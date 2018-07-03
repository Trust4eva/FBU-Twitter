//
//  TweetCell.m
//  twitter
//
//  Created by Trustin Harris on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"

@implementation TweetCell


-(void)setTweets:(Tweet *)tweets{
    _tweets = tweets;
    
    self.screenName.text = tweets.user.screenName;
    self.atName.text = [NSString stringWithFormat:@"@%@",tweets.user.AtName];
    self.timeStamp.text = tweets.createdAtString;
    self.tweetText.text = tweets.text;
    

    [self.profilePic setImageWithURL:tweets.user.profilePicURL];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
