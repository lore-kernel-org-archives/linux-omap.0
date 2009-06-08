From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] DSPBRIDGE: Various compile warning fixes
Date: Mon,  8 Jun 2009 18:47:10 +0300
Message-ID: <1244476030-15195-1-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23674 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871AbZFHPsi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Jun 2009 11:48:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: omar.ramirez@ti.com, mika.kukkonen@nokia.com

From: Mika Kukkonen <mika.kukkonen@nokia.com>

This patch cleans up various warnings uncovered with extra warning flags:
  - empty if() bodies
  - bad comparison of pointer value
  - pointless check of unsigned value being smaller than zero
  - keyword 'extern' has to be first one in variable declaration
  - indentation fixes

Signed-off-by: Mika Kukkonen <mika.kukkonen@nokia.com>
Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/dbc.h |    6 +-
 arch/arm/plat-omap/include/dspbridge/dbg.h |    4 +-
 arch/arm/plat-omap/include/dspbridge/gt.h  |   16 ++++---
 arch/arm/plat-omap/include/dspbridge/mem.h |    2 +-
 drivers/dsp/bridge/wmd/io_sm.c             |   72 ++++++++++++++--------------
 drivers/dsp/bridge/wmd/ue_deh.c            |    2 +-
 6 files changed, 52 insertions(+), 50 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbc.h b/arch/arm/plat-omap/include/dspbridge/dbc.h
index 0e6a67d..ec55c1d 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbc.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbc.h
@@ -57,9 +57,9 @@
 
 #else
 
-#define DBC_Assert(exp)
-#define DBC_Require(exp)
-#define DBC_Ensure(exp)
+#define DBC_Assert(exp) {}
+#define DBC_Require(exp) {}
+#define DBC_Ensure(exp) {}
 
 #endif				/* DEBUG */
 
diff --git a/arch/arm/plat-omap/include/dspbridge/dbg.h b/arch/arm/plat-omap/include/dspbridge/dbg.h
index 7f44ff9..442955c 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbg.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbg.h
@@ -101,9 +101,9 @@
 	extern DSP_STATUS DBG_Trace(IN u8 bLevel, IN char *pstrFormat, ...);
 #else
 
-#define DBG_Exit(void)
+#define DBG_Exit(void) do {} while (0)
 #define DBG_Init(void) true
-#define DBG_Trace(bLevel, pstrFormat, args...)
+#define DBG_Trace(bLevel, pstrFormat, args...) do {} while (0)
 
 #endif	     /* (defined(DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE */
 
diff --git a/arch/arm/plat-omap/include/dspbridge/gt.h b/arch/arm/plat-omap/include/dspbridge/gt.h
index 456c866..72ef42d 100644
--- a/arch/arm/plat-omap/include/dspbridge/gt.h
+++ b/arch/arm/plat-omap/include/dspbridge/gt.h
@@ -261,13 +261,15 @@ extern struct GT_Config _GT_params;
 
 #define GT_query(mask, class)     false
 
-#define GT_0trace(mask, class, format)
-#define GT_1trace(mask, class, format, arg1)
-#define GT_2trace(mask, class, format, arg1, arg2)
-#define GT_3trace(mask, class, format, arg1, arg2, arg3)
-#define GT_4trace(mask, class, format, arg1, arg2, arg3, arg4)
-#define GT_5trace(mask, class, format, arg1, arg2, arg3, arg4, arg5)
-#define GT_6trace(mask, class, format, arg1, arg2, arg3, arg4, arg5, arg6)
+#define GT_0trace(mask, class, format) do {} while (0)
+#define GT_1trace(mask, class, format, arg1) do {} while (0)
+#define GT_2trace(mask, class, format, arg1, arg2) do {} while (0)
+#define GT_3trace(mask, class, format, arg1, arg2, arg3) do {} while (0)
+#define GT_4trace(mask, class, format, arg1, arg2, arg3, arg4) do {} while (0)
+#define GT_5trace(mask, class, format, arg1, arg2, arg3, arg4, arg5) \
+	do {} while (0)
+#define GT_6trace(mask, class, format, arg1, arg2, arg3, arg4, arg5, arg6) \
+	do {} while (0)
 
 #else				/* GT_TRACE == 1 */
 
diff --git a/arch/arm/plat-omap/include/dspbridge/mem.h b/arch/arm/plat-omap/include/dspbridge/mem.h
index 535ac3a..cc79047 100644
--- a/arch/arm/plat-omap/include/dspbridge/mem.h
+++ b/arch/arm/plat-omap/include/dspbridge/mem.h
@@ -317,7 +317,7 @@
  *  Ensures:
  *      - pBaseAddr no longer points to a valid linear address.
  */
-#define MEM_UnmapLinearAddress(pBaseAddr)
+#define MEM_UnmapLinearAddress(pBaseAddr) {}
 
 /*
  *  ======== MEM_ExtPhysPoolInit ========
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 6f7e338..39c34f7 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -204,7 +204,7 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 	struct CFG_HOSTRES hostRes;
 	struct CFG_DEVNODE *hDevNode;
 	struct CHNL_MGR *hChnlMgr;
-       static int ref_count;
+	static int ref_count;
 	u32 devType;
 	/* Check DBC requirements:  */
 	DBC_Require(phIOMgr != NULL);
@@ -215,31 +215,30 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 	DBC_Require(status != DSP_EHANDLE);
 	DBC_Require(hChnlMgr != NULL);
 	DBC_Require(hChnlMgr->hIOMgr == NULL);
-	 /*  Message manager will be created when a file is loaded, since
-	 *  size of message buffer in shared memory is configurable in
-	 *  the base image.  */
+	/*
+	 * Message manager will be created when a file is loaded, since
+	 * size of message buffer in shared memory is configurable in
+	 * the base image.
+	 */
 	DEV_GetWMDContext(hDevObject, &hWmdContext);
 	DBC_Assert(hWmdContext);
 	DEV_GetDevType(hDevObject, &devType);
-	/*  DSP shared memory area will get set properly when
-	 *  a program is loaded. They are unknown until a COFF file is
-	 *  loaded. I chose the value -1 because it was less likely to be
-	 *  a valid address than 0.  */
+	/*
+	 * DSP shared memory area will get set properly when
+	 * a program is loaded. They are unknown until a COFF file is
+	 * loaded. I chose the value -1 because it was less likely to be
+	 * a valid address than 0.
+	 */
 	pSharedMem = (struct SHM *) -1;
 	if (DSP_FAILED(status))
 		goto func_cont;
 
-    /*
-     *  Create a Single Threaded Work Queue
-     */
-
-       if (ref_count == 0)
-               bridge_workqueue = create_workqueue("bridge_work-queue");
-
-       if (bridge_workqueue <= 0)
-               DBG_Trace(DBG_LEVEL1, "Workque Create"
-                       " failed 0x%d \n", bridge_workqueue);
+	/* Create a Single Threaded Work Queue */
+	if (ref_count == 0)
+		bridge_workqueue = create_workqueue("bridge_work-queue");
 
+	if (!bridge_workqueue)
+		DBG_Trace(DBG_LEVEL1, "Workqueue creation failed!\n");
 
 	/* Allocate IO manager object: */
 	MEM_AllocObject(pIOMgr, struct IO_MGR, IO_MGRSIGNATURE);
@@ -247,12 +246,13 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 		status = DSP_EMEMORY;
 		goto func_cont;
 	}
-       /*Intializing Work Element*/
-       if (ref_count == 0) {
-               INIT_WORK(&pIOMgr->io_workq, (void *)IO_DispatchPM);
-               ref_count = 1;
-       } else
-               PREPARE_WORK(&pIOMgr->io_workq, (void *)IO_DispatchPM);
+
+	/* Intializing Work Element */
+	if (ref_count == 0) {
+		INIT_WORK(&pIOMgr->io_workq, (void *)IO_DispatchPM);
+		ref_count = 1;
+	} else
+		PREPARE_WORK(&pIOMgr->io_workq, (void *)IO_DispatchPM);
 
 	/* Initialize CHNL_MGR object:    */
 #ifndef DSP_TRACEBUF_DISABLED
@@ -283,18 +283,18 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 		IO_DisableInterrupt(hWmdContext);
 		if (devType == DSP_UNIT) {
 			/* Plug the channel ISR:. */
-                       if ((request_irq(INT_MAIL_MPU_IRQ, IO_ISR, 0,
-                               "DspBridge\tmailbox", (void *)pIOMgr)) == 0)
-                               status = DSP_SOK;
-                       else
-                               status = DSP_EFAIL;
+			if ((request_irq(INT_MAIL_MPU_IRQ, IO_ISR, 0,
+				"DspBridge\tmailbox", (void *)pIOMgr)) == 0)
+				status = DSP_SOK;
+			else
+				status = DSP_EFAIL;
 		}
-       if (DSP_SUCCEEDED(status))
-               DBG_Trace(DBG_LEVEL1, "ISR_IRQ Object 0x%x \n",
-                               pIOMgr);
-       else
-               status = CHNL_E_ISR;
-       } else
+		if (DSP_SUCCEEDED(status))
+			DBG_Trace(DBG_LEVEL1, "ISR_IRQ Object 0x%x \n",
+					pIOMgr);
+		else
+			status = CHNL_E_ISR;
+	} else
 		status = CHNL_E_ISR;
 func_cont:
 	if (DSP_FAILED(status)) {
@@ -1157,7 +1157,7 @@ static void InputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
 			    pChnlMgr->uWordSize;
 	chnlId = IO_GetValue(pIOMgr->hWmdContext, struct SHM, sm, inputId);
 	dwArg = IO_GetLong(pIOMgr->hWmdContext, struct SHM, sm, arg);
-	if (!(chnlId >= 0) || !(chnlId < CHNL_MAXCHANNELS)) {
+	if (chnlId >= CHNL_MAXCHANNELS) {
 		/* Shouldn't be here: would indicate corrupted SHM. */
 		DBC_Assert(chnlId);
 		goto func_end;
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index dcb44dd..fed8bd4 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -205,7 +205,7 @@ void WMD_DEH_Notify(struct DEH_MGR *hDehMgr, u32 ulEventMask,
 	DSP_STATUS status1 = DSP_EFAIL;
 	u32 memPhysical = 0;
 	u32 HW_MMU_MAX_TLB_COUNT = 31;
-	u32 extern faultAddr;
+	extern u32 faultAddr;
 	struct CFG_HOSTRES resources;
 	HW_STATUS hwStatus;
 
-- 
1.6.2.4

