//
//  Custom_Keychain.h
//  Custom_Keychain
//
//  Created by Wisemen on 29/03/2017.
//
//

#import <Cordova/CDV.h>
#import <Foundation/Foundation.h>



@interface Custom_Keychain : CDVPlugin
{
    NSString* callbackId;
  
}



@property (nonatomic,copy) NSString* callbackId;

- (void)_INIT_KEYCHAIN:(CDVInvokedUrlCommand*)command;
- (void)_GET_DETAILS:(CDVInvokedUrlCommand*)command;
- (void)_SET_DETAILS:(CDVInvokedUrlCommand*)command;
- (void)_DELETE_DETAILS:(CDVInvokedUrlCommand*)command;
- (NSData *)AES256EncryptWithKey:(NSString *)key;





//- (void)Getkey:(CDVInvokedUrlCommand*)command;
//- (void)Setkey:(CDVInvokedUrlCommand*)command;

@end

