From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH v3 3/7] DSPBRIDGE: do not call follow_page
Date: Thu, 27 May 2010 19:02:10 +0300
Message-ID: <1274976134-22769-4-git-send-email-ohad@wizery.com>
References: <1274976134-22769-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38997 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897Ab0E0QCg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 May 2010 12:02:36 -0400
Received: by mail-fx0-f46.google.com with SMTP id 7so35401fxm.19
        for <linux-omap@vger.kernel.org>; Thu, 27 May 2010 09:02:35 -0700 (PDT)
In-Reply-To: <1274976134-22769-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Contreras <felipe.contreras@gmail.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>

Eliminate the call to follow_page. Instead, use the page
information that was kept during the proc_map call.
This also has the advantage that users can now only
specify memory areas that were previously mapped.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
You can also reach me at <  ohadb at ti dot com  >.

 drivers/dsp/bridge/pmgr/dspapi.c |    4 +-
 drivers/dsp/bridge/rmgr/proc.c   |  148 +++++++++++++++++++++++++-------------
 2 files changed, 99 insertions(+), 53 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/dspapi.c b/drivers/dsp/bridge/pmgr/dspapi.c
index 05ea853..cc64a99 100644
--- a/drivers/dsp/bridge/pmgr/dspapi.c
+++ b/drivers/dsp/bridge/pmgr/dspapi.c
@@ -688,7 +688,7 @@ u32 procwrap_flush_memory(union Trapped_Args *args, void *pr_ctxt)
 	    PROC_WRITEBACK_INVALIDATE_MEM)
 		return -EINVAL;
 
-	status = proc_flush_memory(args->args_proc_flushmemory.hprocessor,
+	status = proc_flush_memory(pr_ctxt,
 				   args->args_proc_flushmemory.pmpu_addr,
 				   args->args_proc_flushmemory.ul_size,
 				   args->args_proc_flushmemory.ul_flags);
@@ -703,7 +703,7 @@ u32 procwrap_invalidate_memory(union Trapped_Args *args, void *pr_ctxt)
 	dsp_status status;
 
 	status =
-	    proc_invalidate_memory(args->args_proc_invalidatememory.hprocessor,
+	    proc_invalidate_memory(pr_ctxt,
 				   args->args_proc_invalidatememory.pmpu_addr,
 				   args->args_proc_invalidatememory.ul_size);
 	return status;
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 37258c4..6628483 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -189,6 +189,75 @@ out:
 	spin_unlock(&pr_ctxt->dmm_map_lock);
 }
 
+static int match_containing_map_obj(struct dmm_map_object *map_obj,
+					u32 mpu_addr, u32 size)
+{
+	u32 map_obj_end = map_obj->mpu_addr + map_obj->size;
+
+	return mpu_addr >= map_obj->mpu_addr &&
+		mpu_addr + size <= map_obj_end;
+}
+
+static struct dmm_map_object *find_containing_mapping(
+				struct process_context *pr_ctxt,
+				u32 mpu_addr, u32 size)
+{
+	struct dmm_map_object *map_obj;
+	pr_debug("%s: looking for mpu_addr 0x%x size 0x%x\n", __func__,
+						mpu_addr, size);
+
+	spin_lock(&pr_ctxt->dmm_map_lock);
+	list_for_each_entry(map_obj, &pr_ctxt->dmm_map_list, link) {
+		pr_debug("%s: candidate: mpu_addr 0x%x virt 0x%x size 0x%x\n",
+						__func__,
+						map_obj->mpu_addr,
+						map_obj->dsp_addr,
+						map_obj->size);
+		if (match_containing_map_obj(map_obj, mpu_addr, size)) {
+			pr_debug("%s: match!\n", __func__);
+			goto out;
+		}
+
+		pr_debug("%s: no match!\n", __func__);
+	}
+
+	map_obj = NULL;
+out:
+	spin_unlock(&pr_ctxt->dmm_map_lock);
+	return map_obj;
+}
+
+static int find_first_page_in_cache(struct dmm_map_object *map_obj,
+					unsigned long mpu_addr)
+{
+	u32 mapped_base_page = map_obj->mpu_addr >> PAGE_SHIFT;
+	u32 requested_base_page = mpu_addr >> PAGE_SHIFT;
+	int pg_index = requested_base_page - mapped_base_page;
+
+	if (pg_index < 0 || pg_index >= map_obj->num_usr_pgs) {
+		pr_err("%s: failed (got %d)\n", __func__, pg_index);
+		return -1;
+	}
+
+	pr_debug("%s: first page is %d\n", __func__, pg_index);
+	return pg_index;
+}
+
+static inline struct page *get_mapping_page(struct dmm_map_object *map_obj,
+								int pg_i)
+{
+	pr_debug("%s: looking for pg_i %d, num_usr_pgs: %d\n", __func__,
+					pg_i, map_obj->num_usr_pgs);
+
+	if (pg_i < 0 || pg_i >= map_obj->num_usr_pgs) {
+		pr_err("%s: requested pg_i %d is out of mapped range\n",
+				__func__, pg_i);
+		return NULL;
+	}
+
+	return map_obj->pages[pg_i];
+}
+
 /*
  *  ======== proc_attach ========
  *  Purpose:
@@ -537,23 +606,30 @@ dsp_status proc_enum_nodes(void *hprocessor, void **node_tab,
 }
 
 /* Cache operation against kernel address instead of users */
-static int memory_sync_page(struct vm_area_struct *vma, unsigned long start,
-			    ssize_t len, enum dsp_flushtype ftype)
+static int memory_sync_page(struct dmm_map_object *map_obj,
+		unsigned long start, ssize_t len, enum dsp_flushtype ftype)
 {
 	struct page *page;
 	void *kaddr;
 	unsigned long offset;
 	ssize_t rest;
+	int pg_i;
+
+	pg_i = find_first_page_in_cache(map_obj, start);
+	if (pg_i < 0) {
+		pr_err("%s: failed to find first page in cache\n", __func__);
+		return -EINVAL;
+	}
 
 	while (len) {
-		page = follow_page(vma, start, FOLL_GET);
+		page = get_mapping_page(map_obj, pg_i);
 		if (!page) {
 			pr_err("%s: no page for %08lx\n", __func__, start);
 			return -EINVAL;
 		} else if (IS_ERR(page)) {
 			pr_err("%s: err page for %08lx(%lu)\n", __func__, start,
-			       IS_ERR(page));
-			return IS_ERR(page);
+			       PTR_ERR(page));
+			return PTR_ERR(page);
 		}
 
 		offset = start & ~PAGE_MASK;
@@ -562,77 +638,47 @@ static int memory_sync_page(struct vm_area_struct *vma, unsigned long start,
 		mem_flush_cache(kaddr, rest, ftype);
 
 		kunmap(page);
-		put_page(page);
 		len -= rest;
 		start += rest;
+		pg_i++;
 	}
 
 	return 0;
 }
 
-/* Check if the given area blongs to process virtul memory address space */
-static int memory_sync_vma(unsigned long start, u32 len,
-			   enum dsp_flushtype ftype)
-{
-	int err = 0;
-	unsigned long end;
-	struct vm_area_struct *vma;
-
-	end = start + len;
-	if (end <= start)
-		return -EINVAL;
-
-	while ((vma = find_vma(current->mm, start)) != NULL) {
-		ssize_t size;
-
-		if (vma->vm_flags & (VM_IO | VM_PFNMAP))
-			return -EINVAL;
-
-		if (vma->vm_start > start)
-			return -EINVAL;
-
-		size = min_t(ssize_t, vma->vm_end - start, len);
-		err = memory_sync_page(vma, start, size, ftype);
-		if (err)
-			break;
-
-		if (end <= vma->vm_end)
-			break;
-
-		start = vma->vm_end;
-	}
-
-	if (!vma)
-		err = -EINVAL;
-
-	return err;
-}
-
 static dsp_status proc_memory_sync(void *hprocessor, void *pmpu_addr,
 				   u32 ul_size, u32 ul_flags,
 				   enum dsp_flushtype FlushMemType)
 {
 	/* Keep STATUS here for future additions to this function */
 	dsp_status status = DSP_SOK;
-	struct proc_object *p_proc_object = (struct proc_object *)hprocessor;
+	struct process_context *pr_ctxt = (struct process_context *) hprocessor;
+	struct dmm_map_object *map_obj;
 
 	DBC_REQUIRE(refs > 0);
 
-	if (!p_proc_object) {
+	if (!pr_ctxt) {
 		status = -EFAULT;
 		goto err_out;
 	}
 
-	down_read(&current->mm->mmap_sem);
+	pr_debug("%s: addr 0x%x, size 0x%x, type %d\n", __func__,
+							(u32)pmpu_addr,
+							ul_size, ul_flags);
 
-	if (memory_sync_vma((u32) pmpu_addr, ul_size, FlushMemType)) {
+	/* find requested memory are in cached mapping information */
+	map_obj = find_containing_mapping(pr_ctxt, (u32) pmpu_addr, ul_size);
+	if (!map_obj) {
+		pr_err("%s: find_containing_mapping failed\n", __func__);
+		status = -EFAULT;
+		goto err_out;
+	}
+	if (memory_sync_page(map_obj, (u32) pmpu_addr, ul_size, ul_flags)) {
 		pr_err("%s: InValid address parameters %p %x\n",
-		       __func__, pmpu_addr, ul_size);
+			       __func__, pmpu_addr, ul_size);
 		status = -EFAULT;
 	}
 
-	up_read(&current->mm->mmap_sem);
-
 err_out:
 
 	return status;
-- 
1.7.0.4

