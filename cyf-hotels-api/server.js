const express = require("express");
const app = express();
const { Pool } = require('pg');
const secret = require('./secrets.json');
const bodyParser = require("body-parser");
app.use(bodyParser.json());

const pool = new Pool(secret);

app.get("/hello", function(req, res) {
    res.send("Hello world")
});

/*app.get("/hotels", function (req, res) {
    pool
      .query("SELECT * FROM hotels ORDER BY name")
      .then((result) => res.json(result.rows))
      .catch((e) => console.error(e));
  });

app.get("/hotels", function(req, res) {
    pool.query('SELECT * FROM hotels', (error, result) => {
        console.log(error);
        res.json(result.rows);
    });
});

app.get("/hotels", function (req, res) {
    pool
      .query("SELECT * FROM hotels")
      .then((result) => res.json(result.rows))
      .catch((e) => console.error(e));
  });*/

app.get("/hotels", function (req, res) {
    const hotelNameQuery = req.query.name;
         let query = `SELECT * FROM hotels ORDER BY name`;

           if (hotelNameQuery) {
             query = `SELECT * FROM hotels WHERE name LIKE '%${hotelNameQuery}%' ORDER BY name`;
           } 
               
           pool
             .query(query)
             .then((result) => 
               hotelNameQuery ? res.json(result.rows[0]) :  res.json(result.rows)
               )
             .catch((e) => console.error(e));
});

app.get("/hotels/:hotelId", function (req, res) {
   const hotelId = req.params.hotelId;
 
   pool
     .query("SELECT * FROM hotels WHERE id=$1", [hotelId])
     .then((result) => res.json(result.rows))
     .catch((e) => console.error(e));
 });


app.get("/customers", function (req, res) {
    pool
      .query("SELECT * FROM customers ORDER BY name")
      .then((result) => res.json(result.rows))
      .catch((e) => console.error(e));
  });

app.get("/customers/:customerId", function (req, res) {
    const customerId = req.params.customerId;
  
    pool
      .query("SELECT * FROM customers WHERE id=$1", [customerId])
      .then((result) => res.json(result.rows))
      .catch((e) => console.error(e));
  });

  app.get("/customers/:customerId/bookings", function (req, res) {
    const customerId = req.params.customerId;
    let query = `SELECT b.checkin_date, b.nights, h."name", h.postcode FROM bookings b inner join customers c on c.id = b.customer_id  inner join hotels h on h.id = b.hotel_id where customer_id ='${customerId}'`;         
           pool
             .query(query)
             .then((result) => res.json(result.rows))
             .catch((e) => console.error(e));
});


app.post("/hotels", function (req, res) {
    const newHotelName = req.body.name;
    const newHotelRooms = req.body.rooms;
    const newHotelPostcode = req.body.postcode;
  
    if (!Number.isInteger(newHotelRooms) || newHotelRooms <= 0) {
        return res
          .status(400)
          .send("The number of rooms should be a positive integer.");
      }
    
      pool
        .query("SELECT * FROM hotels WHERE name=$1", [newHotelName])
        .then((result) => {
          if (result.rows.length > 0) {
            return res
              .status(400)
              .send("An hotel with the same name already exists!");
          } else {
            const query =
              "INSERT INTO hotels (name, rooms, postcode) VALUES ($1, $2, $3) returning id as hotelId";
            pool
              .query(query, [newHotelName, newHotelRooms, newHotelPostcode])
              .then((result2) => res.json(result2.rows[0]))
              .catch((e) => console.error(e));
          }
        });
    });

    app.post("/customers", function (req, res) {
        const newCustomerName = req.body.name;
        const newEmail = req.body.email;
        const newAddress = req.body.address;
        const newCity = req.body.city; 
        const newPostCode = req.body.postcode; 
        const newCountry = req.body.country;
        
          pool
            .query("SELECT * FROM customers WHERE name=$1", [newCustomerName])
            .then((result) => {
              if (result.rows.length > 0) {
                return res
                  .status(400)
                  .send("A customer with the same name already exists!");
              } else {
                const query =
                  "INSERT INTO customers (name, email, address, city, postcode, country) VALUES ($1, $2, $3, $4, $5, $6)";
                pool
                  .query(query, [newCustomerName,  newEmail, newAddress, newCity, newPostCode, newCountry])
                  .then(() => res.send("Customer created!"))
                  .catch((e) => console.error(e));
              }
            });
        });

///pending to add the possibility to modify address, the city, the postcode and the country
app.patch("/customers/:customerId", function (req, res) {
  const customerId = req.params.customerId;
  const newEmail = req.body.email;
  const newAddress = req.body.address;
  const newCity = req.body.city; 
  const newPostCode = req.body.postcode; 
  const newCountry = req.body.country;


  if (!newEmail) {
    return res
      .status(400)
      .send("You should have an email as an input.");
  }

  pool
    .query("UPDATE customers c SET email=$1 WHERE c.id=$2 returning c.id, c.email", [newEmail, customerId])
    /*.then(() => res.send(`Customer ${customerId} updated!`))*/
    .then((result) => res.json(result.rows[0]))
    .catch((e) => console.error(e));
});        


app.put("/customers/:customerId", function (req, res) {
    const customerId = req.params.customerId;
    const newName = req.body.name;
    const newEmail = req.body.email;
    const newAddress = req.body.address;
    const newCity = req.body.city; 
    const newPostCode = req.body.postcode; 
    const newCountry = req.body.country;

    pool
        .query("UPDATE customers c SET c.name=$1, email=$2, address=$3, city=$4, postcode=$5, country=$6 WHERE c.id=$7", [newName, newEmail, newAddress, newCity, newPostCode, newCountry, customerId])
        .then(() => res.send(`Customer ${customerId} updated!`))
        .catch((e) => console.error(e));
});


app.delete("/customers/:customerId", function (req, res) {
  const customerId = req.params.customerId;

  pool
    .query("DELETE FROM bookings WHERE customer_id=$1", [customerId])
    .then(() => {
      pool
        .query("DELETE FROM customers WHERE id=$1", [customerId])
        .then(() => res.send(`Customer ${customerId} deleted!`))
        .catch((e) => console.error(e));
    })
    .catch((e) => console.error(e));
});


app.delete("/hotels/:hotelId", function (req, res) {
  const hotelId = req.params.hotelId;

  pool
    .query("DELETE FROM bookings WHERE hotel_id=$1", [hotelId])
    .then(() => {
      pool
        .query("DELETE FROM hotels WHERE id=$1", [hotelId])
        .then(() => res.send(`Hotel ${hotelId} deleted!`))
        .catch((e) => console.error(e));
    })
    .catch((e) => console.error(e));
});

app.listen(3000, function() {
    console.log("Server is listening on port 3000. Ready to accept requests!");
});

