From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] dspbridge: deh: remove unused code
Date: Thu, 13 May 2010 23:46:41 +0300
Message-ID: <1273783601-13472-3-git-send-email-felipe.contreras@gmail.com>
References: <1273783601-13472-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:36607 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667Ab0EMUqw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 16:46:52 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1321331fga.1
        for <linux-omap@vger.kernel.org>; Thu, 13 May 2010 13:46:51 -0700 (PDT)
In-Reply-To: <1273783601-13472-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>

And a few cleanups.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/plat-omap/include/dspbridge/wmddeh.h |    1 -
 drivers/dsp/bridge/rmgr/proc.c                |    7 +------
 drivers/dsp/bridge/wmd/_tiomap.h              |    4 ----
 drivers/dsp/bridge/wmd/tiomap3430.c           |    2 --
 drivers/dsp/bridge/wmd/ue_deh.c               |   20 +-------------------
 5 files changed, 2 insertions(+), 32 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/wmddeh.h b/arch/arm/plat-omap/include/dspbridge/wmddeh.h
index 6f9a788..afe19c7 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmddeh.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmddeh.h
@@ -43,5 +43,4 @@ extern dsp_status bridge_deh_register_notify(struct deh_mgr *deh_mgr,
 extern void bridge_deh_notify(struct deh_mgr *deh_mgr,
 		u32 ulEventMask, u32 dwErrInfo);
 
-extern void bridge_deh_release_dummy_mem(void);
 #endif /* WMDDEH_ */
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index c163829..794ff63 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -1357,18 +1357,12 @@ dsp_status proc_stop(void *hprocessor)
 	u32 node_tab_size = 1;
 	u32 num_nodes = 0;
 	u32 nodes_allocated = 0;
-	int brd_state;
 
 	DBC_REQUIRE(refs > 0);
 	if (!p_proc_object) {
 		status = -EFAULT;
 		goto func_end;
 	}
-	if (DSP_SUCCEEDED((*p_proc_object->intf_fxns->pfn_brd_status)
-			  (p_proc_object->hwmd_context, &brd_state))) {
-		if (brd_state == BRD_ERROR)
-			bridge_deh_release_dummy_mem();
-	}
 	/* check if there are any running nodes */
 	status = dev_get_node_manager(p_proc_object->hdev_obj, &hnode_mgr);
 	if (DSP_SUCCEEDED(status) && hnode_mgr) {
@@ -1390,6 +1384,7 @@ dsp_status proc_stop(void *hprocessor)
 		p_proc_object->proc_state = PROC_STOPPED;
 		/* Destory the Node Manager, msg_ctrl Manager */
 		if (DSP_SUCCEEDED(dev_destroy2(p_proc_object->hdev_obj))) {
+			int brd_state;
 			/* Destroy the msg_ctrl by calling msg_delete */
 			dev_get_msg_mgr(p_proc_object->hdev_obj, &hmsg_mgr);
 			if (hmsg_mgr) {
diff --git a/drivers/dsp/bridge/wmd/_tiomap.h b/drivers/dsp/bridge/wmd/_tiomap.h
index bf3b849..d73b130 100644
--- a/drivers/dsp/bridge/wmd/_tiomap.h
+++ b/drivers/dsp/bridge/wmd/_tiomap.h
@@ -341,10 +341,6 @@ struct wmd_dev_context {
 	/* DMMU TLB entries */
 	struct wmdioctl_extproc atlb_entry[WMDIOCTL_NUMOFMMUTLB];
 	u32 dw_brd_state;	/* Last known board state. */
-	u32 ul_int_mask;	/* int mask */
-	u16 io_base;		/* Board I/O base */
-	u32 num_tlb_entries;	/* DSP MMU TLB entry counter */
-	u32 fixed_tlb_entries;	/* Fixed DSPMMU TLB entry count */
 
 	/* TC Settings */
 	bool tc_word_swap_on;	/* Traffic Controller Word Swap */
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index a69f663..cf4b28a 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -900,7 +900,6 @@ static dsp_status bridge_dev_create(OUT struct wmd_dev_context **ppDevContext,
 		dev_context->atlb_entry[entry_ndx].ul_gpp_pa =
 		    dev_context->atlb_entry[entry_ndx].ul_dsp_va = 0;
 	}
-	dev_context->num_tlb_entries = 0;
 	dev_context->dw_dsp_base_addr = (u32) MEM_LINEAR_ADDRESS((void *)
 								 (pConfig->
 								  dw_mem_base
@@ -1003,7 +1002,6 @@ static dsp_status bridge_dev_create(OUT struct wmd_dev_context **ppDevContext,
 	}
 	if (DSP_SUCCEEDED(status)) {
 		dev_context->hdev_obj = hdev_obj;
-		dev_context->ul_int_mask = 0;
 		/* Store current board state. */
 		dev_context->dw_brd_state = BRD_STOPPED;
 		dev_context->resources = resources;
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 233ad17..c39f56f 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -138,8 +138,6 @@ dsp_status bridge_deh_destroy(struct deh_mgr *deh_mgr)
 	if (!deh_mgr)
 		return -EFAULT;
 
-	/* Release dummy VA buffer */
-	bridge_deh_release_dummy_mem();
 	/* If notification object exists, delete it */
 	if (deh_mgr->ntfy_obj) {
 		ntfy_delete(deh_mgr->ntfy_obj);
@@ -182,9 +180,7 @@ dsp_status bridge_deh_register_notify(struct deh_mgr *deh_mgr, u32 event_mask,
 void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 {
 	struct wmd_dev_context *dev_context;
-	u32 hw_mmu_max_tlb_count = 31;
 	extern u32 fault_addr;
-	u32 cnt = 0;
 
 	if (!deh_mgr)
 		return;
@@ -222,22 +218,12 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 		dump_dl_modules(dev_context);
 
 		/*
-		 * Reset the dynamic mmu index to fixed count if it exceeds
-		 * 31. So that the dynmmuindex is always between the range of
-		 * standard/fixed entries and 31.
-		 */
-		if (dev_context->num_tlb_entries >
-				hw_mmu_max_tlb_count) {
-			dev_context->num_tlb_entries =
-				dev_context->fixed_tlb_entries;
-		}
-
-		/*
 		 * Send a GP Timer interrupt to DSP.
 		 * The DSP expects a GP timer interrupt after an
 		 * MMU-Fault Request GPTimer.
 		 */
 		if (timer) {
+			u32 cnt = 0;
 			omap_dm_timer_enable(timer);
 			/* Enable overflow interrupt */
 			omap_dm_timer_set_int_enable(timer,
@@ -327,7 +313,3 @@ dsp_status bridge_deh_get_info(struct deh_mgr *deh_mgr,
 
 	return DSP_SOK;
 }
-
-void bridge_deh_release_dummy_mem(void)
-{
-}
-- 
1.7.1

