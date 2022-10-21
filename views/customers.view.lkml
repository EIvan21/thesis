# The name of this view in Looker is "Customers"
view: customers {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: sales.customers ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Custmer Name" in Explore.

  dimension: custmer_name {
    type: string
    sql: ${TABLE}.custmer_name ;;
  }

  dimension: customer_code {
    type: string
    sql: ${TABLE}.customer_code ;;
  }

  dimension: customer_type {
    type: string
    sql: ${TABLE}.customer_type ;;
  }

  measure: count {
    type: count
    drill_fields: [custmer_name]
  }
}
