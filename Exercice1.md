#  Cas n°1 : Eldo – Start-up de 60 employés

##  Projets développés

- Un **logiciel de mise en relation** (type plateforme web)
- Un **CRM pour professionnels du BTP**

---

##  Exigences identifiées

- Déploiement **rapide** et **évolutif**
- **Coûts maîtrisés** (contexte start-up)
- Forte probabilité de croissance → **scalabilité**
- **Haute disponibilité** nécessaire
- Application web → potentiellement **forte charge** en cas de succès

---

##  Type de cloud recommandé : **Cloud public**

### Pourquoi le cloud public ?
- Évolutif facilement → indispensable pour une start-up qui peut grossir vite
- **Investissement initial faible** → pas besoin d’acheter de serveurs
- **Déploiement rapide** → gain de temps pour les développeurs
- Pas de maintenance d'infrastructure → focus sur le produit

---

##  Exemples de fournisseurs adaptés

- **Amazon Web Services (AWS)**
- **Microsoft Azure**
- **Google Cloud Platform (GCP)**

---

##  Modèle XaaS recommandé : **PaaS (Platform as a Service)**

### Avantages du PaaS pour Eldo
- L’équipe de dev peut se concentrer sur le **code** (pas de gestion VM, OS, MAJ)
- Permet de déployer rapidement les **deux modules** (mise en relation + CRM)
- Supporte nativement **CI/CD**, **microservices** et **API**
- Gère automatiquement la **scalabilité**

---

##  Estimation du coût mensuel (au lancement)

| Ressource                      | Estimation / mois | Détail                                      |
|-------------------------------|-------------------|---------------------------------------------|
| Hébergement App Web (PaaS)    | ~50–150 €         | selon trafic et environnements              |
| Base de données (SQL/NoSQL)   | ~30–100 €         | selon volume et requêtes                    |
| Stockage fichiers/images      | ~10–30 €          | pièces jointes, photos de chantier…         |
| Services annexes (monitoring, mail…) | ~10–50 €  | App Insights, SendGrid, logs, etc.          |

---

###  **Total estimé** : **~100 à 300 €/mois** au lancement  
> Montant **évolutif** selon la charge et le succès de la plateforme


#  Cas n°2 : MySecureProtect

##  Type de cloud recommandé : **Cloud hybride**

### Pourquoi un cloud hybride ?
- Une partie **cloud public** pour :
  - l’infrastructure évolutive
  - les **API**, traitements serveur, bases de données, services web
- Une partie **cloud privé** ou **edge computing** pour :
  - le traitement **localisé** des données
  - les **notifications critiques**
  - le **traitement embarqué** (IoT, capteurs, véhicules...)

### Objectifs couverts :
- **Sécurité** renforcée
- **Latence** réduite
- **Résilience** des systèmes critiques
- **Compliance RGPD**

---

##  Modèle XaaS recommandé : **Combinaison IaaS + PaaS**

| Type   | Usage                                                                 |
|--------|------------------------------------------------------------------------|
| **PaaS** | Pour l’app mobile, les **API REST**, les **services web**, le **DBaaS** |
| **IaaS** | Pour les **pics de charge**, les **files de messages**, les serveurs **MQTT**, etc. |

- **IaaS** : offre un **contrôle accru** pour gérer les **flux massifs de données IoT**  
- **PaaS** : idéal pour les services orientés utilisateurs (notifications, dashboards, mobile)

---

##  Estimation des coûts mensuels (pour 1 million de devices connectés)

| Ressource                     | Estimation / mois |
|------------------------------|-------------------|
| IoT Hub (connexion 1M devices) | ~800–1500 €       |
| Stockage cloud + base de données | ~500–1000 €     |
| Services backend / API       | ~300–700 €         |
| Notifications / Messaging    | ~100–300 €         |
| Sécurité / monitoring / logs | ~200–500 €         |

---

###  **Total estimé** : **~2000 à 4000 €/mois**
> Coût **hautement scalable**, dépendant du **nombre de messages/jour** et du **volume de données stockées**

#  Cas n°3 : Utilisateur particulier – Paul

##  Type de cloud recommandé : **Cloud public**

### Pourquoi le cloud public ?
- Idéal pour un **utilisateur individuel**
- **Accès depuis n’importe où**, sur tous types d’appareils
- **Maintenance** gérée entièrement par le fournisseur
- **Haut niveau de sécurité** et **redondance des données**
- Utilisation simple via des **applications mobiles** ou web

---

##  Fournisseurs typiques

- **Google Drive**
- **Microsoft OneDrive**
- **Apple iCloud**
- **Dropbox**

---

##  Modèle XaaS recommandé : **SaaS (Software as a Service)**

### Pourquoi le SaaS ?
- Paul **n’a pas besoin de gérer l’infrastructure**
- Il souhaite uniquement **accéder à un service fiable et fonctionnel**
- Interface **web et mobile** fournie
- Sauvegarde, synchronisation et partage facilités

---

##  Exemples de solutions SaaS

| Service          | Offre             | Prix approx. / mois | Avantages                                      |
|------------------|-------------------|----------------------|------------------------------------------------|
| **Google One**   | 2 To              | ~9,99 €              | Multi-plateforme, partage familial             |
| **OneDrive**     | 1 To + Office     | ~7,00 €              | Intégré à Windows, inclus avec Microsoft 365   |
| **iCloud+**      | 2 To              | ~9,99 €              | Idéal pour utilisateurs Apple, respect vie privée |

---


#  Cas n°4 : Structure critique – Données sensibles

##  Type de cloud recommandé : **Cloud privé souverain** ou **cloud hybride sécurisé**

### Pourquoi éviter le cloud public ?
- Risques de **souveraineté**, **espionnage** ou **fuites de données**
- Besoin de **maîtrise physique et juridique** de l’infrastructure
- Respect des normes françaises de sécurité (ex. **SecNumCloud**, **ANSSI**)

---

##  Avantages du cloud privé souverain

- **Confidentialité** garantie
- **Conformité réglementaire** française ou européenne
- **Hébergement local** des données

---

##  Exemples de clouds souverains français

- **OVHcloud SecNumCloud**
- **Outscale** (Dassault Systèmes) – certifié **SecNumCloud**
- **Numspot** – initiative française récente
- **Cloud privé sur site** : VMware vSphere, OpenStack
- **Cloud hybride sécurisé** : combiner un cloud privé + cloud public **SecNumCloud-compatible**

---

##  Modèle XaaS recommandé : **IaaS + PaaS** (dans un cloud souverain)

| Type   | Usage                                                                 |
|--------|------------------------------------------------------------------------|
| **IaaS** | Déploiement d’environnements sur mesure, gestion des OS, virtualisation, sécurité |
| **PaaS** | Accélération du développement d’outils internes ou d’applications web |

---

##  Estimation du coût mensuel


| Ressource                                 | Estimation / mois      |
|-------------------------------------------|-------------------------|
| Cloud privé ou souverain hébergé          | 20 000 – 100 000 €      |
| Licences (VMware, OS, sécurité…)          | 10 000 – 30 000 €       |
| Maintenance & infogérance                 | 5 000 – 15 000 €        |
| Sécurité (firewalls, VPN, cloisonnement…) | ≥ 10 000 €              | 
| Développement / migration initiale        | 100 000 – 300 000 €     |

---

###  **Total estimé** :
**Plusieurs dizaines à centaines de milliers d’euros par mois**  
> Adapté aux **structures critiques** nécessitant **confidentialité**, **souveraineté** et **résilience maximale**


#  Cas n°5 : Site e-commerce simple

##  Type de cloud recommandé : **Cloud public**

### Pourquoi le cloud public ?
- Aucun besoin d’**infrastructure personnalisée complexe**
- Permet d’**héberger un site à faible coût**, rapidement, sans maintenance
- Hébergement **partagé** ou via **plateforme SaaS e-commerce** dans le cloud
- Solution idéale pour **se concentrer sur les ventes** sans gestion technique

---

##  Plateformes e-commerce compatibles

- **Shopify**
- **Wix**
- **PrestaShop Cloud**
- **WooCommerce** (avec hébergement sur **OVH**, **O2Switch**, etc.)

---

##  Modèle XaaS recommandé : **SaaS (Software as a Service)**

### Avantages du SaaS pour un e-commerce :
- Pas besoin de **gérer des serveurs**
- **Solution clé en main** : hébergement, design, paiement, gestion du catalogue
- Permet de se concentrer uniquement sur :
  - les **produits**
  - le **contenu**
  - le **marketing**
  - les **ventes**

---

##  Estimation des coûts mensuels

| Solution               | Prix mensuel      |
|------------------------|-------------------|
| **Shopify Basic**      | ~30 €/mois        |
| **Wix Business**       | ~20–30 €/mois     |
| **PrestaShop Cloud**   | ~30–50 €/mois     |
| **WooCommerce + hébergeur** | ~10–20 €/mois |

---

###  **Total estimé** : **entre 20 et 50 €/mois**  
> Pour un **site e-commerce fonctionnel**, **hébergé**, **personnalisable** et **prêt à vendre**

#  Cas n°6 : Plateforme DeliverEats – Commande et livraison de repas

##  Contexte

Développement d’une **plateforme de commande et de livraison de repas** avec :

- **Application client** (commande, paiement)
- **Application livreur** (navigation, réception commande)
- **Application restaurateur** (interface tablette)

### Exigences techniques

- Application **temps réel** → **latence critique**
- **Pic d’utilisation** pendant les heures de repas
- **Multi-appareil**, **multi-utilisateur**
- **Géolocalisation**, **notifications**, **base de données massive**

---

##  Architectures envisageables

### 🔸 A. Architecture **Cloud native 100% public**  
**Microservices sur PaaS + Serverless**

| Élément            | Technologie recommandée                     |
|--------------------|----------------------------------------------|
| **Cloud provider** | AWS / Azure / GCP                            |
| **Backend**        | Microservices – Node.js / Java / Python      |
| **Frontend**       | React / Flutter / Angular                    |
| **Base de données**| Scalable : Firebase, MongoDB Atlas, DynamoDB |
| **Notifications**  | Firebase Cloud Messaging, AWS SNS            |
| **Géolocalisation**| Google Maps API, Mapbox                      |
| **Serverless**     | AWS Lambda, Azure Functions                  |
| **CI/CD**          | GitHub Actions, GitLab CI/CD                 |

####  Avantages :
- **Scalabilité automatique** pour les heures de pointe
- **Faible coût** au lancement (Pay-as-you-go)
- **Mise en production rapide**
- Idéal pour le **temps réel** (WebSocket, API REST, Pub/Sub)

####  Inconvénients :
- **Dépendance** à un fournisseur cloud
- **Complexité** avec la multiplication des services
- Moins de **contrôle bas niveau** si optimisation fine requise

---

### 🔸 B. Architecture **Hybride** (cloud public + edge/local)

| Élément                  | Description                                                  |
|--------------------------|--------------------------------------------------------------|
| **Cloud public**         | Traitement des commandes, utilisateurs, paiements…           |
| **Edge/local apps**      | Pour restaurateurs/livreurs – fonctionnement offline possible |
| **Synchronisation**      | Dès retour de connexion réseau (sync différée)               |

####  Avantages :
- Résilience en cas de **perte de réseau**
- **Expérience offline** plus robuste
- Idéal pour les **zones mal couvertes**

####  Inconvénients :
- **Complexité technique** accrue (offline-first)
- **Coût** de synchronisation + déploiement local

---

### 🔸 C. Architecture **monolithique** hébergée (VM/IaaS)

| Élément                  | Description                                  |
|--------------------------|----------------------------------------------|
| **Infrastructure**       | IaaS : ex. EC2, Azure VM, etc.               |
| **Code**                 | Application centralisée, logique unifiée     |

####  Avantages :
- **Facile à démarrer**, simple pour une première version
- **Centralisation du code**

####  Inconvénients :
- Scalabilité horizontale **difficile**
- **Point de défaillance unique**
- Risque élevé en cas de **mise à jour**
- **Temps réel** difficile à gérer en cas de charge

---

##  Recommandation

###  **Architecture cloud native** (microservices + Serverless)

> C’est la **solution la plus adaptée** pour une plateforme comme DeliverEats :

- Absorbe facilement les **pics de charge** (midi, soir)
- Offre une **expérience utilisateur fluide en temps réel**
- **Évolutive** : permet d’ajouter facilement des modules (promos, avis, parrainage…)
- Optimale pour un **déploiement rapide**, flexible et moderne

#  Cas n°7 : Utilisation d’un CRM cloud

##  Type de cloud recommandé : **Cloud public**

### Pourquoi un cloud public ?
- **Accessibilité mondiale** depuis tout appareil connecté
- Évite les problématiques de **gestion d’infrastructure interne**
- Fournisseurs majeurs garantissent :
  - **Haute disponibilité**
  - **Sécurité**
  - **Conformité réglementaire (compliance)**
- **Facilité de déploiement** et **d’administration**

###  Fournisseurs possibles :
- **Google Cloud**
- **Amazon Web Services (AWS)**
- **Microsoft Azure**
- Services **SaaS tiers compatibles**, comme les **CRM cloud**

---

##  Modèle XaaS recommandé : **SaaS (Software as a Service)**

### Pourquoi le SaaS est adapté ?
- Pas besoin de **développer un CRM de zéro**
- CRM **prêts à l’emploi**, accessibles via **navigateur ou mobile**
- Fonctionnalités incluses :
  - Authentification
  - Sauvegardes automatiques
  - Gestion des accès
  - Intégration avec d’autres outils

---

##  Estimation du coût mensuel (par utilisateur)

| Solution                | Prix / mois / utilisateur | 
|-------------------------|----------------------------|
| **HubSpot CRM (base)**  | Gratuit                    |
| **Salesforce Essentials** | ~25 €/utilisateur         |
| **Zoho CRM**            | ~20 €/utilisateur          |
| **Microsoft Dynamics 365** | ~60 €/utilisateur       |

