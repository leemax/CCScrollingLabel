//
//  CCScrollingLabel.h
//
//  Created by Cameron Rudnick (www.conceitedcode.com)
//  All code is provided under the New BSD license.
//

#import <UIKit/UIKit.h>

enum ScrollDirection {
	RIGHT,
	LEFT,
};

@interface CCScrollingLabel : UIScrollView <UIScrollViewDelegate>{
	UILabel					*label[2];
	
	NSTimeInterval			pauseInterval;
	
	float					scrollSpeed;
	enum ScrollDirection	scrollDirection;
	int						bufferSpaceBetweenLabels;
}

@property(nonatomic) NSTimeInterval				pauseInterval;

@property(nonatomic) enum ScrollDirection		scrollDirection;
@property(nonatomic) float						scrollSpeed;
@property(nonatomic) int						bufferSpaceBetweenLabels;

@property(nonatomic, retain) UIColor			*textColor;
@property(nonatomic, retain) UIFont				*font;

- (void) updateLabels;
- (void) scroll;

- (void) setText: (NSString *) text;
- (NSString *) text;

@end
