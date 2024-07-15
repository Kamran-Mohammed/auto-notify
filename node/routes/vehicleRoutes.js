const express = require("express");
const vehicleController = require("../controllers/vehicleController");
const authController = require("../controllers/authController");

const router = express.Router();

router.post(
  "/register",
  authController.protect,
  vehicleController.registerVehicle
);

// router.patch(
//   "/updatePassword",
//   authController.protect,
//   authController.updatePassword
// );

// router
//   .route("/")
//   .get(userController.getAllUsers)
//   .post(userController.createUser);

// router
//   .route("/:id")
//   .get(userController.getUser)
//   .patch(userController.updateUser)
//   .delete(userController.deleteUser);

module.exports = router;
