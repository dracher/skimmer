gp = require('../utils/data_helpers').GP


exports.main_page = (req, res) ->
  results = []
  gp(req.db, 1 ,
    (data, args) ->

      results.push([args[0], data])
      if results.length == 1
        console.log results
        res.render('index', {'res': results})
  )
  return