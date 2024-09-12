const express = require('express');
const fs = require('fs');
const app = express();
const port = 3000;

app.use(express.json());

const readData = () => {
  const data = fs.readFileSync('data.json');
  return JSON.parse(data);
};

const writeData = (data) => {
  fs.writeFileSync('data.json', JSON.stringify(data, null, 2));
};

// Get list of products
app.get('/products', (req, res) => {
  const data = readData();
  res.json(data.products);
});

// Add a product to the list
app.post('/products', (req, res) => {
  const data = readData();
  const newProduct = { id: Date.now(), ...req.body };
  data.products.push(newProduct);
  writeData(data);
  res.status(201).json(newProduct);
});

// Delete a product by ID
app.delete('/products/:id', (req, res) => {
  const data = readData();
  const id = parseInt(req.params.id);
  data.products = data.products.filter((product) => product.id !== id);
  writeData(data);
  res.status(204).send();
});

// Get cart items
app.get('/cart', (req, res) => {
  const data = readData();
  res.json(data.cart);
});

// Add item to cart
app.post('/cart', (req, res) => {
  const data = readData();
  const newItem = { id: Date.now(), ...req.body };
  data.cart.push(newItem);
  writeData(data);
  res.status(201).json(newItem);
});

// Delete item from cart
app.delete('/cart/:id', (req, res) => {
  const data = readData();
  const id = parseInt(req.params.id);
  data.cart = data.cart.filter((item) => item.id !== id);
  writeData(data);
  res.status(204).send();
});

// Get wishlist items
app.get('/wishlist', (req, res) => {
  const data = readData();
  res.json(data.wishlist);
});

// Add item to wishlist
app.post('/wishlist', (req, res) => {
  const data = readData();
  const newItem = { id: Date.now(), ...req.body };
  data.wishlist.push(newItem);
  writeData(data);
  res.status(201).json(newItem);
});

// Delete item from wishlist
app.delete('/wishlist/:id', (req, res) => {
  const data = readData();
  const id = parseInt(req.params.id);
  data.wishlist = data.wishlist.filter((item) => item.id !== id);
  writeData(data);
  res.status(204).send();
});

app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});
