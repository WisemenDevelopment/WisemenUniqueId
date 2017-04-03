//
//  Custom_Keychain.m
//  Custom_Keychain
//
//  Created by Wisemen on 29/03/2017.
//
//

#import "Custom_Keychain.h"

#include "NSDataEncryption.h"


#import<AdSupport/ASIdentifierManager.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <CoreFoundation/CoreFoundation.h>
#import <Security/Security.h>
#include <Accounts/Accounts.h>
#include <Foundation/Foundation.h>
#import <objc/runtime.h>
#include <MobileCoreServices/MobileCoreServices.h>
#include <Security/SecBase.h>
#include <Security/SecAccessControl.h>
#include <CoreFoundation/CFArray.h>
#include "KeychainItemWrapper.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
//#import "NSData+Encryption.h"

@implementation Custom_Keychain

//- (NSData *)AES256DecryptWithKey:(NSString *)key;

@synthesize callbackId;


- (void)_INIT_KEYCHAIN:(CDVInvokedUrlCommand*)command
{
     NSString *Appstr = [command.arguments objectAtIndex:0];
   KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:Appstr accessGroup:nil];
    
}


- (void)_GET_DETAILS:(CDVInvokedUrlCommand*)command
{
    self.callbackId = command.callbackId;
    
     NSString *Appstr = [command.arguments objectAtIndex:0];
     KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:Appstr accessGroup:nil];
    NSString *_ID = [keychainItem objectForKey:kSecValueData];
    
     NSString *res = @"fail";
    if(_ID.length > 0)
    {
        res = _ID ;
    }

    
    
    
 //   NSString *TOKEN = [[NSUserDefaults standardUserDefaults] stringForKey:@"_Device_token"];
    
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:res];
    [self.commandDelegate sendPluginResult:result callbackId:self.callbackId];

 
}
- (void)_SET_DETAILS:(CDVInvokedUrlCommand*)command
{
      self.callbackId = command.callbackId;

     
    NSString *Appstr = [command.arguments objectAtIndex:0];
    
     NSString *str1 = [command.arguments objectAtIndex:1];
     NSString *str2 = [command.arguments objectAtIndex:2];
    NSString *_Random_string = [self generateRandomString:7];
  NSString   *_sbuffer = @"";
    _sbuffer = [_sbuffer stringByAppendingString:Appstr];
    _sbuffer = [_sbuffer stringByAppendingString:@"_"];
    _sbuffer = [_sbuffer stringByAppendingString:str1];
   _sbuffer = [_sbuffer stringByAppendingString:@"_"];
   _sbuffer = [_sbuffer stringByAppendingString:_Random_string];
   _sbuffer = [_sbuffer stringByAppendingString:@"_"];
   _sbuffer = [_sbuffer stringByAppendingString:str2];
    NSString *key = @"mykey";
    NSString *secret = _sbuffer;
    
  
   NSString *Unique_Device_Id = [self encryptString:secret withKey:key];
    NSCharacterSet *charactersToRemove = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    Unique_Device_Id = [[Unique_Device_Id componentsSeparatedByCharactersInSet:charactersToRemove] componentsJoinedByString:@""];
   
     KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:Appstr accessGroup:nil];
     [keychainItem setObject:str1 forKey:(id)kSecAttrAccount];
   [keychainItem setObject:Unique_Device_Id forKey:(id)kSecValueData];
       NSString *_ID = [keychainItem objectForKey:kSecValueData];
    
    NSString *res = @"fail";
 
    if(_ID.length > 0)
    {
        res = _ID ;
    }

    
   
    
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:res];
    [self.commandDelegate sendPluginResult:result callbackId:self.callbackId];
    
  // [keychainItem setObject:@"fgfdhgsfdh" forKey:kSecValueData];
    
    // NSString *_ID = [keychainItem objectForKey:kSecValueData];
    
}
- (void)_DELETE_DETAILS:(CDVInvokedUrlCommand*)command
{
      NSString *Appstr = [command.arguments objectAtIndex:0];
    
     KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:Appstr accessGroup:nil];
    [keychainItem resetKeychainItem];
}

-(NSString*)generateRandomString:(int)num {
    NSMutableString* string = [NSMutableString stringWithCapacity:num];
    for (int i = 0; i < num; i++) {
        [string appendFormat:@"%C", (unichar)('a' + arc4random_uniform(25))];
    }
    return string;
}

- (NSString*) encryptString:(NSString*)plaintext withKey:(NSString*)key {
    
    NSData *dt = [[plaintext dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:key];
return  [dt base64EncodedStringWithOptions:kNilOptions ];
    
  
}



@end


