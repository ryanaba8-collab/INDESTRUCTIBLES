const prisma = require("../config/prisma");

exports.getCalendrierGroupe = async (req, res) => {
  try {
    const groupeId = Number(req.params.id);

    const seances = await prisma.seances.findMany({
      where: {
        sequences_cours: {
          groupe_id: groupeId
        }
      },
      include: {
        salles: {
          select: {
            nom: true
          }
        },
        sequences_cours: {
          select: {
            matieres: {
              select: {
                nom: true
              }
            }
          }
        }
      },
      orderBy: [
        { date_cours: "asc" },
        { heure_debut: "asc" }
      ]
    });

    res.json(seances);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Erreur serveur" });
  }
};
exports.getCalendrierProfesseur = async (req, res) => {
  try {
    const professeurId = Number(req.params.id);

    const seances = await prisma.seances.findMany({
      where: {
        statut: "PLANIFIEE",
        sequences_cours: {
          professeur_id: professeurId
        }
      },
      include: {
        salles: {
          select: {
            id: true,
            nom: true,
            code: true
          }
        },
        sequences_cours: {
          select: {
            id: true,
            type_cours: true,
            matieres: {
              select: {
                id: true,
                nom: true,
                code: true
              }
            },
            groupes: {
              select: {
                id: true,
                nom: true,
                periode: true
              }
            }
          }
        }
      },
      orderBy: [
        { date_cours: "asc" },
        { heure_debut: "asc" }
      ]
    });

    res.json(seances);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Erreur serveur" });
  }
};