From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 04/15] tidspbridge: tiomap3430: Remove unneeded dev_context local variables
Date: Wed, 19 Sep 2012 14:06:52 +0200
Message-ID: <1348056423-25573-5-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:35804 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756135Ab2ISMGd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 08:06:33 -0400
In-Reply-To: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>

Most function that takes a device context as argument immediately assign
it to a local variable of the same type and use the local variable.
Remove the variable and use the function parameter directly. Rename all
remaining occurences of dev_context to dev_ctxt to be consistent with
the rest of the code.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/staging/tidspbridge/core/tiomap3430.c |  216 ++++++++++++-------------
 1 files changed, 101 insertions(+), 115 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/tiomap3430.c b/drivers/staging/tidspbridge/core/tiomap3430.c
index fa5b7b9..5113da8 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430.c
@@ -132,7 +132,6 @@ static struct notifier_block dsp_mbox_notifier = {
  */
 static int bridge_brd_monitor(struct bridge_dev_context *dev_ctxt)
 {
-	struct bridge_dev_context *dev_context = dev_ctxt;
 	u32 temp;
 	struct omap_dsp_platform_data *pdata =
 		omap_dspbridge_dev->dev.platform_data;
@@ -161,7 +160,7 @@ static int bridge_brd_monitor(struct bridge_dev_context *dev_ctxt)
 	dsp_clk_enable(DSP_CLK_IVA2);
 
 	/* set the device state to IDLE */
-	dev_context->brd_state = BRD_IDLE;
+	dev_ctxt->brd_state = BRD_IDLE;
 
 	return 0;
 }
@@ -176,20 +175,19 @@ static int bridge_brd_read(struct bridge_dev_context *dev_ctxt,
 				  u32 ul_num_bytes, u32 mem_type)
 {
 	int status = 0;
-	struct bridge_dev_context *dev_context = dev_ctxt;
 	u32 offset;
 	u32 dsp_base_addr = dev_ctxt->dsp_base_addr;
 
-	if (dsp_addr < dev_context->dsp_start_add) {
+	if (dsp_addr < dev_ctxt->dsp_start_add) {
 		status = -EPERM;
 		return status;
 	}
 	/* change here to account for the 3 bands of the DSP internal memory */
-	if ((dsp_addr - dev_context->dsp_start_add) <
-	    dev_context->internal_size) {
-		offset = dsp_addr - dev_context->dsp_start_add;
+	if ((dsp_addr - dev_ctxt->dsp_start_add) <
+	    dev_ctxt->internal_size) {
+		offset = dsp_addr - dev_ctxt->dsp_start_add;
 	} else {
-		status = read_ext_dsp_data(dev_context, host_buff, dsp_addr,
+		status = read_ext_dsp_data(dev_ctxt, host_buff, dsp_addr,
 					   ul_num_bytes, mem_type);
 		return status;
 	}
@@ -207,18 +205,17 @@ static int bridge_brd_write(struct bridge_dev_context *dev_ctxt,
 				   u32 ul_num_bytes, u32 mem_type)
 {
 	int status = 0;
-	struct bridge_dev_context *dev_context = dev_ctxt;
 
-	if (dsp_addr < dev_context->dsp_start_add) {
+	if (dsp_addr < dev_ctxt->dsp_start_add) {
 		status = -EPERM;
 		return status;
 	}
-	if ((dsp_addr - dev_context->dsp_start_add) <
-	    dev_context->internal_size) {
+	if ((dsp_addr - dev_ctxt->dsp_start_add) <
+	    dev_ctxt->internal_size) {
 		status = write_dsp_data(dev_ctxt, host_buff, dsp_addr,
 					ul_num_bytes, mem_type);
 	} else {
-		status = write_ext_dsp_data(dev_context, host_buff, dsp_addr,
+		status = write_ext_dsp_data(dev_ctxt, host_buff, dsp_addr,
 					    ul_num_bytes, mem_type, false);
 	}
 
@@ -234,9 +231,8 @@ static int bridge_brd_set_state(struct bridge_dev_context *dev_ctxt,
 				    u32 brd_state)
 {
 	int status = 0;
-	struct bridge_dev_context *dev_context = dev_ctxt;
 
-	dev_context->brd_state = brd_state;
+	dev_ctxt->brd_state = brd_state;
 	return status;
 }
 
@@ -244,7 +240,7 @@ static int bridge_brd_set_state(struct bridge_dev_context *dev_ctxt,
  *  ======== wait_for_start ========
  *      Wait for the singal from DSP that it has started, or time out.
  */
-bool wait_for_start(struct bridge_dev_context *dev_context, u32 dw_sync_addr)
+bool wait_for_start(struct bridge_dev_context *dev_ctxt, u32 dw_sync_addr)
 {
 	u16 timeout = TIHELEN_ACKTIMEOUT;
 
@@ -274,7 +270,6 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 				   u32 dsp_addr)
 {
 	int status = 0;
-	struct bridge_dev_context *dev_context = dev_ctxt;
 	u32 dw_sync_addr = 0;
 	u32 ul_shm_base;	/* Gpp Phys SM base addr(byte) */
 	u32 ul_shm_base_virt;	/* Dsp Virt SM base addr */
@@ -299,15 +294,15 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 	 * last dsp base image was loaded. The first entry is always
 	 * SHMMEM base. */
 	/* Get SHM_BEG - convert to byte address */
-	(void)dev_get_symbol(dev_context->dev_obj, SHMBASENAME,
+	(void)dev_get_symbol(dev_ctxt->dev_obj, SHMBASENAME,
 			     &ul_shm_base_virt);
 	ul_shm_base_virt *= DSPWORDSIZE;
 	/* DSP Virtual address */
-	ul_tlb_base_virt = dev_context->atlb_entry[0].dsp_va;
+	ul_tlb_base_virt = dev_ctxt->atlb_entry[0].dsp_va;
 	ul_shm_offset_virt =
 	    ul_shm_base_virt - (ul_tlb_base_virt * DSPWORDSIZE);
 	/* Kernel logical address */
-	ul_shm_base = dev_context->atlb_entry[0].gpp_va + ul_shm_offset_virt;
+	ul_shm_base = dev_ctxt->atlb_entry[0].gpp_va + ul_shm_offset_virt;
 
 	/* 2nd wd is used as sync field */
 	dw_sync_addr = ul_shm_base + SHMSYNCOFFSET;
@@ -320,7 +315,7 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 		__raw_writel(0xffffffff, dw_sync_addr);
 
 	if (!status) {
-		resources = dev_context->resources;
+		resources = dev_ctxt->resources;
 		if (!resources)
 			status = -EPERM;
 
@@ -367,7 +362,7 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 		/* Only make TLB entry if both addresses are non-zero */
 		for (entry_ndx = 0; entry_ndx < BRDIOCTL_NUMOFMMUTLB;
 		     entry_ndx++) {
-			struct bridge_ioctl_extproc *e = &dev_context->atlb_entry[entry_ndx];
+			struct bridge_ioctl_extproc *e = &dev_ctxt->atlb_entry[entry_ndx];
 			struct hw_mmu_map_attrs_t map_attrs = {
 				.endianism = e->endianism,
 				.element_size = e->elem_size,
@@ -384,7 +379,7 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 					e->dsp_va,
 					e->size);
 
-			hw_mmu_tlb_add(dev_context->dsp_mmu_base,
+			hw_mmu_tlb_add(dev_ctxt->dsp_mmu_base,
 					e->gpp_pa,
 					e->dsp_va,
 					e->size,
@@ -401,7 +396,7 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 		hw_mmu_num_locked_set(resources->dmmu_base, itmp_entry_ndx);
 		hw_mmu_victim_num_set(resources->dmmu_base, itmp_entry_ndx);
 		hw_mmu_ttb_set(resources->dmmu_base,
-			       dev_context->pt_attrs->l1_base_pa);
+			       dev_ctxt->pt_attrs->l1_base_pa);
 		hw_mmu_twl_enable(resources->dmmu_base);
 		/* Enable the SmartIdle and AutoIdle bit for MMU_SYSCONFIG */
 
@@ -413,9 +408,9 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 		hw_mmu_enable(resources->dmmu_base);
 
 		/* Enable the BIOS clock */
-		(void)dev_get_symbol(dev_context->dev_obj,
+		(void)dev_get_symbol(dev_ctxt->dev_obj,
 				     BRIDGEINIT_BIOSGPTIMER, &ul_bios_gp_timer);
-		(void)dev_get_symbol(dev_context->dev_obj,
+		(void)dev_get_symbol(dev_ctxt->dev_obj,
 				     BRIDGEINIT_LOADMON_GPTIMER,
 				     &ul_load_monitor_timer);
 	}
@@ -424,7 +419,7 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 		if (ul_load_monitor_timer != 0xFFFF) {
 			clk_cmd = (BPWR_ENABLE_CLOCK << MBX_PM_CLK_CMDSHIFT) |
 			    ul_load_monitor_timer;
-			dsp_peripheral_clk_ctrl(dev_context, &clk_cmd);
+			dsp_peripheral_clk_ctrl(dev_ctxt, &clk_cmd);
 		} else {
 			dev_dbg(bridge, "Not able to get the symbol for Load "
 				"Monitor Timer\n");
@@ -435,7 +430,7 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 		if (ul_bios_gp_timer != 0xFFFF) {
 			clk_cmd = (BPWR_ENABLE_CLOCK << MBX_PM_CLK_CMDSHIFT) |
 			    ul_bios_gp_timer;
-			dsp_peripheral_clk_ctrl(dev_context, &clk_cmd);
+			dsp_peripheral_clk_ctrl(dev_ctxt, &clk_cmd);
 		} else {
 			dev_dbg(bridge,
 				"Not able to get the symbol for BIOS Timer\n");
@@ -444,7 +439,7 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 
 	if (!status) {
 		/* Set the DSP clock rate */
-		(void)dev_get_symbol(dev_context->dev_obj,
+		(void)dev_get_symbol(dev_ctxt->dev_obj,
 				     "_BRIDGEINIT_DSP_FREQ", &ul_dsp_clk_addr);
 		/*Set Autoidle Mode for IVA2 PLL */
 		(*pdata->dsp_cm_write)(1 << OMAP3430_AUTO_IVA2_DPLL_SHIFT,
@@ -455,7 +450,7 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 			ul_dsp_clk_rate = dsp_clk_get_iva2_rate();
 			dev_dbg(bridge, "%s: DSP clock rate (KHZ): 0x%x \n",
 				__func__, ul_dsp_clk_rate);
-			(void)bridge_brd_write(dev_context,
+			(void)bridge_brd_write(dev_ctxt,
 					       (u8 *) &ul_dsp_clk_rate,
 					       ul_dsp_clk_addr, sizeof(u32), 0);
 		}
@@ -463,9 +458,9 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 		 * Enable Mailbox events and also drain any pending
 		 * stale messages.
 		 */
-		dev_context->mbox = omap_mbox_get("dsp", &dsp_mbox_notifier);
-		if (IS_ERR(dev_context->mbox)) {
-			dev_context->mbox = NULL;
+		dev_ctxt->mbox = omap_mbox_get("dsp", &dsp_mbox_notifier);
+		if (IS_ERR(dev_ctxt->mbox)) {
+			dev_ctxt->mbox = NULL;
 			pr_err("%s: Failed to get dsp mailbox handle\n",
 								__func__);
 			status = -EPERM;
@@ -508,17 +503,17 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 
 		/* Wait for DSP to clear word in shared memory */
 		/* Read the Location */
-		if (!wait_for_start(dev_context, dw_sync_addr))
+		if (!wait_for_start(dev_ctxt, dw_sync_addr))
 			status = -ETIMEDOUT;
 
-		dev_get_symbol(dev_context->dev_obj, "_WDT_enable", &wdt_en);
+		dev_get_symbol(dev_ctxt->dev_obj, "_WDT_enable", &wdt_en);
 		if (wdt_en) {
 			/* Start wdt */
 			dsp_wdt_sm_set((void *)ul_shm_base);
 			dsp_wdt_enable(true);
 		}
 
-		status = dev_get_io_mgr(dev_context->dev_obj, &hio_mgr);
+		status = dev_get_io_mgr(dev_ctxt->dev_obj, &hio_mgr);
 		if (hio_mgr) {
 			io_sh_msetting(hio_mgr, SHM_OPPINFO, NULL);
 			/* Write the synchronization bit to indicate the
@@ -527,10 +522,10 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 			__raw_writel(0XCAFECAFE, dw_sync_addr);
 
 			/* update board state */
-			dev_context->brd_state = BRD_RUNNING;
-			/* (void)chnlsm_enable_interrupt(dev_context); */
+			dev_ctxt->brd_state = BRD_RUNNING;
+			/* (void)chnlsm_enable_interrupt(dev_ctxt); */
 		} else {
-			dev_context->brd_state = BRD_UNKNOWN;
+			dev_ctxt->brd_state = BRD_UNKNOWN;
 		}
 	}
 	return status;
@@ -547,13 +542,12 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 static int bridge_brd_stop(struct bridge_dev_context *dev_ctxt)
 {
 	int status = 0;
-	struct bridge_dev_context *dev_context = dev_ctxt;
 	struct pg_table_attrs *pt_attrs;
 	u32 dsp_pwr_state;
 	struct omap_dsp_platform_data *pdata =
 		omap_dspbridge_dev->dev.platform_data;
 
-	if (dev_context->brd_state == BRD_STOPPED)
+	if (dev_ctxt->brd_state == BRD_STOPPED)
 		return status;
 
 	/* as per TRM, it is advised to first drive the IVA2 to 'Standby' mode,
@@ -564,7 +558,7 @@ static int bridge_brd_stop(struct bridge_dev_context *dev_ctxt)
 	if (dsp_pwr_state != PWRDM_POWER_OFF) {
 		(*pdata->dsp_prm_rmw_bits)(OMAP3430_RST2_IVA2_MASK, 0,
 					OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
-		sm_interrupt_dsp(dev_context, MBX_PM_DSPIDLE);
+		sm_interrupt_dsp(dev_ctxt, MBX_PM_DSPIDLE);
 		mdelay(10);
 
 		/* IVA2 is not in OFF state */
@@ -578,32 +572,32 @@ static int bridge_brd_stop(struct bridge_dev_context *dev_ctxt)
 	udelay(10);
 	/* Release the Ext Base virtual Address as the next DSP Program
 	 * may have a different load address */
-	if (dev_context->dsp_ext_base_addr)
-		dev_context->dsp_ext_base_addr = 0;
+	if (dev_ctxt->dsp_ext_base_addr)
+		dev_ctxt->dsp_ext_base_addr = 0;
 
-	dev_context->brd_state = BRD_STOPPED;	/* update board state */
+	dev_ctxt->brd_state = BRD_STOPPED;	/* update board state */
 
 	dsp_wdt_enable(false);
 
 	/* This is a good place to clear the MMU page tables as well */
-	if (dev_context->pt_attrs) {
-		pt_attrs = dev_context->pt_attrs;
+	if (dev_ctxt->pt_attrs) {
+		pt_attrs = dev_ctxt->pt_attrs;
 		memset((u8 *) pt_attrs->l1_base_va, 0x00, pt_attrs->l1_size);
 		memset((u8 *) pt_attrs->l2_base_va, 0x00, pt_attrs->l2_size);
 		memset((u8 *) pt_attrs->pg_info, 0x00,
 		       (pt_attrs->l2_num_pages * sizeof(struct page_info)));
 	}
 	/* Disable the mailbox interrupts */
-	if (dev_context->mbox) {
-		omap_mbox_disable_irq(dev_context->mbox, IRQ_RX);
-		omap_mbox_put(dev_context->mbox, &dsp_mbox_notifier);
-		dev_context->mbox = NULL;
+	if (dev_ctxt->mbox) {
+		omap_mbox_disable_irq(dev_ctxt->mbox, IRQ_RX);
+		omap_mbox_put(dev_ctxt->mbox, &dsp_mbox_notifier);
+		dev_ctxt->mbox = NULL;
 	}
 	/* Reset IVA2 clocks*/
 	(*pdata->dsp_prm_write)(OMAP3430_RST1_IVA2_MASK | OMAP3430_RST2_IVA2_MASK |
 			OMAP3430_RST3_IVA2_MASK, OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
 
-	dsp_clock_disable_all(dev_context->dsp_per_clks);
+	dsp_clock_disable_all(dev_ctxt->dsp_per_clks);
 	dsp_clk_disable(DSP_CLK_IVA2);
 
 	return status;
@@ -616,8 +610,7 @@ static int bridge_brd_stop(struct bridge_dev_context *dev_ctxt)
 static int bridge_brd_status(struct bridge_dev_context *dev_ctxt,
 				    int *board_state)
 {
-	struct bridge_dev_context *dev_context = dev_ctxt;
-	*board_state = dev_context->brd_state;
+	*board_state = dev_ctxt->brd_state;
 	return 0;
 }
 
@@ -631,7 +624,7 @@ static int bridge_dev_create(struct bridge_dev_context
 					struct cfg_hostres *config_param)
 {
 	int status = 0;
-	struct bridge_dev_context *dev_context = NULL;
+	struct bridge_dev_context *dev_ctxt = NULL;
 	s32 entry_ndx;
 	struct cfg_hostres *resources = config_param;
 	struct pg_table_attrs *pt_attrs;
@@ -642,30 +635,30 @@ static int bridge_dev_create(struct bridge_dev_context
 
 	/* Allocate and initialize a data structure to contain the bridge driver
 	 *  state, which becomes the context for later calls into this driver */
-	dev_context = kzalloc(sizeof(struct bridge_dev_context), GFP_KERNEL);
-	if (!dev_context) {
+	dev_ctxt = kzalloc(sizeof(struct bridge_dev_context), GFP_KERNEL);
+	if (!dev_ctxt) {
 		status = -ENOMEM;
 		goto func_end;
 	}
 
-	dev_context->dsp_start_add = (u32) OMAP_GEM_BASE;
-	dev_context->self_loop = (u32) NULL;
-	dev_context->dsp_per_clks = 0;
-	dev_context->internal_size = OMAP_DSP_SIZE;
+	dev_ctxt->dsp_start_add = (u32) OMAP_GEM_BASE;
+	dev_ctxt->self_loop = (u32) NULL;
+	dev_ctxt->dsp_per_clks = 0;
+	dev_ctxt->internal_size = OMAP_DSP_SIZE;
 	/*  Clear dev context MMU table entries.
 	 *  These get set on bridge_io_on_loaded() call after program loaded. */
 	for (entry_ndx = 0; entry_ndx < BRDIOCTL_NUMOFMMUTLB; entry_ndx++) {
-		dev_context->atlb_entry[entry_ndx].gpp_pa =
-		    dev_context->atlb_entry[entry_ndx].dsp_va = 0;
+		dev_ctxt->atlb_entry[entry_ndx].gpp_pa =
+		    dev_ctxt->atlb_entry[entry_ndx].dsp_va = 0;
 	}
-	dev_context->dsp_base_addr = (u32) MEM_LINEAR_ADDRESS((void *)
+	dev_ctxt->dsp_base_addr = (u32) MEM_LINEAR_ADDRESS((void *)
 								 (config_param->
 								  mem_base
 								  [3]),
 								 config_param->
 								 mem_length
 								 [3]);
-	if (!dev_context->dsp_base_addr)
+	if (!dev_ctxt->dsp_base_addr)
 		status = -EPERM;
 
 	pt_attrs = kzalloc(sizeof(struct pg_table_attrs), GFP_KERNEL);
@@ -741,29 +734,29 @@ static int bridge_dev_create(struct bridge_dev_context
 	}
 	if ((pt_attrs != NULL) && (pt_attrs->l1_base_va != 0) &&
 	    (pt_attrs->l2_base_va != 0) && (pt_attrs->pg_info != NULL))
-		dev_context->pt_attrs = pt_attrs;
+		dev_ctxt->pt_attrs = pt_attrs;
 	else
 		status = -ENOMEM;
 
 	if (!status) {
 		spin_lock_init(&pt_attrs->pg_lock);
-		dev_context->tc_word_swap_on = drv_datap->tc_wordswapon;
+		dev_ctxt->tc_word_swap_on = drv_datap->tc_wordswapon;
 
 		/* Set the Clock Divisor for the DSP module */
 		udelay(5);
 		/* MMU address is obtained from the host
 		 * resources struct */
-		dev_context->dsp_mmu_base = resources->dmmu_base;
+		dev_ctxt->dsp_mmu_base = resources->dmmu_base;
 	}
 	if (!status) {
-		dev_context->dev_obj = hdev_obj;
+		dev_ctxt->dev_obj = hdev_obj;
 		/* Store current board state. */
-		dev_context->brd_state = BRD_UNKNOWN;
-		dev_context->resources = resources;
+		dev_ctxt->brd_state = BRD_UNKNOWN;
+		dev_ctxt->resources = resources;
 		dsp_clk_enable(DSP_CLK_IVA2);
-		bridge_brd_stop(dev_context);
+		bridge_brd_stop(dev_ctxt);
 		/* Return ptr to our device state to the DSP API for storage */
-		*dev_cntxt = dev_context;
+		*dev_cntxt = dev_ctxt;
 	} else {
 		if (pt_attrs != NULL) {
 			kfree(pt_attrs->pg_info);
@@ -782,7 +775,7 @@ static int bridge_dev_create(struct bridge_dev_context
 			}
 		}
 		kfree(pt_attrs);
-		kfree(dev_context);
+		kfree(dev_ctxt);
 	}
 func_end:
 	return status;
@@ -792,7 +785,7 @@ func_end:
  *  ======== bridge_dev_ctrl ========
  *      Receives device specific commands.
  */
-static int bridge_dev_ctrl(struct bridge_dev_context *dev_context,
+static int bridge_dev_ctrl(struct bridge_dev_context *dev_ctxt,
 				  u32 dw_cmd, void *pargs)
 {
 	int status = 0;
@@ -808,33 +801,33 @@ static int bridge_dev_ctrl(struct bridge_dev_context *dev_context,
 	case BRDIOCTL_SETMMUCONFIG:
 		/* store away dsp-mmu setup values for later use */
 		for (ndx = 0; ndx < BRDIOCTL_NUMOFMMUTLB; ndx++, pa_ext_proc++)
-			dev_context->atlb_entry[ndx] = *pa_ext_proc;
+			dev_ctxt->atlb_entry[ndx] = *pa_ext_proc;
 		break;
 	case BRDIOCTL_DEEPSLEEP:
 	case BRDIOCTL_EMERGENCYSLEEP:
 		/* Currently only DSP Idle is supported Need to update for
 		 * later releases */
-		status = sleep_dsp(dev_context, PWR_DEEPSLEEP, pargs);
+		status = sleep_dsp(dev_ctxt, PWR_DEEPSLEEP, pargs);
 		break;
 	case BRDIOCTL_WAKEUP:
-		status = wake_dsp(dev_context, pargs);
+		status = wake_dsp(dev_ctxt, pargs);
 		break;
 	case BRDIOCTL_CLK_CTRL:
 		status = 0;
 		/* Looking For Baseport Fix for Clocks */
-		status = dsp_peripheral_clk_ctrl(dev_context, pargs);
+		status = dsp_peripheral_clk_ctrl(dev_ctxt, pargs);
 		break;
 	case BRDIOCTL_PWR_HIBERNATE:
-		status = handle_hibernation_from_dsp(dev_context);
+		status = handle_hibernation_from_dsp(dev_ctxt);
 		break;
 	case BRDIOCTL_PRESCALE_NOTIFY:
-		status = pre_scale_dsp(dev_context, pargs);
+		status = pre_scale_dsp(dev_ctxt, pargs);
 		break;
 	case BRDIOCTL_POSTSCALE_NOTIFY:
-		status = post_scale_dsp(dev_context, pargs);
+		status = post_scale_dsp(dev_ctxt, pargs);
 		break;
 	case BRDIOCTL_CONSTRAINT_REQUEST:
-		status = handle_constraints_set(dev_context, pargs);
+		status = handle_constraints_set(dev_ctxt, pargs);
 		break;
 	default:
 		status = -EPERM;
@@ -851,8 +844,6 @@ static int bridge_dev_destroy(struct bridge_dev_context *dev_ctxt)
 {
 	struct pg_table_attrs *pt_attrs;
 	int status = 0;
-	struct bridge_dev_context *dev_context = (struct bridge_dev_context *)
-	    dev_ctxt;
 	struct cfg_hostres *host_res;
 	u32 shm_size;
 	struct drv_data *drv_datap = dev_get_drvdata(bridge);
@@ -862,9 +853,9 @@ static int bridge_dev_destroy(struct bridge_dev_context *dev_ctxt)
 		return -EFAULT;
 
 	/* first put the device to stop state */
-	bridge_brd_stop(dev_context);
-	if (dev_context->pt_attrs) {
-		pt_attrs = dev_context->pt_attrs;
+	bridge_brd_stop(dev_ctxt);
+	if (dev_ctxt->pt_attrs) {
+		pt_attrs = dev_ctxt->pt_attrs;
 		kfree(pt_attrs->pg_info);
 
 		if (pt_attrs->l2_tbl_alloc_va) {
@@ -881,8 +872,8 @@ static int bridge_dev_destroy(struct bridge_dev_context *dev_ctxt)
 
 	}
 
-	if (dev_context->resources) {
-		host_res = dev_context->resources;
+	if (dev_ctxt->resources) {
+		host_res = dev_ctxt->resources;
 		shm_size = drv_datap->shm_size;
 		if (shm_size >= 0x10000) {
 			if ((host_res->mem_base[1]) &&
@@ -944,7 +935,6 @@ static int bridge_brd_mem_copy(struct bridge_dev_context *dev_ctxt,
 	u32 copy_bytes = 0;
 	u32 total_bytes = ul_num_bytes;
 	u8 host_buf[BUFFERSIZE];
-	struct bridge_dev_context *dev_context = dev_ctxt;
 	while (total_bytes > 0 && !status) {
 		copy_bytes =
 		    total_bytes > BUFFERSIZE ? BUFFERSIZE : total_bytes;
@@ -952,8 +942,8 @@ static int bridge_brd_mem_copy(struct bridge_dev_context *dev_ctxt,
 		status = read_ext_dsp_data(dev_ctxt, host_buf, src_addr,
 					   copy_bytes, mem_type);
 		if (!status) {
-			if (dest_addr < (dev_context->dsp_start_add +
-					 dev_context->internal_size)) {
+			if (dest_addr < (dev_ctxt->dsp_start_add +
+					 dev_ctxt->internal_size)) {
 				/* Write to Internal memory */
 				status = write_dsp_data(dev_ctxt, host_buf,
 							dest_addr, copy_bytes,
@@ -979,15 +969,14 @@ static int bridge_brd_mem_write(struct bridge_dev_context *dev_ctxt,
 				    u32 ul_num_bytes, u32 mem_type)
 {
 	int status = 0;
-	struct bridge_dev_context *dev_context = dev_ctxt;
 	u32 ul_remain_bytes = 0;
 	u32 ul_bytes = 0;
 	ul_remain_bytes = ul_num_bytes;
 	while (ul_remain_bytes > 0 && !status) {
 		ul_bytes =
 		    ul_remain_bytes > BUFFERSIZE ? BUFFERSIZE : ul_remain_bytes;
-		if (dsp_addr < (dev_context->dsp_start_add +
-				 dev_context->internal_size)) {
+		if (dsp_addr < (dev_ctxt->dsp_start_add +
+				 dev_ctxt->internal_size)) {
 			status =
 			    write_dsp_data(dev_ctxt, host_buff, dsp_addr,
 					   ul_bytes, mem_type);
@@ -1113,7 +1102,6 @@ static int pte_update(struct bridge_dev_context *dev_ctxt, u32 pa,
 	u32 pa_curr = pa;
 	u32 va_curr = va;
 	u32 num_bytes = size;
-	struct bridge_dev_context *dev_context = dev_ctxt;
 	int status = 0;
 	u32 page_size[] = { HW_PAGE_SIZE16MB, HW_PAGE_SIZE1MB,
 		HW_PAGE_SIZE64KB, HW_PAGE_SIZE4KB
@@ -1129,7 +1117,7 @@ static int pte_update(struct bridge_dev_context *dev_ctxt, u32 pa,
 							     (page_size[i] -
 							      1)) == 0)) {
 				status =
-				    pte_set(dev_context->pt_attrs, pa_curr,
+				    pte_set(dev_ctxt->pt_attrs, pa_curr,
 					    va_curr, page_size[i], map_attrs);
 				pa_curr += page_size[i];
 				va_curr += page_size[i];
@@ -1180,17 +1168,17 @@ static u32 user_va2_pa(struct mm_struct *mm, u32 address)
 	return 0;
 }
 
-static inline void flush_all(struct bridge_dev_context *dev_context)
+static inline void flush_all(struct bridge_dev_context *dev_ctxt)
 {
-	if (dev_context->brd_state == BRD_DSP_HIBERNATION ||
-	    dev_context->brd_state == BRD_HIBERNATION)
-		wake_dsp(dev_context, NULL);
+	if (dev_ctxt->brd_state == BRD_DSP_HIBERNATION ||
+	    dev_ctxt->brd_state == BRD_HIBERNATION)
+		wake_dsp(dev_ctxt, NULL);
 
-	hw_mmu_tlb_flush_all(dev_context->dsp_mmu_base);
+	hw_mmu_tlb_flush_all(dev_ctxt->dsp_mmu_base);
 }
 
 /* Memory map kernel VA -- memory allocated with vmalloc */
-static int mem_map_vmalloc(struct bridge_dev_context *dev_context,
+static int mem_map_vmalloc(struct bridge_dev_context *dev_ctxt,
 				  u32 ul_mpu_addr, u32 virt_addr,
 				  u32 ul_num_bytes,
 				  struct hw_mmu_map_attrs_t *hw_attrs)
@@ -1250,7 +1238,7 @@ static int mem_map_vmalloc(struct bridge_dev_context *dev_context,
 			get_page(PHYS_TO_PAGE(pa));
 			pa += HW_PAGE_SIZE4KB;
 		}
-		status = pte_update(dev_context, pa_curr, virt_addr +
+		status = pte_update(dev_ctxt, pa_curr, virt_addr +
 				    (va_curr - ul_mpu_addr), size_curr,
 				    hw_attrs);
 		va_curr += size_curr;
@@ -1261,7 +1249,7 @@ static int mem_map_vmalloc(struct bridge_dev_context *dev_context,
 	 * repetition while mapping non-contiguous physical regions of a virtual
 	 * region
 	 */
-	flush_all(dev_context);
+	flush_all(dev_ctxt);
 	dev_dbg(bridge, "%s status %x\n", __func__, status);
 	return status;
 }
@@ -1303,8 +1291,7 @@ static int bridge_brd_mem_un_map(struct bridge_dev_context *dev_ctxt,
 	u32 va_curr;
 	struct page *pg = NULL;
 	int status = 0;
-	struct bridge_dev_context *dev_context = dev_ctxt;
-	struct pg_table_attrs *pt = dev_context->pt_attrs;
+	struct pg_table_attrs *pt = dev_ctxt->pt_attrs;
 	u32 temp;
 	u32 paddr;
 	u32 numof4k_pages = 0;
@@ -1468,7 +1455,7 @@ skip_coarse_page:
 	 * get flushed
 	 */
 EXIT_LOOP:
-	flush_all(dev_context);
+	flush_all(dev_ctxt);
 	dev_dbg(bridge,
 		"%s: va_curr %x, pte_addr_l1 %x pte_addr_l2 %x rem_bytes %x,"
 		" rem_bytes_l2 %x status %x\n", __func__, va_curr, pte_addr_l1,
@@ -1492,7 +1479,6 @@ static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
 {
 	u32 attrs;
 	int status = 0;
-	struct bridge_dev_context *dev_context = dev_ctxt;
 	struct hw_mmu_map_attrs_t hw_attrs;
 	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
@@ -1563,7 +1549,7 @@ static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
 	 * Pass the translated pa to pte_update.
 	 */
 	if ((attrs & DSP_MAPPHYSICALADDR)) {
-		status = pte_update(dev_context, ul_mpu_addr, virt_addr,
+		status = pte_update(dev_ctxt, ul_mpu_addr, virt_addr,
 				    ul_num_bytes, &hw_attrs);
 		goto func_cont;
 	}
@@ -1625,7 +1611,7 @@ static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
 					bad_page_dump(pa, pg);
 				}
 			}
-			status = pte_set(dev_context->pt_attrs, pa,
+			status = pte_set(dev_ctxt->pt_attrs, pa,
 					 va, HW_PAGE_SIZE4KB, &hw_attrs);
 			if (status)
 				break;
@@ -1650,7 +1636,7 @@ static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
 					bad_page_dump(page_to_phys(mapped_page),
 						      mapped_page);
 				}
-				status = pte_set(dev_context->pt_attrs,
+				status = pte_set(dev_ctxt->pt_attrs,
 						 page_to_phys(mapped_page), va,
 						 HW_PAGE_SIZE4KB, &hw_attrs);
 				if (status)
@@ -1682,7 +1668,7 @@ func_cont:
 		 * mapping
 		 */
 		if (pg_i) {
-			bridge_brd_mem_un_map(dev_context, virt_addr,
+			bridge_brd_mem_un_map(dev_ctxt, virt_addr,
 					   (pg_i * PG_SIZE4K));
 		}
 		status = -EPERM;
@@ -1693,7 +1679,7 @@ func_cont:
 	 * repetition while mapping non-contiguous physical regions of a virtual
 	 * region
 	 */
-	flush_all(dev_context);
+	flush_all(dev_ctxt);
 	dev_dbg(bridge, "%s status %x\n", __func__, status);
 	return status;
 }
-- 
1.7.8.6

