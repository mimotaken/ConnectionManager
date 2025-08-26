## ConnectionManager
Event Manager Module A lightweight utility for dealing with events efficiently.  

## 🌟 Features
Add, retrieve, or remove event connections with the following simple methods. Includes methods for removing all connections, or those matching a prefix. Prevents memory leaks by cleaning up unused events.

## 📖 Usage
AddConnection
```lua
:AddConnection(Connection: RBXScriptConnection, Path: string, Replace: boolean)
```
# Connection: The RBXScriptConnection to store (e.g. from.Connect().).
Path: Connection name. If this is not set, the connection name will be generated randomly.
Replace: true or false. If this is true it will clean any path associated with the given path and clean it accordingling

```lua
:GetConnection(Path: string)
```
# Retrieve a stored connection by its name (Path).

Path: The name of the connection to retrieve.

```lua
:GetAllConnections()
```
# Returns a table of all the stored connections.

```lua
:RemoveConnection(Path: string)
```
# Removes and cleans up a connection by its name.

Path: The name of the connection to remove.

```lua
:RemoveConnectionsFromPath(Path: string)
```
# Removes all the connections whose names start with the given string.

# Example:
If the following relationships are named Chicken, Cheese, Hamburger, and Class:
RemoveAllConnectionsStartsWith("C") will clean up Chicken, Cheese, and Class.
RemoveAllConnectionsStartsWith("CH") will clean up Chicken and Cheese.
Note: This is case-sensitive.

```lua
:RemoveAllConnections()
```
# Completely removes and cleans all stored connections.

## 💡 Why Use ConnectionManager?
Poor event handling in Roblox can result in memory leaks. ConnectionManager is a simple module that makes sure your events are always cleaned up and your memory doesn't leak, keeping your code clean and tidy. It's lightweight and perfect for projects of any size.
