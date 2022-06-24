//
//  ComposeViewController.m
//  twitter
//
//  Created by Bienn Viquiera on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *composeField;

@end

@implementation ComposeViewController
- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)tweetAction:(UIButton*)sender {
    sender.enabled = NO;
    
    [[APIManager shared] postStatusWithText:[self.composeField text] completion:^(Tweet *twt, NSError *err) {
        if (twt) {
            NSLog(@"twt success");
            [self.delegate didTweet:twt];
            [self dismissViewControllerAnimated:true completion:nil];
            
        }
        else {
            sender.enabled = YES;

            NSLog(@"twt fail. %@", err.localizedDescription);
            
        }
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField.delegate = self;

}

-(void)textViewDidChange:(UITextView *)textView{
    unsigned long charsize = [self.textField.text length];
    self.charCount.text = [NSString stringWithFormat:@"%lu", charsize];
    if (charsize > 280) {
        self.charCount.textColor = [UIColor systemRedColor];
    }
    if (charsize <= 280) {
        self.charCount.textColor = [UIColor systemGray2Color];
    }
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
