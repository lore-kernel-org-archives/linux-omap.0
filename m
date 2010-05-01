From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [RFC/PATCH 4/6] DSPBRIDGE: do not call follow_page
Date: Sat,  1 May 2010 23:44:29 +0300
Message-ID: <1272746671-13423-5-git-send-email-ohad@wizery.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:19785 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402Ab0EAUr5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 May 2010 16:47:57 -0400
Received: by fg-out-1718.google.com with SMTP id d23so560455fga.1
        for <linux-omap@vger.kernel.org>; Sat, 01 May 2010 13:47:56 -0700 (PDT)
In-Reply-To: <1272746671-13423-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>

Eliminate the call to follow_page. Instead, use the page
information that was kept during the proc_map call.
This also has the advantage that users can now only
specify memory areas that were previously mapped.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
If you want, you can also reach me at <  ohadb at ti dot com  >.

 drivers/dsp/bridge/rmgr/proc.c |  143 ++++++++++++++++++++++++++--------------
 1 files changed, 93 insertions(+), 50 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index ebb11b1..bbc7e0f 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -209,6 +209,71 @@ out:
 	spin_unlock(&pr_obj->maps_lock);
 }
 
+static int match_containing_map_info(struct memory_map_info *map_info,
+					u32 mpu_addr, u32 size)
+{
+	u32 map_info_end = map_info->mpu_addr + map_info->size;
+
+	return mpu_addr >= map_info->mpu_addr &&
+		mpu_addr + size <= map_info_end;
+}
+
+static struct memory_map_info *find_containing_mapping(
+				struct proc_object *pr_obj,
+				u32 mpu_addr, u32 size)
+{
+	struct memory_map_info *map_info;
+	struct list_head *iter;
+	pr_debug("%s: looking for mpu_addr 0x%x size 0x%x\n", __func__,
+						mpu_addr, size);
+
+	spin_lock(&pr_obj->maps_lock);
+	list_for_each(iter, &pr_obj->maps) {
+		map_info = list_entry(iter, struct memory_map_info, node);
+		pr_debug("%s: candidate: mpu_addr 0x%x virt 0x%x size 0x%x\n",
+						__func__,
+						map_info->mpu_addr,
+						map_info->dsp_addr,
+						map_info->size);
+		if (match_containing_map_info(map_info, mpu_addr, size)) {
+			pr_debug("%s: match!\n", __func__);
+			goto out;
+		}
+
+		pr_debug("%s: no match!\n", __func__);
+	}
+
+	map_info = NULL;
+out:
+	spin_unlock(&pr_obj->maps_lock);
+	return map_info;
+}
+
+static int find_first_page_in_cache(struct memory_map_info *map_info,
+					unsigned long mpu_addr)
+{
+	u32 mapped_base_page = map_info->mpu_addr >> PAGE_SHIFT;
+	u32 requested_base_page = mpu_addr >> PAGE_SHIFT;
+	int pg_index = requested_base_page - mapped_base_page;
+
+	if (pg_index < 0 || pg_index >= map_info->num_usr_pgs) {
+		pr_err("%s: failed (got %d)\n", __func__, pg_index);
+		return -1;
+	}
+
+	pr_debug("%s: first page is %d\n", __func__, pg_index);
+	return pg_index;
+}
+
+static inline struct page *get_mapping_page(struct memory_map_info *map_info,
+								int pg_i)
+{
+	if (pg_i < 0 || pg_i >= map_info->num_usr_pgs)
+		return NULL;
+
+	return map_info->pages[pg_i];
+}
+
 /*
  *  ======== proc_attach ========
  *  Purpose:
@@ -561,23 +626,30 @@ dsp_status proc_enum_nodes(void *hprocessor, void **node_tab,
 }
 
 /* Cache operation against kernel address instead of users */
-static int memory_sync_page(struct vm_area_struct *vma, unsigned long start,
-			    ssize_t len, enum dsp_flushtype ftype)
+static int memory_sync_page(struct memory_map_info *map_info,
+		unsigned long start, ssize_t len, enum dsp_flushtype ftype)
 {
 	struct page *page;
 	void *kaddr;
 	unsigned long offset;
 	ssize_t rest;
+	int pg_i;
+
+	pg_i = find_first_page_in_cache(map_info, start);
+	if (pg_i < 0) {
+		pr_err("%s: failed to find first page in cache\n", __func__);
+		return -EINVAL;
+	}
 
 	while (len) {
-		page = follow_page(vma, start, FOLL_GET);
+		page = get_mapping_page(map_info, pg_i);
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
@@ -586,59 +658,22 @@ static int memory_sync_page(struct vm_area_struct *vma, unsigned long start,
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
-				   enum dsp_flushtype FlushMemType)
+				   enum dsp_flushtype ftype)
 {
 	/* Keep STATUS here for future additions to this function */
 	dsp_status status = DSP_SOK;
 	struct proc_object *p_proc_object = (struct proc_object *)hprocessor;
+	struct memory_map_info *map_info;
 
 	DBC_REQUIRE(refs > 0);
 
@@ -647,18 +682,26 @@ static dsp_status proc_memory_sync(void *hprocessor, void *pmpu_addr,
 		goto err_out;
 	}
 
-	down_read(&current->mm->mmap_sem);
+	pr_debug("%s: addr 0x%x, size 0x%x, type %d\n", __func__,
+							(u32)pmpu_addr,
+							ul_size, ftype);
+
+	/* find requested memory are in cached mapping information */
+	map_info = find_containing_mapping(p_proc_object, (u32) pmpu_addr,
+								ul_size);
+	if (!map_info) {
+		pr_err("%s: find_containing_mapping failed\n", __func__);
+		status = DSP_EHANDLE;
+		goto err_out;
+	}
 
-	if (memory_sync_vma((u32) pmpu_addr, ul_size, FlushMemType)) {
+	if (memory_sync_page(map_info, (u32) pmpu_addr, ul_size, ftype)) {
 		pr_err("%s: InValid address parameters %p %x\n",
 		       __func__, pmpu_addr, ul_size);
 		status = DSP_EHANDLE;
 	}
 
-	up_read(&current->mm->mmap_sem);
-
 err_out:
-
 	return status;
 }
 
-- 
1.6.3.3

