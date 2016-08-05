//
//  ViewController.h
//  ISBN
//
//  Created by Christian camilo fernandez on 4/08/16.
//  Copyright © 2016 Carolain Lenes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

// Indicador
@property(nonatomic,weak)IBOutlet UITextView *txvResponse;
@property(nonatomic,weak)IBOutlet UITextField *txtIsbn;
@property(nonatomic,weak)IBOutlet UIView *vistaWait;
@property(nonatomic,weak)IBOutlet UIActivityIndicatorView *indicador;

@property(nonatomic,strong)NSString * data;

@end

