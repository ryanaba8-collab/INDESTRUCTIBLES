const prisma = require("../config/prisma");

exports.createSeance = async (req, res) => {
  try {
    const {
      sequence_id,
      salle_id,
      date_cours,
      heure_debut,
      heure_fin,
      cree_par,
      commentaire
    } = req.body;

    // 🔥 Correction fuseau horaire
    const dateCours = new Date(`${date_cours}T00:00:00Z`);
    const debutDateTime = new Date(`${date_cours}T${heure_debut}Z`);
    const finDateTime = new Date(`${date_cours}T${heure_fin}Z`);

    const sequence = await prisma.sequences_cours.findUnique({
      where: { id: Number(sequence_id) }
    });

    if (!sequence) {
      return res.status(404).json({ message: "Séquence introuvable" });
    }

    const dureeSeance = Number(sequence.duree_seance);
    const heuresRestantes = Number(sequence.heures_restantes);

    if (heuresRestantes < dureeSeance) {
      return res.status(400).json({
        message: "Heures restantes insuffisantes"
      });
    }

    const conflitSalle = await prisma.seances.findFirst({
      where: {
        salle_id: Number(salle_id),
        date_cours: dateCours,
        statut: "PLANIFIEE",
        heure_debut: { lt: finDateTime },
        heure_fin: { gt: debutDateTime }
      }
    });

    if (conflitSalle) {
      return res.status(409).json({ message: "Salle déjà occupée" });
    }

    const conflitProf = await prisma.seances.findFirst({
      where: {
        date_cours: dateCours,
        statut: "PLANIFIEE",
        heure_debut: { lt: finDateTime },
        heure_fin: { gt: debutDateTime },
        sequences_cours: {
          professeur_id: sequence.professeur_id
        }
      }
    });

    if (conflitProf) {
      return res.status(409).json({ message: "Professeur déjà occupé" });
    }

    const conflitGroupe = await prisma.seances.findFirst({
      where: {
        date_cours: dateCours,
        statut: "PLANIFIEE",
        heure_debut: { lt: finDateTime },
        heure_fin: { gt: debutDateTime },
        sequences_cours: {
          groupe_id: sequence.groupe_id
        }
      }
    });

    if (conflitGroupe) {
      return res.status(409).json({ message: "Groupe déjà occupé" });
    }

    const result = await prisma.$transaction(async (tx) => {
      const seance = await tx.seances.create({
        data: {
          sequence_id: Number(sequence_id),
          salle_id: Number(salle_id),
          date_cours: dateCours,
          heure_debut: debutDateTime,
          heure_fin: finDateTime,
          statut: "PLANIFIEE",
          cree_par: cree_par ? Number(cree_par) : null,
          commentaire: commentaire || null
        }
      });

      const nouvellesHeures = heuresRestantes - dureeSeance;

      const sequenceMaj = await tx.sequences_cours.update({
        where: { id: Number(sequence_id) },
        data: {
          heures_restantes: nouvellesHeures,
          statut: nouvellesHeures <= 0 ? "TERMINEE" : "ACTIVE"
        }
      });

      return { seance, sequence: sequenceMaj };
    });

    res.status(201).json({
      message: "Séance créée avec succès",
      data: result
    });

  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Erreur serveur" });
  }
};

exports.updateSeance = async (req, res) => {
  try {
    const seanceId = Number(req.params.id);

    const {
      salle_id,
      date_cours,
      heure_debut,
      heure_fin,
      modifie_par,
      motif
    } = req.body;

    // 🔥 Correction fuseau horaire
    const dateCours = new Date(`${date_cours}T00:00:00Z`);
    const debutDateTime = new Date(`${date_cours}T${heure_debut}Z`);
    const finDateTime = new Date(`${date_cours}T${heure_fin}Z`);

    const ancienneSeance = await prisma.seances.findUnique({
      where: { id: seanceId },
      include: {
        sequences_cours: true
      }
    });

    if (!ancienneSeance) {
      return res.status(404).json({ message: "Séance introuvable" });
    }

    const sequence = ancienneSeance.sequences_cours;

    const conflitSalle = await prisma.seances.findFirst({
      where: {
        id: { not: seanceId },
        salle_id: Number(salle_id),
        date_cours: dateCours,
        statut: "PLANIFIEE",
        heure_debut: { lt: finDateTime },
        heure_fin: { gt: debutDateTime }
      }
    });

    if (conflitSalle) {
      return res.status(409).json({ message: "Salle déjà occupée" });
    }

    const conflitProf = await prisma.seances.findFirst({
      where: {
        id: { not: seanceId },
        date_cours: dateCours,
        statut: "PLANIFIEE",
        heure_debut: { lt: finDateTime },
        heure_fin: { gt: debutDateTime },
        sequences_cours: {
          professeur_id: sequence.professeur_id
        }
      }
    });

    if (conflitProf) {
      return res.status(409).json({ message: "Professeur déjà occupé" });
    }

    const conflitGroupe = await prisma.seances.findFirst({
      where: {
        id: { not: seanceId },
        date_cours: dateCours,
        statut: "PLANIFIEE",
        heure_debut: { lt: finDateTime },
        heure_fin: { gt: debutDateTime },
        sequences_cours: {
          groupe_id: sequence.groupe_id
        }
      }
    });

    if (conflitGroupe) {
      return res.status(409).json({ message: "Groupe déjà occupé" });
    }

    const result = await prisma.$transaction(async (tx) => {
      const seanceModifiee = await tx.seances.update({
        where: { id: seanceId },
        data: {
          salle_id: Number(salle_id),
          date_cours: dateCours,
          heure_debut: debutDateTime,
          heure_fin: finDateTime
        }
      });

      const historique = await tx.historique_modifications.create({
        data: {
          seance_id: seanceId,
          modifie_par: Number(modifie_par),
          ancienne_date: ancienneSeance.date_cours,
          ancienne_heure_debut: ancienneSeance.heure_debut,
          ancienne_heure_fin: ancienneSeance.heure_fin,
          ancienne_salle_id: ancienneSeance.salle_id,
          nouvelle_date: dateCours,
          nouvelle_heure_debut: debutDateTime,
          nouvelle_heure_fin: finDateTime,
          nouvelle_salle_id: Number(salle_id),
          motif: motif || null
        }
      });

      return { seance: seanceModifiee, historique };
    });

    res.json({
      message: "Séance modifiée avec succès",
      data: result
    });

  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Erreur serveur" });
  }
};
exports.annulerSeance = async (req, res) => {
  try {
    const seanceId = Number(req.params.id);

    const seance = await prisma.seances.findUnique({
      where: { id: seanceId }
    });

    if (!seance) {
      return res.status(404).json({ message: "Séance introuvable" });
    }

    if (seance.statut === "ANNULEE") {
      return res.status(400).json({ message: "Cette séance est déjà annulée" });
    }

    const seanceAnnulee = await prisma.seances.update({
      where: { id: seanceId },
      data: {
        statut: "ANNULEE"
      }
    });

    res.json({
      message: "Séance annulée avec succès",
      data: seanceAnnulee
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Erreur serveur" });
  }
};