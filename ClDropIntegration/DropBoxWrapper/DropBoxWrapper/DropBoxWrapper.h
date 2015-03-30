//
//  DropBoxWrapper.h
//  DropBoxWrapper
//
//  Created by Abbie on 3/30/15.
//  Copyright (c) 2015 Abbie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DropboxSDK/DropboxSDK.h>

@interface DropBoxWrapper : NSObject
@property (nonatomic,strong)DBRestClient *uploadClient;

+(DropBoxWrapper *)standardWrapper;

-(void)initialisingDropBoxIntegrationWithConsumerKey:(NSString *)consumerKey andConsumerSecretKey:(NSString *)secretKey;
-(BOOL)authenticatingURLSchemeWithURL:(NSURL *)URL;
-(void)loginActionWithRootController:(UIViewController *)controller;
-(void)createDropBoxFolderWithFolderName:(NSString *)folderName;
-(void)uploadToDropBoxWithText:(NSString *)text fileName:(NSString *)fileName andLocalDirectory :(NSString *)LocalDirectoy toDestinationDirectory :(NSString *)DestinationDirectory;
-(void)uploadToDropBoxWithFileName:(NSString *)filename andDirectory:(NSString *)Directory toDestinationDirectory:(NSString *)DestinationDirectory;
-(void)downloadFromDropBoxWithFilePath:(NSString *)filepath toDirectory:(NSString *)Directory;
-(void)listDropBoxFilesWithMetadata :(NSString *)metadata;
@end
