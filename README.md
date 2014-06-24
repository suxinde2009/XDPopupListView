#Description
    
    An iOS pop up list view, like Spinner in Android. You can use it to create Android like controls,
    such as Spinner or AutoCompleteTextView, for your iOS project. It's under MIT license, 
    so help yourself and have fun.

#Example
    
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

    


#Screenshot
![image1](https://raw.github.com/suxinde2009/XDPopupListView/master/snapshot01.png)

![image2](https://raw.github.com/suxinde2009/XDPopupListView/master/snapshot02.png)

![image3](https://raw.github.com/suxinde2009/XDPopupListView/master/snapshot03.png)

![image4](https://raw.github.com/suxinde2009/XDPopupListView/master/snapshot04.png)

#License

The MIT License (MIT)

Copyright (c) 2013 SuXinDe (Email: suxinde2009@126.com)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
