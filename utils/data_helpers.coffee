
exec_sql = (sql, db, col_name, call_back, args...) ->
  ret = []

  db.serialize(()->
    db.each(sql,
      (err, row) ->
        if err
          console.log(err)
        if col_name
          ret.push(row[col_name])
        else
          ret.push(row)
        return
      ,
      (err, rn) ->
        call_back(ret, args)
        return
      )
  )

get_specific_date = (db, cbk, args...) ->
  # get_specific_date(5)
  # query for last 5 days

  # get_specific_date('2001-12-12', '2001-12-20')
  # query for 2001-12-12 to 2001-12-20
  console.log(args)
  if args.length == 1 and not Array.isArray(args[0])
    console.log "Query for last #{args} day(s)"

    sql = 'select date(c_time) as days from env_list ' +
    'group by date(c_time) ' +
    'order by date(c_time) ' +
    'desc ' +
    "limit #{args[0]}"

    exec_sql(sql, db, null, (data) ->
      cbk(data)
    )

  if args.length == 2
    console.log "Query for data interval"

    sql = 'select distinct date(c_time) as day from env_list ' +
          "where day between '#{args[0]}' and '#{args[1]}'"

    exec_sql(sql, db, null, (data) ->
      cbk(data)
    )

get_session_id_by_data = (db, day, cbk) ->

  sql = 'select session_id from env_list ' +
        "where date(c_time)='%s'"

  get_specific_date(db,
    (data)->
      for d, i in data

        exec_sql(sql.replace('%s', d['days']), db, 'session_id',
          cbk, d['days']
        )
    ,
    day
  )


exports.GP = get_session_id_by_data