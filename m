From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 03/14] dspbridge: mmufault: trivial cleanups
Date: Sun, 16 May 2010 18:45:54 +0300
Message-ID: <1274024765-21076-4-git-send-email-felipe.contreras@gmail.com>
References: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:34390 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138Ab0EPPqP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 11:46:15 -0400
Received: by fg-out-1718.google.com with SMTP id 22so178499fge.1
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 08:46:15 -0700 (PDT)
In-Reply-To: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/dsp/bridge/core/mmu_fault.c |  102 ++++++++++++-----------------------
 1 files changed, 34 insertions(+), 68 deletions(-)

diff --git a/drivers/dsp/bridge/core/mmu_fault.c b/drivers/dsp/bridge/core/mmu_fault.c
index 883f45d..1de9cb4 100644
--- a/drivers/dsp/bridge/core/mmu_fault.c
+++ b/drivers/dsp/bridge/core/mmu_fault.c
@@ -42,11 +42,8 @@
 #include "_tiomap.h"
 #include "mmu_fault.h"
 
-static u32 dmmu_event_mask;
 u32 fault_addr;
 
-static bool mmu_check_if_fault(struct bridge_dev_context *dev_context);
-
 /*
  *  ======== mmu_fault_dpc ========
  *      Deferred procedure call to handle DSP MMU fault.
@@ -55,9 +52,10 @@ void mmu_fault_dpc(IN unsigned long pRefData)
 {
 	struct deh_mgr *hdeh_mgr = (struct deh_mgr *)pRefData;
 
-	if (hdeh_mgr)
-		bridge_deh_notify(hdeh_mgr, DSP_MMUFAULT, 0L);
+	if (!hdeh_mgr)
+		return;
 
+	bridge_deh_notify(hdeh_mgr, DSP_MMUFAULT, 0L);
 }
 
 /*
@@ -66,76 +64,44 @@ void mmu_fault_dpc(IN unsigned long pRefData)
  */
 irqreturn_t mmu_fault_isr(int irq, IN void *pRefData)
 {
-	struct deh_mgr *deh_mgr_obj = (struct deh_mgr *)pRefData;
-	struct bridge_dev_context *dev_context;
+	struct deh_mgr *deh_mgr_obj = pRefData;
 	struct cfg_hostres *resources;
+	u32 dmmu_event_mask;
 
-	DBC_REQUIRE(irq == INT_DSP_MMU_IRQ);
-	DBC_REQUIRE(deh_mgr_obj);
-
-	if (deh_mgr_obj) {
-
-		dev_context =
-		    (struct bridge_dev_context *)deh_mgr_obj->hbridge_context;
-
-		resources = dev_context->resources;
+	if (!deh_mgr_obj)
+		return IRQ_HANDLED;
 
-		if (!resources) {
-			dev_dbg(bridge, "%s: Failed to get Host Resources\n",
+	resources = deh_mgr_obj->hbridge_context->resources;
+	if (!resources) {
+		dev_dbg(bridge, "%s: Failed to get Host Resources\n",
 				__func__);
-			return IRQ_HANDLED;
-		}
-		if (mmu_check_if_fault(dev_context)) {
-			printk(KERN_INFO "***** DSPMMU FAULT ***** IRQStatus "
-			       "0x%x\n", dmmu_event_mask);
-			printk(KERN_INFO "***** DSPMMU FAULT ***** fault_addr "
-			       "0x%x\n", fault_addr);
-			/*
-			 * Schedule a DPC directly. In the future, it may be
-			 * necessary to check if DSP MMU fault is intended for
-			 * Bridge.
-			 */
-			tasklet_schedule(&deh_mgr_obj->dpc_tasklet);
-
-			/* Reset err_info structure before use. */
-			deh_mgr_obj->err_info.dw_err_mask = DSP_MMUFAULT;
-			deh_mgr_obj->err_info.dw_val1 = fault_addr >> 16;
-			deh_mgr_obj->err_info.dw_val2 = fault_addr & 0xFFFF;
-			deh_mgr_obj->err_info.dw_val3 = 0L;
-			/* Disable the MMU events, else once we clear it will
-			 * start to raise INTs again */
-			hw_mmu_event_disable(resources->dw_dmmu_base,
-					     HW_MMU_TRANSLATION_FAULT);
-		} else {
-			hw_mmu_event_disable(resources->dw_dmmu_base,
-					     HW_MMU_ALL_INTERRUPTS);
-		}
+		return IRQ_HANDLED;
 	}
-	return IRQ_HANDLED;
-}
 
-/*
- *  ======== mmu_check_if_fault ========
- *      Check to see if MMU Fault is valid TLB miss from DSP
- *  Note: This function is called from an ISR
- */
-static bool mmu_check_if_fault(struct bridge_dev_context *dev_context)
-{
-
-	bool ret = false;
-	hw_status hw_status_obj;
-	struct cfg_hostres *resources = dev_context->resources;
-
-	if (!resources) {
-		dev_dbg(bridge, "%s: Failed to get Host Resources in\n",
-			__func__);
-		return ret;
-	}
-	hw_status_obj =
-	    hw_mmu_event_status(resources->dw_dmmu_base, &dmmu_event_mask);
+	hw_mmu_event_status(resources->dw_dmmu_base, &dmmu_event_mask);
 	if (dmmu_event_mask == HW_MMU_TRANSLATION_FAULT) {
 		hw_mmu_fault_addr_read(resources->dw_dmmu_base, &fault_addr);
-		ret = true;
+		dev_info(bridge, "%s: status=0x%x, fault_addr=0x%x\n", __func__,
+				dmmu_event_mask, fault_addr);
+		/*
+		 * Schedule a DPC directly. In the future, it may be
+		 * necessary to check if DSP MMU fault is intended for
+		 * Bridge.
+		 */
+		tasklet_schedule(&deh_mgr_obj->dpc_tasklet);
+
+		/* Reset err_info structure before use. */
+		deh_mgr_obj->err_info.dw_err_mask = DSP_MMUFAULT;
+		deh_mgr_obj->err_info.dw_val1 = fault_addr >> 16;
+		deh_mgr_obj->err_info.dw_val2 = fault_addr & 0xFFFF;
+		deh_mgr_obj->err_info.dw_val3 = 0L;
+		/* Disable the MMU events, else once we clear it will
+		 * start to raise INTs again */
+		hw_mmu_event_disable(resources->dw_dmmu_base,
+				HW_MMU_TRANSLATION_FAULT);
+	} else {
+		hw_mmu_event_disable(resources->dw_dmmu_base,
+				HW_MMU_ALL_INTERRUPTS);
 	}
-	return ret;
+	return IRQ_HANDLED;
 }
-- 
1.7.1

