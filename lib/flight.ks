// launch related functions
runOncePath("0:/lib/utils.ks").

// launch ship with MechJeb autopilot
global function autopilot_launch {
  // enable MechJeb autopilot
  toggle_mechjeb_autopilot().
  print "Autopilot engaged".

  // activate launch sequence
  stage.
  print "Launch!".

  // wait till flying to announce liftoff
  wait until ship:status = "FLYING".
  print "Liftoff!".

  // set timewarp to 4x after liftoff
  phy_warp(4).
}

// arm parachute from RealChute
global function arm_chute {
  local chute is ship:partsnamed("RC.stack").

  if chute:empty {
    print "No parachute found".
  } else if chute:length = 1 {
    chute[0]:getModule("RealChuteModule"):doaction("arm parachute", true).
    print "Parachute armed".
  } else {
    print "Found multiple parachutes, not sure what to do".
  }
}

// call at the end of your mission
// arms parachute, waits for landing and set time warp back to 1x
global function land {
  print " ".

  arm_chute().

  print "Waiting for landing...".
  wait until ship:status = "LANDED" OR ship:status = "SPLASHED".
  print "Landed!".
  print " ".

  // print remaining electric charge
  for r in ship:resources {
    if r:name = "ElectricCharge" {
      print "Remaining electric charge: " + round(r:amount) + " / " + round(r:capacity) + " (" + round(r:amount / (r:capacity / 100), 2) + " % )".
      break.
    }
  }

  set kuniverse:timewarp:warp to 0.
}

global function destroy_bellow {
  declare parameter a is 40.

  print "Waiting for altitude of " + a + "km".
  wait until altitude < (a * 1000) and verticalSpeed < 0.

  // has to be executed before destruction to take effect
  // reset time warp to 1x
  phy_warp(1).
  wait 0.

  ship:controlPart:getmodule("ModuleRangeSafety"):doAction("range safety", true).
}
