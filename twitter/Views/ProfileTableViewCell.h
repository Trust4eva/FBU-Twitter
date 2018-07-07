//
//  ProfileTableViewCell.h
//  twitter
//
//  Created by Trustin Harris on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ProfileTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UIImageView *ProfilePic;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *atName;
@property (weak, nonatomic) IBOutlet UILabel *timeStamp;
@property(strong,nonatomic)User *user;

@end
