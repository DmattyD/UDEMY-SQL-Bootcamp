var express = require('express');
var app = express();
var mysql = require('mysql');
var bodyParser = require('body-parser');
app.set('view engine', 'ejs');
app.use(bodyParser.urlencoded({extended: true}));
app.use(express.static(__dirname + '/views'));

var connection = mysql.createConnection({
	host: 'localhost',
	user: 'root',
	database: 'Practice'
});


app.get('/', function(req, res){
	// Find count of users in DB
	var q = 'SELECT COUNT(*) as count FROM users';
	connection.query(q, function(err, results){
		if(err) throw err;
		var count = results[0].count;
		console.log('successfully connected');
			// Respond with that count
		//res.send('We have ' + count + ' users in our db');
		res.render('home', {count: count});
	});
});

app.post('/register', function(req, res){
	var person = {email: req.body.email	};
	connection.query('INSERT INTO users SET ?', person, function(err, result) {
	console.log(err);
	console.log(result);
	res.redirect('/');
});
});
app.get('/joke', function (req, res){
	var joke = 'What do you call a dog that does magic tricks?  A labracadabrador.';
	res.send(joke)
});

app.get('/random_num', function(req, res){
	var num = Math.floor((Math.random()* 10) +1) ;
	res.send('Your luck number is ' + num)
});

app.listen(3000, function(){
	console.log('Server running on Port 3000');
});
