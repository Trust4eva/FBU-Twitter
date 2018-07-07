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
@property (weak, nonatomic) IBOutlet UITextView *tweetView;
@property (weak, nonatomic) IBOutlet UIButton *postButton;
@property (weak, nonatomic) IBOutlet UILabel *characterLabel;

@end

@implementation ComposingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tweetView.delegate = self;
    self.postButton.layer.cornerRadius = self.postButton.frame.size.height/3;
    
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    // Set the max character limit
    int characterLimit = 140;
    
    // Construct what the new text would be if we allowed the user's latest edit
    NSString *newText = [self.tweetView.text stringByReplacingCharactersInRange:range withString:text];
    
    // TODO: Update Character Count Label
    self.characterLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)(140 -newText.length)];
    
    // The new text should be allowed? True/False
    return newText.length < characterLimit;
    }

- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.tweetView = textView;
    self.tweetView.text = @"";
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
