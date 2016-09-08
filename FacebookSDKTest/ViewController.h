//
//  ViewController.h
//  FacebookSDKTest
//
//  Created by 家彥 陳 on 2016/9/3.
//  Copyright © 2016年 Chen-Chia-Yen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    
}

@property (weak, nonatomic) IBOutlet UIImageView *facebookPicture;
@property (weak, nonatomic) IBOutlet UIButton *facebookLogin;
@property (weak, nonatomic) IBOutlet UITableView *tableview;


//@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;
- (IBAction)facebookLoginHasBeenClick:(id)sender;

@end

