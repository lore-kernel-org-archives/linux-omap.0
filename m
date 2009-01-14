From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [OMAPZOOM][PATCH] DSPBRIDGE Wakeup IVA before accessing IVA MMU
 Registers
Date: Wed, 14 Jan 2009 14:07:01 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A5303F21B0E6F@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57999 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756934AbZANUHJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2009 15:07:09 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n0EK73mR020252
	for <linux-omap@vger.kernel.org>; Wed, 14 Jan 2009 14:07:08 -0600
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n0EK73Br006405
	for <linux-omap@vger.kernel.org>; Wed, 14 Jan 2009 14:07:03 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Ramesh Gupta <grgupta@ti.com>
Date: Wed, 14 Jan 2009 17:39:20 +0530
Subject: [PATCH] DSPBRIDGE Wakeup IVA before accessing IVA MMU Registers

Wakeup IVA before accessing IVA MMU Registers

Signed-off-by: Ramesh Gupta G <grgupta@ti.com>

---
 drivers/dsp/bridge/wmd/tiomap3430.c |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index c05383e..d838169 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -1289,6 +1290,7 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CONTEXT *hDevContext,
 	struct HW_MMUMapAttrs_t hwAttrs;
 	u32 numOfActualTabEntries = 0;
 	u32 temp = 0;
+	struct CFG_HOSTRES resources;
 	u32 *pPhysAddrPageTbl = NULL;
 	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
@@ -1296,6 +1298,10 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CONTEXT *hDevContext,
 	DBG_Trace(DBG_ENTER, "> WMD_BRD_MemMap hDevContext %x, pa %x, va %x, "
 		 "size %x, ulMapAttr %x\n", hDevContext, ulMpuAddr, ulVirtAddr,
 		 ulNumBytes, ulMapAttr);
+	status = CFG_GetHostResources(
+			(struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
+					&resources);
+
 	if (ulNumBytes == 0)
 		return DSP_EINVALIDARG;
 
@@ -1423,7 +1429,16 @@ func_cont:
 	 * This is called from here instead from PteUpdate to avoid unnecessary
 	 * repetition while mapping non-contiguous physical regions of a virtual
 	 * region */
-	HW_MMU_TLBFlushAll(pDevContext->dwDSPMmuBase);
+	HW_PWRST_IVA2RegGet(resources.dwPrmBase, &temp);
+	if ((temp & HW_PWR_STATE_ON) == HW_PWR_STATE_OFF) {
+		/* IVA domain is not in ON state*/
+		DBG_Trace(DBG_LEVEL7, "temp value is 0x%x\n", temp);
+		CLK_Enable(SERVICESCLK_iva2_ck);
+		WakeDSP(pDevContext, NULL);
+		HW_MMU_TLBFlushAll(pDevContext->dwDSPMmuBase);
+		CLK_Disable(SERVICESCLK_iva2_ck);
+	} else
+		HW_MMU_TLBFlushAll(pDevContext->dwDSPMmuBase);
 	DBG_Trace(DBG_ENTER, "< WMD_BRD_MemMap status %x\n", status);
 	return status;
 }
@@ -1564,6 +1579,7 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CONTEXT *hDevContext,
 	 /* It is better to flush the TLB here, so that any stale old entries
 	 * get flushed */
 EXIT_LOOP:
+	IO_InterruptDSP2(pDevContext, MBX_PM_DSPWAKEUP);
 	HW_MMU_TLBFlushAll(pDevContext->dwDSPMmuBase);
 	DBG_Trace(DBG_LEVEL1, "WMD_BRD_MemUnMap vaCurr %x, pteAddrL1 %x "
 		  "pteAddrL2 %x\n", vaCurr, pteAddrL1, pteAddrL2);
@@ -2048,6 +2064,7 @@ func_cont:
 	 * repetition while mapping non-contiguous physical regions of a virtual
 	 * region */
 	/* Waking up DSP before calling TLB Flush */
+	IO_InterruptDSP2(pDevContext, MBX_PM_DSPWAKEUP);
 	HW_MMU_TLBFlushAll(pDevContext->dwDSPMmuBase);
 	DBG_Trace(DBG_LEVEL7, "< WMD_BRD_MemMap  at end status %x\n", status);
 	return status;
-- 
1.5.3.2

