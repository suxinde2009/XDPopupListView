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

#import "XDPopupListView.h"


@implementation UIView (UIShadowBorderEffects)

+ (void)shadowBorder:(UIView *)view
{
    view.layer.masksToBounds = NO;
    view.layer.shadowOpacity = 1.0;
    view.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    [view.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
    view.layer.shadowRadius = 5.0;
}

@end


@implementation XDPopupListView

@synthesize tableView = mTableView;
@synthesize boundView = mBoundView;
@synthesize isShowing = mIsShowing;

- (void)dealloc
{
    self.dataSource = nil;
    self.delegate = nil;
    mTableView.dataSource = nil;
    mTableView.delegate = nil;
    [mTableView release];
    [mBoundView release];
    
    [super dealloc];
}

- (id)initWithBoundView:(UIView *)boundView
             dataSource:(id)datasource
               delegate:(id)delegate
              popupType:(XDPopupListViewType)popupType
{
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect frame = CGRectMake(0.0f, 0.0f, screenBounds.size.width, screenBounds.size.height);
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = datasource;
        self.delegate = delegate;
        
        mPopupType = popupType;
        
        mBoundView = [boundView retain];
        
        mTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        mTableView.dataSource = self;
        mTableView.delegate = self;
        
        mTableView.clipsToBounds = YES;
        mTableView.layer.cornerRadius = 10.0f;
        
        mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        //mTableView.backgroundColor = [UIColor clearColor];
        
        [UIView shadowBorder:mTableView];
        
        
        if(popupType == XDPopupListViewNormal){
            self.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
        }
        [self addTarget:self
                 action:@selector(dismiss)
       forControlEvents:UIControlEventTouchUpInside];
        
        mIsShowing = NO;
    }
    return self;
}

- (void)bindToView:(UIView *)boundView
{
    if (mBoundView) {
        [mBoundView release];
        mBoundView = nil;
    }
    mBoundView = [boundView retain];
}

- (void)show
{
    if (mIsShowing) {
        return;
    }
    
    UIWindow *keywindow = [[UIApplication sharedApplication] windows][0];
    //[keywindow addSubview:self];
    
    
    UIView *boundViewSuperView = mBoundView.superview;
    CGRect boundViewframe = mBoundView.frame;
    
    if (mPopupType == XDPopupListViewDropDown) {
        
        mTableView.frame = CGRectMake(CGRectGetMinX(boundViewframe),
                                      CGRectGetMaxY(boundViewframe),
                                      boundViewframe.size.width,
                                      0.0f);
        
        [boundViewSuperView addSubview:self];
        [boundViewSuperView addSubview:mTableView];
        
        
        [UIView animateWithDuration:kDefalutPopupAnimationDuration animations:^{
            mTableView.frame = CGRectMake(CGRectGetMinX(boundViewframe),
                                          CGRectGetMaxY(boundViewframe),
                                          boundViewframe.size.width,
                                          kDefaultPopupListViewHeight);
        } completion:^(BOOL finished) {
            
        }];
        
        
    }else if (mPopupType == XDPopupListViewPullup) {
        
        
        mTableView.frame = CGRectMake(CGRectGetMinX(boundViewframe),
                                      CGRectGetMinY(boundViewframe),
                                      boundViewframe.size.width,
                                      0.0f);
        
        [boundViewSuperView addSubview:self];
        [boundViewSuperView addSubview:mTableView];
        
        
        [UIView animateWithDuration:kDefalutPopupAnimationDuration animations:^{
            
        } completion:^(BOOL finished) {
            mTableView.frame = CGRectMake(CGRectGetMinX(boundViewframe),
                                          CGRectGetMinY(boundViewframe)-kDefaultPopupListViewHeight,
                                          boundViewframe.size.width,
                                          kDefaultPopupListViewHeight);
        }];
        NSLog(@"%f %f", mTableView.frame.origin.x, mTableView.frame.origin.y);
        
    }else {
        [keywindow addSubview:self];
        CGSize winSize = [UIScreen mainScreen].bounds.size;
        mTableView.frame = CGRectMake((winSize.width-kCenterPopupListViewWidth)/2.0f,
                                      (winSize.height-kCenterPopupListViewHeight)/2.0f,
                                      kCenterPopupListViewWidth,
                                      kCenterPopupListViewHeight);
        
        
        NSLog(@"%s: %f %f", __func__, mTableView.bounds.size.width, mTableView.bounds.size.height);
        
        [keywindow addSubview: mTableView];
        
        // fadeIn
        mTableView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        mTableView.alpha = 0;
        [UIView animateWithDuration:kDefalutPopupAnimationDuration animations:^{
            mTableView.alpha = 1;
            mTableView.transform = CGAffineTransformMakeScale(1, 1);
        }];
    }
    
    
    mIsShowing = YES;
    
    
    mTableView.layer.cornerRadius = 10.0f;
    mTableView.clipsToBounds = YES;
    
    [mTableView reloadData];
    
}

- (void)dismiss
{
    if (!mIsShowing) {
        return;
    }
    
    CGRect boundViewframe = mBoundView.frame;
    
    if (mPopupType == XDPopupListViewDropDown) {
        
        [UIView animateWithDuration:kDefalutPopupAnimationDuration animations:^{
            
        } completion:^(BOOL finished) {
            mTableView.frame = CGRectMake(CGRectGetMinX(boundViewframe),
                                          CGRectGetMaxY(boundViewframe),
                                          boundViewframe.size.width,
                                          0.0f);
            
            [mTableView removeFromSuperview];
            [self removeFromSuperview];
        }];
        
        
    }else if (mPopupType == XDPopupListViewPullup) {
        
        [UIView animateWithDuration:kDefalutPopupAnimationDuration animations:^{
            
        } completion:^(BOOL finished) {
            mTableView.frame = CGRectMake(CGRectGetMinX(boundViewframe),
                                          CGRectGetMinY(boundViewframe),
                                          boundViewframe.size.width,
                                          0.0f);
            [mTableView removeFromSuperview];
            [self removeFromSuperview];
        }];
        
    }else {
        
        [UIView animateWithDuration:kDefalutPopupAnimationDuration animations:^{
            mTableView.transform = CGAffineTransformMakeScale(0.5, 0.5);
            mTableView.alpha = 0.0f;
            
        } completion:^(BOOL finished) {
            mTableView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
            [mTableView removeFromSuperview];
            [self removeFromSuperview];
            
        }];
    }
    
    mIsShowing = NO;
}

- (void)reloadListData
{
    [mTableView reloadData];
}

- (void)backTapAction:(id)sender
{
    [self dismiss];
}


#pragma mark -- UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(itemCellHeight:)]) {
        return [self.dataSource itemCellHeight:indexPath];
    }
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(clickedListViewAtIndexPath:)]) {
        [self.delegate clickedListViewAtIndexPath:indexPath];
    }
    [self dismiss];
}

#pragma mark -- UITableView DataSource


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfSections)]) {
        [self.dataSource numberOfSections];
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfRowsInSection:)]) {
        return [self.dataSource numberOfRowsInSection:section];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(itemCell:)]) {
        return [self.dataSource itemCell:indexPath];
    }
    return nil;
}


@end


