//
//  ViewController.m
//  HelloRomo
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // To receive messages when Robots connect & disconnect, set RMCore's delegate to self
    [RMCore setDelegate:self];
        
    // Grab a shared instance of the Romo character
    self.Romo = [RMCharacter Romo];
    
    [self addGestureRecognizers];
}

- (void)viewWillAppear:(BOOL)animated
{
    // Add Romo's face to self.view whenever the view will appear
    [self.Romo addToSuperview:self.view];
}

- (void)robotDidConnect:(RMCoreRobot *)robot
{
    if ([robot isKindOfClass:[RMCoreRobotRomo3 class]]) {
        self.Romo3 = (RMCoreRobotRomo3 *)robot;
        
        // When we plug Romo in, he get's excited!
        self.Romo.expression = RMCharacterExpressionExcited;
    }
}

- (void)robotDidDisconnect:(RMCoreRobot *)robot
{
    if (robot == self.Romo3) {
        self.Romo3 = nil;
    }
}

//- (void)swipedLeft:(UIGestureRecognizer *)sender
//{
//    // When the user swipes left, Romo will drive forward
//    [self.Romo3 driveForwardWithSpeed:1.0];
//    //self.Romo.emotion = RMCharacterExpressionLaugh;
//    //sleep(5);
//    //[self.Romo3 stopDriving];
//}

- (void)swipedRight:(UIGestureRecognizer *)sender
{
    // When the user swipes right, Romo will turn in a circle to his right
    self.Romo.emotion = RMCharacterExpressionScared;
    //[self.Romo3 driveBackwardWithSpeed:1.0];
    
}





//// Simply tap the screen to stop Romo
- (void)tappedScreen:(UIGestureRecognizer *)sender
{
//    int numberOfEmotions = 12;
//    
//    // Choose a random emotion from 1 to numberOfEmotions
//    // That's different from the current emotion
//    RMCharacterEmotion randomEmotion = 1 + (arc4random() % numberOfEmotions);
//    
//    self.Romo.emotion = randomEmotion;
    [self.Romo3 stopDriving];
}

#pragma mark -- Adding gesture recognizers --

- (void)addGestureRecognizers
{
   /* // Let's start by adding some gesture recognizers with which to interact with Romo
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedLeft:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];*/
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedRight:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    /*UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedUp:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUp];*/
    
    UITapGestureRecognizer *tapReceived = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedScreen:)];
    [self.view addGestureRecognizer:tapReceived];
    
    /*UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedDown:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeDown];*/
    
}

@end
