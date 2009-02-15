From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [OMAPZOOM][PATCH] DSPBRIDGE Workqueue implementation for DVFS
Date: Sat, 14 Feb 2009 20:12:34 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A5303F8029664@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50675 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750788AbZBOCMl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Feb 2009 21:12:41 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1F2CaZq030857
	for <linux-omap@vger.kernel.org>; Sat, 14 Feb 2009 20:12:41 -0600
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n1F2CZIq011776
	for <linux-omap@vger.kernel.org>; Sat, 14 Feb 2009 20:12:36 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguilar Pena, Leed" <leed.aguilar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Nischal Varide  <nischal_@ti.com>
Date: Thu, 12 Feb 2009 13:43:40 -0600
Subject: [PATCH] DSPBRIDGE Workqueue implementation for DVFS

This patch will fix the BUG_ON message "Scheduling
while atomic" that was seen when enabling DVFS.

Signed-off-by: Nischal Varide  <nischal_@ti.com>
---
 drivers/dsp/bridge/hw/hw_mbox.c |    2 +-
 drivers/dsp/bridge/wmd/io_sm.c  |   47 +++++++++++++++++++++++++++++++++-----
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/dsp/bridge/hw/hw_mbox.c b/drivers/dsp/bridge/hw/hw_mbox.c
index 2c14ade..bc61d64 100644
--- a/drivers/dsp/bridge/hw/hw_mbox.c
+++ b/drivers/dsp/bridge/hw/hw_mbox.c
@@ -33,7 +33,7 @@
 /* width in bits of MBOX Id */
 #define HW_MBOX_ID_WIDTH	   2
 
-struct MAILBOX_CONTEXT mboxsetting = {0, 0, 0};
+struct MAILBOX_CONTEXT mboxsetting = {0x4, 0x1, 0x1};
 
 /* Saves the mailbox context */
 HW_STATUS HW_MBOX_saveSettings(u32 baseAddress)
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index ede25a3..040e87f 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -111,6 +111,7 @@
 
 /*  ----------------------------------- Host OS */
 #include <dspbridge/host_os.h>
+#include <linux/workqueue.h>
 #ifndef CONFIG_DISABLE_BRIDGE_PM
 #ifndef CONFIG_DISABLE_BRIDGE_DVFS
 #ifndef CONFIG_OMAP3_PM
@@ -205,6 +206,7 @@ struct IO_MGR {
 	/* private extnd proc info; mmu setup */
 	struct MGR_PROCESSOREXTINFO extProcInfo;
 	struct CMM_OBJECT *hCmmMgr; 	/* Shared Mem Mngr	      */
+	struct work_struct io_workq;	/* workqueue */
 	u32 dQuePowerMbxVal[MAX_PM_REQS];
 	u32 iQuePowerHead;
 	u32 iQuePowerTail;
@@ -223,7 +225,7 @@ struct IO_MGR {
 static void IO_DispatchChnl(IN struct IO_MGR *pIOMgr,
 			   IN OUT struct CHNL_OBJECT *pChnl, u32 iMode);
 static void IO_DispatchMsg(IN struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr);
-static void IO_DispatchPM(IN struct IO_MGR *pIOMgr);
+static void IO_DispatchPM(struct work_struct *work);
 static void NotifyChnlComplete(struct CHNL_OBJECT *pChnl,
 				struct CHNL_IRP *pChirp);
 static void InputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
@@ -238,6 +240,8 @@ static u32 ReadData(struct WMD_DEV_CONTEXT *hDevContext, void *pDest,
 			void *pSrc, u32 uSize);
 static u32 WriteData(struct WMD_DEV_CONTEXT *hDevContext, void *pDest,
 			void *pSrc, u32 uSize);
+static struct workqueue_struct *bridge_workqueue;
+
 #ifndef DSP_TRACEBUF_DISABLED
 void PrintDSPDebugTrace(struct IO_MGR *hIOMgr);
 #endif
@@ -281,6 +285,7 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 	struct CFG_HOSTRES hostRes;
 	struct CFG_DEVNODE *hDevNode;
 	struct CHNL_MGR *hChnlMgr;
+	static int ref_count;
 	u32 devType;
 	/* Check DBC requirements:  */
 	DBC_Require(phIOMgr != NULL);
@@ -305,12 +310,32 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 	if (DSP_FAILED(status))
 		goto func_cont;
 
+	/*
+	 *  Create a Single Threaded Work Queue
+	 */
+
+	if (ref_count == 0)
+		bridge_workqueue =
+			create_singlethread_workqueue("bridge_work-queue");
+	if (bridge_workqueue <= 0)
+		printk(KERN_ALERT "Bridge workqueue create failed in function \
+			%s at line %i", __func__, __LINE__);
+
 	/* Allocate IO manager object: */
 	MEM_AllocObject(pIOMgr, struct IO_MGR, IO_MGRSIGNATURE);
 	if (pIOMgr == NULL) {
 		status = DSP_EMEMORY;
 		goto func_cont;
 	}
+
+
+	/* Intializing Work Element */
+	if (ref_count == 0) {
+		INIT_WORK(&pIOMgr->io_workq, (void *)IO_DispatchPM);
+		ref_count = 1;
+	} else
+		PREPARE_WORK(&pIOMgr->io_workq, (void *)IO_DispatchPM);
+
 	/* Initialize CHNL_MGR object:    */
 #ifndef DSP_TRACEBUF_DISABLED
 	pIOMgr->pMsg = NULL;
@@ -379,10 +404,12 @@ DSP_STATUS WMD_IO_Destroy(struct IO_MGR *hIOMgr)
 		/* Unplug IRQ:    */
 		/* Disable interrupts from the board:  */
 		if (DSP_SUCCEEDED(DEV_GetWMDContext(hIOMgr->hDevObject,
-		   &hWmdContext))) {
+		   &hWmdContext)))
 			DBC_Assert(hWmdContext);
-		}
+
 		(void)CHNLSM_DisableInterrupt(hWmdContext);
+
+		flush_workqueue(bridge_workqueue);
 		/* Linux function to uninstall ISR */
 		free_irq(INT_MAIL_MPU_IRQ, (void *)hIOMgr);
 		(void)DPC_Destroy(hIOMgr->hDPC);
@@ -950,11 +977,14 @@ static void IO_DispatchMsg(IN struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
  *  ======== IO_DispatchPM ========
  *      Performs I/O dispatch on PM related messages from DSP
  */
-static void IO_DispatchPM(IN struct IO_MGR *pIOMgr)
+static void IO_DispatchPM(struct work_struct *work)
 {
+
+	struct IO_MGR *pIOMgr =
+				container_of(work, struct IO_MGR, io_workq);
+
 	DSP_STATUS status;
 	u32 pArg[2];
-
 	DBC_Require(MEM_IsValidHandle(pIOMgr, IO_MGRSIGNATURE));
 
 	DBG_Trace(DBG_LEVEL7, "IO_DispatchPM: Entering IO_DispatchPM : \n");
@@ -1005,6 +1035,7 @@ static void IO_DispatchPM(IN struct IO_MGR *pIOMgr)
 			pIOMgr->iQuePowerTail = 0;
 
 	}
+
 }
 
 /*
@@ -1049,7 +1080,7 @@ void IO_DPC(IN OUT void *pRefData)
 			PrintDSPDebugTrace(pIOMgr);
 	}
 #endif
-	IO_DispatchPM(pIOMgr);
+
 #ifndef DSP_TRACEBUF_DISABLED
 	PrintDSPDebugTrace(pIOMgr);
 #endif
@@ -1069,6 +1100,7 @@ irqreturn_t IO_ISR(int irq, IN void *pRefData)
 	DBC_Require(irq == INT_MAIL_MPU_IRQ);
 	DBC_Require(MEM_IsValidHandle(hIOMgr, IO_MGRSIGNATURE));
 	DBG_Trace(DBG_LEVEL3, "Entering IO_ISR(0x%x)\n", pRefData);
+
 	/* Call WMD's CHNLSM_ISR() to see if interrupt is ours, and process. */
 	if (IO_CALLISR(hIOMgr->hWmdContext, &fSchedDPC, &hIOMgr->wIntrVal)) {
 		{
@@ -1080,6 +1112,8 @@ irqreturn_t IO_ISR(int irq, IN void *pRefData)
 				if (hIOMgr->iQuePowerHead >= MAX_PM_REQS)
 					hIOMgr->iQuePowerHead = 0;
 
+				queue_work(bridge_workqueue,
+							 &(hIOMgr->io_workq));
 			}
 			if (hIOMgr->wIntrVal == MBX_DEH_RESET) {
 				DBG_Trace(DBG_LEVEL6, "*** DSP RESET ***\n");
@@ -1139,7 +1173,6 @@ void IO_RequestChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
 void IO_Schedule(struct IO_MGR *pIOMgr)
 {
 	DBC_Require(MEM_IsValidHandle(pIOMgr, IO_MGRSIGNATURE));
-
 	DPC_Schedule(pIOMgr->hDPC);
 }
 
-- 
1.5.4.3

