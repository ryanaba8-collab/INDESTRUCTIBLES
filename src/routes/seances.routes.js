const express = require("express");
const router = express.Router();

const seancesController = require("../controllers/seances.controller");

router.post("/", seancesController.createSeance);
router.put("/:id", seancesController.updateSeance);
router.patch("/:id/annuler", seancesController.annulerSeance);


module.exports = router;