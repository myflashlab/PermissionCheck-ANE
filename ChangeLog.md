Permission Check Air Native Extension

*Aug 2, 2019 - V3.1.1*
- Added Android 64-bit support
- Supports iOS 10+
- Removed **PermissionCheck.os** property, use ```OverrideAir.os``` instead.

*Feb 21, 2019 - V3.1.0*
- Added method ```PermissionCheck.shouldShowRequest("permissionSource")```. This method works on Android side only.

*Nov 18, 2018 - V3.0.1*
- Works with OverrideAir ANE V5.6.1 or higher
- Works with ANELAB V1.1.26 or higher

*Sep 10, 2018 - V3.0.0*
- remove *androidSupport* and instead add the following dependencies:
  - `<extensionID>com.myflashlab.air.extensions.dependency.androidSupport.v4</extensionID>`
  - `<extensionID>com.myflashlab.air.extensions.dependency.androidSupport.core</extensionID>`
- Set `android:targetSdkVersion` to at least `26` in your AIR manifest file
- When asking for iOS SOURCE_LOCATION_ALWAYS permission, you must add a new `key` to your manifest in adition to the old one:
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
- Optimized for [ANE-LAB software](https://github.com/myflashlab/ANE-LAB).

*Aug 14, 2017 - V2.2.0*
- `SOURCE_LOCATION_WHEN_IN_USE` and `SOURCE_LOCATION_ALWAYS` for iOS are now also supported by the ANE. Do not confuse them with `SOURCE_LOCATION` which works on Android only.
- Sample intelliJ project added to GitHub.

*Mar 27, 2016 - V2.1.0*
- Updated the ANE with the latest OverrideAir ANE. This dependency is required on iOS builds also.

*Nov 03, 2016 - V2.0.2*
- Fixed a bug on Android when requesting permissions quickly one after the other
- Fixed a bug on Android when requesting for permission groups. In this fix, you can call any of the permissions in a group and a correct dialog will open

*Nov 02, 2016 - V2.0.1*
- Fixed a bug on Android when requesting for a permission in the project constructor function was returning a wrong value.

*Oct 29, 2016 - V2.0.0*
- Added Android support
- AIR 24+ is required to compile the ANE
- Set -swf-version=35 in compiler options
- Set ```android:targetSdkVersion``` to at least ``23``` in your AIR manifest file

*Sep 18, 2016 - V1.0.1*
- Fixed iOS 7 hard crash

*Jun 08, 2016 - V1.0.0*
- beginning of the journey!
