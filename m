From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 07/13] staging: ti dspbridge: deh: refactor in mmu_fault_print_stack()
Date: Sun,  4 Jul 2010 16:34:33 +0300
Message-ID: <1278250479-16982-8-git-send-email-felipe.contreras@gmail.com>
References: <1278250479-16982-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40955 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757698Ab0GDNe4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Jul 2010 09:34:56 -0400
Received: by mail-bw0-f46.google.com with SMTP id 1so2295322bwz.19
        for <linux-omap@vger.kernel.org>; Sun, 04 Jul 2010 06:34:56 -0700 (PDT)
In-Reply-To: <1278250479-16982-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Greg KH <greg@kroah.com>, Felipe Contreras <felipe.contreras@gmail.com>

All this code is just to print the stack, so make it clearer.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/staging/tidspbridge/core/ue_deh.c |   65 ++++++++++++++++-------------
 1 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/ue_deh.c b/drivers/staging/tidspbridge/core/ue_deh.c
index 793e982..1e506d7 100644
--- a/drivers/staging/tidspbridge/core/ue_deh.c
+++ b/drivers/staging/tidspbridge/core/ue_deh.c
@@ -140,9 +140,8 @@ int bridge_deh_register_notify(struct deh_mgr *deh_mgr, u32 event_mask,
 		return ntfy_unregister(deh_mgr->ntfy_obj, hnotification);
 }
 
-void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
+static void mmu_fault_print_stack(struct bridge_dev_context *dev_context)
 {
-	struct bridge_dev_context *dev_context;
 	struct cfg_hostres *resources;
 	struct hw_mmu_map_attrs_t map_attrs = {
 		.endianism = HW_LITTLE_ENDIAN,
@@ -151,12 +150,45 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
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
+	dsp_clk_enable(DSP_CLK_GPT8);
+
+	dsp_gpt_wait_overflow(DSP_CLK_GPT8, 0xfffffffe);
+
+	/* Clear MMU interrupt */
+	hw_mmu_event_ack(resources->dw_dmmu_base,
+			HW_MMU_TRANSLATION_FAULT);
+	dump_dsp_stack(dev_context);
+	dsp_clk_disable(DSP_CLK_GPT8);
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
@@ -181,36 +213,11 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 			(unsigned int) deh_mgr->err_info.dw_val1,
 			(unsigned int) deh_mgr->err_info.dw_val2,
 			(unsigned int) fault_addr);
-		dummy_va_addr = (void*)__get_free_page(GFP_ATOMIC);
 
 		print_dsp_trace_buffer(dev_context);
 		dump_dl_modules(dev_context);
 
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
-		dsp_clk_enable(DSP_CLK_GPT8);
-
-		dsp_gpt_wait_overflow(DSP_CLK_GPT8, 0xfffffffe);
-
-		/* Clear MMU interrupt */
-		hw_mmu_event_ack(resources->dw_dmmu_base,
-				HW_MMU_TRANSLATION_FAULT);
-		dump_dsp_stack(dev_context);
-		dsp_clk_disable(DSP_CLK_GPT8);
-
-		hw_mmu_disable(resources->dw_dmmu_base);
-		free_page((unsigned long)dummy_va_addr);
+		mmu_fault_print_stack(dev_context);
 		break;
 #ifdef CONFIG_BRIDGE_NTFY_PWRERR
 	case DSP_PWRERROR:
-- 
1.7.1

