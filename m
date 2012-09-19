From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 06/15] tidspbridge: tiomap3430: Remove ul_ prefix
Date: Wed, 19 Sep 2012 14:06:54 +0200
Message-ID: <1348056423-25573-7-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:35804 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756228Ab2ISMGi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 08:06:38 -0400
In-Reply-To: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>

There's no need to prefix all u32 variables with ul_.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/staging/tidspbridge/core/tiomap3430.c |  183 ++++++++++++-------------
 1 files changed, 87 insertions(+), 96 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/tiomap3430.c b/drivers/staging/tidspbridge/core/tiomap3430.c
index a01e9c5e..3dfb663 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430.c
@@ -172,7 +172,7 @@ static int bridge_brd_monitor(struct bridge_dev_context *dev_ctxt)
  */
 static int bridge_brd_read(struct bridge_dev_context *dev_ctxt,
 				  u8 *host_buff, u32 dsp_addr,
-				  u32 ul_num_bytes, u32 mem_type)
+				  u32 num_bytes, u32 mem_type)
 {
 	int status = 0;
 	u32 offset;
@@ -188,11 +188,11 @@ static int bridge_brd_read(struct bridge_dev_context *dev_ctxt,
 		offset = dsp_addr - dev_ctxt->dsp_start_add;
 	} else {
 		status = read_ext_dsp_data(dev_ctxt, host_buff, dsp_addr,
-					   ul_num_bytes, mem_type);
+					   num_bytes, mem_type);
 		return status;
 	}
 	/* copy the data from  DSP memory, */
-	memcpy(host_buff, (void *)(dsp_base_addr + offset), ul_num_bytes);
+	memcpy(host_buff, (void *)(dsp_base_addr + offset), num_bytes);
 	return status;
 }
 
@@ -202,7 +202,7 @@ static int bridge_brd_read(struct bridge_dev_context *dev_ctxt,
  */
 static int bridge_brd_write(struct bridge_dev_context *dev_ctxt,
 				   u8 *host_buff, u32 dsp_addr,
-				   u32 ul_num_bytes, u32 mem_type)
+				   u32 num_bytes, u32 mem_type)
 {
 	int status = 0;
 
@@ -213,10 +213,10 @@ static int bridge_brd_write(struct bridge_dev_context *dev_ctxt,
 	if ((dsp_addr - dev_ctxt->dsp_start_add) <
 	    dev_ctxt->internal_size) {
 		status = write_dsp_data(dev_ctxt, host_buff, dsp_addr,
-					ul_num_bytes, mem_type);
+					num_bytes, mem_type);
 	} else {
 		status = write_ext_dsp_data(dev_ctxt, host_buff, dsp_addr,
-					    ul_num_bytes, mem_type, false);
+					    num_bytes, mem_type, false);
 	}
 
 	return status;
@@ -271,21 +271,21 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 {
 	int status = 0;
 	u32 dw_sync_addr = 0;
-	u32 ul_shm_base;	/* Gpp Phys SM base addr(byte) */
-	u32 ul_shm_base_virt;	/* Dsp Virt SM base addr */
-	u32 ul_tlb_base_virt;	/* Base of MMU TLB entry */
+	u32 shm_base;		/* Gpp Phys SM base addr(byte) */
+	u32 shm_base_virt;	/* Dsp Virt SM base addr */
+	u32 tlb_base_virt;	/* Base of MMU TLB entry */
 	/* Offset of shm_base_virt from tlb_base_virt */
-	u32 ul_shm_offset_virt;
+	u32 shm_offset_virt;
 	s32 entry_ndx;
 	s32 itmp_entry_ndx = 0;	/* DSP-MMU TLB entry base address */
 	struct cfg_hostres *resources = NULL;
 	u32 temp;
-	u32 ul_dsp_clk_rate;
-	u32 ul_dsp_clk_addr;
-	u32 ul_bios_gp_timer;
+	u32 dsp_clk_rate;
+	u32 dsp_clk_addr;
+	u32 bios_gp_timer;
 	u32 clk_cmd;
 	struct io_mgr *hio_mgr;
-	u32 ul_load_monitor_timer;
+	u32 load_monitor_timer;
 	u32 wdt_en = 0;
 	struct omap_dsp_platform_data *pdata =
 		omap_dspbridge_dev->dev.platform_data;
@@ -294,21 +294,19 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 	 * last dsp base image was loaded. The first entry is always
 	 * SHMMEM base. */
 	/* Get SHM_BEG - convert to byte address */
-	(void)dev_get_symbol(dev_ctxt->dev_obj, SHMBASENAME,
-			     &ul_shm_base_virt);
-	ul_shm_base_virt *= DSPWORDSIZE;
+	(void)dev_get_symbol(dev_ctxt->dev_obj, SHMBASENAME, &shm_base_virt);
+	shm_base_virt *= DSPWORDSIZE;
 	/* DSP Virtual address */
-	ul_tlb_base_virt = dev_ctxt->atlb_entry[0].dsp_va;
-	ul_shm_offset_virt =
-	    ul_shm_base_virt - (ul_tlb_base_virt * DSPWORDSIZE);
+	tlb_base_virt = dev_ctxt->atlb_entry[0].dsp_va;
+	shm_offset_virt = shm_base_virt - (tlb_base_virt * DSPWORDSIZE);
 	/* Kernel logical address */
-	ul_shm_base = dev_ctxt->atlb_entry[0].gpp_va + ul_shm_offset_virt;
+	shm_base = dev_ctxt->atlb_entry[0].gpp_va + shm_offset_virt;
 
 	/* 2nd wd is used as sync field */
-	dw_sync_addr = ul_shm_base + SHMSYNCOFFSET;
+	dw_sync_addr = shm_base + SHMSYNCOFFSET;
 	/* Write a signature into the shm base + offset; this will
 	 * get cleared when the DSP program starts. */
-	if ((ul_shm_base_virt == 0) || (ul_shm_base == 0)) {
+	if ((shm_base_virt == 0) || (shm_base == 0)) {
 		pr_err("%s: Illegal SM base\n", __func__);
 		status = -EPERM;
 	} else
@@ -409,16 +407,16 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 
 		/* Enable the BIOS clock */
 		(void)dev_get_symbol(dev_ctxt->dev_obj,
-				     BRIDGEINIT_BIOSGPTIMER, &ul_bios_gp_timer);
+				     BRIDGEINIT_BIOSGPTIMER, &bios_gp_timer);
 		(void)dev_get_symbol(dev_ctxt->dev_obj,
 				     BRIDGEINIT_LOADMON_GPTIMER,
-				     &ul_load_monitor_timer);
+				     &load_monitor_timer);
 	}
 
 	if (!status) {
-		if (ul_load_monitor_timer != 0xFFFF) {
+		if (load_monitor_timer != 0xFFFF) {
 			clk_cmd = (BPWR_ENABLE_CLOCK << MBX_PM_CLK_CMDSHIFT) |
-			    ul_load_monitor_timer;
+			    load_monitor_timer;
 			dsp_peripheral_clk_ctrl(dev_ctxt, &clk_cmd);
 		} else {
 			dev_dbg(bridge, "Not able to get the symbol for Load "
@@ -427,9 +425,9 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 	}
 
 	if (!status) {
-		if (ul_bios_gp_timer != 0xFFFF) {
+		if (bios_gp_timer != 0xFFFF) {
 			clk_cmd = (BPWR_ENABLE_CLOCK << MBX_PM_CLK_CMDSHIFT) |
-			    ul_bios_gp_timer;
+			    bios_gp_timer;
 			dsp_peripheral_clk_ctrl(dev_ctxt, &clk_cmd);
 		} else {
 			dev_dbg(bridge,
@@ -440,19 +438,18 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 	if (!status) {
 		/* Set the DSP clock rate */
 		(void)dev_get_symbol(dev_ctxt->dev_obj,
-				     "_BRIDGEINIT_DSP_FREQ", &ul_dsp_clk_addr);
+				     "_BRIDGEINIT_DSP_FREQ", &dsp_clk_addr);
 		/*Set Autoidle Mode for IVA2 PLL */
 		(*pdata->dsp_cm_write)(1 << OMAP3430_AUTO_IVA2_DPLL_SHIFT,
 				OMAP3430_IVA2_MOD, OMAP3430_CM_AUTOIDLE_PLL);
 
-		if ((unsigned int *)ul_dsp_clk_addr != NULL) {
+		if ((unsigned int *)dsp_clk_addr != NULL) {
 			/* Get the clock rate */
-			ul_dsp_clk_rate = dsp_clk_get_iva2_rate();
+			dsp_clk_rate = dsp_clk_get_iva2_rate();
 			dev_dbg(bridge, "%s: DSP clock rate (KHZ): 0x%x \n",
-				__func__, ul_dsp_clk_rate);
-			(void)bridge_brd_write(dev_ctxt,
-					       (u8 *) &ul_dsp_clk_rate,
-					       ul_dsp_clk_addr, sizeof(u32), 0);
+				__func__, dsp_clk_rate);
+			(void)bridge_brd_write(dev_ctxt, (u8 *) &dsp_clk_rate,
+					       dsp_clk_addr, sizeof(u32), 0);
 		}
 		/*
 		 * Enable Mailbox events and also drain any pending
@@ -509,7 +506,7 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 		dev_get_symbol(dev_ctxt->dev_obj, "_WDT_enable", &wdt_en);
 		if (wdt_en) {
 			/* Start wdt */
-			dsp_wdt_sm_set((void *)ul_shm_base);
+			dsp_wdt_sm_set((void *)shm_base);
 			dsp_wdt_enable(true);
 		}
 
@@ -927,13 +924,13 @@ static int bridge_dev_destroy(struct bridge_dev_context *dev_ctxt)
 
 static int bridge_brd_mem_copy(struct bridge_dev_context *dev_ctxt,
 				   u32 dsp_dest_addr, u32 dsp_src_addr,
-				   u32 ul_num_bytes, u32 mem_type)
+				   u32 num_bytes, u32 mem_type)
 {
 	int status = 0;
 	u32 src_addr = dsp_src_addr;
 	u32 dest_addr = dsp_dest_addr;
 	u32 copy_bytes = 0;
-	u32 total_bytes = ul_num_bytes;
+	u32 total_bytes = num_bytes;
 	u8 host_buf[BUFFERSIZE];
 	while (total_bytes > 0 && !status) {
 		copy_bytes =
@@ -966,28 +963,27 @@ static int bridge_brd_mem_copy(struct bridge_dev_context *dev_ctxt,
 /* Mem Write does not halt the DSP to write unlike bridge_brd_write */
 static int bridge_brd_mem_write(struct bridge_dev_context *dev_ctxt,
 				    u8 *host_buff, u32 dsp_addr,
-				    u32 ul_num_bytes, u32 mem_type)
+				    u32 num_bytes, u32 mem_type)
 {
 	int status = 0;
-	u32 ul_remain_bytes = 0;
-	u32 ul_bytes = 0;
-	ul_remain_bytes = ul_num_bytes;
-	while (ul_remain_bytes > 0 && !status) {
-		ul_bytes =
-		    ul_remain_bytes > BUFFERSIZE ? BUFFERSIZE : ul_remain_bytes;
+	u32 remain_bytes = 0;
+	u32 bytes = 0;
+	remain_bytes = num_bytes;
+	while (remain_bytes > 0 && !status) {
+		bytes = remain_bytes > BUFFERSIZE ? BUFFERSIZE : remain_bytes;
 		if (dsp_addr < (dev_ctxt->dsp_start_add +
 				 dev_ctxt->internal_size)) {
 			status =
 			    write_dsp_data(dev_ctxt, host_buff, dsp_addr,
-					   ul_bytes, mem_type);
+					   bytes, mem_type);
 		} else {
 			status = write_ext_dsp_data(dev_ctxt, host_buff,
-						    dsp_addr, ul_bytes,
+						    dsp_addr, bytes,
 						    mem_type, true);
 		}
-		ul_remain_bytes -= ul_bytes;
-		dsp_addr += ul_bytes;
-		host_buff = host_buff + ul_bytes;
+		remain_bytes -= bytes;
+		dsp_addr += bytes;
+		host_buff = host_buff + bytes;
 	}
 	return status;
 }
@@ -1179,9 +1175,8 @@ static inline void flush_all(struct bridge_dev_context *dev_ctxt)
 
 /* Memory map kernel VA -- memory allocated with vmalloc */
 static int mem_map_vmalloc(struct bridge_dev_context *dev_ctxt,
-				  u32 ul_mpu_addr, u32 virt_addr,
-				  u32 ul_num_bytes,
-				  struct hw_mmu_map_attrs_t *hw_attrs)
+			   u32 mpu_addr, u32 virt_addr, u32 num_bytes,
+			   struct hw_mmu_map_attrs_t *hw_attrs)
 {
 	int status = 0;
 	struct page *page[1];
@@ -1200,9 +1195,9 @@ static int mem_map_vmalloc(struct bridge_dev_context *dev_ctxt,
 	 * Combine physically contiguous regions to reduce TLBs.
 	 * Pass the translated pa to pte_update.
 	 */
-	num_pages = ul_num_bytes / PAGE_SIZE;	/* PAGE_SIZE = OS page size */
+	num_pages = num_bytes / PAGE_SIZE;	/* PAGE_SIZE = OS page size */
 	i = 0;
-	va_curr = ul_mpu_addr;
+	va_curr = mpu_addr;
 	page[0] = vmalloc_to_page((void *)va_curr);
 	pa_next = page_to_phys(page[0]);
 	while (!status && (i < num_pages)) {
@@ -1239,7 +1234,7 @@ static int mem_map_vmalloc(struct bridge_dev_context *dev_ctxt,
 			pa += HW_PAGE_SIZE4KB;
 		}
 		status = pte_update(dev_ctxt, pa_curr, virt_addr +
-				    (va_curr - ul_mpu_addr), size_curr,
+				    (va_curr - mpu_addr), size_curr,
 				    hw_attrs);
 		va_curr += size_curr;
 	}
@@ -1300,7 +1295,7 @@ static void bridge_release_pages(u32 paddr, u32 pte_size, u32 num_bytes)
  *      we clear consecutive PTEs until we unmap all the bytes
  */
 static int bridge_brd_mem_un_map(struct bridge_dev_context *dev_ctxt,
-				     u32 virt_addr, u32 ul_num_bytes)
+				     u32 virt_addr, u32 num_bytes)
 {
 	u32 l1_base_va;
 	u32 l2_base_va;
@@ -1318,13 +1313,13 @@ static int bridge_brd_mem_un_map(struct bridge_dev_context *dev_ctxt,
 	struct pg_table_attrs *pt = dev_ctxt->pt_attrs;
 
 	va_curr = virt_addr;
-	rem_bytes = ul_num_bytes;
+	rem_bytes = num_bytes;
 	rem_bytes_l2 = 0;
 	l1_base_va = pt->l1_base_va;
 	pte_addr_l1 = hw_mmu_pte_addr_l1(l1_base_va, va_curr);
 	dev_dbg(bridge, "%s dev_ctxt %p, va %x, NumBytes %x l1_base_va %x, "
 		"pte_addr_l1 %x\n", __func__, dev_ctxt, virt_addr,
-		ul_num_bytes, l1_base_va, pte_addr_l1);
+		num_bytes, l1_base_va, pte_addr_l1);
 
 	while (rem_bytes && !status) {
 		u32 va_curr_orig = va_curr;
@@ -1376,7 +1371,7 @@ static int bridge_brd_mem_un_map(struct bridge_dev_context *dev_ctxt,
 			}
 
 			bridge_release_pages(pte_val & ~(pte_size - 1), pte_size,
-					     ul_num_bytes);
+					     num_bytes);
 
 			if (hw_mmu_pte_clear(pte_addr_l2, va_curr, pte_size)) {
 				status = -EPERM;
@@ -1420,7 +1415,7 @@ skip_coarse_page:
 		}
 
 		bridge_release_pages(pte_val & ~(pte_size - 1), pte_size,
-				     ul_num_bytes);
+				     num_bytes);
 
 		if (!hw_mmu_pte_clear(l1_base_va, va_curr, pte_size)) {
 			status = 0;
@@ -1454,9 +1449,8 @@ EXIT_LOOP:
  *  TODO: Disable MMU while updating the page tables (but that'll stall DSP)
  */
 static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
-				  u32 ul_mpu_addr, u32 virt_addr,
-				  u32 ul_num_bytes, u32 ul_map_attr,
-				  struct page **mapped_pages)
+			      u32 mpu_addr, u32 virt_addr, u32 num_bytes,
+			      u32 map_attr, struct page **mapped_pages)
 {
 	u32 attrs;
 	int status = 0;
@@ -1470,20 +1464,20 @@ static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
 	u32 va = virt_addr;
 	struct task_struct *curr_task = current;
 	u32 pg_i = 0;
-	u32 mpu_addr, pa;
+	u32 pa;
 
 	dev_dbg(bridge,
-		"%s hDevCtxt %p, pa %x, va %x, size %x, ul_map_attr %x\n",
-		__func__, dev_ctxt, ul_mpu_addr, virt_addr, ul_num_bytes,
-		ul_map_attr);
-	if (ul_num_bytes == 0)
+		"%s hDevCtxt %p, pa %x, va %x, size %x, map_attr %x\n",
+		__func__, dev_ctxt, mpu_addr, virt_addr, num_bytes,
+		map_attr);
+	if (num_bytes == 0)
 		return -EINVAL;
 
-	if (ul_map_attr & DSP_MAP_DIR_MASK) {
-		attrs = ul_map_attr;
+	if (map_attr & DSP_MAP_DIR_MASK) {
+		attrs = map_attr;
 	} else {
 		/* Assign default attributes */
-		attrs = ul_map_attr | (DSP_MAPVIRTUALADDR | DSP_MAPELEMSIZE16);
+		attrs = map_attr | (DSP_MAPVIRTUALADDR | DSP_MAPELEMSIZE16);
 	}
 	/* Take mapping properties */
 	if (attrs & DSP_MAPBIGENDIAN)
@@ -1521,8 +1515,8 @@ static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
 		hw_attrs.donotlockmpupage = 0;
 
 	if (attrs & DSP_MAPVMALLOCADDR) {
-		return mem_map_vmalloc(dev_ctxt, ul_mpu_addr, virt_addr,
-				       ul_num_bytes, &hw_attrs);
+		return mem_map_vmalloc(dev_ctxt, mpu_addr, virt_addr,
+				       num_bytes, &hw_attrs);
 	}
 	/*
 	 * Do OS-specific user-va to pa translation.
@@ -1530,50 +1524,47 @@ static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
 	 * Pass the translated pa to pte_update.
 	 */
 	if ((attrs & DSP_MAPPHYSICALADDR)) {
-		status = pte_update(dev_ctxt, ul_mpu_addr, virt_addr,
-				    ul_num_bytes, &hw_attrs);
+		status = pte_update(dev_ctxt, mpu_addr, virt_addr,
+				    num_bytes, &hw_attrs);
 		goto func_cont;
 	}
 
 	/*
-	 * Important Note: ul_mpu_addr is mapped from user application process
+	 * Important Note: mpu_addr is mapped from user application process
 	 * to current process - it must lie completely within the current
 	 * virtual memory address space in order to be of use to us here!
 	 */
 	down_read(&mm->mmap_sem);
-	vma = find_vma(mm, ul_mpu_addr);
+	vma = find_vma(mm, mpu_addr);
 	if (vma)
 		dev_dbg(bridge,
-			"VMAfor UserBuf: ul_mpu_addr=%x, ul_num_bytes=%x, "
-			"vm_start=%lx, vm_end=%lx, vm_flags=%lx\n", ul_mpu_addr,
-			ul_num_bytes, vma->vm_start, vma->vm_end,
-			vma->vm_flags);
+			"VMAfor UserBuf: mpu_addr=%x, num_bytes=%x, "
+			"vm_start=%lx, vm_end=%lx, vm_flags=%lx\n", mpu_addr,
+			num_bytes, vma->vm_start, vma->vm_end, vma->vm_flags);
 
 	/*
 	 * It is observed that under some circumstances, the user buffer is
 	 * spread across several VMAs. So loop through and check if the entire
 	 * user buffer is covered
 	 */
-	while ((vma) && (ul_mpu_addr + ul_num_bytes > vma->vm_end)) {
+	while ((vma) && (mpu_addr + num_bytes > vma->vm_end)) {
 		/* jump to the next VMA region */
 		vma = find_vma(mm, vma->vm_end + 1);
 		dev_dbg(bridge,
-			"VMA for UserBuf ul_mpu_addr=%x ul_num_bytes=%x, "
-			"vm_start=%lx, vm_end=%lx, vm_flags=%lx\n", ul_mpu_addr,
-			ul_num_bytes, vma->vm_start, vma->vm_end,
-			vma->vm_flags);
+			"VMA for UserBuf mpu_addr=%x num_bytes=%x, "
+			"vm_start=%lx, vm_end=%lx, vm_flags=%lx\n", mpu_addr,
+			num_bytes, vma->vm_start, vma->vm_end, vma->vm_flags);
 	}
 	if (!vma) {
 		pr_err("%s: Failed to get VMA region for 0x%x (%d)\n",
-		       __func__, ul_mpu_addr, ul_num_bytes);
+		       __func__, mpu_addr, num_bytes);
 		status = -EINVAL;
 		up_read(&mm->mmap_sem);
 		goto func_cont;
 	}
 
 	if (vma->vm_flags & VM_IO) {
-		num_usr_pgs = ul_num_bytes / PG_SIZE4K;
-		mpu_addr = ul_mpu_addr;
+		num_usr_pgs = num_bytes / PG_SIZE4K;
 
 		/* Get the physical addresses for user buffer */
 		for (pg_i = 0; pg_i < num_usr_pgs; pg_i++) {
@@ -1602,12 +1593,12 @@ static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
 			pa += HW_PAGE_SIZE4KB;
 		}
 	} else {
-		num_usr_pgs = ul_num_bytes / PG_SIZE4K;
+		num_usr_pgs = num_bytes / PG_SIZE4K;
 		if (vma->vm_flags & (VM_WRITE | VM_MAYWRITE))
 			write = 1;
 
 		for (pg_i = 0; pg_i < num_usr_pgs; pg_i++) {
-			pg_num = get_user_pages(curr_task, mm, ul_mpu_addr, 1,
+			pg_num = get_user_pages(curr_task, mm, mpu_addr, 1,
 						write, 1, &mapped_page, NULL);
 			if (pg_num > 0) {
 				if (page_count(mapped_page) < 1) {
@@ -1627,15 +1618,15 @@ static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
 					mapped_pages[pg_i] = mapped_page;
 
 				va += HW_PAGE_SIZE4KB;
-				ul_mpu_addr += HW_PAGE_SIZE4KB;
+				mpu_addr += HW_PAGE_SIZE4KB;
 			} else {
 				pr_err("DSPBRIDGE: get_user_pages FAILED,"
 				       "MPU addr = 0x%x,"
 				       "vma->vm_flags = 0x%lx,"
 				       "get_user_pages Err"
 				       "Value = %d, Buffer"
-				       "size=0x%x\n", ul_mpu_addr,
-				       vma->vm_flags, pg_num, ul_num_bytes);
+				       "size=0x%x\n", mpu_addr,
+				       vma->vm_flags, pg_num, num_bytes);
 				status = -EPERM;
 				break;
 			}
-- 
1.7.8.6

