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

echo -e "\n====== [POPULATOR] Inserindo dados mockados via Bulk API (200 tasks)... ======"
curl -X POST "http://$ES_HOST:9200/tasks/_bulk" -H 'Content-Type: application/json' --data-binary @- << EOF
{ "index" : { "_id" : "task-001" } }
{ "projectName": "E-commerce-Web", "description": "Configurar repositório inicial e pipeline de CI/CD", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-002" } }
{ "projectName": "E-commerce-Web", "description": "Criar componentes base do Design System no React", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-003" } }
{ "projectName": "E-commerce-Web", "description": "Implementar tela de login e integração com Auth0", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-004" } }
{ "projectName": "E-commerce-Web", "description": "Ajustar responsividade do header para dispositivos móveis", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-005" } }
{ "projectName": "E-commerce-Web", "description": "Adicionar skeleton loading na vitrine de produtos", "estimativeTime": "E2" }
{ "index" : { "_id" : "task-006" } }
{ "projectName": "E-commerce-Web", "description": "Desenvolver carrinho de compras usando Context API", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-007" } }
{ "projectName": "E-commerce-Web", "description": "Integrar busca de produtos com Algolia", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-008" } }
{ "projectName": "E-commerce-Web", "description": "Criar página de detalhes do produto com galeria de imagens", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-009" } }
{ "projectName": "E-commerce-Web", "description": "Corrigir bug de renderização no Safari iOS", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-010" } }
{ "projectName": "E-commerce-Web", "description": "Implementar checkout em múltiplas etapas", "estimativeTime": "E21" }
{ "index" : { "_id" : "task-011" } }
{ "projectName": "E-commerce-Web", "description": "Ajustar SEO (meta tags e Open Graph) das páginas de categoria", "estimativeTime": "E2" }
{ "index" : { "_id" : "task-012" } }
{ "projectName": "E-commerce-Web", "description": "Adicionar testes unitários no reducer do carrinho (Jest)", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-013" } }
{ "projectName": "E-commerce-Web", "description": "Otimizar tempo de carregamento com lazy loading de imagens", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-014" } }
{ "projectName": "E-commerce-Web", "description": "Implementar sistema de cupons de desconto no front-end", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-015" } }
{ "projectName": "E-commerce-Web", "description": "Configurar Google Analytics 4 via Tag Manager", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-016" } }
{ "projectName": "E-commerce-Web", "description": "Criar modal de recuperação de senha", "estimativeTime": "E2" }
{ "index" : { "_id" : "task-017" } }
{ "projectName": "E-commerce-Web", "description": "Reunião de planejamento da sprint (Planning)", "estimativeTime": "E1" }
{ "index" : { "_id" : "task-018" } }
{ "projectName": "E-commerce-Web", "description": "Revisar PRs pendentes do time de front-end", "estimativeTime": "E2" }
{ "index" : { "_id" : "task-019" } }
{ "projectName": "E-commerce-Web", "description": "Refatorar chamadas da API usando Axios interceptors", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-020" } }
{ "projectName": "E-commerce-Web", "description": "Atualizar dependências desatualizadas no package.json", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-021" } }
{ "projectName": "Mobile-App", "description": "Criar projeto base em React Native com TypeScript", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-022" } }
{ "projectName": "Mobile-App", "description": "Configurar navegação com React Navigation", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-023" } }
{ "projectName": "Mobile-App", "description": "Implementar splash screen nativa para iOS e Android", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-024" } }
{ "projectName": "Mobile-App", "description": "Integrar notificações push com Firebase Cloud Messaging", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-025" } }
{ "projectName": "Mobile-App", "description": "Criar tela de onboarding (carrossel animado)", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-026" } }
{ "projectName": "Mobile-App", "description": "Implementar biometria/FaceID para login rápido", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-027" } }
{ "projectName": "Mobile-App", "description": "Ajustar layout da bottom tab bar", "estimativeTime": "E2" }
{ "index" : { "_id" : "task-028" } }
{ "projectName": "Mobile-App", "description": "Cache offline de produtos com AsyncStorage", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-029" } }
{ "projectName": "Mobile-App", "description": "Adicionar leitor de código de barras para busca", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-030" } }
{ "projectName": "Mobile-App", "description": "Corrigir memory leak na lista infinita de produtos", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-031" } }
{ "projectName": "Mobile-App", "description": "Atualizar ícone do aplicativo e gerar assets", "estimativeTime": "E1" }
{ "index" : { "_id" : "task-032" } }
{ "projectName": "Mobile-App", "description": "Implementar deep linking para campanhas de marketing", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-033" } }
{ "projectName": "Mobile-App", "description": "Criar fluxo de avaliação na App Store/Play Store", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-034" } }
{ "projectName": "Mobile-App", "description": "Configurar fastlane para automação de deploy", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-035" } }
{ "projectName": "Mobile-App", "description": "Resolver conflitos de versão do Gradle", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-036" } }
{ "projectName": "Mobile-App", "description": "Testes end-to-end do fluxo de login com Detox", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-037" } }
{ "projectName": "Mobile-App", "description": "Adicionar modo noturno (Dark Mode)", "estimativeTime": "E21" }
{ "index" : { "_id" : "task-038" } }
{ "projectName": "Mobile-App", "description": "Ajustar permissões de câmera e galeria", "estimativeTime": "E2" }
{ "index" : { "_id" : "task-039" } }
{ "projectName": "Mobile-App", "description": "Implementar compartilhamento de produtos (Share API)", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-040" } }
{ "projectName": "Mobile-App", "description": "Reduzir tamanho final do bundle gerado (APK/AAB)", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-041" } }
{ "projectName": "Payment-Gateway", "description": "Integrar API da Stripe para processamento de cartão de crédito", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-042" } }
{ "projectName": "Payment-Gateway", "description": "Criar webhook para receber atualizações de status de pagamento", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-043" } }
{ "projectName": "Payment-Gateway", "description": "Implementar suporte a pagamentos via Pix", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-044" } }
{ "projectName": "Payment-Gateway", "description": "Validar assinatura do payload no webhook do provedor", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-045" } }
{ "projectName": "Payment-Gateway", "description": "Desenvolver rotina de conciliação bancária diária", "estimativeTime": "E21" }
{ "index" : { "_id" : "task-046" } }
{ "projectName": "Payment-Gateway", "description": "Salvar logs de requisição no Elasticsearch para auditoria", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-047" } }
{ "projectName": "Payment-Gateway", "description": "Criar endpoint de estorno (refund) parcial e total", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-048" } }
{ "projectName": "Payment-Gateway", "description": "Garantir idempotência nas chamadas de criação de cobrança", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-049" } }
{ "projectName": "Payment-Gateway", "description": "Ajustar máscara e validação de cartão no front-end", "estimativeTime": "E2" }
{ "index" : { "_id" : "task-050" } }
{ "projectName": "Payment-Gateway", "description": "Implementar retry com backoff exponencial para falhas de rede", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-051" } }
{ "projectName": "Payment-Gateway", "description": "Criptografar dados sensíveis em repouso (PCI Compliance)", "estimativeTime": "E21" }
{ "index" : { "_id" : "task-052" } }
{ "projectName": "Payment-Gateway", "description": "Adicionar suporte a pagamento com Apple Pay", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-053" } }
{ "projectName": "Payment-Gateway", "description": "Adicionar suporte a pagamento com Google Pay", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-054" } }
{ "projectName": "Payment-Gateway", "description": "Criar dashboard administrativo de transações diárias", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-055" } }
{ "projectName": "Payment-Gateway", "description": "Gerar relatório de repasses financeiros em CSV", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-056" } }
{ "projectName": "Payment-Gateway", "description": "Refatorar serviço de emissão de notas fiscais", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-057" } }
{ "projectName": "Payment-Gateway", "description": "Corrigir cálculo de taxas para parcelamento sem juros", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-058" } }
{ "projectName": "Payment-Gateway", "description": "Documentar a API de pagamentos usando Swagger", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-059" } }
{ "projectName": "Payment-Gateway", "description": "Testes de carga na rota principal de checkout", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-060" } }
{ "projectName": "Payment-Gateway", "description": "Atualizar chaves de produção nos cofres do AWS Secrets Manager", "estimativeTime": "E2" }
{ "index" : { "_id" : "task-061" } }
{ "projectName": "ERP-Internal", "description": "Modelagem de dados do módulo de controle de estoque", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-062" } }
{ "projectName": "ERP-Internal", "description": "Criar CRUD de fornecedores no painel administrativo", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-063" } }
{ "projectName": "ERP-Internal", "description": "Implementar controle de acesso baseado em roles (RBAC)", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-064" } }
{ "projectName": "ERP-Internal", "description": "Desenvolver funcionalidade de inventário rotativo", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-065" } }
{ "projectName": "ERP-Internal", "description": "Ajustar layout da tabela de listagem de produtos", "estimativeTime": "E2" }
{ "index" : { "_id" : "task-066" } }
{ "projectName": "ERP-Internal", "description": "Criar exportação em PDF de ordens de compra", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-067" } }
{ "projectName": "ERP-Internal", "description": "Integrar módulo de estoque com PDV físico", "estimativeTime": "E21" }
{ "index" : { "_id" : "task-068" } }
{ "projectName": "ERP-Internal", "description": "Adicionar alertas visuais para produtos com estoque baixo", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-069" } }
{ "projectName": "ERP-Internal", "description": "Corrigir erro ao salvar variações (tamanho/cor) de produtos", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-070" } }
{ "projectName": "ERP-Internal", "description": "Criar histórico de alterações de preço para auditoria", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-071" } }
{ "projectName": "ERP-Internal", "description": "Migrar banco de dados de MySQL 5.7 para PostgreSQL 14", "estimativeTime": "E21" }
{ "index" : { "_id" : "task-072" } }
{ "projectName": "ERP-Internal", "description": "Refatorar queries lentas no painel de vendas diárias", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-073" } }
{ "projectName": "ERP-Internal", "description": "Implementar sistema de multi-filiais (estoque separado)", "estimativeTime": "E21" }
{ "index" : { "_id" : "task-074" } }
{ "projectName": "ERP-Internal", "description": "Criar rotina de fechamento de caixa do dia", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-075" } }
{ "projectName": "ERP-Internal", "description": "Validar CNPJ na criação de novo cliente pessoa jurídica", "estimativeTime": "E2" }
{ "index" : { "_id" : "task-076" } }
{ "projectName": "ERP-Internal", "description": "Traduzir mensagens de erro do sistema para Espanhol", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-077" } }
{ "projectName": "ERP-Internal", "description": "Adicionar atalhos de teclado para inserção rápida de vendas", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-078" } }
{ "projectName": "ERP-Internal", "description": "Otimizar Dockerfile para reduzir tempo de build", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-079" } }
{ "projectName": "ERP-Internal", "description": "Escrever documentação técnica do módulo financeiro no Notion", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-080" } }
{ "projectName": "ERP-Internal", "description": "Testes de aceitação do módulo de cadastro com Cypress", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-081" } }
{ "projectName": "Data-Pipeline", "description": "Criar job no Apache Airflow para ingestão de dados do Salesforce", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-082" } }
{ "projectName": "Data-Pipeline", "description": "Configurar conector do Kafka para o Data Lake no S3", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-083" } }
{ "projectName": "Data-Pipeline", "description": "Limpeza e normalização de dados de clientes na camada Raw", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-084" } }
{ "projectName": "Data-Pipeline", "description": "Desenvolver script PySpark para cálculo de churn mensal", "estimativeTime": "E21" }
{ "index" : { "_id" : "task-085" } }
{ "projectName": "Data-Pipeline", "description": "Corrigir timezone nas agregações diárias do Redshift", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-086" } }
{ "projectName": "Data-Pipeline", "description": "Criar views materializadas para dashboards do Metabase", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-087" } }
{ "projectName": "Data-Pipeline", "description": "Implementar dbt (data build tool) para transformação de dados", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-088" } }
{ "projectName": "Data-Pipeline", "description": "Monitorar uso de disco do cluster EMR", "estimativeTime": "E2" }
{ "index" : { "_id" : "task-089" } }
{ "projectName": "Data-Pipeline", "description": "Anonimização de dados sensíveis (LGPD) na camada de analítica", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-090" } }
{ "projectName": "Data-Pipeline", "description": "Criar alerta no Slack para falhas na execução das DAGs", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-091" } }
{ "projectName": "Data-Pipeline", "description": "Integração de dados de campanhas do Facebook Ads via API", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-092" } }
{ "projectName": "Data-Pipeline", "description": "Integração de dados de campanhas do Google Ads via API", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-093" } }
{ "projectName": "Data-Pipeline", "description": "Otimização de custos no BigQuery particionando tabelas", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-094" } }
{ "projectName": "Data-Pipeline", "description": "Atualizar versão do Python e bibliotecas no ambiente do Airflow", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-095" } }
{ "projectName": "Data-Pipeline", "description": "Criar modelo preditivo básico para LTV de clientes", "estimativeTime": "E21" }
{ "index" : { "_id" : "task-096" } }
{ "projectName": "Data-Pipeline", "description": "Mapear dicionário de dados da tabela de transações", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-097" } }
{ "projectName": "Data-Pipeline", "description": "Configurar backup automatizado do metastore", "estimativeTime": "E2" }
{ "index" : { "_id" : "task-098" } }
{ "projectName": "Data-Pipeline", "description": "Implementar data quality checks com Great Expectations", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-099" } }
{ "projectName": "Data-Pipeline", "description": "Migrar scripts legados em bash para scripts Python nativos", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-100" } }
{ "projectName": "Data-Pipeline", "description": "Sincronização de base de usuários em tempo real via Change Data Capture (CDC)", "estimativeTime": "E21" }
{ "index" : { "_id" : "task-101" } }
{ "projectName": "HR-Portal", "description": "Criar módulo de avaliação de desempenho 360", "estimativeTime": "E21" }
{ "index" : { "_id" : "task-102" } }
{ "projectName": "HR-Portal", "description": "Implementar upload de atestados médicos com preview", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-103" } }
{ "projectName": "HR-Portal", "description": "Desenvolver calendário de férias e aprovações do gestor", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-104" } }
{ "projectName": "HR-Portal", "description": "Criar organograma interativo da empresa", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-105" } }
{ "projectName": "HR-Portal", "description": "Integrar API de assinatura eletrônica (DocuSign) para contratos", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-106" } }
{ "projectName": "HR-Portal", "description": "Painel de vagas abertas e acompanhamento de candidatos (ATS)", "estimativeTime": "E21" }
{ "index" : { "_id" : "task-107" } }
{ "projectName": "HR-Portal", "description": "Ajustar envio de email de boas-vindas para novos colaboradores", "estimativeTime": "E2" }
{ "index" : { "_id" : "task-108" } }
{ "projectName": "HR-Portal", "description": "Criar relatório de absenteísmo mensal exportável", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-109" } }
{ "projectName": "HR-Portal", "description": "Corrigir validação de horas extras no espelho de ponto", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-110" } }
{ "projectName": "HR-Portal", "description": "Permitir personalização do perfil do colaborador (foto, pronomes)", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-111" } }
{ "projectName": "HR-Portal", "description": "Criar webhook para desativar acessos na demissão", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-112" } }
{ "projectName": "HR-Portal", "description": "Adicionar mural de recados e aniversariantes do mês", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-113" } }
{ "projectName": "HR-Portal", "description": "Refatorar componente de formulário genérico para React Hook Form", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-114" } }
{ "projectName": "HR-Portal", "description": "Atualizar documentação de integração com folha de pagamento", "estimativeTime": "E2" }
{ "index" : { "_id" : "task-115" } }
{ "projectName": "HR-Portal", "description": "Criar API interna de feriados nacionais e regionais", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-116" } }
{ "projectName": "HR-Portal", "description": "Implementar controle de benefícios (Plano de saúde, VR, VA)", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-117" } }
{ "projectName": "HR-Portal", "description": "Testes unitários nos services do domínio de colaboradores", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-118" } }
{ "projectName": "HR-Portal", "description": "Melhorar acessibilidade (ARIA tags) na navbar", "estimativeTime": "E2" }
{ "index" : { "_id" : "task-119" } }
{ "projectName": "HR-Portal", "description": "Configurar pipeline de testes no GitHub Actions", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-120" } }
{ "projectName": "HR-Portal", "description": "Criar sistema de badges/reconhecimento entre pares", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-121" } }
{ "projectName": "Cloud-Migration", "description": "Mapear infraestrutura legada on-premise para Terraform", "estimativeTime": "E21" }
{ "index" : { "_id" : "task-122" } }
{ "projectName": "Cloud-Migration", "description": "Configurar VPC, Subnets públicas e privadas na AWS", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-123" } }
{ "projectName": "Cloud-Migration", "description": "Criar cluster Kubernetes (EKS) e node groups", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-124" } }
{ "projectName": "Cloud-Migration", "description": "Migrar banco de dados legado para Amazon RDS", "estimativeTime": "E21" }
{ "index" : { "_id" : "task-125" } }
{ "projectName": "Cloud-Migration", "description": "Implementar Ingress Controller e certificados SSL (Let's Encrypt)", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-126" } }
{ "projectName": "Cloud-Migration", "description": "Ajustar variáveis de ambiente para o novo ambiente Cloud", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-127" } }
{ "projectName": "Cloud-Migration", "description": "Configurar cluster de Redis (ElastiCache) para controle de sessão", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-128" } }
{ "projectName": "Cloud-Migration", "description": "Criar dashboards de monitoramento base no Datadog", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-129" } }
{ "projectName": "Cloud-Migration", "description": "Configurar alertas de consumo e billing na AWS", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-130" } }
{ "projectName": "Cloud-Migration", "description": "Migrar rotinas de cron para Kubernetes CronJobs", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-131" } }
{ "projectName": "Cloud-Migration", "description": "Testes de performance do novo banco de dados no cloud", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-132" } }
{ "projectName": "Cloud-Migration", "description": "Configurar rotas no Route53 e cutover do domínio", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-133" } }
{ "projectName": "Cloud-Migration", "description": "Estabelecer VPN Site-to-Site com o escritório HQ", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-134" } }
{ "projectName": "Cloud-Migration", "description": "Atualizar documentação de arquitetura no Confluence", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-135" } }
{ "projectName": "Cloud-Migration", "description": "Validar backups automáticos e retenção de snapshots no RDS", "estimativeTime": "E2" }
{ "index" : { "_id" : "task-136" } }
{ "projectName": "Cloud-Migration", "description": "Configurar IAM roles com Least Privilege", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-137" } }
{ "projectName": "Cloud-Migration", "description": "Implementar clusterização do Elasticsearch na nuvem", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-138" } }
{ "projectName": "Cloud-Migration", "description": "Criar bucket S3 público para assets estáticos e CloudFront", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-139" } }
{ "projectName": "Cloud-Migration", "description": "Desligar e arquivar servidores on-premise antigos", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-140" } }
{ "projectName": "Cloud-Migration", "description": "Reunião de post-mortem da migração", "estimativeTime": "E1" }
{ "index" : { "_id" : "task-141" } }
{ "projectName": "CRM-Integration", "description": "Pesquisa de viabilidade e limitações da API do HubSpot", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-142" } }
{ "projectName": "CRM-Integration", "description": "Criar microserviço em Node.js para atuar como middleware", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-143" } }
{ "projectName": "CRM-Integration", "description": "Sincronizar criação de novos leads em tempo real", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-144" } }
{ "projectName": "CRM-Integration", "description": "Tratar erro de rate limit na API do CRM (retry delay)", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-145" } }
{ "projectName": "CRM-Integration", "description": "Mapear campos customizados do nosso banco para as properties do HubSpot", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-146" } }
{ "projectName": "CRM-Integration", "description": "Implementar atualização bidirecional de status do lead", "estimativeTime": "E21" }
{ "index" : { "_id" : "task-147" } }
{ "projectName": "CRM-Integration", "description": "Criar script de carga inicial de contatos legados", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-148" } }
{ "projectName": "CRM-Integration", "description": "Garantir que descadastros (opt-out) se propaguem para o CRM", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-149" } }
{ "projectName": "CRM-Integration", "description": "Adicionar logs no Datadog para falhas de sincronização", "estimativeTime": "E2" }
{ "index" : { "_id" : "task-150" } }
{ "projectName": "CRM-Integration", "description": "Criar painel interno para forçar re-sincronização manual", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-151" } }
{ "projectName": "CRM-Integration", "description": "Sincronizar histórico de faturamento como Deal stage", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-152" } }
{ "projectName": "CRM-Integration", "description": "Atualizar tokens de autenticação Oauth2 rotineiramente", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-153" } }
{ "projectName": "CRM-Integration", "description": "Ajustar webhook de recebimento de mensagens enviadas pelo time de vendas", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-154" } }
{ "projectName": "CRM-Integration", "description": "Testar integração em ambiente de sandbox", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-155" } }
{ "projectName": "CRM-Integration", "description": "Escrever runbook para resolução de conflitos de sync", "estimativeTime": "E2" }
{ "index" : { "_id" : "task-156" } }
{ "projectName": "CRM-Integration", "description": "Mapear atribuição de vendedor (Owner ID)", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-157" } }
{ "projectName": "CRM-Integration", "description": "Validar telefone e email antes de enviar ao CRM para evitar dirty data", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-158" } }
{ "projectName": "CRM-Integration", "description": "Migrar autenticação para uso de Private App Tokens", "estimativeTime": "E2" }
{ "index" : { "_id" : "task-159" } }
{ "projectName": "CRM-Integration", "description": "Corrigir delay na criação do contato antes do Deal", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-160" } }
{ "projectName": "CRM-Integration", "description": "Adicionar testes de mutação (Stryker) no serviço de sync", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-161" } }
{ "projectName": "Marketing-Tools", "description": "Implementar gerador de links parametrizados (UTM builder) interno", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-162" } }
{ "projectName": "Marketing-Tools", "description": "Criar sistema de disparos de e-mail marketing com SendGrid", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-163" } }
{ "projectName": "Marketing-Tools", "description": "Desenvolver editor de templates HTML drag-and-drop", "estimativeTime": "E21" }
{ "index" : { "_id" : "task-164" } }
{ "projectName": "Marketing-Tools", "description": "Gerenciar descadastros via webhook do SendGrid", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-165" } }
{ "projectName": "Marketing-Tools", "description": "Testes A/B na engine de recomendação de produtos em e-mails", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-166" } }
{ "projectName": "Marketing-Tools", "description": "Criar landing page template para campanhas de Black Friday", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-167" } }
{ "projectName": "Marketing-Tools", "description": "Otimizar pontuação no Google PageSpeed Insights das landing pages", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-168" } }
{ "projectName": "Marketing-Tools", "description": "Integrar formulários com verificação de reCAPTCHA v3", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-169" } }
{ "projectName": "Marketing-Tools", "description": "Adicionar pixels de conversão do TikTok e Pinterest", "estimativeTime": "E2" }
{ "index" : { "_id" : "task-170" } }
{ "projectName": "Marketing-Tools", "description": "Automatizar criação de cupons via API para afiliados", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-171" } }
{ "projectName": "Marketing-Tools", "description": "Painel analítico de taxas de abertura e clique (CTR)", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-172" } }
{ "projectName": "Marketing-Tools", "description": "Corrigir renderização de e-mails em clientes Outlook antigos", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-173" } }
{ "projectName": "Marketing-Tools", "description": "Implementar pop-up de intenção de saída do site", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-174" } }
{ "projectName": "Marketing-Tools", "description": "Criar endpoint para capturar leads via chatbot de parceiros", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-175" } }
{ "projectName": "Marketing-Tools", "description": "Validar sintaxe e existência de domínios em e-mails cadastrados", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-176" } }
{ "projectName": "Marketing-Tools", "description": "Gerar sitemap.xml dinâmico atualizado diariamente", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-177" } }
{ "projectName": "Marketing-Tools", "description": "Implementar schema.org JSON-LD nas páginas de artigos do blog", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-178" } }
{ "projectName": "Marketing-Tools", "description": "Adicionar suporte a WebP no upload de imagens do CMS", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-179" } }
{ "projectName": "Marketing-Tools", "description": "Atualizar biblioteca de ícones vetoriais no pacote UI", "estimativeTime": "E1" }
{ "index" : { "_id" : "task-180" } }
{ "projectName": "Marketing-Tools", "description": "Monitorar quebra de links internos via crawler script", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-181" } }
{ "projectName": "Customer-Support-Bot", "description": "Modelagem de intenções básicas usando Dialogflow", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-182" } }
{ "projectName": "Customer-Support-Bot", "description": "Criar backend em Python/FastAPI para processar NLP", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-183" } }
{ "projectName": "Customer-Support-Bot", "description": "Implementar widget de chat flutuante no front-end", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-184" } }
{ "projectName": "Customer-Support-Bot", "description": "Integrar API de status de pedidos para respostas automáticas", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-185" } }
{ "projectName": "Customer-Support-Bot", "description": "Desenvolver funcionalidade de hand-off para atendente humano", "estimativeTime": "E21" }
{ "index" : { "_id" : "task-186" } }
{ "projectName": "Customer-Support-Bot", "description": "Salvar histórico de transcrição de chat no MongoDB", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-187" } }
{ "projectName": "Customer-Support-Bot", "description": "Configurar integração omnichannel com WhatsApp Business API", "estimativeTime": "E21" }
{ "index" : { "_id" : "task-188" } }
{ "projectName": "Customer-Support-Bot", "description": "Tratar formatação de quebra de linha nas mensagens do WhatsApp", "estimativeTime": "E2" }
{ "index" : { "_id" : "task-189" } }
{ "projectName": "Customer-Support-Bot", "description": "Criar fluxo automatizado para envio de 2ª via de boleto", "estimativeTime": "E8" }
{ "index" : { "_id" : "task-190" } }
{ "projectName": "Customer-Support-Bot", "description": "Identificar linguagem profana e bloquear remetente", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-191" } }
{ "projectName": "Customer-Support-Bot", "description": "Treinar modelo com base de conhecimento (FAQs) usando LLM open-source", "estimativeTime": "E21" }
{ "index" : { "_id" : "task-192" } }
{ "projectName": "Customer-Support-Bot", "description": "Implementar rate limit para evitar flood de mensagens no webhook", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-193" } }
{ "projectName": "Customer-Support-Bot", "description": "Ajustar som de notificação para nova mensagem no painel do agente", "estimativeTime": "E2" }
{ "index" : { "_id" : "task-194" } }
{ "projectName": "Customer-Support-Bot", "description": "Criar indicador visual (typing) enquanto o bot processa resposta", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-195" } }
{ "projectName": "Customer-Support-Bot", "description": "Gerar relatório semanal de tópicos mais perguntados", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-196" } }
{ "projectName": "Customer-Support-Bot", "description": "Permitir anexo de imagens e PDFs na janela do chat", "estimativeTime": "E13" }
{ "index" : { "_id" : "task-197" } }
{ "projectName": "Customer-Support-Bot", "description": "Compactar e otimizar imagens recebidas de clientes", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-198" } }
{ "projectName": "Customer-Support-Bot", "description": "Adicionar botões de quick-reply no chat da web", "estimativeTime": "E5" }
{ "index" : { "_id" : "task-199" } }
{ "projectName": "Customer-Support-Bot", "description": "Revisar logs de intents que falharam no fallback ('não entendi')", "estimativeTime": "E3" }
{ "index" : { "_id" : "task-200" } }
{ "projectName": "Customer-Support-Bot", "description": "Ajustar cache de sessão do usuário no Redis (TTL de 24h)", "estimativeTime": "E3" }

EOF

echo -e "\n====== [POPULATOR] Carga de 200 tasks finalizada! ======"