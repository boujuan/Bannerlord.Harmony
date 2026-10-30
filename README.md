# Harmony Updated (fork of BUTR/Bannerlord.Harmony)

<p align="center">
  <a href="https://steamcommunity.com/sharedfiles/filedetails/?id=3740878109">
    <img alt="Steam Subscriptions" src="https://img.shields.io/steam/subscriptions/3740878109?label=Steam%20Subscriptions&color=blue">
  </a>
  <a href="https://www.nexusmods.com/mountandblade2bannerlord/mods/11597">
    <img alt="NexusMods Version" src="https://img.shields.io/endpoint?url=https%3A%2F%2Fnmstats.butr.link%2Fmod-version%3FgameId%3D3174%26modId%3D11597">
  </a>
  <a href="https://www.nuget.org/packages/Lib.Harmony">
    <img alt="NuGet Lib.Harmony" src="https://img.shields.io/nuget/v/Lib.Harmony.svg?label=NuGet%20Lib.Harmony&colorB=blue" />
  </a>
</p>

Community-maintained rebuild of [BUTR's Harmony module](https://github.com/BUTR/Bannerlord.Harmony), published as **Harmony Updated** on the
[Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3740878109) and [Nexus Mods](https://www.nexusmods.com/mountandblade2bannerlord/mods/11597).
It keeps the module id `Bannerlord.Harmony`, so every mod that depends on Harmony works with it unchanged. Install either this or the original, not both.

What this fork changes on top of BUTR's `dev`:
* Harmony **2.4.3** (`Lib.Harmony.Thin`, MonoMod.Core 1.3.6) and Bannerlord.ModuleManager 6.0.249.
* Built against Bannerlord **v1.5.6 beta** (`Bannerlord.ReferenceAssemblies.Core` 1.5.6.125053-beta) and API-checked against v1.4.8 stable, so one release serves both.
* `Url`/`UpdateInfo` in `SubModule.xml` point to this fork's Nexus page.
* Linux builds work out of the box (fixed default game path) and `build/package.sh` produces the release files.

### Branches
* `dev` mirrors [BUTR's `dev`](https://github.com/BUTR/Bannerlord.Harmony/tree/dev). Sync it with GitHub's *Sync fork* button or `git fetch upstream && git push origin upstream/dev:dev`.
* `gameversion-<version>` branches carry this fork's changes rebased on `dev`.

### Building (Windows or Linux)
Needs the .NET SDK 8 or newer. On Linux the `net472` target builds through `Microsoft.NETFramework.ReferenceAssemblies`, no Mono or Windows needed.
```sh
dotnet build src/Bannerlord.Harmony/Bannerlord.Harmony.csproj -c Stable_Release
```
The module is copied into the game's `Modules` folder (Steam's default location, or `$BANNERLORD_GAME_DIR`).
To target a new game version, change `GameVersion` in `build/common.props`; beta versions such as `1.5.6` resolve to their `-beta` reference package.

### Releasing
```sh
build/package.sh <build-id>   # e.g. 249 -> v2.4.3.249
```
Builds into `artifacts/`: upload `Bannerlord.Harmony-v<version>.zip` to Nexus Mods, and push the Workshop item with the
`steamcmd +login <steam-user> +workshop_build_item <abs-path>/workshop_item.vdf +quit` command the script prints.

---

## Original README (BUTR)

<p align="center">
  <a href="https://github.com/BUTR/Bannerlord.Harmony/actions/workflows/publish.yml?query=branch%3Amaster+event%3Apush">
    <img alt="GitHub Workflow Status (event)" src="https://img.shields.io/github/actions/workflow/status/BUTR/Bannerlord.Harmony/publish.yml?branch=master&event=push&label=Latest%20Commit">
  </a>
  <a href="https://translate.butr.link/engage/bannerlord-harmony/">
    <img src="https://translate.butr.link/widget/bannerlord-harmony/github/svg-badge.svg" alt="Translation status">
  </a>
  </br>
  <a href="https://www.nuget.org/packages/Lib.Harmony" alt="NuGet Harmony">
    <img src="https://img.shields.io/nuget/v/Lib.Harmony.svg?label=NuGet%20Lib.Harmony&colorB=blue" />
  </a>
  </br>
  <a href="https://www.nexusmods.com/mountandblade2bannerlord/mods/2006" alt="NexusMods Harmony">
    <img src="https://img.shields.io/badge/NexusMods-Harmony-yellow.svg" />
  </a>
  <a href="https://www.nexusmods.com/mountandblade2bannerlord/mods/2006" alt="NexusMods Harmony">
    <img src="https://img.shields.io/endpoint?url=https%3A%2F%2Fnmstats.butr.link%2Fmod-version%3FgameId%3D3174%26modId%3D2006" />
  </a>
  <a href="https://www.nexusmods.com/mountandblade2bannerlord/mods/2006" alt="NexusMods Harmony">
    <img src="https://img.shields.io/endpoint?url=https%3A%2F%2Fnmstats.butr.link%2Fdownloads%3Ftype%3Dunique%26gameId%3D3174%26modId%3D2006" />
  </a>
  <a href="https://www.nexusmods.com/mountandblade2bannerlord/mods/2006" alt="NexusMods Harmony">
    <img src="https://img.shields.io/endpoint?url=https%3A%2F%2Fnmstats.butr.link%2Fdownloads%3Ftype%3Dtotal%26gameId%3D3174%26modId%3D2006" />
  </a>
  <a href="https://www.nexusmods.com/mountandblade2bannerlord/mods/2006" alt="NexusMods Harmony">
    <img src="https://img.shields.io/endpoint?url=https%3A%2F%2Fnmstats.butr.link%2Fdownloads%3Ftype%3Dviews%26gameId%3D3174%26modId%3D2006" />
  </a>
  </br>
  <a href="https://steamcommunity.com/sharedfiles/filedetails/?id=2859188632">
    <img alt="Steam Mod Configuration Menu" src="https://img.shields.io/badge/Steam-Harmony-blue.svg" />
  </a>
  <a href="https://steamcommunity.com/sharedfiles/filedetails/?id=2859188632">
    <img alt="Steam Downloads" src="https://img.shields.io/steam/downloads/2859188632?label=Downloads&color=blue">
  </a>
  <a href="https://steamcommunity.com/sharedfiles/filedetails/?id=2859188632">
    <img alt="Steam Views" src="https://img.shields.io/steam/views/2859188632?label=Views&color=blue">
  </a>
  <a href="https://steamcommunity.com/sharedfiles/filedetails/?id=2859188632">
    <img alt="Steam Subscriptions" src="https://img.shields.io/steam/subscriptions/2859188632?label=Subscriptions&color=blue">
  </a>
  <a href="https://steamcommunity.com/sharedfiles/filedetails/?id=2859188632">
    <img alt="Steam Favorites" src="https://img.shields.io/steam/favorites/2859188632?label=Favorites&color=blue">
  </a>
  </br>
  <img src="https://staticdelivery.nexusmods.com/mods/3174/images/2006/2006-1615240039-1903390080.png" width="800">
</p>
 
This is an unofficial distribution of the [Lib.Harmony](https://github.com/pardeike/Harmony) library maintained by the community to have an easier way to manage external library dependencies.  
  
## Installation
This module should be the highest in loading order. Any other module that requires to be set at the top (Better Exception Window, DoubleDrawDistance, MCM, etc.) should be loaded after this mod.
  
## For Players
This mod is intended to ensure that all mods in a player's modlist are using the latest version of Harmony to minimize conflicts.  
  
## For Modders
**We added a Debug UI! Available via CTRL+ALT+H.**

You still need to reference Harmony as a NuGet package, it is not required to include ``0Harmony.dll`` in the final /bin output of your module.  
You do need to add this to your ``SubModule.xml``  
```xml
<DependedModules>
    <DependedModule Id="Bannerlord.Harmony" DependentVersion="v2.10.1" />
</DependedModules>
```
This way the game will ensure that the Harmony library is loaded before your mod.  
  
## Versioning  
The Module combines the Harmony version used and the Build Id that published the Module. The Build Id is simply added to the end.  
``2.0.2.22`` indicates that Harmony ``2.0.2.0`` is used and ``22`` is the Build Id.  
``2.0.0.1025`` indicates that Harmony ``2.0.0.10`` is used and ``25`` is the Build Id.  
  
We considered using the Rimworld approach with introducing our own version system, but it won't give a clear way to detect which Harmony version the Module contains. It's easier for the user to report the version of the Module used than to check the assembly version/send it. 
  
