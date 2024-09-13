const express = require("express");
const fs = require("fs");
const app = express();
const port = 3000;

app.use(express.json());

const readData = () => {
  const data = fs.readFileSync("data.json");
  return JSON.parse(data);
};

const writeData = (data) => {
  fs.writeFileSync("data.json", JSON.stringify(data, null, 2));
};

// Get list of products
app.get("/products", (req, res) => {
  const data = readData();
  res.json(data.products);
});

// Add a product to the list
app.post("/products", (req, res) => {
  const data = readData();
  const { id, name, price } = req.body;
  const newProduct = {
    id: id,
    name: name,
    price: price,
  };
  data.products.push(newProduct);
  writeData(data);
  res.status(201).json(newProduct);
});

// Delete a product by ID
app.delete("/products/:id", (req, res) => {
  const data = readData();
  const id = req.params.id;
  data.products = data.products.filter((product) => product.id !== id);
  writeData(data);
  res.status(204).send(data);
});

// Update a product by ID
app.put("/products/:id", (req, res) => {
  const data = readData();
  const productId = req.params.id;
  const { price } = req.body;
  const productIndex = data.products.findIndex((item) => item.id === productId);

  if (productIndex !== -1) {
    const updatedProduct = {
      id: productId,
      name: data.products[productIndex].name,
      price: price || data.products[productIndex].price, // Keep old price if not provided
    };

    data.products[productIndex] = updatedProduct;
    writeData(data);
    res.json(updatedProduct);
  } else {
    res.status(404).json({ error: "Product not found" });
  }
});

app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});
