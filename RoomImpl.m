classdef RoomImpl < handle
    
    properties(SetAccess='private')
        width = 0
        depth = 0;
        height = 0;
        name = 'Room';
        whiteSpaceHeight = 0;
        floorPlenumDepth = 0;
        tileSize = Constants.defaultTileSize;
        tileXOffset = 0;
        tileZOffset = 0;
        floorLeakage = 0;
        roomMaxInletTemperature = 0;
        roomCoolerSupplyTemperature = 0;
        globalXLocation = 0;
        globalZLocation = 0;
     end
    
    methods
        
        %constructor
        function room = RoomImpl(name, width, depth, height, whiteSpaceHeight, floorPlenumDepth, tileSize, tileXOffset, tileZOffset, floorLeakage, roomMaxInletTemperature, roomCoolerSupplyTemperature, globalXLocation, globalZLocation)
            room.name = name;
            room.width = width;
            room.depth = depth;
            room.height = height;
            room.whiteSpaceHeight = whiteSpaceHeight;
            room.floorPlenumDepth = floorPlenumDepth;
            room.tileSize = tileSize;
            room.tileXOffset = tileXOffset;
            room.tileZOffset = tileZOffset;
            room.floorLeakage = floorLeakage;
            room.roomMaxInletTemperature = roomMaxInletTemperature;
            room.roomCoolerSupplyTemperature = roomCoolerSupplyTemperature;
            room.globalXLocation = globalXLocation;
            room.globalZLocation = globalZLocation;
        end
        
    end
    
end

