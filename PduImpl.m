classdef PduImpl < PowerEquipmentImpl
    
    
    methods
        function pdu = PduImpl(name, width, height, depth, positionX, positionZ, orientation, power)
            pdu@PowerEquipmentImpl(name, width, height, depth, positionX, positionZ, orientation, power);            
        end
    end
    
end