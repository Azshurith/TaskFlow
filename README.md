# 🚀 TaskFlow

> Full-stack workflow automation dashboard — scalable, modular, and built for modern development.

**TaskFlow** is a full-stack platform that brings together a NuxtJS frontend with an ASP.NET backend, powered by PostgreSQL and Redis. It's fully Dockerized for instant environment setup, and designed to support scalable development across projects requiring queuing, caching, and user authentication.

---

## 🧰 Tech Stack

| Layer         | Technology                            |
|---------------|----------------------------------------|
| **Frontend**  | NuxtJS 3 (Vue 3, Vite)                 |
| **Backend**   | ASP.NET Core (C#)                      |
| **Database**  | PostgreSQL + pgAdmin GUI               |
| **Cache**     | Redis                                  |
| **Container** | Docker + Docker Compose                |

---

## 📦 Features

- ✅ Clean, modular ASP.NET backend
- 🖥️ NuxtJS 3 frontend (Vue 3 + Pinia)
- 🐘 PostgreSQL with pgAdmin for database management
- 🔁 Redis for sessions, queuing, and caching
- 🐳 Dockerized with fully configurable environment
- 🔐 JWT-based authentication system
- 🔌 Makefile CLI with custom developer commands

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/Azshurith/TaskFlow.git
cd TaskFlow
```

### 2. Create `.env` File

Copy and edit the environment file:

```bash
cp .env.example .env
```

Set project details, ports, credentials, and Docker paths as needed.

### 3. Launch with Docker

```bash
make project_start
```

Access your services:
- Nuxt Frontend: `http://localhost:4000`
- ASP.NET Backend: `http://localhost:4001`
- pgAdmin: `http://localhost:4002`
- Redis: `localhost:6379`

---

## 🛠️ Project Structure

```
backend/                  # ASP.NET backend (C#)
frontend/                 # Nuxt 3 frontend (Vue 3)
.docker/                  # Dockerfiles and Docker config
.env                      # Project environment variables
Makefile                  # CLI commands for automation
docker-compose.yml        # Multi-container orchestration
```

---

## 🧪 Makefile CLI Commands

Use `make help` to view available commands:

| Command             | Description                                  |
|---------------------|----------------------------------------------|
| `project_start`     | 🚀 Start all containers                      |
| `project_stop`      | 🛑 Stop all containers                       |
| `project_restart`   | 🔄 Restart containers                        |
| `project_destroy`   | 💣 Destroy containers and volumes            |
| `project_cleanup`   | 🧹 Clean compiled backend artifacts          |
| `asp_shell`         | 🔧 Shell into ASP.NET container             |
| `asp_restore`       | 📦 Restore backend dependencies              |
| `asp_build`         | 🔧 Build backend project                     |
| `asp_run`           | ▶️  Run backend                              |
| `asp_test`          | 🧪 Run backend tests                         |
| `nuxt_shell`        | 🔧 Shell into Nuxt container                 |
| `nuxt_install`      | 📦 Install frontend packages                 |
| `nuxt_update`       | 🔄 Update frontend packages                 |
| `nuxt_dev`          | 🛠️  Run frontend in dev mode               |
| `nuxt_start`        | ▶️  Run frontend in production mode         |
| `nuxt_build`        | 🔧 Build frontend                           |
| `help`              | 📖 Show Makefile help menu                  |

---

## 🔐 Authentication

JWT-based authentication is integrated:

```http
Authorization: Bearer <your-token-here>
```

---

## 🧠 Redis Use Cases

- User sessions
- Background job queues
- Temporary caching for API or DB results

---

## 🏗️ Manual Build (Frontend)

```bash
cd frontend
npm install
npm run build
```

---

## 👤 Author

**Devitrax / Azshurith**  
GitHub: [@Azshurith](https://github.com/Azshurith)

---

## 📄 License

[MIT](./LICENSE)
