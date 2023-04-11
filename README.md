# WhereaboutsWiz
WhereaboutsWiz is a decentralized dynamic proof of location system built on the Ethereum blockchain, enabling devices to securely verify and store their geographic location. Leveraging consensus algorithms and cryptographic techniques, WhereaboutsWiz offers a tamper-proof, transparent, and verifiable alternative to traditional GPS systems, addressing challenges related to centralization, security, and trust.

## Limitations of traditional GPS systems
1. **Centralization:** <br> GPS relies on a centralized network of satellites operated by specific organizations or governments. This centralization creates dependencies on these entities and can lead to potential vulnerabilities or disruptions.
2. **Security and Privacy:** <br> GPS data can be susceptible to manipulation, spoofing, or jamming attacks, which can compromise the accuracy and integrity of location information. 
3. **Trust and Verification:** <br> In traditional GPS systems, location data is often taken at face value, and it can be challenging to verify the authenticity of the data.

## How proof of location works?
1. **Anchor nodes:** <br> A network of anchor nodes, or radio beacons, is established. These nodes have known and verified locations. They communicate with each other and other devices in the network using radio signals, rather than relying solely on GPS.
2. **Triangulation:** <br> When a device wants to prove its location, it communicates with multiple anchor nodes in its vicinity. The device and anchor nodes exchange messages, which are time-stamped and signed cryptographically. By measuring the time it takes for messages to travel between the device and each anchor node, the device's location can be triangulated.
3. **Verifiable location:** <br> Since the location data is stored on a decentralized ledger and agreed upon by the network participants, it becomes a verifiable proof of location that other devices and applications can trust.

## Smart Contract
The smart contract stores location data in a struct called LocationData, which contains the following fields:
* timestamp: The time at which the location was recorded.
* latitude: The latitude of the device's location.
* longitude: The longitude of the device's location.

The contract also defines a mapping called deviceLocationHistory, which maps Ethereum addresses to an array of LocationData structs. This mapping is used to store the location history of devices with the DEVICE_ROLE.

To update a device's location, the updateLocation() function is called, which takes the new latitude and longitude as arguments. This function requires the caller to have the DEVICE_ROLE in order to be authorized to update its location. When the location is updated, a LocationUpdated event is emitted.

The contract provides several functions for querying location data:
* getLocation(): Returns the location data at a specific index in a device's location history.
* getLocationHistoryLength(): Returns the length of a device's location history.
* getCurrentLocation(): Returns the most recent location data for a device.

Finally, an admin can add devices to the system by calling the addDeviceRole() function, which assigns the DEVICE_ROLE to a device's Ethereum address.

## Applications of WhereaboutsWiz
1. **Supply Chain Management:** <br> WhereaboutsWiz can be used to track and verify the location of goods throughout the supply chain, ensuring transparency and accurate information about the movement of products. Businesses can benefit from improved efficiency, reduced fraud, and better decision-making capabilities.
2. **Geofencing and Access Control:** <br> WhereaboutsWiz can be utilized to create geofencing solutions that restrict access to specific geographic areas. This can be useful for managing access to secure facilities, controlling the use of shared resources, or enforcing location-based policies.
3. **Emergency Response:** <br> WhereaboutsWiz can provide accurate location data for emergency responders, helping them quickly locate and reach people in need of assistance. This can improve the efficiency of rescue operations and potentially save lives.
4. **Location-Based Rewards:** <br> WhereaboutsWiz can enable the creation of decentralized applications that offer location-based rewards or incentives to users. For example, a retailer could offer special promotions or discounts to customers who visit their physical stores, verified through the proof of location system.
