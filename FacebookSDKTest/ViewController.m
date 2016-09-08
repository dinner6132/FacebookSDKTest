//
//  ViewController.m
//  FacebookSDKTest
//
//  Created by 家彥 陳 on 2016/9/3.
//  Copyright © 2016年 Chen-Chia-Yen. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface ViewController ()


@property (nonatomic, strong) NSMutableDictionary *dataOfResult;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if ([FBSDKAccessToken currentAccessToken])
    {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id,picture"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
             {
                 NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", result[@"id"]]];
                 NSData *imageData = [NSData dataWithContentsOfURL:pictureURL];
                 UIImage *fbImage = [UIImage imageWithData:imageData];
                 self.facebookPicture.image = fbImage;
                 
             }
             else
             {
                 NSLog(@"error : %@",error);
             }
         }];
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, email"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
             {
                 self.dataOfResult = [[NSMutableDictionary alloc] init];
                 self.dataOfResult = result;
                 
                 //NSLog(@"dataOfResult=%@",self.dataOfResult);
                 [self.tableview reloadData];
             }
             else
             {
                 NSLog(@"error : %@",error);
             }
         }];
        
        [self.facebookLogin setTitle:@"Facebook Logout" forState:UIControlStateNormal];
    }else{
        [self.facebookLogin setTitle:@"Facebook Login" forState:UIControlStateNormal];
        [self.tableview reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)facebookLoginHasBeenClick:(id)sender {
    if([FBSDKAccessToken currentAccessToken]){
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logOut];
        [self.facebookLogin setTitle:@"Facebook Login" forState:UIControlStateNormal];
    }else{
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login
         logInWithReadPermissions: @[@"public_profile"]
         fromViewController:self
         handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
             if (error) {
                 NSLog(@"Process error");
             } else if (result.isCancelled) {
                 NSLog(@"Cancelled");
             } else {
                 NSLog(@"Logged in");
                 [self viewDidLoad];
                 [self.facebookLogin setTitle:@"Facebook Logout" forState:UIControlStateNormal];
             }
         }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return [self.dataOfResult count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSString *key = [self.dataOfResult allKeys][indexPath.row];
    NSString *providerNameString = self.dataOfResult[key];
    NSString *providerIdString = key;
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ = %@",providerIdString,providerNameString];
    
    
    return cell;
}
@end
