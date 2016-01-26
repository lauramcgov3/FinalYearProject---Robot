//
//  ViewController.m
//  HelloRomo
//

#import "ViewController.h"

@implementation ViewController

#pragma mark - View Management
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // To receive messages when Robots connect & disconnect, set RMCore's delegate to self
    [RMCore setDelegate:self];
    
    // Grab a shared instance of the Romo character
    self.Romo = [RMCharacter Romo];
    [RMCore setDelegate:self];
    
    [self addGestureRecognizers];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    // Add Romo's face to self.view whenever the view will appear
    [self.Romo addToSuperview:self.view];
}

#pragma mark - RMCoreDelegate Methods
- (void)robotDidConnect:(RMCoreRobot *)robot
{
    // Currently the only kind of robot is Romo3, so this is just future-proofing
    if ([robot isKindOfClass:[RMCoreRobotRomo3 class]]) {
        self.Romo3 = (RMCoreRobotRomo3 *)robot;
        
        // Change Romo's LED to be solid at 80% power
        [self.Romo3.LEDs setSolidWithBrightness:0.8];
        
        // When you plug Romo in, he gets excited
        self.Romo.expression = RMCharacterExpressionExcited;
    }
}

- (void)robotDidDisconnect:(RMCoreRobot *)robot
{
    if (robot == self.Romo3) {
        self.Romo3 = nil;
        
        // When you unplug Romo in, he gets sad
        self.Romo.expression = RMCharacterExpressionSad;
    }
}

#pragma mark - Gesture recognizers

- (void)addGestureRecognizers
{
    // Let's start by adding some gesture recognizers with which to interact with Romo
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedLeft:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedRight:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedUp:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUp];
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedDown:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown];
    
    UITapGestureRecognizer *tapReceived = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedScreen:)];
    [self.view addGestureRecognizer:tapReceived];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    doubleTap.numberOfTapsRequired = 2; //Adds double table
    [self.view addGestureRecognizer:doubleTap];
}


- (void)swipedLeft:(UIGestureRecognizer *)sender
{
    // When the user swipes left, Romo will turn in a circle to his left
    [self.Romo3 driveWithRadius:-1.0 speed:1.0];
    sleep(3);
    [self.Romo3 stopDriving];

}

- (void)swipedRight:(UIGestureRecognizer *)sender
{
    // When the user swipes right, Romo will turn in a circle to his right
    [self.Romo3 driveWithRadius:1.0 speed:1.0];
}

// Swipe up
- (void)swipedUp:(UIGestureRecognizer *)sender
{
    // Tilt up by ten degrees
    float tiltByAngleInDegrees = 10.0;
     
    [self.Romo3 tiltByAngle:tiltByAngleInDegrees
                  completion:^(BOOL success) {
                  }];
}

// Swipe down
- (void)swipedDown:(UIGestureRecognizer *)sender
{
    // Tilt up by ten degrees
    float tiltByAngleInDegrees = -10.0;
    
    [self.Romo3 tiltByAngle:tiltByAngleInDegrees
                 completion:^(BOOL success) {
                 }];
}

// Simply tap the screen to stop Romo
- (void)tappedScreen:(UIGestureRecognizer *)sender
{
    [self.Romo3 stopDriving];
}

- (void)doubleTap:(UIGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateRecognized)
    {
        // Constants for the number of expression & emotion enum values
        int numberOfExpressions = 19;
        int numberOfEmotions = 7;
        
        // Choose a random expression from 1 to numberOfExpressions
        RMCharacterExpression randomExpression = 1 + (arc4random() % numberOfExpressions);
        
        // Choose a random expression from 1 to numberOfEmotions
        RMCharacterEmotion randomEmotion = 1 + (arc4random() % numberOfEmotions);
        
        [self.Romo setExpression:randomExpression withEmotion:randomEmotion];
    }
}


@end
