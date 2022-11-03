# The name of this view in Looker is "Transactions"
view: transactions {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: sales.transactions ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Currency" in Explore.

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension: customer_code {
    type: string
    sql: ${TABLE}.customer_code ;;
  }

  dimension: market_code {
    type: string
    sql: ${TABLE}.market_code ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: order {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year,
      month_name,

    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.order_date ;;

  }

  dimension: product_code {
    type: string
    sql: ${TABLE}.product_code ;;
  }

  dimension: sales_amount {
    type: number
    sql: ${TABLE}.sales_amount ;;
  }

  dimension: sales_qty {
    type: number
    sql: ${TABLE}.sales_qty ;;
  }


  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_sales_amount {
    label: "Total sales by label"
    type: sum
    sql: ${sales_amount} ;;
    value_format_name: usd_0
    drill_fields: [total_sales_qty,total_sales_amount]
    html:
    <a href="#drillmenu" target="_self">
    {% if value > 5000000 %}
    <span style="color:#42a338;">{{ rendered_value }}</span>
    {% elsif value > 50000000 %}
    <span style="color:#ffb92e;">{{ rendered_value }}</span>
    {% else %}
    <span style="color:#fa4444;">{{ rendered_value }}</span>
    {% endif %}
    </a>;;
  }

  measure: average_sales_amount {
    type: average
    sql: ${sales_amount} ;;
    value_format_name: usd_0
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: total_sales_qty {
    type: sum
    sql: ${sales_qty} ;;
    value_format_name: decimal_0
  }



}
