
/*
 * GET home page.
 */
var dh = require('../utils/db_helpers');

exports.index = function(req, res){
  var ret = [];
  req.db.serialize(function(){
    req.db.each(dh.last_n_days.replace('%s', 5),
      function(err, row){
        if (err){
          console.log(err);
        }
        ret.push(row.session_id);
      },
      function(err, rn){
        res.render('index', {title: ret});
        req.db.close();
      }
    )
  });
};