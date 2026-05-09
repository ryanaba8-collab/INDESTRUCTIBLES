const express = require("express");
const router = express.Router();

const calendrierController = require("../controllers/calendrier.controller");

router.get("/groupe/:id", calendrierController.getCalendrierGroupe);
router.get("/professeur/:id", calendrierController.getCalendrierProfesseur);

module.exports = router;