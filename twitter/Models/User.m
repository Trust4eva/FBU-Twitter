//
//  User.m
//  twitter
//
//  Created by Trustin Harris on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "User.h"
#import "APIManager.h"

@implementation User

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if(self) {
        self.screenName = dictionary[@"name"];
        self.AtName = dictionary[@"screen_name"];
        self.profilePicURL = [NSURL URLWithString:dictionary[@"profile_image_url"]];
        self.backdropURL = [NSURL URLWithString:dictionary[@"profile_banner_url"]];
        self.followersCount = dictionary[@"followers_count"];
        self.followingCount = dictionary[@"friends_count"];
    }
    return self;
}

+ (NSMutableArray *)UserWithArray:(NSArray *)dictionaries {
    NSMutableArray *user = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dictionary in dictionaries) {
        User *myuser = [[User alloc] initWithDictionary:dictionary];
        [user addObject:myuser];
    }
    return user;
}


@end
