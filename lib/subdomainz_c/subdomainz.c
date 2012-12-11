#include <stdlib.h>
#include <string.h>

/* RFC 2181 */
#define MAXDNSLENGTH 253

char * find_common_subdomain(char *a, char *b){
  long alen     = strnlen(a, MAXDNSLENGTH),
    blen       = strnlen(b, MAXDNSLENGTH);
  char *aptr   = alen + a,
    *bptr      = blen + b,
    *candidate = NULL,
    *common    = NULL;

  while((aptr >= a) && (bptr >= b)){
    if(*aptr != *bptr) break;

    /* a=alpha.foo.com, b=beta.foo.com */
    if(*aptr == '.') candidate = aptr;

    /* a=foo.com, b=beta.foo.com */
    if((aptr == a) && (alen < blen) && bptr[-1] == '.') candidate = aptr;

    /* a=alpha.foo.com, b=foo.com */
    if((bptr == b) && (blen < alen) && aptr[-1]== '.') candidate = aptr;
    
    /* a=foo.com, b=foo.com */
    if((aptr == a) && (bptr = b)) candidate = aptr;

    aptr -= 1 ; bptr -= 1;
  }
  if(candidate == NULL) return NULL;
  common = calloc(strnlen(candidate, MAXDNSLENGTH), sizeof(char));
  strncpy(common, candidate, MAXDNSLENGTH);
  return common;
}

#if 0
int main(int argc, char **argv){
  char *common;
  if(argc != 3) return 1;

  common = find_common_subdomain(argv[1], argv[2]);
  printf("common: %s\n", common);
  free(common);
  return 0;
}
#endif
