// pre-flight associated functions
// in case of checks if there is an obvious error the processor will shut down
// in case of warning script will print it but continue

runOncePath("0:/lib/log.ks").

// find any modules named "Experiment" and does "start" action on them
global function start_experiments {
  FOR Module in Ship:ModulesNamed("Experiment") {
    FOR Action in Module:AllActionNames {
      if Action:contains("start") {
        Module:doAction(Action, true).
      }
    }
  }

  info("Experiments armed").
}

global function check_clamps {
  // get Launch Clamps and do some sanity checks
  // TODO: this might not be good pattern but works for now
  local clamps is Ship:partsNamedPattern("^ROE-.*LC$").

  if clamps:empty { error("No launch clamps found"). }
  else if clamps:length > 1 { error("Multiple launch clamps found"). }
  else { return clamps[0]. }
}

global function check_engines {
  declare parameter clamp.

  // list of engine ignited before clamps are released
  local engines is list().
  for eng in ship:Engines {
    if eng:stage = clamp:stage or eng:stage = (clamp:stage + 1) { engines:add(eng). }
  }

  // sanity check the engine
  if engines:empty {
    error("No engines found after clamp release. Check staging!").
  } else {
    return engines.
  }
}

// calculates Thrust-to-Weight ratio of the ship
global function check_twr {
  declare parameter clamp.
  declare parameter engines.

  // ship mass without clamps
  set ship_mass to ship:mass - clamp:mass.

  // calculate collective thrust of all engines
  set thrust to 0.
  for en in engines {
    set thrust to thrust + en:PossibleThrust.
  }

  // calculate current g for the ship
  set current_g to body:mu / ((body:radius + ship:altitude)^2).

  // calculate Thrust-to-Weight ratio
  local twr to thrust / (ship_mass * current_g).

  if twr <= 1.0 {
    error("Thrust-to-Weight ratio is too low to start: " + round(twr, 2)).
  } else if twr <= 1.2 {
    warning("Thrust-to-Weight ration is quite low. Check your design!").
  } else {
    return.
  }
}
