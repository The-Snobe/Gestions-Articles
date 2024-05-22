-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 22 avr. 2024 à 12:37
-- Version du serveur : 10.4.28-MariaDB
-- Version de PHP : 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `project`
--

-- --------------------------------------------------------

--
-- Structure de la table `produit`
--

CREATE TABLE `produit` (
  `code` varchar(200) NOT NULL,
  `designation` varchar(200) NOT NULL,
  `prix` float NOT NULL,
  `quantite` int(11) NOT NULL,
  `dateExpiration` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Déchargement des données de la table `produit`
--

INSERT INTO `produit` (`code`, `designation`, `prix`, `quantite`, `dateExpiration`) VALUES
('AA123', 'Cereales', 2500, 15, '2024-05-31'),
('AA128', 'cremes', 2350, 4, '2024-05-12'),
('AA456', 'lotions', 6700, 12, '2024-04-29'),
('AA540', 'Bonbon', 30400, 24, '2024-05-11'),
('AA567', 'fromage', 7500, 65, '2024-04-28'),
('AA573', 'Parfum', 30400, 13, '2024-05-12'),
('AA761', 'Confiture', 4200, 15, '2024-05-24'),
('AA765', 'lait', 7800, 3, '2024-04-30');

-- --------------------------------------------------------

--
-- Structure de la table `responsable`
--

CREATE TABLE `responsable` (
  `id` int(200) NOT NULL,
  `nom` varchar(200) NOT NULL,
  `prenom` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Déchargement des données de la table `responsable`
--

INSERT INTO `responsable` (`id`, `nom`, `prenom`, `email`, `password`) VALUES
(1, 'KAZE TIOTSOP', 'Audrey', 'audreykaze03@gmail.com', 'Tka@2004'),
(3, 'KAZE ', 'Audrey', 'kaze03@gmail.com', 'La@12345'),
(4, 'TENDOGMO', 'KITIO', 'audreykaze3@gmail.com', 'Ka@12345');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `produit`
--
ALTER TABLE `produit`
  ADD PRIMARY KEY (`code`);

--
-- Index pour la table `responsable`
--
ALTER TABLE `responsable`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `responsable`
--
ALTER TABLE `responsable`
  MODIFY `id` int(200) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
