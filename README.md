# FLOW MANAGEMENT SYSTEM (FMS)

**FMS (Flow Management System)** é uma solução IoT desenvolvida por alunos de primeiro ano de Ciência da Computação da São Paulo Tech School para auxiliar gestores de restaurantes de rodízio de pizza a otimizar operações e aumentar o faturamento por meio de dados sobre o fluxo de clientes.

---

## 📋 Índice

- [Visão Geral do Projeto](#visão-geral-do-projeto)
- [Screenshots](#screenshots)
  - [Protótipo de Interface — Figma](#protótipo-de-interface--figma)
  - [Calculadora Financeira (ROI)](#calculadora-financeira-roi)
- [Protótipos](#protótipos)
  - [Simulador Financeiro (ROI)](#simulador-financeiro-roi)
- [Banco de Dados](#banco-de-dados)
- [Tecnologias Utilizadas](#tecnologias-utilizadas)
- [Como Usar os Protótipos](#como-usar-os-protótipos)
- [Estrutura de Arquivos](#estrutura-de-arquivos)
- [Equipe](#equipe)

---

## Visão Geral do Projeto

O FMS resolve um problema real enfrentado por restaurantes de rodízio: **a falta de dados sobre o fluxo de clientes**. Sem essas informações, a equipe de marketing não consegue identificar períodos de baixa demanda para lançar promoções estratégicas, e o estoque é mal gerenciado, gerando desperdício de insumos perecíveis.

A solução combina **hardware embarcado (Arduino + sensores ultrassônicos)** com uma **plataforma web de dashboards** que apresenta os dados coletados de forma clara e acionável.

**Problema central:** Restaurantes de pizza no sistema de rodízio operam com margem de lucro apertada (~11% do faturamento). Sem dados de fluxo, campanhas de marketing são mal cronometradas, e recursos são desperdiçados em horários de baixo movimento.

**Solução:** Sensores instalados no teto do restaurante coletam dados de presença (binário: 0 = ausente, 1 = presente) e os enviam a um sistema web que gera dashboards, mapas de calor e alertas de movimentação, permitindo decisões de marketing embasadas em dados reais.

---

## Screenshots

> 📌 **Instrução para a equipe:** substitua os blocos abaixo pelas imagens reais. Para adicionar uma imagem, salve o arquivo na pasta `docs/screenshots/` e atualize o caminho no markdown. Exemplo: `![alt](docs/screenshots/nome-do-arquivo.png)`

### Protótipo de Interface — Figma

Telas do protótipo de alta fidelidade desenvolvido no Figma, cobrindo os principais fluxos da aplicação web: login, dashboard principal, mapa de calor e tela de alertas.

#### Tela de Login
<!-- Substitua pelo caminho da imagem: docs/screenshots/figma-login.png -->
```
[ screenshot — tela de login ]
```
<img src="https://res.cloudinary.com/dleo9ipkq/image/upload/v1772935049/tela_login-2_dqzty8.png">
---

#### Dashboard Principal
<!-- Substitua pelo caminho da imagem: docs/screenshots/figma-dashboard.png -->
```
[ screenshot — dashboard principal com gráficos de fluxo ]
```
![Dashboard Principal](docs/screenshots/figma-dashboard.png)

---

#### Mapa de Calor
<!-- Substitua pelo caminho da imagem: docs/screenshots/figma-heatmap.png -->
```
[ screenshot — mapa de calor dos setores do restaurante ]
```
![Mapa de Calor](docs/screenshots/figma-heatmap.png)

---

#### Tela de Alertas
<!-- Substitua pelo caminho da imagem: docs/screenshots/figma-alertas.png -->
```
[ screenshot — painel de alertas de movimentação ]
```
![Alertas](docs/screenshots/figma-alertas.png)

---

> 🔗 **Link do Figma:** [Adicione aqui o link de visualização do projeto no Figma](https://figma.com)

---

### Calculadora Financeira (ROI)

Capturas de tela do simulador financeiro em funcionamento, mostrando o formulário de entrada e os resultados calculados.

#### Formulário de Entrada
<!-- Substitua pelo caminho da imagem: docs/screenshots/calc-formulario.png -->
```
[ screenshot — formulário com campos preenchidos ]
```
![Formulário da Calculadora](docs/screenshots/calc-formulario.png)

---

#### Resultado do Cálculo — ROI Positivo
<!-- Substitua pelo caminho da imagem: docs/screenshots/calc-resultado-positivo.png -->
```
[ screenshot — resultado com ROI positivo (valores em verde) ]
```
![Resultado ROI Positivo](docs/screenshots/calc-resultado-positivo.png)

---

#### Resultado do Cálculo — ROI Negativo
<!-- Substitua pelo caminho da imagem: docs/screenshots/calc-resultado-negativo.png -->
```
[ screenshot — resultado com ROI negativo no primeiro dia (valores em vermelho) ]
```
![Resultado ROI Negativo](docs/screenshots/calc-resultado-negativo.png)

---

## Protótipos

### Simulador Financeiro (ROI)

**Arquivo:** `simulador_financeiroV2.html`

O Simulador Financeiro é uma ferramenta web standalone que permite ao potencial cliente do FMS **calcular o retorno sobre investimento (ROI)** esperado ao adotar o sistema em seu restaurante.

#### Funcionalidade

O simulador coleta os seguintes dados do usuário:

| Campo | Descrição |
|---|---|
| Qtd. de investimentos mensais em marketing | Frequência com que o usuário faz ações de marketing por mês |
| Metragem do estabelecimento (m²) | Usada para calcular o número de sensores necessários e o custo de instalação |
| Ticket médio (R$) | Valor médio gasto por cliente no restaurante |
| Fluxo médio de clientes (dia) | Quantidade de clientes em um dia de movimento normal |
| Fluxo baixo de clientes (dia) | Quantidade de clientes em um dia de baixo movimento |

#### Lógica de Cálculo

A lógica central do simulador está na função `calcular()` (`simulador_financeiroV2.html`).

**1. Estimativa de sensores e custo de instalação:**
```js
let qtdSensores = tmhEstabelecimento / 18        // 1 sensor a cada 18 m²
let valorInstalacao = (qtdSensores * 50) + 500   // R$50 por sensor + R$500 de instalação base
```

**2. Mensalidade por porte do estabelecimento:**
```js
if (tmhEstabelecimento <= 200)       mensalidade = 300   // Pequeno porte
else if (tmhEstabelecimento <= 400)  mensalidade = 500   // Médio porte
else                                 mensalidade = 800   // Grande porte
```

**3. Cálculo de lucro e ROI:**
```js
faturamentoBruto    = (mediaFluxo - baixaFluxo) * ticketMedio  // Ganho incremental por campanha
lucroBase           = faturamentoBruto * 0.11                  // Margem do rodízio (~11%)
lucroLiquidoDiario  = lucroBase - (lucroBase / 5)              // Desconto de 20% de custos variáveis

// ROI por período
roiDIARIO  = ((lucroLiquidoDiario - valorInstalacao) / valorInstalacao) * 100
roiMENSAL  = ((lucroMes - custoM) / custoM) * 100             // custoM = instalação + mensalidade
roiANUAL   = ((lucroAno - custoA) / custoA) * 100             // custoA = instalação + (mensalidade * 12)
```

**4. Apresentação dos resultados:**
O resultado é exibido com formatação visual dinâmica: valores positivos em **verde** e negativos em **vermelho**, facilitando a leitura imediata do resultado financeiro.

#### Exemplo de Saída

```
Serão necessários 6 sensores para abranger a área de seu restaurante,
o orçamento para a instalação do FMS no seu rodízio é de R$ 800,00.

No primeiro dia:  R$ 242,00  | ROI: -69%
No primeiro mês:  R$ 968,00  | ROI: 14%
No primeiro ano:  R$ 11.616,00 | ROI: 512%
```

> **Nota:** O ROI negativo no primeiro dia é esperado, pois reflete o custo de instalação concentrado. O retorno positivo se materializa ao longo do tempo com as campanhas recorrentes.

---

## Banco de Dados

**Arquivo:** `banco_dados/fluxo_pessoas_banco_dados.sql`

O script SQL define a estrutura de dados completa do FMS em MySQL. O schema é composto por 7 tabelas principais:

### Diagrama de Entidades

```
endereco ──── empresa ──── usuario
                │
              bloco
                │
             sensor
                │
          sensor_evento
                │
             alerta
```

### Tabelas

| Tabela | Descrição |
|---|---|
| `endereco` | Armazena o endereço físico de cada empresa/restaurante |
| `empresa` | Dados cadastrais do restaurante (CNPJ, razão social, contato) |
| `usuario` | Administradores com acesso ao sistema (login restrito) |
| `bloco` | Setores físicos do restaurante (entrada, ambiente, saída) |
| `sensor` | Sensores cadastrados, vinculados a um bloco |
| `sensor_evento` | Registros de cada detecção (0/1) com timestamp e duração |
| `alerta` | Alertas gerados automaticamente com base na movimentação |

### Queries Utilitárias Incluídas

O script inclui consultas prontas para os principais casos de uso do sistema:

```sql
-- Atividade dos sensores em uma hora específica
SELECT data_evento, duracao, sensor_id, detectado
FROM sensor_evento
WHERE data_evento BETWEEN "2026-10-11 13:00:00" AND "2026-10-11 13:59:59";

-- Áreas com mais movimento no dia (sensor detectando presença)
SELECT data_evento, duracao, sensor_id
FROM sensor_evento
WHERE detectado = 1 AND data_evento BETWEEN '...' AND '...'
ORDER BY duracao;

-- Alertas de baixa movimentação
SELECT descricao, tipo, sensor_evento_id, data_alerta
FROM alerta
WHERE tipo = 'baixa movimentação';
```

### Tipos de Alerta

O sistema emite 3 níveis de alerta baseados nos dados dos sensores:

- `baixa movimentação` — Momento ideal para acionar campanhas de marketing
- `movimentação moderada` — Operação dentro do esperado
- `alta movimentação` — Pico de clientes, considerar otimização operacional

---

## Tecnologias Utilizadas

| Camada | Tecnologia |
|---|---|
| Hardware | Arduino + Sensores Ultrassônicos |
| Banco de Dados | MySQL |
| Frontend (protótipo) | HTML5 + JavaScript (Vanilla) |
| Dashboard (previsto) | Aplicação Web com gráficos e mapas de calor |
| Comunicação sensor → sistema | IoT (protocolo a definir) |

---

## Como Usar os Protótipos

### Simulador Financeiro

1. Abra o arquivo `simulador_financeiroV2.html` diretamente no navegador (não requer servidor).
2. Preencha todos os campos do formulário com os dados do seu restaurante.
3. Clique em **"Calcule o ROI"**.
4. O resultado exibirá o lucro estimado e o ROI para o primeiro dia, mês e ano de uso do FMS.

> ⚠️ **Atenção:** O campo de metragem é obrigatório. Caso não seja preenchido, o sistema exibirá um alerta solicitando a informação.

### Banco de Dados

1. Certifique-se de ter o MySQL instalado.
2. Execute o script completo:
```bash
mysql -u root -p < banco_dados/fluxo_pessoas_banco_dados.sql
```
3. O banco `fluxo_pessoas` será criado com todas as tabelas e dados de exemplo já inseridos.
4. As queries de consulta estão comentadas ao final do arquivo e podem ser executadas individualmente.

---

## Estrutura de Arquivos

```
FLOW_MANAGEMENT_SYSTEM/
│
├── README.md                          # Esta documentação
│
├── docs/
│   └── screenshots/                   # Capturas de tela dos protótipos
│       ├── figma-login.png            # Tela de login (Figma)
│       ├── figma-dashboard.png        # Dashboard principal (Figma)
│       ├── figma-heatmap.png          # Mapa de calor (Figma)
│       ├── figma-alertas.png          # Painel de alertas (Figma)
│       ├── calc-formulario.png        # Calculadora — formulário
│       ├── calc-resultado-positivo.png# Calculadora — ROI positivo
│       └── calc-resultado-negativo.png# Calculadora — ROI negativo
│
├── simulador_financeiroV2.html        # Protótipo: Simulador de ROI
│
└── banco_dados/
    └── fluxo_pessoas_banco_dados.sql  # Schema MySQL + dados de exemplo + queries
```

---

## Roadmap do Projeto

| Etapa | Duração | Status |
|---|---|---|
| Levantamento de requisitos | 20 dias | ✅ Concluído |
| Desenvolvimento | 70 dias | 🔄 Em andamento |
| Testes e homologação | 18 dias | ⏳ Pendente |
| Implantação | 2 dias | ⏳ Pendente |
| Acompanhamento pós-implantação | 10 dias | ⏳ Pendente |

---

## Equipe

| Nome | RA |
|---|---|
| Daniel da Silva Ramos Bueno | 04261051 |
| Eduardo Pereira de Queiroz | 04261102 |
| Gabriel Silva Carrara | 04261026 |
| João Vitor da Silva Rodrigues | 04261100 |
| Kevin Augusto Zancle Pereira | 04261065 |
| Lucas Nogueira Buono de Albuquerque | 04261145 |
| Matheus da Silva Rosa | 04261143 |
| Vinicius Faria Cerqueira | 04261107 |

**Orientadores:** Prof. Julia · Prof. Marcos  
**Instituição:** São Paulo Tech School — Faculdade de Tecnologia  
**Ano:** 2026
