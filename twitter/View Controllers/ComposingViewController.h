//
//  ComposingViewController.h
//  twitter
//
//  Created by Trustin Harris on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"


@protocol ComposingViewControllerDelegate

- (void)didTweet:(Tweet *)tweet;


@end

@interface ComposingViewController : UIViewController

@property (nonatomic, weak) id<ComposingViewControllerDelegate> delegate;



@end
