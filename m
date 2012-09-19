From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 03/15] tidspbridge: tiomap3430: Reorder functions to avoid forward declarations
Date: Wed, 19 Sep 2012 14:06:51 +0200
Message-ID: <1348056423-25573-4-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:35805 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862Ab2ISMGd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 08:06:33 -0400
In-Reply-To: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/staging/tidspbridge/core/tiomap3430.c | 1123 ++++++++++++-------------
 1 files changed, 537 insertions(+), 586 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/tiomap3430.c b/drivers/staging/tidspbridge/core/tiomap3430.c
index f9609ce..fa5b7b9 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430.c
@@ -79,55 +79,6 @@
 #define OMAP343X_CONTROL_IVA2_BOOTADDR (OMAP2_CONTROL_GENERAL + 0x0190)
 #define OMAP343X_CONTROL_IVA2_BOOTMOD (OMAP2_CONTROL_GENERAL + 0x0194)
 
-/* Forward Declarations: */
-static int bridge_brd_monitor(struct bridge_dev_context *dev_ctxt);
-static int bridge_brd_read(struct bridge_dev_context *dev_ctxt,
-				  u8 *host_buff,
-				  u32 dsp_addr, u32 ul_num_bytes,
-				  u32 mem_type);
-static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
-				   u32 dsp_addr);
-static int bridge_brd_status(struct bridge_dev_context *dev_ctxt,
-				    int *board_state);
-static int bridge_brd_stop(struct bridge_dev_context *dev_ctxt);
-static int bridge_brd_write(struct bridge_dev_context *dev_ctxt,
-				   u8 *host_buff,
-				   u32 dsp_addr, u32 ul_num_bytes,
-				   u32 mem_type);
-static int bridge_brd_set_state(struct bridge_dev_context *dev_ctxt,
-				    u32 brd_state);
-static int bridge_brd_mem_copy(struct bridge_dev_context *dev_ctxt,
-				   u32 dsp_dest_addr, u32 dsp_src_addr,
-				   u32 ul_num_bytes, u32 mem_type);
-static int bridge_brd_mem_write(struct bridge_dev_context *dev_ctxt,
-				    u8 *host_buff, u32 dsp_addr,
-				    u32 ul_num_bytes, u32 mem_type);
-static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
-				  u32 ul_mpu_addr, u32 virt_addr,
-				  u32 ul_num_bytes, u32 ul_map_attr,
-				  struct page **mapped_pages);
-static int bridge_brd_mem_un_map(struct bridge_dev_context *dev_ctxt,
-				     u32 virt_addr, u32 ul_num_bytes);
-static int bridge_dev_create(struct bridge_dev_context
-					**dev_cntxt,
-					struct dev_object *hdev_obj,
-					struct cfg_hostres *config_param);
-static int bridge_dev_ctrl(struct bridge_dev_context *dev_context,
-				  u32 dw_cmd, void *pargs);
-static int bridge_dev_destroy(struct bridge_dev_context *dev_ctxt);
-static u32 user_va2_pa(struct mm_struct *mm, u32 address);
-static int pte_update(struct bridge_dev_context *dev_ctxt, u32 pa,
-			     u32 va, u32 size,
-			     struct hw_mmu_map_attrs_t *map_attrs);
-static int pte_set(struct pg_table_attrs *pt, u32 pa, u32 va,
-			  u32 size, struct hw_mmu_map_attrs_t *attrs);
-static int mem_map_vmalloc(struct bridge_dev_context *dev_context,
-				  u32 ul_mpu_addr, u32 virt_addr,
-				  u32 ul_num_bytes,
-				  struct hw_mmu_map_attrs_t *hw_attrs);
-
-bool wait_for_start(struct bridge_dev_context *dev_context, u32 dw_sync_addr);
-
 /*  ----------------------------------- Globals */
 
 /* Attributes of L2 page tables for DSP MMU */
@@ -166,96 +117,10 @@ struct pg_table_attrs {
 	struct page_info *pg_info;
 };
 
-/*
- *  This Bridge driver's function interface table.
- */
-static struct bridge_drv_interface drv_interface_fxns = {
-	/* Bridge API ver. for which this bridge driver is built. */
-	BRD_API_MAJOR_VERSION,
-	BRD_API_MINOR_VERSION,
-	bridge_dev_create,
-	bridge_dev_destroy,
-	bridge_dev_ctrl,
-	bridge_brd_monitor,
-	bridge_brd_start,
-	bridge_brd_stop,
-	bridge_brd_status,
-	bridge_brd_read,
-	bridge_brd_write,
-	bridge_brd_set_state,
-	bridge_brd_mem_copy,
-	bridge_brd_mem_write,
-	bridge_brd_mem_map,
-	bridge_brd_mem_un_map,
-	/* The following CHNL functions are provided by chnl_io.lib: */
-	bridge_chnl_create,
-	bridge_chnl_destroy,
-	bridge_chnl_open,
-	bridge_chnl_close,
-	bridge_chnl_add_io_req,
-	bridge_chnl_get_ioc,
-	bridge_chnl_cancel_io,
-	bridge_chnl_flush_io,
-	bridge_chnl_get_info,
-	bridge_chnl_get_mgr_info,
-	bridge_chnl_idle,
-	bridge_chnl_register_notify,
-	/* The following IO functions are provided by chnl_io.lib: */
-	bridge_io_create,
-	bridge_io_destroy,
-	bridge_io_on_loaded,
-	bridge_io_get_proc_load,
-	/* The following msg_ctrl functions are provided by chnl_io.lib: */
-	bridge_msg_create,
-	bridge_msg_create_queue,
-	bridge_msg_delete,
-	bridge_msg_delete_queue,
-	bridge_msg_get,
-	bridge_msg_put,
-	bridge_msg_register_notify,
-	bridge_msg_set_queue_id,
-};
-
 static struct notifier_block dsp_mbox_notifier = {
 	.notifier_call = io_mbox_msg,
 };
 
-static inline void flush_all(struct bridge_dev_context *dev_context)
-{
-	if (dev_context->brd_state == BRD_DSP_HIBERNATION ||
-	    dev_context->brd_state == BRD_HIBERNATION)
-		wake_dsp(dev_context, NULL);
-
-	hw_mmu_tlb_flush_all(dev_context->dsp_mmu_base);
-}
-
-static void bad_page_dump(u32 pa, struct page *pg)
-{
-	pr_emerg("DSPBRIDGE: MAP function: COUNT 0 FOR PA 0x%x\n", pa);
-	pr_emerg("Bad page state in process '%s'\n"
-		 "page:%p flags:0x%0*lx mapping:%p mapcount:%d count:%d\n"
-		 "Backtrace:\n",
-		 current->comm, pg, (int)(2 * sizeof(unsigned long)),
-		 (unsigned long)pg->flags, pg->mapping,
-		 page_mapcount(pg), page_count(pg));
-	dump_stack();
-}
-
-/*
- *  ======== bridge_drv_entry ========
- *  purpose:
- *      Bridge Driver entry point.
- */
-void bridge_drv_entry(struct bridge_drv_interface **drv_intf,
-		   const char *driver_file_name)
-{
-	if (strcmp(driver_file_name, "UMA") == 0)
-		*drv_intf = &drv_interface_fxns;
-	else
-		dev_dbg(bridge, "%s Unknown Bridge file name", __func__);
-
-}
-
 /*
  *  ======== bridge_brd_monitor ========
  *  purpose:
@@ -334,6 +199,33 @@ static int bridge_brd_read(struct bridge_dev_context *dev_ctxt,
 }
 
 /*
+ *  ======== bridge_brd_write ========
+ *      Copies the buffers to DSP internal or external memory.
+ */
+static int bridge_brd_write(struct bridge_dev_context *dev_ctxt,
+				   u8 *host_buff, u32 dsp_addr,
+				   u32 ul_num_bytes, u32 mem_type)
+{
+	int status = 0;
+	struct bridge_dev_context *dev_context = dev_ctxt;
+
+	if (dsp_addr < dev_context->dsp_start_add) {
+		status = -EPERM;
+		return status;
+	}
+	if ((dsp_addr - dev_context->dsp_start_add) <
+	    dev_context->internal_size) {
+		status = write_dsp_data(dev_ctxt, host_buff, dsp_addr,
+					ul_num_bytes, mem_type);
+	} else {
+		status = write_ext_dsp_data(dev_context, host_buff, dsp_addr,
+					    ul_num_bytes, mem_type, false);
+	}
+
+	return status;
+}
+
+/*
  *  ======== bridge_brd_set_state ========
  *  purpose:
  *      This routine updates the Board status.
@@ -349,6 +241,26 @@ static int bridge_brd_set_state(struct bridge_dev_context *dev_ctxt,
 }
 
 /*
+ *  ======== wait_for_start ========
+ *      Wait for the singal from DSP that it has started, or time out.
+ */
+bool wait_for_start(struct bridge_dev_context *dev_context, u32 dw_sync_addr)
+{
+	u16 timeout = TIHELEN_ACKTIMEOUT;
+
+	/*  Wait for response from board */
+	while (__raw_readw(dw_sync_addr) && --timeout)
+		udelay(10);
+
+	/*  If timed out: return false */
+	if (!timeout) {
+		pr_err("%s: Timed out waiting DSP to Start\n", __func__);
+		return false;
+	}
+	return true;
+}
+
+/*
  *  ======== bridge_brd_start ========
  *  purpose:
  *      Initializes DSP MMU and Starts DSP.
@@ -710,33 +622,6 @@ static int bridge_brd_status(struct bridge_dev_context *dev_ctxt,
 }
 
 /*
- *  ======== bridge_brd_write ========
- *      Copies the buffers to DSP internal or external memory.
- */
-static int bridge_brd_write(struct bridge_dev_context *dev_ctxt,
-				   u8 *host_buff, u32 dsp_addr,
-				   u32 ul_num_bytes, u32 mem_type)
-{
-	int status = 0;
-	struct bridge_dev_context *dev_context = dev_ctxt;
-
-	if (dsp_addr < dev_context->dsp_start_add) {
-		status = -EPERM;
-		return status;
-	}
-	if ((dsp_addr - dev_context->dsp_start_add) <
-	    dev_context->internal_size) {
-		status = write_dsp_data(dev_ctxt, host_buff, dsp_addr,
-					ul_num_bytes, mem_type);
-	} else {
-		status = write_ext_dsp_data(dev_context, host_buff, dsp_addr,
-					    ul_num_bytes, mem_type, false);
-	}
-
-	return status;
-}
-
-/*
  *  ======== bridge_dev_create ========
  *      Creates a driver object. Puts DSP in self loop.
  */
@@ -1119,215 +1004,256 @@ static int bridge_brd_mem_write(struct bridge_dev_context *dev_ctxt,
 }
 
 /*
- *  ======== bridge_brd_mem_map ========
- *      This function maps MPU buffer to the DSP address space. It performs
- *  linear to physical address translation if required. It translates each
- *  page since linear addresses can be physically non-contiguous
- *  All address & size arguments are assumed to be page aligned (in proc.c)
- *
- *  TODO: Disable MMU while updating the page tables (but that'll stall DSP)
+ *  ======== pte_set ========
+ *      This function calculates PTE address (MPU virtual) to be updated
+ *      It also manages the L2 page tables
  */
-static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
-				  u32 ul_mpu_addr, u32 virt_addr,
-				  u32 ul_num_bytes, u32 ul_map_attr,
-				  struct page **mapped_pages)
+static int pte_set(struct pg_table_attrs *pt, u32 pa, u32 va,
+			  u32 size, struct hw_mmu_map_attrs_t *attrs)
 {
-	u32 attrs;
+	u32 i;
+	u32 pte_val;
+	u32 pte_addr_l1;
+	u32 pte_size;
+	/* Base address of the PT that will be updated */
+	u32 pg_tbl_va;
+	u32 l1_base_va;
+	/* Compiler warns that the next three variables might be used
+	 * uninitialized in this function. Doesn't seem so. Working around,
+	 * anyways. */
+	u32 l2_base_va = 0;
+	u32 l2_base_pa = 0;
+	u32 l2_page_num = 0;
 	int status = 0;
-	struct bridge_dev_context *dev_context = dev_ctxt;
-	struct hw_mmu_map_attrs_t hw_attrs;
-	struct vm_area_struct *vma;
-	struct mm_struct *mm = current->mm;
-	u32 write = 0;
-	u32 num_usr_pgs = 0;
-	struct page *mapped_page, *pg;
-	s32 pg_num;
-	u32 va = virt_addr;
-	struct task_struct *curr_task = current;
-	u32 pg_i = 0;
-	u32 mpu_addr, pa;
-
-	dev_dbg(bridge,
-		"%s hDevCtxt %p, pa %x, va %x, size %x, ul_map_attr %x\n",
-		__func__, dev_ctxt, ul_mpu_addr, virt_addr, ul_num_bytes,
-		ul_map_attr);
-	if (ul_num_bytes == 0)
-		return -EINVAL;
-
-	if (ul_map_attr & DSP_MAP_DIR_MASK) {
-		attrs = ul_map_attr;
-	} else {
-		/* Assign default attributes */
-		attrs = ul_map_attr | (DSP_MAPVIRTUALADDR | DSP_MAPELEMSIZE16);
-	}
-	/* Take mapping properties */
-	if (attrs & DSP_MAPBIGENDIAN)
-		hw_attrs.endianism = HW_BIG_ENDIAN;
-	else
-		hw_attrs.endianism = HW_LITTLE_ENDIAN;
 
-	hw_attrs.mixed_size = (enum hw_mmu_mixed_size_t)
-	    ((attrs & DSP_MAPMIXEDELEMSIZE) >> 2);
-	/* Ignore element_size if mixed_size is enabled */
-	if (hw_attrs.mixed_size == 0) {
-		if (attrs & DSP_MAPELEMSIZE8) {
-			/* Size is 8 bit */
-			hw_attrs.element_size = HW_ELEM_SIZE8BIT;
-		} else if (attrs & DSP_MAPELEMSIZE16) {
-			/* Size is 16 bit */
-			hw_attrs.element_size = HW_ELEM_SIZE16BIT;
-		} else if (attrs & DSP_MAPELEMSIZE32) {
-			/* Size is 32 bit */
-			hw_attrs.element_size = HW_ELEM_SIZE32BIT;
-		} else if (attrs & DSP_MAPELEMSIZE64) {
-			/* Size is 64 bit */
-			hw_attrs.element_size = HW_ELEM_SIZE64BIT;
+	l1_base_va = pt->l1_base_va;
+	pg_tbl_va = l1_base_va;
+	if ((size == HW_PAGE_SIZE64KB) || (size == HW_PAGE_SIZE4KB)) {
+		/* Find whether the L1 PTE points to a valid L2 PT */
+		pte_addr_l1 = hw_mmu_pte_addr_l1(l1_base_va, va);
+		if (pte_addr_l1 <= (pt->l1_base_va + pt->l1_size)) {
+			pte_val = *(u32 *) pte_addr_l1;
+			pte_size = hw_mmu_pte_size_l1(pte_val);
 		} else {
-			/*
-			 * Mixedsize isn't enabled, so size can't be
-			 * zero here
-			 */
-			return -EINVAL;
+			return -EPERM;
 		}
+		spin_lock(&pt->pg_lock);
+		if (pte_size == HW_MMU_COARSE_PAGE_SIZE) {
+			/* Get the L2 PA from the L1 PTE, and find
+			 * corresponding L2 VA */
+			l2_base_pa = hw_mmu_pte_coarse_l1(pte_val);
+			l2_base_va =
+			    l2_base_pa - pt->l2_base_pa + pt->l2_base_va;
+			l2_page_num =
+			    (l2_base_pa -
+			     pt->l2_base_pa) / HW_MMU_COARSE_PAGE_SIZE;
+		} else if (pte_size == 0) {
+			/* L1 PTE is invalid. Allocate a L2 PT and
+			 * point the L1 PTE to it */
+			/* Find a free L2 PT. */
+			for (i = 0; (i < pt->l2_num_pages) &&
+			     (pt->pg_info[i].num_entries != 0); i++)
+				;
+			if (i < pt->l2_num_pages) {
+				l2_page_num = i;
+				l2_base_pa = pt->l2_base_pa + (l2_page_num *
+						HW_MMU_COARSE_PAGE_SIZE);
+				l2_base_va = pt->l2_base_va + (l2_page_num *
+						HW_MMU_COARSE_PAGE_SIZE);
+				/* Endianness attributes are ignored for
+				 * HW_MMU_COARSE_PAGE_SIZE */
+				status =
+				    hw_mmu_pte_set(l1_base_va, l2_base_pa, va,
+						   HW_MMU_COARSE_PAGE_SIZE,
+						   attrs);
+			} else {
+				status = -ENOMEM;
+			}
+		} else {
+			/* Found valid L1 PTE of another size.
+			 * Should not overwrite it. */
+			status = -EPERM;
+		}
+		if (!status) {
+			pg_tbl_va = l2_base_va;
+			if (size == HW_PAGE_SIZE64KB)
+				pt->pg_info[l2_page_num].num_entries += 16;
+			else
+				pt->pg_info[l2_page_num].num_entries++;
+			dev_dbg(bridge, "PTE: L2 BaseVa %x, BasePa %x, PageNum "
+				"%x, num_entries %x\n", l2_base_va,
+				l2_base_pa, l2_page_num,
+				pt->pg_info[l2_page_num].num_entries);
+		}
+		spin_unlock(&pt->pg_lock);
 	}
-	if (attrs & DSP_MAPDONOTLOCK)
-		hw_attrs.donotlockmpupage = 1;
-	else
-		hw_attrs.donotlockmpupage = 0;
-
-	if (attrs & DSP_MAPVMALLOCADDR) {
-		return mem_map_vmalloc(dev_ctxt, ul_mpu_addr, virt_addr,
-				       ul_num_bytes, &hw_attrs);
-	}
-	/*
-	 * Do OS-specific user-va to pa translation.
-	 * Combine physically contiguous regions to reduce TLBs.
-	 * Pass the translated pa to pte_update.
-	 */
-	if ((attrs & DSP_MAPPHYSICALADDR)) {
-		status = pte_update(dev_context, ul_mpu_addr, virt_addr,
-				    ul_num_bytes, &hw_attrs);
-		goto func_cont;
+	if (!status) {
+		dev_dbg(bridge, "PTE: pg_tbl_va %x, pa %x, va %x, size %x\n",
+			pg_tbl_va, pa, va, size);
+		dev_dbg(bridge, "PTE: endianism %x, element_size %x, "
+			"mixed_size %x\n", attrs->endianism,
+			attrs->element_size, attrs->mixed_size);
+		status = hw_mmu_pte_set(pg_tbl_va, pa, va, size, attrs);
 	}
 
-	/*
-	 * Important Note: ul_mpu_addr is mapped from user application process
-	 * to current process - it must lie completely within the current
-	 * virtual memory address space in order to be of use to us here!
-	 */
-	down_read(&mm->mmap_sem);
-	vma = find_vma(mm, ul_mpu_addr);
-	if (vma)
-		dev_dbg(bridge,
-			"VMAfor UserBuf: ul_mpu_addr=%x, ul_num_bytes=%x, "
-			"vm_start=%lx, vm_end=%lx, vm_flags=%lx\n", ul_mpu_addr,
-			ul_num_bytes, vma->vm_start, vma->vm_end,
-			vma->vm_flags);
+	return status;
+}
 
-	/*
-	 * It is observed that under some circumstances, the user buffer is
-	 * spread across several VMAs. So loop through and check if the entire
-	 * user buffer is covered
-	 */
-	while ((vma) && (ul_mpu_addr + ul_num_bytes > vma->vm_end)) {
-		/* jump to the next VMA region */
-		vma = find_vma(mm, vma->vm_end + 1);
-		dev_dbg(bridge,
-			"VMA for UserBuf ul_mpu_addr=%x ul_num_bytes=%x, "
-			"vm_start=%lx, vm_end=%lx, vm_flags=%lx\n", ul_mpu_addr,
-			ul_num_bytes, vma->vm_start, vma->vm_end,
-			vma->vm_flags);
-	}
-	if (!vma) {
-		pr_err("%s: Failed to get VMA region for 0x%x (%d)\n",
-		       __func__, ul_mpu_addr, ul_num_bytes);
-		status = -EINVAL;
-		up_read(&mm->mmap_sem);
-		goto func_cont;
-	}
+/*
+ *  ======== pte_update ========
+ *      This function calculates the optimum page-aligned addresses and sizes
+ *      Caller must pass page-aligned values
+ */
+static int pte_update(struct bridge_dev_context *dev_ctxt, u32 pa,
+			     u32 va, u32 size,
+			     struct hw_mmu_map_attrs_t *map_attrs)
+{
+	u32 i;
+	u32 all_bits;
+	u32 pa_curr = pa;
+	u32 va_curr = va;
+	u32 num_bytes = size;
+	struct bridge_dev_context *dev_context = dev_ctxt;
+	int status = 0;
+	u32 page_size[] = { HW_PAGE_SIZE16MB, HW_PAGE_SIZE1MB,
+		HW_PAGE_SIZE64KB, HW_PAGE_SIZE4KB
+	};
 
-	if (vma->vm_flags & VM_IO) {
-		num_usr_pgs = ul_num_bytes / PG_SIZE4K;
-		mpu_addr = ul_mpu_addr;
+	while (num_bytes && !status) {
+		/* To find the max. page size with which both PA & VA are
+		 * aligned */
+		all_bits = pa_curr | va_curr;
 
-		/* Get the physical addresses for user buffer */
-		for (pg_i = 0; pg_i < num_usr_pgs; pg_i++) {
-			pa = user_va2_pa(mm, mpu_addr);
-			if (!pa) {
-				status = -EPERM;
-				pr_err("DSPBRIDGE: VM_IO mapping physical"
-				       "address is invalid\n");
+		for (i = 0; i < 4; i++) {
+			if ((num_bytes >= page_size[i]) && ((all_bits &
+							     (page_size[i] -
+							      1)) == 0)) {
+				status =
+				    pte_set(dev_context->pt_attrs, pa_curr,
+					    va_curr, page_size[i], map_attrs);
+				pa_curr += page_size[i];
+				va_curr += page_size[i];
+				num_bytes -= page_size[i];
+				/* Don't try smaller sizes. Hopefully we have
+				 * reached an address aligned to a bigger page
+				 * size */
 				break;
 			}
-			if (pfn_valid(__phys_to_pfn(pa))) {
-				pg = PHYS_TO_PAGE(pa);
-				get_page(pg);
-				if (page_count(pg) < 1) {
-					pr_err("Bad page in VM_IO buffer\n");
-					bad_page_dump(pa, pg);
-				}
-			}
-			status = pte_set(dev_context->pt_attrs, pa,
-					 va, HW_PAGE_SIZE4KB, &hw_attrs);
-			if (status)
-				break;
-
-			va += HW_PAGE_SIZE4KB;
-			mpu_addr += HW_PAGE_SIZE4KB;
-			pa += HW_PAGE_SIZE4KB;
 		}
-	} else {
-		num_usr_pgs = ul_num_bytes / PG_SIZE4K;
-		if (vma->vm_flags & (VM_WRITE | VM_MAYWRITE))
-			write = 1;
+	}
 
-		for (pg_i = 0; pg_i < num_usr_pgs; pg_i++) {
-			pg_num = get_user_pages(curr_task, mm, ul_mpu_addr, 1,
-						write, 1, &mapped_page, NULL);
-			if (pg_num > 0) {
-				if (page_count(mapped_page) < 1) {
-					pr_err("Bad page count after doing"
-					       "get_user_pages on"
-					       "user buffer\n");
-					bad_page_dump(page_to_phys(mapped_page),
-						      mapped_page);
-				}
-				status = pte_set(dev_context->pt_attrs,
-						 page_to_phys(mapped_page), va,
-						 HW_PAGE_SIZE4KB, &hw_attrs);
-				if (status)
-					break;
+	return status;
+}
 
-				if (mapped_pages)
-					mapped_pages[pg_i] = mapped_page;
+/*
+ *  ======== user_va2_pa ========
+ *  Purpose:
+ *      This function walks through the page tables to convert a userland
+ *      virtual address to physical address
+ */
+static u32 user_va2_pa(struct mm_struct *mm, u32 address)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *ptep, pte;
 
-				va += HW_PAGE_SIZE4KB;
-				ul_mpu_addr += HW_PAGE_SIZE4KB;
-			} else {
-				pr_err("DSPBRIDGE: get_user_pages FAILED,"
-				       "MPU addr = 0x%x,"
-				       "vma->vm_flags = 0x%lx,"
-				       "get_user_pages Err"
-				       "Value = %d, Buffer"
-				       "size=0x%x\n", ul_mpu_addr,
-				       vma->vm_flags, pg_num, ul_num_bytes);
-				status = -EPERM;
-				break;
-			}
-		}
+	pgd = pgd_offset(mm, address);
+	if (pgd_none(*pgd) || pgd_bad(*pgd))
+		return 0;
+
+	pud = pud_offset(pgd, address);
+	if (pud_none(*pud) || pud_bad(*pud))
+		return 0;
+
+	pmd = pmd_offset(pud, address);
+	if (pmd_none(*pmd) || pmd_bad(*pmd))
+		return 0;
+
+	ptep = pte_offset_map(pmd, address);
+	if (ptep) {
+		pte = *ptep;
+		if (pte_present(pte))
+			return pte & PAGE_MASK;
 	}
-	up_read(&mm->mmap_sem);
-func_cont:
-	if (status) {
+
+	return 0;
+}
+
+static inline void flush_all(struct bridge_dev_context *dev_context)
+{
+	if (dev_context->brd_state == BRD_DSP_HIBERNATION ||
+	    dev_context->brd_state == BRD_HIBERNATION)
+		wake_dsp(dev_context, NULL);
+
+	hw_mmu_tlb_flush_all(dev_context->dsp_mmu_base);
+}
+
+/* Memory map kernel VA -- memory allocated with vmalloc */
+static int mem_map_vmalloc(struct bridge_dev_context *dev_context,
+				  u32 ul_mpu_addr, u32 virt_addr,
+				  u32 ul_num_bytes,
+				  struct hw_mmu_map_attrs_t *hw_attrs)
+{
+	int status = 0;
+	struct page *page[1];
+	u32 i;
+	u32 pa_curr;
+	u32 pa_next;
+	u32 va_curr;
+	u32 size_curr;
+	u32 num_pages;
+	u32 pa;
+	u32 num_of4k_pages;
+	u32 temp = 0;
+
+	/*
+	 * Do Kernel va to pa translation.
+	 * Combine physically contiguous regions to reduce TLBs.
+	 * Pass the translated pa to pte_update.
+	 */
+	num_pages = ul_num_bytes / PAGE_SIZE;	/* PAGE_SIZE = OS page size */
+	i = 0;
+	va_curr = ul_mpu_addr;
+	page[0] = vmalloc_to_page((void *)va_curr);
+	pa_next = page_to_phys(page[0]);
+	while (!status && (i < num_pages)) {
 		/*
-		 * Roll out the mapped pages incase it failed in middle of
-		 * mapping
+		 * Reuse pa_next from the previous iteraion to avoid
+		 * an extra va2pa call
 		 */
-		if (pg_i) {
-			bridge_brd_mem_un_map(dev_context, virt_addr,
-					   (pg_i * PG_SIZE4K));
+		pa_curr = pa_next;
+		size_curr = PAGE_SIZE;
+		/*
+		 * If the next page is physically contiguous,
+		 * map it with the current one by increasing
+		 * the size of the region to be mapped
+		 */
+		while (++i < num_pages) {
+			page[0] =
+			    vmalloc_to_page((void *)(va_curr + size_curr));
+			pa_next = page_to_phys(page[0]);
+
+			if (pa_next == (pa_curr + size_curr))
+				size_curr += PAGE_SIZE;
+			else
+				break;
+
+		}
+		if (pa_next == 0) {
+			status = -ENOMEM;
+			break;
 		}
-		status = -EPERM;
+		pa = pa_curr;
+		num_of4k_pages = size_curr / HW_PAGE_SIZE4KB;
+		while (temp++ < num_of4k_pages) {
+			get_page(PHYS_TO_PAGE(pa));
+			pa += HW_PAGE_SIZE4KB;
+		}
+		status = pte_update(dev_context, pa_curr, virt_addr +
+				    (va_curr - ul_mpu_addr), size_curr,
+				    hw_attrs);
+		va_curr += size_curr;
 	}
 	/*
 	 * In any case, flush the TLB
@@ -1340,6 +1266,18 @@ func_cont:
 	return status;
 }
 
+static void bad_page_dump(u32 pa, struct page *pg)
+{
+	pr_emerg("DSPBRIDGE: MAP function: COUNT 0 FOR PA 0x%x\n", pa);
+	pr_emerg("Bad page state in process '%s'\n"
+		 "page:%p flags:0x%0*lx mapping:%p mapcount:%d count:%d\n"
+		 "Backtrace:\n",
+		 current->comm, pg, (int)(2 * sizeof(unsigned long)),
+		 (unsigned long)pg->flags, pg->mapping,
+		 page_mapcount(pg), page_count(pg));
+	dump_stack();
+}
+
 /*
  *  ======== bridge_brd_mem_un_map ========
  *      Invalidate the PTEs for the DSP VA block to be unmapped.
@@ -1539,247 +1477,215 @@ EXIT_LOOP:
 }
 
 /*
- *  ======== user_va2_pa ========
- *  Purpose:
- *      This function walks through the page tables to convert a userland
- *      virtual address to physical address
- */
-static u32 user_va2_pa(struct mm_struct *mm, u32 address)
-{
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *ptep, pte;
-
-	pgd = pgd_offset(mm, address);
-	if (pgd_none(*pgd) || pgd_bad(*pgd))
-		return 0;
-
-	pud = pud_offset(pgd, address);
-	if (pud_none(*pud) || pud_bad(*pud))
-		return 0;
-
-	pmd = pmd_offset(pud, address);
-	if (pmd_none(*pmd) || pmd_bad(*pmd))
-		return 0;
-
-	ptep = pte_offset_map(pmd, address);
-	if (ptep) {
-		pte = *ptep;
-		if (pte_present(pte))
-			return pte & PAGE_MASK;
-	}
-
-	return 0;
-}
-
-/*
- *  ======== pte_update ========
- *      This function calculates the optimum page-aligned addresses and sizes
- *      Caller must pass page-aligned values
+ *  ======== bridge_brd_mem_map ========
+ *      This function maps MPU buffer to the DSP address space. It performs
+ *  linear to physical address translation if required. It translates each
+ *  page since linear addresses can be physically non-contiguous
+ *  All address & size arguments are assumed to be page aligned (in proc.c)
+ *
+ *  TODO: Disable MMU while updating the page tables (but that'll stall DSP)
  */
-static int pte_update(struct bridge_dev_context *dev_ctxt, u32 pa,
-			     u32 va, u32 size,
-			     struct hw_mmu_map_attrs_t *map_attrs)
+static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
+				  u32 ul_mpu_addr, u32 virt_addr,
+				  u32 ul_num_bytes, u32 ul_map_attr,
+				  struct page **mapped_pages)
 {
-	u32 i;
-	u32 all_bits;
-	u32 pa_curr = pa;
-	u32 va_curr = va;
-	u32 num_bytes = size;
-	struct bridge_dev_context *dev_context = dev_ctxt;
+	u32 attrs;
 	int status = 0;
-	u32 page_size[] = { HW_PAGE_SIZE16MB, HW_PAGE_SIZE1MB,
-		HW_PAGE_SIZE64KB, HW_PAGE_SIZE4KB
-	};
-
-	while (num_bytes && !status) {
-		/* To find the max. page size with which both PA & VA are
-		 * aligned */
-		all_bits = pa_curr | va_curr;
-
-		for (i = 0; i < 4; i++) {
-			if ((num_bytes >= page_size[i]) && ((all_bits &
-							     (page_size[i] -
-							      1)) == 0)) {
-				status =
-				    pte_set(dev_context->pt_attrs, pa_curr,
-					    va_curr, page_size[i], map_attrs);
-				pa_curr += page_size[i];
-				va_curr += page_size[i];
-				num_bytes -= page_size[i];
-				/* Don't try smaller sizes. Hopefully we have
-				 * reached an address aligned to a bigger page
-				 * size */
-				break;
-			}
-		}
-	}
-
-	return status;
-}
+	struct bridge_dev_context *dev_context = dev_ctxt;
+	struct hw_mmu_map_attrs_t hw_attrs;
+	struct vm_area_struct *vma;
+	struct mm_struct *mm = current->mm;
+	u32 write = 0;
+	u32 num_usr_pgs = 0;
+	struct page *mapped_page, *pg;
+	s32 pg_num;
+	u32 va = virt_addr;
+	struct task_struct *curr_task = current;
+	u32 pg_i = 0;
+	u32 mpu_addr, pa;
 
-/*
- *  ======== pte_set ========
- *      This function calculates PTE address (MPU virtual) to be updated
- *      It also manages the L2 page tables
- */
-static int pte_set(struct pg_table_attrs *pt, u32 pa, u32 va,
-			  u32 size, struct hw_mmu_map_attrs_t *attrs)
-{
-	u32 i;
-	u32 pte_val;
-	u32 pte_addr_l1;
-	u32 pte_size;
-	/* Base address of the PT that will be updated */
-	u32 pg_tbl_va;
-	u32 l1_base_va;
-	/* Compiler warns that the next three variables might be used
-	 * uninitialized in this function. Doesn't seem so. Working around,
-	 * anyways. */
-	u32 l2_base_va = 0;
-	u32 l2_base_pa = 0;
-	u32 l2_page_num = 0;
-	int status = 0;
+	dev_dbg(bridge,
+		"%s hDevCtxt %p, pa %x, va %x, size %x, ul_map_attr %x\n",
+		__func__, dev_ctxt, ul_mpu_addr, virt_addr, ul_num_bytes,
+		ul_map_attr);
+	if (ul_num_bytes == 0)
+		return -EINVAL;
 
-	l1_base_va = pt->l1_base_va;
-	pg_tbl_va = l1_base_va;
-	if ((size == HW_PAGE_SIZE64KB) || (size == HW_PAGE_SIZE4KB)) {
-		/* Find whether the L1 PTE points to a valid L2 PT */
-		pte_addr_l1 = hw_mmu_pte_addr_l1(l1_base_va, va);
-		if (pte_addr_l1 <= (pt->l1_base_va + pt->l1_size)) {
-			pte_val = *(u32 *) pte_addr_l1;
-			pte_size = hw_mmu_pte_size_l1(pte_val);
-		} else {
-			return -EPERM;
-		}
-		spin_lock(&pt->pg_lock);
-		if (pte_size == HW_MMU_COARSE_PAGE_SIZE) {
-			/* Get the L2 PA from the L1 PTE, and find
-			 * corresponding L2 VA */
-			l2_base_pa = hw_mmu_pte_coarse_l1(pte_val);
-			l2_base_va =
-			    l2_base_pa - pt->l2_base_pa + pt->l2_base_va;
-			l2_page_num =
-			    (l2_base_pa -
-			     pt->l2_base_pa) / HW_MMU_COARSE_PAGE_SIZE;
-		} else if (pte_size == 0) {
-			/* L1 PTE is invalid. Allocate a L2 PT and
-			 * point the L1 PTE to it */
-			/* Find a free L2 PT. */
-			for (i = 0; (i < pt->l2_num_pages) &&
-			     (pt->pg_info[i].num_entries != 0); i++)
-				;
-			if (i < pt->l2_num_pages) {
-				l2_page_num = i;
-				l2_base_pa = pt->l2_base_pa + (l2_page_num *
-						HW_MMU_COARSE_PAGE_SIZE);
-				l2_base_va = pt->l2_base_va + (l2_page_num *
-						HW_MMU_COARSE_PAGE_SIZE);
-				/* Endianness attributes are ignored for
-				 * HW_MMU_COARSE_PAGE_SIZE */
-				status =
-				    hw_mmu_pte_set(l1_base_va, l2_base_pa, va,
-						   HW_MMU_COARSE_PAGE_SIZE,
-						   attrs);
-			} else {
-				status = -ENOMEM;
-			}
-		} else {
-			/* Found valid L1 PTE of another size.
-			 * Should not overwrite it. */
-			status = -EPERM;
-		}
-		if (!status) {
-			pg_tbl_va = l2_base_va;
-			if (size == HW_PAGE_SIZE64KB)
-				pt->pg_info[l2_page_num].num_entries += 16;
-			else
-				pt->pg_info[l2_page_num].num_entries++;
-			dev_dbg(bridge, "PTE: L2 BaseVa %x, BasePa %x, PageNum "
-				"%x, num_entries %x\n", l2_base_va,
-				l2_base_pa, l2_page_num,
-				pt->pg_info[l2_page_num].num_entries);
-		}
-		spin_unlock(&pt->pg_lock);
-	}
-	if (!status) {
-		dev_dbg(bridge, "PTE: pg_tbl_va %x, pa %x, va %x, size %x\n",
-			pg_tbl_va, pa, va, size);
-		dev_dbg(bridge, "PTE: endianism %x, element_size %x, "
-			"mixed_size %x\n", attrs->endianism,
-			attrs->element_size, attrs->mixed_size);
-		status = hw_mmu_pte_set(pg_tbl_va, pa, va, size, attrs);
+	if (ul_map_attr & DSP_MAP_DIR_MASK) {
+		attrs = ul_map_attr;
+	} else {
+		/* Assign default attributes */
+		attrs = ul_map_attr | (DSP_MAPVIRTUALADDR | DSP_MAPELEMSIZE16);
 	}
+	/* Take mapping properties */
+	if (attrs & DSP_MAPBIGENDIAN)
+		hw_attrs.endianism = HW_BIG_ENDIAN;
+	else
+		hw_attrs.endianism = HW_LITTLE_ENDIAN;
 
-	return status;
-}
-
-/* Memory map kernel VA -- memory allocated with vmalloc */
-static int mem_map_vmalloc(struct bridge_dev_context *dev_context,
-				  u32 ul_mpu_addr, u32 virt_addr,
-				  u32 ul_num_bytes,
-				  struct hw_mmu_map_attrs_t *hw_attrs)
-{
-	int status = 0;
-	struct page *page[1];
-	u32 i;
-	u32 pa_curr;
-	u32 pa_next;
-	u32 va_curr;
-	u32 size_curr;
-	u32 num_pages;
-	u32 pa;
-	u32 num_of4k_pages;
-	u32 temp = 0;
+	hw_attrs.mixed_size = (enum hw_mmu_mixed_size_t)
+	    ((attrs & DSP_MAPMIXEDELEMSIZE) >> 2);
+	/* Ignore element_size if mixed_size is enabled */
+	if (hw_attrs.mixed_size == 0) {
+		if (attrs & DSP_MAPELEMSIZE8) {
+			/* Size is 8 bit */
+			hw_attrs.element_size = HW_ELEM_SIZE8BIT;
+		} else if (attrs & DSP_MAPELEMSIZE16) {
+			/* Size is 16 bit */
+			hw_attrs.element_size = HW_ELEM_SIZE16BIT;
+		} else if (attrs & DSP_MAPELEMSIZE32) {
+			/* Size is 32 bit */
+			hw_attrs.element_size = HW_ELEM_SIZE32BIT;
+		} else if (attrs & DSP_MAPELEMSIZE64) {
+			/* Size is 64 bit */
+			hw_attrs.element_size = HW_ELEM_SIZE64BIT;
+		} else {
+			/*
+			 * Mixedsize isn't enabled, so size can't be
+			 * zero here
+			 */
+			return -EINVAL;
+		}
+	}
+	if (attrs & DSP_MAPDONOTLOCK)
+		hw_attrs.donotlockmpupage = 1;
+	else
+		hw_attrs.donotlockmpupage = 0;
 
+	if (attrs & DSP_MAPVMALLOCADDR) {
+		return mem_map_vmalloc(dev_ctxt, ul_mpu_addr, virt_addr,
+				       ul_num_bytes, &hw_attrs);
+	}
 	/*
-	 * Do Kernel va to pa translation.
+	 * Do OS-specific user-va to pa translation.
 	 * Combine physically contiguous regions to reduce TLBs.
 	 * Pass the translated pa to pte_update.
 	 */
-	num_pages = ul_num_bytes / PAGE_SIZE;	/* PAGE_SIZE = OS page size */
-	i = 0;
-	va_curr = ul_mpu_addr;
-	page[0] = vmalloc_to_page((void *)va_curr);
-	pa_next = page_to_phys(page[0]);
-	while (!status && (i < num_pages)) {
-		/*
-		 * Reuse pa_next from the previous iteraion to avoid
-		 * an extra va2pa call
-		 */
-		pa_curr = pa_next;
-		size_curr = PAGE_SIZE;
-		/*
-		 * If the next page is physically contiguous,
-		 * map it with the current one by increasing
-		 * the size of the region to be mapped
-		 */
-		while (++i < num_pages) {
-			page[0] =
-			    vmalloc_to_page((void *)(va_curr + size_curr));
-			pa_next = page_to_phys(page[0]);
+	if ((attrs & DSP_MAPPHYSICALADDR)) {
+		status = pte_update(dev_context, ul_mpu_addr, virt_addr,
+				    ul_num_bytes, &hw_attrs);
+		goto func_cont;
+	}
 
-			if (pa_next == (pa_curr + size_curr))
-				size_curr += PAGE_SIZE;
-			else
+	/*
+	 * Important Note: ul_mpu_addr is mapped from user application process
+	 * to current process - it must lie completely within the current
+	 * virtual memory address space in order to be of use to us here!
+	 */
+	down_read(&mm->mmap_sem);
+	vma = find_vma(mm, ul_mpu_addr);
+	if (vma)
+		dev_dbg(bridge,
+			"VMAfor UserBuf: ul_mpu_addr=%x, ul_num_bytes=%x, "
+			"vm_start=%lx, vm_end=%lx, vm_flags=%lx\n", ul_mpu_addr,
+			ul_num_bytes, vma->vm_start, vma->vm_end,
+			vma->vm_flags);
+
+	/*
+	 * It is observed that under some circumstances, the user buffer is
+	 * spread across several VMAs. So loop through and check if the entire
+	 * user buffer is covered
+	 */
+	while ((vma) && (ul_mpu_addr + ul_num_bytes > vma->vm_end)) {
+		/* jump to the next VMA region */
+		vma = find_vma(mm, vma->vm_end + 1);
+		dev_dbg(bridge,
+			"VMA for UserBuf ul_mpu_addr=%x ul_num_bytes=%x, "
+			"vm_start=%lx, vm_end=%lx, vm_flags=%lx\n", ul_mpu_addr,
+			ul_num_bytes, vma->vm_start, vma->vm_end,
+			vma->vm_flags);
+	}
+	if (!vma) {
+		pr_err("%s: Failed to get VMA region for 0x%x (%d)\n",
+		       __func__, ul_mpu_addr, ul_num_bytes);
+		status = -EINVAL;
+		up_read(&mm->mmap_sem);
+		goto func_cont;
+	}
+
+	if (vma->vm_flags & VM_IO) {
+		num_usr_pgs = ul_num_bytes / PG_SIZE4K;
+		mpu_addr = ul_mpu_addr;
+
+		/* Get the physical addresses for user buffer */
+		for (pg_i = 0; pg_i < num_usr_pgs; pg_i++) {
+			pa = user_va2_pa(mm, mpu_addr);
+			if (!pa) {
+				status = -EPERM;
+				pr_err("DSPBRIDGE: VM_IO mapping physical"
+				       "address is invalid\n");
+				break;
+			}
+			if (pfn_valid(__phys_to_pfn(pa))) {
+				pg = PHYS_TO_PAGE(pa);
+				get_page(pg);
+				if (page_count(pg) < 1) {
+					pr_err("Bad page in VM_IO buffer\n");
+					bad_page_dump(pa, pg);
+				}
+			}
+			status = pte_set(dev_context->pt_attrs, pa,
+					 va, HW_PAGE_SIZE4KB, &hw_attrs);
+			if (status)
 				break;
 
+			va += HW_PAGE_SIZE4KB;
+			mpu_addr += HW_PAGE_SIZE4KB;
+			pa += HW_PAGE_SIZE4KB;
 		}
-		if (pa_next == 0) {
-			status = -ENOMEM;
-			break;
+	} else {
+		num_usr_pgs = ul_num_bytes / PG_SIZE4K;
+		if (vma->vm_flags & (VM_WRITE | VM_MAYWRITE))
+			write = 1;
+
+		for (pg_i = 0; pg_i < num_usr_pgs; pg_i++) {
+			pg_num = get_user_pages(curr_task, mm, ul_mpu_addr, 1,
+						write, 1, &mapped_page, NULL);
+			if (pg_num > 0) {
+				if (page_count(mapped_page) < 1) {
+					pr_err("Bad page count after doing"
+					       "get_user_pages on"
+					       "user buffer\n");
+					bad_page_dump(page_to_phys(mapped_page),
+						      mapped_page);
+				}
+				status = pte_set(dev_context->pt_attrs,
+						 page_to_phys(mapped_page), va,
+						 HW_PAGE_SIZE4KB, &hw_attrs);
+				if (status)
+					break;
+
+				if (mapped_pages)
+					mapped_pages[pg_i] = mapped_page;
+
+				va += HW_PAGE_SIZE4KB;
+				ul_mpu_addr += HW_PAGE_SIZE4KB;
+			} else {
+				pr_err("DSPBRIDGE: get_user_pages FAILED,"
+				       "MPU addr = 0x%x,"
+				       "vma->vm_flags = 0x%lx,"
+				       "get_user_pages Err"
+				       "Value = %d, Buffer"
+				       "size=0x%x\n", ul_mpu_addr,
+				       vma->vm_flags, pg_num, ul_num_bytes);
+				status = -EPERM;
+				break;
+			}
 		}
-		pa = pa_curr;
-		num_of4k_pages = size_curr / HW_PAGE_SIZE4KB;
-		while (temp++ < num_of4k_pages) {
-			get_page(PHYS_TO_PAGE(pa));
-			pa += HW_PAGE_SIZE4KB;
+	}
+	up_read(&mm->mmap_sem);
+func_cont:
+	if (status) {
+		/*
+		 * Roll out the mapped pages incase it failed in middle of
+		 * mapping
+		 */
+		if (pg_i) {
+			bridge_brd_mem_un_map(dev_context, virt_addr,
+					   (pg_i * PG_SIZE4K));
 		}
-		status = pte_update(dev_context, pa_curr, virt_addr +
-				    (va_curr - ul_mpu_addr), size_curr,
-				    hw_attrs);
-		va_curr += size_curr;
+		status = -EPERM;
 	}
 	/*
 	 * In any case, flush the TLB
@@ -1793,21 +1699,66 @@ static int mem_map_vmalloc(struct bridge_dev_context *dev_context,
 }
 
 /*
- *  ======== wait_for_start ========
- *      Wait for the singal from DSP that it has started, or time out.
+ *  This Bridge driver's function interface table.
  */
-bool wait_for_start(struct bridge_dev_context *dev_context, u32 dw_sync_addr)
-{
-	u16 timeout = TIHELEN_ACKTIMEOUT;
+static struct bridge_drv_interface drv_interface_fxns = {
+	/* Bridge API ver. for which this bridge driver is built. */
+	BRD_API_MAJOR_VERSION,
+	BRD_API_MINOR_VERSION,
+	bridge_dev_create,
+	bridge_dev_destroy,
+	bridge_dev_ctrl,
+	bridge_brd_monitor,
+	bridge_brd_start,
+	bridge_brd_stop,
+	bridge_brd_status,
+	bridge_brd_read,
+	bridge_brd_write,
+	bridge_brd_set_state,
+	bridge_brd_mem_copy,
+	bridge_brd_mem_write,
+	bridge_brd_mem_map,
+	bridge_brd_mem_un_map,
+	/* The following CHNL functions are provided by chnl_io.lib: */
+	bridge_chnl_create,
+	bridge_chnl_destroy,
+	bridge_chnl_open,
+	bridge_chnl_close,
+	bridge_chnl_add_io_req,
+	bridge_chnl_get_ioc,
+	bridge_chnl_cancel_io,
+	bridge_chnl_flush_io,
+	bridge_chnl_get_info,
+	bridge_chnl_get_mgr_info,
+	bridge_chnl_idle,
+	bridge_chnl_register_notify,
+	/* The following IO functions are provided by chnl_io.lib: */
+	bridge_io_create,
+	bridge_io_destroy,
+	bridge_io_on_loaded,
+	bridge_io_get_proc_load,
+	/* The following msg_ctrl functions are provided by chnl_io.lib: */
+	bridge_msg_create,
+	bridge_msg_create_queue,
+	bridge_msg_delete,
+	bridge_msg_delete_queue,
+	bridge_msg_get,
+	bridge_msg_put,
+	bridge_msg_register_notify,
+	bridge_msg_set_queue_id,
+};
 
-	/*  Wait for response from board */
-	while (__raw_readw(dw_sync_addr) && --timeout)
-		udelay(10);
+/*
+ *  ======== bridge_drv_entry ========
+ *  purpose:
+ *      Bridge Driver entry point.
+ */
+void bridge_drv_entry(struct bridge_drv_interface **drv_intf,
+		   const char *driver_file_name)
+{
+	if (strcmp(driver_file_name, "UMA") == 0)
+		*drv_intf = &drv_interface_fxns;
+	else
+		dev_dbg(bridge, "%s Unknown Bridge file name", __func__);
 
-	/*  If timed out: return false */
-	if (!timeout) {
-		pr_err("%s: Timed out waiting DSP to Start\n", __func__);
-		return false;
-	}
-	return true;
 }
-- 
1.7.8.6

