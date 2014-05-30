function dataCenterObjectsIncludingRoom = ImportEcostreamXml(fileName)
    
    xDoc = xmlread(fileName);

    listOfRacks = getListOfRackObjects(xDoc.getElementsByTagName('rack'));
    listOfCrahs = getListOfCrahObjects(xDoc.getElementsByTagName('downflow_CRAC'));
    listOfPdus = getListOfPduObjects(xDoc.getElementsByTagName('PDU'));
    listOfUps = getListOfUpsObjects(xDoc.getElementsByTagName('UPS'));
    listOfPerforatedTile = getListOfPeforatedTileObjects(xDoc.getElementsByTagName('perforated_floor_tile'));        
    room = createRoom(xDoc, xDoc.getElementsByTagName('wall'));
    
    dataCenterObjectsIncludingRoom = {room, listOfRacks, listOfCrahs, listOfPdus, listOfUps, listOfPerforatedTile};
end

function room =createRoom(xDoc, wallItem)
    
    globalXLocation = str2double(getElementValueByTagName(wallItem.item(0), 'x_location'));
    globalZLocation = str2double(getElementValueByTagName(wallItem.item(0), 'z_location'));
    
    pointItemsInRoom = xDoc.getElementsByTagName('point');
    numberOfPoints = pointItemsInRoom.getLength;
    
    listOfXCoordinates = [];
    listOfZCoordinates = [];
        
    for index = 0:numberOfPoints-1
        thisPoint = pointItemsInRoom.item(index);
        listOfXCoordinates(index+1) = str2double(getElementValueByTagName(thisPoint, 'x_location'));
        listOfZCoordinates(index+1) = str2double(getElementValueByTagName(thisPoint, 'z_location'));
    end
    
    width = max(listOfXCoordinates);
    depth = max(listOfZCoordinates);
    height = Constants.sizeOfRoomInString;
    ecostreamModelItem = xDoc.getElementsByTagName('EcoStream_Model').item(0);
    
    name = getElementValueByTagName(ecostreamModelItem, 'file_name');
    whiteSpaceHeight = str2double(getElementValueByTagName(ecostreamModelItem, 'white_space_height'));
    floorPlenumDepth = str2double(getElementValueByTagName(ecostreamModelItem, 'floor_plenum_depth'));
    tileSize = str2double(getElementValueByTagName(ecostreamModelItem, 'tile_size'));
    tileXOffset = str2double(getElementValueByTagName(ecostreamModelItem, 'tile_x_offset'));
    tileZOffset = str2double(getElementValueByTagName(ecostreamModelItem, 'tile_z_offset'));
    floorLeakage = str2double(getElementValueByTagName(ecostreamModelItem, 'raised_floor_leakage_percentage'));
    roomMaxInletTemperature = str2double(getElementValueByTagName(ecostreamModelItem, 'max_recommended_inlet_temp'));
    roomCoolerSupplyTemperature = str2double(getElementValueByTagName(ecostreamModelItem, 'default_cooler_supply_temp'));
    
    room = RoomImpl(name, width, depth, height, whiteSpaceHeight, floorPlenumDepth, tileSize, tileXOffset, tileZOffset, floorLeakage, roomMaxInletTemperature, roomCoolerSupplyTemperature, globalXLocation, globalZLocation);
end

function listOfPerforatedTile = getListOfPeforatedTileObjects(allTileItems)
    numberOfTile = allTileItems.getLength;
    listOfPerforatedTile = cell(numberOfTile,1);
    for k = 0:numberOfTile-1
        thisTileItem = allTileItems.item(k);
        name = getElementValueByTagName(thisTileItem, 'name');
        x_location = getElementValueByTagName(thisTileItem, 'x_location');
        z_location = getElementValueByTagName(thisTileItem, 'z_location');
        perforatedRatio = getElementValueByTagName(thisTileItem, 'perforated_ratio');        
        tile = PerforatedTileImpl(name, Constants.defaultTileSizeString, '0', Constants.defaultTileSizeString, x_location, z_location, Constants.defaultTileAngleString, perforatedRatio);        
        listOfPerforatedTile{k+1} = tile;
    end
end

function listOfPdu = getListOfPduObjects(allPduItems)
    numberOfPdu = allPduItems.getLength;
    listOfPdu = cell(numberOfPdu,1);
    for k = 0:allPduItems.getLength-1
        thisPduItem = allPduItems.item(k);
        [name, width, height, depth, x_location, z_location, orientation] = getCommonProperties(thisPduItem);       
        power = getElementValueByTagName(thisPduItem, 'power');
        pdu = PduImpl(name, width, height, depth, x_location, z_location, orientation, power);
        listOfPdu{k+1} = pdu;
    end
end

function listOfCrahs = getListOfCrahObjects(allCrahsItems)
    numberOfCrahs = allCrahsItems.getLength;
    listOfCrahs = cell(numberOfCrahs,1);
    for k = 0:allCrahsItems.getLength-1
        thisCrahItem = allCrahsItems.item(k);
        [name, width, height, depth, x_location, z_location, orientation] = getCommonProperties(thisCrahItem);        
        supplyTemperature = getElementValueByTagName(thisCrahItem, 'supply_temperature');
        airflow = getElementValueByTagName(thisCrahItem, 'airflow');
        isDucted = getElementValueByTagName(thisCrahItem, 'ducted');
        crah = CrahImpl(name, width, height, depth, x_location, z_location, orientation, supplyTemperature, airflow, isDucted);
        listOfCrahs{k+1} = crah;
    end
end

function listOfUps = getListOfUpsObjects(allUpsItems)
    numberOfUps = allUpsItems.getLength;
    listOfUps = cell(numberOfUps,1);
    for k = 0:allUpsItems.getLength-1
        thisUpsItem = allUpsItems.item(k);
        [name, width, height, depth, x_location, z_location, orientation, airflowPerKw, power] = getPowerItemObject(thisUpsItem);        
        ups = UpsImpl(name, width, height, depth, x_location, z_location, orientation, airflowPerKw, power);
        listOfUps{k+1} = ups;
    end
    
    
end
function listOfRacks = getListOfRackObjects(allRackItems)
    numberOfRacks = allRackItems.getLength;
    listOfRacks = cell(numberOfRacks,1);
    for k = 0:allRackItems.getLength-1
        thisRackItem = allRackItems.item(k);
        [name, width, height, depth, x_location, z_location, orientation, airflow, power] = getPowerItemObject(thisRackItem);
        isDucted = getElementValueByTagName(thisRackItem, 'ducted');
        rack = RackImpl(name, width, height, depth, x_location, z_location, orientation, airflow, power, isDucted);
        listOfRacks{k+1} = rack;
    end
end

function [name, width, height, depth, x_location, z_location, orientation, airflow, power] = getPowerItemObject(thisPowerItem)
    [name, width, height, depth, x_location, z_location, orientation] = getCommonProperties(thisPowerItem);        
    power = getElementValueByTagName(thisPowerItem, 'power');
    airflow = getElementValueByTagName(thisPowerItem, 'airflow');
end

function [name, width, height, depth, x_location, z_location, orientation] = getCommonProperties(dataCenterItem)
    name = getElementValueByTagName(dataCenterItem, 'name');
    width = getElementValueByTagName(dataCenterItem, 'width');
    height = getElementValueByTagName(dataCenterItem, 'height');
    depth = getElementValueByTagName(dataCenterItem, 'depth');
    x_location = getElementValueByTagName(dataCenterItem, 'x_location');
    z_location = getElementValueByTagName(dataCenterItem, 'z_location');
    orientation = getElementValueByTagName(dataCenterItem, 'orientation');
    
    
end
function value = getElementValueByTagName(dataCenterItem, elementTagName)
    % Get the label element. In this file, each
    % item contains only one label.    
    element = dataCenterItem.getElementsByTagName(elementTagName).item(0);    
    value = element.getFirstChild.getData;
end