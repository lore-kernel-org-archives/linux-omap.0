From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 09/10] dsp-bridge: deh: fix hdeh_mgr silliness
Date: Tue, 23 Mar 2010 23:25:41 +0200
Message-ID: <1269379542-11892-10-git-send-email-felipe.contreras@gmail.com>
References: <1269379542-11892-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:33760 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524Ab0CWV0e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Mar 2010 17:26:34 -0400
Received: by mail-bw0-f209.google.com with SMTP id 1so2292169bwz.21
        for <linux-omap@vger.kernel.org>; Tue, 23 Mar 2010 14:26:34 -0700 (PDT)
In-Reply-To: <1269379542-11892-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/plat-omap/include/dspbridge/wmddeh.h |    8 +-
 drivers/dsp/bridge/wmd/ue_deh.c               |  104 +++++++++++-------------
 2 files changed, 52 insertions(+), 60 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/wmddeh.h b/arch/arm/plat-omap/include/dspbridge/wmddeh.h
index d7b7ee9..67beb08 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmddeh.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmddeh.h
@@ -30,17 +30,17 @@
 extern dsp_status bridge_deh_create(struct deh_mgr **ret_deh_mgr,
 		struct dev_object *hdev_obj);
 
-extern dsp_status bridge_deh_destroy(struct deh_mgr *hdeh_mgr);
+extern dsp_status bridge_deh_destroy(struct deh_mgr *deh_mgr);
 
-extern dsp_status bridge_deh_get_info(struct deh_mgr *hdeh_mgr,
+extern dsp_status bridge_deh_get_info(struct deh_mgr *deh_mgr,
 		struct dsp_errorinfo *pErrInfo);
 
-extern dsp_status bridge_deh_register_notify(struct deh_mgr *hdeh_mgr,
+extern dsp_status bridge_deh_register_notify(struct deh_mgr *deh_mgr,
 		u32 event_mask,
 		u32 notify_type,
 		struct dsp_notification *hnotification);
 
-extern void bridge_deh_notify(struct deh_mgr *hdeh_mgr,
+extern void bridge_deh_notify(struct deh_mgr *deh_mgr,
 		u32 ulEventMask, u32 dwErrInfo);
 
 extern void bridge_deh_release_dummy_mem(void);
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 104ab33..b1c3189 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -66,7 +66,7 @@ dsp_status bridge_deh_create(struct deh_mgr **ret_deh_mgr,
 		struct dev_object *hdev_obj)
 {
 	dsp_status status = DSP_SOK;
-	struct deh_mgr *deh_mgr_obj;
+	struct deh_mgr *deh_mgr;
 	struct cfg_hostres cfg_host_res;
 	struct cfg_devnode *dev_node_obj;
 	struct wmd_dev_context *hwmd_context = NULL;
@@ -82,18 +82,17 @@ dsp_status bridge_deh_create(struct deh_mgr **ret_deh_mgr,
 	DBC_ASSERT(hwmd_context);
 	dummy_va_addr = 0;
 	/* Allocate IO manager object: */
-	MEM_ALLOC_OBJECT(deh_mgr_obj, struct deh_mgr, SIGNATURE);
-	if (!deh_mgr_obj) {
+	MEM_ALLOC_OBJECT(deh_mgr, struct deh_mgr, SIGNATURE);
+	if (!deh_mgr) {
 		status = DSP_EMEMORY;
 		goto leave;
 	}
 
 	/* Create an NTFY object to manage notifications */
-	status = ntfy_create(&deh_mgr_obj->ntfy_obj);
+	status = ntfy_create(&deh_mgr->ntfy_obj);
 
 	/* Create a MMUfault DPC */
-	tasklet_init(&deh_mgr_obj->dpc_tasklet, mmu_fault_dpc,
-			(u32) deh_mgr_obj);
+	tasklet_init(&deh_mgr->dpc_tasklet, mmu_fault_dpc, (u32) deh_mgr);
 
 	if (DSP_FAILED(status))
 		goto err;
@@ -109,16 +108,16 @@ dsp_status bridge_deh_create(struct deh_mgr **ret_deh_mgr,
 		goto err;
 
 	/* Fill in context structure */
-	deh_mgr_obj->hwmd_context = hwmd_context;
-	deh_mgr_obj->err_info.dw_err_mask = 0L;
-	deh_mgr_obj->err_info.dw_val1 = 0L;
-	deh_mgr_obj->err_info.dw_val2 = 0L;
-	deh_mgr_obj->err_info.dw_val3 = 0L;
+	deh_mgr->hwmd_context = hwmd_context;
+	deh_mgr->err_info.dw_err_mask = 0L;
+	deh_mgr->err_info.dw_val1 = 0L;
+	deh_mgr->err_info.dw_val2 = 0L;
+	deh_mgr->err_info.dw_val3 = 0L;
 
 	/* Install ISR function for DSP MMU fault */
 	if ((request_irq(INT_DSP_MMU_IRQ, mmu_fault_isr, 0,
 					"DspBridge\tiommu fault",
-					(void *)deh_mgr_obj)) == 0)
+					(void *)deh_mgr)) == 0)
 		status = DSP_SOK;
 	else
 		status = DSP_EFAIL;
@@ -126,56 +125,51 @@ dsp_status bridge_deh_create(struct deh_mgr **ret_deh_mgr,
 err:
 	if (DSP_FAILED(status)) {
 		/* If create failed, cleanup */
-		bridge_deh_destroy((struct deh_mgr *)deh_mgr_obj);
-		deh_mgr_obj = NULL;
+		bridge_deh_destroy(deh_mgr);
+		deh_mgr = NULL;
 	}
 
 leave:
-	*ret_deh_mgr = deh_mgr_obj;
+	*ret_deh_mgr = deh_mgr;
 
 	return status;
 }
 
-dsp_status bridge_deh_destroy(struct deh_mgr *hdeh_mgr)
+dsp_status bridge_deh_destroy(struct deh_mgr *deh_mgr)
 {
-	struct deh_mgr *deh_mgr_obj = (struct deh_mgr *)hdeh_mgr;
-
-	if (!MEM_IS_VALID_HANDLE(deh_mgr_obj, SIGNATURE))
+	if (!MEM_IS_VALID_HANDLE(deh_mgr, SIGNATURE))
 		return DSP_EHANDLE;
 
 	/* Release dummy VA buffer */
 	bridge_deh_release_dummy_mem();
 	/* If notification object exists, delete it */
-	if (deh_mgr_obj->ntfy_obj)
-		ntfy_delete(deh_mgr_obj->ntfy_obj);
+	if (deh_mgr->ntfy_obj)
+		ntfy_delete(deh_mgr->ntfy_obj);
 	/* Disable DSP MMU fault */
-	free_irq(INT_DSP_MMU_IRQ, deh_mgr_obj);
+	free_irq(INT_DSP_MMU_IRQ, deh_mgr);
 
 	/* Free DPC object */
-	tasklet_kill(&deh_mgr_obj->dpc_tasklet);
+	tasklet_kill(&deh_mgr->dpc_tasklet);
 
 	/* Deallocate the DEH manager object */
-	MEM_FREE_OBJECT(deh_mgr_obj);
+	MEM_FREE_OBJECT(deh_mgr);
 
 	return DSP_SOK;
 }
 
-dsp_status bridge_deh_register_notify(struct deh_mgr *hdeh_mgr, u32 event_mask,
+dsp_status bridge_deh_register_notify(struct deh_mgr *deh_mgr, u32 event_mask,
 		u32 notify_type,
 		struct dsp_notification *hnotification)
 {
-	struct deh_mgr *deh_mgr_obj = (struct deh_mgr *)hdeh_mgr;
-
-	if (!MEM_IS_VALID_HANDLE(deh_mgr_obj, SIGNATURE))
+	if (!MEM_IS_VALID_HANDLE(deh_mgr, SIGNATURE))
 		return DSP_EHANDLE;
 
-	return ntfy_register(deh_mgr_obj->ntfy_obj, hnotification,
+	return ntfy_register(deh_mgr->ntfy_obj, hnotification,
 			event_mask, notify_type);
 }
 
-void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
+void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 {
-	struct deh_mgr *deh_mgr_obj = (struct deh_mgr *)hdeh_mgr;
 	struct wmd_dev_context *dev_context;
 	dsp_status status = DSP_SOK;
 	u32 mem_physical = 0;
@@ -188,27 +182,27 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
 			drv_get_first_dev_extension(),
 			&resources);
 
-	if (!MEM_IS_VALID_HANDLE(deh_mgr_obj, SIGNATURE))
+	if (!MEM_IS_VALID_HANDLE(deh_mgr, SIGNATURE))
 		return;
 
 	dev_info(bridge, "%s: device exception\n", __func__);
 	dev_context =
-		(struct wmd_dev_context *)deh_mgr_obj->hwmd_context;
+		(struct wmd_dev_context *)deh_mgr->hwmd_context;
 
 	switch (ulEventMask) {
 	case DSP_SYSERROR:
 		/* reset err_info structure before use */
-		deh_mgr_obj->err_info.dw_err_mask = DSP_SYSERROR;
-		deh_mgr_obj->err_info.dw_val1 = 0L;
-		deh_mgr_obj->err_info.dw_val2 = 0L;
-		deh_mgr_obj->err_info.dw_val3 = 0L;
-		deh_mgr_obj->err_info.dw_val1 = dwErrInfo;
+		deh_mgr->err_info.dw_err_mask = DSP_SYSERROR;
+		deh_mgr->err_info.dw_val1 = 0L;
+		deh_mgr->err_info.dw_val2 = 0L;
+		deh_mgr->err_info.dw_val3 = 0L;
+		deh_mgr->err_info.dw_val1 = dwErrInfo;
 		dev_err(bridge, "%s: %s, err_info = 0x%x\n",
 				__func__, "DSP_SYSERROR", dwErrInfo);
 		break;
 	case DSP_MMUFAULT:
 		/* MMU fault routine should have set err info structure. */
-		deh_mgr_obj->err_info.dw_err_mask = DSP_MMUFAULT;
+		deh_mgr->err_info.dw_err_mask = DSP_MMUFAULT;
 		dev_err(bridge, "%s: %s, err_info = 0x%x\n",
 				__func__, "DSP_MMUFAULT", dwErrInfo);
 		dev_info(bridge, "%s: %s, high=0x%x, low=0x%x, fault=0x%x\n",
@@ -222,7 +216,7 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
 			VIRT_TO_PHYS(PG_ALIGN_LOW
 					((u32) dummy_va_addr, PG_SIZE4K));
 		dev_context = (struct wmd_dev_context *)
-			deh_mgr_obj->hwmd_context;
+			deh_mgr->hwmd_context;
 		/*
 		 * Reset the dynamic mmu index to fixed count if it exceeds
 		 * 31. So that the dynmmuindex is always between the range of
@@ -250,11 +244,11 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
 #ifdef CONFIG_BRIDGE_NTFY_PWRERR
 	case DSP_PWRERROR:
 		/* reset err_info structure before use */
-		deh_mgr_obj->err_info.dw_err_mask = DSP_PWRERROR;
-		deh_mgr_obj->err_info.dw_val1 = 0L;
-		deh_mgr_obj->err_info.dw_val2 = 0L;
-		deh_mgr_obj->err_info.dw_val3 = 0L;
-		deh_mgr_obj->err_info.dw_val1 = dwErrInfo;
+		deh_mgr->err_info.dw_err_mask = DSP_PWRERROR;
+		deh_mgr->err_info.dw_val1 = 0L;
+		deh_mgr->err_info.dw_val2 = 0L;
+		deh_mgr->err_info.dw_val3 = 0L;
+		deh_mgr->err_info.dw_val1 = dwErrInfo;
 		dev_err(bridge, "%s: %s, err_info = 0x%x\n",
 				__func__, "DSP_PWRERROR", dwErrInfo);
 		break;
@@ -267,32 +261,30 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
 
 	/* Filter subsequent notifications when an error occurs */
 	if (dev_context->dw_brd_state != BRD_ERROR)
-		ntfy_notify(deh_mgr_obj->ntfy_obj, ulEventMask);
+		ntfy_notify(deh_mgr->ntfy_obj, ulEventMask);
 
 	/* Set the Board state as ERROR */
 	dev_context->dw_brd_state = BRD_ERROR;
 	/* Disable all the clocks that were enabled by DSP */
 	dsp_peripheral_clocks_disable(dev_context, NULL);
 	/* Call DSP Trace Buffer */
-	print_dsp_trace_buffer(hdeh_mgr->hwmd_context);
+	print_dsp_trace_buffer(deh_mgr->hwmd_context);
 }
 
-dsp_status bridge_deh_get_info(struct deh_mgr *hdeh_mgr,
+dsp_status bridge_deh_get_info(struct deh_mgr *deh_mgr,
 		struct dsp_errorinfo *pErrInfo)
 {
-	struct deh_mgr *deh_mgr_obj = (struct deh_mgr *)hdeh_mgr;
-
-	DBC_REQUIRE(deh_mgr_obj);
+	DBC_REQUIRE(deh_mgr);
 	DBC_REQUIRE(pErrInfo);
 
-	if (!MEM_IS_VALID_HANDLE(deh_mgr_obj, SIGNATURE))
+	if (!MEM_IS_VALID_HANDLE(deh_mgr, SIGNATURE))
 		return DSP_EHANDLE;
 
 	/* Copy DEH error info structure to PROC error info structure. */
-	pErrInfo->dw_err_mask = deh_mgr_obj->err_info.dw_err_mask;
-	pErrInfo->dw_val1 = deh_mgr_obj->err_info.dw_val1;
-	pErrInfo->dw_val2 = deh_mgr_obj->err_info.dw_val2;
-	pErrInfo->dw_val3 = deh_mgr_obj->err_info.dw_val3;
+	pErrInfo->dw_err_mask = deh_mgr->err_info.dw_err_mask;
+	pErrInfo->dw_val1 = deh_mgr->err_info.dw_val1;
+	pErrInfo->dw_val2 = deh_mgr->err_info.dw_val2;
+	pErrInfo->dw_val3 = deh_mgr->err_info.dw_val3;
 
 	return DSP_SOK;
 }
-- 
1.7.0.3

