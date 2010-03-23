From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 08/10] dsp-bridge: deh: reorganize create()
Date: Tue, 23 Mar 2010 23:25:40 +0200
Message-ID: <1269379542-11892-9-git-send-email-felipe.contreras@gmail.com>
References: <1269379542-11892-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:35757 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524Ab0CWV0d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Mar 2010 17:26:33 -0400
Received: by mail-bw0-f209.google.com with SMTP id 1so2292212bwz.21
        for <linux-omap@vger.kernel.org>; Tue, 23 Mar 2010 14:26:32 -0700 (PDT)
In-Reply-To: <1269379542-11892-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/plat-omap/include/dspbridge/wmddeh.h |    2 +-
 drivers/dsp/bridge/wmd/ue_deh.c               |   22 ++++++++++++----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/wmddeh.h b/arch/arm/plat-omap/include/dspbridge/wmddeh.h
index e193029..d7b7ee9 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmddeh.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmddeh.h
@@ -27,7 +27,7 @@
 
 #include <dspbridge/dehdefs.h>
 
-extern dsp_status bridge_deh_create(struct deh_mgr **phDehMgr,
+extern dsp_status bridge_deh_create(struct deh_mgr **ret_deh_mgr,
 		struct dev_object *hdev_obj);
 
 extern dsp_status bridge_deh_destroy(struct deh_mgr *hdeh_mgr);
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 1add675..104ab33 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -62,11 +62,11 @@ static struct hw_mmu_map_attrs_t map_attrs = {
 
 static u32 dummy_va_addr;
 
-dsp_status bridge_deh_create(struct deh_mgr **phDehMgr,
+dsp_status bridge_deh_create(struct deh_mgr **ret_deh_mgr,
 		struct dev_object *hdev_obj)
 {
 	dsp_status status = DSP_SOK;
-	struct deh_mgr *deh_mgr_obj = NULL;
+	struct deh_mgr *deh_mgr_obj;
 	struct cfg_hostres cfg_host_res;
 	struct cfg_devnode *dev_node_obj;
 	struct wmd_dev_context *hwmd_context = NULL;
@@ -83,7 +83,7 @@ dsp_status bridge_deh_create(struct deh_mgr **phDehMgr,
 	dummy_va_addr = 0;
 	/* Allocate IO manager object: */
 	MEM_ALLOC_OBJECT(deh_mgr_obj, struct deh_mgr, SIGNATURE);
-	if (deh_mgr_obj == NULL) {
+	if (!deh_mgr_obj) {
 		status = DSP_EMEMORY;
 		goto leave;
 	}
@@ -96,17 +96,17 @@ dsp_status bridge_deh_create(struct deh_mgr **phDehMgr,
 			(u32) deh_mgr_obj);
 
 	if (DSP_FAILED(status))
-		goto leave;
+		goto err;
 
 	status = dev_get_dev_node(hdev_obj, &dev_node_obj);
 
 	if (DSP_FAILED(status))
-		goto leave;
+		goto err;
 
 	status = cfg_get_host_resources(dev_node_obj, &cfg_host_res);
 
 	if (DSP_FAILED(status))
-		goto leave;
+		goto err;
 
 	/* Fill in context structure */
 	deh_mgr_obj->hwmd_context = hwmd_context;
@@ -114,6 +114,7 @@ dsp_status bridge_deh_create(struct deh_mgr **phDehMgr,
 	deh_mgr_obj->err_info.dw_val1 = 0L;
 	deh_mgr_obj->err_info.dw_val2 = 0L;
 	deh_mgr_obj->err_info.dw_val3 = 0L;
+
 	/* Install ISR function for DSP MMU fault */
 	if ((request_irq(INT_DSP_MMU_IRQ, mmu_fault_isr, 0,
 					"DspBridge\tiommu fault",
@@ -122,15 +123,16 @@ dsp_status bridge_deh_create(struct deh_mgr **phDehMgr,
 	else
 		status = DSP_EFAIL;
 
-leave:
+err:
 	if (DSP_FAILED(status)) {
 		/* If create failed, cleanup */
 		bridge_deh_destroy((struct deh_mgr *)deh_mgr_obj);
-		*phDehMgr = NULL;
-	} else {
-		*phDehMgr = (struct deh_mgr *)deh_mgr_obj;
+		deh_mgr_obj = NULL;
 	}
 
+leave:
+	*ret_deh_mgr = deh_mgr_obj;
+
 	return status;
 }
 
-- 
1.7.0.3

