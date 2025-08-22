## Repository Overview
DTC (**Distributed Table Cache**) is a high‑performance caching layer that offloads hotspot queries from relational databases. The project is primarily written in C/C++, built with CMake, and organized into several modules under `src/`.

### Major Modules
- **Agent (`src/agent/`)** – A high-performance proxy (in C) handling client connections, consistent hashing, request routing, and statistics.
- **Core (`src/core/`)** – The main cache service (in C++) implementing buffer management, memory allocation, task pipelines, node grouping, logging, and the server entry point (`main.cc`).
- **Connector (`src/connector/`)** – Bridges the cache with persistent storage (e.g., MySQL) and manages database connections.
- **Config Center (`src/configcenter/`)** – Shared-memory based configuration APIs.
- **Daemons & Watchdog (`src/daemons/`, `src/agent-watchdog/`)** – Process supervisors that start, monitor, and restart components.
- **Data Lifecycle (`src/data_lifecycle/`)** – A scheduler that communicates with the agent to periodically clean or archive data based on user‑defined rules.
- **HWC Server (`src/hwcserver/`)** – Manages hierarchical storage and binlog synchronization for hot/warm/cold data tiers.
- **Rule Engine (`src/rule/`)** – Regex-based request filtering and configuration loading.
- **Utilities (`src/utils/`)** – Logging and config-generation helpers.
- **Third‑Party Libraries (`src/libs/`)** – Vendored dependencies such as cJSON, log4cplus, MySQL client, RocksDB, yaml‑cpp, croncpp, etc.

### Supporting Material
- **Configuration** (`conf/`): Sample `dtc.yaml`, `agent.xml`, and logging configs.
- **Documentation** (`docs/`): Architecture overview, build instructions, quickstart guide.
- **Scripts** (`script/`): Shell helpers for building and running demo environments.
- **Tests** (`tests/`): Integration tests (Python + PyMySQL) and SQL setup scripts.

## Important Concepts
1. **Component Roles**
   - *Agent* handles incoming connections and distributes requests to DTC core nodes using consistent hashing.
   - *Core* caches data, applies write-through policies, and maintains consistency and availability.
   - *Connector* enables datasource mode, forwarding cache misses and updates to the underlying database.
   - *Data Lifecycle Manager* and *HWC server* add scheduled cleanup and hierarchical storage capabilities.

2. **Build & Dependencies**
   - CMake orchestrates builds; optional test suite toggled via `-DCMAKE_TEST_OPTION=ON`.
   - Many third‑party libraries are bundled; understanding how they’re integrated (e.g., log4cplus for logging, RocksDB for storage) is useful.

3. **Configuration & Deployment**
   - `conf/dtc.yaml` and `conf/agent.xml` define tables, routing, and runtime parameters.
   - Dockerfiles and scripts in `script/` provide quick-start containers and build automation.

4. **Code Style & Layout**
   - C++ components commonly use “AskChain/AnswerChain” patterns and buffer abstractions.
   - Agent code mimics a high-performance proxy design (similar to twemproxy) with extensive logging and stats.
