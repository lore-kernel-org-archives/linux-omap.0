From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 1/2] tidspbridge: Refactor mapping find/remove operations
Date: Tue, 25 Sep 2012 01:13:05 +0200
Message-ID: <1348528386-4627-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <2509239.EghAKueIs0@avalon>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:49777 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889Ab2IXXMd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Sep 2012 19:12:33 -0400
In-Reply-To: <2509239.EghAKueIs0@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Split the remove_mapping_information() function into find_dsp_mapping()
to locate the mapping and remove_mapping_information() to remove it.
Rename find_containing_mapping() to find_mpu_mapping() and share the
search code between find_dsp_mapping() and find_mpu_mapping().

This prepares the driver for VM_PFNMAP support.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/staging/tidspbridge/rmgr/proc.c |  116 ++++++++++++++++---------------
 1 files changed, 59 insertions(+), 57 deletions(-)

diff --git a/drivers/staging/tidspbridge/rmgr/proc.c b/drivers/staging/tidspbridge/rmgr/proc.c
index 7e4f12f..64b1bba 100644
--- a/drivers/staging/tidspbridge/rmgr/proc.c
+++ b/drivers/staging/tidspbridge/rmgr/proc.c
@@ -145,47 +145,67 @@ static struct dmm_map_object *add_mapping_info(struct process_context *pr_ctxt,
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
+	if (map_obj == NULL)
+		return;
 
-	return map_obj->dsp_addr == dsp_addr &&
-		map_obj->size == size;
+	pr_debug("%s: match, deleting map info\n", __func__);
+
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
@@ -197,33 +217,13 @@ static int match_containing_map_obj(struct dmm_map_object *map_obj,
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
+		 mpu_addr, size);
 
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
-
-	map_obj = NULL;
-out:
-	spin_unlock(&pr_ctxt->dmm_map_lock);
-	return map_obj;
+	return find_mapping(pr_ctxt, mpu_addr, size, match_containing_map_obj);
 }
 
 static int find_first_page_in_cache(struct dmm_map_object *map_obj,
@@ -755,9 +755,9 @@ int proc_begin_dma(void *hprocessor, void *pmpu_addr, u32 ul_size,
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
@@ -795,9 +795,9 @@ int proc_end_dma(void *hprocessor, void *pmpu_addr, u32 ul_size,
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
@@ -1273,7 +1273,7 @@ int proc_map(void *hprocessor, void *pmpu_addr, u32 ul_size,
 	u32 size_align;
 	int status = 0;
 	struct proc_object *p_proc_object = (struct proc_object *)hprocessor;
-	struct dmm_map_object *map_obj;
+	struct dmm_map_object *map_obj = NULL;
 	u32 tmp_addr = 0;
 
 #ifdef CONFIG_TIDSPBRIDGE_CACHE_LINE_CHECK
@@ -1324,7 +1324,7 @@ int proc_map(void *hprocessor, void *pmpu_addr, u32 ul_size,
 		/* Mapped address = MSB of VA | LSB of PA */
 		*pp_map_addr = (void *) tmp_addr;
 	} else {
-		remove_mapping_information(pr_ctxt, tmp_addr, size_align);
+		remove_mapping_information(pr_ctxt, map_obj);
 		dmm_un_map_memory(dmm_mgr, va_align, &size_align);
 	}
 	mutex_unlock(&proc_lock);
@@ -1600,6 +1600,7 @@ int proc_un_map(void *hprocessor, void *map_addr,
 {
 	int status = 0;
 	struct proc_object *p_proc_object = (struct proc_object *)hprocessor;
+	struct dmm_map_object *map_obj;
 	struct dmm_object *dmm_mgr;
 	u32 va_align;
 	u32 size_align;
@@ -1637,7 +1638,8 @@ int proc_un_map(void *hprocessor, void *map_addr,
 	 * from dmm_map_list, so that mapped memory resource tracking
 	 * remains uptodate
 	 */
-	remove_mapping_information(pr_ctxt, (u32) map_addr, size_align);
+	map_obj = find_dsp_mapping(pr_ctxt, (u32) map_addr, size_align);
+	remove_mapping_information(pr_ctxt, map_obj);
 
 unmap_failed:
 	mutex_unlock(&proc_lock);
-- 
1.7.8.6

