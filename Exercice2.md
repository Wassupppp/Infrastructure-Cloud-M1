# Exercice – Comparaison des coûts Cloud (IaaS)

## Consigne

Comparer les **coûts mensuels** de **3 infrastructures** sur les fournisseurs cloud suivants :
- **AWS**
- **GCP**
- **Azure**
- **Scaleway**
- **OVHcloud**

**Hypothèses** :
- Tarifs exprimés en **USD**, mensuels, **hors taxes**.
- **Aucune licence**, **aucun plan d’économie** ou **remise** n’est appliqué.
- **Région** utilisée : **Europe (Paris)** ou équivalent.

---

#  Comparatif Cloud – Infrastructure n°1

> **Configuration demandée :**  
> 1 serveur – **4 vCPU**, **16 Go RAM**, **100 Go de stockage SSD**  
> Périmètre : sans licence, sans plan d’économie, région Paris ou Europe, en $USD, mensuel, hors taxes.

---

## Détail des coûts mensuels par fournisseur

| Cloud Provider | Type d’Instance       | vCPU | RAM   | Stockage (100 GB SSD) | Coût Instance ($/mois) | Coût Stockage ($/mois) | **Coût Total ($/mois)** |
|----------------|------------------------|------|--------|-------------------------|--------------------------|--------------------------|---------------------------|
| **Scaleway**   | GP1‑XS (ARM)           | 4    | 16 Go | Inclus                  | ~80.00                  | 0.00                     | **80.00**                 |
| **OVHcloud**   | b3‑16                  | 4    | 16 Go | Block Storage NVMe      | 73.15                   | 9.50                     | **82.65**                 |
| **Azure**      | D4as_v5                | 4    | 16 Go | Premium SSD             | 81.03                   | 10.00                    | **91.03**                 |
| **AWS**        | t3a.xlarge             | 4    | 16 Go | GP3 EBS                 | 108.29                  | 9.28                     | **117.57**                |
| **GCP**        | n2‑standard‑4          | 4    | 16 Go | PD‑SSD                  | 139.82                  | 19.72                    | **159.54**                |

---

### 🔎 Notes :
- **Régions choisies** : Paris (France) ou Europe de l’Ouest.
- **Durée estimée** : 720 heures/mois (≈ 30 jours × 24 h).
- **Stockage SSD uniquement**, basé sur les offres standards disponibles publiquement.

---

#  Comparatif Cloud – Infrastructure n°2

> **Infrastructure n°2** :  
> 6 serveurs – **3 vCPU**, **6 Go RAM**, **20 Go SSD** chacun  
> Particularité : 3 serveurs sont arrêtés chaque nuit de **22h à 6h**

---

## Heures mensuelles (sur base de 730h/mois)

- **3 serveurs full time** : 3 × 730 = **2 190 h**
- **3 serveurs actifs 16h/jour** : 16 × 30 = 480 h × 3 = **1 440 h**
- **Total d'heures mensuelles utilisées** : **3 630 h**

---

## Détail des coûts mensuels par fournisseur

| Provider    | Instance (extrapolée)        | Tarif horaire ($) | Coût Compute ($)      | Coût Stockage ($)           | **Total mensuel ($)** |
|-------------|-------------------------------|-------------------|------------------------|------------------------------|------------------------|
| **OVHcloud**| C2‑2x                         | 0.0300            | 0.03 × 3 630 = 108.90   | 6 × 20 Go × 0.038 = 4.56     | **113.46**             |
| **AWS**     | t3.medium                     | 0.0624            | 0.0624 × 3 630 = 226.51 | 6 × 20 Go × 0.08 = 9.60      | **236.11**             |
| **GCP**     | e2-custom (3 vCPU / 6 Go)     | 0.1200            | 0.12 × 3 630 = 435.60   | 6 × 20 Go × 0.04 = 4.80      | **440.40**             |
| **Scaleway**| DEV1-M                        | 0.1200            | 0.12 × 3 630 = 435.60   | 6 × 20 Go × 0.10 = 12.00     | **447.60**             |
| **Azure**   | D2_v5                         | 0.1440            | 0.144 × 3 630 = 522.72  | 6 × 20 Go × 0.09 = 10.80     | **533.52**             |

---

#  Comparatif Cloud – Infrastructure n°3

> **Configuration demandée :**  
> - 3 serveurs – **2 vCPU**, **4 Go RAM**, **50 Go SSD** chacun  
> - 1 Load Balancer répartissant **5 Mb/s** (≈ 1.65 TB/mois) entre les 3 serveurs  
> - 1 base de données managée – **2 vCPU**, **8 Go RAM**, **10 Go stockage**

---

## Détail des composants

- **VM** : 3 instances × 720 h = 2 160 h
- **Stockage VM total** : 150 Go
- **Load Balancer** : 5 Mb/s ≈ 1 650 Go sortants/mois
- **Base de données managée** : 2 vCPU, 8 Go RAM, 10 Go SSD

---

## Coûts estimés par fournisseur

| Fournisseur | Instance VM (3×)                              | Stockage VM | Base gérée DB | Load Balancer               | **Total mensuel ($)** |
|-------------|-----------------------------------------------|-------------|----------------|------------------------------|------------------------|
| **OVHcloud**| VPS C2‑2x – 0.03 $/h × 2160 h = 64.80 $       | inclus      | PostgreSQL ≈ 51.26 $         | LB Pack1 19.90 $ + 18.3 $ data | **154.20**             |
| **AWS**     | t3.medium – 0.0624 $/h × 2160 h = 134.90 $    | 45.00 $     | db.t3.small ≈ 60.00 $        | ALB ~24.24 $ + 13.20 $ data    | **277.34**             |
| **Scaleway**| DEV1-M – 0.12 $/h × 2160 h = 259.20 $         | inclus      | PostgreSQL ≈ 16.50 $         | LB 13.26 $ + 13.20 $ data      | **302.16**             |
| **GCP**     | e2-custom – 0.12 $/h × 2160 h = 259.20 $      | 45.00 $     | Cloud SQL ≈ 80.00 $          | LB ~18.00 $ + 13.20 $ data     | **415.40**             |
| **Azure**   | D2_v5 – 0.144 $/h × 2160 h = 311.04 $         | 45.00 $     | PostgreSQL Basic ≈ 90.00 $   | LB ~8.64 $ + 6.60 $ data       | **461.24**             |
