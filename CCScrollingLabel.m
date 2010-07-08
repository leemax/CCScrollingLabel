//
//  CCScrollingLabel.m
//
//  Created by Cameron Rudnick (www.conceitedcode.com)
//  All code is provided under the New BSD license.
//

#import "CCScrollingLabel.h"

@implementation CCScrollingLabel
@synthesize pauseInterval;
@synthesize bufferSpaceBetweenLabels;

-(void) setup {        
	for (int i=0; i< 2; i++){
		label[i] = [[UILabel alloc] init];
		label[i].textColor = [UIColor whiteColor];
		label[i].textAlignment = UITextAlignmentCenter;
		label[i].backgroundColor = [UIColor clearColor];
		[self addSubview:label[i]];
	}
	
	scrollDirection =  LEFT;
	scrollSpeed = 30;
	pauseInterval = 2.0f;
	bufferSpaceBetweenLabels = 20;
	self.showsVerticalScrollIndicator = NO;
	self.showsHorizontalScrollIndicator = NO;
	self.userInteractionEnabled = NO;
}

-(id) init {
	if (self = [super init]){
        // Initialization code
		[self setup];
	}
	
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        // Initialization code
		[self setup];
    }
    return self;
	
}


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		[self setup];
    }
    return self;
}


- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	[NSThread sleepForTimeInterval:pauseInterval];
	if ([finished intValue] == 1 && self.frame.size.width < label[0].frame.size.width){
		[self scroll];
	}
}


- (void) updateLabels {
	float offset = 0.0f;
	
	for (int i = 0; i < 2; i++) {
		[label[i] sizeToFit];
		
		CGPoint center = label[i].center;
		center.y = self.center.y - self.frame.origin.y;
		label[i].center = center;
		
		CGRect frame = label[i].frame;
		frame.origin.x = offset;
		label[i].frame = frame;
		
		offset += label[i].frame.size.width + bufferSpaceBetweenLabels;
	}
	
	self.contentSize = CGSizeMake(label[0].frame.size.width + self.frame.size.width + bufferSpaceBetweenLabels,
							 self.frame.size.height);
	
	[self setContentOffset:CGPointMake(0,0) animated:NO];
	
	if (label[0].frame.size.width > self.frame.size.width) {
		
		for (int i = 1; i < 2; i++){
			label[i].hidden = NO;
		}
		[self scroll];
		
	} else {
		
		for (int i = 1; i < 2; i++){
			label[i].hidden = YES;
		}
		
		CGPoint center = label[0].center;
		center.x = self.center.x - self.frame.origin.x;
		label[0].center = center;
		
	}
	
}

- (void) scroll {
	
	if (scrollDirection == LEFT) {
		self.contentOffset = CGPointMake(0,0);
	} else {
		self.contentOffset = CGPointMake(label[0].frame.size.width+bufferSpaceBetweenLabels, 0);
	}
	
	[UIView beginAnimations:@"scroll" context:nil];
    [UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:label[0].frame.size.width/(float)scrollSpeed];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	
	if (scrollDirection ==  LEFT) {
		self.contentOffset = CGPointMake(label[0].frame.size.width+bufferSpaceBetweenLabels, 0);
	} else {
		self.contentOffset = CGPointMake(0,0);
	}		
	
	[UIView commitAnimations];
	
}

#pragma mark - GETTERS/SETTERS

- (void) setText: (NSString *) text {
	if ([text isEqualToString:label[0].text]){
		return;
	}
	
	for (int i=0; i<2; i++){
		label[i].text = text;
	}
	[self updateLabels];
}


- (NSString *) text {
	return label[0].text;
}


- (void) setTextColor:(UIColor *)color {
	for (int i=0; i<2; i++){
		label[i].textColor = color;
	}
}

- (UIColor *) textColor {
	return label[0].textColor;
}


- (void) setFont:(UIFont *)font {
	for (int i=0; i<2; i++){
		label[i].font = font;
	}
	[self updateLabels];
}

- (UIFont *) font {
	return label[0].font;
}


- (void) setScrollSpeed: (float)speed {
	scrollSpeed = speed;
	[self updateLabels];
}

- (float) scrollSpeed {
	return scrollSpeed;
}

- (void) setScrollDirection: (enum ScrollDirection)direction {
	scrollDirection = direction;
	[self updateLabels];
}

- (enum ScrollDirection) scrollDirection {
	return scrollDirection;
}

- (void) dealloc {
	for (int i=0; i<2; i++){
		[label[i] release];
	}
    [super dealloc];
}

@end