# Estimador de Tarefas com IA Local (Protótipo) 🚀

Este projeto consiste de um serviço projetado para estimar o tempo necessário (em horas) para a implementação de tarefas de desenvolvimento de software, baseado em dados de tasks anteriores, utilizando **LLM**. 

A solução adota uma abordagem **privacy-first (foco em privacidade)** e custo zero, utilizando o **Spring AI** para se comunicar com Grandes Modelos de Linguagem (LLMs). O sistema utiliza a técnica de **Few-Shot Prompting** para enriquecer o contexto do modelo com exemplos reais de tarefas passadas semelhantes, armazenados e filtrados utilizando **Elasticsearch** garantindo alta precisão nas estimativas.

---

## 🏗️ Arquitetura e Fluxo de Dados

O serviço atua como um orquestrador seguro entre as entradas de dados do usuário e o motor de inferência local.

### Pilares Técnicos:
1. **Custo Otimizado com Cota Gratuita / Pay-per-Use:** Substituição de infraestruturas locais complexas (que exigiriam hardware caro com GPUs dedicadas) pelo modelo serverless do Gemini. A solução aproveita o modelo de precificação flexível por volume de tokens, viabilizando o uso do protótipo dentro de limites de desenvolvimento sem custos proibitivos.
2. **Higienização Ativa de Prompts (`PromptSanitizer`):** Um pipeline defensivo baseado em Expressões Regulares (Regex) intercepta o texto antes de enviá-lo à IA. Ele mascara de forma insensível a maiúsculas/minúsculas chaves de configuração, emails, tokens de API e variáveis de ambiente complexas (como `minimum-idle=x` ou `minimum_idle=x`).
3. **Saída Estruturada com Java Records:** O Spring AI garante que a resposta do modelo não seja um texto genérico, mas sim mapeada diretamente para um objeto estruturado Java (`TaskEstimate`), pronto para consumo.

---

## 🛠️ Stack Tecnológica

- **Linguagem:** Java 21
- **Framework Principal:** Spring Boot 4.0.6
- **Framework de IA:** Spring AI
- **LLM Padrão:** `gemini-2.5-flash`

---

## 🚀 Como Executar o Projeto

### 1. Configuração do Ambiente de IA (Ollama)
Certifique-se de ter o Docker instalado na sua máquina.

1. Execute o comando
    ```bash
    docker compose up --build

## Configuração da Aplicação
Crie um arquivo .env na raiz do projeto e defina as variaveis de ambiente. ex) .env.dev

## 📈 Estratégia de Escalabilidade para Produção
Ao apresentar este protótipo para a equipe de arquitetura ou planejar a ida para produção, os seguintes pontos devem ser considerados:

1. Bancos de Dados Vetoriais (Vector Stores): Evoluir a busca por tarefas semelhantes de consultas SQL simples baseadas em palavras-chave para buscas semânticas vetoriais utilizando o módulo VectorStore do Spring AI (ex: integrado ao PostgreSQL com pgvector ou índices vetoriais do Elasticsearch).

2. Cache Distribuído: Implementar cache distribuído (Spring Cache backed por Redis) para evitar requisições repetidas idênticas ao LLM, otimizando o tempo de resposta e o uso de hardware.
