//
//  ViewController.m
//  GithubRepos
//
//  Created by Hyung Jip Moon on 2017-02-27.
//  Copyright © 2017 leomoon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *storeReposURL;
@property NSArray *repos;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/users/leomoondev/repos"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error) {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        NSError *jsonError = nil;
        self.repos = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if(jsonError) {
            //Handle the error
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return ;
        }
        
        // If we reach this point, we have successfully retrieved the JSON from the API
        for(NSDictionary *repo in self.repos) {
            NSString *repoName = repo[@"name"];
            NSLog(@"repo: %@", repoName);
        }
        [self.storeReposURL reloadData];
    }];
    
    [dataTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.repos.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    NSDictionary *dict = self.repos[indexPath.row];
    NSString *name = dict[@"name"];
    cell.textLabel.text = name;
    
    return cell;

}


@end
