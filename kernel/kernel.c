#include "screen.h"

void main() {
  // Create a pointer to a char, and point it to the first text cell of
  // video memory (top-left of the screen)
  char* video_memory = (char*) 0xb8000;
  // At the address pointed to by video_memory, store the character 'X'
  // (display 'X' in the top-left of the screen).
  *video_memory = 'X';
  
  // Test print a message
  print("Hello");
  print(", World!");

  // Test scrolling
  print_char('A', 23, 0, 0);
  for(int i = 0; i < 11; i++) {
    print("Goodbye, Test!");
  }
  for (int i = 0; i < 4; i++) {
    print_char('X', -1, -1, 0);
  }
  print_char('K', -1, -1, 0);
  print("A new line! WOW :D");
}
