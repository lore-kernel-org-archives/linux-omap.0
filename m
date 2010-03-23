From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 06/10] dsp-bridge: deh: decrease nesting levels
Date: Tue, 23 Mar 2010 23:25:38 +0200
Message-ID: <1269379542-11892-7-git-send-email-felipe.contreras@gmail.com>
References: <1269379542-11892-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:33760 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001Ab0CWV0a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Mar 2010 17:26:30 -0400
Received: by mail-bw0-f209.google.com with SMTP id 1so2292169bwz.21
        for <linux-omap@vger.kernel.org>; Tue, 23 Mar 2010 14:26:29 -0700 (PDT)
In-Reply-To: <1269379542-11892-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/dsp/bridge/wmd/ue_deh.c |  293 +++++++++++++++++++--------------------
 1 files changed, 145 insertions(+), 148 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 4708c10..0a03e09 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -85,37 +85,44 @@ dsp_status bridge_deh_create(struct deh_mgr **phDehMgr,
 	MEM_ALLOC_OBJECT(deh_mgr_obj, struct deh_mgr, SIGNATURE);
 	if (deh_mgr_obj == NULL) {
 		status = DSP_EMEMORY;
-	} else {
-		/* Create an NTFY object to manage notifications */
-		status = ntfy_create(&deh_mgr_obj->ntfy_obj);
+		goto leave;
+	}
 
-		/* Create a MMUfault DPC */
-		tasklet_init(&deh_mgr_obj->dpc_tasklet, mmu_fault_dpc,
-				(u32) deh_mgr_obj);
+	/* Create an NTFY object to manage notifications */
+	status = ntfy_create(&deh_mgr_obj->ntfy_obj);
 
-		if (DSP_SUCCEEDED(status))
-			status = dev_get_dev_node(hdev_obj, &dev_node_obj);
+	/* Create a MMUfault DPC */
+	tasklet_init(&deh_mgr_obj->dpc_tasklet, mmu_fault_dpc,
+			(u32) deh_mgr_obj);
 
-		if (DSP_SUCCEEDED(status))
-			status =
-				cfg_get_host_resources(dev_node_obj, &cfg_host_res);
+	if (DSP_FAILED(status))
+		goto leave;
 
-		if (DSP_SUCCEEDED(status)) {
-			/* Fill in context structure */
-			deh_mgr_obj->hwmd_context = hwmd_context;
-			deh_mgr_obj->err_info.dw_err_mask = 0L;
-			deh_mgr_obj->err_info.dw_val1 = 0L;
-			deh_mgr_obj->err_info.dw_val2 = 0L;
-			deh_mgr_obj->err_info.dw_val3 = 0L;
-			/* Install ISR function for DSP MMU fault */
-			if ((request_irq(INT_DSP_MMU_IRQ, mmu_fault_isr, 0,
-							"DspBridge\tiommu fault",
-							(void *)deh_mgr_obj)) == 0)
-				status = DSP_SOK;
-			else
-				status = DSP_EFAIL;
-		}
-	}
+	status = dev_get_dev_node(hdev_obj, &dev_node_obj);
+
+	if (DSP_FAILED(status))
+		goto leave;
+
+	status = cfg_get_host_resources(dev_node_obj, &cfg_host_res);
+
+	if (DSP_FAILED(status))
+		goto leave;
+
+	/* Fill in context structure */
+	deh_mgr_obj->hwmd_context = hwmd_context;
+	deh_mgr_obj->err_info.dw_err_mask = 0L;
+	deh_mgr_obj->err_info.dw_val1 = 0L;
+	deh_mgr_obj->err_info.dw_val2 = 0L;
+	deh_mgr_obj->err_info.dw_val3 = 0L;
+	/* Install ISR function for DSP MMU fault */
+	if ((request_irq(INT_DSP_MMU_IRQ, mmu_fault_isr, 0,
+					"DspBridge\tiommu fault",
+					(void *)deh_mgr_obj)) == 0)
+		status = DSP_SOK;
+	else
+		status = DSP_EFAIL;
+
+leave:
 	if (DSP_FAILED(status)) {
 		/* If create failed, cleanup */
 		bridge_deh_destroy((struct deh_mgr *)deh_mgr_obj);
@@ -129,41 +136,39 @@ dsp_status bridge_deh_create(struct deh_mgr **phDehMgr,
 
 dsp_status bridge_deh_destroy(struct deh_mgr *hdeh_mgr)
 {
-	dsp_status status = DSP_SOK;
 	struct deh_mgr *deh_mgr_obj = (struct deh_mgr *)hdeh_mgr;
 
-	if (MEM_IS_VALID_HANDLE(deh_mgr_obj, SIGNATURE)) {
-		/* Release dummy VA buffer */
-		bridge_deh_release_dummy_mem();
-		/* If notification object exists, delete it */
-		if (deh_mgr_obj->ntfy_obj)
-			ntfy_delete(deh_mgr_obj->ntfy_obj);
-		/* Disable DSP MMU fault */
-		free_irq(INT_DSP_MMU_IRQ, deh_mgr_obj);
+	if (!MEM_IS_VALID_HANDLE(deh_mgr_obj, SIGNATURE))
+		return DSP_SOK;
 
-		/* Free DPC object */
-		tasklet_kill(&deh_mgr_obj->dpc_tasklet);
+	/* Release dummy VA buffer */
+	bridge_deh_release_dummy_mem();
+	/* If notification object exists, delete it */
+	if (deh_mgr_obj->ntfy_obj)
+		ntfy_delete(deh_mgr_obj->ntfy_obj);
+	/* Disable DSP MMU fault */
+	free_irq(INT_DSP_MMU_IRQ, deh_mgr_obj);
 
-		/* Deallocate the DEH manager object */
-		MEM_FREE_OBJECT(deh_mgr_obj);
-	}
+	/* Free DPC object */
+	tasklet_kill(&deh_mgr_obj->dpc_tasklet);
 
-	return status;
+	/* Deallocate the DEH manager object */
+	MEM_FREE_OBJECT(deh_mgr_obj);
+
+	return DSP_SOK;
 }
 
 dsp_status bridge_deh_register_notify(struct deh_mgr *hdeh_mgr, u32 event_mask,
 		u32 notify_type,
 		struct dsp_notification *hnotification)
 {
-	dsp_status status = DSP_SOK;
 	struct deh_mgr *deh_mgr_obj = (struct deh_mgr *)hdeh_mgr;
 
-	if (MEM_IS_VALID_HANDLE(deh_mgr_obj, SIGNATURE)) {
-		status = ntfy_register(deh_mgr_obj->ntfy_obj, hnotification,
-				event_mask, notify_type);
-	}
+	if (!MEM_IS_VALID_HANDLE(deh_mgr_obj, SIGNATURE))
+		return DSP_SOK;
 
-	return status;
+	return ntfy_register(deh_mgr_obj->ntfy_obj, hnotification,
+			event_mask, notify_type);
 }
 
 void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
@@ -181,121 +186,113 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
 			drv_get_first_dev_extension(),
 			&resources);
 
-	if (MEM_IS_VALID_HANDLE(deh_mgr_obj, SIGNATURE)) {
-		dev_info(bridge, "%s: device exception\n", __func__);
-		dev_context =
-			(struct wmd_dev_context *)deh_mgr_obj->hwmd_context;
-
-		switch (ulEventMask) {
-		case DSP_SYSERROR:
-			/* reset err_info structure before use */
-			deh_mgr_obj->err_info.dw_err_mask = DSP_SYSERROR;
-			deh_mgr_obj->err_info.dw_val1 = 0L;
-			deh_mgr_obj->err_info.dw_val2 = 0L;
-			deh_mgr_obj->err_info.dw_val3 = 0L;
-			deh_mgr_obj->err_info.dw_val1 = dwErrInfo;
-			dev_err(bridge, "%s: %s, err_info = 0x%x\n",
-					__func__, "DSP_SYSERROR", dwErrInfo);
-			break;
-		case DSP_MMUFAULT:
-			/*
-			 * MMU fault routine should have set err info
-			 * structure.
-			 */
-			deh_mgr_obj->err_info.dw_err_mask = DSP_MMUFAULT;
-			dev_err(bridge, "%s: %s, err_info = 0x%x\n",
-					__func__, "DSP_MMUFAULT", dwErrInfo);
-			dev_info(bridge, "%s: %s, high=0x%x, low=0x%x, fault=0x%x\n",
-					__func__, "DSP_MMUFAULT",
-					(unsigned int) deh_mgr->err_info.dw_val1,
-					(unsigned int) deh_mgr->err_info.dw_val2,
-					(unsigned int) fault_addr);
-			dummy_va_addr =
-				(u32) mem_calloc(sizeof(char) * 0x1000, MEM_PAGED);
-			mem_physical =
-				VIRT_TO_PHYS(PG_ALIGN_LOW
-						((u32) dummy_va_addr, PG_SIZE4K));
-			dev_context = (struct wmd_dev_context *)
-				deh_mgr_obj->hwmd_context;
-			/*
-			 * Reset the dynamic mmu index to fixed count if it
-			 * exceeds 31. So that the dynmmuindex is always
-			 * between the range of standard/fixed entries and 31.
-			 */
-			if (dev_context->num_tlb_entries >
-					hw_mmu_max_tlb_count) {
-				dev_context->num_tlb_entries =
-					dev_context->fixed_tlb_entries;
-			}
-			if (DSP_SUCCEEDED(status)) {
-				hw_status_obj =
-					hw_mmu_tlb_add(resources.dw_dmmu_base,
-							mem_physical, fault_addr,
-							HW_PAGE_SIZE4KB, 1,
-							&map_attrs, HW_SET, HW_SET);
-			}
-			/* send an interrupt to DSP */
-			hw_mbox_msg_write(resources.dw_mbox_base, MBOX_ARM2DSP,
-					MBX_DEH_CLASS | MBX_DEH_EMMU);
-			/* Clear MMU interrupt */
-			hw_mmu_event_ack(resources.dw_dmmu_base,
-					HW_MMU_TRANSLATION_FAULT);
-			break;
+	if (!MEM_IS_VALID_HANDLE(deh_mgr_obj, SIGNATURE))
+		return;
+
+	dev_info(bridge, "%s: device exception\n", __func__);
+	dev_context =
+		(struct wmd_dev_context *)deh_mgr_obj->hwmd_context;
+
+	switch (ulEventMask) {
+	case DSP_SYSERROR:
+		/* reset err_info structure before use */
+		deh_mgr_obj->err_info.dw_err_mask = DSP_SYSERROR;
+		deh_mgr_obj->err_info.dw_val1 = 0L;
+		deh_mgr_obj->err_info.dw_val2 = 0L;
+		deh_mgr_obj->err_info.dw_val3 = 0L;
+		deh_mgr_obj->err_info.dw_val1 = dwErrInfo;
+		dev_err(bridge, "%s: %s, err_info = 0x%x\n",
+				__func__, "DSP_SYSERROR", dwErrInfo);
+		break;
+	case DSP_MMUFAULT:
+		/* MMU fault routine should have set err info structure. */
+		deh_mgr_obj->err_info.dw_err_mask = DSP_MMUFAULT;
+		dev_err(bridge, "%s: %s, err_info = 0x%x\n",
+				__func__, "DSP_MMUFAULT", dwErrInfo);
+		dev_info(bridge, "%s: %s, high=0x%x, low=0x%x, fault=0x%x\n",
+				__func__, "DSP_MMUFAULT",
+				(unsigned int) deh_mgr->err_info.dw_val1,
+				(unsigned int) deh_mgr->err_info.dw_val2,
+				(unsigned int) fault_addr);
+		dummy_va_addr =
+			(u32) mem_calloc(sizeof(char) * 0x1000, MEM_PAGED);
+		mem_physical =
+			VIRT_TO_PHYS(PG_ALIGN_LOW
+					((u32) dummy_va_addr, PG_SIZE4K));
+		dev_context = (struct wmd_dev_context *)
+			deh_mgr_obj->hwmd_context;
+		/*
+		 * Reset the dynamic mmu index to fixed count if it exceeds
+		 * 31. So that the dynmmuindex is always between the range of
+		 * standard/fixed entries and 31.
+		 */
+		if (dev_context->num_tlb_entries >
+				hw_mmu_max_tlb_count) {
+			dev_context->num_tlb_entries =
+				dev_context->fixed_tlb_entries;
+		}
+		if (DSP_SUCCEEDED(status)) {
+			hw_status_obj =
+				hw_mmu_tlb_add(resources.dw_dmmu_base,
+						mem_physical, fault_addr,
+						HW_PAGE_SIZE4KB, 1,
+						&map_attrs, HW_SET, HW_SET);
+		}
+		/* send an interrupt to DSP */
+		hw_mbox_msg_write(resources.dw_mbox_base, MBOX_ARM2DSP,
+				MBX_DEH_CLASS | MBX_DEH_EMMU);
+		/* Clear MMU interrupt */
+		hw_mmu_event_ack(resources.dw_dmmu_base,
+				HW_MMU_TRANSLATION_FAULT);
+		break;
 #ifdef CONFIG_BRIDGE_NTFY_PWRERR
-		case DSP_PWRERROR:
-			/* reset err_info structure before use */
-			deh_mgr_obj->err_info.dw_err_mask = DSP_PWRERROR;
-			deh_mgr_obj->err_info.dw_val1 = 0L;
-			deh_mgr_obj->err_info.dw_val2 = 0L;
-			deh_mgr_obj->err_info.dw_val3 = 0L;
-			deh_mgr_obj->err_info.dw_val1 = dwErrInfo;
-			dev_err(bridge, "%s: %s, err_info = 0x%x\n",
-					__func__, "DSP_PWRERROR", dwErrInfo);
-			break;
+	case DSP_PWRERROR:
+		/* reset err_info structure before use */
+		deh_mgr_obj->err_info.dw_err_mask = DSP_PWRERROR;
+		deh_mgr_obj->err_info.dw_val1 = 0L;
+		deh_mgr_obj->err_info.dw_val2 = 0L;
+		deh_mgr_obj->err_info.dw_val3 = 0L;
+		deh_mgr_obj->err_info.dw_val1 = dwErrInfo;
+		dev_err(bridge, "%s: %s, err_info = 0x%x\n",
+				__func__, "DSP_PWRERROR", dwErrInfo);
+		break;
 #endif /* CONFIG_BRIDGE_NTFY_PWRERR */
-		default:
-			dev_dbg(bridge, "%s: Unknown Error, err_info = 0x%x\n",
-					__func__, dwErrInfo);
-			break;
-		}
-
-		/* Filter subsequent notifications when an error occurs */
-		if (dev_context->dw_brd_state != BRD_ERROR)
-			ntfy_notify(deh_mgr_obj->ntfy_obj, ulEventMask);
+	default:
+		dev_dbg(bridge, "%s: Unknown Error, err_info = 0x%x\n",
+				__func__, dwErrInfo);
+		break;
+	}
 
-		/* Set the Board state as ERROR */
-		dev_context->dw_brd_state = BRD_ERROR;
-		/* Disable all the clocks that were enabled by DSP */
-		dsp_peripheral_clocks_disable(dev_context, NULL);
-		/* Call DSP Trace Buffer */
-		print_dsp_trace_buffer(hdeh_mgr->hwmd_context);
+	/* Filter subsequent notifications when an error occurs */
+	if (dev_context->dw_brd_state != BRD_ERROR)
+		ntfy_notify(deh_mgr_obj->ntfy_obj, ulEventMask);
 
-	}
+	/* Set the Board state as ERROR */
+	dev_context->dw_brd_state = BRD_ERROR;
+	/* Disable all the clocks that were enabled by DSP */
+	dsp_peripheral_clocks_disable(dev_context, NULL);
+	/* Call DSP Trace Buffer */
+	print_dsp_trace_buffer(hdeh_mgr->hwmd_context);
 }
 
 dsp_status bridge_deh_get_info(struct deh_mgr *hdeh_mgr,
 		struct dsp_errorinfo *pErrInfo)
 {
-	dsp_status status = DSP_SOK;
 	struct deh_mgr *deh_mgr_obj = (struct deh_mgr *)hdeh_mgr;
 
 	DBC_REQUIRE(deh_mgr_obj);
 	DBC_REQUIRE(pErrInfo);
 
-	if (MEM_IS_VALID_HANDLE(deh_mgr_obj, SIGNATURE)) {
-		/*
-		 * Copy DEH error info structure to PROC error info
-		 * structure.
-		 */
-		pErrInfo->dw_err_mask = deh_mgr_obj->err_info.dw_err_mask;
-		pErrInfo->dw_val1 = deh_mgr_obj->err_info.dw_val1;
-		pErrInfo->dw_val2 = deh_mgr_obj->err_info.dw_val2;
-		pErrInfo->dw_val3 = deh_mgr_obj->err_info.dw_val3;
-	} else {
-		status = DSP_EHANDLE;
-	}
+	if (!MEM_IS_VALID_HANDLE(deh_mgr_obj, SIGNATURE))
+		return DSP_EHANDLE;
 
-	return status;
+	/* Copy DEH error info structure to PROC error info structure. */
+	pErrInfo->dw_err_mask = deh_mgr_obj->err_info.dw_err_mask;
+	pErrInfo->dw_val1 = deh_mgr_obj->err_info.dw_val1;
+	pErrInfo->dw_val2 = deh_mgr_obj->err_info.dw_val2;
+	pErrInfo->dw_val3 = deh_mgr_obj->err_info.dw_val3;
+
+	return DSP_SOK;
 }
 
 void bridge_deh_release_dummy_mem(void)
-- 
1.7.0.3

