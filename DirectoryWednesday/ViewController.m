#import "ViewController.h"

#import "Person.h"

static NSString *dataURL =

@"https://appdev.grinnell.edu/members.json";

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController {
  NSMutableArray <Person *> *people;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  people = [NSMutableArray<Person *> new];
  [self refreshContent];
}

- (void)refreshContent {
  NSURL *properDataURL = [NSURL URLWithString:dataURL];
  // warn on string in task dec first
  NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:properDataURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    NSDictionary<NSString*, NSDictionary*> *parsedResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSArray<NSString *> *keys = [parsedResponse allKeys];
    for (NSString *key in keys) {
      NSDictionary *personDictionary = parsedResponse[key];
      Person *person = [Person new];
      person.name = key;
      person.title = personDictionary[@"title"];
      [people addObject:person];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
      [self.tableView reloadData];
    });
  }];
  [task resume];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return people.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *nextCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  
  Person *peep = people[indexPath.row];
  nextCell.textLabel.text = peep.name;
  nextCell.detailTextLabel.text = peep.title;
  
  return nextCell;
}
@end









