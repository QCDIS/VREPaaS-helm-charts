{{/*
Expand the name of the chart.
*/}}
{{- define "vreapp.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "vreapp.fullname" -}}
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
{{- define "vreapp.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "vreapp.labels" -}}
helm.sh/chart: {{ include "vreapp.chart" . }}
{{ include "vreapp.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "vreapp.selectorLabels" -}}
app.kubernetes.io/name: {{ include "vreapp.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "vreapp.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "vreapp.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Pick up base path from ingress configuration
*/}}
{{- define "vreapp.basePath" -}}
  {{- $hosts := .Values.ingress.hosts }}
  {{- if eq (len $hosts) 0 }}
    {{- printf "" }}
  {{- else if eq (len $hosts) 1 }}
    {{- $paths := (first $hosts).paths }}
    {{- if eq (len $paths) 1 }}
      {{- printf ((first $paths).path | clean) }}
    {{- else }}
      {{- fail ".Values.ingress.hosts[0].paths must contain exactly one element" }}
    {{- end }}
  {{- else }}
    {{- fail ".Values.ingress.hosts must contain at most one element" }}
  {{- end }}
{{- end }}
