From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 02/10] dsp-bridge: deh: trivial cleanups
Date: Tue, 23 Mar 2010 23:25:34 +0200
Message-ID: <1269379542-11892-3-git-send-email-felipe.contreras@gmail.com>
References: <1269379542-11892-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:35757 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252Ab0CWV0H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Mar 2010 17:26:07 -0400
Received: by bwz1 with SMTP id 1so2292212bwz.21
        for <linux-omap@vger.kernel.org>; Tue, 23 Mar 2010 14:26:05 -0700 (PDT)
In-Reply-To: <1269379542-11892-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Mostly white-space formatting.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/plat-omap/include/dspbridge/wmddeh.h |   16 ++--
 drivers/dsp/bridge/wmd/ue_deh.c               |  111 +++++++++++++-----------
 2 files changed, 68 insertions(+), 59 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/wmddeh.h b/arch/arm/plat-omap/include/dspbridge/wmddeh.h
index 0152c43..e193029 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmddeh.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmddeh.h
@@ -27,22 +27,22 @@
 
 #include <dspbridge/dehdefs.h>
 
-extern dsp_status bridge_deh_create(OUT struct deh_mgr **phDehMgr,
-				    struct dev_object *hdev_obj);
+extern dsp_status bridge_deh_create(struct deh_mgr **phDehMgr,
+		struct dev_object *hdev_obj);
 
 extern dsp_status bridge_deh_destroy(struct deh_mgr *hdeh_mgr);
 
 extern dsp_status bridge_deh_get_info(struct deh_mgr *hdeh_mgr,
-				   struct dsp_errorinfo *pErrInfo);
+		struct dsp_errorinfo *pErrInfo);
 
 extern dsp_status bridge_deh_register_notify(struct deh_mgr *hdeh_mgr,
-					  u32 event_mask,
-					  u32 notify_type,
-					  struct dsp_notification
-					  *hnotification);
+		u32 event_mask,
+		u32 notify_type,
+		struct dsp_notification *hnotification);
 
 extern void bridge_deh_notify(struct deh_mgr *hdeh_mgr,
-			      u32 ulEventMask, u32 dwErrInfo);
+		u32 ulEventMask, u32 dwErrInfo);
 
 extern void bridge_deh_release_dummy_mem(void);
+
 #endif /* WMDDEH_ */
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 8d44180..284f378 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -52,7 +52,8 @@
 #include "_tiomap_pwr.h"
 #include <dspbridge/io_sm.h>
 
-static struct hw_mmu_map_attrs_t map_attrs = { HW_LITTLE_ENDIAN,
+static struct hw_mmu_map_attrs_t map_attrs = {
+	HW_LITTLE_ENDIAN,
 	HW_ELEM_SIZE16BIT,
 	HW_MMU_CPUES
 };
@@ -61,8 +62,8 @@ static struct hw_mmu_map_attrs_t map_attrs = { HW_LITTLE_ENDIAN,
 
 static u32 dummy_va_addr;
 
-dsp_status bridge_deh_create(OUT struct deh_mgr **phDehMgr,
-			     struct dev_object *hdev_obj)
+dsp_status bridge_deh_create(struct deh_mgr **phDehMgr,
+		struct dev_object *hdev_obj)
 {
 	dsp_status status = DSP_SOK;
 	struct deh_mgr *deh_mgr_obj = NULL;
@@ -70,9 +71,12 @@ dsp_status bridge_deh_create(OUT struct deh_mgr **phDehMgr,
 	struct cfg_devnode *dev_node_obj;
 	struct wmd_dev_context *hwmd_context = NULL;
 
-	/*  Message manager will be created when a file is loaded, since
-	 *  size of message buffer in shared memory is configurable in
-	 *  the base image. */
+	/*
+	 * Message manager will be created when a file is loaded, since size
+	 * of message buffer in shared memory is configurable in the base
+	 * image.
+	 */
+
 	/* Get WMD context info. */
 	dev_get_wmd_context(hdev_obj, &hwmd_context);
 	DBC_ASSERT(hwmd_context);
@@ -87,14 +91,14 @@ dsp_status bridge_deh_create(OUT struct deh_mgr **phDehMgr,
 
 		/* Create a MMUfault DPC */
 		tasklet_init(&deh_mgr_obj->dpc_tasklet, mmu_fault_dpc,
-			     (u32) deh_mgr_obj);
+				(u32) deh_mgr_obj);
 
 		if (DSP_SUCCEEDED(status))
 			status = dev_get_dev_node(hdev_obj, &dev_node_obj);
 
 		if (DSP_SUCCEEDED(status))
 			status =
-			    cfg_get_host_resources(dev_node_obj, &cfg_host_res);
+				cfg_get_host_resources(dev_node_obj, &cfg_host_res);
 
 		if (DSP_SUCCEEDED(status)) {
 			/* Fill in context structure */
@@ -105,8 +109,8 @@ dsp_status bridge_deh_create(OUT struct deh_mgr **phDehMgr,
 			deh_mgr_obj->err_info.dw_val3 = 0L;
 			/* Install ISR function for DSP MMU fault */
 			if ((request_irq(INT_DSP_MMU_IRQ, mmu_fault_isr, 0,
-					 "DspBridge\tiommu fault",
-					 (void *)deh_mgr_obj)) == 0)
+							"DspBridge\tiommu fault",
+							(void *)deh_mgr_obj)) == 0)
 				status = DSP_SOK;
 			else
 				status = DSP_EFAIL;
@@ -148,15 +152,15 @@ dsp_status bridge_deh_destroy(struct deh_mgr *hdeh_mgr)
 }
 
 dsp_status bridge_deh_register_notify(struct deh_mgr *hdeh_mgr, u32 event_mask,
-				   u32 notify_type,
-				   struct dsp_notification *hnotification)
+		u32 notify_type,
+		struct dsp_notification *hnotification)
 {
 	dsp_status status = DSP_SOK;
 	struct deh_mgr *deh_mgr_obj = (struct deh_mgr *)hdeh_mgr;
 
 	if (MEM_IS_VALID_HANDLE(deh_mgr_obj, SIGNATURE)) {
 		status = ntfy_register(deh_mgr_obj->ntfy_obj, hnotification,
-				       event_mask, notify_type);
+				event_mask, notify_type);
 	}
 
 	return status;
@@ -174,15 +178,15 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
 	hw_status hw_status_obj;
 
 	status = cfg_get_host_resources((struct cfg_devnode *)
-					drv_get_first_dev_extension(),
-					&resources);
+			drv_get_first_dev_extension(),
+			&resources);
 
 	if (MEM_IS_VALID_HANDLE(deh_mgr_obj, SIGNATURE)) {
 		printk(KERN_INFO
-		       "bridge_deh_notify: ********** DEVICE EXCEPTION "
-		       "**********\n");
+				"bridge_deh_notify: ********** DEVICE EXCEPTION "
+				"**********\n");
 		dev_context =
-		    (struct wmd_dev_context *)deh_mgr_obj->hwmd_context;
+			(struct wmd_dev_context *)deh_mgr_obj->hwmd_context;
 
 		switch (ulEventMask) {
 		case DSP_SYSERROR:
@@ -193,54 +197,57 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
 			deh_mgr_obj->err_info.dw_val3 = 0L;
 			deh_mgr_obj->err_info.dw_val1 = dwErrInfo;
 			printk(KERN_ERR
-			       "bridge_deh_notify: DSP_SYSERROR, err_info "
-			       "= 0x%x\n", dwErrInfo);
+					"bridge_deh_notify: DSP_SYSERROR, err_info "
+					"= 0x%x\n", dwErrInfo);
 			break;
 		case DSP_MMUFAULT:
-			/* MMU fault routine should have set err info
-			 * structure */
+			/*
+			 * MMU fault routine should have set err info
+			 * structure.
+			 */
 			deh_mgr_obj->err_info.dw_err_mask = DSP_MMUFAULT;
 			printk(KERN_INFO "bridge_deh_notify: DSP_MMUFAULT,"
-			       "err_info = 0x%x\n", dwErrInfo);
+					"err_info = 0x%x\n", dwErrInfo);
 			printk(KERN_INFO
-			       "bridge_deh_notify: DSP_MMUFAULT, High "
-			       "Address = 0x%x\n",
-			       (unsigned int)deh_mgr_obj->err_info.dw_val1);
+					"bridge_deh_notify: DSP_MMUFAULT, High "
+					"Address = 0x%x\n",
+					(unsigned int)deh_mgr_obj->err_info.dw_val1);
 			printk(KERN_INFO "bridge_deh_notify: DSP_MMUFAULT, Low "
-			       "Address = 0x%x\n",
-			       (unsigned int)deh_mgr_obj->err_info.dw_val2);
+					"Address = 0x%x\n",
+					(unsigned int)deh_mgr_obj->err_info.dw_val2);
 			printk(KERN_INFO
-			       "bridge_deh_notify: DSP_MMUFAULT, fault "
-			       "address = 0x%x\n", (unsigned int)fault_addr);
+					"bridge_deh_notify: DSP_MMUFAULT, fault "
+					"address = 0x%x\n", (unsigned int)fault_addr);
 			dummy_va_addr =
-			    (u32) mem_calloc(sizeof(char) * 0x1000, MEM_PAGED);
+				(u32) mem_calloc(sizeof(char) * 0x1000, MEM_PAGED);
 			mem_physical =
-			    VIRT_TO_PHYS(PG_ALIGN_LOW
-					 ((u32) dummy_va_addr, PG_SIZE4K));
+				VIRT_TO_PHYS(PG_ALIGN_LOW
+						((u32) dummy_va_addr, PG_SIZE4K));
 			dev_context = (struct wmd_dev_context *)
-			    deh_mgr_obj->hwmd_context;
-			/* Reset the dynamic mmu index to fixed count if it
+				deh_mgr_obj->hwmd_context;
+			/*
+			 * Reset the dynamic mmu index to fixed count if it
 			 * exceeds 31. So that the dynmmuindex is always
-			 * between the range of standard/fixed entries
-			 * and 31. */
+			 * between the range of standard/fixed entries and 31.
+			 */
 			if (dev_context->num_tlb_entries >
-			    hw_mmu_max_tlb_count) {
+					hw_mmu_max_tlb_count) {
 				dev_context->num_tlb_entries =
-				    dev_context->fixed_tlb_entries;
+					dev_context->fixed_tlb_entries;
 			}
 			if (DSP_SUCCEEDED(status)) {
 				hw_status_obj =
-				    hw_mmu_tlb_add(resources.dw_dmmu_base,
-						   mem_physical, fault_addr,
-						   HW_PAGE_SIZE4KB, 1,
-						   &map_attrs, HW_SET, HW_SET);
+					hw_mmu_tlb_add(resources.dw_dmmu_base,
+							mem_physical, fault_addr,
+							HW_PAGE_SIZE4KB, 1,
+							&map_attrs, HW_SET, HW_SET);
 			}
 			/* send an interrupt to DSP */
 			hw_mbox_msg_write(resources.dw_mbox_base, MBOX_ARM2DSP,
-					  MBX_DEH_CLASS | MBX_DEH_EMMU);
+					MBX_DEH_CLASS | MBX_DEH_EMMU);
 			/* Clear MMU interrupt */
 			hw_mmu_event_ack(resources.dw_dmmu_base,
-					 HW_MMU_TRANSLATION_FAULT);
+					HW_MMU_TRANSLATION_FAULT);
 			break;
 #ifdef CONFIG_BRIDGE_NTFY_PWRERR
 		case DSP_PWRERROR:
@@ -251,13 +258,13 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
 			deh_mgr_obj->err_info.dw_val3 = 0L;
 			deh_mgr_obj->err_info.dw_val1 = dwErrInfo;
 			printk(KERN_ERR
-			       "bridge_deh_notify: DSP_PWRERROR, err_info "
-			       "= 0x%x\n", dwErrInfo);
+					"bridge_deh_notify: DSP_PWRERROR, err_info "
+					"= 0x%x\n", dwErrInfo);
 			break;
 #endif /* CONFIG_BRIDGE_NTFY_PWRERR */
 		default:
 			dev_dbg(bridge, "%s: Unknown Error, err_info = 0x%x\n",
-				__func__, dwErrInfo);
+					__func__, dwErrInfo);
 			break;
 		}
 
@@ -276,7 +283,7 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
 }
 
 dsp_status bridge_deh_get_info(struct deh_mgr *hdeh_mgr,
-			    struct dsp_errorinfo *pErrInfo)
+		struct dsp_errorinfo *pErrInfo)
 {
 	dsp_status status = DSP_SOK;
 	struct deh_mgr *deh_mgr_obj = (struct deh_mgr *)hdeh_mgr;
@@ -285,8 +292,10 @@ dsp_status bridge_deh_get_info(struct deh_mgr *hdeh_mgr,
 	DBC_REQUIRE(pErrInfo);
 
 	if (MEM_IS_VALID_HANDLE(deh_mgr_obj, SIGNATURE)) {
-		/* Copy DEH error info structure to PROC error info
-		 * structure. */
+		/*
+		 * Copy DEH error info structure to PROC error info
+		 * structure.
+		 */
 		pErrInfo->dw_err_mask = deh_mgr_obj->err_info.dw_err_mask;
 		pErrInfo->dw_val1 = deh_mgr_obj->err_info.dw_val1;
 		pErrInfo->dw_val2 = deh_mgr_obj->err_info.dw_val2;
-- 
1.7.0.3

