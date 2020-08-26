//
//  main.m
//  Hangman
//
//  Created by Viktor on 26.08.2020.
//  Copyright © 2020 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

void printWord(NSString *word, NSMutableArray<NSString*> *usedLetters) {
    printf("\nWorld: ");
    BOOL missingLetters = NO;
    
    for (NSInteger i = 0; i < [word length]; ++i) {
        unichar letter = [word characterAtIndex:i];
        NSString *letterString = [NSString stringWithFormat:@"%C", letter];
        
        if ([usedLetters containsObject:letterString]) {
            printf("%C", letter);
        } else {
            printf("_");
            missingLetters = YES;
        }
    }
    
    printf("\nGuesses: %ld/8\n", [usedLetters count]);
    
    if (missingLetters == NO) {
        printf("It looks like you live on... for now.\n");
        exit(0);
    } else {
        if ([usedLetters count] == 8) {
            printf("Oops - you died! The word was %s.\n", [word cStringUsingEncoding:NSUTF8StringEncoding]);
            exit(0);
        } else {
            printf("Enter a guess: ");
        }
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *word = @"RHYTM";
        NSMutableArray<NSString*> *usedLetters = [NSMutableArray arrayWithCapacity:8];
        
        printf("Welcome to Hangman!\n");
        printf("Press a letter to guess, or Ctr+C to quit. \n");
        while(1) {
            char cstring[256];
            scanf("%s", cstring);
            
            NSString *input = [NSString stringWithCString:cstring encoding:NSUTF8StringEncoding];
            
            if ([input length] != 1) {
                printf("Please type exactly one letter, or Ctrl+C to quit.");
            } else {
                unichar letter = [input characterAtIndex:0];
                NSString *letterString = [[NSString stringWithFormat:@"%C", letter] uppercaseString];
                
                if ([usedLetters containsObject:letterString]) {
                    printf("You used that letters already! \n");
                } else {
                    [usedLetters addObject:letterString];
                }
            }
            printWord(word, usedLetters);
        }
    }
    return 0;
}
