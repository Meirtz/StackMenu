#line 1 "/Users/meirtz/Desktop/StackMenu/StackMenu/StackMenu.xm"


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



#include <logos/logos.h>
#include <substrate.h>
@class SBAwayController; 
static void (*_logos_orig$_ungrouped$SBAwayController$lock)(SBAwayController*, SEL); static void _logos_method$_ungrouped$SBAwayController$lock(SBAwayController*, SEL); static void (*_logos_orig$_ungrouped$SBAwayController$_finishUnlockWithSound$unlockSource$isAutoUnlock$)(SBAwayController*, SEL, BOOL, int, BOOL); static void _logos_method$_ungrouped$SBAwayController$_finishUnlockWithSound$unlockSource$isAutoUnlock$(SBAwayController*, SEL, BOOL, int, BOOL); static void _logos_method$_ungrouped$SBAwayController$btnPressed$(SBAwayController*, SEL, id); 

#line 21 "/Users/meirtz/Desktop/StackMenu/StackMenu/StackMenu.xm"


static void _logos_method$_ungrouped$SBAwayController$lock(SBAwayController* self, SEL _cmd){
    _logos_orig$_ungrouped$SBAwayController$lock(self, _cmd);






    
    
     
    
    
    
    
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

static void _logos_method$_ungrouped$SBAwayController$_finishUnlockWithSound$unlockSource$isAutoUnlock$(SBAwayController* self, SEL _cmd, BOOL arg1, int arg2, BOOL arg3){
    _logos_orig$_ungrouped$SBAwayController$_finishUnlockWithSound$unlockSource$isAutoUnlock$(self, _cmd, arg1, arg2, arg3); 
    
    
   contentWindow.hidden = YES;

   contentWindow = nil;
}





static void _logos_method$_ungrouped$SBAwayController$btnPressed$(SBAwayController* self, SEL _cmd, id sender){
    contenVC = [[UIViewController alloc] init];
    
    [contentWindow makeKeyAndVisible];
    [contentWindow addSubview:contenVC.view];
    
    UIButton* button = (UIButton*)sender;
    
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
                
                
               
                
                [contenVC presentViewController:slComposerSheet animated:YES completion:^(void){
                    [contentWindow resignKeyWindow];
                }];
                
               
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
            
            
           
        }];
}



static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBAwayController = objc_getClass("SBAwayController"); MSHookMessageEx(_logos_class$_ungrouped$SBAwayController, @selector(lock), (IMP)&_logos_method$_ungrouped$SBAwayController$lock, (IMP*)&_logos_orig$_ungrouped$SBAwayController$lock);MSHookMessageEx(_logos_class$_ungrouped$SBAwayController, @selector(_finishUnlockWithSound:unlockSource:isAutoUnlock:), (IMP)&_logos_method$_ungrouped$SBAwayController$_finishUnlockWithSound$unlockSource$isAutoUnlock$, (IMP*)&_logos_orig$_ungrouped$SBAwayController$_finishUnlockWithSound$unlockSource$isAutoUnlock$);{ const char *_typeEncoding = "v:@"; class_addMethod(_logos_class$_ungrouped$SBAwayController, @selector(btnPressed:), (IMP)&_logos_method$_ungrouped$SBAwayController$btnPressed$, _typeEncoding); }} }
#line 127 "/Users/meirtz/Desktop/StackMenu/StackMenu/StackMenu.xm"
