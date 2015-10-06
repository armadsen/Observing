//
//  ORSAAPLStock.m
//  KVODemo
//
//  Created by Andrew Madsen on 10/6/15.
//  Copyright © 2015 Open Reel Software. All rights reserved.
//

#import "ORSAAPLStock.h"

@implementation ORSAAPLStock

- (instancetype)init
{
	self = [super init];
	if (self) {
		_stockSymbol = @"AAPL";
	}
	return self;
}

@end
