/*
 The MIT License (MIT)
 
 Copyright (c) 2014 SuXinDe (Email: suxinde2009@126.com)
 
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
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define kDefaultPopupListViewHeight 180.0f
#define kCenterPopupListViewHeight 300.0f
#define kCenterPopupListViewWidth  300.0f

#define kDefalutPopupAnimationDuration 0.35f

@interface UIView (UIShadowBorderEffects)
+ (void)shadowBorder:(UIView *)view;
@end

typedef NS_ENUM(NSInteger, XDPopupListViewType) {
    XDPopupListViewDropDown = 0,
    XDPopupListViewPullup,
    XDPopupListViewNormal
};

@protocol XDPopupListViewDelegate <NSObject>
@optional
- (void)clickedListViewAtIndexPath:(NSIndexPath *)indexPath;
@end

@protocol XDPopupListViewDataSource <NSObject>
@required
- (UITableViewCell *)itemCell:(NSIndexPath *)indexPath;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
@optional
- (NSInteger)numberOfSections;
- (CGFloat)itemCellHeight:(NSIndexPath *)indexPath;
- (NSString *)titleInSection:(NSInteger)section;
@end


@interface XDPopupListView : UIControl  <UITableViewDelegate,UITableViewDataSource>{
    XDPopupListViewType mPopupType;
}

@property (nonatomic, assign) id<XDPopupListViewDelegate> delegate;
@property (nonatomic, assign) id<XDPopupListViewDataSource> dataSource;

@property (nonatomic, retain) UIView *boundView; // 绑定的视图
@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, assign) BOOL isShowing;

- (id)initWithBoundView:(UIView *)boundView
             dataSource:(id)datasource
               delegate:(id)delegate
              popupType:(XDPopupListViewType)popupType;

- (void)bindToView:(UIView *)boundView;

- (void)show;
- (void)dismiss;

- (void)reloadListData;

@end
