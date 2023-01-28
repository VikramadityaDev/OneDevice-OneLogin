# OneDevice-OneLogin
"One login in One device" functionality using Firebase Authentication | Firestore | Unique Identifier in Flutter.

## Description

"1 login in 1 device" is a security feature that allows a user to log in to an account from a single device at a time. If the user attempts to log in to the same account on a different device, the previous login session will be terminated, and the user will need to enter their credentials again to log in on the new device. This feature helps to prevent unauthorized access to an account and ensures that only the intended user has access to the account's information.
It can be achieved by storing device unique identifier in firebase firestore and then checking every time user logins from a new device if the device is already registered or not. If it is already registered and user is already logged in on that device, then the new login request will be rejected.
