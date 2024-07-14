const mongoose = require("mongoose");

const vehicleSchema = mongoose.Schema({
  numberPlate: {
    type: String,
    requred: [true, "Please enter the number plate"],
  },
  ownedBy: {
    type: mongoose.Types.ObjectId,
    ref: "User",
    required: [true, "please provide user"],
  },
});

const Vehicle = mongoose.model("Vehicle", vehicleSchema);

module.exports = Vehicle;
