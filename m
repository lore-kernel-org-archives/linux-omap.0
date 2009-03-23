From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [OMAPZOOM][PATCH 2/3] DSPBRIDGE: Flooding the mailbox causes
 reliability issues (messages lost) and performance issues (busy looping
 waiting for a slot in the mailbox)
Date: Mon, 23 Mar 2009 16:06:14 -0500
Message-ID: <496565EC904933469F292DDA3F1663E60287E2B12C@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37499 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754507AbZCWVGV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Mar 2009 17:06:21 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2NL6FSR007003
	for <linux-omap@vger.kernel.org>; Mon, 23 Mar 2009 16:06:20 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2NL6F6O029162
	for <linux-omap@vger.kernel.org>; Mon, 23 Mar 2009 16:06:15 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "Aguilar Pena, Leed" <leed.aguilar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Fri, 20 Mar 2009 20:46:51 -0500
Subject: [PATCH] DSPBRIDGE: Flooding the mailbox causes reliability issues (messages lost) and performance issues (busy looping waiting for a slot in the mailbox)

This patch does:
don't flood the mailbox on MemUnMap
cleanup and remove HW_MMU_TLBFlushAll

Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
---
 drivers/dsp/bridge/hw/MMUAccInt.h   |    3 --
 drivers/dsp/bridge/hw/MMURegAcM.h   |   14 ---------
 drivers/dsp/bridge/hw/hw_mmu.c      |    9 ------
 drivers/dsp/bridge/hw/hw_mmu.h      |    2 -
 drivers/dsp/bridge/wmd/tiomap3430.c |   53 +++++++++++++++++++++--------------
 5 files changed, 32 insertions(+), 49 deletions(-)

diff --git a/drivers/dsp/bridge/hw/MMUAccInt.h b/drivers/dsp/bridge/hw/MMUAccInt.h
index 78e1d15..6ca1573 100644
--- a/drivers/dsp/bridge/hw/MMUAccInt.h
+++ b/drivers/dsp/bridge/hw/MMUAccInt.h
@@ -41,7 +41,6 @@
 #define EASIL1_MMUMMU_LD_TLBWriteRegister32   (MMU_BASE_EASIL1 + 214)
 #define EASIL1_MMUMMU_CAMWriteRegister32   (MMU_BASE_EASIL1 + 226)
 #define EASIL1_MMUMMU_RAMWriteRegister32 (MMU_BASE_EASIL1 + 268)
-#define EASIL1_MMUMMU_GFLUSHGlobalFlushWrite32 (MMU_BASE_EASIL1 + 317)
 #define EASIL1_MMUMMU_FLUSH_ENTRYWriteRegister32  (MMU_BASE_EASIL1 + 322)
 
 /* Register offset address definitions */
@@ -73,7 +72,5 @@
 #define MMU_MMU_LOCK_BaseValue_OFFSET   10
 #define MMU_MMU_LOCK_CurrentVictim_MASK   0x3f0
 #define MMU_MMU_LOCK_CurrentVictim_OFFSET    4
-#define MMU_MMU_GFLUSH_GlobalFlush_MASK 0x1
-#define MMU_MMU_GFLUSH_GlobalFlush_OFFSET   0
 
 #endif /* _MMU_ACC_INT_H */
diff --git a/drivers/dsp/bridge/hw/MMURegAcM.h b/drivers/dsp/bridge/hw/MMURegAcM.h
index a130b1a..e46fdcb 100644
--- a/drivers/dsp/bridge/hw/MMURegAcM.h
+++ b/drivers/dsp/bridge/hw/MMURegAcM.h
@@ -239,20 +239,6 @@
 }
 
 
-#define MMUMMU_GFLUSHGlobalFlushWrite32(baseAddress, value)\
-{\
-    const u32 offset = MMU_MMU_GFLUSH_OFFSET;\
-    register u32 data = RD_MEM_32_VOLATILE((baseAddress)+offset);\
-    register u32 newValue = (value);\
-    _DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_GFLUSHGlobalFlushWrite32);\
-    data &= ~(MMU_MMU_GFLUSH_GlobalFlush_MASK);\
-    newValue <<= MMU_MMU_GFLUSH_GlobalFlush_OFFSET;\
-    newValue &= MMU_MMU_GFLUSH_GlobalFlush_MASK;\
-    newValue |= data;\
-    WR_MEM_32_VOLATILE(baseAddress+offset, newValue);\
-}
-
-
 #define MMUMMU_FLUSH_ENTRYWriteRegister32(baseAddress, value)\
 {\
     const u32 offset = MMU_MMU_FLUSH_ENTRY_OFFSET;\
diff --git a/drivers/dsp/bridge/hw/hw_mmu.c b/drivers/dsp/bridge/hw/hw_mmu.c
index da7e092..ab65de0 100644
--- a/drivers/dsp/bridge/hw/hw_mmu.c
+++ b/drivers/dsp/bridge/hw/hw_mmu.c
@@ -212,15 +212,6 @@ HW_STATUS HW_MMU_VictimNumSet(const u32 baseAddress,
     return status;
 }
 
-HW_STATUS HW_MMU_TLBFlushAll(const u32 baseAddress)
-{
-    HW_STATUS status = RET_OK;
-
-    MMUMMU_GFLUSHGlobalFlushWrite32(baseAddress, HW_SET);
-
-    return status;
-}
-
 HW_STATUS HW_MMU_EventAck(const u32 baseAddress, u32 irqMask)
 {
     HW_STATUS status = RET_OK;
diff --git a/drivers/dsp/bridge/hw/hw_mmu.h b/drivers/dsp/bridge/hw/hw_mmu.h
index 924f32b..4783276 100644
--- a/drivers/dsp/bridge/hw/hw_mmu.h
+++ b/drivers/dsp/bridge/hw/hw_mmu.h
@@ -91,8 +91,6 @@ extern HW_STATUS HW_MMU_TLBFlush(const u32 baseAddress,
 				    u32 virtualAddr,
 				    u32 pageSize);
 
-extern HW_STATUS HW_MMU_TLBFlushAll(const u32 baseAddress);
-
 extern HW_STATUS HW_MMU_TLBAdd(const u32     baseAddress,
 				  u32	   physicalAddr,
 				  u32	   virtualAddr,
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index aa71a98..21d62c2 100755
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -87,6 +87,9 @@
 #define MMU_LARGE_PAGE_MASK      0xFFFF0000
 #define MMU_SMALL_PAGE_MASK      0xFFFFF000
 #define PAGES_II_LVL_TABLE   512
+
+#define MMU_GFLUSH 0x60
+
 /* Forward Declarations: */
 static DSP_STATUS WMD_BRD_Monitor(struct WMD_DEV_CONTEXT *pDevContext);
 static DSP_STATUS WMD_BRD_Read(struct WMD_DEV_CONTEXT *pDevContext,
@@ -234,6 +237,31 @@ static struct WMD_DRV_INTERFACE drvInterfaceFxns = {
 	WMD_MSG_SetQueueId,
 };
 
+static inline void tlb_flush_all(const u32 base)
+{
+    __raw_writeb(__raw_readb(base + MMU_GFLUSH) | 1, base + MMU_GFLUSH);
+}
+
+static inline void flush_all(struct WMD_DEV_CONTEXT *pDevContext)
+{
+	struct CFG_HOSTRES resources;
+	u32 temp = 0;
+
+	CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
+				&resources);
+	HW_PWRST_IVA2RegGet(resources.dwPrmBase, &temp);
+
+	if ((temp & HW_PWR_STATE_ON) == HW_PWR_STATE_OFF) {
+		/* IVA domain is not in ON state*/
+		DBG_Trace(DBG_LEVEL7, "temp value is 0x%x\n", temp);
+		CLK_Enable(SERVICESCLK_iva2_ck);
+		WakeDSP(pDevContext, NULL);
+		tlb_flush_all(pDevContext->dwDSPMmuBase);
+		CLK_Disable(SERVICESCLK_iva2_ck);
+	} else
+		tlb_flush_all(pDevContext->dwDSPMmuBase);
+}
+
 /*
  *  ======== WMD_DRV_Entry ========
  *  purpose:
@@ -1286,19 +1314,14 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CONTEXT *hDevContext,
 	struct WMD_DEV_CONTEXT *pDevContext = hDevContext;
 	struct HW_MMUMapAttrs_t hwAttrs;
 	u32 numOfActualTabEntries = 0;
-	u32 temp = 0;
-	struct CFG_HOSTRES resources;
 	u32 *pPhysAddrPageTbl = NULL;
 	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
+	u32 temp = 0;
 
 	DBG_Trace(DBG_ENTER, "> WMD_BRD_MemMap hDevContext %x, pa %x, va %x, "
 		 "size %x, ulMapAttr %x\n", hDevContext, ulMpuAddr, ulVirtAddr,
 		 ulNumBytes, ulMapAttr);
-	status = CFG_GetHostResources(
-			(struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
-					&resources);
-
 	if (ulNumBytes == 0)
 		return DSP_EINVALIDARG;
 
@@ -1426,16 +1449,7 @@ func_cont:
 	 * This is called from here instead from PteUpdate to avoid unnecessary
 	 * repetition while mapping non-contiguous physical regions of a virtual
 	 * region */
-	HW_PWRST_IVA2RegGet(resources.dwPrmBase, &temp);
-	if ((temp & HW_PWR_STATE_ON) == HW_PWR_STATE_OFF) {
-		/* IVA domain is not in ON state*/
-		DBG_Trace(DBG_LEVEL7, "temp value is 0x%x\n", temp);
-		CLK_Enable(SERVICESCLK_iva2_ck);
-		WakeDSP(pDevContext, NULL);
-		HW_MMU_TLBFlushAll(pDevContext->dwDSPMmuBase);
-		CLK_Disable(SERVICESCLK_iva2_ck);
-	} else
-		HW_MMU_TLBFlushAll(pDevContext->dwDSPMmuBase);
+	flush_all(pDevContext);
 	DBG_Trace(DBG_ENTER, "< WMD_BRD_MemMap status %x\n", status);
 	return status;
 }
@@ -1576,8 +1590,7 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CONTEXT *hDevContext,
 	 /* It is better to flush the TLB here, so that any stale old entries
 	 * get flushed */
 EXIT_LOOP:
-	CHNLSM_InterruptDSP2(pDevContext, MBX_PM_DSPWAKEUP);
-	HW_MMU_TLBFlushAll(pDevContext->dwDSPMmuBase);
+	flush_all(pDevContext);
 	DBG_Trace(DBG_LEVEL1, "WMD_BRD_MemUnMap vaCurr %x, pteAddrL1 %x "
 		  "pteAddrL2 %x\n", vaCurr, pteAddrL1, pteAddrL2);
 	DBG_Trace(DBG_ENTER, "< WMD_BRD_MemUnMap status %x remBytes %x, "
@@ -2060,9 +2073,7 @@ func_cont:
 	 * This is called from here instead from PteUpdate to avoid unnecessary
 	 * repetition while mapping non-contiguous physical regions of a virtual
 	 * region */
-	/* Waking up DSP before calling TLB Flush */
-	CHNLSM_InterruptDSP2(pDevContext, MBX_PM_DSPWAKEUP);
-	HW_MMU_TLBFlushAll(pDevContext->dwDSPMmuBase);
+	flush_all(pDevContext);
 	DBG_Trace(DBG_LEVEL7, "< WMD_BRD_MemMap  at end status %x\n", status);
 	return status;
 }
-- 
1.5.6.4

