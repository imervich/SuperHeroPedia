//
//  ViewController.m
//  SuperHeroPedia
//
//  Created by Iván Mervich on 8/4/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *heroes;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	NSDictionary *superperson = @{@"name": @"superperson", @"age": @"24"};
	NSDictionary *spiderperson = @{@"name": @"spiderperson", @"age": @"18"};
	self.heroes = [NSArray arrayWithObjects:superperson, spiderperson, nil];

	NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/mobile-makers-lib/superheroes.json"];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
	 {
		 self.heroes = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
		 [self.tableView reloadData];

		 NSLog(@"%@", self.heroes);
	}];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary *superhero = [self.heroes objectAtIndex:indexPath.row];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCellID"];
	cell.textLabel.text = [superhero objectForKey:@"name"];
	cell.detailTextLabel.text = [superhero objectForKey:@"description"];

	NSURL *url = [NSURL URLWithString:[superhero objectForKey:@"avatar_url"]];
	NSData *data = [NSData dataWithContentsOfURL:url];
	cell.imageView.image = [UIImage imageWithData:data];

	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.heroes count];
}

@end
