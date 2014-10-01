class AccessLog
  self.table_name = :access_log

  def self.getRecent(last=5)
    sub_query = group(:card_id).select{[card_id, count(card_id).as(qty)]}
    query = self
      .joins{[
        sub_query.as('aggs').on{ card_id == aggs.card_id }
      ]}
      .select{['access_log.*', 'aggs.qty']}
      .group(:card_id)
      .order(id: :desc)
    query.limit(last)
  end

  # res = client.query("select
  #   c.card_id,
  # c.user,
  # c.nick,
  # a.entry_count,
  # a.logged
  # from
  # (select
  #   aa.id,
  # aa.logged,
  # aa.card_id,
  # ab.entry_count
  # from
  # access_log
  # aa
  # join
  # (select card_id, count(*) as entry_count from access_log group by card_id)
  # ab
  # on
  # aa.card_id
  # =
  # ab.card_id
  # ORDER BY aa.id DESC LIMIT 0,#{last}) as a join card c ON a.card_id = c.card_id ORDER BY a.id DESC")
  # results = res.entries
  # client.close
  # results
end

