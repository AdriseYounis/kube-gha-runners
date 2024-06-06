resource "kubernetes_namespace" "cm" {
  metadata {
    name = "cert-manager"
  }
}

resource "helm_release" "cert_manager" {
  chart      = "cert-manager"
  name       = "cert-manager"
  namespace  = kubernetes_namespace.cm.metadata[0].name
  repository = "https://charts.jetstack.io"
  version    = "v1.13.3"
  timeout    = 600
  atomic     = true

  set {
    name  = "global.logLevel"
    value = "3"
  }

  set {
    name  = "global.podSecurityPolicy.enabled"
    value = "true"
  }

  set {
    name  = "global.podSecurityPolicy.useAppArmor"
    value = "true"
  }

  set {
    name  = "installCRDs"
    value = "true"
  }
}