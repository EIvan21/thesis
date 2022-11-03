# The name of this view in Looker is "Markets"
include: "/views/*"
view: markets {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: sales.markets ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Markets Code" in Explore.

  dimension: market_code {
    type: string
    sql: ${TABLE}.markets_code ;;
    primary_key: yes
  }

  dimension: markets_name {
    type: string
    sql: ${TABLE}.markets_name ;;
  }


  dimension: zone {
    type: string
    sql: ${TABLE}.zone ;;
  }

  dimension: name_map {
    map_layer_name: uk_postcode_areas
    sql: ${TABLE}.markets_name ;;
  }

  measure: count {
    type: count
    drill_fields: [markets_name]
  }

  measure: comparasion {
    type: number
    sql: ${TABLE}.{% parameter market_name %} / ${count};;
    }

  #Parameters
  parameter: market_name {
    type: string
    allowed_value: {
      value: "Delhi NCR"
    }
    allowed_value: {
      value: "Mumbai"
    }
    allowed_value: {
      value: "Ahmedabad"
    }
    allowed_value: {
      value: "Bhopal"
    }
  }
  # Parameters
  parameter: dim_to_show_parameter_Code_Name {
    type: string
    allowed_value: {
      value: "Code"
    }
    allowed_value: {
      value: "Name"
    }
  }

  dimension: dim_to_show {
    label_from_parameter: dim_to_show_parameter_Code_Name
    sql:
    {% if ${dim_to_show_parameter_Code_Name}._parameter_value == "'Code'" %}
      ${market_code}
    {% elsif ${dim_to_show_parameter_Code_Name}._parameter_value == "'Name'" %}
      ${markets_name}
    {% else %}
      NULL
    {% endif %} ;;
  }
}
