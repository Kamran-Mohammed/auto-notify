const Vehicle = require("../models/vehicleModel");
const User = require("../models/userModel");
const catchAsyncError = require("../utils/catchAsyncError");
const AppError = require("../utils/appError");

function validateNumberPlate(plate) {
  const pattern = /^[A-Z]{2}\d{2}(?:[A-Z]{1,3})?\d{4}$/;
  return pattern.test(plate);
}

exports.addVehicle = catchAsyncError(async (req, res, next) => {
  const numberPlate = req.body.numberPlate;

  if (!validateNumberPlate(numberPlate)) {
    // console.log("Wrong number plate format");
    return next(new AppError("Invalid number plate format", 400));
  }

  // req.body.createdBy = req.user.userId; alternative method
  const newVehicle = await Vehicle.create({
    name: req.body.name,
    numberPlate: req.body.numberPlate,
    ownedBy: req.user._id,
  });

  //add vehicle to Owner's User document
  await User.findByIdAndUpdate(req.user._id, {
    $push: { vehicles: newVehicle._id },
  });

  res.status(201).json({
    status: "success",
    data: {
      newVehicle,
    },
  });
});

exports.getMyVehicles = catchAsyncError(async (req, res, next) => {
  const id = req.user._id;

  const myVehicles = await Vehicle.find({ ownedBy: id });

  res.status(200).json({
    status: "success",
    data: {
      myVehicles,
    },
  });
});
