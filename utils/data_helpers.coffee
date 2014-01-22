class BasicQuery
  constructor: (@conn) ->

  exec_sql = (sql, con, call_back) ->
    ret = []

    con.serialize(()->
      con.each(sql,
        (err, row) ->
          if err
            console.log(err)
          ret.push(row)
          return
        ,
        (err, rn) ->
          call_back(ret)
          return
      )
    )


class RhevhQuery extends BasicQuery
  get_last_n_day: (n) ->
    sql = 'select session_id from env_list where date(c_time) in ' +
    '(select date(c_time) from env_list ' +
    'group by date(c_time) ' +
    'order by date(c_time) ' +
    'desc ' +
    "limit #{n})"
    exec_sql(sql, @conn, (data)->
      console.log(data)
    )
    return

  get_specific_date: (args...) ->
    # get_specific_date(5)
    # query for last 5 days

    # get_specific_date(['2001-12-12', '2002-10-2', '2300-12-14'])
    # query for these 3 days

    # get_specific_date('2001-12-12', '2001-12-20')
    # query for 2001-12-12 to 2001-12-20

    if args.length == 1 and not Array.isArray(args[0])
      console.log "Query for last #{args} day(s)"
    if args.length == 1 and Array.isArray(args[0])
      console.log "Query for sepcific dates: #{args}"
    if args.length == 2
      console.log "Query for data interval"

exports.RhevhQuery = RhevhQuery