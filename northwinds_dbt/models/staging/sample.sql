{% for i in range(3) %}
    SELECT {{ i }} as number
    {% if not loop.last %} union all {% endif %}
{% endfor %}


