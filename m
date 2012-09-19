From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 12/15] tidspbridge: Use constants defined in IOMMU platform headers
Date: Wed, 19 Sep 2012 14:07:00 +0200
Message-ID: <1348056423-25573-13-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:35804 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756276Ab2ISMGm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 08:06:42 -0400
In-Reply-To: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/staging/tidspbridge/core/io_sm.c      |    7 +-
 drivers/staging/tidspbridge/core/tiomap3430.c |   38 +++-----
 drivers/staging/tidspbridge/core/tiomap_io.c  |    2 +-
 drivers/staging/tidspbridge/core/ue_deh.c     |   13 +--
 drivers/staging/tidspbridge/hw/hw_defs.h      |    6 --
 drivers/staging/tidspbridge/hw/hw_mmu.c       |  121 ++++++++++---------------
 drivers/staging/tidspbridge/hw/hw_mmu.h       |   19 +++--
 7 files changed, 83 insertions(+), 123 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/io_sm.c b/drivers/staging/tidspbridge/core/io_sm.c
index 480a384..78e6fe3 100644
--- a/drivers/staging/tidspbridge/core/io_sm.c
+++ b/drivers/staging/tidspbridge/core/io_sm.c
@@ -361,10 +361,7 @@ int bridge_io_on_loaded(struct io_mgr *hio_mgr)
 	u32 pa_curr, va_curr, da_curr;
 	u32 bytes;
 	u32 all_bits = 0;
-	u32 page_size[] = {
-		HW_PAGE_SIZE16MB, HW_PAGE_SIZE1MB,
-		HW_PAGE_SIZE64KB, HW_PAGE_SIZE4KB
-	};
+	u32 page_size[] = { SZ_16M, SZ_1M, SZ_64K, SZ_4K };
 	u32 map_attrs = DSP_MAPLITTLEENDIAN | DSP_MAPPHYSICALADDR |
 			DSP_MAPELEMSIZE32 | DSP_MAPDONOTLOCK;
 
@@ -616,7 +613,7 @@ int bridge_io_on_loaded(struct io_mgr *hio_mgr)
 		status = hio_mgr->intf_fxns->brd_mem_map(dc,
 					l4_peripheral_table[i].phys_addr,
 					l4_peripheral_table[i].dsp_virt_addr,
-					HW_PAGE_SIZE4KB, map_attrs, NULL);
+					SZ_4K, map_attrs, NULL);
 		if (status)
 			goto free_eproc;
 		i++;
diff --git a/drivers/staging/tidspbridge/core/tiomap3430.c b/drivers/staging/tidspbridge/core/tiomap3430.c
index 5cd85dc..7f1372e 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430.c
@@ -62,10 +62,6 @@
 
 #define TIHELEN_ACKTIMEOUT  10000
 
-#define MMU_SECTION_ADDR_MASK    0xFFF00000
-#define MMU_SSECTION_ADDR_MASK   0xFF000000
-#define MMU_LARGE_PAGE_MASK      0xFFFF0000
-#define MMU_SMALL_PAGE_MASK      0xFFFFF000
 #define OMAP3_IVA2_BOOTADDR_MASK 0xFFFFFC00
 #define PAGES_II_LVL_TABLE   512
 #define PHYS_TO_PAGE(phys)      pfn_to_page((phys) >> PAGE_SHIFT)
@@ -486,8 +482,7 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 		/* Let DSP go */
 		dev_dbg(bridge, "%s Unreset\n", __func__);
 		/* Enable DSP MMU Interrupts */
-		hw_mmu_event_enable(resources->dmmu_base,
-				    HW_MMU_ALL_INTERRUPTS);
+		hw_mmu_event_enable(resources->dmmu_base, OMAP_IOMMU_ERR_ALL);
 		/* release the RST1, DSP starts executing now .. */
 		(*pdata->dsp_prm_rmw_bits)(OMAP3430_RST1_IVA2_MASK, 0,
 					OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
@@ -1013,7 +1008,7 @@ static int pte_set(struct pg_table_attrs *pt, u32 pa, u32 va,
 
 	l1_base_va = pt->l1_base_va;
 	pg_tbl_va = l1_base_va;
-	if ((size == HW_PAGE_SIZE64KB) || (size == HW_PAGE_SIZE4KB)) {
+	if (size == SZ_64K || size == SZ_4K) {
 		/* Find whether the L1 PTE points to a valid L2 PT */
 		pte_addr_l1 = hw_mmu_pte_addr_l1(l1_base_va, va);
 		if (pte_addr_l1 <= (pt->l1_base_va + pt->l1_size)) {
@@ -1061,7 +1056,7 @@ static int pte_set(struct pg_table_attrs *pt, u32 pa, u32 va,
 		}
 		if (!status) {
 			pg_tbl_va = l2_base_va;
-			if (size == HW_PAGE_SIZE64KB)
+			if (size == SZ_64K)
 				pt->pg_info[l2_page_num].num_entries += 16;
 			else
 				pt->pg_info[l2_page_num].num_entries++;
@@ -1099,9 +1094,7 @@ static int pte_update(struct bridge_dev_context *dev_ctxt, u32 pa,
 	u32 va_curr = va;
 	u32 num_bytes = size;
 	int status = 0;
-	u32 page_size[] = { HW_PAGE_SIZE16MB, HW_PAGE_SIZE1MB,
-		HW_PAGE_SIZE64KB, HW_PAGE_SIZE4KB
-	};
+	u32 page_size[] = { SZ_16M, SZ_1M, SZ_64K, SZ_4K };
 
 	while (num_bytes && !status) {
 		/* To find the max. page size with which both PA & VA are
@@ -1228,10 +1221,10 @@ static int mem_map_vmalloc(struct bridge_dev_context *dev_ctxt,
 			break;
 		}
 		pa = pa_curr;
-		num_of4k_pages = size_curr / HW_PAGE_SIZE4KB;
+		num_of4k_pages = size_curr / SZ_4K;
 		while (temp++ < num_of4k_pages) {
 			get_page(PHYS_TO_PAGE(pa));
-			pa += HW_PAGE_SIZE4KB;
+			pa += SZ_4K;
 		}
 		status = pte_update(dev_ctxt, pa_curr, virt_addr +
 				    (va_curr - mpu_addr), size_curr,
@@ -1270,7 +1263,7 @@ static void bridge_release_pages(u32 paddr, u32 pte_size, u32 num_bytes,
 
 	num_pages = pte_size / PAGE_SIZE;
 
-	for (; num_pages > 0; --num_pages, paddr += HW_PAGE_SIZE4KB) {
+	for (; num_pages > 0; --num_pages, paddr += SZ_4K) {
 		if (!pfn_valid(__phys_to_pfn(paddr)) ||
 		    (map_obj && map_obj->vm_flags & VM_PFNMAP))
 			continue;
@@ -1582,14 +1575,14 @@ static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
 					bad_page_dump(pa, pg);
 				}
 			}
-			status = pte_set(dev_ctxt->pt_attrs, pa,
-					 virt_addr, HW_PAGE_SIZE4KB, &hw_attrs);
+			status = pte_set(dev_ctxt->pt_attrs, pa, virt_addr,
+					 SZ_4K, &hw_attrs);
 			if (status)
 				break;
 
-			virt_addr += HW_PAGE_SIZE4KB;
-			mpu_addr += HW_PAGE_SIZE4KB;
-			pa += HW_PAGE_SIZE4KB;
+			virt_addr += SZ_4K;
+			mpu_addr += SZ_4K;
+			pa += SZ_4K;
 		}
 	} else {
 		num_usr_pgs = num_bytes / PG_SIZE4K;
@@ -1608,16 +1601,15 @@ static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
 				}
 				status = pte_set(dev_ctxt->pt_attrs,
 						 page_to_phys(pg),
-						 virt_addr, HW_PAGE_SIZE4KB,
-						 &hw_attrs);
+						 virt_addr, SZ_4K, &hw_attrs);
 				if (status)
 					break;
 
 				if (map_obj)
 					map_obj->pages[pg_i] = pg;
 
-				virt_addr += HW_PAGE_SIZE4KB;
-				mpu_addr += HW_PAGE_SIZE4KB;
+				virt_addr += SZ_4K;
+				mpu_addr += SZ_4K;
 			} else {
 				pr_err("DSPBRIDGE: get_user_pages FAILED,"
 				       "MPU addr = 0x%x,"
diff --git a/drivers/staging/tidspbridge/core/tiomap_io.c b/drivers/staging/tidspbridge/core/tiomap_io.c
index 7fda10c..a76e37c 100644
--- a/drivers/staging/tidspbridge/core/tiomap_io.c
+++ b/drivers/staging/tidspbridge/core/tiomap_io.c
@@ -132,7 +132,7 @@ int read_ext_dsp_data(struct bridge_dev_context *dev_ctxt,
 				    ul_shm_base_virt - ul_tlb_base_virt;
 				ul_shm_offset_virt +=
 				    PG_ALIGN_HIGH(ul_ext_end - ul_dyn_ext_base +
-						  1, HW_PAGE_SIZE64KB);
+						  1, SZ_64K);
 				dw_ext_prog_virt_mem -= ul_shm_offset_virt;
 				dw_ext_prog_virt_mem +=
 				    (ul_ext_base - ul_dyn_ext_base);
diff --git a/drivers/staging/tidspbridge/core/ue_deh.c b/drivers/staging/tidspbridge/core/ue_deh.c
index 3d28b23..c6196c4 100644
--- a/drivers/staging/tidspbridge/core/ue_deh.c
+++ b/drivers/staging/tidspbridge/core/ue_deh.c
@@ -60,7 +60,7 @@ static irqreturn_t mmu_fault_isr(int irq, void *data)
 	}
 
 	hw_mmu_event_status(resources->dmmu_base, &event);
-	if (event == HW_MMU_TRANSLATION_FAULT) {
+	if (event == OMAP_IOMMU_ERR_TRANS_FAULT) {
 		hw_mmu_fault_addr_read(resources->dmmu_base, &fault_addr);
 		dev_dbg(bridge, "%s: event=0x%x, fault_addr=0x%x\n", __func__,
 				event, fault_addr);
@@ -74,10 +74,9 @@ static irqreturn_t mmu_fault_isr(int irq, void *data)
 		/* Disable the MMU events, else once we clear it will
 		 * start to raise INTs again */
 		hw_mmu_event_disable(resources->dmmu_base,
-				HW_MMU_TRANSLATION_FAULT);
+				     OMAP_IOMMU_ERR_TRANS_FAULT);
 	} else {
-		hw_mmu_event_disable(resources->dmmu_base,
-				HW_MMU_ALL_INTERRUPTS);
+		hw_mmu_event_disable(resources->dmmu_base, OMAP_IOMMU_ERR_ALL);
 	}
 	return IRQ_HANDLED;
 }
@@ -189,8 +188,7 @@ static void mmu_fault_print_stack(struct bridge_dev_context *dev_context)
 	hw_mmu_tlb_flush_all(resources->dmmu_base);
 
 	hw_mmu_tlb_add(resources->dmmu_base,
-			virt_to_phys(dummy_va_addr), fault_addr,
-			HW_PAGE_SIZE4KB, 1,
+			virt_to_phys(dummy_va_addr), fault_addr, SZ_4K, 1,
 			&map_attrs, HW_SET, HW_SET);
 
 	dsp_clk_enable(DSP_CLK_GPT8);
@@ -198,8 +196,7 @@ static void mmu_fault_print_stack(struct bridge_dev_context *dev_context)
 	dsp_gpt_wait_overflow(DSP_CLK_GPT8, 0xfffffffe);
 
 	/* Clear MMU interrupt */
-	hw_mmu_event_ack(resources->dmmu_base,
-			HW_MMU_TRANSLATION_FAULT);
+	hw_mmu_event_ack(resources->dmmu_base, OMAP_IOMMU_ERR_TRANS_FAULT);
 	dump_dsp_stack(dev_context);
 	dsp_clk_disable(DSP_CLK_GPT8);
 
diff --git a/drivers/staging/tidspbridge/hw/hw_defs.h b/drivers/staging/tidspbridge/hw/hw_defs.h
index d5266d4..89e6c4f 100644
--- a/drivers/staging/tidspbridge/hw/hw_defs.h
+++ b/drivers/staging/tidspbridge/hw/hw_defs.h
@@ -19,12 +19,6 @@
 #ifndef _HW_DEFS_H
 #define _HW_DEFS_H
 
-/* Page size */
-#define HW_PAGE_SIZE4KB   0x1000
-#define HW_PAGE_SIZE64KB  0x10000
-#define HW_PAGE_SIZE1MB   0x100000
-#define HW_PAGE_SIZE16MB  0x1000000
-
 /* hw_status:  return type for HW API */
 typedef long hw_status;
 
diff --git a/drivers/staging/tidspbridge/hw/hw_mmu.c b/drivers/staging/tidspbridge/hw/hw_mmu.c
index 981794d..a5766f6 100644
--- a/drivers/staging/tidspbridge/hw/hw_mmu.c
+++ b/drivers/staging/tidspbridge/hw/hw_mmu.c
@@ -16,36 +16,21 @@
  * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
  */
 
+#include <linux/err.h>
 #include <linux/io.h>
-#include "MMURegAcM.h"
+#include <linux/types.h>
+#include <plat/iommu.h>
+#include <plat/iommu2.h>
+#include <plat/iopgtable.h>
+
 #include <hw_defs.h>
 #include <hw_mmu.h>
-#include <linux/types.h>
-#include <linux/err.h>
 
-#define MMU_BASE_VAL_MASK	0xFC00
-#define MMU_PAGE_MAX	     3
-#define MMU_ELEMENTSIZE_MAX      3
-#define MMU_ADDR_MASK	    0xFFFFF000
-#define MMU_TTB_MASK	     0xFFFFC000
-#define MMU_SECTION_ADDR_MASK    0xFFF00000
-#define MMU_SSECTION_ADDR_MASK   0xFF000000
-#define MMU_PAGE_TABLE_MASK      0xFFFFFC00
-#define MMU_LARGE_PAGE_MASK      0xFFFF0000
-#define MMU_SMALL_PAGE_MASK      0xFFFFF000
+#include "MMURegAcM.h"
+
+#define IOPGD_TABLE_MASK		(~((1UL << 10) - 1))
 
 #define MMU_LOAD_TLB	0x00000001
-#define MMU_GFLUSH	0x60
-
-/*
- * hw_mmu_page_size_t: Enumerated Type used to specify the MMU Page Size(SLSS)
- */
-enum hw_mmu_page_size_t {
-	HW_MMU_SECTION,
-	HW_MMU_LARGE_PAGE,
-	HW_MMU_SMALL_PAGE,
-	HW_MMU_SUPERSECTION
-};
 
 /*
  * FUNCTION	      : mmu_set_cam_entry
@@ -151,18 +136,16 @@ static hw_status mmu_set_ram_entry(const void __iomem *base_address,
 				   enum hw_element_size_t element_size,
 				   enum hw_mmu_mixed_size_t mixed_size)
 {
-	hw_status status = 0;
 	u32 mmu_ram_reg;
 
-	mmu_ram_reg = (physical_addr & MMU_ADDR_MASK);
+	mmu_ram_reg = (physical_addr & IOPAGE_MASK);
 	mmu_ram_reg = (mmu_ram_reg) | ((endianism << 9) | (element_size << 7) |
 				       (mixed_size << 6));
 
 	/* write values to register */
 	MMUMMU_RAM_WRITE_REGISTER32(base_address, mmu_ram_reg);
 
-	return status;
-
+	return 0;
 }
 
 /* HW FUNCTIONS */
@@ -298,24 +281,24 @@ hw_status hw_mmu_tlb_add(const void __iomem *base_address,
 	hw_status status = 0;
 	u32 lock_reg;
 	u32 virtual_addr_tag;
-	enum hw_mmu_page_size_t mmu_pg_size;
+	u32 mmu_pg_size;
 
 	/*Check the input Parameters */
 	switch (page_sz) {
-	case HW_PAGE_SIZE4KB:
-		mmu_pg_size = HW_MMU_SMALL_PAGE;
+	case SZ_4K:
+		mmu_pg_size = MMU_CAM_PGSZ_4K;
 		break;
 
-	case HW_PAGE_SIZE64KB:
-		mmu_pg_size = HW_MMU_LARGE_PAGE;
+	case SZ_64K:
+		mmu_pg_size = MMU_CAM_PGSZ_64K;
 		break;
 
-	case HW_PAGE_SIZE1MB:
-		mmu_pg_size = HW_MMU_SECTION;
+	case SZ_1M:
+		mmu_pg_size = MMU_CAM_PGSZ_1M;
 		break;
 
-	case HW_PAGE_SIZE16MB:
-		mmu_pg_size = HW_MMU_SUPERSECTION;
+	case SZ_16M:
+		mmu_pg_size = MMU_CAM_PGSZ_16M;
 		break;
 
 	default:
@@ -325,7 +308,7 @@ hw_status hw_mmu_tlb_add(const void __iomem *base_address,
 	lock_reg = MMUMMU_LOCK_READ_REGISTER32(base_address);
 
 	/* Generate the 20-bit tag from virtual address */
-	virtual_addr_tag = ((virtual_addr & MMU_ADDR_MASK) >> 12);
+	virtual_addr_tag = ((virtual_addr & IOPAGE_MASK) >> 12);
 
 	/* Write the fields in the CAM Entry Register */
 	mmu_set_cam_entry(base_address, mmu_pg_size, preserved_bit, valid_bit,
@@ -359,58 +342,54 @@ hw_status hw_mmu_pte_set(const u32 pg_tbl_va,
 	s32 num_entries = 1;
 
 	switch (page_sz) {
-	case HW_PAGE_SIZE4KB:
+	case SZ_4K:
 		pte_addr = hw_mmu_pte_addr_l2(pg_tbl_va,
-					      virtual_addr &
-					      MMU_SMALL_PAGE_MASK);
+					      virtual_addr & IOPAGE_MASK);
 		pte_val =
-		    ((physical_addr & MMU_SMALL_PAGE_MASK) |
+		    ((physical_addr & IOPAGE_MASK) |
 		     (map_attrs->endianism << 9) | (map_attrs->
 						    element_size << 4) |
-		     (map_attrs->mixed_size << 11) | 2);
+		     (map_attrs->mixed_size << 11) | IOPTE_SMALL);
 		break;
 
-	case HW_PAGE_SIZE64KB:
+	case SZ_64K:
 		num_entries = 16;
 		pte_addr = hw_mmu_pte_addr_l2(pg_tbl_va,
-					      virtual_addr &
-					      MMU_LARGE_PAGE_MASK);
+					      virtual_addr & IOLARGE_MASK);
 		pte_val =
-		    ((physical_addr & MMU_LARGE_PAGE_MASK) |
+		    ((physical_addr & IOLARGE_MASK) |
 		     (map_attrs->endianism << 9) | (map_attrs->
 						    element_size << 4) |
-		     (map_attrs->mixed_size << 11) | 1);
+		     (map_attrs->mixed_size << 11) | IOPTE_LARGE);
 		break;
 
-	case HW_PAGE_SIZE1MB:
+	case SZ_1M:
 		pte_addr = hw_mmu_pte_addr_l1(pg_tbl_va,
-					      virtual_addr &
-					      MMU_SECTION_ADDR_MASK);
+					      virtual_addr & IOSECTION_MASK);
 		pte_val =
-		    ((((physical_addr & MMU_SECTION_ADDR_MASK) |
+		    ((((physical_addr & IOSECTION_MASK) |
 		       (map_attrs->endianism << 15) | (map_attrs->
 						       element_size << 10) |
-		       (map_attrs->mixed_size << 17)) & ~0x40000) | 0x2);
+		       (map_attrs->mixed_size << 17)) & ~0x40000) |
+		       IOPGD_SECTION);
 		break;
 
-	case HW_PAGE_SIZE16MB:
+	case SZ_16M:
 		num_entries = 16;
 		pte_addr = hw_mmu_pte_addr_l1(pg_tbl_va,
-					      virtual_addr &
-					      MMU_SSECTION_ADDR_MASK);
+					      virtual_addr & IOSUPER_MASK);
 		pte_val =
-		    (((physical_addr & MMU_SSECTION_ADDR_MASK) |
+		    (((physical_addr & IOSUPER_MASK) |
 		      (map_attrs->endianism << 15) | (map_attrs->
 						      element_size << 10) |
 		      (map_attrs->mixed_size << 17)
-		     ) | 0x40000 | 0x2);
+		     ) | 0x40000 | IOPGD_SUPER);
 		break;
 
 	case HW_MMU_COARSE_PAGE_SIZE:
 		pte_addr = hw_mmu_pte_addr_l1(pg_tbl_va,
-					      virtual_addr &
-					      MMU_SECTION_ADDR_MASK);
-		pte_val = (physical_addr & MMU_PAGE_TABLE_MASK) | 1;
+					      virtual_addr & IOPGD_TABLE_MASK);
+		pte_val = (physical_addr & IOPGD_TABLE_MASK) | IOPGD_TABLE;
 		break;
 
 	default:
@@ -430,31 +409,27 @@ hw_status hw_mmu_pte_clear(const u32 pg_tbl_va, u32 virtual_addr, u32 page_size)
 	s32 num_entries = 1;
 
 	switch (page_size) {
-	case HW_PAGE_SIZE4KB:
+	case SZ_4K:
 		pte_addr = hw_mmu_pte_addr_l2(pg_tbl_va,
-					      virtual_addr &
-					      MMU_SMALL_PAGE_MASK);
+					      virtual_addr & IOPAGE_MASK);
 		break;
 
-	case HW_PAGE_SIZE64KB:
+	case SZ_64K:
 		num_entries = 16;
 		pte_addr = hw_mmu_pte_addr_l2(pg_tbl_va,
-					      virtual_addr &
-					      MMU_LARGE_PAGE_MASK);
+					      virtual_addr & IOLARGE_MASK);
 		break;
 
-	case HW_PAGE_SIZE1MB:
+	case SZ_1M:
 	case HW_MMU_COARSE_PAGE_SIZE:
 		pte_addr = hw_mmu_pte_addr_l1(pg_tbl_va,
-					      virtual_addr &
-					      MMU_SECTION_ADDR_MASK);
+					      virtual_addr & IOSECTION_MASK);
 		break;
 
-	case HW_PAGE_SIZE16MB:
+	case SZ_16M:
 		num_entries = 16;
 		pte_addr = hw_mmu_pte_addr_l1(pg_tbl_va,
-					      virtual_addr &
-					      MMU_SSECTION_ADDR_MASK);
+					      virtual_addr & IOSUPER_MASK);
 		break;
 
 	default:
diff --git a/drivers/staging/tidspbridge/hw/hw_mmu.h b/drivers/staging/tidspbridge/hw/hw_mmu.h
index 37fc4d4..b034f28 100644
--- a/drivers/staging/tidspbridge/hw/hw_mmu.h
+++ b/drivers/staging/tidspbridge/hw/hw_mmu.h
@@ -20,10 +20,15 @@
 #define _HW_MMU_H
 
 #include <linux/types.h>
+#include <plat/iommu.h>
+#include <plat/iommu2.h>
 
-/* Bitmasks for interrupt sources */
-#define HW_MMU_TRANSLATION_FAULT   0x2
-#define HW_MMU_ALL_INTERRUPTS      0x1F
+#define OMAP_IOMMU_ERR_ALL \
+	(OMAP_IOMMU_ERR_TLB_MISS | \
+	 OMAP_IOMMU_ERR_TRANS_FAULT | \
+	 OMAP_IOMMU_ERR_EMU_MISS | \
+	 OMAP_IOMMU_ERR_TBLWALK_FAULT | \
+	 OMAP_IOMMU_ERR_MULTIHIT_FAULT)
 
 #define HW_MMU_COARSE_PAGE_SIZE 0x400
 
@@ -136,9 +141,9 @@ static inline u32 hw_mmu_pte_size_l1(u32 pte_val)
 
 	if ((pte_val & 0x3) == 0x2) {
 		if (pte_val & (1 << 18))
-			pte_size = HW_PAGE_SIZE16MB;
+			pte_size = SZ_16M;
 		else
-			pte_size = HW_PAGE_SIZE1MB;
+			pte_size = SZ_1M;
 	}
 
 	return pte_size;
@@ -149,9 +154,9 @@ static inline u32 hw_mmu_pte_size_l2(u32 pte_val)
 	u32 pte_size = 0;
 
 	if (pte_val & 0x2)
-		pte_size = HW_PAGE_SIZE4KB;
+		pte_size = SZ_4K;
 	else if (pte_val & 0x1)
-		pte_size = HW_PAGE_SIZE64KB;
+		pte_size = SZ_64K;
 
 	return pte_size;
 }
-- 
1.7.8.6

