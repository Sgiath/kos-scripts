// general boot file for any ship

runOncePath("0:/lib/utils.ks").
runOncePath("0:/lib/preflight.ks").

global function basic {
  open_terminal().
  clearScreen.

  // switch to archive
  switch to 0.
  cd("0:/missions").

  // switch TimeWarp to Physics mode
  set kuniverse:timewarp:mode to "PHYSICS".

  // start all available experiments
  start_experiments().

  // check Thrust-to-Weight ratio
  local twr to compute_twr().

  if twr <= 1.0 {
    print "Thrust-to-Weight ratio is too low to start: " + round(twr, 2).
    shutdown.
  } else if twr <= 1.2 {
    print "Thrust-to-Weight ration is quite low. Check your design!".
  }

  print "All systems nominal".
  print "Ready to launch".
  print " ".
}
