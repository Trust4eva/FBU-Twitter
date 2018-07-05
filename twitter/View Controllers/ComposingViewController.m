//
//  ComposingViewController.m
//  twitter
//
//  Created by Trustin Harris on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ComposingViewController.h"
#import "APIManager.h"
#import "Tweet.h"

@interface ComposingViewController ()
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UITextView *tweetView;
@property (weak, nonatomic) IBOutlet UIButton *postButton;

@end

@implementation ComposingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)PostTweet:(id)sender {
    [[APIManager shared] postStatusWithText:self.tweetView.text completion:^(Tweet *tweet, NSError *error) {
        
        if(tweet){
            [self dismissViewControllerAnimated:true completion:nil];
            [self.delegate didTweet:tweet];
            NSLog(@"Tweet successfully posted");
        } else {
            NSLog(@"%@",error.localizedDescription);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
