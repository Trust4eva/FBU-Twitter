//
//  DetailViewController.h
//  twitter
//
//  Created by Trustin Harris on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface DetailViewController : UIViewController

@property (strong,nonatomic) Tweet *tweets;

@end
