#import "ViewController.h"

#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController {
  NSArray <Person *> *people;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  Person *alex = [Person new];
  alex.name = @"alex";
  alex.title = @"dude";
  
  Person *bob = [[Person alloc] init];
  bob.name = @"bob";
  bob.title = @"fisher";
  
  people = @[alex, bob];
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









