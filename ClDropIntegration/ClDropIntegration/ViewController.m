//
//  ViewController.m
//  ClDropIntegration
//
//  Created by Abbie on 3/27/15.
//  Copyright (c) 2015 Abbie. All rights reserved.
//

#import "ViewController.h"
#import <DropBoxWrapper/DropBoxWrapper.h>

@interface ViewController ()<DBRestClientDelegate>
@property (nonatomic,strong)UIButton *loginButton;
@property (nonatomic,strong)UIButton *uploadButton;
@property (nonatomic,strong)UIButton *listButton;
@property (nonatomic,strong)UIButton *downloadButton;
@property (nonatomic,strong)NSString *localPath;
@property (nonatomic,strong)NSString *desktopPath;
@property (nonatomic,strong)UIButton *createButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialisation];
    [self customization];
    [self addSubview];
}

-(void)initialisation
{
    self.loginButton = [[UIButton alloc]init];
    self.uploadButton = [[UIButton alloc]init];
    self.listButton = [[UIButton alloc]init];
    self.downloadButton = [[UIButton alloc]init];
    self.createButton = [[UIButton alloc]init];
}
-(void)customization
{
    [self.loginButton setTitle:@"Dropbox Login" forState:UIControlStateNormal];
    self.loginButton.frame = CGRectMake(100, 100, 200, 80);
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    self.loginButton.backgroundColor = [UIColor blueColor];
    
    
    [self.uploadButton setTitle:@"Upload File" forState:UIControlStateNormal];
    self.uploadButton.frame = CGRectMake(100, 200, 200, 80);
    [self.uploadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.uploadButton addTarget:self action:@selector(uploadAction) forControlEvents:UIControlEventTouchUpInside];
    self.uploadButton.backgroundColor = [UIColor blueColor];
    
    
    [self.listButton setTitle:@"List File" forState:UIControlStateNormal];
    self.listButton.frame = CGRectMake(100, 300, 200, 80);
    [self.listButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.listButton addTarget:self action:@selector(listAction) forControlEvents:UIControlEventTouchUpInside];
    self.listButton.backgroundColor = [UIColor blueColor];
    
    
    [self.downloadButton setTitle:@"Download File" forState:UIControlStateNormal];
    self.downloadButton.frame = CGRectMake(100, 400, 200, 80);
    [self.downloadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.downloadButton addTarget:self action:@selector(downloadAction) forControlEvents:UIControlEventTouchUpInside];
    self.downloadButton.backgroundColor = [UIColor blueColor];
    
    
    [self.createButton setTitle:@"Create Folder" forState:UIControlStateNormal];
    self.createButton.frame = CGRectMake(100, 500, 200, 80);
    [self.createButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.createButton addTarget:self action:@selector(createAction) forControlEvents:UIControlEventTouchUpInside];
    self.createButton.backgroundColor = [UIColor blueColor];
}
-(void)addSubview
{
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.uploadButton];
    [self.view addSubview:self.listButton];
    [self.view addSubview:self.downloadButton];
    [self.view addSubview:self.createButton];
}
#pragma mark - DropBox Login

-(void)loginAction{
    
[[DropBoxWrapper standardWrapper]loginActionWithRootController:self];
}
#pragma mark - uploading files

-(void)uploadAction{
[[DropBoxWrapper standardWrapper]uploadToDropBoxWithText:@"Hi checking uploaded wrapper" fileName:@"123.txt" andLocalDirectory:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] toDestinationDirectory:@"/FourthFolder"];
    
    //[[DropBoxWrapper standardWrapper]uploadToDropBoxWithFileName:@"abc.jpg" andDirectory:[[NSBundle mainBundle]pathForResource:@"abc" ofType:@".jpg"] toDestinationDirectory:@"/FouthFolder"];
}

#pragma mark - Listing Files

-(void)listAction{
[[DropBoxWrapper standardWrapper]listDropBoxFilesWithMetadata:@"/"];
    
}
#pragma mark - Downloading

-(void)downloadAction{
[[DropBoxWrapper standardWrapper]downloadFromDropBoxWithFilePath:@"/FourthFolder/xyz.txt" toDirectory:NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES)[0]];
    
}
#pragma mark - Creating New Folder

-(void)createAction{
    
[[DropBoxWrapper standardWrapper]createDropBoxFolderWithFolderName:@"/FifthFolder"];
    
}

@end
