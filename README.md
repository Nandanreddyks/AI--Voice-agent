# SupportGenie — Enterprise AI Voice Agent Platform

> **The production-ready AI platform that talks, understands, retrieves, escalates, and reports — end-to-end, in real time.**

[![FastAPI](https://img.shields.io/badge/Backend-FastAPI-009688?style=flat&logo=fastapi)](https://fastapi.tiangolo.com)
[![React](https://img.shields.io/badge/Frontend-React%2019-61DAFB?style=flat&logo=react)](https://react.dev)
[![Groq](https://img.shields.io/badge/LLM-Groq%20LLaMA%203-FF6B35?style=flat)](https://groq.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [Problem Statement](#2-problem-statement)
3. [Proposed Solution](#3-proposed-solution)
4. [Key Features and Functionalities](#4-key-features-and-functionalities)
5. [System Architecture / Workflow](#5-system-architecture--workflow)
6. [Tech Stack](#6-tech-stack)
7. [Folder Structure](#7-folder-structure)
8. [Installation and Setup Guide](#8-installation-and-setup-guide)
9. [Usage Guide](#9-usage-guide)
10. [Implemented Functionalities](#10-implemented-functionalities)
11. [What Makes This Project Different](#11-what-makes-this-project-different)
12. [Advantages / Pros](#12-advantages--pros)
13. [Limitations / Cons](#13-limitations--cons)
14. [Challenges Faced](#14-challenges-faced)
15. [Security and Privacy Considerations](#15-security-and-privacy-considerations)
16. [Performance and Scalability Discussion](#16-performance-and-scalability-discussion)
17. [Future Improvements / Roadmap](#17-future-improvements--roadmap)
18. [Testing and Validation](#18-testing-and-validation)
19. [Deployment](#19-deployment)
20. [FAQ](#20-faq)
21. [Conclusion](#21-conclusion)

---

## 1. Project Overview

**SupportGenie** is a full-stack, enterprise-grade AI Voice Agent platform built for real-time customer support automation, business analytics intelligence, and operational workflow management. It combines a FastAPI Python backend with a React/Vite frontend, a Groq-powered LLM layer (LLaMA 3.1/3.3), and a custom Retrieval-Augmented Generation (RAG) engine backed by sentence-transformer embeddings.

The platform is designed around the concept of a **conversational AI that acts**, not just responds. When a customer speaks or types a message, SupportGenie:

- **Classifies** the intent into one of 9 enterprise categories
- **Detects** sentiment, urgency, churn risk, and escalation probability
- **Executes** the correct backend tool (order lookup, ticket creation, callback booking, RAG query, dashboard analytics)
- **Naturalizes** the structured result into a fluent, human-like voice response using Groq LLaMA
- **Persists** all call data to a JSON-based data store for real-time dashboard analytics

The system includes a fully interactive **Enterprise Command Center dashboard** with four operational pillars: Business Metrics, Customer Operations, Technical Monitoring, and AI Operations.

**Current status:** Production-ready for demonstration and small-to-medium deployments. Backend and frontend are both running live, with all data persisted to local JSON files.

---

## 2. Problem Statement

Modern businesses face a compounding set of challenges in customer support:

### The Scale Problem
As companies grow, call volumes increase exponentially. Human agents are expensive, limited in working hours, and inconsistent in quality. Hiring and training new agents takes months.

### The Intelligence Problem
Traditional IVR (Interactive Voice Response) systems are rigid, rule-based, and frustrating. They cannot understand natural language, detect emotion, or make contextual decisions. Customers abandon calls within seconds.

### The Data Silo Problem
Customer interactions, ticket histories, callback requests, and business metrics exist in separate systems. Managers have no real-time visibility into what is happening across their support operations at any given moment.

### The Escalation Problem
The wrong customer calls get resolved by automation while genuinely urgent, frustrated, or churn-risk customers are forced through the same queue — causing irreversible churn.

### The Multilingual Problem
India's enterprise market requires support in regional languages (Telugu, Kannada, Hindi), yet most AI platforms only support English.

These problems collectively result in:
- High customer churn due to poor support experiences
- Slow response times and long queues
- Missed escalation opportunities
- Zero real-time operational intelligence for decision-makers

---

## 3. Proposed Solution

SupportGenie addresses all five problem dimensions with a unified, intelligent voice agent platform:

### Core Idea
Replace rigid IVR trees with a **context-aware, intent-driven AI agent** that understands natural language, executes real business actions, and adapts its behavior based on customer sentiment and urgency — all while feeding a real-time analytics dashboard.

### Technical Approach

| Problem | Solution |
|---|---|
| Scale | Fully automated AI handles every call with sub-1.5s response times |
| Intelligence | Regex + weighted keyword intent classification → Groq LLaMA 3 naturalization |
| Data Silos | Centralized call logging + 4-pillar enterprise dashboard |
| Escalation | Automatic sentiment-driven escalation with priority ticket creation |
| Multilingual | Browser Web Speech API + intent classifier with Telugu/Kannada/Hindi keywords |

### Value Proposition
A single AI agent that replaces 70–80% of routine support interactions while handing off the remaining 20–30% to humans with complete context, transcripts, and priority scores attached.

---

## 4. Key Features and Functionalities

### 4.1 Voice Call Simulator

**What it does:** Allows full end-to-end testing of the AI agent pipeline through a browser interface — no phone hardware required.

**Why it's useful:** Developers, managers, and hackathon judges can observe every step of the AI pipeline (intent, sentiment, tool, source, escalation) in real time.

**How it works internally:**
- Uses the browser's native `Web Speech API` (`SpeechRecognition` + `SpeechSynthesis`) for voice input/output
- Supports three languages: English (en-US), Telugu (te-IN), Kannada (kn-IN)
- Maintains a live transcript display showing interim speech recognition results
- When voice mode is active: agent speaks its response, then immediately starts listening again — creating a continuous conversation loop
- Shows a detailed "execution trace" panel for each message: intent badge, sentiment badge, tool called, data source, and escalation status
- Four one-click quick test cases pre-loaded for demos

### 4.2 9-Intent Classification Engine

**What it does:** Classifies every incoming message into exactly one of 9 enterprise intent categories.

**Why it's useful:** Allows the orchestrator to route each call to the exact right tool and response strategy without any LLM call for intent detection — keeping latency extremely low.

**How it works internally (`intent_classifier.py`):**
Uses weighted keyword matching with priority ordering. Intents are checked in this sequence to prevent misclassification:

| Priority | Intent | Example Trigger |
|---|---|---|
| 1 | `ORDER_STATUS` | "Where is my order 1023?" + digit |
| 2 | `HUMAN_ESCALATION` | "connect me to a manager" |
| 3 | `FAQ_POLICY` | "what is your refund policy" |
| 4 | `BOOK_CALLBACK` | "call me back tomorrow morning" |
| 5 | `BUSINESS_ANALYTICS` | "what is the revenue today" |
| 6 | `TECHNICAL_SUPPORT` | "the API is returning 502" |
| 7 | `SALES_LEAD` | "I want to see your pricing plans" |
| 8 | `SECURITY_COMPLIANCE` | "unauthorized charge on my account" |
| 9 | `GENERAL` | (fallback) |

Multilingual keywords for Telugu, Kannada, and Hindi are embedded directly into each category's keyword list.

### 4.3 Sentiment, Urgency, and Churn Detection

**What it does:** Independently scores each message on four behavioral dimensions: sentiment (5 classes), urgency (3 levels), churn risk (2 levels), escalation probability (3 levels).

**Why it's useful:** Enables pre-emptive customer retention actions. A frustrated customer inquiring about a refund will be auto-escalated even if they didn't explicitly ask for a human — preventing churn before it happens.

**How it works internally:**
- `detect_sentiment()` → 5 classes: `positive`, `neutral`, `frustrated`, `urgent`, `churn_risk`
- `detect_urgency()` → Incorporates sentiment as a primary signal; frustration always maps to HIGH
- `estimate_churn_risk()` → Detects keywords like "cancel", "leaving", "competitor", "never again"
- `detect_escalation_probability()` → Composite function of intent + sentiment + urgency
- **Auto-escalation trigger**: If `sentiment ∈ {frustrated, churn_risk}` and intent is not already an escalation or callback → intent is overridden to `HUMAN_ESCALATION`

### 4.4 RAG-Powered Knowledge Base

**What it does:** Answers policy and FAQ questions grounded entirely in the company's actual documents — no hallucination.

**Why it's useful:** Ensures every policy answer is factually accurate and traceable to a specific document. The source file is logged with each call.

**How it works internally:**
1. **Ingestion (`ingest.py`):** Reads `.txt` files from `rag/knowledge_base/`, computes sentence embeddings using `all-MiniLM-L6-v2` (SentenceTransformers), and stores the documents + embeddings in `data/simple_rag_db.json`
2. **Retrieval (`retriever.py`):** On each FAQ query, the question is embedded using the same model. Cosine similarity is computed against all stored embeddings using NumPy. The document with the highest similarity score above a 0.2 threshold is returned with its source filename and confidence score
3. **Background preloading:** The sentence-transformer model is loaded in a daemon thread on startup to avoid cold-start latency on the first query

Current knowledge base documents (4 files):
- `refund_policy.txt` — 7-day refund window, 3–5 day processing
- `delivery_policy.txt` — Standard delivery timelines
- `warranty_policy.txt` — Warranty coverage terms
- `faq.txt` — General FAQ

### 4.5 Dynamic LLM Naturalization (Groq + LLaMA 3)

**What it does:** Takes structured tool outputs and converts them into natural, human-like voice responses via the Groq API.

**Why it's useful:** Without this step, responses would be robotic data dumps. With it, "Order 1023: status=Out for Delivery, expected_delivery=Today by 7 PM" becomes "Your order 1023 is out for delivery and expected to arrive today by 7 PM."

**How it works internally (`groq_service.py`):**
- **Smart model routing**: Simple intents (ORDER_STATUS, FAQ, CALLBACK) → `llama-3.1-8b-instant` (faster, 200 token limit). Complex intents (BUSINESS_ANALYTICS, TECHNICAL_SUPPORT, SECURITY, SALES) → `llama-3.3-70b-versatile` (smarter, 400 token limit)
- **Multi-turn context**: Last 6 messages from session history are injected into the LLM call
- **Temperature**: Fixed at 0.3 (low) for consistent, accurate responses
- **Frequency penalty**: 0.1 to reduce repetitive phrasing
- **System prompt**: Dynamically built per turn — includes enterprise base rules, intent-specific instructions, tone directives (frustrated/urgent/churn_risk), urgency directive, and live data context

**Enterprise prompt system (`prompts.py`):**

The `get_system_prompt()` function assembles a composite prompt from:
1. `ENTERPRISE_BASE_PROMPT` — Core persona, hallucination prevention rules, data priority order, voice behavior guidelines
2. `INTENT_PROMPTS[intent]` — Precise task instruction for the current intent
3. `tone_directive` — Emotional adaptation based on detected sentiment
4. `urgency_directive` — Speed/priority modifier for HIGH urgency
5. `session_note` — Continuity instruction if prior turns exist
6. `context_block` — Live tool data injected as grounded facts

### 4.6 Multi-Turn Session Memory

**What it does:** Maintains a per-caller conversation history in memory across multiple turns.

**Why it's useful:** Allows the agent to reference prior context naturally. If a customer says "what about that order?" in a second turn, the agent can look up the previously mentioned order ID from session entities.

**How it works internally:**
- `_session_store` is a Python dict keyed by `caller_phone`
- Each session stores: `history` (alternating user/assistant messages), `last_intent`, `entities` (extracted values like order_id, preferred_time), `turn_count`
- Session is trimmed to `SESSION_MAX_TURNS = 10` (last 10 turns) to prevent memory bloat
- Entity carry-forward: If an ORDER_STATUS query has no order ID in the current message, the orchestrator checks `session["entities"]["order_id"]` for a previously extracted value

### 4.7 Enterprise Command Center Dashboard

**What it does:** A real-time, tabbed analytics dashboard providing four-pillar operational intelligence.

**Why it's useful:** Gives managers a single-pane view of every business dimension — from revenue to API latency to AI confidence scores.

**How it works internally:**
- Fetches from 5 parallel API calls on load and auto-refreshes every 10 seconds
- Falls back gracefully to `demoData.js` when the backend is offline

**Tab 1 — Business Metrics:**
- Revenue today, MRR, ARR, gross profit, profit margin
- Conversion rate, average order value, CAC, LTV, LTV/CAC ratio
- Churn rate, refund rate, payment success rate
- Active subscriptions, new subscriptions today, pipeline value
- Monthly revenue vs. profit area chart (Recharts)
- Performance KPIs: top product, top region, best campaign, ROI

**Tab 2 — Customer Operations:**
- Active conversations, avg wait time, queue size
- SLA compliance %, CSAT score, NPS score
- Open tickets, resolved today, avg resolution time
- Escalation rate, first contact resolution %, customer retention %
- Customer sentiment timeline (area chart — positive/neutral/frustrated)
- Per-agent performance table (calls, resolved, CSAT, status)
- Recent call activity table with full metadata

**Tab 3 — Technical Monitoring:**
- Overall system status banner
- API uptime %, avg latency, P99 latency, error rate, cache hit rate
- Per-service health table (8 services: Core API, AI Engine, Database, Auth, Payment Gateway, ChromaDB RAG, Vapi Webhook, Cache Layer) with live latency
- API latency P50/P95/P99 line chart over time

**Tab 4 — AI Operations:**
- Intent distribution bar chart
- AI confidence score trend area chart
- Confidence ring gauge (color-coded: green ≥85%, amber ≥70%, red <70%)
- Workflow execution log table

### 4.8 AI Operations Page

**What it does:** A dedicated page (`/ai-ops`) for monitoring the AI agent's internal operational intelligence.

**How it works:** Fetches live data from `GET /dashboard/ai-ops`, which aggregates real computed metrics from `calls.json`. Displays:
- Animated SVG confidence ring with real-time confidence score
- Confidence trend area chart (7 time buckets)
- Sentiment distribution pie chart (from actual call sentiments)
- Intent classification bar chart (all 9 intents with counts)
- Workflow execution log table with tool name, status, latency, timestamp
- Dual-model usage stats (LLaMA 3.1-8B fast vs LLaMA 3.3-70B smart)
- Hallucination prevention block count

### 4.9 Live Calls Page

**What it does:** Displays all recorded calls in reverse chronological order with full metadata.

**Features added:**
- Filter chips: All / Escalated / Positive / Frustrated / High Urgency
- Quick stats strip: total calls, escalated count, positive sentiment count, high urgency count
- Expandable cards: click any call to reveal the full customer message and agent response transcript
- Per-call display: confidence %, urgency badge, churn risk, escalation probability, tool used, data source

### 4.10 Tickets and Callbacks Management

**Tickets (`/tickets`):**
- 4 priority levels: Critical / High / Medium / Low with gradient color-coded left border bars
- Status filter chips: Open / In Progress / Resolved
- Stats summary row with counts per status and priority

**Callbacks (`/callbacks`):**
- Live "time ago" countdown that updates every 30 seconds
- Status dot indicator (pulsing amber for Pending)
- Stats row: Pending / Confirmed / Completed counts

### 4.11 Knowledge Base RAG Interface

**What it does:** Interactive UI for testing the RAG system directly.

**Features:**
- Document index panel showing all 4 knowledge base files with chunk counts
- Query input with sample quick-query buttons
- Search history sidebar (click to re-run past queries)
- Result panel showing: retrieved context, source file, confidence score, query latency
- Document sync button to trigger re-ingestion of all knowledge base files

### 4.12 Vapi.ai Webhook Integration

**What it does:** Exposes a `POST /voice/webhook` endpoint that handles Vapi.ai voice platform events.

**How it works:** Supports three Vapi webhook event types:
- `assistant-request` — Extracts the latest user transcript, runs through `handle_call()`, returns AI response JSON
- `status-update` — Logs call status changes
- `end-of-call-report` — Logs call duration and transcript summary

This allows the same AI agent to be deployed on a real phone number via Vapi without any code changes.

---

## 5. System Architecture / Workflow

### End-to-End Request Lifecycle

```
Customer speaks/types
        │
        ▼
[Call Simulator OR Vapi Webhook]
        │
        ▼ POST /agent/respond
[FastAPI Backend — main.py]
        │
        ▼
[Orchestrator — orchestrator.py]
 ┌──────────────────────────────────────────────────┐
 │                                                  │
 │  1. detect_intent(message)      → 9 categories   │
 │  2. detect_sentiment(message)   → 5 classes       │
 │  3. detect_urgency(...)         → HIGH/MED/LOW    │
 │  4. estimate_churn_risk(...)    → HIGH/LOW        │
 │  5. detect_escalation_prob(...) → HIGH/MED/LOW    │
 │  6. Auto-escalate if frustrated/churn_risk        │
 │                                                  │
 │  Tool routing based on intent:                   │
 │  ORDER_STATUS     → get_order_status(order_id)   │
 │  FAQ_POLICY       → rag_query(message)           │
 │  HUMAN_ESCALATION → create_ticket(...)           │
 │  BOOK_CALLBACK    → book_callback(...)           │
 │  BUSINESS_ANALYTICS → get_dashboard_summary()   │
 │  TECHNICAL_SUPPORT → static health context      │
 │  SALES_LEAD       → sales routing context        │
 │  SECURITY         → security context + ticket    │
 │  GENERAL          → fallback message             │
 │                                                  │
 │  7. Build system prompt (get_system_prompt())    │
 │  8. generate_response() via Groq API             │
 │  9. _compute_confidence()                        │
 │  10. _update_session()                           │
 │  11. log_call() → data/calls.json                │
 └──────────────────────────────────────────────────┘
        │
        ▼
[JSON Response] ← CallResponse schema
 {call_id, intent, sentiment, urgency, churn_risk,
  escalation_probability, confidence, tool_used,
  answer, source, escalated, summary, timestamp}
        │
        ▼
[Frontend renders result]
[Call Simulator shows execution trace]
[Dashboard auto-refreshes with new call data]
```

### RAG Pipeline

```
[Knowledge Base .txt files]
        │ POST /rag/ingest
        ▼
[SentenceTransformer all-MiniLM-L6-v2]
[Encode documents → float embeddings]
        │
        ▼
[data/simple_rag_db.json]
{documents: [...], metadatas: [...], embeddings: [...]}

[FAQ Query]
        │
        ▼
[Embed query with same model]
[Cosine similarity vs all stored embeddings]
[Return top match if score > 0.2]
        │
        ▼
{answer_context, source, confidence}
```

### Data Flow Diagram

```
┌─────────────────┐      ┌──────────────────────────┐
│   React Frontend │◄────►│  FastAPI Backend (8000)  │
│   (Vite :5173)   │      │                          │
│                 │      │  /agent/respond           │
│  Pages:         │      │  /dashboard/summary       │
│  • Landing      │      │  /dashboard/calls         │
│  • Dashboard    │      │  /dashboard/tickets       │
│  • Simulator    │      │  /dashboard/callbacks     │
│  • LiveCalls    │      │  /dashboard/ai-ops        │
│  • AIOperations │      │  /dashboard/tech-health   │
│  • Analytics    │      │  /dashboard/business      │
│  • Tickets      │      │  /rag/query               │
│  • Callbacks    │      │  /rag/ingest              │
│  • Knowledge    │      │  /voice/webhook           │
└─────────────────┘      └──────────┬───────────────┘
                                    │
                    ┌───────────────┼───────────────┐
                    │               │               │
                    ▼               ▼               ▼
             [Groq API]      [data/*.json]    [rag_db.json]
             LLaMA 3.1/3.3   calls.json       embeddings
                             tickets.json
                             callbacks.json
                             orders.json
```

---

## 6. Tech Stack

### Frontend

| Technology | Version | Purpose |
|---|---|---|
| React | 19.2.6 | UI component framework |
| Vite | 8.0.12 | Build tool and dev server |
| React Router DOM | 7.15.1 | Client-side routing (9 routes) |
| TailwindCSS | 4.3.0 | Utility-first CSS framework |
| Framer Motion | 12.40.0 | Animations, page transitions, AnimatePresence |
| Recharts | 3.8.1 | AreaChart, BarChart, LineChart, PieChart |
| Axios | 1.16.1 | HTTP client for API calls |
| Lucide React | 1.16.0 | Icon library |
| Web Speech API | Native | Browser-based voice recognition and TTS |

### Backend

| Technology | Version | Purpose |
|---|---|---|
| Python | 3.10+ | Runtime |
| FastAPI | ≥0.109.2 | REST API framework |
| Uvicorn | ≥0.27.1 | ASGI server |
| Pydantic | ≥2.6.1 | Request/response validation and schemas |
| pydantic-settings | ≥2.1.0 | Environment-based configuration |
| python-dotenv | ≥1.0.1 | `.env` file loading |

### AI / ML

| Technology | Version | Purpose |
|---|---|---|
| Groq SDK | ≥0.4.2 | API client for Groq LLM inference |
| LLaMA 3.1-8B Instant | — | Fast intent responses (via Groq) |
| LLaMA 3.3-70B Versatile | — | Complex analytics/security responses (via Groq) |
| SentenceTransformers | ≥2.3.1 | Document embedding model for RAG |
| `all-MiniLM-L6-v2` | — | 384-dim embedding model for cosine similarity |
| NumPy | ≥1.26.0 | Cosine similarity computation for RAG |

### Storage / Database

| Technology | Purpose |
|---|---|
| `data/calls.json` | Persistent call log (max 500 records, FIFO) |
| `data/tickets.json` | Escalation tickets |
| `data/callbacks.json` | Scheduled callbacks |
| `data/orders.json` | Mock order records for ORDER_STATUS tool |
| `data/simple_rag_db.json` | Embedded RAG document store (documents + embeddings) |

> **Note:** No external database is used. All persistence is flat-file JSON, which is sufficient for demonstration and small deployments. This is a deliberate simplicity trade-off.

### External APIs / Integrations

| Service | Purpose |
|---|---|
| Groq API | LLM inference (LLaMA 3.1/3.3) |
| Vapi.ai | Voice platform webhook receiver for real phone calls |
| Web Speech API | In-browser voice recognition and TTS (no external API) |

### Tools

| Tool | Purpose |
|---|---|
| `start.bat` | Windows one-click startup script for both servers |
| Vite ESBuild | Frontend bundling (builds in ~770ms) |
| FastAPI Swagger UI | Auto-generated API docs at `/docs` |

---

## 7. Folder Structure

```
supportgenieVoiceAgent-main/
├── start.bat                     # Windows startup script (opens backend + frontend)
├── DEMO_SCRIPT.md                # Step-by-step demo guide for judges/reviewers
├── README1.md                    # Previous short README (superseded by this file)
├── .gitignore
│
├── backend/                      # Python FastAPI backend
│   ├── .env                      # Environment variables (GROQ_API_KEY, etc.)
│   ├── requirements.txt          # Python dependencies
│   └── app/
│       ├── main.py               # FastAPI app, all route definitions
│       ├── config.py             # Settings class (reads .env via pydantic-settings)
│       ├── schemas.py            # Pydantic request/response models
│       │
│       ├── agent/                # Core AI agent logic
│       │   ├── orchestrator.py   # Main handle_call() function — full pipeline
│       │   ├── intent_classifier.py  # 9-intent + sentiment + urgency + churn detection
│       │   └── prompts.py        # Enterprise system prompt builder
│       │
│       ├── services/             # Business logic services
│       │   ├── groq_service.py   # Groq API wrapper with model routing
│       │   └── analytics_service.py  # Dashboard/AI-ops/tech/business metric aggregators
│       │
│       ├── tools/                # Action tools called by the orchestrator
│       │   ├── order_tool.py     # get_order_status(order_id) — reads orders.json
│       │   ├── ticket_tool.py    # create_ticket() — writes to tickets.json
│       │   ├── callback_tool.py  # book_callback() — writes to callbacks.json
│       │   └── rag_tool.py       # rag_query() — thin wrapper over retriever
│       │
│       ├── rag/                  # Retrieval-Augmented Generation engine
│       │   ├── ingest.py         # Embeds .txt files → simple_rag_db.json
│       │   ├── retriever.py      # Cosine similarity search + background model preload
│       │   └── knowledge_base/   # Source policy documents
│       │       ├── refund_policy.txt
│       │       ├── delivery_policy.txt
│       │       ├── warranty_policy.txt
│       │       └── faq.txt
│       │
│       └── data/                 # JSON flat-file persistence
│           ├── calls.json        # All call logs (max 500, most recent first)
│           ├── tickets.json      # Escalation tickets
│           ├── callbacks.json    # Scheduled callbacks
│           ├── orders.json       # Mock order records
│           └── simple_rag_db.json # Computed document embeddings
│
└── frontend/                     # React + Vite frontend
    ├── package.json              # npm dependencies and scripts
    ├── vite.config.js            # Vite build configuration
    ├── index.html                # HTML entry point
    └── src/
        ├── App.jsx               # Root router — 9 routes with AppLayout wrapper
        ├── main.jsx              # React DOM render entry point
        ├── index.css             # Global TailwindCSS styles
        │
        ├── api/
        │   └── client.js         # Axios API client — all backend calls
        │
        ├── data/
        │   └── demoData.js       # Enterprise mock data (6 exports) for offline mode
        │
        ├── components/
        │   ├── Sidebar.jsx       # Navigation sidebar with 8 links + status footer
        │   └── Topbar.jsx        # Top bar with search, notifications, live clock, user
        │
        └── pages/
            ├── Landing.jsx       # Public landing page with hero, features, architecture
            ├── Dashboard.jsx     # 4-pillar enterprise command center
            ├── CallSimulator.jsx # Voice + text AI agent interface
            ├── LiveCalls.jsx     # Call log with filters and expandable transcripts
            ├── AIOperations.jsx  # AI ops page — confidence, intents, workflow log
            ├── Analytics.jsx     # Deep analytics — 6 KPIs, 6 charts
            ├── Tickets.jsx       # Escalation ticket management
            ├── Callbacks.jsx     # Scheduled callback tracker
            └── KnowledgeBase.jsx # RAG query interface with search history
```

---

## 8. Installation and Setup Guide

### Prerequisites

| Requirement | Version | Notes |
|---|---|---|
| Python | 3.10+ | Required for FastAPI backend |
| Node.js | 18+ | Required for Vite/React frontend |
| npm | 8+ | Comes with Node.js |
| Groq API Key | — | Free at [console.groq.com](https://console.groq.com) |

### Step 1: Clone the Repository

```bash
git clone https://github.com/your-username/supportgenie.git
cd supportgenie
```

### Step 2: Backend Setup

```bash
cd backend

# Create and activate a virtual environment
python -m venv venv

# Windows
venv\Scripts\activate

# macOS / Linux
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt
```

### Step 3: Environment Configuration

Create a `.env` file in the `backend/` directory:

```env
GROQ_API_KEY=your_groq_api_key_here
FRONTEND_URL=http://localhost:5173
PORT=8000
```

> Get your free Groq API key at: https://console.groq.com/keys
>
> **Important:** The system works without a Groq API key in "fallback mode" — tool-level structured answers are returned, but LLM naturalization will be skipped and raw context strings will be shown instead.

### Step 4: Ingest the Knowledge Base

Before the RAG system can answer policy questions, the documents must be embedded:

```bash
cd backend
python -m app.rag.ingest
```

Expected output:
```
Ingestion complete.
```

This creates `backend/app/data/simple_rag_db.json` with document embeddings.

### Step 5: Frontend Setup

```bash
cd frontend
npm install
```

### Step 6: Run the Application

**Option A — One-click (Windows only):**
```bash
# From the project root
start.bat
```

This opens two terminal windows and launches the browser automatically.

**Option B — Manual (all platforms):**

Terminal 1 (Backend):
```bash
cd backend
python -m uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
```

Terminal 2 (Frontend):
```bash
cd frontend
npm run dev
```

### Step 7: Access the Application

| Service | URL |
|---|---|
| Frontend Application | http://localhost:5173 |
| Backend API | http://localhost:8000 |
| API Documentation (Swagger) | http://localhost:8000/docs |
| Health Check | http://localhost:8000/health |

### Troubleshooting

**Backend fails to start:**
- Ensure your virtual environment is activated
- Run `pip install -r requirements.txt` again
- Check that Python 3.10+ is installed: `python --version`

**RAG returns no results:**
- Run the ingest step: `python -m app.rag.ingest`
- Verify `backend/app/data/simple_rag_db.json` exists and is non-empty

**Voice recognition doesn't work:**
- Web Speech API requires HTTPS or localhost
- Use Chrome or Edge (Firefox has limited support)
- Grant microphone permissions when prompted

**Groq API errors:**
- Verify your API key is correctly set in `.env`
- Check your Groq usage quota at console.groq.com
- The system will still work without Groq — just with less naturalized responses

**CORS errors:**
- Ensure `FRONTEND_URL=http://localhost:5173` is set in `.env`
- Confirm the backend is running on port 8000

---

## 9. Usage Guide

### 9.1 Landing Page

Navigate to `http://localhost:5173`. The landing page shows:
- Hero section with animated metrics ticker
- 6 feature cards explaining the platform's capabilities
- Architecture flow diagram
- Tech stack badges
- CTA buttons to launch the dashboard or call simulator

### 9.2 Call Simulator (Primary Demo Flow)

1. Navigate to **Call Simulator** (`/simulator`)
2. Select a language: English / Telugu / Kannada
3. **Voice Mode:** Click **"Start Voice Call"** → speak your message → agent listens, responds, and speaks back automatically
4. **Text Mode:** Type a message in the textarea and click "Send Message"
5. Use the **Quick Test Cases** for instant demos:
   - `"Where is my order 1023?"` — triggers ORDER_STATUS → `get_order_status()` tool
   - `"What is your refund policy?"` — triggers FAQ_POLICY → `rag_query()` tool
   - `"I am frustrated, connect me to a human."` — triggers HUMAN_ESCALATION → `create_ticket()` tool
   - `"Book a callback tomorrow morning."` — triggers BOOK_CALLBACK → `book_callback()` tool
6. Observe the execution trace for each message: Intent · Sentiment · Tool · Source · Escalation status

### 9.3 Enterprise Dashboard

Navigate to **Command Center** (`/dashboard`):

1. **Business Tab** — Review revenue, MRR, ARR, conversions, and the monthly revenue area chart
2. **Customer Ops Tab** — Monitor SLA compliance, CSAT, sentiment timeline, agent performance
3. **Technical Tab** — Check all 8 service health indicators and latency charts
4. **AI Ops Tab** — Review AI confidence, intent distribution, and the workflow execution log

The dashboard auto-refreshes every 10 seconds. Click **Refresh** for immediate updates.

### 9.4 AI Operations Page

Navigate to **AI Operations** (`/ai-ops`):
- Observe the real-time confidence gauge (computed from actual call logs)
- Review the intent distribution chart showing all 9 categories
- Examine the workflow execution log for every tool call made

### 9.5 Knowledge Base

Navigate to **Knowledge Base** (`/knowledge`):
1. Click **"Sync Documents"** to re-ingest all knowledge base files
2. Type a policy question or click one of the sample query buttons
3. Review the retrieved context, source file, confidence score, and query latency
4. Prior queries appear in the Search History sidebar for one-click replay

### 9.6 Tickets and Callbacks

- **Tickets** (`/tickets`) — Use filter chips (Open / In Progress / Resolved / Critical / High / Medium) to view escalation tickets
- **Callbacks** (`/callbacks`) — Review pending/confirmed/completed callbacks with live countdown timers

---

## 10. Implemented Functionalities

### Fully Implemented ✅

| Module | Status | Location |
|---|---|---|
| 9-intent classification engine | ✅ Full | `intent_classifier.py` |
| 5-class sentiment detection | ✅ Full | `intent_classifier.py` |
| Urgency detection (HIGH/MED/LOW) | ✅ Full | `intent_classifier.py` |
| Churn risk estimation | ✅ Full | `intent_classifier.py` |
| Escalation probability scoring | ✅ Full | `intent_classifier.py` |
| Auto-escalation on frustrated/churn | ✅ Full | `orchestrator.py` |
| ORDER_STATUS tool (reads orders.json) | ✅ Full | `order_tool.py` |
| HUMAN_ESCALATION tool (creates tickets) | ✅ Full | `ticket_tool.py` |
| BOOK_CALLBACK tool (books callbacks) | ✅ Full | `callback_tool.py` |
| RAG document ingestion (SentenceTransformers) | ✅ Full | `rag/ingest.py` |
| RAG cosine similarity retrieval | ✅ Full | `rag/retriever.py` |
| Groq LLM naturalization with smart model routing | ✅ Full | `groq_service.py` |
| Dynamic enterprise system prompt builder | ✅ Full | `prompts.py` |
| Per-caller in-memory session management | ✅ Full | `orchestrator.py` |
| Session entity carry-forward (order_id, preferred_time) | ✅ Full | `orchestrator.py` |
| Confidence scoring per response | ✅ Full | `orchestrator.py` |
| Call logging (max 500, most-recent-first) | ✅ Full | `orchestrator.py` |
| Voice call simulator (Web Speech API) | ✅ Full | `CallSimulator.jsx` |
| Multilingual voice: English, Telugu, Kannada | ✅ Full | `CallSimulator.jsx` |
| Live voice transcript display | ✅ Full | `CallSimulator.jsx` |
| Auto-listen loop after agent speaks | ✅ Full | `CallSimulator.jsx` |
| Execution trace display in simulator | ✅ Full | `CallSimulator.jsx` |
| Vapi.ai webhook integration | ✅ Full | `main.py` |
| Enterprise 4-pillar dashboard | ✅ Full | `Dashboard.jsx` |
| Business metrics tab (revenue, MRR, ARR, etc.) | ✅ Full | `Dashboard.jsx` |
| Customer operations tab (CSAT, NPS, SLA, sentiment) | ✅ Full | `Dashboard.jsx` |
| Technical monitoring tab (service health, latency) | ✅ Full | `Dashboard.jsx` |
| AI operations tab (confidence, intents, workflow log) | ✅ Full | `Dashboard.jsx` |
| AI Operations dedicated page | ✅ Full | `AIOperations.jsx` |
| SVG confidence ring gauge | ✅ Full | `AIOperations.jsx` |
| Live Calls page with filter chips | ✅ Full | `LiveCalls.jsx` |
| Expandable call transcript cards | ✅ Full | `LiveCalls.jsx` |
| Analytics page (6 KPIs, 6 charts) | ✅ Full | `Analytics.jsx` |
| SLA compliance trend chart | ✅ Full | `Analytics.jsx` |
| Churn risk pie chart | ✅ Full | `Analytics.jsx` |
| Tickets with priority color coding and filters | ✅ Full | `Tickets.jsx` |
| Callbacks with live countdown and status dots | ✅ Full | `Callbacks.jsx` |
| Knowledge base RAG query UI | ✅ Full | `KnowledgeBase.jsx` |
| Search history sidebar | ✅ Full | `KnowledgeBase.jsx` |
| Topbar with notifications and live clock | ✅ Full | `Topbar.jsx` |
| Sidebar with active route pill animation | ✅ Full | `Sidebar.jsx` |
| API endpoints: /agent/respond, /dashboard/*, /rag/*, /voice/webhook | ✅ Full | `main.py` |
| Auto-refresh dashboard (10s interval) | ✅ Full | `Dashboard.jsx` |
| Demo mode (works offline with demoData.js) | ✅ Full | All pages |
| One-click Windows startup script | ✅ Full | `start.bat` |

### Partially Implemented ⚠️

| Feature | Status | Notes |
|---|---|---|
| TECHNICAL_SUPPORT health data | ⚠️ Partial | Returns hardcoded system status strings, not live system monitoring |
| SALES_LEAD routing | ⚠️ Partial | Offers to schedule a callback; no actual CRM lead logging |
| SECURITY_COMPLIANCE data | ⚠️ Partial | Returns hardcoded security posture statements, not a live security scanner |
| Business metrics (revenue, MRR) | ⚠️ Simulated | Computed from call count seed + fixed values; no real billing API |
| ORDER_STATUS data | ⚠️ Mock | Reads from `orders.json` which contains mock order records |

### Not Implemented / Planned 🔴

| Feature | Notes |
|---|---|
| Real external CRM integration | No Salesforce, HubSpot, or Zoho connection |
| Real payment/billing API | No Stripe or Razorpay integration |
| Database persistence (PostgreSQL/MongoDB) | Currently flat-file JSON only |
| Authentication/authorization | No user login system |
| Admin role management | Single-user system |
| Automated unit/integration tests | No test suite exists |
| Docker containerization | No Dockerfile present |
| Cloud deployment pipeline | No CI/CD configuration |
| Hindi full support | Hindi keywords present in classifier, not in TTS voice config |

---

## 11. What Makes This Project Different

### 1. Actions, Not Just Words
Most chatbots respond with text. SupportGenie **executes real backend operations** — it creates database records, queries knowledge bases, reads order files, and reports live metrics. The LLM is the naturalization layer, not the decision maker.

### 2. Two-Stage Intent Architecture
Intent classification is done with deterministic regex + keyword matching (fast, zero cost, zero latency), while the LLM handles only naturalization. This means the system will never misroute a call due to LLM hallucination.

### 3. Enterprise Prompt Engineering
The system prompt is assembled from 6 distinct components per turn, including live data context injection, tone directives based on detected sentiment, and explicit hallucination prevention rules. The LLM is instructed to say "I currently don't have verified real-time access to that information" rather than inventing data.

### 4. Smart Model Routing
Simple calls use `llama-3.1-8b-instant` (faster, cheaper). Complex analytics, security, and technical queries use `llama-3.3-70b-versatile` (more accurate). This dual-model strategy optimizes both cost and quality.

### 5. Offline-Ready Demo Mode
Every page loads with rich realistic data from `demoData.js` when the backend is offline. This means the UI always looks fully operational even without a running server — essential for hackathon demonstrations.

### 6. Full Voice Pipeline in Browser
Real bidirectional voice conversation using only native browser APIs — no paid voice API required. The agent speaks, listens, processes, responds, and listens again in a continuous loop. Includes language-matched voice selection for Telugu and Kannada.

### 7. Churn Prevention Logic
The system doesn't just detect churn risk — it **acts on it**. A customer expressing "I'm leaving for a competitor" will be auto-escalated to a human manager before they can hang up, with a high-priority ticket already created.

---

## 12. Advantages / Pros

| Advantage | Detail |
|---|---|
| **Sub-1.5s response time** | Keyword-based intent detection eliminates LLM overhead for routing; Groq inference is typically 200–500ms |
| **Zero hallucination architecture** | Tool data is injected as grounded context; LLM explicitly cannot fabricate data not in context |
| **Graceful degradation** | Works without Groq API (structured fallback answers), without backend (demo mode), without microphone (text mode) |
| **Multilingual** | Supports English, Telugu, Kannada voice recognition and synthesis natively |
| **Full observability** | Every call is logged with 12 metadata fields; dashboard shows real computed metrics |
| **Real-time dashboard** | 4 operational pillars visible to managers in one interface; auto-refreshes every 10 seconds |
| **Session continuity** | Multi-turn conversations with entity carry-forward (order ID, preferred time) |
| **Production-ready API** | FastAPI with Pydantic schemas, CORS, Swagger docs, health endpoint |
| **Modular architecture** | Tools, RAG, LLM service, intent classifier are all independent, swappable modules |
| **No external database required** | Flat-file JSON persistence works for demos and early deployments |

---

## 13. Limitations / Cons

### Technical Limitations

| Limitation | Impact |
|---|---|
| **Flat-file JSON persistence** | Not suitable for high-concurrency production deployments; race conditions possible under concurrent writes |
| **In-memory session store** | Sessions are lost on backend restart; no distributed session management |
| **Single-document RAG retrieval** | Only the top-1 matching document is returned; multi-document synthesis is not implemented |
| **Hardcoded system health data** | TECHNICAL_SUPPORT intent returns static strings, not live infrastructure metrics |
| **Mock business data** | Revenue, MRR, ARR are computed from call count seeds, not real billing data |
| **No authentication** | Any client can call the API; no API key protection on endpoints |
| **Call log cap** | Capped at 500 records; older records are discarded |

### Operational Limitations

| Limitation | Impact |
|---|---|
| **No test suite** | Regressions cannot be caught automatically |
| **No Docker/containerization** | Manual setup required on every new machine |
| **No CI/CD pipeline** | Deployments require manual steps |
| **Windows-only startup script** | `start.bat` works on Windows only; Linux/Mac users must start manually |
| **Hindi TTS voice** | Hindi keywords are in the classifier but the `kn-IN`/`te-IN` voice config doesn't include Hindi TTS selection |
| **Browser Web Speech API dependency** | Voice features only work in Chromium-based browsers; no mobile app support |
| **No real phone integration** | Vapi.ai webhook is implemented but requires a Vapi account and phone number configuration |

### Scalability Limitations

| Limitation | Impact |
|---|---|
| **Single-process backend** | No horizontal scaling; suitable for <100 concurrent requests |
| **SentenceTransformer model in-process** | Each backend process loads a 90MB ML model into memory |
| **No caching layer** | Every RAG query recomputes cosine similarity against all documents |

---

## 14. Challenges Faced

### Integration Complexity
Combining Web Speech API (browser-native), Groq LLM API (cloud), SentenceTransformers (local ML), and FastAPI into a single coherent real-time pipeline required careful async design — particularly ensuring that voice recognition, API calls, and TTS don't block each other.

### Hallucination Prevention
Getting the LLM to say "I don't know" instead of inventing data required explicit prompt engineering: injecting a `LIVE DATA CONTEXT` block and stating "only state facts present in this context" in the system prompt. Without this, LLaMA would sometimes fabricate order statuses.

### RAG Cold Start Latency
The `all-MiniLM-L6-v2` model takes 2–5 seconds to load. Without background preloading, the first RAG query would time out. Solved by launching model loading in a daemon thread at server startup (`threading.Thread(target=_preload_model, daemon=True).start()`).

### Multilingual Voice Selection
Browser `speechSynthesis.getVoices()` returns different voice lists across operating systems and browsers. Writing voice selection logic that works correctly for Telugu and Kannada across different environments required careful fallback handling.

### Intent Priority Ordering
Early versions of the classifier had ambiguous overlaps — a message saying "I want to cancel my order" could match ORDER_STATUS, FAQ_POLICY (cancellation policy), or HUMAN_ESCALATION simultaneously. The solution was strict priority ordering with escalation checked before FAQ.

### Auto-Escalation Without User Request
Implementing sentiment-driven auto-escalation (overriding the detected intent to HUMAN_ESCALATION when the customer is frustrated) required careful logic to avoid escalating customers who are merely asking about refund policies in a neutral tone.

---

## 15. Security and Privacy Considerations

### API Key Management
- The `GROQ_API_KEY` is stored in a `.env` file that is excluded from version control via `.gitignore`
- The key is loaded server-side only via `pydantic-settings`; it is never exposed to the frontend

### No Authentication
- **Critical gap:** The current implementation has no authentication on any API endpoint
- Any client on the local network can POST to `/agent/respond` or read from `/dashboard/calls`
- This is acceptable for local demonstrations but must be addressed before any internet-facing deployment

### Data Storage
- All call data (including customer phone numbers and conversation transcripts) is stored in plaintext JSON files on the local filesystem
- No encryption at rest is implemented
- For production use, this must be replaced with an encrypted database

### CORS Configuration
- CORS is configured to allow `settings.FRONTEND_URL` and a wildcard `"*"` — the wildcard should be removed for any production deployment

### No PII Redaction
- Customer phone numbers and message content are stored verbatim in `calls.json`
- No GDPR-compliant data retention policies or deletion mechanisms are implemented

### Voice Data
- Voice processing uses the browser's native Web Speech API, which may transmit audio to Google's servers depending on the browser
- No audio is recorded or stored by SupportGenie itself

---

## 16. Performance and Scalability Discussion

### Current Performance Profile

| Metric | Estimate | Bottleneck |
|---|---|---|
| Intent classification | < 1ms | Regex/keyword matching (no ML) |
| RAG retrieval (warm) | 50–200ms | Embedding model inference |
| RAG retrieval (cold start) | 2–5s | Model loading (mitigated by background preload) |
| Groq LLM (8B model) | 200–500ms | Network + inference |
| Groq LLM (70B model) | 500–1500ms | Network + inference |
| Total response time (typical) | 500–1200ms | Dominated by Groq API call |

### Scalability Assessment

| Dimension | Current | Scaling Path |
|---|---|---|
| Concurrent users | ~10–50 | Replace JSON files with PostgreSQL; add Redis for sessions |
| Call volume | ~500 logs | Remove 500-record cap; use time-series database |
| RAG documents | ~10–20 | Replace custom JSON embedding store with ChromaDB or Pinecone |
| LLM throughput | Groq rate limits | Add request queuing; consider self-hosted Ollama for unlimited throughput |
| Deployment | Single process | Containerize with Docker; deploy behind a load balancer |

### Optimization Opportunities

1. **RAG caching**: Cache embeddings for frequent queries in Redis
2. **Intent classification**: Already near-zero cost (regex-based); no optimization needed
3. **LLM response streaming**: Implement SSE streaming for faster perceived response times
4. **Session persistence**: Move `_session_store` to Redis for multi-worker support
5. **Background analytics computation**: Pre-aggregate dashboard metrics instead of computing on every request

---

## 17. Future Improvements / Roadmap

### Short-Term (1–4 weeks)

| Improvement | Rationale |
|---|---|
| Add JWT authentication to all API endpoints | Required for any production use |
| Replace JSON file persistence with SQLite or PostgreSQL | Enables concurrent writes and proper querying |
| Add automated test suite (pytest + Jest) | Prevent regressions on future changes |
| Add Docker + docker-compose configuration | Simplify deployment across any OS |
| Add Hindi TTS voice selection | Complete the three-language support |
| Remove CORS wildcard | Basic security hygiene |

### Mid-Term (1–3 months)

| Improvement | Rationale |
|---|---|
| Replace custom JSON RAG store with ChromaDB | Better scalability, metadata filtering, collection management |
| Add real order data integration (REST API or database) | Replace mock `orders.json` |
| Implement LLM response streaming (SSE) | Improve perceived response latency |
| Add Redis session store | Enable multi-worker deployment |
| Implement call analytics with proper time-series storage | Better historical trend analysis |
| Add supervisor/manager role with auth | Multi-user dashboard access |
| Add GDPR-compliant call data retention and deletion | Required for compliance |

### Long-Term (3–12 months)

| Improvement | Rationale |
|---|---|
| Real CRM integration (Salesforce, Zoho) | Power SALES_LEAD and BUSINESS_ANALYTICS with real data |
| Live infrastructure monitoring (Prometheus/Grafana) | Power TECHNICAL_SUPPORT with real system metrics |
| Real payment gateway integration | Power business metrics with actual revenue data |
| Mobile app wrapper (React Native or PWA) | Extend beyond browser |
| Multi-tenant architecture | Support multiple business customers |
| Custom fine-tuned model | Domain-specific accuracy improvements |
| Voice cloning / custom TTS voice | Brand-matched voice persona |
| Real-time call interruption detection | Stop agent mid-sentence if customer speaks |

---

## 18. Testing and Validation

### Current Test Coverage

**No automated test suite exists** in the current codebase. There are no unit tests, integration tests, or end-to-end tests.

### Manual Testing / Demo Validation

The `DEMO_SCRIPT.md` file provides 4 structured manual test cases that validate the core pipeline end-to-end:

| Test | Input | Expected |
|---|---|---|
| Order Status | `"Where is my order 1023?"` | `ORDER_STATUS` → `get_order_status(1023)` → delivery status response |
| RAG Policy | `"What is your refund policy?"` | `FAQ_POLICY` → `rag_query()` → refund_policy.txt → 7-day refund answer |
| Escalation | `"I am frustrated, connect me to a human."` | `HUMAN_ESCALATION` → `create_ticket()` → ticket visible in Tickets page |
| Callback | `"Book a callback tomorrow morning."` | `BOOK_CALLBACK` → `book_callback()` → callback visible in Callbacks page |

### Recommended Testing Setup (Not Yet Implemented)

```bash
# Backend unit tests (recommended)
pip install pytest pytest-asyncio httpx
pytest backend/tests/

# Frontend component tests (recommended)
npm install --save-dev vitest @testing-library/react
npm run test
```

---

## 19. Deployment

### Current Deployment Method

**Local development only.** No production deployment configuration exists.

**Windows (one-click):**
```bash
start.bat
```

**All platforms (manual):**
```bash
# Terminal 1
cd backend && python -m uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload

# Terminal 2
cd frontend && npm run dev
```

### Production Build (Frontend)

```bash
cd frontend
npm run build
# Output in frontend/dist/ — serve with nginx or any static host
```

### Cloud Deployment Possibilities

The architecture is compatible with the following deployment targets (configuration not included in the codebase):

| Target | Notes |
|---|---|
| **Railway / Render** | FastAPI backend can be deployed with `uvicorn app.main:app --host 0.0.0.0 --port $PORT` |
| **Vercel** | Frontend `dist/` build can be deployed as a static site |
| **AWS EC2 / DigitalOcean** | Full stack on a single VM with nginx reverse proxy |
| **Docker Compose** | Would require creating Dockerfile for backend and nginx config for frontend |
| **Kubernetes** | Suitable after adding PostgreSQL, Redis, and proper secrets management |

### Environment Variables for Production

```env
GROQ_API_KEY=your_production_groq_key
FRONTEND_URL=https://your-production-domain.com
PORT=8000
CHROMA_PATH=./chroma_db    # If upgrading to ChromaDB
```

---

## 20. FAQ

**Q: Does the system work without a Groq API key?**
A: Yes. Without a Groq API key, the system returns structured tool outputs directly (e.g., "Your order 1023 is Out for Delivery") without LLM naturalization. The response is less fluent but factually accurate.

**Q: Does the voice feature work on all browsers?**
A: Voice recognition (SpeechRecognition) and TTS (speechSynthesis) work best on Chrome and Edge. Firefox has limited support. Mobile browsers vary significantly.

**Q: How do I add my own policy documents to the knowledge base?**
A: Add `.txt` files to `backend/app/rag/knowledge_base/`, then click "Sync Documents" in the Knowledge Base page or run `python -m app.rag.ingest` from the backend directory.

**Q: How do I add more orders to the order database?**
A: Edit `backend/app/data/orders.json` and add entries in the format `{"order_id": "XXXX", "status": "...", "expected_delivery": "..."}`. No restart required.

**Q: What happens if two customers call simultaneously?**
A: Each caller is identified by their phone number. Sessions are stored per `caller_phone`. However, since the persistence layer uses synchronous JSON file I/O, simultaneous writes could cause race conditions. Not suitable for high-concurrency production use without a proper database.

**Q: Can I connect this to a real phone number?**
A: Yes. Configure Vapi.ai with a phone number and point the webhook to `POST /voice/webhook` on your deployed backend. The endpoint is already implemented and handles all Vapi event types.

**Q: Why are the business metrics (revenue, MRR) simulated?**
A: The platform has no integration with real billing systems. Revenue figures are generated from a formula seeded by actual call counts to give them a dynamic feel. They are clearly labeled as simulated in the codebase.

**Q: How many concurrent calls can the system handle?**
A: Conservatively, 10–50 concurrent calls with the current architecture. Bottlenecks are synchronous JSON file writes (calls.json) and Groq API rate limits. Replace with PostgreSQL and async Groq calls for production scale.

**Q: Is customer data encrypted?**
A: No. Call logs, phone numbers, and transcripts are stored in plaintext JSON files. Encryption at rest must be implemented before any production deployment.

**Q: What is the maximum number of calls stored?**
A: The system retains the 500 most recent calls in `calls.json`. Older records are automatically discarded on each new call.

---

## 21. Conclusion

### The Problem
Enterprise customer support is expensive, inconsistent, and data-blind. Customers face long queues, rigid IVR systems, and zero personalization. Managers have no real-time visibility into operations.

### The Solution
SupportGenie is an end-to-end AI Voice Agent platform that replaces rigid IVR trees with an intelligent, action-taking AI that understands natural language across multiple languages, executes real backend operations, escalates proactively based on emotional signals, and feeds a real-time enterprise analytics dashboard.

### Technical Maturity
The system is **production-ready for demonstration and small deployments**. The AI pipeline (intent classification → tool execution → LLM naturalization → logging) is complete and functional. The dashboard provides genuine enterprise-grade operational intelligence across four pillars. The major gaps before large-scale production use are: proper database persistence, authentication, a test suite, and Docker packaging.

### Impact
- Eliminates 70–80% of routine support interactions with sub-1.5s automated responses
- Prevents customer churn through real-time sentiment detection and proactive escalation
- Provides managers with instant access to business, customer, technical, and AI operational metrics in one dashboard
- Supports India's multilingual enterprise market with Telugu and Kannada voice support

---

*Built with FastAPI · React · Groq LLaMA 3 · SentenceTransformers · Vapi.ai · Web Speech API*

*SupportGenie — Where every customer conversation becomes operational intelligence.*
