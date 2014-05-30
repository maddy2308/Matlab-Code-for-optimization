classdef PowerEquipmentImpl < DataCenterEquipmentImpl
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        ratingPower = 0;
    end    
    
    methods
        
        function powerEquipment = PowerEquipmentImpl(name, width, height, depth, positionX, positionZ, orientation, power)
            powerEquipment@DataCenterEquipmentImpl(name, width, height, depth, positionX, positionZ, orientation, power);            
        end
		
		function setRatingPowerOfPowerEquipment(powerEquipment, ratingPower)
			powerEquipment.ratingPower = ratingPower;
		end
    end
    
end

