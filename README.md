# goTenna Radio SDK for iOS

## Overview
The goTenna radio SDK for iOS allows client applications to utilize our mesh radio network for transmitting data from one radio to another. The SDK abstracts the lower level communication layers into higher level objects, so you can do things like `radio.send(Location(...))`.

## Requirements
Make sure you've been given access to the RSDK on goTenna's JFrog/Artifactory instance. Also make sure you put those credentials in your macOS keychain:

![](img/keychain.png)

## Installation
1. Right click your project > Add Package Dependencies... or go to the Package Dependencies section of your project and click the + button.
2. Paste https://github.com/gotenna/gotenna-rsdk-spm into the Package URL field.
3. Select the exact version you want from the Releases GitHub page (note if the version has a "v" as in v3.1.13, you would only put 3.1.13 in the version field for Swift Package Manager).

![](img/package.png)

## Usage

For a quick reference, see our [iOS sample app](https://github.com/gotenna/rsdk-samples/tree/main/ios) that demonstrates a simple implementation of scanning, connecting, and sending some data.

### Initialization

```swift
Task {
    do {
        let initialized = try await GotennaClient.shared.initialize(
            sdkToken: "<#YOUR_SDK_TOKEN#>",
            appId: "<#YOUR_APP_ID#>",
            preProcessAction: nil,
            postProcessAction: nil,
            enableDebugLogs: true
        )
        print("Initialized: \(initialized)")
    } catch {
        print("Error initializing: \(error)")
    }
}
```

Where `preProcessAction` and `postProcessAction` can be used to manipulate data passed to and received from the SDK (e.g. for things like encryption/decryption). The `sdkToken` and `appId` should be provided to you by goTenna.

### Scan and Connect

```swift
Task {
    do {
        let radios = try await GotennaClient.shared.scan(connectionType: ConnectionType.ble, address: nil)
        try await radios.first?.connect()
    } catch {
        print("Error scanning/connecting: \(error)")
    }
}
```

This is a simple example where we just want to connect to the first radio we find in the scan.

### Send Location

```swift
Task {
    let location = SendToNetwork.Location(
        how: "m-g",
        staleTime: 60,
        lat: 35.291802,
        long: 80.846604,
        altitude: 0.0,
        team: "CYAN",
        accuracy: 11, // default value
        creationTime: 1744384848472, // current time in milliseconds since epoch
        messageId: 0, // default value
        commandMetaData: CommandMetaData(
            messageType: GTMessageType.broadcast, // default value
            destinationGid: 0, // default for broadcasts
            isPeriodic: false, // default value
            priority: GTMessagePriority.normal, // default value
            senderGid: activeRadio?.personalGid ?? 0 // activeRadio is a locally stored variable for the radio we connected to
        ),
        commandHeader: GotennaHeaderWrapper(
            timeStamp: 1744384848472, // current time in milliseconds since epoch,
            messageTypeWrapper: MessageTypeWrapper.location,
            recipientUUID: "",
            appCode: 0, // default value
            senderGid: activeRadio?.personalGid ?? 0,
            senderUUID: senderUuid,
            senderCallsign: "JONAS",
            encryptionParameters: nil,
            uuid: UUID().uuidString
        ),
        gripResult: GripResultUnknown(), // default value
        _bytes: nil, // default value
        sequenceId: -1 // default value
    )

     try await activeRadio?.send(model: location)
}
```

**Note**: There are many default values above. These are values that usually clients wouldn't actually need to specify. Unfortunately there is currently a Kotlin Multiplatform translation issue for Swift that drops the Kotlin default values, so all must be explicitly specified.

### Observe radio state changes

```swift
Task {
    try await activeRadio?.radioState.collect(collector: Collector<RadioState>(callback: { [weak self] newState in
        print("Radio state changed to: \(newState)")
        self?.radioConnectionState = newState
    }))
}
```

The `Collector` class used here can be found in our [iOS sample app](https://github.com/gotenna/rsdk-samples/blob/main/ios/ios-sample-app/Collector.swift) if you'd like to re-use it.

Observing state changes means being notified of radio states like `connecting`, `connected`, `disconnected`, etc.

### Listen for incoming network data

```swift
Task {
    try await activeRadio?.radioEvents.collect(collector: Collector<RadioResult>(callback: { radioResult in
        if radioResult is RadioResultFailure<RadioCommand> { print("Got failure") }
        guard let success = radioResult as? RadioResultSuccess<RadioCommand>, let executed = success.executed else {
            print("Unexpected radio result: \(radioResult)\n\n")
            return
        }
        print("Got event from radio: \(executed)")
    }))
}
```

If someone else on the network sends out their location or other messages, you would pick that up in the above collector.

### High Level Suggestion

What we normally do is this:

1. Node A sends everyone on the mesh network its Location as a broadcast message every minute.
1. Node B receives Location from A and other nodes.
1. Node B stores (app logic) the GID of each node in a contact list.
1. Node B uses the contact list to get the GID of the node they want to contact.

## Full API Documentation

API documentation is lost in the Kotlin Multiplatform -> Swift/Objc header translation, so Xcode API documentation won't work. To see the full API documentation, view the javadoc.jar file in the release folder in Artifactory.