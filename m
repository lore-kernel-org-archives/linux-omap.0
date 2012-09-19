From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 15/15] tidspbridge: Replace hw_mmu_map_attrs_t structure with a prot bitfield
Date: Wed, 19 Sep 2012 14:07:03 +0200
Message-ID: <1348056423-25573-16-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:35805 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932151Ab2ISMGn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 08:06:43 -0400
In-Reply-To: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/staging/tidspbridge/core/tiomap3430.c      |   83 ++++++++-----------
 drivers/staging/tidspbridge/core/ue_deh.c          |    8 +--
 drivers/staging/tidspbridge/hw/hw_defs.h           |   16 ----
 drivers/staging/tidspbridge/hw/hw_mmu.c            |   80 ++++---------------
 drivers/staging/tidspbridge/hw/hw_mmu.h            |   20 +----
 .../tidspbridge/include/dspbridge/dspioctl.h       |   25 ++++++
 6 files changed, 82 insertions(+), 150 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/tiomap3430.c b/drivers/staging/tidspbridge/core/tiomap3430.c
index c9d240c..669b126 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430.c
@@ -357,11 +357,9 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 		for (entry_ndx = 0; entry_ndx < BRDIOCTL_NUMOFMMUTLB;
 		     entry_ndx++) {
 			struct bridge_ioctl_extproc *e = &dev_ctxt->atlb_entry[entry_ndx];
-			struct hw_mmu_map_attrs_t map_attrs = {
-				.endianism = e->endianism,
-				.element_size = e->elem_size,
-				.mixed_size = e->mixed_mode,
-			};
+			int prot = (e->endianism << MMU_RAM_ENDIAN_SHIFT)
+				 | (e->elem_size << MMU_RAM_ELSZ_SHIFT)
+				 | (e->mixed_mode << MMU_RAM_MIXED_SHIFT);
 
 			if (!e->gpp_pa || !e->dsp_va)
 				continue;
@@ -378,7 +376,7 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 					e->dsp_va,
 					e->size,
 					itmp_entry_ndx,
-					&map_attrs, 1, 1);
+					prot, 1, 1);
 
 			itmp_entry_ndx++;
 		}
@@ -989,7 +987,7 @@ static int bridge_brd_mem_write(struct bridge_dev_context *dev_ctxt,
  *      It also manages the L2 page tables
  */
 static int pte_set(struct pg_table_attrs *pt, phys_addr_t pa, u32 da,
-		   size_t size, struct hw_mmu_map_attrs_t *attrs)
+		   size_t size, int prot)
 {
 	u32 i;
 	u32 pte_val;
@@ -1045,7 +1043,7 @@ static int pte_set(struct pg_table_attrs *pt, phys_addr_t pa, u32 da,
 				status =
 				    hw_mmu_pte_set(l1_base_va, l2_base_pa, da,
 						   HW_MMU_COARSE_PAGE_SIZE,
-						   attrs);
+						   prot);
 			} else {
 				status = -ENOMEM;
 			}
@@ -1070,10 +1068,8 @@ static int pte_set(struct pg_table_attrs *pt, phys_addr_t pa, u32 da,
 	if (!status) {
 		dev_dbg(bridge, "PTE: pg_tbl_va %x, pa %x, da %x, size %x\n",
 			pg_tbl_va, pa, da, size);
-		dev_dbg(bridge, "PTE: endianism %x, element_size %x, "
-			"mixed_size %x\n", attrs->endianism,
-			attrs->element_size, attrs->mixed_size);
-		status = hw_mmu_pte_set(pg_tbl_va, pa, da, size, attrs);
+		dev_dbg(bridge, "PTE: prot %x", prot);
+		status = hw_mmu_pte_set(pg_tbl_va, pa, da, size, prot);
 	}
 
 	return status;
@@ -1098,7 +1094,7 @@ static unsigned max_alignment(u32 addr, size_t size)
  *      Caller must pass page-aligned values
  */
 static int pte_update(struct bridge_dev_context *dev_ctxt, phys_addr_t pa, u32 da,
-		      size_t size, struct hw_mmu_map_attrs_t *map_attrs)
+		      size_t size, int prot)
 {
 	while (size) {
 		/* To find the max. page size with which both PA & VA are
@@ -1109,7 +1105,7 @@ static int pte_update(struct bridge_dev_context *dev_ctxt, phys_addr_t pa, u32 d
 		if (WARN_ON(ent_sz == 0))
 			return -EINVAL;
 
-		ret = pte_set(dev_ctxt->pt_attrs, pa, da, ent_sz, map_attrs);
+		ret = pte_set(dev_ctxt->pt_attrs, pa, da, ent_sz, prot);
 		if (ret < 0)
 			return ret;
 
@@ -1167,8 +1163,7 @@ static inline void flush_all(struct bridge_dev_context *dev_ctxt)
 
 /* Memory map kernel VA -- memory allocated with vmalloc */
 static int mem_map_vmalloc(struct bridge_dev_context *dev_ctxt,
-			   unsigned long va, u32 da, size_t bytes,
-			   struct hw_mmu_map_attrs_t *hw_attrs)
+			   unsigned long va, u32 da, size_t bytes, int prot)
 {
 	struct page *page_next;
 	int ret;
@@ -1208,7 +1203,7 @@ static int mem_map_vmalloc(struct bridge_dev_context *dev_ctxt,
 		}
 
 		ret = pte_update(dev_ctxt, page_to_phys(page), da,
-				 chunk_size, hw_attrs);
+				 chunk_size, prot);
 		if (ret)
 			break;
 
@@ -1435,12 +1430,12 @@ static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
 {
 	u32 attrs;
 	int status = 0;
-	struct hw_mmu_map_attrs_t hw_attrs;
 	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
 	u32 write = 0;
 	u32 num_usr_pgs;
 	struct page *pg;
+	int prot;
 	s32 pg_num;
 	u32 pg_i = 0;
 	u32 pa;
@@ -1460,46 +1455,38 @@ static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
 	}
 	/* Take mapping properties */
 	if (attrs & DSP_MAPBIGENDIAN)
-		hw_attrs.endianism = HW_BIG_ENDIAN;
+		prot = MMU_RAM_ENDIAN_BIG;
 	else
-		hw_attrs.endianism = HW_LITTLE_ENDIAN;
+		prot = MMU_RAM_ENDIAN_LITTLE;
+
+	if (attrs & DSP_MAPMIXEDELEMSIZE)
+		prot |= MMU_RAM_MIXED;
 
-	hw_attrs.mixed_size = (enum hw_mmu_mixed_size_t)
-	    ((attrs & DSP_MAPMIXEDELEMSIZE) >> 2);
 	/* Ignore element_size if mixed_size is enabled */
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
-		} else {
-			/*
-			 * Mixedsize isn't enabled, so size can't be
-			 * zero here
-			 */
+	if (!(attrs & DSP_MAPMIXEDELEMSIZE)) {
+		if (attrs & DSP_MAPELEMSIZE8)
+			prot |= MMU_RAM_ELSZ_8;
+		else if (attrs & DSP_MAPELEMSIZE16)
+			prot |= MMU_RAM_ELSZ_16;
+		else if (attrs & DSP_MAPELEMSIZE32)
+			prot |= MMU_RAM_ELSZ_32;
+		else if (attrs & DSP_MAPELEMSIZE64)
+			prot |= MMU_RAM_ELSZ_NONE;
+		else
+			/* Mixedsize isn't enabled, size can't be zero here */
 			return -EINVAL;
-		}
 	}
 
-	if (attrs & DSP_MAPVMALLOCADDR) {
-		return mem_map_vmalloc(dev_ctxt, va, da, bytes, &hw_attrs);
-	}
+	if (attrs & DSP_MAPVMALLOCADDR)
+		return mem_map_vmalloc(dev_ctxt, va, da, bytes, prot);
+
 	/*
 	 * Do OS-specific user-va to pa translation.
 	 * Combine physically contiguous regions to reduce TLBs.
 	 * Pass the translated pa to pte_update.
 	 */
 	if ((attrs & DSP_MAPPHYSICALADDR)) {
-		status = pte_update(dev_ctxt, (phys_addr_t)va, da,
-				    bytes, &hw_attrs);
+		status = pte_update(dev_ctxt, (phys_addr_t)va, da, bytes, prot);
 		goto func_cont;
 	}
 
@@ -1562,7 +1549,7 @@ static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
 				}
 			}
 			status = pte_set(dev_ctxt->pt_attrs, pa, da,
-					 SZ_4K, &hw_attrs);
+					 SZ_4K, prot);
 			if (status)
 				break;
 
@@ -1587,7 +1574,7 @@ static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
 				}
 				status = pte_set(dev_ctxt->pt_attrs,
 						 page_to_phys(pg), da,
-						 SZ_4K, &hw_attrs);
+						 SZ_4K, prot);
 				if (status)
 					break;
 
diff --git a/drivers/staging/tidspbridge/core/ue_deh.c b/drivers/staging/tidspbridge/core/ue_deh.c
index c6196c4..15ef933 100644
--- a/drivers/staging/tidspbridge/core/ue_deh.c
+++ b/drivers/staging/tidspbridge/core/ue_deh.c
@@ -169,11 +169,7 @@ int bridge_deh_register_notify(struct deh_mgr *deh, u32 event_mask,
 static void mmu_fault_print_stack(struct bridge_dev_context *dev_context)
 {
 	struct cfg_hostres *resources;
-	struct hw_mmu_map_attrs_t map_attrs = {
-		.endianism = HW_LITTLE_ENDIAN,
-		.element_size = HW_ELEM_SIZE16BIT,
-		.mixed_size = HW_MMU_CPUES,
-	};
+	int prot = MMU_RAM_ENDIAN_LITTLE | MMU_RAM_ELSZ_16 | MMU_RAM_MIXED;
 	void *dummy_va_addr;
 
 	resources = dev_context->resources;
@@ -189,7 +185,7 @@ static void mmu_fault_print_stack(struct bridge_dev_context *dev_context)
 
 	hw_mmu_tlb_add(resources->dmmu_base,
 			virt_to_phys(dummy_va_addr), fault_addr, SZ_4K, 1,
-			&map_attrs, HW_SET, HW_SET);
+			prot, HW_SET, HW_SET);
 
 	dsp_clk_enable(DSP_CLK_GPT8);
 
diff --git a/drivers/staging/tidspbridge/hw/hw_defs.h b/drivers/staging/tidspbridge/hw/hw_defs.h
index 89e6c4f..9a87e1c 100644
--- a/drivers/staging/tidspbridge/hw/hw_defs.h
+++ b/drivers/staging/tidspbridge/hw/hw_defs.h
@@ -26,22 +26,6 @@ typedef long hw_status;
 #define HW_CLEAR	0
 #define HW_SET		1
 
-/* hw_endianism_t:  Enumerated Type used to specify the endianism
- *		Do NOT change these values. They are used as bit fields. */
-enum hw_endianism_t {
-	HW_LITTLE_ENDIAN,
-	HW_BIG_ENDIAN
-};
-
-/* hw_element_size_t:  Enumerated Type used to specify the element size
- *		Do NOT change these values. They are used as bit fields. */
-enum hw_element_size_t {
-	HW_ELEM_SIZE8BIT,
-	HW_ELEM_SIZE16BIT,
-	HW_ELEM_SIZE32BIT,
-	HW_ELEM_SIZE64BIT
-};
-
 /* hw_idle_mode_t:  Enumerated Type used to specify Idle modes */
 enum hw_idle_mode_t {
 	HW_FORCE_IDLE,
diff --git a/drivers/staging/tidspbridge/hw/hw_mmu.c b/drivers/staging/tidspbridge/hw/hw_mmu.c
index 34c2054..d80a2e2 100644
--- a/drivers/staging/tidspbridge/hw/hw_mmu.c
+++ b/drivers/staging/tidspbridge/hw/hw_mmu.c
@@ -105,47 +105,18 @@ static hw_status mmu_set_cam_entry(const void __iomem *base_address,
  *       Description     : Physical Address to which the corresponding
  *			 virtual   Address shouldpoint
  *
- *       Identifier      : endianism
- *       Type	    	: hw_endianism_t
- *       Description     : endianism for the given page
- *
- *       Identifier      : element_size
- *       Type	    	: hw_element_size_t
- *       Description     : The element size ( 8,16, 32 or 64 bit)
- *
- *       Identifier      : mixed_size
- *       Type	    	: hw_mmu_mixed_size_t
- *       Description     : Element Size to follow CPU or TLB
- *
- * RETURNS:
- *
- *       Type	    	: hw_status
- *       Description     : 0		 -- No errors occurred
- *			 RET_BAD_NULL_PARAM     -- A Pointer Paramater
- *							was set to NULL
- *			 RET_PARAM_OUT_OF_RANGE -- Input Parameter
- *							out of Range
+ *       Identifier      : prot
+ *       Type	    	: int
+ *       Description     : MMU_RAM_* flags
  *
  * PURPOSE:	      : Set MMU_CAM reg
  *
  * METHOD:	       : Check the Input parameters and set the RAM entry.
  */
-static hw_status mmu_set_ram_entry(const void __iomem *base_address,
-				   phys_addr_t pa,
-				   enum hw_endianism_t endianism,
-				   enum hw_element_size_t element_size,
-				   enum hw_mmu_mixed_size_t mixed_size)
+static void mmu_set_ram_entry(const void __iomem *base_address,
+			      phys_addr_t pa, int prot)
 {
-	u32 mmu_ram_reg;
-
-	mmu_ram_reg = (pa & IOPAGE_MASK);
-	mmu_ram_reg = (mmu_ram_reg) | ((endianism << 9) | (element_size << 7) |
-				       (mixed_size << 6));
-
-	/* write values to register */
-	MMUMMU_RAM_WRITE_REGISTER32(base_address, mmu_ram_reg);
-
-	return 0;
+	MMUMMU_RAM_WRITE_REGISTER32(base_address, (pa & IOPAGE_MASK) | prot);
 }
 
 /* HW FUNCTIONS */
@@ -271,8 +242,7 @@ hw_status hw_mmu_twl_disable(const void __iomem *base_address)
 }
 
 hw_status hw_mmu_tlb_add(const void __iomem *base_address, phys_addr_t pa,
-			 u32 da, u32 page_sz, u32 entry_num,
-			 struct hw_mmu_map_attrs_t *map_attrs,
+			 u32 da, u32 page_sz, u32 entry_num, int prot,
 			 s8 preserved_bit, s8 valid_bit)
 {
 	hw_status status = 0;
@@ -313,8 +283,7 @@ hw_status hw_mmu_tlb_add(const void __iomem *base_address, phys_addr_t pa,
 
 	/* Write the different fields of the RAM Entry Register */
 	/* endianism of the page,Element Size of the page (8, 16, 32, 64 bit) */
-	mmu_set_ram_entry(base_address, pa, map_attrs->endianism,
-			  map_attrs->element_size, map_attrs->mixed_size);
+	mmu_set_ram_entry(base_address, pa, prot);
 
 	/* Update the MMU Lock Register */
 	/* currentVictim between lockedBaseValue and (MMU_Entries_Number - 1) */
@@ -330,51 +299,38 @@ hw_status hw_mmu_tlb_add(const void __iomem *base_address, phys_addr_t pa,
 }
 
 hw_status hw_mmu_pte_set(const u32 pg_tbl_va, phys_addr_t pa, u32 da,
-			 u32 page_sz, struct hw_mmu_map_attrs_t *map_attrs)
+			 u32 page_sz, int prot)
 {
 	hw_status status = 0;
 	u32 pte_addr, pte_val;
 	s32 num_entries = 1;
 
+	pte_val = ((prot & MMU_RAM_MIXED_MASK) << 5)
+		| (prot & MMU_RAM_ENDIAN_MASK)
+		| ((prot & MMU_RAM_ELSZ_MASK) >> 3);
+
 	switch (page_sz) {
 	case SZ_4K:
 		pte_addr = hw_mmu_pte_addr_l2(pg_tbl_va, da & IOPAGE_MASK);
-		pte_val =
-		    ((pa & IOPAGE_MASK) |
-		     (map_attrs->endianism << 9) | (map_attrs->
-						    element_size << 4) |
-		     (map_attrs->mixed_size << 11) | IOPTE_SMALL);
+		pte_val = (pa & IOPAGE_MASK) | pte_val | IOPTE_SMALL;
 		break;
 
 	case SZ_64K:
 		num_entries = 16;
 		pte_addr = hw_mmu_pte_addr_l2(pg_tbl_va, da & IOLARGE_MASK);
-		pte_val =
-		    ((pa & IOLARGE_MASK) |
-		     (map_attrs->endianism << 9) | (map_attrs->
-						    element_size << 4) |
-		     (map_attrs->mixed_size << 11) | IOPTE_LARGE);
+		pte_val = (pa & IOLARGE_MASK) | pte_val | IOPTE_LARGE;
 		break;
 
 	case SZ_1M:
 		pte_addr = hw_mmu_pte_addr_l1(pg_tbl_va, da & IOSECTION_MASK);
-		pte_val =
-		    ((((pa & IOSECTION_MASK) |
-		       (map_attrs->endianism << 15) | (map_attrs->
-						       element_size << 10) |
-		       (map_attrs->mixed_size << 17)) & ~0x40000) |
-		       IOPGD_SECTION);
+		pte_val = (pa & IOSECTION_MASK) | (pte_val << 6)
+			| IOPGD_SECTION;
 		break;
 
 	case SZ_16M:
 		num_entries = 16;
 		pte_addr = hw_mmu_pte_addr_l1(pg_tbl_va, da & IOSUPER_MASK);
-		pte_val =
-		    (((pa & IOSUPER_MASK) |
-		      (map_attrs->endianism << 15) | (map_attrs->
-						      element_size << 10) |
-		      (map_attrs->mixed_size << 17)
-		     ) | 0x40000 | IOPGD_SUPER);
+		pte_val = (pa & IOSUPER_MASK) | (pte_val << 6) | IOPGD_SUPER;
 		break;
 
 	case HW_MMU_COARSE_PAGE_SIZE:
diff --git a/drivers/staging/tidspbridge/hw/hw_mmu.h b/drivers/staging/tidspbridge/hw/hw_mmu.h
index b4f476f..b7cc9e3 100644
--- a/drivers/staging/tidspbridge/hw/hw_mmu.h
+++ b/drivers/staging/tidspbridge/hw/hw_mmu.h
@@ -32,20 +32,6 @@
 
 #define HW_MMU_COARSE_PAGE_SIZE 0x400
 
-/* hw_mmu_mixed_size_t:  Enumerated Type used to specify whether to follow
-			CPU/TLB Element size */
-enum hw_mmu_mixed_size_t {
-	HW_MMU_TLBES,
-	HW_MMU_CPUES
-};
-
-/* hw_mmu_map_attrs_t:  Struct containing MMU mapping attributes */
-struct hw_mmu_map_attrs_t {
-	enum hw_endianism_t endianism;
-	enum hw_element_size_t element_size;
-	enum hw_mmu_mixed_size_t mixed_size;
-};
-
 extern hw_status hw_mmu_enable(const void __iomem *base_address);
 
 extern hw_status hw_mmu_disable(const void __iomem *base_address);
@@ -82,14 +68,12 @@ extern hw_status hw_mmu_twl_disable(const void __iomem *base_address);
 
 extern hw_status hw_mmu_tlb_add(const void __iomem *base_address,
 				phys_addr_t pa, u32 da, u32 page_sz,
-				u32 entry_num,
-				struct hw_mmu_map_attrs_t *map_attrs,
+				u32 entry_num, int prot,
 				s8 preserved_bit, s8 valid_bit);
 
 /* For PTEs */
 extern hw_status hw_mmu_pte_set(const u32 pg_tbl_va, phys_addr_t pa, u32 da,
-				u32 page_sz,
-				struct hw_mmu_map_attrs_t *map_attrs);
+				u32 page_sz, int prot);
 
 extern hw_status hw_mmu_pte_clear(const u32 pg_tbl_va,
 				  u32 da, u32 page_size);
diff --git a/drivers/staging/tidspbridge/include/dspbridge/dspioctl.h b/drivers/staging/tidspbridge/include/dspbridge/dspioctl.h
index 0c7ec04..28eebbb 100644
--- a/drivers/staging/tidspbridge/include/dspbridge/dspioctl.h
+++ b/drivers/staging/tidspbridge/include/dspbridge/dspioctl.h
@@ -54,6 +54,31 @@
 /* Number of actual DSP-MMU TLB entrries */
 #define BRDIOCTL_NUMOFMMUTLB        32
 
+/* hw_endianism_t: Enumerated Type used to specify the endianism
+ *		   Do NOT change these values. They are used as bit fields.
+ */
+enum hw_endianism_t {
+	HW_LITTLE_ENDIAN,
+	HW_BIG_ENDIAN
+};
+
+/* hw_element_size_t: Enumerated Type used to specify the element size
+ *		      Do NOT change these values. They are used as bit fields.
+ */
+enum hw_element_size_t {
+	HW_ELEM_SIZE8BIT,
+	HW_ELEM_SIZE16BIT,
+	HW_ELEM_SIZE32BIT,
+	HW_ELEM_SIZE64BIT
+};
+
+/* hw_mmu_mixed_size_t: Enumerated Type used to specify whether to follow
+			CPU/TLB Element size */
+enum hw_mmu_mixed_size_t {
+	HW_MMU_TLBES,
+	HW_MMU_CPUES
+};
+
 struct bridge_ioctl_extproc {
 	u32 dsp_va;		/* DSP virtual address */
 	u32 gpp_pa;		/* GPP physical address */
-- 
1.7.8.6

