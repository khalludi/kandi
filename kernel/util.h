// Helper prepocesser directives
#define low_16(address) (u16)((address) & 0xFFFF)
#define high_16(address) (u16)(((address) >> 16) & 0xFFFF)


// Function prototypes
void memory_copy(char* source, char* dest, int no_bytes);
