#  Infrastructure InfoLine avec Terraform

# Description

Projet ECF Bloc 1 - Administrateur Système DevOps  
Déploiement automatisé d'une infrastructure Azure complète avec Terraform.

#  Infrastructure déployée

- ✅ **Cluster Kubernetes (AKS)** : 2 nodes Standard_B2s
- ✅ **Azure Function App** : Service serverless d'authentification (Node.js 18)
- ✅ **Storage Account** : Stockage pour Azure Functions
- ✅ **App Service Plan** : Plan Consumption (Y1)
- ✅ **Clés SSH** : Générées automatiquement

# Technologies utilisées

- Terraform 1.13.4
- Azure Cloud
- Kubernetes (AKS)
- Azure Functions
- PowerShell

## 📁 Structure du projet

ECF_Infoline_Terraform/
  - terraform/
      - provider.tf       (Configuration des providers Azure)
      - variables.tf      (Variables paramétrables)
      - main.tf           (Infrastructure principale - AKS + Functions)
      - ssh.tf            (Génération automatique des clés SSH)
      - outputs.tf        (Informations affichées après déploiement)
      - terraform.tfvars  (Valeurs des variables - non publié)
      - .gitignore        (Fichiers à ne pas publier)
      - README.md         (Documentation technique)
  

# Déploiement

# Prérequis
- Terraform 1.0+
- Azure CLI
- kubectl
- Compte Azure actif

# Étapes

1. *Connexion à Azure*
```bash
az login
```

2. *Configuration*
```bash
cd terraform
# Créer terraform.tfvars avec votre Subscription ID
```

3. *Initialisation*
```bash
terraform init
```

4. *Validation*
```bash
terraform validate
```

5. *Planification*
```bash
terraform plan
```

6. *Déploiement*
```bash
terraform apply
```

# Coûts estimés

- **Total mensuel** : ~75-95€
  - AKS Control Plane : Gratuit
  - 2x Nodes Standard_B2s : ~50-60€
  - Azure Functions : ~0-5€
  - Storage Account : ~1-2€
  - Load Balancer : ~15-20€

# Suppression
```bash
terraform destroy
```

# Sécurité

- ✅ Clés SSH générées automatiquement
- ✅ System Assigned Identity pour AKS
- ✅ .gitignore protège les fichiers sensibles
- ✅ terraform.tfvars avec Id Azure non publié sur GitHub

# Auteur

*Baroni Pierre*
Email : [Pierre.baroni@free.fr]  
Formation : Administrateur Système DevOps  
ECF Bloc 1 - Novembre 2025

# Documentation utilisée

- [Terraform](https://www.terraform.io/docs)
- [Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure AKS](https://learn.microsoft.com/azure/aks/)
