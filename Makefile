# --------------------------------------------------
# 🌍 Load Environment Variables
# --------------------------------------------------
include .env

# --------------------------------------------------
# 🐳 Project Lifecycle Commands
# --------------------------------------------------

project_start:         ## 🚀 Start all containers in detached mode
	docker compose up -d

project_stop:          ## 🛑 Stop all running containers
	docker compose stop

project_restart:       ## 🔄 Restart all containers
	docker compose restart

project_destroy:       ## 💣 Remove containers and volumes
	docker compose down -v

project_cleanup:       ## 🔧 Cleans all build
	sudo rm -rf backend/src/build backend/src/obj backend/bin backend/build backend/obj

# --------------------------------------------------
# 🧠 ASP.NET Backend Commands
# --------------------------------------------------

asp_shell:             ## 🔧 Open a shell in ASP container
	docker exec -it -u root ${PROJECT_NAME}-asp /bin/bash

asp_restore:           ## 📦 Restore .NET dependencies
	docker exec -it -u root ${PROJECT_NAME}-asp sh -c "cd ${ASP_WORK_DIRECTORY}/src && dotnet restore"

asp_build:             ## 🔧 Build .NET project
	docker exec -it -u root ${PROJECT_NAME}-asp sh -c "cd ${ASP_WORK_DIRECTORY}/src && dotnet build TaskManager.csproj"

asp_run:               ## ▶️ Run .NET app
	docker exec -it -u root ${PROJECT_NAME}-asp sh -c "cd ${ASP_WORK_DIRECTORY}/src && dotnet run --urls=http://0.0.0.0:${ASP_PORT}"

asp_test:              ## 🧪 Run .NET tests (requires test project)
	docker exec -it -u root ${PROJECT_NAME}-asp sh -c "cd ${ASP_WORK_DIRECTORY}/src && dotnet test"

asp_migrate_add: 	   ## 🧱 Add EF migration: make asp_migrate_add name=Init
	docker exec -it -u root ${PROJECT_NAME}-asp sh -c "export PATH=\$$PATH:/root/.dotnet/tools && cd ${ASP_WORK_DIRECTORY}/src && dotnet ef migrations add ${name} --msbuildprojectextensionspath ../build/obj/"

asp_migrate_update:    ## 🧱 Apply latest EF migrations
	docker exec -it -u root ${PROJECT_NAME}-asp sh -c "export PATH=\$$PATH:/root/.dotnet/tools && cd ${ASP_WORK_DIRECTORY}/src && dotnet ef database update --msbuildprojectextensionspath ../build/obj/"

# --------------------------------------------------
# 🖥️ Nuxt Frontend Commands
# --------------------------------------------------

nuxt_shell:            ## 🔧 Open a shell in Nuxt container
	docker exec -it -u root ${PROJECT_NAME}-nuxt /bin/bash

nuxt_install:          ## 📦 Install frontend dependencies
	docker exec -it -u root ${PROJECT_NAME}-nuxt npm install

nuxt_update:           ## 🔄 Update frontend packages
	docker exec -it -u root ${PROJECT_NAME}-nuxt npm update

nuxt_dev:              ## 🛠️ Run Nuxt in dev mode
	docker exec -it -u root ${PROJECT_NAME}-nuxt sh -c "npm run dev"

nuxt_start:            ## ▶️ Run Nuxt in production mode
	docker exec -it -u root ${PROJECT_NAME}-nuxt sh -c "npm run start"

nuxt_build:            ## 🔧 Build frontend for production
	docker exec -it -u root ${PROJECT_NAME}-nuxt sh -c "npm run build"

# --------------------------------------------------
# 📖 Help
# --------------------------------------------------
help:  ## 📖 Show this help menu
	@echo "╔══════════════════════════════════════════════════════════════════════════════╗"
	@echo "║                          🛠️  Make Commands Help                               ║"
	@echo "╠══════════════════════════════════════════════════════════════════════════════╣"
	@awk -F':.*?## ' '/^[a-zA-Z0-9_-]+:.*?## / { printf "║ 	\033[36m%-20s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
	@echo "╚══════════════════════════════════════════════════════════════════════════════╝"