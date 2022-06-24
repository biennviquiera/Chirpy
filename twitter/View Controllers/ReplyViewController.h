//
//  ReplyViewController.h
//  twitter
//
//  Created by Bienn Viquiera on 6/24/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReplyViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userHandle;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *quotedTweet;
@property (weak, nonatomic) IBOutlet UITextView *replyField;
@property (weak, nonatomic) IBOutlet UILabel *replyingToLabel;

@end

NS_ASSUME_NONNULL_END
