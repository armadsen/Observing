//
//  ViewController.m
//  KVODemo
//
//  Created by Andrew Madsen on 10/6/15.
//  Copyright © 2015 Open Reel Software. All rights reserved.
//

#import "ViewController.h"
#import "ORSStock.h"
#import "ORSStockPriceFetcher.h"

@interface ViewController () <UITextFieldDelegate>

@property (nonatomic, strong) ORSStock *stock;
@property (nonatomic, strong) ORSStockPriceFetcher *stockFetcher;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.stock = [[ORSStock alloc] init];
	self.stock.symbol = @"AAPL";
	self.stockFetcher = [[ORSStockPriceFetcher alloc] initWithStock:self.stock];
}

- (void)dealloc
{
	self.stock = nil;
}

- (IBAction)changeStockSymbol:(UITextField *)sender
{
	self.stock.symbol = sender.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
	if (object == self.stock) {
		dispatch_async(dispatch_get_main_queue(), ^{
			self.priceLabel.text = [@(self.stock.price) stringValue];
		});
	}
}


-(void)setStock:(ORSStock *)stock
{
	if (stock != _stock) {
		[_stock removeObserver:self forKeyPath:@"price"];
		_stock = stock;
		[_stock addObserver:self forKeyPath:@"price" options:0 context:NULL];
	}
}

@end
