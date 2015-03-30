//
//  DropBoxWrapper.m
//  DropBoxWrapper
//
//  Created by Abbie on 3/30/15.
//  Copyright (c) 2015 Abbie. All rights reserved.
//

#import "DropBoxWrapper.h"

@interface DropBoxWrapper ()<DBRestClientDelegate>
@property (nonatomic,strong)NSString *localPath;
@property (nonatomic,strong)NSString *desktopPath;


@end

@implementation DropBoxWrapper

+(DropBoxWrapper *)standardWrapper
{
    static DropBoxWrapper *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        
        instance = [[self alloc]init];
    });
    
    return instance;
}

#pragma mark - Authenticating URL Schemes

-(BOOL)authenticatingURLSchemeWithURL:(NSURL *)URL
{
    if ([[DBSession sharedSession] handleOpenURL:URL]) {
        if ([[DBSession sharedSession] isLinked]) {
            NSLog(@"Successfully Logged In");
        }
        return YES;
    }
    return NO;
}

#pragma mark DropBox initialisation

-(void)initialisingDropBoxIntegrationWithConsumerKey:(NSString *)consumerKey andConsumerSecretKey:(NSString *)secretKey
{
    DBSession *session = [[DBSession alloc]initWithAppKey:consumerKey appSecret:secretKey root:kDBRootDropbox];
    [DBSession setSharedSession:session];
    self.uploadClient = [[DBRestClient alloc]initWithSession:[DBSession sharedSession]];
    self.uploadClient.delegate = self;
    // self.desktopPath = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES)[0];
    //NSString *text = @"Heyyy it is my second upload";
    //NSString *filename = @"ghi.txt";
    //NSString *localDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //NSString *localPath = [localDir stringByAppendingPathComponent:filename];
    
}

#pragma mark - DropBox Login

-(void)loginActionWithRootController:(UIViewController *)controller
{
    if (![[DBSession sharedSession] isLinked]) {
        [[DBSession sharedSession]linkFromController:controller];
    }
    else
    {
        [[DBSession sharedSession]linkFromController:controller];
    }
}

#pragma mark - DropBox Creating Folder

-(void)createDropBoxFolderWithFolderName:(NSString *)folderName
{
    // [self.uploadClient createFolder:@"/FourthFolder"];
    [self.uploadClient createFolder:folderName];
}

// Folder is the metadata for the newly created folder
- (void)restClient:(DBRestClient*)client createdFolder:(DBMetadata*)folder{
    NSLog(@"Created Folder Path %@",folder.path);
    NSLog(@"Created Folder name %@",folder.filename);
}
// [error userInfo] contains the root and path
- (void)restClient:(DBRestClient*)client createFolderFailedWithError:(NSError*)error{
    NSLog(@"%@",error);
}

#pragma mark - DropBox Uploading

-(void)uploadToDropBoxWithText:(NSString *)text fileName:(NSString *)fileName andLocalDirectory:(NSString *)LocalDirectoy toDestinationDirectory:(NSString *)DestinationDirectory
{
    NSString *text1 = text;
    NSString *filename = fileName;
    NSString *localDir = LocalDirectoy;
    self.localPath = [localDir stringByAppendingPathComponent:filename];
    NSLog(@"Local Path %@",self.localPath);
    [text1 writeToFile:self.localPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSString *destDir = DestinationDirectory;
    [self.uploadClient uploadFile:filename toPath:destDir withParentRev:nil fromPath:self.localPath];
}

-(void)uploadToDropBoxWithFileName:(NSString *)filename andDirectory:(NSString *)Directory toDestinationDirectory:(NSString *)DestinationDirectory
{
    NSString *fileName = filename;
    NSString *localDir = Directory;
    //self.localPath = [localDir stringByAppendingPathComponent:filename];
    NSLog(@"Local Path %@",localDir);
    //[text1 writeToFile:self.localPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSString *destDir = DestinationDirectory;
    [self.uploadClient uploadFile:fileName toPath:destDir withParentRev:nil fromPath:localDir];
    
}

#pragma mark - Uploading delegates

- (void)restClient:(DBRestClient *)client uploadedFile:(NSString *)destPath
              from:(NSString *)srcPath metadata:(DBMetadata *)metadata {
    NSLog(@"File uploaded successfully to path: %@", metadata.path);
}

- (void)restClient:(DBRestClient *)client uploadFileFailedWithError:(NSError *)error {
    NSLog(@"File upload failed with error: %@", error);
}

#pragma mark - DropBox downloading

-(void)downloadFromDropBoxWithFilePath:(NSString *)filepath toDirectory:(NSString *)Directory
{
    // [self.uploadClient loadFile:@"/my/ghi.txt" intoPath:self.desktopPath];
    [self.uploadClient loadFile:filepath intoPath:Directory];
}

- (void)restClient:(DBRestClient *)client loadedFile:(NSString *)localPath
       contentType:(NSString *)contentType metadata:(DBMetadata *)metadata {
    NSLog(@"File loaded into path: %@", localPath);
}

- (void)restClient:(DBRestClient *)client loadFileFailedWithError:(NSError *)error {
    NSLog(@"There was an error loading the file: %@", error);
}

#pragma marks - DropBox Listing Folders

-(void)listDropBoxFilesWithMetadata:(NSString *)metadata
{
    // [self.uploadClient loadMetadata:@"/"];
    [self.uploadClient loadMetadata:metadata];
}

#pragma mark - Listing Delegates

- (void)restClient:(DBRestClient *)client loadedMetadata:(DBMetadata *)metadata {
    if (metadata.isDirectory) {
        NSLog(@"Folder '%@' contains:", metadata.path);
        for (DBMetadata *file in metadata.contents) {
            NSLog(@"	%@", file.filename);
        }
    }
}

- (void)restClient:(DBRestClient *)client
loadMetadataFailedWithError:(NSError *)error {
    NSLog(@"Error loading metadata: %@", error);
}

@end
