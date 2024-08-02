const express = require("express");
const vehicleController = require("../controllers/vehicleController");
const authController = require("../controllers/authController");

const router = express.Router();

router.post("/add", authController.protect, vehicleController.addVehicle);

router.get(
  "/myVehicles",
  authController.protect,
  vehicleController.getMyVehicles
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
