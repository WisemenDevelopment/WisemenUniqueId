var Custom_Keychain = {
_INITIALIZE_KEYCHAIN: function(success, failure,param1){
    cordova.exec(success, failure, "Custom_Keychain", "_INIT_KEYCHAIN", [param1]);
},
_GET_KEYCHAIN: function(success, failure,param1){
    cordova.exec(success, failure, "Custom_Keychain", "_GET_DETAILS", [param1]);
},
_SET_KEYCHAIN: function(success, failure,param1,param2,param3){
    
    cordova.exec(success, failure, "Custom_Keychain", "_SET_DETAILS", [param1,param2,param3]);
},
    
_DELETE_KEYCHAIN: function(success, failure,param1){
    cordova.exec(success, failure, "Custom_Keychain", "_DELETE_DETAILS", [param1]);
}
};
module.exports = Custom_Keychain;