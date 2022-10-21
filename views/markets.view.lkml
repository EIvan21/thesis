# The name of this view in Looker is "Markets"
view: markets {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: sales.markets ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Markets Code" in Explore.

  dimension: markets_code {
    type: string
    sql: ${TABLE}.markets_code ;;
  }

  dimension: markets_name {
    type: string
    sql: ${TABLE}.markets_name ;;
  }

  dimension: zone {
    type: string
    sql: ${TABLE}.zone ;;
  }

  measure: count {
    type: count
    drill_fields: [markets_name]
  }
}
