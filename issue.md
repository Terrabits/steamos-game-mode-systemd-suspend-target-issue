# Systemd services relying on `suspend.target` not processed after `systemctl sleep` in SteamOS Game Mode

#### Your system information

* Steam client version: 1792618285
* SteamOS version: 3.9.5
* Opted into Steam client beta?: No
* Opted into SteamOS beta?: No
* Have you checked for updates in Settings > System?:  Yes; no updates available

#### Please describe your issue in as much detail as possible:

I just wanted to preface my issue by saying that I love SteamOS, Steam and Valve. I really appreciate everything you guys are doing. I apologize if I am missing something (I am new to systemd services and not at all confident using them), or if this is expected (or acceptable) behavior after the most recent update.

tl;dr: Recent updates to SteamOS Game Mode seem to have caused systemd services depending on `suspend.target` to not fire if sleep is initiated by executing `systemctl sleep`.

I've installed two `systemd` system-level services: `after-suspend.service` and `before-suspend.service`. These services are meant to be triggered after and before `suspend.target`, respectively. These services fire as expected in both Game Mode and Desktop Mode when the computer is put to sleep from the UI and then subsequently woken up.

I have a sleep script that executes `systemctl sleep`. When I am in Desktop Mode and I put the computer to sleep with this script, then wake it, both services fire as expected. However, when I do this in Game Mode both services do not fire as expected. I should note that they used to fire as expected in Game Mode until the most recent update (v3.9.5).

#### Steps for reproducing this issue:

1. Put SteamOS into Desktop Mode.
2. Download the included files.
3. Run `install-services.sh` to install the services and their respective scripts.
4. Run the script `sleep.sh` to put the computer to sleep, then wake it.
5. Run `check-status.sh` to check the status of these services. They should've fired as expected.
6. Add `sleep.sh` as a non-steam game.
7. Put SteamOS into Game Mode.
8. Run the script `sleep.sh` to put the computer to sleep, then wake it.
9. Put SteamOS back into Desktop Mode.
10. Run `check-status.sh` to check the status of these services. Based on my experience I would've expected them not to have fired while in Game Mode.
