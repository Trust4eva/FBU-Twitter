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
#import "APIManager.h"

@implementation TweetCell


-(void)setTweets:(Tweet *)tweets{
    _tweets = tweets;
    
    self.screenName.text = tweets.user.screenName;
    self.atName.text = [NSString stringWithFormat:@"@%@",tweets.user.AtName];
    self.timeStamp.text = tweets.createdAtString;
    self.tweetText.text = tweets.text;
    
    self.retweetLabel.text = [NSString stringWithFormat:@"%d", tweets.retweetCount];
    if(tweets.retweetCount < 1){
        self.retweetLabel.text = @"";
    }
    
    self.favLabel.text = [NSString stringWithFormat:@"%d", tweets.favoriteCount];
    if (tweets.favoriteCount < 1){
        self.favLabel.text = @"";
    }
    
    if (tweets.retweeted == YES) {
        self.retweetButton.selected = YES;
    } else {
        self.retweetButton.selected = NO;
    }
    
    if (tweets.favorited == YES) {
        self.favButton.selected = YES;
    } else {
        self.favButton.selected = NO;
    }
    
    [self.profilePic setImageWithURL:tweets.user.profilePicURL];
    self.profilePic.layer.cornerRadius = self.profilePic.frame.size.height/2;
    self.profilePic.layer.masksToBounds = YES;
}


- (IBAction)retweetButton:(id)sender {
    if(self.tweets.retweeted == NO) {
        
        [[APIManager shared] retweet:self.tweets completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
                self.tweets.retweeted = YES;
                self.tweets.retweetCount += 1;
                self.retweetButton.selected = YES;
                self.retweetLabel.text = [NSString stringWithFormat:@"%d", self.tweets.retweetCount];
            }
        }];
    } else {
        
        [[APIManager shared] unretweet:self.tweets completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeting the following Tweet: %@", tweet.text);
                self.tweets.retweeted = NO;
                self.tweets.retweetCount -= 1;
                self.retweetButton.selected = NO;
                self.retweetLabel.text = [NSString stringWithFormat:@"%d", self.tweets.retweetCount];
            }
        }];
    }
}

- (IBAction)favButton:(id)sender {
    if (self.tweets.favorited == YES){
        
        [[APIManager shared] unfavorite:self.tweets completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
                self.tweets.favorited = NO;
                self.tweets.favoriteCount -= 1;
                self.favButton.selected = NO;
                self.favLabel.text = [NSString stringWithFormat:@"%d", self.tweets.favoriteCount];
            }
        }];
        
    } else {
    
    [[APIManager shared] favorite:self.tweets completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            self.tweets.favorited = YES;
            self.tweets.favoriteCount += 1;
            self.favButton.selected = YES;
            self.favLabel.text = [NSString stringWithFormat:@"%d", self.tweets.favoriteCount];
        }
    }];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
