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
    [self updateRTorFavLabel];
    
    self.favCountLabel.text = [NSString stringWithFormat:@"%d", tweets.favoriteCount];
    [self updateRTorFavLabel];
    
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
    self.ProfilePic.layer.cornerRadius = self.ProfilePic.frame.size.height/2;
    self.ProfilePic.layer.masksToBounds = YES;
}

-(void)updateRTorFavLabel {
    if(_tweets.retweetCount == 1){
        self.RTCountLabel.text = [NSString stringWithFormat:@"%d", _tweets.retweetCount];
        self.RTLabel.text = @"Retweet";
    } else {
        self.RTCountLabel.text = [NSString stringWithFormat:@"%d", _tweets.retweetCount];
        self.RTLabel.text = @"Retweets";
    }
    
    if (_tweets.favoriteCount == 1){
        self.favLabel.text = @"Like";
         self.favCountLabel.text = [NSString stringWithFormat:@"%d", _tweets.favoriteCount];
    } else {
        self.favLabel.text = @"Likes";
        self.favCountLabel.text = [NSString stringWithFormat:@"%d", _tweets.favoriteCount];
    }
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
                self.RTCountLabel.text = [NSString stringWithFormat:@"%d", self.tweets.retweetCount];
                [self updateRTorFavLabel];
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
                self.RTCountLabel.text = [NSString stringWithFormat:@"%d", self.tweets.retweetCount];
                [self updateRTorFavLabel];
            }
        }];
    }
    [self updateRTorFavLabel];
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
                self.favCountLabel.text = [NSString stringWithFormat:@"%d", self.tweets.favoriteCount];
                [self updateRTorFavLabel];
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
                self.favCountLabel.text = [NSString stringWithFormat:@"%d", self.tweets.favoriteCount];
                [self updateRTorFavLabel];
            }
        }];
    }
}

- (IBAction)replyButton:(id)sender {
    
    NSString *title = @"Sorry!";
    NSString *message = @"THIS BUTTON IS JUST FOR LOOKS. IT DOESN'T DO ANYTHING!";
    NSString *text = @"I GOT IT!";
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *button = [UIAlertAction actionWithTitle:text style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:button];
    
    [self presentViewController:alert animated:YES completion:nil];
}





@end
