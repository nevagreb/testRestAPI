const express = require("express");
const app = express();
const bodyParser = require('body-parser');

var urlencodedParser = bodyParser.urlencoded({ extended: false });
var jsonParser = bodyParser.json();

class Person {
	static currentId = 0;
	constructor(email, first_name, last_name, avatar) {
		this.id = Person.currentId++;
		this.email = email;
		this.first_name = first_name;
		this.last_name = last_name;
		this.avatar = avatar;
	}

	editData(email, first_name, last_name, avatar) {
		this.email = email;
		this.first_name = first_name;
		this.last_name = last_name;
		this.avatar = avatar;
	}

	static addPersonToArray(array1, email, first_name, last_name, avatar) {
        	array1.push(new Person(email, first_name, last_name, avatar));
    }
}

let myObject = [
	new Person("michael.lawson@reqres.in", "Michael", "Lawson", "https://reqres.in/img/faces/7-image.jpg"), 
	new Person("lindsay.ferguson@reqres.in", "Lindsay", "Ferguson", "https://reqres.in/img/faces/8-image.jpg"), 
	new Person("tobias.funke@reqres.in", "Tobias", "Funke", "https://reqres.in/img/faces/9-image.jpg"), 
	new Person("byron.fields@reqres.in", "Byron", "Fields", "https://reqres.in/img/faces/10-image.jpg"), 
	new Person("george.edwards@reqres.in", "George", "Edwards", "https://reqres.in/img/faces/11-image.jpg"), 
	new Person("rachel.howell@reqres.in", "Rachel", "Howell", "https://reqres.in/img/faces/12-image.jpg")
];


app.get("/url", (req, res, next) => {
	res.json(myObject);
});



app.post('/url', jsonParser, function(req, res)  {
	Person.addPersonToArray(myObject, req.body.email, req.body.first_name, req.body.last_name, req.body.avatar)
	res.json(myObject);
});

app.put('/url/:id', jsonParser, function(req, res) {
	const id = parseInt(req.params.id);
	const index = myObject.findIndex(person => person.id == id);
	console.log(id, index);
    if (index !== -1) {
        myObject[index].editData(req.body.email, req.body.first_name, req.body.last_name, req.body.avatar);
	console.log("Data:", req.body.email, req.body.first_name, req.body.last_name, req.body.avatar);
	res.json(myObject);
    } else {
        res.status(404).json({ message: 'Person not found' });
    }
});

app.delete('/url/:id', (req, res) => {
	const id = parseInt(req.params.id);
	const index = myObject.findIndex(person => person.id == id);

    if (index !== -1) {
        myObject.splice(index, 1);
	res.json(myObject);
    } else {
        res.status(404).json({ message: 'Person not found' });
    }
});

app.listen(3000, () => {
 console.log("Server running on port 3000");
});


