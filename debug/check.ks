print "Debugging parts properties".

// delete old log files
deletePath("parts.json"). deletePath("modules.json"). deletePath("fields.json"). deletePath("actions.json"). deletePath("events.json").

writeJson(ship:parts, "parts.json").

writeJson(ship:partsNamed("proceduralAvionics")[0]:modules, "modules.json").

writeJson(ship:partsNamed("proceduralAvionics")[0]:getModule("ModuleRangeSafety"):allFieldNames, "fields.json").
writeJson(ship:partsNamed("proceduralAvionics")[0]:getModule("ModuleRangeSafety"):allActionNames, "actions.json").
writeJson(ship:partsNamed("proceduralAvionics")[0]:getModule("ModuleRangeSafety"):allEventNames, "events.json").
