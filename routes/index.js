
/*
 * GET home page.
 */
var fq = require('../utils/data_helpers');

exports.index = function(req, res){

  var dq = new fq.RhevhQuery(req.db);

  dq.get_specific_date([1,3,4,5]);
  res.render('index')
};