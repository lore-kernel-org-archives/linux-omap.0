From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2 3/5] DSPBRIDGE: Remove multiple initializations of MEM module
Date: Tue, 26 Jan 2010 18:57:26 -0600
Message-ID: <1264553848-23555-4-git-send-email-omar.ramirez@ti.com>
References: <1264553848-23555-1-git-send-email-omar.ramirez@ti.com>
 <1264553848-23555-2-git-send-email-omar.ramirez@ti.com>
 <1264553848-23555-3-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45370 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754117Ab0A0Aqq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jan 2010 19:46:46 -0500
In-Reply-To: <1264553848-23555-3-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

MEM module should be only initialized by services layer,
removed reference counter for it.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/gen/gs.c       |    8 ++------
 drivers/dsp/bridge/pmgr/dbll.c    |   15 ++-------------
 drivers/dsp/bridge/rmgr/dbdcd.c   |    8 +-------
 drivers/dsp/bridge/rmgr/rmm.c     |   17 ++---------------
 drivers/dsp/bridge/services/mem.c |   36 ++++++------------------------------
 5 files changed, 13 insertions(+), 71 deletions(-)

diff --git a/drivers/dsp/bridge/gen/gs.c b/drivers/dsp/bridge/gen/gs.c
index 5a5684c..1197829 100644
--- a/drivers/dsp/bridge/gen/gs.c
+++ b/drivers/dsp/bridge/gen/gs.c
@@ -52,7 +52,7 @@ void *GS_alloc(u32 size)
  */
 void GS_exit(void)
 {
-	MEM_Exit();
+	/* Do nothing */
 }
 
 /*
@@ -85,9 +85,5 @@ void GS_frees(void *ptr, u32 size)
  */
 void GS_init(void)
 {
-	static bool curInit;
-
-	if (curInit == false) {
-		curInit = MEM_Init(); /* which can't fail currently. */
-	}
+	/* Do nothing */
 }
diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index 5422d21..80ca4d4 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -317,7 +317,6 @@ void DBLL_exit(void)
 		  cRefs);
 
 	if (cRefs == 0) {
-		MEM_Exit();
 		GH_exit();
 #if GT_TRACE
 		DBLL_debugMask.flags = NULL;
@@ -468,30 +467,20 @@ DSP_STATUS DBLL_getSect(struct DBLL_LibraryObj *lib, char *name, u32 *pAddr,
  */
 bool DBLL_init(void)
 {
-	bool retVal = true;
-
 	DBC_Require(cRefs >= 0);
 
 	if (cRefs == 0) {
 		DBC_Assert(!DBLL_debugMask.flags);
 		GT_create(&DBLL_debugMask, "DL"); 	/* "DL" for dbDL */
 		GH_init();
-		retVal = MEM_Init();
-		if (!retVal)
-			MEM_Exit();
-
 	}
 
-	if (retVal)
-		cRefs++;
-
+	cRefs++;
 
 	GT_1trace(DBLL_debugMask, GT_5CLASS, "DBLL_init(), ref count:  0x%x\n",
 		 cRefs);
 
-	DBC_Ensure((retVal && (cRefs > 0)) || (!retVal && (cRefs >= 0)));
-
-	return retVal;
+	return true;
 }
 
 /*
diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index 3d50952..cb244f4 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -352,7 +352,6 @@ void DCD_Exit(void)
 	if (cRefs == 0) {
 		REG_Exit();
 		COD_Exit();
-		MEM_Exit();
 	}
 
 	DBC_Ensure(cRefs >= 0);
@@ -822,7 +821,6 @@ DSP_STATUS DCD_GetLibraryName(IN struct DCD_MANAGER *hDcdMgr,
  */
 bool DCD_Init(void)
 {
-	bool fInitMEM;
 	bool fInitREG;
 	bool fInitCOD;
 	bool fInit = true;
@@ -834,17 +832,13 @@ bool DCD_Init(void)
 
 	if (cRefs == 0) {
 		/* Initialize required modules. */
-		fInitMEM = MEM_Init();
 		fInitCOD = COD_Init();
 		fInitREG = REG_Init();
 
-		if (!fInitMEM || !fInitCOD || !fInitREG) {
+		if (!fInitCOD || !fInitREG) {
 			fInit = false;
 			GT_0trace(curTrace, GT_6CLASS, "DCD_Init failed\n");
 			/* Exit initialized modules. */
-			if (fInitMEM)
-				MEM_Exit();
-
 			if (fInitCOD)
 				COD_Exit();
 
diff --git a/drivers/dsp/bridge/rmgr/rmm.c b/drivers/dsp/bridge/rmgr/rmm.c
index cdd987a..5c484bc 100644
--- a/drivers/dsp/bridge/rmgr/rmm.c
+++ b/drivers/dsp/bridge/rmgr/rmm.c
@@ -335,9 +335,6 @@ void RMM_exit(void)
 	GT_1trace(RMM_debugMask, GT_5CLASS, "RMM_exit() ref count: 0x%x\n",
 		 cRefs);
 
-	if (cRefs == 0)
-		MEM_Exit();
-
 	DBC_Ensure(cRefs >= 0);
 }
 
@@ -396,31 +393,21 @@ bool RMM_free(struct RMM_TargetObj *target, u32 segid, u32 addr, u32 size,
  */
 bool RMM_init(void)
 {
-	bool retVal = true;
-
 	DBC_Require(cRefs >= 0);
 
 	if (cRefs == 0) {
 		DBC_Assert(!RMM_debugMask.flags);
 		GT_create(&RMM_debugMask, "RM");	/* "RM" for RMm */
 
-		retVal = MEM_Init();
-
-		if (!retVal)
-			MEM_Exit();
-
 	}
 
-	if (retVal)
-		cRefs++;
+	cRefs++;
 
 	GT_1trace(RMM_debugMask, GT_5CLASS,
 		 "RMM_init(), ref count:  0x%x\n",
 		 cRefs);
 
-	DBC_Ensure((retVal && (cRefs > 0)) || (!retVal && (cRefs >= 0)));
-
-	return retVal;
+	return true;
 }
 
 /*
diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
index 4d01917..cee646a 100644
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -45,8 +45,6 @@
 static struct GT_Mask MEM_debugMask = { NULL, NULL };	/* GT trace variable */
 #endif
 
-static u32 cRefs;		/* module reference count */
-
 static bool extPhysMemPoolEnabled;
 
 struct extPhysMemPool {
@@ -307,8 +305,6 @@ void *MEM_AllocPhysMem(u32 cBytes, u32 ulAlign, OUT u32 *pPhysicalAddress)
 	void *pVaMem = NULL;
 	dma_addr_t paMem;
 
-	DBC_Require(cRefs > 0);
-
 	GT_2trace(MEM_debugMask, GT_ENTER,
 		  "MEM_AllocPhysMem: cBytes 0x%x\tulAlign"
 		  "0x%x\n", cBytes, ulAlign);
@@ -414,17 +410,9 @@ void *MEM_Calloc(u32 cBytes, enum MEM_POOLATTRS type)
  */
 void MEM_Exit(void)
 {
-	DBC_Require(cRefs > 0);
-
-	GT_1trace(MEM_debugMask, GT_5CLASS, "MEM_Exit: cRefs 0x%x\n", cRefs);
-
-	cRefs--;
 #ifdef MEM_CHECK
-	if (cRefs == 0)
-		MEM_Check();
-
+	MEM_Check();
 #endif
-	DBC_Ensure(cRefs >= 0);
 }
 
 /*
@@ -434,7 +422,7 @@ void MEM_Exit(void)
  */
 void MEM_FlushCache(void *pMemBuf, u32 cBytes, s32 FlushType)
 {
-	if (cRefs <= 0 || !pMemBuf)
+	if (!pMemBuf)
 		return;
 
 	switch (FlushType) {
@@ -546,7 +534,6 @@ void MEM_Free(IN void *pMemBuf)
 void MEM_FreePhysMem(void *pVirtualAddress, u32 pPhysicalAddress,
 		     u32 cBytes)
 {
-	DBC_Require(cRefs > 0);
 	DBC_Require(pVirtualAddress != NULL);
 
 	GT_1trace(MEM_debugMask, GT_ENTER, "MEM_FreePhysMem: pVirtualAddress "
@@ -564,24 +551,13 @@ void MEM_FreePhysMem(void *pVirtualAddress, u32 pPhysicalAddress,
  */
 bool MEM_Init(void)
 {
-	DBC_Require(cRefs >= 0);
-
-	if (cRefs == 0) {
-		GT_create(&MEM_debugMask, "MM");	/* MM for MeM module */
+	GT_create(&MEM_debugMask, "MM");	/* MM for MeM module */
 
 #ifdef MEM_CHECK
-		mMan.lst.head.next = &mMan.lst.head;
-		mMan.lst.head.prev = &mMan.lst.head;
-		spin_lock_init(&mMan.lock);
+	mMan.lst.head.next = &mMan.lst.head;
+	mMan.lst.head.prev = &mMan.lst.head;
+	spin_lock_init(&mMan.lock);
 #endif
 
-	}
-
-	cRefs++;
-
-	GT_1trace(MEM_debugMask, GT_5CLASS, "MEM_Init: cRefs 0x%x\n", cRefs);
-
-	DBC_Ensure(cRefs > 0);
-
 	return true;
 }
-- 
1.6.2.4

