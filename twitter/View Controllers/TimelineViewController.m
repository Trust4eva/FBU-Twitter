//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "ComposingViewController.h"
#import "DetailViewController.h"

@interface TimelineViewController () <UITableViewDelegate, UITableViewDataSource,ComposingViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong,nonatomic) NSMutableArray *Tweets;
@property (strong,nonatomic) Tweet *moreTweets;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.refreshControl addTarget:self action:@selector(RefreshTimeline) forControlEvents:UIControlEventValueChanged];
    [self.myTableView insertSubview:self.refreshControl atIndex:0];
    
    
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    self.myTableView.rowHeight = UITableViewAutomaticDimension;
    
    
    
    [self RefreshTimeline];
}

-(void)RefreshTimeline {
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            self.Tweets = (NSMutableArray *) tweets;
        } else {
            NSLog(@"%@",error.localizedDescription);
        }
        [self.myTableView reloadData];
        [self.refreshControl endRefreshing];
    }];
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

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    Tweet* tweet = self.Tweets[indexPath.row];
    
    [cell setTweets:tweet];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.Tweets.count;
}

- (void)didTweet:(Tweet *)tweet {
    [self RefreshTimeline];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)LogOut:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    [[APIManager shared] logout];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"detailSegue"]){
        UITableViewCell *cell = sender;
        NSIndexPath *indexPath = [self.myTableView indexPathForCell:cell];
        Tweet *tweets = self.Tweets[indexPath.row];
        
        DetailViewController *detailViewController = [segue destinationViewController];
        detailViewController.tweets = tweets;
        [self.myTableView deselectRowAtIndexPath:indexPath animated:YES];
    } else {
        UINavigationController *navigationController = [segue destinationViewController];
        ComposingViewController *composeController = (ComposingViewController*)navigationController.topViewController;
        composeController.delegate = self;
    }
}
    
    
    
    
    






@end
