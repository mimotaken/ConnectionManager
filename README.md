## ConnectionsUtility

Event Connections Utility Module — A lightweight utility for managing event connections efficiently.

## 🌟 Features

Add, retrieve, or remove event connections with simple methods. Includes support for removing all connections, or those matching a specific path prefix. Prevents memory leaks by cleaning up unused events.

## 📖 Usage

### AddConnection

```luau
:AddConnection(Connection: RBXScriptConnection, Path: string, Replace: boolean)
```

Stores a connection in the active connections table.

- **Connection**: The `RBXScriptConnection` to store (e.g. from `.Connect()`).
- **Path**: The name to assign to the connection. Must be a valid string.
- **Replace**: If `true`, any existing connection at the given path will be disconnected and replaced. If `false`, the function will exit without making changes if the path is already in use.

> **Note:** Invalid arguments (non-RBXScriptConnection or non-string path) will trigger a warning and the connection will not be stored.

### GetConnection

```luau
:GetConnection(Path: string)
```

Retrieves a stored connection by its name. Returns the connection if it exists, or `nil` if the path was not found.

- **Path**: The name of the connection to retrieve.

### RemoveConnection

```luau
:RemoveConnection(Path: string)
```

Removes and disconnects a connection by its name. If the connection exists and is still active, it will be disconnected to prevent memory leaks. The reference is then removed from the table.

- **Path**: The name of the connection to remove.

### RemoveConnectionsFromPath

```luau
:RemoveConnectionsFromPath(Path: string)
```

Removes and disconnects all connections whose names start with the given path string.

- **Path**: The prefix to match against connection names.

**Example:**

If the following connections are stored: `Chicken`, `Cheese`, `Hamburger`, and `Class`:

- `RemoveConnectionsFromPath("C")` will clean up `Chicken`, `Cheese`, and `Class`.
- `RemoveConnectionsFromPath("Ch")` will clean up `Chicken` and `Cheese`.

> **Note:** This is case-sensitive.

### RemoveAllConnections

```luau
:RemoveAllConnections()
```

Disconnects and removes all stored connections, then clears the entire active connections table.

## 💡 Why Use ConnectionsUtility?

Poor event handling in Roblox can result in memory leaks. ConnectionsUtility is a simple module that ensures your events are always properly cleaned up, keeping your code clean and your memory leak-free. It's lightweight and perfect for projects of any size.
