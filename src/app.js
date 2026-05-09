const express = require("express");
const cors = require("cors");

const calendrierRoutes = require("./routes/calendrier.routes");

const app = express();

app.use(cors());
app.use(express.json());

app.get("/", (req, res) => {
  res.json({ message: "API gestion emploi du temps OK 🚀" });
});

app.use("/api/calendrier", calendrierRoutes);

module.exports = app;
const seancesRoutes = require("./routes/seances.routes");
app.use("/api/seances", seancesRoutes);