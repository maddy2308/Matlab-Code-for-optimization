classdef PerforatedTileImpl < DataCenterItemImpl
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        perforatedRatio = 0;
        measuredAirflow = 0;
    end
    
    methods
        
        %constructor
        function tile = PerforatedTileImpl(name, width, height, depth, positionX, positionZ, orientation, perforatedRatio)
            tile@DataCenterItemImpl(name, width, height, depth, positionX, positionZ, orientation);  
            tile.perforatedRatio = str2double(perforatedRatio);
        end
        
        %set Perforated Ratio
        function setPerforatedRatio(tile, perforatedRatio)
            tile.perforatedRatio = str2double(perforatedRatio);
        end
        
        %set measured airflow
        function setMeasuredAirflow(tile, measuredAirflow)
            tile.measuredAirflow = str2double(measuredAirflow);
        end
        
    end
    
end

