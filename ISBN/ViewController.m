//
//  ViewController.m
//  ISBN
//
//  Created by Christian camilo fernandez on 4/08/16.
//  Copyright © 2016 Carolain Lenes. All rights reserved.
//

#import "ViewController.h"
#import "ManageInternetRequest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [self.txvResponse.layer setBorderWidth:1];
    [self.txvResponse.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)clear:(id)sender{
    [self.txtIsbn setText:@""];
    [self.txvResponse setText:@""];
}

#pragma mark - RequestServer Mail

-(void)requestServer{
    NSUserDefaults * _defaults = [NSUserDefaults standardUserDefaults];
    if ([[_defaults objectForKey:@"connectioninternet"] isEqualToString:@"YES"]) {
        [self mostrarCargando];
        NSOperationQueue * queue1 = [[NSOperationQueue alloc] init];
        [queue1 setMaxConcurrentOperationCount:1];
        NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(envioServerCountry) object:nil];
        [queue1 addOperation:operation];
    }else{
        NSMutableDictionary *msgDict=[[NSMutableDictionary alloc] init];
        [msgDict setValue:@"Atención" forKey:@"Title"];
        [msgDict setValue:@"No tiene conexión a internet." forKey:@"Message"];
        [msgDict setValue:@"Aceptar" forKey:@"Cancel"];
        [msgDict setValue:@"" forKey:@"Aceptar"];
        
        [self performSelectorOnMainThread:@selector(showAlert:) withObject:msgDict
                            waitUntilDone:YES];
    }
}

-(void)envioServerCountry{
    NSMutableDictionary * data = [[NSMutableDictionary alloc] init];
    [data setObject:self.txtIsbn.text forKey:@"isbn"];
    _data = [ManageInternetRequest organizer:@"isbn" data:data];
    NSLog(@"%@",_data);
    [self performSelectorOnMainThread:@selector(ocultarCargando) withObject:nil waitUntilDone:YES];
}

-(void)ocultarCargando{
    if (![_data isEqualToString:@"{}"]) {
        [self.txvResponse setText:_data];
    }else{
        [self.txvResponse setText:@""];
        NSMutableDictionary *msgDict=[[NSMutableDictionary alloc] init];
        [msgDict setValue:@"Atención" forKey:@"Title"];
        [msgDict setValue:@"Oh, parece que algo ocurrio con el internet o simplemente el libro no se encuentra" forKey:@"Message"];
        [msgDict setValue:@"Aceptar" forKey:@"Cancel"];
        [msgDict setValue:@"" forKey:@"Aceptar"];
        
        [self performSelectorOnMainThread:@selector(showAlert:) withObject:msgDict
                            waitUntilDone:YES];
    }
    [self mostrarCargando];
}

#pragma mark - Metodos Vista Cargando

-(void)mostrarCargando{
    @autoreleasepool {
        if (_vistaWait.hidden == TRUE) {
            _vistaWait.hidden = FALSE;
            CALayer * l = [_vistaWait layer];
            [l setMasksToBounds:YES];
            [l setCornerRadius:10.0];
            // You can even add a border
            [l setBorderWidth:1.5];
            [l setBorderColor:[[UIColor whiteColor] CGColor]];
            
            [_indicador startAnimating];
        }else{
            _vistaWait.hidden = TRUE;
            [_indicador stopAnimating];
        }
    }
}


#pragma mark Metodos TextField

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([_txtIsbn isEqual:textField]) {
        [self requestServer];
        [self.view endEditing:true];
    }
    return true;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.5 animations:^{
        [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }];
}

#pragma mark - showAlert metodo

-(void)showAlert:(NSMutableDictionary *)msgDict
{
    if ([[msgDict objectForKey:NSLocalizedString(@"btnAceptar", nil)] length]>0) {
        UIAlertView *alert=[[UIAlertView alloc]
                            initWithTitle:[msgDict objectForKey:@"Title"]
                            message:[msgDict objectForKey:@"Message"]
                            delegate:self
                            cancelButtonTitle:[msgDict objectForKey:@"Cancel"]
                            otherButtonTitles:[msgDict objectForKey:@"btnAceptar"],nil];
        [alert setTag:[[msgDict objectForKey:@"Tag"] intValue]];
        [alert show];
    }else{
        UIAlertView *alert=[[UIAlertView alloc]
                            initWithTitle:[msgDict objectForKey:@"Title"]
                            message:[msgDict objectForKey:@"Message"]
                            delegate:self
                            cancelButtonTitle:[msgDict objectForKey:@"Cancel"]
                            otherButtonTitles:nil];
        [alert setTag:[[msgDict objectForKey:@"Tag"] intValue]];
        [alert show];
    }
}

@end
