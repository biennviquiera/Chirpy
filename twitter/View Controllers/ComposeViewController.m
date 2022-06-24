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

- (IBAction)tweetAction:(id)sender {
//    [[APIManager shared] postStatusWithText:[sender text]^(Tweet *te, NSError *err) {
//
//    }
//
//    ];
    [[APIManager shared] postStatusWithText:[self.composeField text] completion:^(Tweet *twt, NSError *err) {
        if (twt) {
            NSLog(@"twt success");
            [self.delegate didTweet:twt];
            //dismiss the viewcontroller
            [self dismissViewControllerAnimated:true completion:nil];
            
        }
        else {
            NSLog(@"twt fail. %@", err.localizedDescription);
            
        }
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textField.delegate = self;

}

-(void)textViewDidChange:(UITextView *)textView{
    
    self.charCount.text = [NSString stringWithFormat:@"%d", [self.textField.text length]];
    
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
