gp = require('../utils/data_helpers').GP


exports.main_page = (req, res) ->
  days = parseInt(req.params[0])
  results = []
  gp(req.db, days ,
    (data, args) ->
      results.push([args[0], data])
      if results.length == days
        console.log results
        res.render('index', {'res': results})
  )
  return