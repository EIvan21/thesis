view: customer_dt {
  derived_table: {
    sql: SELECT
          customers.custmer_name  AS `customers.custmer_name`,
          COALESCE(SUM(transactions.sales_amount ), 0) AS `transactions.total_sales_amount`
      FROM sales.transactions  AS transactions
      LEFT JOIN sales.customers  AS customers ON transactions.customer_code  = customers.customer_code
      WHERE (transactions.sales_amount>0 AND
                          transactions.currency != "USD\r" AND
                          transactions.currency != "INR" AND
                          (YEAR(transactions.order_date )) >2017)
      GROUP BY
          1
      ORDER BY
          customers.custmer_name
      LIMIT 500
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: customers_custmer_name {
    type: string
    sql: ${TABLE}.`customers.custmer_name` ;;
  }

  dimension: transactions_total_sales_amount {
    type: number
    sql: ${TABLE}.`transactions.total_sales_amount` ;;
  }

  set: detail {
    fields: [customers_custmer_name, transactions_total_sales_amount]
  }
}
