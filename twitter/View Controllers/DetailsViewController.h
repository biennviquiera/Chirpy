//
//  DetailsViewController.h
//  twitter
//
//  Created by Bienn Viquiera on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (nonatomic, weak) TweetCell *passedTweet;
@end

NS_ASSUME_NONNULL_END
