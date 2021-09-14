-- selecting the appropriate database
use classicmodels ;

SELECT 
    *
FROM
    customers;

-- selecting the top 25 customers with the highest credit limits
SELECT 
    customerNumber,
    customerName,
    phone,
    country,
    city,
    ROUND(creditlimit) AS credit_Limit
FROM
    customers
WHERE
    creditlimit != 0
GROUP BY customerNumber
ORDER BY creditLimit DESC
LIMIT 25;

SELECT 
    *
FROM
    employees;

-- finding a client and their associated sales_person via an inner join
SELECT 
    customerNumber AS customerID,
    customerName,
    employeeNumber AS employeeID,
    lastName,
    firstName,
    email,
    JobTitle
FROM
    employees
        JOIN
    customers ON employees.employeeNumber = customers.salesRepEmployeeNumber;
  
SELECT 
    *
FROM
    orders;
  
  -- finding the order status for a customer's order alongside their full contact details through an inner join
SELECT 
    orderNumber AS orderID,
    status,
    orders.customerNumber AS customerID,
    customerName,
    phone,
    country,
    city,
    comments
FROM
    orders
        JOIN
    customers ON customers.customerNumber = orders.customerNumber;
    
SELECT 
    *
FROM
    payments;
    
    -- creating a view to check how many payment records align with each customer using an inner join
CREATE VIEW customer_Purchase_Records AS
    SELECT 
        payments.customerNumber,
        customers.customerName,
        phone,
        country,
        city,
        COUNT(payments.customerNumber) AS payment_records
    FROM
        payments
            JOIN
        customers ON payments.customerNumber = customers.customerNumber
    GROUP BY payments.customerNumber;
    
    -- creating a stored procedure to check the availability of a product using the 'IN' parameter
    delimiter $$
    create procedure productAvailability (in p_productCode text) -- the productCode is a unique identifier of a product therefore is best suited to be used as an input parameter
    begin
    select productCode,productName,quantityInStock,productline,productVendor,productDescription
    from products
    where p_productCode = productCode;
    end $$
    delimiter ;
    
    call productAvailability('s700_3962');

  /* finding the average credit limit in order to use it as a benchmark 
  for determining a customer's risk-assessment.*/
SELECT 
    ROUND(AVG(creditlimit)) AS averageCredit
FROM
    customers
WHERE
    country = 'USA';-- in this case, i will be focusing on clients in the U.S 
    
SELECT 
    *
FROM
    customers;
    
    /* classifying customers in the U.S based on their credit limits 
    by using the average credit limit as a benchmark.The following query
    utilises case statements to assign conditions.*/
    
SELECT 
    customerNumber AS customerID,
    customerName,
    phone,
    state,
    city,
    creditlimit,
    CASE
        WHEN creditlimit >= 78103 THEN 'low-risk borrower'
        ELSE 'high-risk borrower'
    END AS 'risk-assessment'
FROM
    customers
WHERE
    country = 'USA'
ORDER BY creditLimit DESC;
    
    
    
    
  
    
