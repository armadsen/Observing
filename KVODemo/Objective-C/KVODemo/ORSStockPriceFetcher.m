//
//  ORSStockPriceFetcher.m
//  KVODemo
//
//  Created by Andrew Madsen on 10/6/15.
//  Copyright © 2015 Open Reel Software. All rights reserved.
//

#import "ORSStockPriceFetcher.h"
#import "ORSStock.h"

@implementation ORSStockPriceFetcher

- (instancetype)initWithStock:(ORSStock *)stock
{
	self = [super init];
	if (self) {
		_stock = stock;
		[_stock addObserver:self forKeyPath:@"symbol" options:0 context:NULL];
		[self updateStockPrice];
	}
	return self;
}

- (void)dealloc
{
	[_stock removeObserver:self forKeyPath:@"symbol"];
}

- (void)updateStockPrice
{
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.google.com/finance/info?q=%@", self.stock.symbol]];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	[[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		if (error) {
			NSLog(@"Error fetching price of %@: %@", self.stock, error);
			return;
		}
		
		data = [data subdataWithRange:NSMakeRange(5, [data length]-7)];
		
		NSError *localError = nil;
		NSDictionary *priceInfo = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
		if (!priceInfo) {
			NSLog(@"Error parsing stock price info for %@: %@", self.stock, localError);
			return;
		}
		
		self.stock.price = [priceInfo[@"l"] floatValue];
	}] resume];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
	if (object == self.stock && [keyPath isEqualToString:@"symbol"]) {
		[self updateStockPrice];
	}
}

@end
