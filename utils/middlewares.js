/**
 * Created by dracher on 1/21/14.
 */

exports.db = function(req, res, next){
  var sqlite3 = require('sqlite3').verbose();
  req.db = new sqlite3.Database('results.sqlite');
  return next();
};