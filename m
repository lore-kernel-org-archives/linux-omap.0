From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 10/14] dspbridge: deh: remove err_info
Date: Sun, 16 May 2010 18:46:01 +0300
Message-ID: <1274024765-21076-11-git-send-email-felipe.contreras@gmail.com>
References: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:5081 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444Ab0EPPq3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 11:46:29 -0400
Received: by fg-out-1718.google.com with SMTP id d23so2359940fga.1
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 08:46:28 -0700 (PDT)
In-Reply-To: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

We only use it to pass the MMU fault address.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/plat-omap/include/dspbridge/dbdefs.h |    1 -
 drivers/dsp/bridge/core/_deh.h                |    2 +-
 drivers/dsp/bridge/core/mmu_fault.c           |   11 +------
 drivers/dsp/bridge/core/mmu_fault.h           |    2 -
 drivers/dsp/bridge/core/ue_deh.c              |   34 +++---------------------
 5 files changed, 8 insertions(+), 42 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbdefs.h b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
index c6703a2..3c337e4 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
@@ -431,7 +431,6 @@ struct dsp_errorinfo {
 struct dsp_processorstate {
 	u32 cb_struct;
 	enum dsp_procstate proc_state;
-	struct dsp_errorinfo err_info;
 };
 
 /*
diff --git a/drivers/dsp/bridge/core/_deh.h b/drivers/dsp/bridge/core/_deh.h
index 8da2212..32b84f3 100644
--- a/drivers/dsp/bridge/core/_deh.h
+++ b/drivers/dsp/bridge/core/_deh.h
@@ -26,7 +26,7 @@
 struct deh_mgr {
 	struct bridge_dev_context *hbridge_context;	/* Bridge context. */
 	struct ntfy_object *ntfy_obj;	/* NTFY object */
-	struct dsp_errorinfo err_info;	/* DSP exception info. */
+	u32 fault_addr;
 
 	/* MMU Fault DPC */
 	struct tasklet_struct dpc_tasklet;
diff --git a/drivers/dsp/bridge/core/mmu_fault.c b/drivers/dsp/bridge/core/mmu_fault.c
index 1de9cb4..49034cf 100644
--- a/drivers/dsp/bridge/core/mmu_fault.c
+++ b/drivers/dsp/bridge/core/mmu_fault.c
@@ -42,8 +42,6 @@
 #include "_tiomap.h"
 #include "mmu_fault.h"
 
-u32 fault_addr;
-
 /*
  *  ======== mmu_fault_dpc ========
  *      Deferred procedure call to handle DSP MMU fault.
@@ -80,9 +78,9 @@ irqreturn_t mmu_fault_isr(int irq, IN void *pRefData)
 
 	hw_mmu_event_status(resources->dw_dmmu_base, &dmmu_event_mask);
 	if (dmmu_event_mask == HW_MMU_TRANSLATION_FAULT) {
-		hw_mmu_fault_addr_read(resources->dw_dmmu_base, &fault_addr);
+		hw_mmu_fault_addr_read(resources->dw_dmmu_base, &deh_mgr_obj->fault_addr);
 		dev_info(bridge, "%s: status=0x%x, fault_addr=0x%x\n", __func__,
-				dmmu_event_mask, fault_addr);
+				dmmu_event_mask, deh_mgr_obj->fault_addr);
 		/*
 		 * Schedule a DPC directly. In the future, it may be
 		 * necessary to check if DSP MMU fault is intended for
@@ -90,11 +88,6 @@ irqreturn_t mmu_fault_isr(int irq, IN void *pRefData)
 		 */
 		tasklet_schedule(&deh_mgr_obj->dpc_tasklet);
 
-		/* Reset err_info structure before use. */
-		deh_mgr_obj->err_info.dw_err_mask = DSP_MMUFAULT;
-		deh_mgr_obj->err_info.dw_val1 = fault_addr >> 16;
-		deh_mgr_obj->err_info.dw_val2 = fault_addr & 0xFFFF;
-		deh_mgr_obj->err_info.dw_val3 = 0L;
 		/* Disable the MMU events, else once we clear it will
 		 * start to raise INTs again */
 		hw_mmu_event_disable(resources->dw_dmmu_base,
diff --git a/drivers/dsp/bridge/core/mmu_fault.h b/drivers/dsp/bridge/core/mmu_fault.h
index 74db489..537e6e7 100644
--- a/drivers/dsp/bridge/core/mmu_fault.h
+++ b/drivers/dsp/bridge/core/mmu_fault.h
@@ -19,8 +19,6 @@
 #ifndef MMU_FAULT_
 #define MMU_FAULT_
 
-extern u32 fault_addr;
-
 /*
  *  ======== mmu_fault_dpc ========
  *      Deferred procedure call to handle DSP MMU fault.
diff --git a/drivers/dsp/bridge/core/ue_deh.c b/drivers/dsp/bridge/core/ue_deh.c
index 2388780..6035757 100644
--- a/drivers/dsp/bridge/core/ue_deh.c
+++ b/drivers/dsp/bridge/core/ue_deh.c
@@ -94,10 +94,6 @@ dsp_status bridge_deh_create(struct deh_mgr **ret_deh_mgr,
 
 	/* Fill in context structure */
 	deh_mgr->hbridge_context = hbridge_context;
-	deh_mgr->err_info.dw_err_mask = 0L;
-	deh_mgr->err_info.dw_val1 = 0L;
-	deh_mgr->err_info.dw_val2 = 0L;
-	deh_mgr->err_info.dw_val3 = 0L;
 
 	/* Install ISR function for DSP MMU fault */
 	status = request_irq(INT_DSP_MMU_IRQ, mmu_fault_isr, 0,
@@ -189,7 +185,8 @@ static void wait_for_timer(void)
 	omap_dm_timer_disable(timer);
 }
 
-static void mmu_fault_print_stack(struct bridge_dev_context *dev_context)
+static void mmu_fault_print_stack(struct bridge_dev_context *dev_context,
+		u32 fault_addr)
 {
 	struct cfg_hostres *resources;
 	struct hw_mmu_map_attrs_t map_attrs = {
@@ -237,49 +234,28 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 
 	switch (ulEventMask) {
 	case DSP_SYSERROR:
-		/* reset err_info structure before use */
-		deh_mgr->err_info.dw_err_mask = DSP_SYSERROR;
-		deh_mgr->err_info.dw_val1 = 0L;
-		deh_mgr->err_info.dw_val2 = 0L;
-		deh_mgr->err_info.dw_val3 = 0L;
-		deh_mgr->err_info.dw_val1 = dwErrInfo;
 		dev_err(bridge, "%s: %s, err_info = 0x%x\n",
 				__func__, "DSP_SYSERROR", dwErrInfo);
 		dump_dl_modules(dev_context);
 		dump_dsp_stack(dev_context);
 		break;
 	case DSP_MMUFAULT:
-		/* MMU fault routine should have set err info structure. */
-		deh_mgr->err_info.dw_err_mask = DSP_MMUFAULT;
 		dev_err(bridge, "%s: %s, err_info = 0x%x\n",
 				__func__, "DSP_MMUFAULT", dwErrInfo);
-		dev_info(bridge, "%s: %s, high=0x%x, low=0x%x, "
-			"fault=0x%x\n", __func__, "DSP_MMUFAULT",
-			(unsigned int) deh_mgr->err_info.dw_val1,
-			(unsigned int) deh_mgr->err_info.dw_val2,
-			(unsigned int) fault_addr);
+		dev_info(bridge, "%s: %s, fault=0x%x\n", __func__, "DSP_MMUFAULT",
+				deh_mgr->fault_addr);
 
 		print_dsp_trace_buffer(dev_context);
 		dump_dl_modules(dev_context);
-		mmu_fault_print_stack(dev_context);
+		mmu_fault_print_stack(dev_context, deh_mgr->fault_addr);
 		break;
 #ifdef CONFIG_BRIDGE_NTFY_PWRERR
 	case DSP_PWRERROR:
-		/* reset err_info structure before use */
-		deh_mgr->err_info.dw_err_mask = DSP_PWRERROR;
-		deh_mgr->err_info.dw_val1 = 0L;
-		deh_mgr->err_info.dw_val2 = 0L;
-		deh_mgr->err_info.dw_val3 = 0L;
-		deh_mgr->err_info.dw_val1 = dwErrInfo;
 		dev_err(bridge, "%s: %s, err_info = 0x%x\n",
 				__func__, "DSP_PWRERROR", dwErrInfo);
 		break;
 #endif /* CONFIG_BRIDGE_NTFY_PWRERR */
 	case DSP_WDTOVERFLOW:
-		deh_mgr->err_info.dw_err_mask = DSP_WDTOVERFLOW;
-		deh_mgr->err_info.dw_val1 = 0L;
-		deh_mgr->err_info.dw_val2 = 0L;
-		deh_mgr->err_info.dw_val3 = 0L;
 		dev_err(bridge, "%s: DSP_WDTOVERFLOW\n", __func__);
 		break;
 	default:
-- 
1.7.1

