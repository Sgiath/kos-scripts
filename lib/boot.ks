// general boot file for any ship

runOncePath("0:/lib/log.ks").
runOncePath("0:/lib/utils.ks").
runOncePath("0:/lib/preflight.ks").

function print_header {
  clearScreen.

  print "==================================================".
  print "             SpaceCommand Bootloader".
  print "==================================================".
  print "     ".
  print "Ship:         " + ship:name.
  print "Manufacturer: StarDrive Systems".
  print "OS:           SpaceCommand".
  print "     ".
}

global function basic {
  open_terminal().

  print_header().

  print "Starting boot sequence".
  print "     ".
  info("Power systems online").
  info("Navigation systems calibrated").
  info("Engines primed for ignition").
  info("Sensor arrays activated").
  info("Communication systems functional").

  // switch to archive
  switch to 0.
  cd("0:/missions").

  // switch TimeWarp to Physics mode
  set kuniverse:timewarp:mode to "PHYSICS".

  // check clamps sanity
  local clamp to check_clamps().

  // check engines sanity
  local engines to check_engines(clamp).

  // check Thrust-to-Weight ratio
  check_twr(clamp, engines).

  // start all available experiments
  start_experiments().

  wait 3.
  print_header().
  print "  -> Ready to launch".
  print "     ".
}
