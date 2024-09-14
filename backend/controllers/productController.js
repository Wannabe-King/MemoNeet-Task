const { readData, writeData } = require("../models/productModel");

const getProducts = (req, res) => {
  const data = readData();
  res.json(data.products);
};

const addProduct = (req, res) => {
  const data = readData();
  const { id, name, price } = req.body;
  const newProduct = { id, name, price: parseFloat(price) };
  data.products.push(newProduct);
  writeData(data);
  res.status(201).json(newProduct);
};

const deleteProduct = (req, res) => {
  const data = readData();
  const id = req.params.id;
  data.products = data.products.filter((product) => product.id !== id);
  writeData(data);
  res.status(204).send();
};

const updateProduct = (req, res) => {
  const data = readData();
  const productId = req.params.id;
  const { price } = req.body;
  const productIndex = data.products.findIndex((item) => item.id === productId);

  if (productIndex !== -1) {
    const updatedProduct = {
      id: productId,
      name: data.products[productIndex].name,
      price: parseFloat(price) || data.products[productIndex].price
    };

    data.products[productIndex] = updatedProduct;
    writeData(data);
    res.json(updatedProduct);
  } else {
    res.status(404).json({ error: "Product not found" });
  }
};

module.exports = {
  getProducts,
  addProduct,
  deleteProduct,
  updateProduct
};
