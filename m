From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 02/14] dspbridge: deh: trivial cleanups
Date: Sun, 16 May 2010 18:45:53 +0300
Message-ID: <1274024765-21076-3-git-send-email-felipe.contreras@gmail.com>
References: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:5081 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108Ab0EPPqO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 11:46:14 -0400
Received: by fg-out-1718.google.com with SMTP id d23so2359940fga.1
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 08:46:13 -0700 (PDT)
In-Reply-To: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/dsp/bridge/core/ue_deh.c |  112 ++++++++++++++------------------------
 1 files changed, 41 insertions(+), 71 deletions(-)

diff --git a/drivers/dsp/bridge/core/ue_deh.c b/drivers/dsp/bridge/core/ue_deh.c
index 48c11e9..605cec7 100644
--- a/drivers/dsp/bridge/core/ue_deh.c
+++ b/drivers/dsp/bridge/core/ue_deh.c
@@ -60,11 +60,6 @@
 /* Max time to check for GP Timer IRQ */
 #define GPTIMER_IRQ_WAIT_MAX_CNT       1000
 
-static struct hw_mmu_map_attrs_t map_attrs = { HW_LITTLE_ENDIAN,
-	HW_ELEM_SIZE16BIT,
-	HW_MMU_CPUES
-};
-
 static void *dummy_va_addr;
 
 static struct omap_dm_timer *timer;
@@ -72,7 +67,7 @@ static struct omap_dm_timer *timer;
 dsp_status bridge_deh_create(struct deh_mgr **ret_deh_mgr,
 		struct dev_object *hdev_obj)
 {
-	dsp_status status = DSP_SOK;
+	dsp_status status;
 	struct deh_mgr *deh_mgr;
 	struct bridge_dev_context *hbridge_context = NULL;
 
@@ -81,23 +76,20 @@ dsp_status bridge_deh_create(struct deh_mgr **ret_deh_mgr,
 	 *  the base image. */
 	/* Get WMD context info. */
 	dev_get_bridge_context(hdev_obj, &hbridge_context);
-	DBC_ASSERT(hbridge_context);
-	dummy_va_addr = NULL;
 	/* Allocate IO manager object: */
 	deh_mgr = kzalloc(sizeof(struct deh_mgr), GFP_KERNEL);
 	if (!deh_mgr) {
 		status = -ENOMEM;
-		goto leave;
+		goto err;
 	}
 
 	/* Create an NTFY object to manage notifications */
 	deh_mgr->ntfy_obj = kmalloc(sizeof(struct ntfy_object), GFP_KERNEL);
-	if (deh_mgr->ntfy_obj) {
-		ntfy_init(deh_mgr->ntfy_obj);
-	} else {
+	if (!deh_mgr->ntfy_obj) {
 		status = -ENOMEM;
 		goto err;
 	}
+	ntfy_init(deh_mgr->ntfy_obj);
 
 	/* Create a MMUfault DPC */
 	tasklet_init(&deh_mgr->dpc_tasklet, mmu_fault_dpc, (u32) deh_mgr);
@@ -110,32 +102,25 @@ dsp_status bridge_deh_create(struct deh_mgr **ret_deh_mgr,
 	deh_mgr->err_info.dw_val3 = 0L;
 
 	/* Install ISR function for DSP MMU fault */
-	if ((request_irq(INT_DSP_MMU_IRQ, mmu_fault_isr, 0,
-					"DspBridge\tiommu fault",
-					(void *)deh_mgr)) == 0)
-		status = DSP_SOK;
-	else
-		status = -EPERM;
+	status = request_irq(INT_DSP_MMU_IRQ, mmu_fault_isr, 0,
+			"DspBridge\tiommu fault", deh_mgr);
+	if (status < 0)
+		goto err;
 
-err:
-	if (DSP_FAILED(status)) {
-		/* If create failed, cleanup */
-		bridge_deh_destroy(deh_mgr);
-		deh_mgr = NULL;
-	} else {
-		timer = omap_dm_timer_request_specific(
-					GPTIMER_FOR_DSP_MMU_FAULT);
-		if (timer) {
-			omap_dm_timer_disable(timer);
-		} else {
-			pr_err("%s: GPTimer not available\n", __func__);
-			return -ENODEV;
-		}
+	timer = omap_dm_timer_request_specific(GPTIMER_FOR_DSP_MMU_FAULT);
+	if (!timer) {
+		pr_err("%s: GPTimer not available\n", __func__);
+		status = -ENODEV;
+		goto err;
 	}
+	omap_dm_timer_disable(timer);
 
-leave:
 	*ret_deh_mgr = deh_mgr;
+	return 0;
 
+err:
+	bridge_deh_destroy(deh_mgr);
+	*ret_deh_mgr = NULL;
 	return status;
 }
 
@@ -164,36 +149,31 @@ dsp_status bridge_deh_destroy(struct deh_mgr *deh_mgr)
 	omap_dm_timer_free(timer);
 	timer = NULL;
 
-	return DSP_SOK;
+	return 0;
 }
 
 dsp_status bridge_deh_register_notify(struct deh_mgr *deh_mgr, u32 event_mask,
 		u32 notify_type,
 		struct dsp_notification *hnotification)
 {
-	dsp_status status = DSP_SOK;
-
 	if (!deh_mgr)
 		return -EFAULT;
 
 	if (event_mask)
-		status = ntfy_register(deh_mgr->ntfy_obj, hnotification,
-					event_mask, notify_type);
+		return ntfy_register(deh_mgr->ntfy_obj, hnotification,
+				event_mask, notify_type);
 	else
-		status = ntfy_unregister(deh_mgr->ntfy_obj, hnotification);
-
-	return status;
+		return ntfy_unregister(deh_mgr->ntfy_obj, hnotification);
 }
 
 static void wait_for_timer(void)
 {
-	u32 cnt = 0;
+	int c;
 
 	omap_dm_timer_enable(timer);
 
 	/* Enable overflow interrupt */
-	omap_dm_timer_set_int_enable(timer,
-			GPTIMER_IRQ_OVERFLOW);
+	omap_dm_timer_set_int_enable(timer, GPTIMER_IRQ_OVERFLOW);
 	/*
 	 * Set counter value to overflow counter after
 	 * one tick and start timer.
@@ -204,15 +184,11 @@ static void wait_for_timer(void)
 	udelay(80);
 
 	/* Check interrupt status and wait for interrupt */
-	cnt = 0;
-	while (!(omap_dm_timer_read_status(timer) &
-				GPTIMER_IRQ_OVERFLOW)) {
-		if (cnt++ >= GPTIMER_IRQ_WAIT_MAX_CNT) {
-			pr_err("%s: GPTimer interrupt failed\n",
-					__func__);
-			break;
-		}
-	}
+	for (c = 0; c < GPTIMER_IRQ_WAIT_MAX_CNT; c++)
+		if ((omap_dm_timer_read_status(timer) & GPTIMER_IRQ_OVERFLOW))
+			return;
+
+	pr_err("%s: GPTimer interrupt failed\n", __func__);
 
 	omap_dm_timer_disable(timer);
 }
@@ -220,16 +196,19 @@ static void wait_for_timer(void)
 void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 {
 	struct bridge_dev_context *dev_context;
-	dsp_status status = DSP_SOK;
 	u32 hw_mmu_max_tlb_count = 31;
 	struct cfg_hostres *resources;
-	hw_status hw_status_obj;
+	struct hw_mmu_map_attrs_t map_attrs = {
+		.endianism = HW_LITTLE_ENDIAN,
+		.element_size = HW_ELEM_SIZE16BIT,
+		.mixed_size = HW_MMU_CPUES,
+	};
 
 	if (!deh_mgr)
 		return;
 
 	dev_info(bridge, "%s: device exception\n", __func__);
-	dev_context = (struct bridge_dev_context *)deh_mgr->hbridge_context;
+	dev_context = deh_mgr->hbridge_context;
 	resources = dev_context->resources;
 
 	switch (ulEventMask) {
@@ -256,8 +235,6 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 			(unsigned int) deh_mgr->err_info.dw_val2,
 			(unsigned int) fault_addr);
 		dummy_va_addr = (void*)__get_free_page(GFP_ATOMIC);
-		dev_context = (struct bridge_dev_context *)
-			deh_mgr->hbridge_context;
 
 		print_dsp_trace_buffer(dev_context);
 		dump_dl_modules(dev_context);
@@ -272,20 +249,16 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 			dev_context->num_tlb_entries =
 				dev_context->fixed_tlb_entries;
 		}
-		if (DSP_SUCCEEDED(status)) {
-			hw_status_obj =
-				hw_mmu_tlb_add(resources->dw_dmmu_base,
-						virt_to_phys(dummy_va_addr), fault_addr,
-						HW_PAGE_SIZE4KB, 1,
-						&map_attrs, HW_SET, HW_SET);
-		}
+		hw_mmu_tlb_add(resources->dw_dmmu_base,
+				virt_to_phys(dummy_va_addr), fault_addr,
+				HW_PAGE_SIZE4KB, 1,
+				&map_attrs, HW_SET, HW_SET);
 
 		wait_for_timer();
-
 		/* Clear MMU interrupt */
 		hw_mmu_event_ack(resources->dw_dmmu_base,
 				HW_MMU_TRANSLATION_FAULT);
-		dump_dsp_stack(deh_mgr->hbridge_context);
+		dump_dsp_stack(dev_context);
 		break;
 #ifdef CONFIG_BRIDGE_NTFY_PWRERR
 	case DSP_PWRERROR:
@@ -334,9 +307,6 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 dsp_status bridge_deh_get_info(struct deh_mgr *deh_mgr,
 		struct dsp_errorinfo *pErrInfo)
 {
-	DBC_REQUIRE(deh_mgr);
-	DBC_REQUIRE(pErrInfo);
-
 	if (!deh_mgr)
 		return -EFAULT;
 
@@ -346,7 +316,7 @@ dsp_status bridge_deh_get_info(struct deh_mgr *deh_mgr,
 	pErrInfo->dw_val2 = deh_mgr->err_info.dw_val2;
 	pErrInfo->dw_val3 = deh_mgr->err_info.dw_val3;
 
-	return DSP_SOK;
+	return 0;
 }
 
 void bridge_deh_release_dummy_mem(void)
-- 
1.7.1

