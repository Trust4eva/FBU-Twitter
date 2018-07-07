//
//  ProfileViewController.h
//  twitter
//
//  Created by Trustin Harris on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Tweet.h"
#import "APIManager.h"

@interface ProfileViewController : UIViewController

@property(strong,nonatomic)User *user;

@end
