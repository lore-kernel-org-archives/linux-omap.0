From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 8/9] DSPBRIDGE: Remove DPC module from SERVICES layer
Date: Mon, 23 Nov 2009 18:50:29 -0600
Message-ID: <1259023830-7557-9-git-send-email-omar.ramirez@ti.com>
References: <1259023830-7557-1-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-2-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-3-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-4-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-5-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-6-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-7-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-8-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51703 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756463AbZKXApH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Nov 2009 19:45:07 -0500
In-Reply-To: <1259023830-7557-8-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Artem Bityutskiy <dedekind1@gmail.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

This patch removes init and exit functions for DPC module.
It also deletes dpc source file and takes out the module from
Makefile.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dpc.h |   26 -----------
 drivers/dsp/bridge/Makefile                |    3 +-
 drivers/dsp/bridge/services/dpc.c          |   68 ----------------------------
 drivers/dsp/bridge/services/services.c     |    9 +---
 4 files changed, 3 insertions(+), 103 deletions(-)
 delete mode 100644 drivers/dsp/bridge/services/dpc.c

diff --git a/arch/arm/plat-omap/include/dspbridge/dpc.h b/arch/arm/plat-omap/include/dspbridge/dpc.h
index b22140f..aee910d 100644
--- a/arch/arm/plat-omap/include/dspbridge/dpc.h
+++ b/arch/arm/plat-omap/include/dspbridge/dpc.h
@@ -35,30 +35,4 @@ struct DPC_OBJECT {
 	spinlock_t dpc_lock;
 };
 
-/*
- *  ======== DPC_Exit ========
- *  Purpose:
- *      Discontinue usage of the DPC module.
- *  Parameters:
- *  Returns:
- *  Requires:
- *      DPC_Init(void) was previously called.
- *  Ensures:
- *      Resources acquired in DPC_Init(void) are freed.
- */
-       extern void DPC_Exit(void);
-
-/*
- *  ======== DPC_Init ========
- *  Purpose:
- *      Initialize the DPC module's private state.
- *  Parameters:
- *  Returns:
- *      TRUE if initialized; FALSE if error occured.
- *  Requires:
- *  Ensures:
- *      A requirement for each of the other public DPC functions.
- */
-       extern bool DPC_Init(void);
-
 #endif				/* DPC_ */
diff --git a/drivers/dsp/bridge/Makefile b/drivers/dsp/bridge/Makefile
index cb6d1ce..df870c9 100644
--- a/drivers/dsp/bridge/Makefile
+++ b/drivers/dsp/bridge/Makefile
@@ -1,8 +1,7 @@
 obj-$(CONFIG_MPU_BRIDGE)	+= bridgedriver.o
 
 libgen = gen/gb.o gen/gt.o gen/gs.o gen/gh.o gen/_gt_para.o gen/uuidutil.o
-libservices = services/mem.o services/list.o services/dpc.o \
-		services/sync.o \
+libservices = services/mem.o services/list.o services/sync.o \
 		services/clk.o services/cfg.o services/reg.o \
                services/regsup.o services/ntfy.o \
 		services/dbg.o services/services.o
diff --git a/drivers/dsp/bridge/services/dpc.c b/drivers/dsp/bridge/services/dpc.c
deleted file mode 100644
index bbb2d47..0000000
--- a/drivers/dsp/bridge/services/dpc.c
+++ /dev/null
@@ -1,68 +0,0 @@
-/*
- * dpc.c
- *
- * DSP-BIOS Bridge driver support functions for TI OMAP processors.
- *
- * Deferred Procedure Call(DPC) Services.
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
-/*  ----------------------------------- Host OS */
-#include <dspbridge/host_os.h>
-
-/*  ----------------------------------- DSP/BIOS Bridge */
-#include <dspbridge/std.h>
-#include <dspbridge/dbdefs.h>
-#include <dspbridge/errbase.h>
-
-/*  ----------------------------------- Trace & Debug */
-#include <dspbridge/dbc.h>
-#include <dspbridge/gt.h>
-
-/*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/mem.h>
-
-/*  ----------------------------------- This */
-#include <dspbridge/dpc.h>
-
-/*  ----------------------------------- Defines, Data Structures, Typedefs */
-#define SIGNATURE       0x5f435044	/* "DPC_" (in reverse). */
-
-/*  ----------------------------------- Globals */
-#if GT_TRACE
-static struct GT_Mask DPC_DebugMask = { NULL, NULL };	/* DPC Debug Mask */
-#endif
-
-/*
- *  ======== DPC_Exit ========
- *  Purpose:
- *      Discontinue usage of the DPC module.
- */
-void DPC_Exit(void)
-{
-	GT_0trace(DPC_DebugMask, GT_5CLASS, "Entered DPC_Exit\n");
-}
-
-/*
- *  ======== DPC_Init ========
- *  Purpose:
- *      Initialize the DPC module's private state.
- */
-bool DPC_Init(void)
-{
-	GT_create(&DPC_DebugMask, "DP");
-
-	GT_0trace(DPC_DebugMask, GT_5CLASS, "Entered DPC_Init\n");
-
-	return true;
-}
-
diff --git a/drivers/dsp/bridge/services/services.c b/drivers/dsp/bridge/services/services.c
index dc9bfad..0b7d623 100644
--- a/drivers/dsp/bridge/services/services.c
+++ b/drivers/dsp/bridge/services/services.c
@@ -68,7 +68,6 @@ void SERVICES_Exit(void)
 		CLK_Exit();
 		REG_Exit();
 		LST_Exit();
-		DPC_Exit();
 		DBG_Exit();
 		CFG_Exit();
 		MEM_Exit();
@@ -87,7 +86,7 @@ void SERVICES_Exit(void)
 bool SERVICES_Init(void)
 {
 	bool fInit = true;
-	bool fCFG, fDBG, fDPC, fLST, fMEM;
+	bool fCFG, fDBG, fLST, fMEM;
 	bool fREG, fSYNC, fCLK, fNTFY;
 
 	DBC_Require(cRefs >= 0);
@@ -106,12 +105,11 @@ bool SERVICES_Init(void)
 		fREG = REG_Init();
 		fCFG = CFG_Init();
 		fDBG = DBG_Init();
-		fDPC = DPC_Init();
 		fLST = LST_Init();
 		fCLK  = CLK_Init();
 		fNTFY = NTFY_Init();
 
-		fInit = fCFG && fDBG && fDPC &&
+		fInit = fCFG && fDBG &&
 			fLST && fMEM && fREG && fSYNC && fCLK;
 
 		if (!fInit) {
@@ -130,9 +128,6 @@ bool SERVICES_Init(void)
 			if (fLST)
 				LST_Exit();
 
-			if (fDPC)
-				DPC_Exit();
-
 			if (fDBG)
 				DBG_Exit();
 
-- 
1.6.2.4

