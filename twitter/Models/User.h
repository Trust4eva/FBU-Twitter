//
//  User.h
//  twitter
//
//  Created by Trustin Harris on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (strong,nonatomic) NSString *screenName;
@property (strong,nonatomic) NSString *AtName;
@property (strong,nonatomic) NSURL *profilePicURL;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;



@end
