//
//  MyViewController.m
//  XDPopupListViewDemo
//
//  Created by su xinde on 14-6-25.
//  Copyright (c) 2014年 su xinde. All rights reserved.
//

#import "MyViewController.h"
#import "NSString+Utils.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initModels];
    [self initUI];

}

- (void)initModels
{
    mContentList = [[NSMutableArray alloc] initWithCapacity:0];
    [self createLisDatatByStr:@"A"];
}

- (void)initUI
{
    mDropDownBtn.backgroundColor = [UIColor greenColor];
    mDefalutPopupBtn.backgroundColor = [UIColor yellowColor];
    mPullUpBtn.backgroundColor = [UIColor redColor];
    
    mDropDownListView = [[XDPopupListView alloc] initWithBoundView:mDropDownBtn dataSource:self delegate:self popupType:XDPopupListViewDropDown];
    
    mPullupListView = [[XDPopupListView alloc] initWithBoundView:mPullUpBtn dataSource:self delegate:self popupType:XDPopupListViewPullup];
    
    mDefalutPopupListView = [[XDPopupListView alloc] initWithBoundView:mDefalutPopupBtn dataSource:self delegate:self popupType:XDPopupListViewNormal];
    
    mTextDropDownListView = [[XDPopupListView alloc] initWithBoundView:mTextField dataSource:self delegate:self popupType:XDPopupListViewDropDown];
 
    [mTextField addTarget:self action:@selector(textDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
}

- (void)createLisDatatByStr:(NSString *)str
{
    [mContentList removeAllObjects];
    if ([NSString isNullOrEmpty:str]) {
        str = @"Fck";
    }
    for (int i = 0; i < 50; i++) {
        [mContentList addObject:[NSString stringWithFormat:@"%@_%d", str, i]];
    }
}

#pragma mark - XDPopupListViewDataSource & XDPopupListViewDelegate


- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return mContentList.count;
}
- (CGFloat)itemCellHeight:(NSIndexPath *)indexPath
{
    return 44.0f;
}
- (void)clickedListViewAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d: %@", indexPath.row, mContentList[indexPath.row]);
    
    
    
}
- (UITableViewCell *)itemCell:(NSIndexPath *)indexPath
{
    if (mContentList.count == 0) {
        return nil;
    }
    static NSString *identifier = @"ddd";
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    cell.textLabel.text = mContentList[indexPath.row];
    return cell;
}

#pragma mark - Button Click Actions

- (IBAction)dropDownClickAction:(id)sender
{
    [mDropDownListView show];
}

- (IBAction)defaultPopupClickACtion:(id)sender
{
    [mDefalutPopupListView show];
}

- (IBAction)pullUpClickAction:(id)sender
{
    [mPullupListView show];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)textDidChanged:(id)sender
{
    UITextField *textField = (UITextField *)sender;
    if (![NSString isNullOrEmpty:textField.text]) {
        
        [self createLisDatatByStr:textField.text];
        
        [mTextDropDownListView show];
        [mTextDropDownListView reloadListData];
    }

}



@end
