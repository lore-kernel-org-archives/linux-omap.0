From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 08/14] dspbridge: deh: refactor in mmu_fault_print_stack()
Date: Sun, 16 May 2010 18:45:59 +0300
Message-ID: <1274024765-21076-9-git-send-email-felipe.contreras@gmail.com>
References: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:34390 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444Ab0EPPqZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 11:46:25 -0400
Received: by fg-out-1718.google.com with SMTP id 22so178499fge.1
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 08:46:24 -0700 (PDT)
In-Reply-To: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

All this code is just to print the stack, so make it clearer.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/dsp/bridge/core/ue_deh.c |   58 +++++++++++++++++++++-----------------
 1 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/drivers/dsp/bridge/core/ue_deh.c b/drivers/dsp/bridge/core/ue_deh.c
index f661aaf..1d1b87b 100644
--- a/drivers/dsp/bridge/core/ue_deh.c
+++ b/drivers/dsp/bridge/core/ue_deh.c
@@ -189,9 +189,8 @@ static void wait_for_timer(void)
 	omap_dm_timer_disable(timer);
 }
 
-void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
+static void mmu_fault_print_stack(struct bridge_dev_context *dev_context)
 {
-	struct bridge_dev_context *dev_context;
 	struct cfg_hostres *resources;
 	struct hw_mmu_map_attrs_t map_attrs = {
 		.endianism = HW_LITTLE_ENDIAN,
@@ -200,12 +199,41 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 	};
 	void *dummy_va_addr;
 
+	resources = dev_context->resources;
+	dummy_va_addr = (void*)__get_free_page(GFP_ATOMIC);
+
+	/*
+	 * Before acking the MMU fault, let's make sure MMU can only
+	 * access entry #0. Then add a new entry so that the DSP OS
+	 * can continue in order to dump the stack.
+	 */
+	hw_mmu_twl_disable(resources->dw_dmmu_base);
+	hw_mmu_tlb_flush_all(resources->dw_dmmu_base);
+
+	hw_mmu_tlb_add(resources->dw_dmmu_base,
+			virt_to_phys(dummy_va_addr), fault_addr,
+			HW_PAGE_SIZE4KB, 1,
+			&map_attrs, HW_SET, HW_SET);
+
+	wait_for_timer();
+	/* Clear MMU interrupt */
+	hw_mmu_event_ack(resources->dw_dmmu_base,
+			HW_MMU_TRANSLATION_FAULT);
+	dump_dsp_stack(dev_context);
+
+	hw_mmu_disable(resources->dw_dmmu_base);
+	free_page((unsigned long)dummy_va_addr);
+}
+
+void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
+{
+	struct bridge_dev_context *dev_context;
+
 	if (!deh_mgr)
 		return;
 
 	dev_info(bridge, "%s: device exception\n", __func__);
 	dev_context = deh_mgr->hbridge_context;
-	resources = dev_context->resources;
 
 	switch (ulEventMask) {
 	case DSP_SYSERROR:
@@ -230,32 +258,10 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 			(unsigned int) deh_mgr->err_info.dw_val1,
 			(unsigned int) deh_mgr->err_info.dw_val2,
 			(unsigned int) fault_addr);
-		dummy_va_addr = (void*)__get_free_page(GFP_ATOMIC);
 
 		print_dsp_trace_buffer(dev_context);
 		dump_dl_modules(dev_context);
-
-		/*
-		 * Before acking the MMU fault, let's make sure MMU can only
-		 * access entry #0. Then add a new entry so that the DSP OS
-		 * can continue in order to dump the stack.
-		 */
-		hw_mmu_twl_disable(resources->dw_dmmu_base);
-		hw_mmu_tlb_flush_all(resources->dw_dmmu_base);
-
-		hw_mmu_tlb_add(resources->dw_dmmu_base,
-				virt_to_phys(dummy_va_addr), fault_addr,
-				HW_PAGE_SIZE4KB, 1,
-				&map_attrs, HW_SET, HW_SET);
-
-		wait_for_timer();
-		/* Clear MMU interrupt */
-		hw_mmu_event_ack(resources->dw_dmmu_base,
-				HW_MMU_TRANSLATION_FAULT);
-		dump_dsp_stack(dev_context);
-
-		hw_mmu_disable(resources->dw_dmmu_base);
-		free_page((unsigned long)dummy_va_addr);
+		mmu_fault_print_stack(dev_context);
 		break;
 #ifdef CONFIG_BRIDGE_NTFY_PWRERR
 	case DSP_PWRERROR:
-- 
1.7.1

