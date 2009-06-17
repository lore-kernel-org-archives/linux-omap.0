From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 1/7] DSPBRIDGE: Removing UTIL module
Date: Wed, 17 Jun 2009 12:36:06 -0500
Message-ID: <1245260172-23008-2-git-send-email-omar.ramirez@ti.com>
References: <1245260172-23008-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36927 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758759AbZFQRbg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 13:31:36 -0400
In-Reply-To: <1245260172-23008-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>

This module was deprecated, removing its source files.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/util.h |  122 ---------------------------
 drivers/dsp/bridge/pmgr/cmm.c               |    2 +-
 drivers/dsp/bridge/pmgr/dev.c               |    1 -
 drivers/dsp/bridge/pmgr/wcd.c               |    1 -
 drivers/dsp/bridge/services/clk.c           |    2 -
 drivers/dsp/bridge/services/services.c      |   15 +---
 drivers/dsp/bridge/wmd/tiomap3430.c         |    1 -
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c     |    1 -
 drivers/dsp/bridge/wmd/tiomap_io.c          |    1 -
 9 files changed, 5 insertions(+), 141 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/dspbridge/util.h

diff --git a/arch/arm/plat-omap/include/dspbridge/util.h b/arch/arm/plat-omap/include/dspbridge/util.h
deleted file mode 100644
index e6815ca..0000000
--- a/arch/arm/plat-omap/include/dspbridge/util.h
+++ /dev/null
@@ -1,122 +0,0 @@
-/*
- * util.h
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
- *  ======== util.h ========
- *  Purpose:
- *      Provide general purpose utility functions.
- *
- *  Public Functions:
- *      UTIL_CDTestDll
- *      UTIL_CmdLineToArgs
- *      UTIL_Exit
- *      UTIL_GetSysInfo
- *      UTIL_Init
- */
-
-#ifndef _UTIL_H
-#define _UTIL_H
-
-#include <linux/delay.h>
-#include <linux/sched.h>
-
-#include <dspbridge/utildefs.h>
-
-/*
- *  ======== UTIL_CDTestDll ========
- *  Purpose:
- *      Provides test entry point in class driver context.
- *  Parameters:
- *      cArgc:  test module command line input count.
- *      ppArgv: test module command line args.
- *  Returns:
- *      0 if successful, a negative value otherwise.
- *  Requires:
- *      UTIL initialized.
- *  Ensures:
- */
-	extern u32 UTIL_CDTestDll(IN s32 cArgc, IN char **ppArgv);
-
-/*
- *  ======== UTIL_CmdLineToArgs ========
- *  Purpose:
- *      This function re-creates C-style cmd line argc & argv from WinMain()
- *      cmd line args.
- *  Parameters:
- *      s8 *pszProgName   - The name of the program currently being executed.
- *      s8 *argv[]        - The argument vector.
- *      s8 *pCmdLine      - The pointer to the command line.
- *      bool fHasProgName   - Indicats whether a program name is supplied.
- *  Returns:
- *      Returns the number of arguments found.
- *  Requires:
- *      UTIL initialized.
- *  Ensures:
- */
-	extern s32 UTIL_CmdLineToArgs(IN char *pszProgName,
-				      IN char *argv[UTIL_MAXARGVS],
-				      IN char *pCmdLine, IN bool fHasProgName);
-
-/*
- *  ======== UTIL_Exit ========
- *  Purpose:
- *      Discontinue usage of module; free resources when reference count
- *      reaches 0.
- *  Parameters:
- *  Returns:
- *  Requires:
- *      UTIL initialized.
- *  Ensures:
- *      Resources used by module are freed when cRef reaches zero.
- */
-	extern inline void UTIL_Exit(void)
-	{
-	}
-/*
- *  ======== UTIL_GetSysInfo ========
- *  Purpose:
- *      This function return platform specific system information.
- *
- *  Parameters:
- *      pSysInfo  - address to store the system information.
- *  Returns:
- *      DSP_SOK
- *      S_FAIL
- *  Requires:
- *      UTIL initialized.
- *      pSysInfo != NULL
- *  Ensures:
- */
-	extern DSP_STATUS UTIL_GetSysInfo(OUT struct UTIL_SYSINFO *pSysInfo);
-
-/*
- *  ======== UTIL_Init ========
- *  Purpose:
- *      Initializes private state of UTIL module.
- *  Parameters:
- *  Returns:
- *      TRUE if success, else FALSE.
- *  Requires:
- *  Ensures:
- *      UTIL initialized.
- */
-	extern inline bool UTIL_Init(void)
-	{
-		return true;
-	}
-
-#endif				/* _UTIL_H */
diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c
index 99a2432..9b19be2 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -107,7 +107,7 @@
 #include <dspbridge/list.h>
 #include <dspbridge/mem.h>
 #include <dspbridge/sync.h>
-#include <dspbridge/util.h>
+#include <dspbridge/utildefs.h>
 
 /*  ----------------------------------- Platform Manager */
 #include <dspbridge/dev.h>
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index 1c2f7d5..5e4e30b 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -130,7 +130,6 @@
 #include <dspbridge/ldr.h>
 #include <dspbridge/list.h>
 #include <dspbridge/mem.h>
-#include <dspbridge/util.h>
 
 /*  ----------------------------------- Platform Manager */
 #include <dspbridge/cod.h>
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 859043d..cd84e4e 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -108,7 +108,6 @@
 #include <dspbridge/mem.h>
 #include <dspbridge/ntfy.h>
 #include <dspbridge/services.h>
-#include <dspbridge/util.h>
 
 /*  ----------------------------------- Platform Manager */
 #include <dspbridge/chnl.h>
diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index f0e46a3..ff2ceea 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -50,8 +50,6 @@
 
 /*  ----------------------------------- This */
 #include <dspbridge/clk.h>
-#include <dspbridge/util.h>
-
 
 /*  ----------------------------------- Defines, Data Structures, Typedefs */
 
diff --git a/drivers/dsp/bridge/services/services.c b/drivers/dsp/bridge/services/services.c
index 346007e..f3f700e 100644
--- a/drivers/dsp/bridge/services/services.c
+++ b/drivers/dsp/bridge/services/services.c
@@ -54,7 +54,6 @@
 #include <dspbridge/reg.h>
 #include <dspbridge/sync.h>
 #include <dspbridge/clk.h>
-#include <dspbridge/util.h>
 
 /*  ----------------------------------- This */
 #include <dspbridge/services.h>
@@ -83,7 +82,6 @@ void SERVICES_Exit(void)
 	if (cRefs == 0) {
 		/* Uninitialize all SERVICES modules here */
 		NTFY_Exit();
-		UTIL_Exit();
 		SYNC_Exit();
 		CLK_Exit();
 		REG_Exit();
@@ -109,8 +107,8 @@ void SERVICES_Exit(void)
 bool SERVICES_Init(void)
 {
 	bool fInit = true;
-       bool fCFG, fCSL, fDBG, fDPC, fKFILE, fLST, fMEM;
-       bool fREG, fSYNC, fCLK, fUTIL, fNTFY;
+	bool fCFG, fCSL, fDBG, fDPC, fKFILE, fLST, fMEM;
+	bool fREG, fSYNC, fCLK, fNTFY;
 
 	DBC_Require(cRefs >= 0);
 
@@ -131,22 +129,17 @@ bool SERVICES_Init(void)
 		fDPC = DPC_Init();
 		fKFILE = KFILE_Init();
 		fLST = LST_Init();
-		/* fREG = REG_Init(); */
 		fSYNC = SYNC_Init();
 		fCLK  = CLK_Init();
-		fUTIL = UTIL_Init();
 		fNTFY = NTFY_Init();
 
-               fInit = fCFG && fCSL && fDBG && fDPC && fKFILE &&
-                       fLST && fMEM && fREG && fSYNC && fCLK && fUTIL;
+		fInit = fCFG && fCSL && fDBG && fDPC && fKFILE &&
+			fLST && fMEM && fREG && fSYNC && fCLK;
 
 		if (!fInit) {
 			if (fNTFY)
 				NTFY_Exit();
 
-			if (fUTIL)
-				UTIL_Exit();
-
 			if (fSYNC)
 				SYNC_Exit();
 
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 7a9603d..4919314 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -47,7 +47,6 @@
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/mem.h>
-#include <dspbridge/util.h>
 #include <dspbridge/reg.h>
 #include <dspbridge/dbreg.h>
 #include <dspbridge/cfg.h>
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 914474f..e5bfb26 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -42,7 +42,6 @@
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/mem.h>
-#include <dspbridge/util.h>
 
 /*  ----------------------------------- Platform Manager */
 #include <dspbridge/brddefs.h>
diff --git a/drivers/dsp/bridge/wmd/tiomap_io.c b/drivers/dsp/bridge/wmd/tiomap_io.c
index 6121e8f..5ef0f9a 100644
--- a/drivers/dsp/bridge/wmd/tiomap_io.c
+++ b/drivers/dsp/bridge/wmd/tiomap_io.c
@@ -43,7 +43,6 @@
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/mem.h>
-#include <dspbridge/util.h>
 #include <dspbridge/cfg.h>
 
 /*  ----------------------------------- specific to this file */
-- 
1.6.2.4

