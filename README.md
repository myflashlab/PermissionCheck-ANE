# Permission Check ANE V2.0.0 for iOS/Android
If you are here reading this, it's probably because of one of the following reasons. Or both?!

1. You need to ask for a permission which is not provided in the AS3 API.
2. You need to ask for a permission without having to initialize the AS3 built in APIs like the Camera API.

with this ANE you can get the current permission status of different iOS/Android sources like the camera, photos, contacts, calendar, reminders, location, mic and etc. This ANE also allows you to request for a permission if its status is still unknown (on iOS) or denied (on Android).

The PermissionCheck Air Native Extension will ask for permissions without you having to actually use the target APIs! For example, you can ask for users permission to have access to their Contacts information without even you actually initialize any API related to contacts.

**NOTE:** If you need other permissions, just leave us a message in the issues section and we will gladly add it to the currently supported permissions.

Here are the list o permissions that this ANE currently supports:

**on iOS:**
* CAMERA
* MIC
* CONTACTS
* CALENDAR
* PHOTOS
* REMINDER
* LOCATION *we support this permission in our [GPS ANE](https://github.com/myflashlab/GPS-ANE)*

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

**NOTICE**: the demo ANE works only after you hit the "OK" button in the dialog which opens. in your tests make sure that you are NOT calling other ANE methods prior to hitting the "OK" button.
[Download the ANE](https://github.com/myflashlab/PermissionCheck-ANE/tree/master/FD/lib)

# Air Usage
```actionscript
import com.myflashlab.air.extensions.nativePermissions.PermissionCheck;

// initialize the ane
var _ex:PermissionCheck = new PermissionCheck();

// check for a permission state
var permissionState:int = _ex.check(PermissionCheck.SOURCE_CAMERA);
// PermissionCheck.SOURCE_CAMERA > both platforms
// PermissionCheck.SOURCE_MIC > both platforms
// PermissionCheck.SOURCE_CONTACTS > both platforms
// PermissionCheck.SOURCE_CALENDAR > both platforms
// PermissionCheck.SOURCE_PHOTOS > iOS ONLY
// PermissionCheck.SOURCE_REMINDER > iOS ONLY
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
_ex.request(PermissionCheck.SOURCE_CAMERA, onRequestResult);

private function onRequestResult($state:int):void
{
	trace("permission result = " + $state);
}

/*
	ON iOS:
	When you request for a permission which is currently in UNKNOWN state, a dialog window will open and asks for
	user's permission if the app should have access to the requested resource. No matter what the decision of the user
	would be, you will never again be able to request for that permission again! Don't ask me why, it's how iOS works :)
	
	So, What would happen if a user has denied a request but later she changes her mind? well, in that case, you should
	take the user to the app's settings menu using _ex.openSettings(); where user can see the list of permissions she
	has granted to your app.
	
	NOTICE: as soon as a user changes the state of a permission in the settings menu, your app will be shut down by OS.
	Well, again, don't ask me why, it's how iOS works :)
	
	-------------------------------------------------------------------------------------------------------------------
	
	ON ANDROID:
	As long as a feature permission is in DENIED state, you can request for user's permission and a dialog will open by
	the ANE. Even the first time that you are asking for a permission, the state is DENIED.
	
	Optionally, you can call _ex.openSettings(); to open the app settings window so users can see the list of features
	that your app has requested permissions for.
	
	If you wish not to use the new Permission thing on Android, compile your project with AIR SDKs lower than 24 and also
	make sure you are setting the android:targetSdkVersion to lower than 23.
*/
```

# Air .xml manifest
```xml
<!--
FOR Android:
-->

<!--The new Permission thing on Android works ONLY if you are targetting Android SDK 23 or higher-->
<uses-sdk android:targetSdkVersion="23"/>







<!--
FOR iOS:
-->
	<InfoAdditions>
	
		<!--iOS 8.0 or higher can support this ANE-->
		<key>MinimumOSVersion</key>
		<string>8.0</string>
		
	</InfoAdditions>
	
	
	
	
	
	
	
	
<!--
Embedding the ANE:
-->
  <extensions>
	
	<extensionID>com.myflashlab.air.extensions.permissionCheck</extensionID>
	
	<!-- The following dependency ANEs are only required when compiling for Android -->
	<extensionID>com.myflashlab.air.extensions.dependency.androidSupport</extensionID>
	<extensionID>com.myflashlab.air.extensions.dependency.overrideAir</extensionID>
	
  </extensions>
-->
```

# Requirements 
1. iOS SDK 8.0 or higher
2. Air SDK 24 or higher

# Commercial Version
http://www.myflashlabs.com/product/native-access-permission-check-settings-menu-air-native-extension/

![Permission Check ANE](http://www.myflashlabs.com/wp-content/uploads/2016/06/product_adobe-air-ane-permission-check-2-595x738.jpg)

# Tutorials
[How to embed ANEs into **FlashBuilder**, **FlashCC** and **FlashDevelop**](https://www.youtube.com/watch?v=Oubsb_3F3ec&list=PL_mmSjScdnxnSDTMYb1iDX4LemhIJrt1O)  
[Understanding How Permissions Work before the release of AIR 24](http://www.myflashlabs.com/understanding-android-ios-permissions-in-adobe-air-apps/)
[How to work with Permissions after the release of AIR SDK 24](http://www.myflashlabs.com/adobe-air-app-permissions-android-ios/)

# Changelog
*Oct 29, 2016 - V2.0.0*
* Added Android support
* AIR 24+ is required to compile the ANE
* Set -swf-version=35 in compiler options
* Set ```android:targetSdkVersion``` to at least ``23``` in your AIR manifest file

*Sep 18, 2016 - V1.0.1*
* Fixed iOS 7 hard crash

*Jun 08, 2016 - V1.0.0*
* beginning of the journey!
