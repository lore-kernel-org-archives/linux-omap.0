From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3] DSPBRIDGE: OSAL: Remove CSL
Date: Wed, 16 Sep 2009 17:17:51 +0300
Message-ID: <1253110671-26004-2-git-send-email-andy.shevchenko@gmail.com>
References: <1253102300-25355-1-git-send-email-andy.shevchenko@gmail.com>
 <1253110671-26004-1-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:21076 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758938AbZIPOSF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Sep 2009 10:18:05 -0400
In-Reply-To: <1253110671-26004-1-git-send-email-andy.shevchenko@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: x0095840@ti.com, omar.ramirez@ti.com, hiroshi.doyu@nokia.com, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

Current DSP bridge driver still contains redudant pieces of CSL code. Get rid
of it finally.

Change CSL_atoi(s) to the kernel's simple_strtol(s, NULL, 10) in place.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/csl.h |  135 ----------------------
 drivers/dsp/bridge/Kbuild                  |    2 +-
 drivers/dsp/bridge/pmgr/chnl.c             |    1 -
 drivers/dsp/bridge/pmgr/cod.c              |    1 -
 drivers/dsp/bridge/pmgr/dbl.c              |   28 +++--
 drivers/dsp/bridge/pmgr/dbll.c             |    3 -
 drivers/dsp/bridge/rmgr/dbdcd.c            |    1 -
 drivers/dsp/bridge/rmgr/disp.c             |    1 -
 drivers/dsp/bridge/rmgr/drv.c              |    1 -
 drivers/dsp/bridge/rmgr/drv_interface.c    |    1 -
 drivers/dsp/bridge/rmgr/dspdrv.c           |    1 -
 drivers/dsp/bridge/rmgr/nldr.c             |    1 -
 drivers/dsp/bridge/rmgr/node.c             |    1 -
 drivers/dsp/bridge/rmgr/proc.c             |    1 -
 drivers/dsp/bridge/services/cfg.c          |    1 -
 drivers/dsp/bridge/services/clk.c          |    1 -
 drivers/dsp/bridge/services/csl.c          |  173 ----------------------------
 drivers/dsp/bridge/services/kfile.c        |    1 -
 drivers/dsp/bridge/services/ntfy.c         |    1 -
 drivers/dsp/bridge/services/reg.c          |    1 -
 drivers/dsp/bridge/services/regsup.c       |    1 -
 drivers/dsp/bridge/services/services.c     |   10 +--
 drivers/dsp/bridge/services/sync.c         |    1 -
 drivers/dsp/bridge/wmd/chnl_sm.c           |    1 -
 drivers/dsp/bridge/wmd/tiomap3430.c        |    1 -
 drivers/dsp/bridge/wmd/ue_deh.c            |    1 -
 26 files changed, 18 insertions(+), 353 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/dspbridge/csl.h
 delete mode 100644 drivers/dsp/bridge/services/csl.c

diff --git a/arch/arm/plat-omap/include/dspbridge/csl.h b/arch/arm/plat-omap/include/dspbridge/csl.h
deleted file mode 100644
index b90d6ff..0000000
--- a/arch/arm/plat-omap/include/dspbridge/csl.h
+++ /dev/null
@@ -1,135 +0,0 @@
-/*
- * csl.h
- *
- * DSP-BIOS Bridge driver support functions for TI OMAP processors.
- *
- * Copyright (C) 2008 Texas Instruments, Inc.
- *
- * This package is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
- * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
- * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
- */
-
-/*
- *  ======== csl.h ========
- *  Purpose:
- *      Platform independent C Standard library functions.
- *
- *  Public Functions:
- *      CSL_AnsiToWchar
- *      CSL_ByteSwap
- *      CSL_Exit
- *      CSL_Init
- *      CSL_NumToAscii
- *      CSL_Strtok
- *      CSL_Strtokr
- *      CSL_WcharToAnsi
- *
- *! Revision History:
- *! ================
- *! 07-Aug-2002 jeh: Added CSL_Strtokr().
- *! 21-Sep-2001 jeh: Added CSL_Strncmp.
- *! 22-Nov-2000 map: Added CSL_Atoi and CSL_Strtok
- *! 19-Nov-2000 kc:  Added CSL_ByteSwap().
- *! 09-Nov-2000 kc:  Added CSL_Strncat.
- *! 29-Oct-1999 kc:  Added CSL_Wstrlen().
- *! 20-Sep-1999 ag:  Added CSL_Wchar2Ansi().
- *! 19-Jan-1998 cr:  Code review cleanup (mostly documentation fixes).
- *! 29-Dec-1997 cr:  Changed CSL_lowercase to CSL_Uppercase, added
- *!                  CSL_AnsiToWchar.
- *! 30-Sep-1997 cr:  Added explicit cdecl descriptors to fxn definitions.
- *! 25-Jun-1997 cr:  Added CSL_strcmp.
- *! 12-Jun-1996 gp:  Created.
- */
-
-#ifndef CSL_
-#define CSL_
-
-#include <dspbridge/host_os.h>
-
-/*
- *  ======== CSL_Exit ========
- *  Purpose:
- *      Discontinue usage of the CSL module.
- *  Parameters:
- *  Returns:
- *  Requires:
- *      CSL initialized.
- *  Ensures:
- *      Resources acquired in CSL_Init(void) are freed.
- */
-	extern void CSL_Exit(void);
-
-/*
- *  ======== CSL_Init ========
- *  Purpose:
- *      Initialize the CSL module's private state.
- *  Parameters:
- *  Returns:
- *      TRUE if initialized; FALSE if error occured.
- *  Requires:
- *  Ensures:
- *      A requirement for each of the other public CSL functions.
- */
-	extern bool CSL_Init(void);
-
-/*
- *  ======== CSL_NumToAscii ========
- *  Purpose:
- *      Convert a 1 or 2 digit number to a 2 digit string.
- *  Parameters:
- *      pstrNumber: Buffer to store converted string.
- *      dwNum:      Number to convert.
- *  Returns:
- *  Requires:
- *      pstrNumber must be able to hold at least three characters.
- *  Ensures:
- *      pstrNumber will be null terminated.
- */
-	extern void CSL_NumToAscii(OUT char *pstrNumber, IN u32 dwNum);
-
-
-/*
- *  ======== CSL_Strtok ========
- *  Purpose:
- *      Tokenize a NULL terminated string
- *  Parameters:
- *      ptstrSrc:       pointer to string.
- *      szSeparators:   pointer to a string of seperators
- *  Returns:
- *      char *
- *  Requires:
- *      CSL initialized.
- *      ptstrSrc is a valid string pointer.
- *      szSeparators is a valid string pointer.
- *  Ensures:
- */
-	extern char *CSL_Strtok(IN char *ptstrSrc,
-				IN CONST char *szSeparators);
-
-/*
- *  ======== CSL_Strtokr ========
- *  Purpose:
- *      Re-entrant version of strtok.
- *  Parameters:
- *      pstrSrc:        Pointer to string. May be NULL on subsequent calls.
- *      szSeparators:   Pointer to a string of seperators
- *      ppstrCur:       Location to store start of string for next call to
- *                      to CSL_Strtokr.
- *  Returns:
- *      char * (the token)
- *  Requires:
- *      CSL initialized.
- *      szSeparators != NULL
- *      ppstrCur != NULL
- *  Ensures:
- */
-	extern char *CSL_Strtokr(IN char *pstrSrc,
-				 IN CONST char *szSeparators,
-				 OUT char **ppstrCur);
-
-#endif				/* CSL_ */
diff --git a/drivers/dsp/bridge/Kbuild b/drivers/dsp/bridge/Kbuild
index e04a6e4..838cc13 100644
--- a/drivers/dsp/bridge/Kbuild
+++ b/drivers/dsp/bridge/Kbuild
@@ -1,7 +1,7 @@
 obj-$(CONFIG_MPU_BRIDGE)	+= bridgedriver.o
 
 libgen = gen/gb.o gen/gt.o gen/gs.o gen/gh.o gen/_gt_para.o gen/uuidutil.o
-libservices = services/csl.o services/mem.o services/dpc.o \
+libservices = services/mem.o services/dpc.o \
                services/kfile.o services/sync.o \
 		services/clk.o services/cfg.o services/reg.o \
                services/regsup.o services/ntfy.o \
diff --git a/drivers/dsp/bridge/pmgr/chnl.c b/drivers/dsp/bridge/pmgr/chnl.c
index 4c9bd2b..19fe6e4 100644
--- a/drivers/dsp/bridge/pmgr/chnl.c
+++ b/drivers/dsp/bridge/pmgr/chnl.c
@@ -76,7 +76,6 @@
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
-#include <dspbridge/csl.h>
 #include <dspbridge/dpc.h>
 #include <dspbridge/mem.h>
 #include <dspbridge/sync.h>
diff --git a/drivers/dsp/bridge/pmgr/cod.c b/drivers/dsp/bridge/pmgr/cod.c
index 2da46bd..e26d115 100644
--- a/drivers/dsp/bridge/pmgr/cod.c
+++ b/drivers/dsp/bridge/pmgr/cod.c
@@ -68,7 +68,6 @@
 #include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/csl.h>
 #include <dspbridge/kfile.h>
 #include <dspbridge/ldr.h>
 #include <dspbridge/mem.h>
diff --git a/drivers/dsp/bridge/pmgr/dbl.c b/drivers/dsp/bridge/pmgr/dbl.c
index 641b011..af0b89b 100644
--- a/drivers/dsp/bridge/pmgr/dbl.c
+++ b/drivers/dsp/bridge/pmgr/dbl.c
@@ -37,6 +37,7 @@
 
 /*  ----------------------------------- Host OS */
 #include <dspbridge/host_os.h>
+#include <linux/kernel.h>
 
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
@@ -48,7 +49,6 @@
 #include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/csl.h>
 #include <dspbridge/mem.h>
 #include <dspbridge/kfile.h>
 
@@ -358,7 +358,7 @@ bool DBL_getAddr(struct DBL_LibraryObj *lib, char *name,
 		 "0x%x\n", lib, name, ppSym);
 	for (i = 0; i < lib->nSymbols; i++) {
 		symbol = &lib->symbols[i];
-		if (CSL_Strcmp(name, symbol->pSymName) == 0) {
+		if (strcmp(name, symbol->pSymName) == 0) {
 			/* Found it */
 			*ppSym = &lib->symbols[i].sym;
 			retVal = true;
@@ -405,8 +405,8 @@ bool DBL_getCAddr(struct DBL_LibraryObj *lib, char *name,
 		 " 0x%x\n", lib, name, ppSym);
 	for (i = 0;  i < lib->nSymbols;  i++) {
 		symbol = &lib->symbols[i];
-		if ((CSL_Strcmp(name, symbol->pSymName) == 0) ||
-		    (CSL_Strcmp(name, symbol->pSymName + 1) == 0 &&
+		if ((strcmp(name, symbol->pSymName) == 0) ||
+		    (strcmp(name, symbol->pSymName + 1) == 0 &&
 		     symbol->pSymName[0] == '_')) {
 			/* Found it */
 			*ppSym = &lib->symbols[i].sym;
@@ -468,7 +468,7 @@ DSP_STATUS DBL_getSect(struct DBL_LibraryObj *lib, char *name, u32 *pAddr,
 	if (name[0] == '.') {
 		/* Get DCD section size (address is 0, since it's a NOLOAD). */
 		for (i = 0; i < pdblLib->nDCDSects; i++) {
-			if (CSL_Strcmp(pdblLib->dcdSects[i].sectHdr.name,
+			if (strcmp(pdblLib->dcdSects[i].sectHdr.name,
 			   name) == 0) {
 				*pAddr = 0;
 				*pSize = pdblLib->dcdSects[i].sectHdr.size *
@@ -480,7 +480,7 @@ DSP_STATUS DBL_getSect(struct DBL_LibraryObj *lib, char *name, u32 *pAddr,
 	} else {
 		/* Check for overlay section */
 		for (i = 0;  i < pdblLib->nOvlySects;  i++) {
-			if (CSL_Strcmp(pdblLib->ppOvlyData[i]->hdr.pName,
+			if (strcmp(pdblLib->ppOvlyData[i]->hdr.pName,
 			   name) == 0) {
 				/* Address and size are meaningless */
 				*pAddr = 0;
@@ -608,7 +608,7 @@ DSP_STATUS DBL_loadSect(struct DBL_LibraryObj *lib, char *sectName,
 	/* Check for match of sect name in overlay table */
 	for (i = 0; i < lib->nOvlySects; i++) {
 		name = lib->ppOvlyData[i]->hdr.pName;
-		if (!CSL_Strncmp(name, sectName, CSL_Strlen(name))) {
+		if (!strncmp(name, sectName, strlen(name))) {
 			/* Match found */
 			status = DSP_SOK;
 			break;
@@ -621,8 +621,9 @@ DSP_STATUS DBL_loadSect(struct DBL_LibraryObj *lib, char *sectName,
 		 *  If node overlay, phase will be encoded in name. If not node
 		 *  overlay, set phase to NONE.
 		 */
-		phase = (CSL_Strcmp(name, sectName)) ?
-			CSL_Atoi(sectName + CSL_Strlen(sectName) - 1) : NONE;
+		phase = (strcmp(name, sectName)) ?
+			simple_strtol(sectName + strlen(sectName) - 1,
+				NULL, 10) : NONE;
 		 /*  Get reference count of node phase to be loaded, offset into
 		 *  overlay data array, and number of sections to overlay.  */
 		switch (phase) {
@@ -848,7 +849,7 @@ DSP_STATUS DBL_readSect(struct DBL_LibraryObj *lib, char *name, char *pContent,
 
 	/* Attempt to find match with DCD section names. */
 	for (i = 0; i < pdblLib->nDCDSects; i++) {
-		if (CSL_Strcmp(pdblLib->dcdSects[i].sectHdr.name, name) == 0) {
+		if (strcmp(pdblLib->dcdSects[i].sectHdr.name, name) == 0) {
 			/* Match found */
 			max = pdblLib->dcdSects[i].sectHdr.size * mauSize;
 			max = (max > size) ? size : max;
@@ -922,7 +923,7 @@ DSP_STATUS DBL_unloadSect(struct DBL_LibraryObj *lib, char *sectName,
 	/* Check for match of sect name in overlay table */
 	for (i = 0; i < lib->nOvlySects; i++) {
 		pName = lib->ppOvlyData[i]->hdr.pName;
-		if (!CSL_Strncmp(pName, sectName, CSL_Strlen(pName))) {
+		if (!strncmp(pName, sectName, strlen(pName))) {
 			/* Match found */
 			status = DSP_SOK;
 			break;
@@ -932,8 +933,9 @@ DSP_STATUS DBL_unloadSect(struct DBL_LibraryObj *lib, char *sectName,
 		DBC_Assert(i < lib->nOvlySects);
 		pOvlyData = lib->ppOvlyData[i];
 		/* If node overlay, phase will be encoded in name. */
-		phase = (CSL_Strcmp(pName, sectName)) ?
-			CSL_Atoi(sectName + CSL_Strlen(sectName) - 1) : NONE;
+		phase = (strcmp(pName, sectName)) ?
+			simple_strtol(sectName + strlen(sectName) - 1,
+				NULL, 10) : NONE;
 		switch (phase) {
 		case NONE:
 			nSects = numOtherSects(pOvlyData);
diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index e32d59e..f1d55fa 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -48,7 +48,6 @@
 #include <dspbridge/gh.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/csl.h>
 #include <dspbridge/mem.h>
 
 /* Dynamic loader library interface */
@@ -339,7 +338,6 @@ void DBLL_exit(void)
 
 	if (cRefs == 0) {
 		MEM_Exit();
-		CSL_Exit();
 		GH_exit();
 #if GT_TRACE
 		DBLL_debugMask.flags = NULL;
@@ -496,7 +494,6 @@ bool DBLL_init(void)
 		DBC_Assert(!DBLL_debugMask.flags);
 		GT_create(&DBLL_debugMask, "DL"); 	/* "DL" for dbDL */
 		GH_init();
-		CSL_Init();
 		retVal = MEM_Init();
 		if (!retVal)
 			MEM_Exit();
diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index 99f0c6e..954e83d 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -73,7 +73,6 @@
 #include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/csl.h>
 #include <dspbridge/mem.h>
 #include <dspbridge/reg.h>
 
diff --git a/drivers/dsp/bridge/rmgr/disp.c b/drivers/dsp/bridge/rmgr/disp.c
index 3fbbf01..d6ddf6e 100644
--- a/drivers/dsp/bridge/rmgr/disp.c
+++ b/drivers/dsp/bridge/rmgr/disp.c
@@ -62,7 +62,6 @@
 #include <dspbridge/dev.h>
 #include <dspbridge/mem.h>
 #include <dspbridge/sync.h>
-#include <dspbridge/csl.h>
 
 /*  ----------------------------------- Link Driver */
 #include <dspbridge/wmd.h>
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index c1794e8..d251046 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -104,7 +104,6 @@
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
-#include <dspbridge/csl.h>
 #include <dspbridge/list.h>
 #include <dspbridge/mem.h>
 #include <dspbridge/reg.h>
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 13442c6..5ce2a7d 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -76,7 +76,6 @@
 #include <dspbridge/services.h>
 #include <dspbridge/sync.h>
 #include <dspbridge/reg.h>
-#include <dspbridge/csl.h>
 
 /*  ----------------------------------- Platform Manager */
 #include <dspbridge/wcdioctl.h>
diff --git a/drivers/dsp/bridge/rmgr/dspdrv.c b/drivers/dsp/bridge/rmgr/dspdrv.c
index a7a74fc..3758e86 100644
--- a/drivers/dsp/bridge/rmgr/dspdrv.c
+++ b/drivers/dsp/bridge/rmgr/dspdrv.c
@@ -105,7 +105,6 @@
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
-#include <dspbridge/csl.h>
 #include <dspbridge/mem.h>
 #include <dspbridge/reg.h>
 
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index 0d06b34..d961aa0 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -63,7 +63,6 @@
 #endif
 
 /* OS adaptation layer */
-#include <dspbridge/csl.h>
 #include <dspbridge/mem.h>
 
 /* Platform manager */
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index a0a8e4e..f2df614 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -106,7 +106,6 @@
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
-#include <dspbridge/csl.h>
 #include <dspbridge/list.h>
 #include <dspbridge/mem.h>
 #include <dspbridge/proc.h>
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 91f9a16..ad4090d 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -114,7 +114,6 @@
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
-#include <dspbridge/csl.h>
 #include <dspbridge/list.h>
 #include <dspbridge/mem.h>
 #include <dspbridge/ntfy.h>
diff --git a/drivers/dsp/bridge/services/cfg.c b/drivers/dsp/bridge/services/cfg.c
index 4a39ccb..18ab65d 100644
--- a/drivers/dsp/bridge/services/cfg.c
+++ b/drivers/dsp/bridge/services/cfg.c
@@ -82,7 +82,6 @@
 #include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/csl.h>
 #include <dspbridge/reg.h>
 
 /*  ----------------------------------- Others */
diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index ff2ceea..d1c68fc 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -45,7 +45,6 @@
 #include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/csl.h>
 #include <dspbridge/mem.h>
 
 /*  ----------------------------------- This */
diff --git a/drivers/dsp/bridge/services/csl.c b/drivers/dsp/bridge/services/csl.c
deleted file mode 100644
index dd33c2d..0000000
--- a/drivers/dsp/bridge/services/csl.c
+++ /dev/null
@@ -1,173 +0,0 @@
-/*
- * csl.c
- *
- * DSP-BIOS Bridge driver support functions for TI OMAP processors.
- *
- * Copyright (C) 2005-2006 Texas Instruments, Inc.
- *
- * This package is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
- * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
- * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
- */
-
-
-/*
- *  ======== cslce.c ========
- *  Purpose:
- *      Provides platform independent C Standard library functions.
- *
- *  Public Functions:
- *      CSL_Atoi
- *      CSL_Exit
- *      CSL_Init
- *      CSL_NumToAscii
- *      CSL_Strtokr
- *
- *! Revision History:
- *! ================
- *! 07-Aug-2002 jeh: Added CSL_Strtokr().
- *! 21-Sep-2001 jeh: Added CSL_Strncmp(). Alphabetized functions.
- *! 22-Nov-2000 map: Added CSL_Atoi and CSL_Strtok
- *! 19-Nov-2000 kc: Added CSL_ByteSwap.
- *! 09-Nov-2000 kc: Added CSL_Strncat.
- *! 03-Feb-2000 rr: Module init/exit is handled by SERVICES Init/Exit.
- *!		 GT Changes.
- *! 15-Dec-1999 ag: Removed incorrect assertion CSL_NumToAscii()
- *! 29-Oct-1999 kc: Added CSL_Wstrlen for UNICODE strings.
- *! 30-Sep-1999 ag: Removed DBC assertion (!CSL_DebugMask.flags) in
- *		  CSP_Init().
- *! 20-Sep-1999 ag: Added CSL_WcharToAnsi().
- *!		 Removed call to GT_set().
- *! 19-Jan-1998 cr: Code review cleanup.
- *! 29-Dec-1997 cr: Made platform independant, using MS CRT code, and
- *!		 combined csl32.c csl95.c and cslnt.c into csl.c.  Also
- *!		 changed CSL_lowercase to CSL_Uppercase.
- *! 21-Aug-1997 gp: Fix to CSL_strcpyn to initialize Source string, the NT way.
- *! 25-Jun-1997 cr: Created from csl95, added CSL_strcmp.
- */
-
-/* ----------------------------------- Host OS */
-#include <dspbridge/host_os.h>
-
-/*  ----------------------------------- DSP/BIOS Bridge */
-#include <dspbridge/std.h>
-#include <dspbridge/dbdefs.h>
-
-/*  ----------------------------------- Trace & Debug */
-#include <dspbridge/dbc.h>
-#include <dspbridge/gt.h>
-
-/*  ----------------------------------- This */
-#include <dspbridge/csl.h>
-
-/* Is character c in the string pstrDelim? */
-#define IsDelimiter(c, pstrDelim) ((c != '\0') && \
-				   (strchr(pstrDelim, c) != NULL))
-
-/*  ----------------------------------- Globals */
-#if GT_TRACE
-static struct GT_Mask CSL_DebugMask = { NULL, NULL };	/* GT trace var. */
-#endif
-
-/*
- *  ======== CSL_Exit ========
- *  Purpose:
- *      Discontinue usage of the CSL module.
- */
-void CSL_Exit(void)
-{
-	GT_0trace(CSL_DebugMask, GT_5CLASS, "CSL_Exit\n");
-}
-
-/*
- *  ======== CSL_Init ========
- *  Purpose:
- *      Initialize the CSL module's private state.
- */
-bool CSL_Init(void)
-{
-	GT_create(&CSL_DebugMask, "CS");
-
-	GT_0trace(CSL_DebugMask, GT_5CLASS, "CSL_Init\n");
-
-	return true;
-}
-
-/*
- *  ======== CSL_NumToAscii ========
- *  Purpose:
- *      Convert a 1 or 2 digit number to a 2 digit string.
- */
-void CSL_NumToAscii(OUT char *pstrNumber, u32 dwNum)
-{
-	char tens;
-
-	DBC_Require(dwNum < 100);
-
-	if (dwNum < 100) {
-		tens = (char) dwNum / 10;
-		dwNum = dwNum % 10;
-
-		if (tens) {
-			pstrNumber[0] = tens + '0';
-			pstrNumber[1] = (char) dwNum + '0';
-			pstrNumber[2] = '\0';
-		} else {
-			pstrNumber[0] = (char) dwNum + '0';
-			pstrNumber[1] = '\0';
-		}
-	} else {
-		pstrNumber[0] = '\0';
-	}
-}
-
-
-
-
-/*
- *  ======= CSL_Strtokr =======
- *  Purpose:
- *      Re-entrant version of strtok.
- */
-char *CSL_Strtokr(IN char *pstrSrc, IN CONST char *szSeparators,
-		  OUT char **ppstrLast)
-{
-	char *pstrTemp;
-	char *pstrToken;
-
-	DBC_Require(szSeparators != NULL);
-	DBC_Require(ppstrLast != NULL);
-	DBC_Require(pstrSrc != NULL || *ppstrLast != NULL);
-
-	/*
-	 *  Set string location to beginning (pstrSrc != NULL) or to the
-	 *  beginning of the next token.
-	 */
-	pstrTemp = (pstrSrc != NULL) ? pstrSrc : *ppstrLast;
-	if (*pstrTemp == '\0') {
-		pstrToken = NULL;
-	} else {
-		pstrToken = pstrTemp;
-		while (*pstrTemp != '\0' && !IsDelimiter(*pstrTemp,
-		      szSeparators)) {
-			pstrTemp++;
-		}
-		if (*pstrTemp != '\0') {
-			while (IsDelimiter(*pstrTemp, szSeparators)) {
-				/* TODO: Shouldn't we do this for
-				 * only 1 char?? */
-				*pstrTemp = '\0';
-				pstrTemp++;
-			}
-		}
-
-		/* Location in string for next call */
-		*ppstrLast = pstrTemp;
-	}
-
-	return pstrToken;
-}
diff --git a/drivers/dsp/bridge/services/kfile.c b/drivers/dsp/bridge/services/kfile.c
index 227d6fc..d1e262c 100644
--- a/drivers/dsp/bridge/services/kfile.c
+++ b/drivers/dsp/bridge/services/kfile.c
@@ -54,7 +54,6 @@
 #include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/csl.h>
 #include <dspbridge/mem.h>
 
 /*  ----------------------------------- This */
diff --git a/drivers/dsp/bridge/services/ntfy.c b/drivers/dsp/bridge/services/ntfy.c
index 5c7219f..819298b 100644
--- a/drivers/dsp/bridge/services/ntfy.c
+++ b/drivers/dsp/bridge/services/ntfy.c
@@ -52,7 +52,6 @@
 #include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/csl.h>
 #include <dspbridge/list.h>
 #include <dspbridge/mem.h>
 #include <dspbridge/sync.h>
diff --git a/drivers/dsp/bridge/services/reg.c b/drivers/dsp/bridge/services/reg.c
index 0d85f41..a1f287d 100644
--- a/drivers/dsp/bridge/services/reg.c
+++ b/drivers/dsp/bridge/services/reg.c
@@ -46,7 +46,6 @@
 #include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/csl.h>
 #include <dspbridge/mem.h>
 
 /*  ----------------------------------- Others */
diff --git a/drivers/dsp/bridge/services/regsup.c b/drivers/dsp/bridge/services/regsup.c
index c9ba80c..8e19ad1 100644
--- a/drivers/dsp/bridge/services/regsup.c
+++ b/drivers/dsp/bridge/services/regsup.c
@@ -43,7 +43,6 @@
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/mem.h>
-#include <dspbridge/csl.h>
 
 /*  ----------------------------------- This */
 #include <regsup.h>
diff --git a/drivers/dsp/bridge/services/services.c b/drivers/dsp/bridge/services/services.c
index 218425c..7df9920 100644
--- a/drivers/dsp/bridge/services/services.c
+++ b/drivers/dsp/bridge/services/services.c
@@ -44,7 +44,6 @@
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
-#include <dspbridge/csl.h>
 #include <dspbridge/dbg.h>
 #include <dspbridge/dpc.h>
 #include <dspbridge/kfile.h>
@@ -87,7 +86,6 @@ void SERVICES_Exit(void)
 		KFILE_Exit();
 		DPC_Exit();
 		DBG_Exit();
-		CSL_Exit();
 		CFG_Exit();
 		MEM_Exit();
 
@@ -105,7 +103,7 @@ void SERVICES_Exit(void)
 bool SERVICES_Init(void)
 {
 	bool fInit = true;
-	bool fCFG, fCSL, fDBG, fDPC, fKFILE, fMEM;
+	bool fCFG, fDBG, fDPC, fKFILE, fMEM;
 	bool fREG, fSYNC, fCLK, fNTFY;
 
 	DBC_Require(cRefs >= 0);
@@ -122,7 +120,6 @@ bool SERVICES_Init(void)
 		fMEM = MEM_Init();
 		fREG = REG_Init();
 		fCFG = CFG_Init();
-		fCSL = CSL_Init();
 		fDBG = DBG_Init();
 		fDPC = DPC_Init();
 		fKFILE = KFILE_Init();
@@ -130,7 +127,7 @@ bool SERVICES_Init(void)
 		fCLK  = CLK_Init();
 		fNTFY = NTFY_Init();
 
-		fInit = fCFG && fCSL && fDBG && fDPC && fKFILE &&
+		fInit = fCFG && fDBG && fDPC && fKFILE &&
 			fMEM && fREG && fSYNC && fCLK;
 
 		if (!fInit) {
@@ -155,9 +152,6 @@ bool SERVICES_Init(void)
 			if (fDBG)
 				DBG_Exit();
 
-			if (fCSL)
-				CSL_Exit();
-
 			if (fCFG)
 				CFG_Exit();
 
diff --git a/drivers/dsp/bridge/services/sync.c b/drivers/dsp/bridge/services/sync.c
index 7ab9347..1b9a8b1 100644
--- a/drivers/dsp/bridge/services/sync.c
+++ b/drivers/dsp/bridge/services/sync.c
@@ -60,7 +60,6 @@
 #include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/csl.h>
 #include <dspbridge/mem.h>
 
 /*  ----------------------------------- This */
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index 8973b04..275ce0f 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -128,7 +128,6 @@
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/mem.h>
 #include <dspbridge/cfg.h>
-#include <dspbridge/csl.h>
 #include <dspbridge/sync.h>
 
 /*  ----------------------------------- Mini-Driver */
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 93d4615..7ccb0de 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -51,7 +51,6 @@
 #include <dspbridge/dbreg.h>
 #include <dspbridge/cfg.h>
 #include <dspbridge/drv.h>
-#include <dspbridge/csl.h>
 #include <dspbridge/sync.h>
 
 /* ------------------------------------ Hardware Abstraction Layer */
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 37a07d0..d6d6043 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -44,7 +44,6 @@
 #include <dspbridge/dbg.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/csl.h>
 #include <dspbridge/cfg.h>
 #include <dspbridge/dpc.h>
 #include <dspbridge/mem.h>
-- 
1.5.6.5

