# ECommerce_Asp.NetMVC
This project aims to create a simple web page application using ASP.NET and MVC technology and supported by SQL in the background. While doing this project, primarily C#, HTML, CSS, and SQL languages were also used. The system consists of 3 main roles: the owner of the company as the admin, the salesman as the seller, and the customer. Company owners have access to both salesmen and customers _such as adding or deleting a salesman or customer or just updating their information. Salespeople deal with customers only. The company sells different products such as engine oil, antifreeze, and dental lubricants. Any owner or salesman can update, add or delete a product. Any order must consist of at least 1 container _approximately 15 tons_ and at least 50 units of one product.

# PLAN OF THE PROJECT PROCESS
- Declaring business rules is required.
- Designing the database schema using an entity relationship diagram with Crow’s Foot notation.
- Creating the database using SQL.
- Data entry for each needed table in the database.
- Starting a new ASP .NET MVC project and connecting the database to it.
- Creating Controller for needed entities then creating the view pages needed for them.
- Testing the project.

# Business Rules
- It is aimed to design a website for the sale of a lubricant company's products.
- The company owners have access to sales employees.
- Information of company owners and sales employees consists of name, surname, Id, password, e-mail, address, phone number, and T.C. number.
- Each customer has a salesman take care of him/her.
- Each customer’s information should include an Id and password, customer’s name, surname, e-mail, phone number, country and city where he lives, and the name and position of the company he works for.
- The names of countries and cities are stored.
- The code, brand, name, packaging (1, 4, 5, 20, 200 liters), price, and stock quantities of the products must be stored.
- There are categories of products. The code and name of each category are stored. (Engine oil, antifreeze, etc.)
- It should be ensured that an invoice is issued for each order containing product orders of the customers. Invoice number, date, billing address information, and total price of the invoices should be stored.
- Each order has a unique order number and order date.
- Orders are delivered by a cargo company (road, seaway). It contains the code, name, and address of the cargo company. Each cargo company has a responsible person for orders.
- Each customer has just one salesman. A salesman can deal with more than one customer.
- A customer can only live in one country and city. More than one customer may live in the same country and city.

- Every product can be contained in only one category. A category can have more than one product.
- An order contains at least one product. However, many products can also be found. A product can take place in more than one order.
- A customer can give more than one order. An order can only be placed by one customer.
- An order can have only one invoice. An invoice can only be an invoice for one order.
- An order is delivered by only one shipping company. A shipping company can forward more than one order.

# Database Design (Crow’s Foot)
![image](https://user-images.githubusercontent.com/40718869/188876440-fdfed37e-374a-4da2-9599-39745898185e.png)
