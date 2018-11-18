# Permission Check ANE V3.0.1 for iOS/Android
This AIR Native Extensions lets you check the permission status of different iOS/Android sources like the camera, photos, contacts, calendar, reminders, location, mic and etc. This ANE also allows you to request for a permission if its status is still unknown (on iOS) or denied (on Android).

**NOTE:** If you need other permissions, just leave us a message in the issues section and we will gladly add it to the currently supported permissions.

Here are the list of permissions that this ANE currently supports:

**on iOS:**

* CAMERA
* MIC
* CONTACTS
* CALENDAR
* PHOTOS
* REMINDER
* LOCATION (when in app)
* LOCATION (always)

**on Android:**

* CAMERA
* MIC
* CONTACTS
* CALENDAR
* PHONE
* STORAGE
* LOCATION
* SENSORS
* SMS


# asdoc
[find the latest asdoc for this ANE here.](http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/nativePermissions/package-detail.html)  

[Download demo ANE](https://github.com/myflashlab/PermissionCheck-ANE/tree/master/AIR/lib)

# Air Usage
```actionscript
import com.myflashlab.air.extensions.nativePermissions.PermissionCheck;

// initialize the ane
PermissionCheck.init();

// check for a permission state
var permissionState:int = PermissionCheck.check(PermissionCheck.SOURCE_CAMERA);
// PermissionCheck.SOURCE_CAMERA > both platforms
// PermissionCheck.SOURCE_MIC > both platforms
// PermissionCheck.SOURCE_CONTACTS > both platforms
// PermissionCheck.SOURCE_CALENDAR > both platforms
// PermissionCheck.SOURCE_PHOTOS > iOS ONLY
// PermissionCheck.SOURCE_REMINDER > iOS ONLY
// PermissionCheck.SOURCE_LOCATION_WHEN_IN_USE > iOS ONLY
// PermissionCheck.SOURCE_LOCATION_ALWAYS > iOS ONLY
// PermissionCheck.SOURCE_PHONE > Android ONLY
// PermissionCheck.SOURCE_STORAGE > Android ONLY
// PermissionCheck.SOURCE_LOCATION > Android ONLY
// PermissionCheck.SOURCE_SENSORS > Android ONLY
// PermissionCheck.SOURCE_SMS > Android ONLY

/*
	The returned state will be one of these values:
	PermissionCheck.PERMISSION_UNKNOWN > iOS ONLY when it's the first time that you are calling the feature.
	PermissionCheck.PERMISSION_DENIED
	PermissionCheck.PERMISSION_GRANTED
*/

// if the state is PERMISSION_UNKNOWN on iOS or PERMISSION_DENIED on Android, you can request for a permission like this:
PermissionCheck.request(PermissionCheck.SOURCE_CAMERA, onRequestResult);

private function onRequestResult($obj:Object):void
{
	trace("permission for " + $obj.source + ": " + $obj.state);
}

/*
	ON iOS:
	When you request for a permission which is currently in UNKNOWN 
	state, a dialog window will open and asks for user's permission 
	if the app should have access to the requested resource. No matter 
	what the decision of the user would be, you will never again be 
	able to request for that permission again! Don't ask me why, it's 
	how iOS works :)
	
	So, What would happen if a user has denied a request but later she 
	changes her mind? well, in that case, you should take the user to 
	the app's settings menu using ```PermissionCheck.openSettings();``` 
	where user can see the list of permissions she has granted to your 
	app.
	
	NOTICE: as soon as a user changes the state of a permission in the 
	settings menu, your app will be shut down by OS.
	
	--------------------------------------------------------------------
	
	ON ANDROID:
	As long as a feature permission is in DENIED state, you can request 
	for user's permission and a dialog will open by the ANE. Even the 
	first time that you are asking for a permission, the state is DENIED.
	
	Optionally, you can call ```PermissionCheck.openSettings();``` to open 
	the app settings window so users can see the list of features that 
	your app has requested permissions for.
*/
```

# Air .xml manifest
```xml
<!--
FOR Android:
-->

<uses-sdk android:targetSdkVersion="26"/>

	<!--
		Although Permissions are asked at runtime, you still need to mention them in your manifest.
		
		To save your time, we have orgenized the permissions groups. Add them only if you are using that 
		feature in your app.
	-->
		
	<!-- CALENDAR GROUP -->
	<uses-permission android:name="android.permission.READ_CALENDAR" />
	<uses-permission android:name="android.permission.WRITE_CALENDAR" />
		
	<!-- CAMERA GROUP -->
	<uses-permission android:name="android.permission.CAMERA" />
		
	<!-- CONTACTS GROUP -->
	<uses-permission android:name="android.permission.READ_CONTACTS" />
	<uses-permission android:name="android.permission.WRITE_CONTACTS" />
	<uses-permission android:name="android.permission.GET_ACCOUNTS" />
		
	<!-- LOCATION GROUP -->
	<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
	<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
		
	<!-- MICROPHONE GROUP -->
	<uses-permission android:name="android.permission.RECORD_AUDIO" />
	
	<!-- PHONE GROUP -->
	<uses-permission android:name="android.permission.PROCESS_OUTGOING_CALLS" />
	<uses-permission android:name="android.permission.WRITE_CALL_LOG" />
	<uses-permission android:name="android.permission.READ_CALL_LOG" />
	<uses-permission android:name="android.permission.CALL_PHONE" />
	<uses-permission android:name="android.permission.READ_PHONE_STATE" />
	<uses-permission android:name="android.permission.USE_SIP" />
	<uses-permission android:name="com.android.voicemail.permission.ADD_VOICEMAIL" />
		
	<!-- SENSORS GROUP -->
	<uses-permission android:name="android.permission.BODY_SENSORS" />
		
	<!-- SMS GROUP -->
	<uses-permission android:name="android.permission.RECEIVE_MMS" />
	<uses-permission android:name="android.permission.RECEIVE_WAP_PUSH" />
	<uses-permission android:name="android.permission.READ_SMS" />
	<uses-permission android:name="android.permission.RECEIVE_SMS" />
	<uses-permission android:name="android.permission.SEND_SMS" />
		
	<!-- STORAGE GROUP -->
	<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
	<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />




	
	
	


<!--
FOR iOS:
-->
	<InfoAdditions>
	
		<!--iOS 8.0 or higher can support this ANE-->
		<key>MinimumOSVersion</key>
		<string>8.0</string>
		
		<!--
			In iOS 10+ submissions require you to add the 'purpose string' to your app 
			when accessing a user's private data such as Camera or Photos. For information 
			about providing keys in your app descriptor file, see https://developer.apple.com/library/content/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html
			
			To save your time, we have added the required key/values below for your reference:
			
			NOTE: Add them ALL even if you are not using that feature in your app. iOS review
			process will notice that the native code is there and if you're not specifying the
			<key> purpose in your manifest, they will reject your app. I know, seems silly but
			that's how it works for now with iOS submissions. If in future, things are changed,
			we will update you.
		-->
		
		<!-- Camera -->
		<key>NSCameraUsageDescription</key>
		<string>My description about why I need this feature in my app</string>
		
		<!-- Mic -->
		<key>NSMicrophoneUsageDescription</key>
		<string>My description about why I need this feature in my app</string>
		
		<!-- Contacts -->
		<key>NSContactsUsageDescription</key>
		<string>My description about why I need this feature in my app</string>
		
		<!-- Calender -->
		<key>NSCalendarsUsageDescription</key>
		<string>My description about why I need this feature in my app</string>
		
		<!-- Photos -->
		<key>NSPhotoLibraryUsageDescription</key>
		<string>My description about why I need this feature in my app</string>
		
		<!-- Reminder -->
		<key>NSRemindersUsageDescription</key>
		<string>My description about why I need this feature in my app</string>
		
		<!-- Location when in use -->
		<key>NSLocationWhenInUseUsageDescription</key>
		<string>My description about why I need this feature in my app</string>
		
		<!-- Location always -->
		<key>NSLocationAlwaysUsageDescription</key>
		<string>My description about why I need this feature in my app</string>
		<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
		<string>My description about why I need this feature in my app</string>
		
		<!-- Motion -->
		<key>NSMotionUsageDescription</key>
		<string>My description about why I need this feature in my app</string>
		
		<!-- Siri (Coming Soon) -->
		<!--<key>NSSiriUsageDescription</key>
		<string>My description about why I need this feature in my app</string>-->
		
		<!-- Speech Recognition (Coming Soon) -->
		<!--<key>NSSpeechRecognitionUsageDescription</key>
		<string>My description about why I need this feature in my app</string>-->
		
		<!-- Home Kit (Coming Soon) -->
		<!--<key>NSHomeKitUsageDescription</key>
		<string>My description about why I need this feature in my app</string>-->
		
		<!-- Health Update (Coming Soon) -->
		<!--<key>NSHealthUpdateUsageDescription</key>
		<string>My description about why I need this feature in my app</string>-->
		
		<!-- Health Share (Coming Soon) -->
		<!--<key>NSHealthShareUsageDescription</key>
		<string>My description about why I need this feature in my app</string>-->
		
		<!-- Bluetooth (Coming Soon) -->
		<!--<key>NSBluetoothPeripheralUsageDescription</key>
		<string>My description about why I need this feature in my app</string>-->
		
		<!-- Apple Music (Coming Soon) -->
		<!--<key>NSAppleMusicUsageDescription</key>
		<string>My description about why I need this feature in my app</string>-->
	
	</InfoAdditions>
	
	
	
<!--
Embedding the ANE:
-->
  <extensions>
	
	<extensionID>com.myflashlab.air.extensions.permissionCheck</extensionID>
	
	<!-- download the dependency ANEs from https://github.com/myflashlab/common-dependencies-ANE -->
	<extensionID>com.myflashlab.air.extensions.dependency.overrideAir</extensionID>
	<extensionID>com.myflashlab.air.extensions.dependency.androidSupport.v4</extensionID>
	<extensionID>com.myflashlab.air.extensions.dependency.androidSupport.core</extensionID>
	
  </extensions>
-->
```

# Requirements 
1. iOS 8.0+
2. AirSDK 30+
3. Android 15+
4. The following dependencies
	* ```<extensionID>com.myflashlab.air.extensions.dependency.overrideAir</extensionID>```
	* ```<extensionID>com.myflashlab.air.extensions.dependency.androidSupport.v4</extensionID>```
	* ```<extensionID>com.myflashlab.air.extensions.dependency.androidSupport.core</extensionID>```

# Commercial Version
http://www.myflashlabs.com/product/native-access-permission-check-settings-menu-air-native-extension/

![Permission Check ANE](https://www.myflashlabs.com/wp-content/uploads/2016/06/product_adobe-air-ane-permission-check-2-595x738.jpg)

# Tutorials
[How to embed ANEs into **FlashBuilder**, **FlashCC** and **FlashDevelop**](https://www.youtube.com/watch?v=Oubsb_3F3ec&list=PL_mmSjScdnxnSDTMYb1iDX4LemhIJrt1O)  
[Understanding How Permissions Work before the release of AIR 24](http://www.myflashlabs.com/understanding-android-ios-permissions-in-adobe-air-apps/)  
[How to work with Permissions after the release of AIR SDK 24](http://www.myflashlabs.com/adobe-air-app-permissions-android-ios/)

# Changelog
*Nov 18, 2018 - V3.0.1*
* Works with OverrideAir ANE V5.6.1 or higher
* Works with ANELAB V1.1.26 or higher

*Sep 10, 2018 - V3.0.0*
* remove *androidSupport* and instead add the following dependencies:
  * ```<extensionID>com.myflashlab.air.extensions.dependency.androidSupport.v4</extensionID>```
  * ```<extensionID>com.myflashlab.air.extensions.dependency.androidSupport.core</extensionID>```
* Set ```android:targetSdkVersion``` to at least ``26``` in your AIR manifest file
* When asking for iOS SOURCE_LOCATION_ALWAYS permission, you must add a new ```key``` to your manifest in adition to the old one:
```xml
<!-- Location always -->
<key>NSLocationAlwaysUsageDescription</key>
<string>My description about why I need location access always</string>

<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>My description about why I need location access always</string>
```
* On Android side, we have now a new static method, ```PermissionCheck.requestMulti``` which you can pass in multiple permissions in one call if you are asking for multiple permissions one after the other. This feature is NOT supported on iOS though. avoid that on the iOS side or it will throw an error.
```actionscript
PermissionCheck.requestMulti(
    [
        PermissionCheck.SOURCE_CAMERA,
        PermissionCheck.SOURCE_MIC
    ],
    onRequestMultiResult
);

function onRequestMultiResult($arr:Array):void
{
	for(var i:int=0; i < $arr.length; i++)
	{
		trace("permission for " + $arr[i].source + ": " + $arr[i].state);
	}
}
```

* Working with this ANE from now on is static rather than instance initialization. Refer to the sample codes to know how you should update your code to use the static methods rathen than instances.
* The permission request callback function returns an *Object* rather than the old *int* parameter.
```actionscript
// asking for the camera permission
PermissionCheck.request(PermissionCheck.SOURCE_CAMERA, onRequestResult);

function onRequestResult($obj:Object):void
{
    // $obj.source > will be SOURCE_CAMERA in this example
    // $obj.state > will be either PERMISSION_DENIED, PERMISSION_GRANTED or PERMISSION_OS_ERR
	trace("permission for " + $obj.source + ": " + $obj.state);
}
```

*Dec 15, 2017 - V2.2.2*
* Optimized for [ANE-LAB software](https://github.com/myflashlab/ANE-LAB).

*Aug 14, 2017 - V2.2.0*
* ```SOURCE_LOCATION_WHEN_IN_USE``` and ```SOURCE_LOCATION_ALWAYS``` for iOS are now also supported by the ANE. Do not confuse them with ```SOURCE_LOCATION``` which works on Android only.
* Sample intelliJ project added to GitHub.

*Mar 27, 2016 - V2.1.0*
* Updated the ANE with the latest OverrideAir ANE. This dependency is required on iOS builds also.


*Nov 03, 2016 - V2.0.2*
* Fixed a bug on Android when requesting permissions quickly one after the other
* Fixed a bug on Android when requesting for permission groups. In this fix, you can call any of the permissions in a group and a correct dialog will open

*Nov 02, 2016 - V2.0.1*
* Fixed a bug on Android when requesting for a permission in the project constructor function was returning a wrong value.

*Oct 29, 2016 - V2.0.0*
* Added Android support
* AIR 24+ is required to compile the ANE
* Set -swf-version=35 in compiler options
* Set ```android:targetSdkVersion``` to at least ``23``` in your AIR manifest file

*Sep 18, 2016 - V1.0.1*
* Fixed iOS 7 hard crash

*Jun 08, 2016 - V1.0.0*
* beginning of the journey!
