From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/1] DSPBRIDGE: expose DSP_TRACEBUF as kernel config option
Date: Fri, 24 Jul 2009 13:24:11 +0300
Message-ID: <1248431051-26340-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:26868 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbZGXKYS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jul 2009 06:24:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ameya.palande@nokia.com, h-kanigeri2@ti.com, x0095840@ti.com, omar.ramirez@ti.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

"CONFIG_DSP_TRACEBUF" is introduced as a kernel config option to save
some amount of unused memory and "#ifndef DSP_TRACEBUF_DISABLED" was
not easy to understand.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/dsp/bridge/Kconfig     |    7 +++++++
 drivers/dsp/bridge/wmd/io_sm.c |   21 +++++++++------------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/dsp/bridge/Kconfig b/drivers/dsp/bridge/Kconfig
index 2fed82c..a43b19d 100644
--- a/drivers/dsp/bridge/Kconfig
+++ b/drivers/dsp/bridge/Kconfig
@@ -34,3 +34,10 @@ config BRIDGE_DEBUG
 	depends on MPU_BRIDGE
 	help
 	  Say Y to enable Bridge debugging capabilities
+
+config DSP_TRACEBUF
+	bool "DSP Debug Trace Support"
+	depends on BRIDGE_DEBUG
+	help
+	  Say Y to enable DSP debugging capabilities. baseimage needs
+	  to be built with debug option.
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index d8ae1f1..cd58cce 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -138,7 +138,7 @@ struct IO_MGR {
 	u32 dQuePowerMbxVal[MAX_PM_REQS];
 	u32 iQuePowerHead;
 	u32 iQuePowerTail;
-#ifndef DSP_TRACEBUF_DISABLED
+#ifdef CONFIG_DSP_TRACEBUF
 	u32 ulTraceBufferBegin; 	/* Trace message start address */
 	u32 ulTraceBufferEnd; 	/* Trace message end address */
 	u32 ulTraceBufferCurrent; 	/* Trace message current address */
@@ -169,9 +169,9 @@ static u32 ReadData(struct WMD_DEV_CONTEXT *hDevContext, void *pDest,
 static u32 WriteData(struct WMD_DEV_CONTEXT *hDevContext, void *pDest,
 			void *pSrc, u32 uSize);
 static struct workqueue_struct *bridge_workqueue;
-#ifndef DSP_TRACEBUF_DISABLED
+
 void PrintDSPDebugTrace(struct IO_MGR *hIOMgr);
-#endif
+
 
 /* Bus Addr (cached kernel)*/
 static DSP_STATUS registerSHMSegs(struct IO_MGR *hIOMgr,
@@ -255,7 +255,7 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 		PREPARE_WORK(&pIOMgr->io_workq, (void *)IO_DispatchPM);
 
 	/* Initialize CHNL_MGR object:    */
-#ifndef DSP_TRACEBUF_DISABLED
+#ifdef CONFIG_DSP_TRACEBUF
 	pIOMgr->pMsg = NULL;
 #endif
 	pIOMgr->hChnlMgr = hChnlMgr;
@@ -330,7 +330,7 @@ DSP_STATUS WMD_IO_Destroy(struct IO_MGR *hIOMgr)
                /* Linux function to uninstall ISR */
                free_irq(INT_MAIL_MPU_IRQ, (void *)hIOMgr);
                (void)DPC_Destroy(hIOMgr->hDPC);
-#ifndef DSP_TRACEBUF_DISABLED
+#ifdef CONFIG_DSP_TRACEBUF
 		if (hIOMgr->pMsg)
 			MEM_Free(hIOMgr->pMsg);
 #endif
@@ -448,7 +448,7 @@ func_cont1:
 		}
 	}
 	if (DSP_SUCCEEDED(status)) {
-#ifndef DSP_TRACEBUF_DISABLED
+#ifdef CONFIG_DSP_TRACEBUF
 		status = COD_GetSymValue(hCodMan, DSP_TRACESEC_END, &ulShm0End);
 		DBG_Trace(DBG_LEVEL7, "_BRIDGE_TRACE_END value = %x \n",
 			 ulShm0End);
@@ -775,7 +775,7 @@ func_cont:
 			 "0x%x\n", hMsgMgr->uMaxMsgs);
 		memset((void *) hIOMgr->pSharedMem, 0, sizeof(struct SHM));
 	}
-#ifndef DSP_TRACEBUF_DISABLED
+#ifdef CONFIG_DSP_TRACEBUF
 	if (DSP_SUCCEEDED(status)) {
 		/* Get the start address of trace buffer */
 		if (DSP_SUCCEEDED(status)) {
@@ -989,15 +989,12 @@ void IO_DPC(IN OUT void *pRefData)
 		IO_DispatchMsg(pIOMgr, pMsgMgr);
 	}
 #endif
-#ifndef DSP_TRACEBUF_DISABLED
+#ifdef CONFIG_DSP_TRACEBUF
 	if (pIOMgr->wIntrVal & MBX_DBG_CLASS) {
 		/* notify DSP Trace message */
 		if (pIOMgr->wIntrVal & MBX_DBG_SYSPRINTF)
 			PrintDSPDebugTrace(pIOMgr);
 	}
-#endif
-
-#ifndef DSP_TRACEBUF_DISABLED
 	PrintDSPDebugTrace(pIOMgr);
 #endif
 }
@@ -1767,7 +1764,7 @@ DSP_STATUS WMD_IO_GetProcLoad(IN struct IO_MGR *hIOMgr,
 	return DSP_SOK;
 }
 
-#ifndef DSP_TRACEBUF_DISABLED
+#ifdef CONFIG_DSP_TRACEBUF
 void PrintDSPDebugTrace(struct IO_MGR *hIOMgr)
 {
 	u32 ulNewMessageLength = 0, ulGPPCurPointer;
-- 
1.6.0.4

