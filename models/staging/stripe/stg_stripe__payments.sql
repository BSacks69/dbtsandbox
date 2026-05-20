SELECT 
id, orderid, paymentmethod, status,amount, created



 FROM {{ source('stripe', 'payments') }}