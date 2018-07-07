//
//  ProfileViewController.m
//  twitter
//
//  Created by Trustin Harris on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "User.h"
#import "Tweet.h"
#import "APIManager.h"
#import "UIImageView+AFNetworking.h"
#import "ProfileTableViewCell.h"

@interface ProfileViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *backdropIV;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicIV;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *atName;
@property (weak, nonatomic) IBOutlet UILabel *followingCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersCountLabel;
@property (weak, nonatomic) IBOutlet UITableView *mytableView;
@property (strong,nonatomic) NSMutableArray *UsersArrary;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUser];
    
    self.mytableView.rowHeight = 150;
}

-(void)setUser {
    [[APIManager shared] getProfileData:^(User *user, NSError *error) {
        if(error){
            NSLog(@"Error getting user data: %@", error.localizedDescription);
        }
        else{
            self.screenNameLabel.text = user.screenName;
            self.atName.text = user.AtName;
            [self.profilePicIV setImageWithURL:user.profilePicURL];
            [self.backdropIV setImageWithURL:user.backdropURL];
            self.followersCountLabel.text = [NSString stringWithFormat:@"%@", user.followersCount];
            self.followingCountLabel.text = [NSString stringWithFormat:@"%@", user.followingCount];
        }
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
     ProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    User *user = self.UsersArrary[indexPath.row];
    
    [cell setUser:user];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.UsersArrary.count;
}




@end
