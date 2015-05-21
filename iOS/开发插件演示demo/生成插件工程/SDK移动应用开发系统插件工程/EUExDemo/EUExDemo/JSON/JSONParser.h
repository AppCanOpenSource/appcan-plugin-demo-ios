//
//  JSONParser.h
//  HZiPadReader
//
//  Created by starinno-005 on 11-3-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

 
@interface JSONParser : NSObject {

}

+(NSMutableArray *)parserUrlData:(NSString *)URLString isAllValues:(BOOL)isAllValues  valueForKey:(NSString *)valueForKey;
+(id)parserData:   (NSData *)ndMain      isAllValues:(BOOL)isAllValues  valueForKey:(NSString *)valueForKey;

@end
