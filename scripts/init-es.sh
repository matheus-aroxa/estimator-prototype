#!/bin/bash

ES_HOST=${1:-localhost}

echo "====== [POPULATOR] Aguardando Elasticsearch em $ES_HOST:9200 ======"
until curl -s http://$ES_HOST:9200 >/dev/null; do
    sleep 2
done

echo "====== [POPULATOR] Resetando indice 'tasks'... ======"
curl -X DELETE "http://$ES_HOST:9200/tasks" -s >/dev/null

echo "====== [POPULATOR] Criando novo indice 'tasks'... ======"
curl -X PUT "http://$ES_HOST:9200/tasks" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0
  }
}'

echo -e "\n====== [POPULATOR] Inserindo dados mockados via Bulk API... ======"
curl -X POST "http://$ES_HOST:9200/tasks/_bulk" -H 'Content-Type: application/json' --data-binary @- << EOF
{ "index" : { "_id" : "task-01" } }
{ "projectName": "PJe-Correição", "description": "Implementar tela de listagem de processos parados", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-02" } }
{ "projectName": "PJe-Correição", "description": "Correção de bug no carregamento do token da assinatura digital", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-03" } }
{ "projectName": "PJe-Correição", "description": "Criação de índices de banco de dados para otimizar busca de réus", "estimativeTime": "E2" }
{ "index" : { "_id" : "task-04" } }
{ "projectName": "Projudi-Migracao", "description": "Mapeamento dos campos de histórico de movimentação processual", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-05" } }
{ "projectName": "Projudi-Migracao", "description": "Desenvolvimento do script de extração de metadados de PDFs", "estimativeTime": "E21" }
{ "index" : { "_id" : "task-06" } }
{ "projectName": "Projudi-Migracao", "description": "Validar carga inicial em ambiente de homologação", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-07" } }
{ "projectName": "Sistemática-Custas", "description": "Homologar novos códigos de barras com o Banco do Brasil", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-08" } }
{ "projectName": "Sistemática-Custas", "description": "Ajustar cálculo de juros moratórios para precatórios acumulados", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-09" } }
{ "projectName": "Sistemática-Custas", "description": "Atualizar label explicativo no rodapé da guia de recolhimento", "estimativeTime": "E1" }
{ "index" : { "_id" : "task-10" } }
{ "projectName": "Sistemática-Custas", "description": "Reunião de alinhamento com a Corregedoria Geral", "estimativeTime": "E0" }
{ "index" : { "_id" : "task-11" } }
{ "projectName": "Portal-TJPE", "description": "Refatorar CSS do menu de acessibilidade para conformidade com eMAG", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-12" } }
{ "projectName": "Portal-TJPE", "description": "Subir patch de segurança do CMS para ambiente de produção", "estimativeTime": "E2" }
{ "index" : { "_id" : "task-13" } }
{ "projectName": "Balcao-Virtual", "description": "Integrar API de videoconferência com o Microsoft Teams", "estimativeTime": "E21" }
{ "index" : { "_id" : "task-14" } }
{ "projectName": "Balcao-Virtual", "description": "Criar fila de espera visual para os advogados aguardando atendimento", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-15" } }
{ "projectName": "Balcao-Virtual", "description": "Corrigir vazamento de memória na desconexão do WebRTC", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-16" } }
{ "projectName": "Calculadora-Pena", "description": "Modelagem inicial do grafo de regras de progressão de regime", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-17" } }
{ "projectName": "Calculadora-Pena", "description": "Implementar input de interrupção por cometimento de falta grave", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-18" } }
{ "projectName": "Calculadora-Pena", "description": "Ajustar testes unitários do cálculo de detração penal", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-19" } }
{ "projectName": "Inteligencia-Artificial-Vera", "description": "Treinar modelo de NLP para classificação de petições iniciais de saúde", "estimativeTime": "E21" }
{ "index" : { "_id" : "task-20" } }
{ "projectName": "Inteligencia-Artificial-Vera", "description": "Expor endpoint REST para recebimento de texto bruto da petição", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-21" } }
{ "projectName": "Inteligencia-Artificial-Vera", "description": "Criar dashboard no Kibana para monitorar acurácia das predições", "estimativeTime": "E8" }

EOF

echo -e "\n====== [POPULATOR] Carga finalizada! ======"