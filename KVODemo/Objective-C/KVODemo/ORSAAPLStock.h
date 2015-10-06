//
//  ORSAAPLStock.h
//  KVODemo
//
//  Created by Andrew Madsen on 10/6/15.
//  Copyright © 2015 Open Reel Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ORSAAPLStock : NSObject

@property (nonatomic, readonly) NSString *stockSymbol;
@property (nonatomic) float price;

@end
