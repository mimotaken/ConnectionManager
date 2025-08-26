--// Module
-- This module holds all the necessary information and functions.
local Connect = {}

--// Variables
local Connections = {}
-- This stores all the active connection's.
Connections._ActiveConnections = {}

--// Functions
-- Stores the connection in the ActiveConnections table.
function Connect:AddConnection(Connection: RBXScriptConnection, Path: string, Replace: boolean)
	-- Validates the provided connection and path Format.
	if typeof(Connection) ~= "RBXScriptConnection" or type(Path) ~= "string" then
		return warn("Invalid path format or the given connection is not a valid RBXScriptConnection.")
	end
	
	-- Checks if the given path already exists in the active connections table.
	if Connections._ActiveConnections[Path] and Connections._ActiveConnections[Path].Connected then 
		-- If Replace is true, disconnect the existing connection; otherwise, exit the function.
		if Replace then Connections._ActiveConnections[Path]:Disconnect() Connections._ActiveConnections[Path] = nil else return end	
	end
	
	-- Stores the new connection in the active connections table using the specified path.
	Connections._ActiveConnections[Path] = Connection
end

-- Retrieves the connection from the active connections table.
function Connect:GetConnection(Path: string)
	-- Returns the connection if it exists; otherwise, returns nil if the path was not found.
	return Connections._ActiveConnections[Path]
end

-- Removes and disconnects the connection from the active connections table.
function Connect:RemoveConnection(Path: string)
	-- Checks if the connection exists and is still active.
	if Connections._ActiveConnections[Path] and Connections._ActiveConnections[Path].Connected then
		-- Disconnects the connection to prevent potential memory leaks.
		Connections._ActiveConnections[Path]:Disconnect()
	end
	
	-- Removes the connection reference from the table.
	Connections._ActiveConnections[Path] = nil
end

-- Removes and disconnects all the connections from the active connections table.
function Connect:RemoveAllConnections()
	-- Simply iterates through each connection and disconnects it, then removes it from the table.
	for Path, Connection in pairs(Connections._ActiveConnections) do
		if Connection and Connection.Connected then
			Connection:Disconnect()
		end
	end
	
	-- Clears the entire table after disconnecting all the connections.
	table.clear(Connections._ActiveConnections)
end

-- Removes and disconnects all the connections from the active connections table which match the given path.
function Connect:RemoveConnectionsFromPath(Path: string)
	local ConnectionsToRemove = {}
	
	-- Uses the `Path` parameter to target and disconnect all connections that match the path.
	for ConnectionPath, Connection in pairs(Connections._ActiveConnections) do
		-- Checks if the ConnecttionPath contains the specified path.
		local Exists, Length = string.find(ConnectionPath, Path)
		
		-- Validates if the path was found and if it's a proper path.
		if Exists ~= 1 or Length == 0 then 
			continue 
		end
		
		-- Adds the connection path in the ToRemove list.
		ConnectionsToRemove[ConnectionPath] = true
	end
	
	-- Updates the active connections table and removes the cleaned up connections.
	for ConnectionPath in pairs(ConnectionsToRemove) do
		Connect:RemoveConnection(ConnectionPath)
	end
end

--// Return Module
return Connect
