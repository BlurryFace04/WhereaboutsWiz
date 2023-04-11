// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract ProofOfLocation is AccessControlEnumerable {
    using SafeMath for uint256;

    // Location Data struct containing the location, and updation time of a device
    struct LocationData {
        uint256 timestamp;
        int256 latitude;
        int256 longitude;
    }

    // Variable containing the anchor nodes
    address[] public participatingBeacons;

    // unique identifier for the DEVICE_ROLE
    bytes32 public constant DEVICE_ROLE = keccak256("DEVICE_ROLE");

    // Mapping for device's location history
    mapping(address => LocationData[]) public deviceLocationHistory;

    // Event indicating that location is updated
    event LocationUpdated(
        address indexed device,
        int256 latitude,
        int256 longitude,
        uint256 timestamp
    );

    // The deployer of the contract gets the DEFAULT_ADMIN_ROLE
    constructor() {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    // Function to update the location: Device
    function updateLocation(
        int256 _latitude,
        int256 _longitude
    ) public {
        require(hasRole(DEVICE_ROLE, msg.sender), "Caller is not an authorized device");

        deviceLocationHistory[msg.sender].push(LocationData({
            timestamp: block.timestamp,
            latitude: _latitude,
            longitude: _longitude
        }));

        emit LocationUpdated(msg.sender, _latitude, _longitude, block.timestamp);
    }

    // Function to get the location of a device based on the historic data indexing
    function getLocation(address _device, uint256 _index)
        public
        view
        returns (
            int256 latitude,
            int256 longitude,
            uint256 timestamp
        )
    {
        LocationData storage locData = deviceLocationHistory[_device][_index];
        return (locData.latitude, locData.longitude, locData.timestamp);
    }

    // Function to get the length of DeviceLocationHistory mapping of a device
    function getLocationHistoryLength(address _device) public view returns (uint256) {
        return deviceLocationHistory[_device].length;
    }

    // Function to get the current location of a device
    function getCurrentLocation(address _device)
        public 
        view 
        returns (
            int256 latitude,
            int256 longitude,
            uint256 timestamp
        )
    {
        uint256 _index = getLocationHistoryLength(_device) - 1;
        LocationData storage locData = deviceLocationHistory[_device][_index];
        return (locData.latitude, locData.longitude, locData.timestamp);
    }

    // Function to grant a device DEVICE_ROLE
    function addDeviceRole(address _device) public {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "Caller is not an admin");
        _setupRole(DEVICE_ROLE, _device);
    }
}
