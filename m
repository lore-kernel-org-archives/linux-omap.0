From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 2/2] tidspbridge: Fix VM_PFNMAP mapping
Date: Tue, 25 Sep 2012 01:13:06 +0200
Message-ID: <1348528386-4627-2-git-send-email-laurent.pinchart@ideasonboard.com>
References: <2509239.EghAKueIs0@avalon>
 <1348528386-4627-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:49780 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911Ab2IXXMd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Sep 2012 19:12:33 -0400
In-Reply-To: <1348528386-4627-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

VMAs marked with the VM_PFNMAP flag have no struct page associated with
the memory PFNs. Don't call get_page()/put_page() on the pages
supposedly associated with the PFNs.

To check the VM flags at unmap time store them in the dmm_map_object
structure at map time, and pass the structure down to the tiomap3430.c
layer.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/staging/tidspbridge/core/tiomap3430.c      |   30 ++++++++++++--------
 .../staging/tidspbridge/include/dspbridge/drv.h    |    1 +
 .../tidspbridge/include/dspbridge/dspdefs.h        |    9 +++--
 drivers/staging/tidspbridge/rmgr/proc.c            |   14 ++++----
 4 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/tiomap3430.c b/drivers/staging/tidspbridge/core/tiomap3430.c
index 2c5be89..cc538ea 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430.c
@@ -1262,7 +1262,8 @@ static void bad_page_dump(u32 pa, struct page *pg)
 }
 
 /* Release all pages associated with a physical addresses range. */
-static void bridge_release_pages(u32 paddr, u32 pte_size, u32 num_bytes)
+static void bridge_release_pages(u32 paddr, u32 pte_size, u32 num_bytes,
+				 struct dmm_map_object *map_obj)
 {
 	struct page *pg;
 	u32 num_pages;
@@ -1270,7 +1271,8 @@ static void bridge_release_pages(u32 paddr, u32 pte_size, u32 num_bytes)
 	num_pages = pte_size / PAGE_SIZE;
 
 	for (; num_pages > 0; --num_pages, paddr += HW_PAGE_SIZE4KB) {
-		if (!pfn_valid(__phys_to_pfn(paddr)))
+		if (!pfn_valid(__phys_to_pfn(paddr)) ||
+		    (map_obj && map_obj->vm_flags & VM_PFNMAP))
 			continue;
 
 		pg = PHYS_TO_PAGE(paddr);
@@ -1295,7 +1297,8 @@ static void bridge_release_pages(u32 paddr, u32 pte_size, u32 num_bytes)
  *      we clear consecutive PTEs until we unmap all the bytes
  */
 static int bridge_brd_mem_un_map(struct bridge_dev_context *dev_ctxt,
-				     u32 virt_addr, u32 num_bytes)
+				 u32 virt_addr, u32 num_bytes,
+				 struct dmm_map_object *map_obj)
 {
 	u32 l1_base_va;
 	u32 l2_base_va;
@@ -1369,7 +1372,7 @@ static int bridge_brd_mem_un_map(struct bridge_dev_context *dev_ctxt,
 			}
 
 			bridge_release_pages(pte_val & ~(pte_size - 1), pte_size,
-					     num_bytes);
+					     num_bytes, map_obj);
 
 			if (hw_mmu_pte_clear(pte_addr_l2, virt_addr, pte_size)) {
 				status = -EPERM;
@@ -1413,7 +1416,7 @@ skip_coarse_page:
 		}
 
 		bridge_release_pages(pte_val & ~(pte_size - 1), pte_size,
-				     num_bytes);
+				     num_bytes, map_obj);
 
 		if (!hw_mmu_pte_clear(l1_base_va, virt_addr, pte_size)) {
 			status = 0;
@@ -1448,7 +1451,7 @@ EXIT_LOOP:
  */
 static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
 			      u32 mpu_addr, u32 virt_addr, u32 num_bytes,
-			      u32 map_attr, struct page **mapped_pages)
+			      u32 map_attr, struct dmm_map_object *map_obj)
 {
 	u32 attrs;
 	int status = 0;
@@ -1559,6 +1562,9 @@ static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
 		goto func_cont;
 	}
 
+	if (map_obj)
+		map_obj->vm_flags = vma->vm_flags;
+
 	if (vma->vm_flags & VM_IO) {
 		num_usr_pgs = num_bytes / PG_SIZE4K;
 
@@ -1571,7 +1577,8 @@ static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
 				       "address is invalid\n");
 				break;
 			}
-			if (pfn_valid(__phys_to_pfn(pa))) {
+			if (!(vma->vm_flags & VM_PFNMAP) &&
+			    pfn_valid(__phys_to_pfn(pa))) {
 				pg = PHYS_TO_PAGE(pa);
 				get_page(pg);
 				if (page_count(pg) < 1) {
@@ -1610,8 +1617,8 @@ static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
 				if (status)
 					break;
 
-				if (mapped_pages)
-					mapped_pages[pg_i] = pg;
+				if (map_obj)
+					map_obj->pages[pg_i] = pg;
 
 				virt_addr += HW_PAGE_SIZE4KB;
 				mpu_addr += HW_PAGE_SIZE4KB;
@@ -1635,10 +1642,9 @@ func_cont:
 		 * Roll out the mapped pages incase it failed in middle of
 		 * mapping
 		 */
-		if (pg_i) {
+		if (pg_i)
 			bridge_brd_mem_un_map(dev_ctxt, virt_addr,
-					   (pg_i * PG_SIZE4K));
-		}
+					      pg_i * PG_SIZE4K, map_obj);
 		status = -EPERM;
 	}
 	/*
diff --git a/drivers/staging/tidspbridge/include/dspbridge/drv.h b/drivers/staging/tidspbridge/include/dspbridge/drv.h
index b0c7708..492d216 100644
--- a/drivers/staging/tidspbridge/include/dspbridge/drv.h
+++ b/drivers/staging/tidspbridge/include/dspbridge/drv.h
@@ -88,6 +88,7 @@ struct dmm_map_object {
 	u32 mpu_addr;
 	u32 size;
 	u32 num_usr_pgs;
+	vm_flags_t vm_flags;
 	struct page **pages;
 	struct bridge_dma_map_info dma_info;
 };
diff --git a/drivers/staging/tidspbridge/include/dspbridge/dspdefs.h b/drivers/staging/tidspbridge/include/dspbridge/dspdefs.h
index ed32bf3..0d28436 100644
--- a/drivers/staging/tidspbridge/include/dspbridge/dspdefs.h
+++ b/drivers/staging/tidspbridge/include/dspbridge/dspdefs.h
@@ -39,6 +39,7 @@
 
 /* Handle to Bridge driver's private device context. */
 struct bridge_dev_context;
+struct dmm_map_object;
 
 /*--------------------------------------------------------------------------- */
 /* BRIDGE DRIVER FUNCTION TYPES */
@@ -176,7 +177,7 @@ typedef int(*fxn_brd_memmap) (struct bridge_dev_context
 				     * dev_ctxt, u32 ul_mpu_addr,
 				     u32 virt_addr, u32 ul_num_bytes,
 				     u32 map_attr,
-				     struct page **mapped_pages);
+				     struct dmm_map_object *map_obj);
 
 /*
  *  ======== bridge_brd_mem_un_map ========
@@ -193,9 +194,9 @@ typedef int(*fxn_brd_memmap) (struct bridge_dev_context
  *      dev_ctxt != NULL;
  *  Ensures:
  */
-typedef int(*fxn_brd_memunmap) (struct bridge_dev_context
-				       * dev_ctxt,
-				       u32 virt_addr, u32 ul_num_bytes);
+typedef int(*fxn_brd_memunmap) (struct bridge_dev_context *dev_ctxt,
+				u32 virt_addr, u32 ul_num_bytes,
+				 struct dmm_map_object *map_obj);
 
 /*
  *  ======== bridge_brd_stop ========
diff --git a/drivers/staging/tidspbridge/rmgr/proc.c b/drivers/staging/tidspbridge/rmgr/proc.c
index 64b1bba..88c5107 100644
--- a/drivers/staging/tidspbridge/rmgr/proc.c
+++ b/drivers/staging/tidspbridge/rmgr/proc.c
@@ -1318,7 +1318,7 @@ int proc_map(void *hprocessor, void *pmpu_addr, u32 ul_size,
 		else
 			status = (*p_proc_object->intf_fxns->brd_mem_map)
 			    (p_proc_object->bridge_context, pa_align, va_align,
-			     size_align, ul_map_attr, map_obj->pages);
+			     size_align, ul_map_attr, map_obj);
 	}
 	if (!status) {
 		/* Mapped address = MSB of VA | LSB of PA */
@@ -1624,12 +1624,13 @@ int proc_un_map(void *hprocessor, void *map_addr,
 	 * This function returns error if the VA is not mapped
 	 */
 	status = dmm_un_map_memory(dmm_mgr, (u32) va_align, &size_align);
-	/* Remove mapping from the page tables. */
-	if (!status) {
-		status = (*p_proc_object->intf_fxns->brd_mem_un_map)
-		    (p_proc_object->bridge_context, va_align, size_align);
-	}
+	if (status)
+		goto unmap_failed;
 
+	/* Remove mapping from the page tables. */
+	map_obj = find_dsp_mapping(pr_ctxt, (u32) map_addr, size_align);
+	status = (*p_proc_object->intf_fxns->brd_mem_un_map)
+		(p_proc_object->bridge_context, va_align, size_align, map_obj);
 	if (status)
 		goto unmap_failed;
 
@@ -1638,7 +1639,6 @@ int proc_un_map(void *hprocessor, void *map_addr,
 	 * from dmm_map_list, so that mapped memory resource tracking
 	 * remains uptodate
 	 */
-	map_obj = find_dsp_mapping(pr_ctxt, (u32) map_addr, size_align);
 	remove_mapping_information(pr_ctxt, map_obj);
 
 unmap_failed:
-- 
1.7.8.6

