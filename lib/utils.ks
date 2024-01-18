// Utility functions not related to any particular flight phase

// open kOS terminal
global function open_terminal {
  core:part:getmodule("kosProcessor"):doevent("open terminal").
}

// close kOS terminal
global function close_terminal {
  core:part:getmodule("kosProcessor"):doevent("close terminal").
}

// toggle MechJeb ascend autopilot
// TODO: once we also use descend and randevouzs autopilot rename it
global function toggle_mechjeb_autopilot {
  ship:controlPart:GetModule("MechJebCore"):doAction("ascent ap toggle", true).
  wait 0.1.
}

global function phy_warp {
  declare parameter rate is 4.

  set kuniverse:timewarp:mode to "PHYSICS".
  set kuniverse:timewarp:warp to (rate - 1).
}
