.PHONY: install
test:
	poetry install

# PROJECT="another-project" make rename
.PHONY: rename
rename:
	@if [ -z "$(PROJECT)" ]; then \
		echo "Error: PROJECT variable not set"; \
		exit 1; \
	fi;
	$(eval CLEAN_PROJECT_NAME := $(shell echo "$(PROJECT)" | tr ' -' '_'))
	$(eval PROJECT_TOML_NAME := $(shell echo "$(PROJECT)" | tr ' ' '-'))
	@echo "Renaming directory langgraph_agent_template to $(CLEAN_PROJECT_NAME)..."
	@mv langgraph_agent_template $(CLEAN_PROJECT_NAME)
	@echo "Updating project name in pyproject.toml..."
	@sed -i '' 's/langgraph-agent-template/$(PROJECT_TOML_NAME)/g' pyproject.toml
	@echo "Rename complete!"

.PHONY: test
test:
	poetry run pytest
