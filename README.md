# Permission Check ANE V1.0.0 for iOS
with this ANE you can get the current permission status of different iOS sources like the camera, photos, contacts, calendar, reminders and mic. This ANE also allows you to request for a permission if its status is still unknown.

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
// PermissionCheck.SOURCE_MIC
// PermissionCheck.SOURCE_PHOTOS
// PermissionCheck.SOURCE_CONTACTS
// PermissionCheck.SOURCE_CALENDAR
// PermissionCheck.SOURCE_REMINDER

/*
	The returned state will be one of these values:
	PermissionCheck.PERMISSION_UNKNOWN
	PermissionCheck.PERMISSION_DENIED
	PermissionCheck.PERMISSION_GRANTED
*/

// if the state is PERMISSION_UNKNOWN, you can request for a permission like this:
_ex.request(PermissionCheck.SOURCE_CAMERA, onRequestResult);

private function onRequestResult($state:int):void
{
	trace("permission result = " + $state);
}

/*
	When you request for a permission which is currently in UNKNOWN state, a dialog window will open and asks for
	users permission if the app should have access to the requested resource. No matter what the decision of the user
	would be, you will never again be able to request for that permission again! Don't ask me why, it's how iOS works :)
	
	So, What would happen if a user has denied a request but later she changes her mind? well, in that case, you should
	take the user to the app's settings menu using _ex.openSettings(); where user can see the list of permissions she
	has granted to your app.
	
	NOTICE: as soon as a user changes the state of a permission in the settings menu, your app will be shut down by iOS.
	Well, again, don't ask me why, it's how iOS works :)
*/
```

# Air .xml manifest
```xml
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
	
  </extensions>
-->
```

# Requirements 
1. iOS SDK 8.0 or higher
2. Air SDK 22 or higher

# Commercial Version
http://www.myflashlabs.com/product/native-access-permissions-settings-air-native-extension/

![Permission Check ANE](http://www.myflashlabs.com/wp-content/uploads/2016/06/product_adobe-air-ane-permission-check-595x738.jpg)

# Tutorials
[How to embed ANEs into **FlashBuilder**, **FlashCC** and **FlashDevelop**](https://www.youtube.com/watch?v=Oubsb_3F3ec&list=PL_mmSjScdnxnSDTMYb1iDX4LemhIJrt1O)  

# Changelog
*Jun 08, 2016 - V1.0.0*
* beginning of the journey!
