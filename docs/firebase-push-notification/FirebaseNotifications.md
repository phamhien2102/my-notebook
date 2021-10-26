# Firebase Push Notifications

On Firebase Cloud Messaging there are two types of messages that you can send to clients:

**Notification messages** - Delivered when the application is in background. These messages trigger the onMessageReceived() callback only when your app is in foreground. Firebase will provide the ui for the notification shown on Android device.

```json
{
   "notification" : 
   {
    "body" : "hello",
    "title": "firebase",
    "sound": "default"
   },
    "registration_ids" : ["eoPr8fUIPns:APA91bEVYODiWaL9a9JidumLRcFjVrEC4iHY80mHSE1e-udmPB32RjMiYL2P2vWTIUgYCJYVOx9SGSN_R4Ksau3vFX4WvkDj4ZstxqmcBhM3K-NMrX8P6U0sdDEqDpr-lD_N5JWBLCoV"]
}
```

**Data messages** - Handled by the client app. These messages trigger the onMessageReceived() callback even if your app is in foreground/background/killed. When using this type of message you are the one providing the UI and handling when push notification is received on an Android device.

```json
{
    "data": {
        "message" : "my_custom_value",
        "other_key" : true,
        "body":"test"
     },
     "priority": "high",
     "condition": "'general' in topics"
}
```

**Important:**

iOS :

- Data message won't display a notification on your device, should use a notification message for that instead.
- For receiving push notifications on the background on should include content_available = true inside the notification key.

Example:

If application on background receives push notification and display a notification.
```json
{
    "data": {
        "message" : "my_custom_value",
        "other_key" : true,
        "body":"test"
     },
     "notification": {
       "body" : "hello",
       "title": "firebase",
       "sound": "default",
        "content_available" : true
     },
     "priority": "high",
     "condition": "'general' in topics"
}
```

If application on background receives push notification doesn't display any notification.
```json
{
    "data": {
        "message" : "my_custom_value",
        "other_key" : true,
        "body":"test"
     },
     "notification": {
        "content_available" : true
     },
     "priority": "high",
     "condition": "'general' in topics"
}
```

If  "content_available" : true is not sent then you have to tap on the notification for it to be received on the application.

Android:

- Data messages let's you customize notifications ui while notification messages don't (ui is renderered by firebase)


For more information:

https://firebase.google.com/docs/cloud-messaging/concept-options

https://firebase.google.com/docs/cloud-messaging/http-server-ref
