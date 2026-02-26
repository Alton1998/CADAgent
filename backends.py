from deepagents.backends import CompositeBackend, StateBackend, StoreBackend,LocalShellBackend


def make_backend(runtime):
    return CompositeBackend(
        default=StateBackend(runtime),  # Ephemeral storage
        routes={
            "/memories/": StoreBackend(runtime)  # Persistent storage
        }
    )