function load2DModel(dataCenterObjectsIncludingRoom)
    %dataCenterObjectsIncludingRoom = ImportEcostreamXml('MyRoom.xml');
    listOfRacks = dataCenterObjectsIncludingRoom{2};
    listOfCrahs = dataCenterObjectsIncludingRoom{3};
    listOfPdus = dataCenterObjectsIncludingRoom{4};
    listOfUps = dataCenterObjectsIncludingRoom{5};
    listOfTiles = dataCenterObjectsIncludingRoom{6};
    room = dataCenterObjectsIncludingRoom{1};
    
    rectangle('Position',[room.globalXLocation,room.globalZLocation, room.width, room.depth]);
    grid on;
    set(gca,...
        'xtick',[0:room.tileSize:room.width],...
        'ytick',[0:room.tileSize:room.depth],...
        'XAxisLocation', 'top',...
        'ydir','reverse');
    
    drawRacks(listOfRacks);
    drawCrahs(listOfCrahs);
    drawTiles(listOfTiles);
    drawPdus(listOfPdus);
    drawUps(listOfUps);
% 	A command to switch off the labels on axes
%   set(gca,'xtick',[0:room.tileSize:room.width],'ytick',...
%   		0:room.tileSize:room.depth],'XTickLabel','','YTickLabel','');

    
end

function drawRacks(listOfRacks)
    drawPowerEquipments(listOfRacks, [.53, .53, .53]);
end

function drawUps(listOfUps)
    drawPowerEquipments(listOfUps, [.89, .52, 0.09]);
end

function drawPdus(listOfPdus)
    drawPowerEquipments(listOfPdus, [0, .89, 0]);
end


function drawCrahs(listOfCrahs)
    numberOfCrahs = numel(listOfCrahs);
    for index = 0:numberOfCrahs-1
        crah = listOfCrahs{index+1, :};
        [x, y, width, depth] = getRectangleParametersToRepresentObjects(crah);        
        rectangle('Position',[x, y, width, depth],...
            'FaceColor',[0.09, .52, .89]);
		
        ratingPower = strcat(num2str(crah.ratingPower), ' kW');                
        writeTextOnDataCenterItem(x+.1, y+.5,ratingPower);
        airflow = strcat(num2str(crah.airflow), ' CFM');
		writeTextOnDataCenterItem(x+.1, y+.8,airflow);
        supplyTemperature = strcat(num2str(crah.supplyTemperature), ' °C');
		writeTextOnDataCenterItem(x+.1, y+1.1,supplyTemperature);
        
    end
    
end

function drawTiles(listOfTiles)
	numberOfTiles = numel(listOfTiles);
	for index = 0:numberOfTiles-1
		tile = listOfTiles{index+1, :};
		
		% Since the tiles are square shaped always we are using 
		% tile.width for both width and depth.
        x = tile.positionX;
        z = tile.positionZ;
		rectangle('Position',[x, z, tile.width, tile.width],...
            'FaceColor',[0.73,0.73,0.73]);   
		measuredAirflow = num2str(tile.measuredAirflow);                
        writeTextOnDataCenterItem(x+.1, z+.1,measuredAirflow);
	end
end

function drawPowerEquipments(listOfPowerEquipments, color)
    numberOfPowerEquipments = numel(listOfPowerEquipments);
    for index = 0:numberOfPowerEquipments-1
        powerEquipment = listOfPowerEquipments{index+1, :};
        [x, y, width, depth] = getRectangleParametersToRepresentObjects(powerEquipment);        
        rectangle('Position',[x, y, width, depth],...
            'FaceColor',color);
        
		power = strcat(num2str(powerEquipment.power), ' kW');                
        writeTextOnDataCenterItem(x+0.05, y+.5,power);
        if (~isa(powerEquipment, 'PduImpl'))
            airflowPerKw = num2str(powerEquipment.airflowPerKw);
            writeTextOnDataCenterItem(x+0.1, y+.8, airflowPerKw);
        end
				
    end

end

function [x,y,width, depth] = getRectangleParametersToRepresentObjects(dataCenterItem)
    x = 0;
    y = 0;
    width = 0;
    depth = 0;
    if (dataCenterItem.orientation == 0)
        x = dataCenterItem.positionX;
        y = dataCenterItem.positionZ;
        depth = dataCenterItem.depth;
        width = dataCenterItem.width;
    elseif (dataCenterItem.orientation == 90)
        x = dataCenterItem.positionX - dataCenterItem.depth;
        y = dataCenterItem.positionZ;
        depth = dataCenterItem.width;
        width = dataCenterItem.depth;
    elseif (dataCenterItem.orientation == 180)
        x = dataCenterItem.positionX - dataCenterItem.width;
        y = dataCenterItem.positionZ - dataCenterItem.depth;
        depth = dataCenterItem.depth;
        width = dataCenterItem.width;
    elseif (dataCenterItem.orientation == 270)
        x = dataCenterItem.positionX;
        y = dataCenterItem.positionZ - dataCenterItem.width;
        depth = dataCenterItem.width;
        width = dataCenterItemclear.depth;
    end
end

function writeTextOnDataCenterItem(xPosition, yPosition, stringToDisplay)
	text(xPosition, yPosition, {'\color{white}', stringToDisplay},...
            'VerticalAlignment','middle',...
            'HorizontalAlignment','left');
end