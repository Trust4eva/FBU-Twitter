//
//  ProfileTableViewCell.m
//  twitter
//
//  Created by Trustin Harris on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ProfileTableViewCell.h"
#import "User.h"
#import "APIManager.h"
#import "UIImageView+AFNetworking.h"


@implementation ProfileTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



-(void)setUser {
    self.screenName.text = _user.screenName;
    self.atName.text = _user.AtName;
}











- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
