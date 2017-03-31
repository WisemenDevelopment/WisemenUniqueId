//
//  NSDataEncryption.h
//  Custom_Keychain
//
//  Created by Wisemen on 30/03/2017.
//
//

#import <Foundation/Foundation.h>

@interface  NSData (AES256)
- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;

@end
