-- Question 7

select carton_id, min(len*width*height) as carton_vol from carton
where len*width*height > (select sum(product.len* product.width* product.height*order_items.PRODUCT_QUANTITY) as volume
from order_items
left join product
on order_items.product_id = product.product_id
group by order_items.ORDER_ID
having order_items.ORDER_ID = 10006)

-- Question 8

Select online_customer.customer_id, concat (online_customer.customer_fname,' ', online_customer.customer_lname) as customer_name,order_items.order_id,sum(order_items.product_quantity)
as total_product_quantity
from online_customer
left join order_header on online_customer.customer_id = order_header.customer_id
left join order_items on order_header.order_id = order_items.order_id
where order_header.order_status = 'Shipped'
group by order_items.order_id
having sum(order_items.product_quantity) > 10

-- Question 9
select order_items.order_id, online_customer.customer_id, concat (online_customer.customer_fname,' ', online_customer.customer_lname) as customer_name
, sum(order_items.product_quantity) as total_product_quantity from order_items
left join order_header on order_items.order_id = order_header.order_id
left join online_customer on order_header.customer_id = online_customer.customer_id
where order_items.order_id > 10060 and order_header.order_status = 'Shipped'
group by order_items.order_id

-- Question 10

select product.product_class_code , product_class.product_class_desc,
sum(order_items.product_quantity) as total_quantity, 
sum( order_items.product_quantity*product.product_price) as total_value from product
left join product_class on product_class.product_class_code = product.product_class_code
left join order_items on product.product_id = order_items.product_id
left join order_header on order_items.order_id = order_header.order_id
left join online_customer on order_header.customer_id = online_customer.customer_id
left join address on online_customer.address_id = address.address_id
where address.country not in ( 'India', 'USA') and order_header.order_status = 'Shipped'
group by product.product_class_code
order by order_items.product_quantity desc
limit 1

