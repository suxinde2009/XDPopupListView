//
//  MyViewController.h
//  XDPopupListViewDemo
//
//  Created by su xinde on 14-6-25.
//  Copyright (c) 2014年 su xinde. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XDPopupListView.h"

@interface MyViewController : UIViewController
<UITextFieldDelegate, XDPopupListViewDataSource, XDPopupListViewDelegate>
{
    XDPopupListView *mDropDownListView;
    XDPopupListView *mPullupListView;
    XDPopupListView *mDefalutPopupListView;
    XDPopupListView *mTextDropDownListView;
    
    IBOutlet UITextField *mTextField;
    IBOutlet UIButton *mDropDownBtn;
    IBOutlet UIButton *mPullUpBtn;
    IBOutlet UIButton *mDefalutPopupBtn;
    
    
    NSMutableArray *mContentList;
    
}


@end
