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
// var person = {email: faker.internet.email()};
// connection.query('INSERT INTO users SET ?', person, function(error, result) {
// 	if (error) throw error;
// 	console.log(result);
// })

// var data = [
// 	['blah@gmail.com', '2018-06-01 03:51:37'],
// 	['ugh@gmail.com', '2018-06-01 03:51:37'],
// 	['meh@gmail.com', '2018-06-01 03:51:37']
// ];


//INSERTING 500 USERS

var data = [];

for(var i=0; i<500; i++) {
	data.push([
		faker.internet.email(),
		faker.date.past()
	]);
}

var q = 'INSERT INTO users (email, created_at) VALUES ?';

connection.query(q, [data], function(err, result) {
	console.log(err);
	console.log(result);
});

connection.end();
