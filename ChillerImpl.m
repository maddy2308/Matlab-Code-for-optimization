classdef ChillerImpl < CoolingEquipmentImpl
    
    
    properties
        minimumTemperature = 0;
        maximumTemperature = 0;
    end
    
    methods
        
        function chiller = ChillerImpl(name, width, height, depth, positionX, positionZ, orientation)
            chiller@CoolingEquipmentImpl(name, width, height, depth, positionX, positionZ, orientation);
        end
        
        function setMinimumTemperatureOfChiller(chiller, minimumTemperature)
            chiller.minimumTemperature = minimumTemperature;
        end
        
        function setMaximumTemperatureOfChiller(chiller, maximumTemperature)
            chiller.maximumTemperature = maximumTemperature;
        end
    end
    
end

