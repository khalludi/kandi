#include "screen.h"

void main() {
  // Create a pointer to a char, and point it to the first text cell of
  // video memory (top-left of the screen)
  char* video_memory = (char*) 0xb8000;
  // At the address pointed to by video_memory, store the character 'X'
  // (display 'X' in the top-left of the screen).
  *video_memory = 'X';
  
  // Test print a message
  print_char('A', 3, 3, 0);
  print_char('A', -1, -1, 0);
}
