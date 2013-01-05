//
//  PrincipalViewController.h
//  EmailSMS
//
//  Created by Rafael Brigagão Paulino on 13/09/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <Twitter/Twitter.h>

@interface PrincipalViewController : UIViewController <MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UITextView *campoMensagem;
@property (nonatomic, weak) IBOutlet UITextField *campoDestino;

-(IBAction)cliqueSMS:(id)sender;
-(IBAction)cliqueEmail:(id)sender;
-(IBAction)cliqueTwitter:(id)sender;

@end
