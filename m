From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 09/12] DSPBRIDGE: Remove GT_trace variables for services
Date: Thu, 18 Feb 2010 15:38:00 -0600
Message-ID: <1266529083-2358-10-git-send-email-omar.ramirez@ti.com>
References: <1266529083-2358-1-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-2-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-3-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-4-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-5-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-6-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-7-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-8-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-9-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54600 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755532Ab0BRVZ2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 16:25:28 -0500
In-Reply-To: <1266529083-2358-9-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

This patch removes variables used to store masks and flags
used for the previous debug implementation.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/services/cfg.c      |    6 ------
 drivers/dsp/bridge/services/clk.c      |    6 ------
 drivers/dsp/bridge/services/dbg.c      |    9 +--------
 drivers/dsp/bridge/services/mem.c      |    5 -----
 drivers/dsp/bridge/services/ntfy.c     |    7 -------
 drivers/dsp/bridge/services/reg.c      |    6 ------
 drivers/dsp/bridge/services/regsup.c   |    4 ----
 drivers/dsp/bridge/services/services.c |    6 ------
 drivers/dsp/bridge/services/sync.c     |    7 -------
 9 files changed, 1 insertions(+), 55 deletions(-)

diff --git a/drivers/dsp/bridge/services/cfg.c b/drivers/dsp/bridge/services/cfg.c
index 295ff11..19c296e 100644
--- a/drivers/dsp/bridge/services/cfg.c
+++ b/drivers/dsp/bridge/services/cfg.c
@@ -36,11 +36,6 @@ struct DRV_EXT {
 	char szString[MAXREGPATHLENGTH];
 };
 
-/*  ----------------------------------- Globals */
-#if GT_TRACE
-static struct GT_Mask CFG_debugMask = { NULL, NULL };	/* CFG debug Mask */
-#endif
-
 /*
  *  ======== CFG_Exit ========
  *  Purpose:
@@ -253,7 +248,6 @@ DSP_STATUS CFG_GetObject(OUT u32 *pdwValue, u32 dwType)
 bool CFG_Init(void)
 {
 	struct CFG_DSPRES dspResources;
-	GT_create(&CFG_debugMask, "CF");	/* CF for ConFig */
 
 	dspResources.uChipType = DSPTYPE_64;
 	dspResources.cChips = 1;
diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index 04d49bd..d279036 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -90,11 +90,6 @@ struct TIMER_OBJECT {
 	struct timer_list timer;
 };
 
-/*  ----------------------------------- Globals */
-#if GT_TRACE
-static struct GT_Mask CLK_debugMask = { NULL, NULL };	/* GT trace variable */
-#endif
-
 /*
  *  ======== CLK_Exit ========
  *  Purpose:
@@ -125,7 +120,6 @@ bool CLK_Init(void)
 	static struct platform_device dspbridge_device;
 	struct clk *clk_handle;
 	int i = 0;
-	GT_create(&CLK_debugMask, "CK");	/* CK for CLK */
 
 	dspbridge_device.dev.bus = &platform_bus_type;
 
diff --git a/drivers/dsp/bridge/services/dbg.c b/drivers/dsp/bridge/services/dbg.c
index a70297d..86c4628 100644
--- a/drivers/dsp/bridge/services/dbg.c
+++ b/drivers/dsp/bridge/services/dbg.c
@@ -28,11 +28,6 @@
 /*  ----------------------------------- This */
 #include <dspbridge/dbg.h>
 
-/*  ----------------------------------- Globals */
-#if GT_TRACE
-static struct GT_Mask DBG_debugMask = { NULL, NULL };	/* GT trace var. */
-#endif
-
 #if (defined(CONFIG_BRIDGE_DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE
 
 /*
@@ -42,8 +37,6 @@ static struct GT_Mask DBG_debugMask = { NULL, NULL };	/* GT trace var. */
  */
 bool DBG_Init(void)
 {
-	GT_create(&DBG_debugMask, "WD");     /* for WmD (link driver) debug */
-
 	return true;
 }
 
@@ -69,7 +62,7 @@ DSP_STATUS DBG_Trace(u8 bLevel, char *pstrFormat, ...)
 
 	va_end(va);
 
-	if (bLevel & *(DBG_debugMask).flags)
+	if (bLevel)
 		printk(pstrFormat, arg1, arg2, arg3, arg4, arg5, arg6);
 
 	return DSP_SOK;
diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
index 092b532..9eb50e5 100644
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -36,10 +36,6 @@
 #define MEM_512MB   0x1fffffff
 
 /*  ----------------------------------- Globals */
-#if GT_TRACE
-static struct GT_Mask MEM_debugMask = { NULL, NULL };	/* GT trace variable */
-#endif
-
 static bool extPhysMemPoolEnabled;
 
 struct extPhysMemPool {
@@ -271,6 +267,5 @@ void MEM_FreePhysMem(void *pVirtualAddress, u32 pPhysicalAddress,
  */
 bool MEM_Init(void)
 {
-	GT_create(&MEM_debugMask, "MM");	/* MM for MeM module */
 	return true;
 }
diff --git a/drivers/dsp/bridge/services/ntfy.c b/drivers/dsp/bridge/services/ntfy.c
index a0abd56..4908be1 100644
--- a/drivers/dsp/bridge/services/ntfy.c
+++ b/drivers/dsp/bridge/services/ntfy.c
@@ -66,11 +66,6 @@ struct NOTIFICATION {
 	struct SYNC_OBJECT *hSync;
 };
 
-/*  ----------------------------------- Globals */
-#if GT_TRACE
-static struct GT_Mask NTFY_debugMask = { NULL, NULL };  /* GT trace variable */
-#endif
-
 /*  ----------------------------------- Function Prototypes */
 static void DeleteNotify(struct NOTIFICATION *pNotify);
 
@@ -158,8 +153,6 @@ void NTFY_Exit(void)
  */
 bool NTFY_Init(void)
 {
-	GT_create(&NTFY_debugMask, "NY");	/* "NY" for NtfY */
-
 	return true;
 }
 
diff --git a/drivers/dsp/bridge/services/reg.c b/drivers/dsp/bridge/services/reg.c
index 36c1519..2e87982 100644
--- a/drivers/dsp/bridge/services/reg.c
+++ b/drivers/dsp/bridge/services/reg.c
@@ -35,10 +35,6 @@
 #include <dspbridge/reg.h>
 #include <regsup.h>
 
-#if GT_TRACE
-struct GT_Mask REG_debugMask = { NULL, NULL };	/* GT trace var. */
-#endif
-
 /*
  *  ======== REG_DeleteValue ========
  *  Deletes a registry entry value.  NOTE:  A registry entry value is not the
@@ -118,8 +114,6 @@ bool REG_Init(void)
 {
 	bool fInit;
 
-	GT_create(&REG_debugMask, "RG");	/* RG for ReG */
-
 	fInit = regsupInit();
 
 	return fInit;
diff --git a/drivers/dsp/bridge/services/regsup.c b/drivers/dsp/bridge/services/regsup.c
index 04f6b3a..fc625f4 100644
--- a/drivers/dsp/bridge/services/regsup.c
+++ b/drivers/dsp/bridge/services/regsup.c
@@ -45,10 +45,6 @@ struct RegValue {
 /*  Pointer to the registry support key  */
 static struct LST_LIST regKey, *pRegKey = &regKey;
 
-#if GT_TRACE
-extern struct GT_Mask REG_debugMask;	/* GT trace var. */
-#endif
-
 /*
  *  ======== regsupInit ========
  *  Purpose:
diff --git a/drivers/dsp/bridge/services/services.c b/drivers/dsp/bridge/services/services.c
index 8a30ac6..87bb76b 100644
--- a/drivers/dsp/bridge/services/services.c
+++ b/drivers/dsp/bridge/services/services.c
@@ -38,11 +38,6 @@
 /*  ----------------------------------- This */
 #include <dspbridge/services.h>
 
-/*  ----------------------------------- Globals */
-#if GT_TRACE
-static struct GT_Mask SERVICES_debugMask = { NULL, NULL };  /* GT trace var. */
-#endif
-
 /*
  *  ======== SERVICES_Exit ========
  *  Purpose:
@@ -75,7 +70,6 @@ bool SERVICES_Init(void)
 	bool fREG, fSYNC, fCLK, fNTFY;
 
 	GT_init();
-	GT_create(&SERVICES_debugMask, "OS");	/* OS for OSal */
 
 	/* Perform required initialization of SERVICES modules. */
 	fMEM = MEM_Init();
diff --git a/drivers/dsp/bridge/services/sync.c b/drivers/dsp/bridge/services/sync.c
index f9cd360..f9cac58 100644
--- a/drivers/dsp/bridge/services/sync.c
+++ b/drivers/dsp/bridge/services/sync.c
@@ -67,11 +67,6 @@ struct SYNC_DPCCSOBJECT {
 	s32 count;
 } ;
 
-/*  ----------------------------------- Globals */
-#if GT_TRACE
-static struct GT_Mask SYNC_debugMask = { NULL, NULL };  /* GT trace variable */
-#endif
-
 static int test_and_set(volatile void *ptr, int val)
 {
 	int ret = val;
@@ -123,8 +118,6 @@ void SYNC_Exit(void)
  */
 bool SYNC_Init(void)
 {
-	GT_create(&SYNC_debugMask, "SY");	/* SY for SYnc */
-
 	return true;
 }
 
-- 
1.6.2.4

