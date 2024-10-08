# Memoneet Task
The app was built with a Node.js backend and a Flutter client(**following MVVM architecture**). The project demonstrates a basic full-stack application where users can manage products, such as adding, updating, and deleting(**CRUD**) items. The project consists of two main components:

- **Backend**: A RESTful API built using Node.js and Express that handles item management (located in the backend folder).
- **Frontend**: A Flutter mobile application that interacts with the backend API (located in the frontend folder).
  
### Screenshots

<div style="display: flex; flex-wrap: wrap; justify-content: space-around;">
    <img src="https://github.com/Wannabe-King/MemoNeet-Task/blob/master/readmeData/Screenshot_1726224996.png" alt="Screenshot 1" style="width: 30%; margin-bottom: 10px;">
    <img src="https://github.com/Wannabe-King/MemoNeet-Task/blob/master/readmeData/Screenshot_1726225303.png" alt="Screenshot 2" style="width: 30%; margin-bottom: 10px;">
    <img src="https://github.com/Wannabe-King/MemoNeet-Task/blob/master/readmeData/Screenshot_1726225312.png" alt="Screenshot 6" style="width: 30%; margin-bottom: 10px;">
    <img src="https://github.com/Wannabe-King/MemoNeet-Task/blob/master/readmeData/Screenshot_1726225316.png" alt="Screenshot 3" style="width: 30%; margin-bottom: 10px;">
    <img src="https://github.com/Wannabe-King/MemoNeet-Task/blob/master/readmeData/Screenshot_1726225326.png" alt="Screenshot 4" style="width: 30%; margin-bottom: 10px;">
    <img src="https://github.com/Wannabe-King/MemoNeet-Task/blob/master/readmeData/Screenshot_1726225360.png" alt="Screenshot 5" style="width: 30%; margin-bottom: 10px;">
</div>


### Project Structure
```
memoneet/
│
├── backend/
│   ├── controllers/
│   │   └── productController.js  # Business logic for handling requests
│   ├── routes/
│   │   └── productRoutes.js      # API route definitions
│   ├── models/
│   │   └── productModel.js       # Data reading/writing logic
│   ├── data/
│   │   └── data.json             # JSON file for storing products
│   └── app.js      
│   └── ...         # Other necessary backend files
│
├── frontend/       # Flutter mobile client
│   ├── lib/
│   │   ├── models/ # Flutter data models
│   │   ├── views/  # UI components
│   │   ├── services/ # API service class for handling HTTP requests
│   │   └── ...     # Other Flutter files
│   └── pubspec.yaml
│
└── README.md       # This file
```

## Features
- **Product Management**: Users can view, add, update, and delete grocery items.
- **Data Storage**: Backend stores product data in a JSON file (data.json) for simplicity.
- **RESTful API**: A simple REST API with endpoints for CRUD operations on products.
- **Mobile App**: A Flutter mobile client that interacts with the backend API.

## Setup Instructions
Follow the steps below to set up and run the project.

### 1. Clone the Repository
```
git clone https://github.com/Wannabe-King/MemoNeet-Task.git
```

### 2. Backend Setup (Node.js)
1) Navigate to the backend directory:
```
cd backend
```
2) Install the dependencies:
```
npm install
```
3) Run the server:
```
node server.js
```
4) The server will be running on `http://localhost:3000`

#### API Endpoints:
- `GET /products`: Fetch a list of products.
- `POST /products`: Add a new product.
- `PUT /products/:id`: Update product price by ID.
- `DELETE /products/:id`: Delete a product by ID.


### 3. Frontend Setup (Flutter)
1) Navigate to the `frontend` directory:
   ```
   cd ../frontend
   ```
2) Install the Flutter dependencies:
   ```
   flutter pub get
   ```
3) Make sure the backend server is running. If you are using an Android emulator, the API URL is set to `http://10.0.2.2:3000` otherwise `http://localhost:3000` in the Flutter app.
4) Run the Flutter app:
   ```
   flutter run
   ```

This will launch the Flutter app on your connected device or emulator.

### 4. Running on a Real Device
- Ensure both your development machine and the mobile device are on the same network.
- Replace the API URL in frontend/lib/services/api_service.dart with your machine's local IP address (e.g., http://192.168.x.x:3000).

### 5. Modifying the Project
- Backend: The backend uses an in-memory store via a JSON file (`data.json`) located in the `backend` folder. You can modify the structure and logic of the backend as per your needs.
- Frontend: The Flutter client interacts with the API via HTTP requests. You can expand the UI and functionality to include additional features like user authentication, product categorization, etc.

## Dependencies
### Backend (Node.js):
- `express`: Web framework for Node.js.
- `body-parser`: Middleware to handle JSON request bodies.
### Frontend (Flutter):
- `provider`: State management for Flutter.
- `http`: For making HTTP requests.
