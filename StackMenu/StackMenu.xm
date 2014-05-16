//#import <SpringBoard/SBAwayView.h>

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import "PCStackMenu.h"
#import <QuartzCore/QuartzCore.h>
#import <Social/Social.h>
#import <ACCOUNTS/ACAccount.h>

@class SLComposeViewController;




static UIWindow *contentWindow = nil;
static SLComposeViewController *slComposerSheet;
static UIViewController *contenVC;



%hook SBAwayController

-(void)lock{
    %orig;
/*UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                  message:@"这是一个简单的警告框！" 
                                                  delegate:nil   
                                                  cancelButtonTitle:@"确定" 
                                                  otherButtonTitles:nil];  
                        [alert show];*/
    
    //__block UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
     
    //UIButton *button = (UIButton *)sender;
    
    
    
    contentWindow = [[UIWindow alloc] initWithFrame:CGRectMake(15, [UIScreen mainScreen].bounds.size.height*0.15, 30,30)];

    
    contentWindow.backgroundColor = [UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:0.3];
    contentWindow.hidden = NO;
    contentWindow.windowLevel = UIWindowLevelAlert;
    contentWindow.layer.borderColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5].CGColor;
    contentWindow.layer.borderWidth = 1.0f;
    contentWindow.layer.cornerRadius = 8;
    


    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 20, 10)];
    button= [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [button setTitle:@"BTN1" forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [contentWindow addSubview:button];
    
    

}

-(void)_finishUnlockWithSound:(BOOL)arg1 unlockSource:(int)arg2 isAutoUnlock:(BOOL)arg3{
    %orig; // Call the original method first
    
    // Remove our window
   contentWindow.hidden = YES;

   contentWindow = nil;
}



%new(v:@)

-(void)btnPressed:(id)sender{
    contenVC = [[UIViewController alloc] init];
    
    [contentWindow makeKeyAndVisible];
    [contentWindow addSubview:contenVC.view];
    
    UIButton* button = (UIButton*)sender;
    //[_headerContainerView addSubview:button];
    PCStackMenu *stackMenu = [[PCStackMenu alloc] initWithTitles:[NSArray arrayWithObjects:@"Setting", @"Search", @"Twitter", @"Message", @"Share", @"More ...", nil]
													  withImages:[NSArray arrayWithObjects:[UIImage imageWithContentsOfFile:@"/Library/gear@2x.png"], [UIImage imageWithContentsOfFile:@"/Library/magnifier@2x.png"], [UIImage imageWithContentsOfFile:@"/Library/twitter@2x.png"], [UIImage imageWithContentsOfFile:@"/Library/speech@2x.png"], [UIImage imageWithContentsOfFile:@"/Library/actions@2x.png"], nil]
													atStartPoint:CGPointMake(button.frame.origin.x+20, button.frame.origin.y + button.frame.size.height)
														  inView:contenVC.view
													  itemHeight:30
												   menuDirection:PCStackMenuDirectionClockWiseDown];
	for(PCStackMenuItem *item in stackMenu.items)
		item.stackTitleLabel.textColor = [UIColor whiteColor];
        
        [stackMenu show:^(NSInteger selectedMenuIndex) {
            [contentWindow makeKeyAndVisible];
            if([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo])
            {
                
                slComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
                //[slComposerSheet setInitialText:self.sharingText];
                //[slComposerSheet addImage:self.sharingImage];
               // [slComposerSheet addURL:[NSURL URLWithString:@"http://www.weibo.com/"]];
                
                [contenVC presentViewController:slComposerSheet animated:YES completion:^(void){
                    [contentWindow resignKeyWindow];
                }];
                //contentWindow = nil;
               
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                               message:@"这是一个简单的警告框！"
                                                              delegate:nil
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil];
                [alert show];
            }
            
            
           // NSLog(@"menu index : %d", selectedMenuIndex);
        }];
}
%end


