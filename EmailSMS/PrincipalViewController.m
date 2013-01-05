//
//  PrincipalViewController.m
//  EmailSMS
//
//  Created by Rafael Brigagão Paulino on 13/09/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import "PrincipalViewController.h"

@interface PrincipalViewController ()

@end

@implementation PrincipalViewController

-(IBAction)cliqueSMS:(id)sender
{
    [_campoDestino resignFirstResponder];
    [_campoMensagem resignFirstResponder];
   
    //verificar se o device e capaz de enviar mensagens de texto
    if ([MFMessageComposeViewController canSendText]) {
        //posso enviar sms
        
        //criar uma nova compose view controller
        MFMessageComposeViewController *smsVC = [[MFMessageComposeViewController alloc] init];

        //preciso setar o delegate da compose view controller
        smsVC.messageComposeDelegate = self;
        
        //configurar alguns campos da view controller, mensagem inicial e destinatario(s)
        smsVC.body = _campoMensagem.text;
        
        smsVC.recipients = [NSArray arrayWithObject:_campoDestino.text];
        
        //apresentar composeVC por modal
        [self presentModalViewController:smsVC animated:YES];
        
        
                        
    }
    else
    {
        //device nao compativel
        [[[UIAlertView alloc] initWithTitle:@"SMS" message:@"Seu device não permite envio de mensagens de texto." delegate:nil cancelButtonTitle:@"Fechar" otherButtonTitles: nil] show];
    }
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    UIAlertView *alertaResultado;
    
    if (result == MessageComposeResultSent)
    {
        //sms enviado
        alertaResultado = [[UIAlertView alloc] initWithTitle:@"Sucesso" message:@"Mensagem enviada" delegate:nil cancelButtonTitle:@"Fechar" otherButtonTitles: nil];
    }
    else if (result == MessageComposeResultFailed)
    {
        //sms fALhou no envio
       alertaResultado = [[UIAlertView alloc] initWithTitle:@"Fracasso" message:@"Mensagem não pode ser enviada" delegate:nil cancelButtonTitle:@"Fechar" otherButtonTitles: nil];
    }
    else if (result == MessageComposeResultCancelled)
    {
        //usuario cancelou o envio
       alertaResultado = [[UIAlertView alloc] initWithTitle:@"Cancelamento" message:@"Envio de mensagem cancelada" delegate:nil cancelButtonTitle:@"Fechar" otherButtonTitles: nil];
    }
    
    [alertaResultado show];
    
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)cliqueEmail:(id)sender
{
    [_campoDestino resignFirstResponder];
    [_campoMensagem resignFirstResponder];
    
    if ([MFMailComposeViewController canSendMail]) {
        
        //criar controladora
        MFMailComposeViewController *emailVC = [[MFMailComposeViewController alloc] init];
        
        emailVC.mailComposeDelegate = self;
        
        //configurando a situacao inicial do meu e-mail
        [emailVC setSubject:@"Titulo do meu e-mail"];
        [emailVC setMessageBody:_campoMensagem.text isHTML:YES];
        [emailVC setToRecipients:[NSArray arrayWithObject:_campoDestino.text]];
        
        //criar imagens
        UIImage *image1 = [UIImage imageNamed:@"Accept-Male-User256.png"];
        //converter img para nsdata
        NSData *dadosImage1 = UIImagePNGRepresentation(image1);
        //anexar ao email
        [emailVC addAttachmentData:dadosImage1 mimeType:@"image/png" fileName:@"icone.png"];
        
        [self presentModalViewController:emailVC animated:YES];
        
    }
    else
    {
        //device nao compativel
        [[[UIAlertView alloc] initWithTitle:@"E-mail" message:@"Seu device não permite envio de e-mail." delegate:nil cancelButtonTitle:@"Fechar" otherButtonTitles: nil] show];
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    UIAlertView *alertaResultado;
    
    if (result == MFMailComposeResultSent)
    {
        //email enviado
        alertaResultado = [[UIAlertView alloc] initWithTitle:@"Sucesso" message:@"E-mail enviado" delegate:nil cancelButtonTitle:@"Fechar" otherButtonTitles: nil];
    }
    else if (result == MFMailComposeResultFailed)
    {
        //email fALhou no envio
        alertaResultado = [[UIAlertView alloc] initWithTitle:@"Fracasso" message:@"E-mail não pode ser enviado" delegate:nil cancelButtonTitle:@"Fechar" otherButtonTitles: nil];
    }
    else if (result == MFMailComposeResultCancelled)
    {
        //usuario cancelou o envio
        alertaResultado = [[UIAlertView alloc] initWithTitle:@"Cancelamento" message:@"Envio do e-mail cancelado" delegate:nil cancelButtonTitle:@"Fechar" otherButtonTitles: nil];
    }
    else
    {
        //rascunho salvo
        alertaResultado = [[UIAlertView alloc] initWithTitle:@"Salvo" message:@"Rascunho salvo" delegate:nil cancelButtonTitle:@"Fechar" otherButtonTitles: nil];
    }
    
    [alertaResultado show];
    
    [self dismissModalViewControllerAnimated:YES];
    
}


-(IBAction)cliqueTwitter:(id)sender
{
    [_campoDestino resignFirstResponder];
    [_campoMensagem resignFirstResponder];
    
    //se pode enviar tweet se tem uma conta do twitter configurada
    if ([TWTweetComposeViewController canSendTweet]) {
       
        TWTweetComposeViewController *tweetCompose = [[TWTweetComposeViewController alloc] init];
        
        [tweetCompose setInitialText:_campoMensagem.text];
        
        UIImage *imagem = [UIImage imageNamed:@"Accept-Male-User256.png"];
        [tweetCompose addImage:imagem];
        
        NSLog(@"Teste");
        
        [self presentModalViewController:tweetCompose animated:YES];
    }
    NSLog(@"Teste 123");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
