// pre-flight associated functions

// find any modules named "Experiment" and does "start" action on them
global function start_experiments {
  FOR Module in Ship:ModulesNamed("Experiment") {
    FOR Action in Module:AllActionNames {
      if Action:contains("start") {
        Module:doAction(Action, true).
      }
    }
  }
}

// calculates Thrust-to-Weight ratio of the ship
global function compute_twr {
  // get Launch Clamps and do some sanity checks
  // TODO: this might not be good pattern but works for now
  local clamps is Ship:partsNamedPattern("^ROE-.*LC$").
  if clamps:empty { print "No launch clamps found". shutdown. }
  if clamps:length > 1 { print "Multiple launch clamps found". shutdown. }

  // ship mass without clamps
  set ship_mass to ship:mass - clamps[0]:mass.

  // list of engine ignited before clamps are released
  local engines is list().
  for eng in ship:Engines {
    if eng:stage = (clamps[0]:stage + 1) { engines:add(eng). }
  }

  // sanity check the engine
  if engines:empty { print "No engines found after clamp release. Check staging!". shutdown. }

  // calculate collective thrust of all 1st stage engines
  set thrust to 0.
  for en in engines {
    set thrust to thrust + en:PossibleThrust.
  }

  // calculate current g for the ship
  set current_g to body:mu / ((body:radius + ship:altitude)^2).

  // calculate Thrust-to-Weight ratio
  return thrust / (ship_mass * current_g).
}
