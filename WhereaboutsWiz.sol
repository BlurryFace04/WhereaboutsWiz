// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract ProofOfLocation is AccessControlEnumerable {
    using SafeMath for uint256;

    struct LocationData {
        uint256 timestamp;
        int256 latitude;
        int256 longitude;
    }

    address[] public participatingBeacons;

    bytes32 public constant DEVICE_ROLE = keccak256("DEVICE_ROLE");

    mapping(address => LocationData[]) public deviceLocationHistory;

    event LocationUpdated(
        address indexed device,
        int256 latitude,
        int256 longitude,
        uint256 timestamp
    );

    constructor() {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

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

    function getLocationHistoryLength(address _device) public view returns (uint256) {
        return deviceLocationHistory[_device].length;
    }

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

    function addDeviceRole(address _device) public {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "Caller is not an admin");
        _setupRole(DEVICE_ROLE, _device);
    }
}
