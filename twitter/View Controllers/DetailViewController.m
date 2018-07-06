//
//  DetailViewController.m
//  twitter
//
//  Created by Trustin Harris on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "DetailViewController.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *ProfilePic;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *atName;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UILabel *timeStamp;
@property (weak, nonatomic) IBOutlet UILabel *RTCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *RTLabel;
@property (weak, nonatomic) IBOutlet UILabel *favCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *favLabel;
@property (weak, nonatomic) IBOutlet UIButton *RTButton;
@property (weak, nonatomic) IBOutlet UIButton *FavButton;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTweets:self.tweets];
}

-(void)setTweets:(Tweet *)tweets{
    _tweets = tweets;
    self.screenName.text = tweets.user.screenName;
    self.atName.text = [NSString stringWithFormat:@"@%@",tweets.user.AtName];
    self.timeStamp.text = tweets.createdAtString;
    self.tweetText.text = tweets.text;
    
    self.RTCountLabel.text = [NSString stringWithFormat:@"%d", tweets.retweetCount];
    if(tweets.retweetCount < 1){
        self.RTCountLabel.text = @"";
    }
    if(tweets.retweetCount > 1){
        self.RTLabel.text = @"Retweets";
    } else {
        self.RTLabel.text = @"Retweet";
    }
    
    self.favCountLabel.text = [NSString stringWithFormat:@"%d", tweets.favoriteCount];
    if (tweets.favoriteCount < 1){
        self.favCountLabel.text = @"";
    }
    
    if (tweets.favoriteCount > 2){
        self.favLabel.text = @"Likes";
    } else {
        self.favLabel.text = @"Like";
    }
    
    if (tweets.retweeted == YES) {
        self.RTButton.selected = YES;
    } else {
        self.RTButton.selected = NO;
    }
    
    if (tweets.favorited == YES) {
        self.FavButton.selected = YES;
    } else {
        self.FavButton.selected = NO;
    }
    
    [self.ProfilePic setImageWithURL:tweets.user.profilePicURL];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)RTing:(id)sender {
    if(self.tweets.retweeted == NO) {
        
        [[APIManager shared] retweet:self.tweets completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
                self.tweets.retweeted = YES;
                self.tweets.retweetCount += 1;
                self.RTButton.selected = YES;
                self.RTLabel.text = [NSString stringWithFormat:@"%d", self.tweets.retweetCount];
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
                self.RTButton.selected = NO;
                self.RTLabel.text = [NSString stringWithFormat:@"%d", self.tweets.retweetCount];
            }
        }];
    }
}

- (IBAction)pressedFav:(id)sender {
    if (self.tweets.favorited == YES){
        
        [[APIManager shared] unfavorite:self.tweets completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
                self.tweets.favorited = NO;
                self.tweets.favoriteCount -= 1;
                self.FavButton.selected = NO;
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
                self.FavButton.selected = YES;
                self.favLabel.text = [NSString stringWithFormat:@"%d", self.tweets.favoriteCount];
            }
        }];
    }
}




@end
