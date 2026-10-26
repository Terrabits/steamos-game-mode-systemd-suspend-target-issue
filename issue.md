# Systemd services relying on `suspend.target` not processed after `systemctl sleep` in SteamOS Game Mode

#### Your system information

- Steam client version: 1792618285
- SteamOS version: 3.9.5
- Opted into Steam client beta?: No
- Opted into SteamOS beta?: No
- Have you checked for updates in Settings > System?: Yes; no updates available

#### Please describe your issue in as much detail as possible:

I just wanted to preface my issue by saying that I love SteamOS, Steam, and Valve. I really appreciate everything you guys are doing. I apologize if I am missing something or if this is expected behavior.

**tl;dr:** A regression in recent updates to SteamOS Game Mode (v3.9.5) causes systemd services depending on `suspend.target` to fail to fire when sleep is initiated via the command line (`systemctl sleep`).

I've installed two `systemd` system-level services: `after-suspend.service` and `before-suspend.service`, designed to trigger after and before `suspend.target` respectively. These services fire as expected in both Game Mode and Desktop Mode when the system is put to sleep through the standard UI.

When executing a script that calls `systemctl sleep` in Desktop Mode, both services fire correctly upon waking. However, a regression in v3.9.5 causes these services to completely fail to fire when the exact same `systemctl sleep` command is executed while in Game Mode.

#### Steps for reproducing this issue:

1. Put SteamOS into Desktop Mode.
2. Download the included files.
3. Run `install-services.sh` to install the services and their respective scripts.
4. Run the script `sleep.sh` (which executes `systemctl sleep`) to put the computer to sleep, then wake it.
5. Run `check-status.sh` to check the status of these services; notice they fired as expected.
6. Add `sleep.sh` as a non-Steam game.
7. Put SteamOS into Game Mode.
8. Run the script `sleep.sh` (which executes `systemctl sleep`) to put the computer to sleep, then wake it.
9. Put SteamOS back into Desktop Mode.
10. Run `check-status.sh` to check the status of these services, showing that they failed to trigger while in Game Mode.
