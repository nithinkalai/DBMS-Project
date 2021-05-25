const express = require('express');
const path = require('path');
const session = require('express-session');
const cors = require('cors');

const connectionString = 'postgressql://postgres:060669@localhost:5432/online_store';
const { Client } = require('pg');

const client = new Client({
    connectionString
})
client.connect();

//helper function
getNewDate = () => {
    const date_ob = new Date();
    const date = ("0" + date_ob.getDate()).slice(-2);
    const month = ("0" + (date_ob.getMonth() + 1)).slice(-2);
    const year = date_ob.getFullYear();
    return year + "-" + month + "-" + date;
}

const app = express();

app.set('views', './views');
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));


app.use(express.static(path.join(__dirname, 'public')));
app.use(express.json());
app.use(express.urlencoded({extended: true}));
app.use(session({
	secret: 'secret',
	resave: true,
	saveUninitialized: true
}));


app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
})
app.get('/about', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'about.html'));
})
app.get('/login', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'login.html'));
})
app.get('/signup', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'signup.html'));
})
app.get('/logintobuy', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'logintobuy.html'));
})
app.get('/logout', (req, res) => {
    req.session.loggedin = false;
    res.redirect('/');
})
//To display clothing table
app.get('/collection', (req, res) => {
    client
    .query('SELECT * FROM CLOTHING',
    (err, result) => {
        if(err) throw err;
        if(result.rows.length > 0) {
            if(req.session.loggedin === true) 
                res.render('collection_user.ejs', {result: result});
            else    
                res.render('collection_guest.ejs', {result: result});
        }
            

    })
})

//Welcome page
app.get('/welcome', (req, res) => {
    if(req.session.loggedin === true) 
        res.render('welcome.ejs', {result: req.session.username});  
    else
        res.redirect('/logintoview');
});

app.post('/addtocart', (req, res) => {
    if(req.session.loggedin !== true) {
        res.redirect('/logintobuy');
        res.end();
    } else {
        const clothing_id = req.body.clothing_id;
        const cart_id = 1;
        client //returning open carts for the user
            .query('SELECT username, cart_id FROM Cart WHERE if_bought = FALSE AND username = $1',
            [req.session.username],
            (err, result) => {
                if(err) throw err; 
                if(result.rows.length === 0) { //no open cart for the user
                    const d = getNewDate();
                    client
                        .query('INSERT INTO Cart(username, order_date) VALUES($1, $2)',
                        [req.session.username, d],
                        (err, result) => {
                            if(err) throw err;
                        });
                } 
            })
    }    
})
app.post('/login', (req, res) => {
    const { username, password } = req.body;
    if(username && password) {
        client
            .query('SELECT * FROM Customer WHERE username = $1 AND pass = $2', [username, password],
            (err, result) => {
                if(err) throw err;
                if(result.rows.length !== 0){
                    req.session.loggedin = true;
                    req.session.username = username;
                    res.redirect('/welcome');
                } else {
                    res.send('Invalid username and/or password');
                }

            });
    } else {
        res.send('Invalid');
    }
    
})

app.post('/signup', (req, res) => {
    const {
        firstname,
        lastname,
        dob,
        phno,
        address,
        gender,
        email,
        username,
        password
    } = req.body;
    
    client
        .query('SELECT * FROM Customer WHERE email = $1', [email],
        (err, result) => {
            if(result.rows.length !== 0)
            {
                res.status(400).send('Email already exists, try again');
            }    
        })

    client
        .query('SELECT * FROM Customer WHERE username = $1', [username],
        (err, result) => {
            if(result.rows.length !== 0)
            {
                res.status(400).send('Username already exists, try again');
            }    
        })

    client
        .query('INSERT INTO Customer VALUES($1, $2, $3, $4, $5, $6, $7, $8, $9)',
        [username, password, firstname, lastname, dob, gender, phno, email, address],
        (err, result) => {
            if(err) throw err;
            res.status(201).send("Customer Created !");
        })
})

app.get('/cart', (req, res) => {
    if(req.session.loggedin === true)
        res.send('welcome back ' + req.session.username);
    else {
        res.send('Please sign in to view this page');
    }
})


const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`App is running on port ${PORT}`);
})