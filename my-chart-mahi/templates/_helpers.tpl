{{/*
    Expand the name of the chart.
    */}}
    {{- define "my-chart-mahi.name" -}}
    {{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
    {{- end }}
    
    {{/*
    Create a default fully qualified app name.
    */}}
    {{- define "my-chart-mahi.fullname" -}}
    {{- if .Values.fullnameOverride }}
      {{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
    {{- else }}
      {{- $name := default .Chart.Name .Values.nameOverride }}
      {{- if contains $name .Release.Name }}
        {{- .Release.Name | trunc 63 | trimSuffix "-" }}
      {{- else }}
        {{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
      {{- end }}
    {{- end }}
    {{- end }}
    
    {{/*
    Create chart name and version as used by the chart label.
    */}}
    {{- define "my-chart-mahi.chart" -}}
    {{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
    {{- end }}
    
    {{/*
    Common labels for Kubernetes resources.
    */}}
    {{- define "my-chart-mahi.labels" -}}
    helm.sh/chart: {{ include "my-chart-mahi.chart" . }}
    {{ include "my-chart-mahi.selectorLabels" . }}
    {{- if .Chart.AppVersion }}
      app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
    {{- end }}
    app.kubernetes.io/managed-by: {{ .Release.Service }}
    {{- end }}
    
    {{/*
    Selector labels for resources.
    */}}
    {{- define "my-chart-mahi.selectorLabels" -}}
    app.kubernetes.io/name: {{ include "my-chart-mahi.name" . }}
    app.kubernetes.io/instance: {{ .Release.Name }}
    {{- end }}
    
    {{/*
    Create the name of the service account to use.
    */}}
    {{- define "my-chart-mahi.serviceAccountName" -}}
    {{- if .Values.serviceAccount.create }}
      {{- default (include "my-chart-mahi.fullname" .) .Values.serviceAccount.name }}
    {{- else }}
      {{- default "default" .Values.serviceAccount.name }}
    {{- end }}
    {{- end }}
    
