/*******************************************************************************

License:
This software and/or related materials was developed at the National Institute
of Standards and Technology (NIST) by employees of the Federal Government
in the course of their official duties. Pursuant to title 17 Section 105
of the United States Code, this software is not subject to copyright
protection and is in the public domain.

This software and/or related materials have been determined to be not subject
to the EAR (see Part 734.3 of the EAR for exact details) because it is
a publicly available technology and software, and is freely distributed
to any interested party with no licensing requirements.  Therefore, it is
permissible to distribute this software as a free download from the internet.

Disclaimer:
This software and/or related materials was developed to promote biometric
standards and biometric technology testing for the Federal Government
in accordance with the USA PATRIOT Act and the Enhanced Border Security
and Visa Entry Reform Act. Specific hardware and software products identified
in this software were used in order to perform the software development.
In no case does such identification imply recommendation or endorsement
by the National Institute of Standards and Technology, nor does it imply that
the products and equipment identified are necessarily the best available
for the purpose.

This software and/or related materials are provided "AS-IS" without warranty
of any kind including NO WARRANTY OF PERFORMANCE, MERCHANTABILITY,
NO WARRANTY OF NON-INFRINGEMENT OF ANY 3RD PARTY INTELLECTUAL PROPERTY
or FITNESS FOR A PARTICULAR PURPOSE or for any purpose whatsoever, for the
licensed product, however used. In no event shall NIST be liable for any
damages and/or costs, including but not limited to incidental or consequential
damages of any kind, including economic damage or injury to property and lost
profits, regardless of whether NIST shall be advised, have reason to know,
or in fact shall know of the possibility.

By using this software, you agree to bear all risk relating to quality,
use and performance of the software and/or related materials.  You agree
to hold the Government harmless from any claim arising from your use
of the software.

*******************************************************************************/

/***********************************************************************
      LIBRARY: FING - NIST Fingerprint Systems Utilities

      FILE:           BZ_ALLOC.C
      ALGORITHM:      Allan S. Bozorth (FBI)
      MODIFICATIONS:  Michael D. Garris (NIST)
                      Stan Janet (NIST)
      DATE:           09/21/2004

      Contains routines responsible for supporting the
      Bozorth3 fingerprint matching algorithm.

***********************************************************************

      ROUTINES:
#cat: malloc_or_exit - allocates a buffer of bytes from the heap of
#cat:        specified length exiting directly upon system error
#cat: malloc_or_return_error - allocates a buffer of bytes from the heap
#cat:        of specified length returning an error code upon system error

***********************************************************************/

#include <bozorth.h>
#include <stdio.h>
#include <string.h>

/***********************************************************************/
char *malloc_or_exit(int nbytes, const char *what) {
  char *p;

  /* These are now externally defined in bozorth.h */
  /* extern FILE * errorfp; */
  /* extern char * get_progname( void ); */

  p = malloc((size_t)nbytes);
  if (p == CNULL) {
    fprintf(errorfp, "%s: ERROR: malloc() of %d bytes for %s failed: %s\n",
            get_progname(), nbytes, what, strerror(errno));
    exit(1);
  }
  return p;
}

/***********************************************************************/
/* returns CNULL on error */
char *malloc_or_return_error(int nbytes, const char *what) {
  char *p;

  p = malloc((size_t)nbytes);
  if (p == CNULL) {
    fprintf(errorfp, "%s: ERROR: malloc() of %d bytes for %s failed: %s\n",
            get_progname(), nbytes, what, strerror(errno));
    return (CNULL);
  }
  return p;
}
