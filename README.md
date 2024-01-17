# My kOS scripts for KSP 1

My scripts for [Kerbal Space Program](https://www.kerbalspaceprogram.com/)

Using it in [Realistic Progression One](https://github.com/KSP-RO/RP-1) career

See [kOS documentation](https://ksp-kos.github.io/KOS_DOC/)

## Boot files

There is currently only `basic.ks` which so far covers my needs. It does following:

1. opens terminal
2. switches to archive disk
3. sets TimeWarp mode to physics mode
4. start every experiment that is on the ship
5. checks if there is exactly one Launch Clamp
6. checks there is at least one engine is stage before clamp release
7. computes Thrust-to-Weight ration for the first stage and checks it is not bellow 1.2

## Launch scripts

I am using MechJeb for navigation so my launch scripts are doing things in parallel with MechJeb.
Actually my main `auto.ks` launch script is just enabling MechJeb autopilot, triggering initial
stage and setting up time warp.
