/**
 * Created by dracher on 1/21/14.
 */

module.exports = {
  last_n_days: 'select session_id from env_list where date(c_time) in ' +
               '(select date(c_time) from env_list ' +
               'group by date(c_time) ' +
               'order by date(c_time) ' +
               'desc ' +
               'limit %s)'
};