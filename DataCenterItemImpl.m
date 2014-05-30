classdef DataCenterItemImpl < handle
   
    
    properties(SetAccess='private')
        width = 0;
        height = 0;
        depth = 0;
        positionX= 0 ;
        positionZ = 0;
        orientation = 0;
        
        % the below properties are required to correctly find where the
        % item sits on the grid.
        xSlotStart = 0;
        xSlotEnd = 0;
        zSlotStart = 0;
        widthCells = 0;
        depthCells = 0;
        heightCells = 0;
        name = 'dataCenterItem';
    end
       
    methods
        
        %constructor to initialize the data center item class;
        function dci = DataCenterItemImpl(name, width, height, depth, positionX, positionZ, orientation)  
            dci.name = name;
            dci.width = str2double(width);
            dci.height = str2double(height);
            dci.depth = str2double(depth);
            dci.positionX = str2double(positionX);
            dci.positionZ = str2double(positionZ);
            dci.orientation = str2double(orientation);
            
            dci.setXSlotStartOfDataCenterItem(positionX);
            dci.setXSlotEndOfDataCenterItem(positionX);
            dci.setZSlotStartOfDataCenterItem(positionZ);
            %dci.setWidthCells(width);
            %dci.setDepthCells(depth);
            %dci.setHeightCells(height);
            
        end
        
        %set function for orientation of Data Center Item
        function setOrientationOfDataCenterItem(dci, orientation)
            dci.orientation = orientation;
        end
        
        %set function for Chassis width, depth and height
        function setWidthOfDataCenterItem(dci, width)
             if (isnumeric(width) && (width >= 0))   
                 width = str2double(width);
                 dci.width = width;
                 dci.widthCells = round(width / Constants.gridSize);
             end
        end
        
        function setHeightOfDataCenterItem(dci, height)
             if (isnumeric(height) && (height >= 0))   
                 height = str2double(height);
                 dci.height = height;
                 dci.heightCells = round(height / Constants.gridSize);
             end
        end
        
        function setDepthOfDataCenterItem(dci, depth)
             if (isnumeric(depth) && (depth >= 0))  
                 depth = str2double(depth);
                 dci.depth = depth;
                 dci.depthCells = round(depth / Constants.gridSize);
             end
        end
        
        %set function for posistion of Data Center Item
        function setPositionXOfDataCenterItem(dci, positionX)
            if (isnumeric(positionX) && (positionX >= 0))
                dci.positionX = positionX;
            end
        end
        
        function setPositionZOfDataCenterItem(dci, positionZ)
            if (isnumeric(positionZ) && (positionZ >= 0))
                dci.positionZ = positionZ;
            end
        end
        
        %calculate the slots for the items based on their properties set in
        %constructor
        
        function setXSlotStartOfDataCenterItem(dci, newPositionX) 
            newPositionX = str2double(newPositionX);
            dci.xSlotStart = round(newPositionX / Constants.gridSize);
        end
        
        function setXSlotEndOfDataCenterItem(dci, newPositionX)                        
            newPositionX = str2double(newPositionX);
            dci.xSlotEnd = round((newPositionX + dci.width) / Constants.gridSize)-1;
        end
        
        function setZSlotStartOfDataCenterItem(dci, newPositionZ)  
            newPositionZ = str2double(newPositionZ);
            dci.zSlotStart = round(newPositionZ / Constants.gridSize);
        end
        
        function setWidthCells(dci, width)                 
            dci.widthCells = round(width / Constants.gridSize);
        end
        
        function setDepthCells(dci, depth)                        
            dci.depthCells = round(depth / Constants.gridSize);
        end
        
        function setHeightCells(dci, height)                        
            dci.heightCells = round(height / Constants.gridSize);
        end
    end
    
end

