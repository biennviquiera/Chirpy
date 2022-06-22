//
//  ComposeViewController.m
//  twitter
//
//  Created by Bienn Viquiera on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()
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
            //dismiss the viewcontroller
            [self dismissViewControllerAnimated:true completion:nil];
            
        }
        else {
            NSLog(@"twt fail");
        }
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
