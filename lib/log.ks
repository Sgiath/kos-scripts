global function info {
  declare parameter message.

  wait (random() * 0.5) + 0.1.
  print "[INFO] " + message.
}

global function warning {
  declare parameter message.

  wait random().
  print "[WARNING] " + message.
}

global function error {
  declare parameter message.

  wait random().
  print "[ERROR] " + message.
  shutdown.
}
