// Generated by CoffeeScript 1.6.3
var BasicQuery, RhevhQuery, _ref,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  __slice = [].slice;

BasicQuery = (function() {
  var exec_sql;

  function BasicQuery(conn) {
    this.conn = conn;
  }

  exec_sql = function(sql, con, call_back) {
    var ret;
    ret = [];
    return con.serialize(function() {
      return con.each(sql, function(err, row) {
        if (err) {
          console.log(err);
        }
        ret.push(row);
      }, function(err, rn) {
        call_back(ret);
      });
    });
  };

  return BasicQuery;

})();

RhevhQuery = (function(_super) {
  __extends(RhevhQuery, _super);

  function RhevhQuery() {
    _ref = RhevhQuery.__super__.constructor.apply(this, arguments);
    return _ref;
  }

  RhevhQuery.prototype.get_last_n_day = function(n) {
    var sql;
    sql = 'select session_id from env_list where date(c_time) in ' + '(select date(c_time) from env_list ' + 'group by date(c_time) ' + 'order by date(c_time) ' + 'desc ' + ("limit " + n + ")");
    exec_sql(sql, this.conn, function(data) {
      return console.log(data);
    });
  };

  RhevhQuery.prototype.get_specific_date = function() {
    var args;
    args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    if (args.length === 1 && !Array.isArray(args[0])) {
      console.log("Query for last " + args + " day(s)");
    }
    if (args.length === 1 && Array.isArray(args[0])) {
      console.log("Query for sepcific dates: " + args);
    }
    if (args.length === 2) {
      return console.log("Query for data interval");
    }
  };

  return RhevhQuery;

})(BasicQuery);

exports.RhevhQuery = RhevhQuery;
