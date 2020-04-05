# Permission Check ANE for iOS/Android
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


[find the latest **asdoc** for this ANE here.](http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/nativePermissions/package-detail.html)

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
	
		<!--iOS 10.0 or higher can support this ANE-->
		<key>MinimumOSVersion</key>
		<string>10.0</string>
		
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
	<extensionID>com.myflashlab.air.extensions.dependency.androidx.core</extensionID>
	
  </extensions>
-->
```

# Requirements 
1. iOS 10.0+
2. AirSDK 33+
3. Android 19+
4. The following dependencies
	* ```<extensionID>com.myflashlab.air.extensions.dependency.overrideAir</extensionID>```
	* ```<extensionID>com.myflashlab.air.extensions.dependency.androidx.core</extensionID>```

# Commercial Version
https://www.myflashlabs.com/product/native-access-permission-check-settings-menu-air-native-extension/

[![Permission Check ANE](https://www.myflashlabs.com/wp-content/uploads/2016/06/product_adobe-air-ane-permission-check-2018-595x738.jpg)](https://www.myflashlabs.com/product/native-access-permission-check-settings-menu-air-native-extension/)

# Tutorials
[How to embed ANEs into **FlashBuilder**, **FlashCC** and **FlashDevelop**](https://www.youtube.com/watch?v=Oubsb_3F3ec&list=PL_mmSjScdnxnSDTMYb1iDX4LemhIJrt1O)  
[Understanding How Permissions Work before the release of AIR 24](http://www.myflashlabs.com/understanding-android-ios-permissions-in-adobe-air-apps/)  
[How to work with Permissions after the release of AIR SDK 24](http://www.myflashlabs.com/adobe-air-app-permissions-android-ios/)

# Premium Support #
[![Premium Support package](https://www.myflashlabs.com/wp-content/uploads/2016/06/professional-support.jpg)](https://www.myflashlabs.com/product/myflashlabs-support/)
If you are an [active MyFlashLabs club member](https://www.myflashlabs.com/product/myflashlabs-club-membership/), you will have access to our private and secure support ticket system for all our ANEs. Even if you are not a member, you can still receive premium help if you purchase the [premium support package](https://www.myflashlabs.com/product/myflashlabs-support/).