/*
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
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 @brief 字符串工具类。该类为NSString类Category，提供一些字符串操作的工具方法。
 */
@interface NSString (Utils)


/**
 判断给定字符串s是否为空
 @param s 待判断字符串
 @returns
 TRUE	字符串str为空
 FALSE	字符串str非空
 */
+ (BOOL)isNullOrEmpty:(NSString *)s;


/**
 判断给定手机号字符串mobile是否有效
 @param mobile 待判断手机号字符串
 @returns
 TRUE	手机号字符串mobile有效
 FALSE	手机号字符串mobile无效
 */
+ (BOOL)validateMobile:(NSString *)mobile;


/**
 判断是否含有子串string
 @param string 待判断字符串子串
 @returns
 TRUE	含有字符串子串string
 FALSE	不含有字符串子串string
 */
- (BOOL)hasSubString:(NSString *)string;


/**
 验证是否是有效邮箱
 @param emailAddress 待验证邮箱地址
 @returns
 TRUE	有效邮箱格式
 FALSE	无效邮箱格式
 */
+ (BOOL)validatEmail:(NSString *)emailAddress;


/**
 对url字符串进行编码，防止中文乱码
 @returns 返回经编码的url字符串
 */
- (id)urlEncoded;

/**
 对url字符串进行解码，防止中文乱码
 @returns 返回经解码的url字符串
 */
- (NSString*)urlDecoded;


//
/**
 根据给定宽度、字体和粗体设置计算文本完整显示所需Size大小
 @param width 字符串显示的宽度
 @param fontSize 字符串字体大小
 @param isBold 是否粗体
 @returns 返回字符串完整显示所需Size大小
 */
- (CGSize)wrapString:(float)width
            fontSize:(float)fontSize
              isBold:(BOOL)isBold;


/**
 根据给定宽度、字体和粗体设置计算文本完整显示所需高度
 @param width 字符串显示的宽度
 @param fontSize 字符串字体大小
 @param isBold 是否粗体
 @returns 返回字符串完整显示所需高度
 */
- (float)wrapStringHeight:(float)width
                 fontSize:(float)fontSize
                   isBold:(BOOL)isBold;


//
+ (NSString *)trimAngleBracketsAndBlanks:(NSString *)str;


+ (NSString *)trimShortHorizontalBar:(NSString *)str;


@end
