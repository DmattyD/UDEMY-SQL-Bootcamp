var faker = require('faker');
var mysql = require('mysql');

var connection = mysql.createConnection({
	host: 'localhost',
	user: 'root',
	database: 'Practice'
});

// SELECTING DATA
// var q = 'SELECT * FROM users';
// connection.query(q, function (error, results, fields) {
//   if (error) throw error;
//   console.log(results[1].email)
// });

// INSERTING DATA 
var person = {email: faker.internet.email()};
connection.query('INSERT INTO users SET ?', person, function(error, result) {
	if (error) throw error;
	console.log(result);
})
