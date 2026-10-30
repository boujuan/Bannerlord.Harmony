#!/usr/bin/env bash
# Builds Bannerlord.Harmony and packages it for Nexus Mods and the Steam Workshop (Linux or Git Bash).
#
# Usage: build/package.sh <build-id> [out-dir]
#   build-id  last segment of the module version: Harmony 2.4.3.0 + 249 -> v2.4.3.249
#   out-dir   where the stage folder, zip and Workshop .vdf go (default: <repo>/artifacts)
#
# Produces:
#   <out-dir>/stage/Modules/Bannerlord.Harmony/   the module, ready to copy into the game's Modules folder
#   <out-dir>/Bannerlord.Harmony-v<version>.zip    Nexus Mods upload (contains Modules/Bannerlord.Harmony)
#   <out-dir>/workshop_item.vdf                    steamcmd +workshop_build_item input
set -euo pipefail

NEXUS_MOD_ID=11597
WORKSHOP_ID=3740878109

if [[ $# -lt 1 || ! $1 =~ ^[0-9]+$ ]]; then
  sed -n '2,13p' "$0"
  exit 1
fi

root="$(cd "$(dirname "$0")/.." && pwd)"
build_id=$1
out="$(mkdir -p "${2:-$root/artifacts}" && cd "${2:-$root/artifacts}" && pwd)"
stage="$out/stage"
module="$stage/Modules/Bannerlord.Harmony"

if [[ -n "$(git -C "$root" status --porcelain)" ]]; then
  echo "warning: working tree has uncommitted changes, the package will not match a commit" >&2
fi

# Bannerlord.BuildResources only copies the module into GameFolder when that folder already exists
rm -rf "$stage"
mkdir -p "$stage"
dotnet build "$root/src/Bannerlord.Harmony/Bannerlord.Harmony.csproj" \
  --configuration Stable_Release \
  -p:GameFolder="$stage" \
  -p:GITHUB_RUN_NUMBER="$build_id"

version="$(grep -oP '<Version value="v\K[^"]+' "$module/SubModule.xml")"
game_version="$(grep -oP 'id="Native"[^>]*version="v\K[0-9]+(\.[0-9]+)*' "$module/SubModule.xml")"

zip="$out/Bannerlord.Harmony-v$version.zip"
rm -f "$zip"
if command -v 7z >/dev/null; then
  (cd "$stage" && 7z a -tzip -mx9 "$zip" Modules >/dev/null)
else
  (cd "$stage" && bsdtar -a -cf "$zip" Modules)
fi

cat > "$out/workshop_item.vdf" <<EOF
"workshopitem"
{
  "appid" "261550"
  "publishedfileid" "$WORKSHOP_ID"
  "contentfolder" "$module"
  "changenote" "v$version: Harmony ${version%.*}, built against Bannerlord v$game_version"
}
EOF

cat <<EOF

Packaged v$version (game v$game_version)
  module:   $module
  nexus:    $zip
            -> upload at https://www.nexusmods.com/mountandblade2bannerlord/mods/$NEXUS_MOD_ID?tab=files
  workshop: $out/workshop_item.vdf
            -> steamcmd +login <steam-user> +workshop_build_item "$out/workshop_item.vdf" +quit
EOF
