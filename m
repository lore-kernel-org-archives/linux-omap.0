From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 05/14] dspbridge: remove unused code
Date: Sun, 16 May 2010 18:45:56 +0300
Message-ID: <1274024765-21076-6-git-send-email-felipe.contreras@gmail.com>
References: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:34390 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268Ab0EPPqT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 11:46:19 -0400
Received: by fg-out-1718.google.com with SMTP id 22so178499fge.1
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 08:46:18 -0700 (PDT)
In-Reply-To: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/plat-omap/include/dspbridge/dspdeh.h |    1 -
 drivers/dsp/bridge/core/_tiomap.h             |    6 +-----
 drivers/dsp/bridge/core/tiomap3430.c          |    2 --
 drivers/dsp/bridge/core/ue_deh.c              |   17 -----------------
 drivers/dsp/bridge/rmgr/proc.c                |    5 -----
 5 files changed, 1 insertions(+), 30 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dspdeh.h b/arch/arm/plat-omap/include/dspbridge/dspdeh.h
index 33cce90..e263184 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspdeh.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspdeh.h
@@ -43,5 +43,4 @@ extern dsp_status bridge_deh_register_notify(struct deh_mgr *deh_mgr,
 extern void bridge_deh_notify(struct deh_mgr *deh_mgr,
 		u32 ulEventMask, u32 dwErrInfo);
 
-extern void bridge_deh_release_dummy_mem(void);
 #endif /* DSPDEH_ */
diff --git a/drivers/dsp/bridge/core/_tiomap.h b/drivers/dsp/bridge/core/_tiomap.h
index df73964..7021fce 100644
--- a/drivers/dsp/bridge/core/_tiomap.h
+++ b/drivers/dsp/bridge/core/_tiomap.h
@@ -339,11 +339,7 @@ struct bridge_dev_context {
 	 */
 	/* DMMU TLB entries */
 	struct bridge_ioctl_extproc atlb_entry[BRDIOCTL_NUMOFMMUTLB];
-	u32 dw_brd_state;	/* Last known board state. */
-	u32 ul_int_mask;	/* int mask */
-	u16 io_base;		/* Board I/O base */
-	u32 num_tlb_entries;	/* DSP MMU TLB entry counter */
-	u32 fixed_tlb_entries;	/* Fixed DSPMMU TLB entry count */
+	u32 dw_brd_state;       /* Last known board state. */
 
 	/* TC Settings */
 	bool tc_word_swap_on;	/* Traffic Controller Word Swap */
diff --git a/drivers/dsp/bridge/core/tiomap3430.c b/drivers/dsp/bridge/core/tiomap3430.c
index c7b0d83..8a3eff9 100644
--- a/drivers/dsp/bridge/core/tiomap3430.c
+++ b/drivers/dsp/bridge/core/tiomap3430.c
@@ -844,7 +844,6 @@ static dsp_status bridge_dev_create(OUT struct bridge_dev_context
 		dev_context->atlb_entry[entry_ndx].ul_gpp_pa =
 		    dev_context->atlb_entry[entry_ndx].ul_dsp_va = 0;
 	}
-	dev_context->num_tlb_entries = 0;
 	dev_context->dw_dsp_base_addr = (u32) MEM_LINEAR_ADDRESS((void *)
 								 (pConfig->
 								  dw_mem_base
@@ -947,7 +946,6 @@ static dsp_status bridge_dev_create(OUT struct bridge_dev_context
 	}
 	if (DSP_SUCCEEDED(status)) {
 		dev_context->hdev_obj = hdev_obj;
-		dev_context->ul_int_mask = 0;
 		/* Store current board state. */
 		dev_context->dw_brd_state = BRD_STOPPED;
 		dev_context->resources = resources;
diff --git a/drivers/dsp/bridge/core/ue_deh.c b/drivers/dsp/bridge/core/ue_deh.c
index 593a0e3..61e5e4e 100644
--- a/drivers/dsp/bridge/core/ue_deh.c
+++ b/drivers/dsp/bridge/core/ue_deh.c
@@ -127,8 +127,6 @@ dsp_status bridge_deh_destroy(struct deh_mgr *deh_mgr)
 	if (!deh_mgr)
 		return -EFAULT;
 
-	/* Release dummy VA buffer */
-	bridge_deh_release_dummy_mem();
 	/* If notification object exists, delete it */
 	if (deh_mgr->ntfy_obj) {
 		ntfy_delete(deh_mgr->ntfy_obj);
@@ -194,7 +192,6 @@ static void wait_for_timer(void)
 void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 {
 	struct bridge_dev_context *dev_context;
-	u32 hw_mmu_max_tlb_count = 31;
 	struct cfg_hostres *resources;
 	struct hw_mmu_map_attrs_t map_attrs = {
 		.endianism = HW_LITTLE_ENDIAN,
@@ -238,16 +235,6 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 		print_dsp_trace_buffer(dev_context);
 		dump_dl_modules(dev_context);
 
-		/*
-		 * Reset the dynamic mmu index to fixed count if it exceeds
-		 * 31. So that the dynmmuindex is always between the range of
-		 * standard/fixed entries and 31.
-		 */
-		if (dev_context->num_tlb_entries >
-				hw_mmu_max_tlb_count) {
-			dev_context->num_tlb_entries =
-				dev_context->fixed_tlb_entries;
-		}
 		hw_mmu_tlb_add(resources->dw_dmmu_base,
 				virt_to_phys(dummy_va_addr), fault_addr,
 				HW_PAGE_SIZE4KB, 1,
@@ -320,7 +307,3 @@ dsp_status bridge_deh_get_info(struct deh_mgr *deh_mgr,
 
 	return 0;
 }
-
-void bridge_deh_release_dummy_mem(void)
-{
-}
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 7dc9b5c..f9efe6a 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -1362,11 +1362,6 @@ dsp_status proc_stop(void *hprocessor)
 		status = -EFAULT;
 		goto func_end;
 	}
-	if (DSP_SUCCEEDED((*p_proc_object->intf_fxns->pfn_brd_status)
-			  (p_proc_object->hbridge_context, &brd_state))) {
-		if (brd_state == BRD_ERROR)
-			bridge_deh_release_dummy_mem();
-	}
 	/* check if there are any running nodes */
 	status = dev_get_node_manager(p_proc_object->hdev_obj, &hnode_mgr);
 	if (DSP_SUCCEEDED(status) && hnode_mgr) {
-- 
1.7.1

