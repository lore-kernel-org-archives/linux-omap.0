From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 08/15] tidspbridge: Fix VM_PFNMAP mapping
Date: Wed, 19 Sep 2012 14:06:56 +0200
Message-ID: <1348056423-25573-9-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:35805 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754259Ab2ISMGj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 08:06:39 -0400
In-Reply-To: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>

VMAs marked with the VM_PFNMAP flag have no struct page associated with
the memory PFNs. Don't call get_page()/put_page() on the pages
supposedly associated with the PFNs.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/staging/tidspbridge/core/tiomap3430.c      |   30 +++--
 .../staging/tidspbridge/include/dspbridge/drv.h    |    1 +
 .../tidspbridge/include/dspbridge/dspdefs.h        |    9 +-
 drivers/staging/tidspbridge/rmgr/proc.c            |  119 ++++++++++----------
 4 files changed, 84 insertions(+), 75 deletions(-)

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
index 7e4f12f..4253980d 100644
--- a/drivers/staging/tidspbridge/rmgr/proc.c
+++ b/drivers/staging/tidspbridge/rmgr/proc.c
@@ -145,47 +145,64 @@ static struct dmm_map_object *add_mapping_info(struct process_context *pr_ctxt,
 	return map_obj;
 }
 
-static int match_exact_map_obj(struct dmm_map_object *map_obj,
-					u32 dsp_addr, u32 size)
+static void remove_mapping_information(struct process_context *pr_ctxt,
+				       struct dmm_map_object *map_obj)
 {
-	if (map_obj->dsp_addr == dsp_addr && map_obj->size != size)
-		pr_err("%s: addr match (0x%x), size don't (0x%x != 0x%x)\n",
-				__func__, dsp_addr, map_obj->size, size);
+	pr_debug("%s: match, deleting map info\n", __func__);
 
-	return map_obj->dsp_addr == dsp_addr &&
-		map_obj->size == size;
+	spin_lock(&pr_ctxt->dmm_map_lock);
+	list_del(&map_obj->link);
+	spin_unlock(&pr_ctxt->dmm_map_lock);
+
+	kfree(map_obj->dma_info.sg);
+	kfree(map_obj->pages);
+	kfree(map_obj);
 }
 
-static void remove_mapping_information(struct process_context *pr_ctxt,
-						u32 dsp_addr, u32 size)
+static struct dmm_map_object *
+find_mapping(struct process_context *pr_ctxt, u32 addr, u32 size,
+	     int (*match)(struct dmm_map_object *, u32, u32))
 {
 	struct dmm_map_object *map_obj;
 
-	pr_debug("%s: looking for virt 0x%x size 0x%x\n", __func__,
-							dsp_addr, size);
-
 	spin_lock(&pr_ctxt->dmm_map_lock);
 	list_for_each_entry(map_obj, &pr_ctxt->dmm_map_list, link) {
-		pr_debug("%s: candidate: mpu_addr 0x%x virt 0x%x size 0x%x\n",
-							__func__,
-							map_obj->mpu_addr,
-							map_obj->dsp_addr,
-							map_obj->size);
-
-		if (match_exact_map_obj(map_obj, dsp_addr, size)) {
-			pr_debug("%s: match, deleting map info\n", __func__);
-			list_del(&map_obj->link);
-			kfree(map_obj->dma_info.sg);
-			kfree(map_obj->pages);
-			kfree(map_obj);
+		pr_debug("%s: candidate: mpu_addr 0x%x dsp_addr 0x%x size 0x%x\n",
+			 __func__, map_obj->mpu_addr, map_obj->dsp_addr,
+			 map_obj->size);
+
+		if (match(map_obj, addr, size)) {
+			pr_debug("%s: match!\n", __func__);
 			goto out;
 		}
-		pr_debug("%s: candidate didn't match\n", __func__);
+
+		pr_debug("%s: no match!\n", __func__);
 	}
 
-	pr_err("%s: failed to find given map info\n", __func__);
+	map_obj = NULL;
 out:
 	spin_unlock(&pr_ctxt->dmm_map_lock);
+	return map_obj;
+}
+
+static int match_exact_map_obj(struct dmm_map_object *map_obj,
+					u32 dsp_addr, u32 size)
+{
+	if (map_obj->dsp_addr == dsp_addr && map_obj->size != size)
+		pr_err("%s: addr match (0x%x), size don't (0x%x != 0x%x)\n",
+				__func__, dsp_addr, map_obj->size, size);
+
+	return map_obj->dsp_addr == dsp_addr &&
+		map_obj->size == size;
+}
+
+static struct dmm_map_object *
+find_dsp_mapping(struct process_context *pr_ctxt, u32 dsp_addr, u32 size)
+{
+	pr_debug("%s: looking for virt 0x%x size 0x%x\n", __func__,
+		 dsp_addr, size);
+
+	return find_mapping(pr_ctxt, dsp_addr, size, match_exact_map_obj);
 }
 
 static int match_containing_map_obj(struct dmm_map_object *map_obj,
@@ -197,33 +214,13 @@ static int match_containing_map_obj(struct dmm_map_object *map_obj,
 		mpu_addr + size <= map_obj_end;
 }
 
-static struct dmm_map_object *find_containing_mapping(
-				struct process_context *pr_ctxt,
-				u32 mpu_addr, u32 size)
+static struct dmm_map_object *
+find_mpu_mapping(struct process_context *pr_ctxt, u32 mpu_addr, u32 size)
 {
-	struct dmm_map_object *map_obj;
 	pr_debug("%s: looking for mpu_addr 0x%x size 0x%x\n", __func__,
-						mpu_addr, size);
-
-	spin_lock(&pr_ctxt->dmm_map_lock);
-	list_for_each_entry(map_obj, &pr_ctxt->dmm_map_list, link) {
-		pr_debug("%s: candidate: mpu_addr 0x%x virt 0x%x size 0x%x\n",
-						__func__,
-						map_obj->mpu_addr,
-						map_obj->dsp_addr,
-						map_obj->size);
-		if (match_containing_map_obj(map_obj, mpu_addr, size)) {
-			pr_debug("%s: match!\n", __func__);
-			goto out;
-		}
-
-		pr_debug("%s: no match!\n", __func__);
-	}
+		 mpu_addr, size);
 
-	map_obj = NULL;
-out:
-	spin_unlock(&pr_ctxt->dmm_map_lock);
-	return map_obj;
+	return find_mapping(pr_ctxt, mpu_addr, size, match_containing_map_obj);
 }
 
 static int find_first_page_in_cache(struct dmm_map_object *map_obj,
@@ -755,9 +752,9 @@ int proc_begin_dma(void *hprocessor, void *pmpu_addr, u32 ul_size,
 	mutex_lock(&proc_lock);
 
 	/* find requested memory are in cached mapping information */
-	map_obj = find_containing_mapping(pr_ctxt, (u32) pmpu_addr, ul_size);
+	map_obj = find_mpu_mapping(pr_ctxt, (u32) pmpu_addr, ul_size);
 	if (!map_obj) {
-		pr_err("%s: find_containing_mapping failed\n", __func__);
+		pr_err("%s: find_mpu_mapping failed\n", __func__);
 		status = -EFAULT;
 		goto no_map;
 	}
@@ -795,9 +792,9 @@ int proc_end_dma(void *hprocessor, void *pmpu_addr, u32 ul_size,
 	mutex_lock(&proc_lock);
 
 	/* find requested memory are in cached mapping information */
-	map_obj = find_containing_mapping(pr_ctxt, (u32) pmpu_addr, ul_size);
+	map_obj = find_mpu_mapping(pr_ctxt, (u32) pmpu_addr, ul_size);
 	if (!map_obj) {
-		pr_err("%s: find_containing_mapping failed\n", __func__);
+		pr_err("%s: find_mpu_mapping failed\n", __func__);
 		status = -EFAULT;
 		goto no_map;
 	}
@@ -1273,7 +1270,7 @@ int proc_map(void *hprocessor, void *pmpu_addr, u32 ul_size,
 	u32 size_align;
 	int status = 0;
 	struct proc_object *p_proc_object = (struct proc_object *)hprocessor;
-	struct dmm_map_object *map_obj;
+	struct dmm_map_object *map_obj = NULL;
 	u32 tmp_addr = 0;
 
 #ifdef CONFIG_TIDSPBRIDGE_CACHE_LINE_CHECK
@@ -1318,13 +1315,14 @@ int proc_map(void *hprocessor, void *pmpu_addr, u32 ul_size,
 		else
 			status = (*p_proc_object->intf_fxns->brd_mem_map)
 			    (p_proc_object->bridge_context, pa_align, va_align,
-			     size_align, ul_map_attr, map_obj->pages);
+			     size_align, ul_map_attr, map_obj);
 	}
 	if (!status) {
 		/* Mapped address = MSB of VA | LSB of PA */
 		*pp_map_addr = (void *) tmp_addr;
 	} else {
-		remove_mapping_information(pr_ctxt, tmp_addr, size_align);
+		if (map_obj)
+			remove_mapping_information(pr_ctxt, map_obj);
 		dmm_un_map_memory(dmm_mgr, va_align, &size_align);
 	}
 	mutex_unlock(&proc_lock);
@@ -1600,6 +1598,7 @@ int proc_un_map(void *hprocessor, void *map_addr,
 {
 	int status = 0;
 	struct proc_object *p_proc_object = (struct proc_object *)hprocessor;
+	struct dmm_map_object *map_obj;
 	struct dmm_object *dmm_mgr;
 	u32 va_align;
 	u32 size_align;
@@ -1625,8 +1624,10 @@ int proc_un_map(void *hprocessor, void *map_addr,
 	status = dmm_un_map_memory(dmm_mgr, (u32) va_align, &size_align);
 	/* Remove mapping from the page tables. */
 	if (!status) {
+		map_obj = find_dsp_mapping(pr_ctxt, (u32) map_addr, size_align);
 		status = (*p_proc_object->intf_fxns->brd_mem_un_map)
-		    (p_proc_object->bridge_context, va_align, size_align);
+		    (p_proc_object->bridge_context, va_align, size_align,
+		     map_obj);
 	}
 
 	if (status)
@@ -1637,7 +1638,7 @@ int proc_un_map(void *hprocessor, void *map_addr,
 	 * from dmm_map_list, so that mapped memory resource tracking
 	 * remains uptodate
 	 */
-	remove_mapping_information(pr_ctxt, (u32) map_addr, size_align);
+	remove_mapping_information(pr_ctxt, map_obj);
 
 unmap_failed:
 	mutex_unlock(&proc_lock);
-- 
1.7.8.6

