From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [RFC/PATCH 5/6] DSPBRIDGE: do not use low level cache manipulation API
Date: Sat,  1 May 2010 23:44:30 +0300
Message-ID: <1272746671-13423-6-git-send-email-ohad@wizery.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:21912 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402Ab0EAUsE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 May 2010 16:48:04 -0400
Received: by fg-out-1718.google.com with SMTP id 19so364977fgg.1
        for <linux-omap@vger.kernel.org>; Sat, 01 May 2010 13:48:01 -0700 (PDT)
In-Reply-To: <1272746671-13423-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>

Instead of using low level cache manipulation API,
use the standard DMA API.  This changes the concept
of the dspbridge cache API a little, hence the naming changes:
* Flush marks the beginning of a DMA transfer from the MPU
to the DSP.
* Invalidate marks the beginning of a DMA transfer from the DSP
to the MPU.

Both of these actions eventually build a scatter gatter list
using the page information that was kept during proc_map,
and feed it to the standard dma_map_sg API.
Note that now users cannot manipulate the cache state of any random
address; if the buffer is not part of a previous memory mapping of that
application, the request is denied.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
If you want, you can also reach me at <  ohadb at ti dot com  >.

 arch/arm/plat-omap/include/dspbridge/_dcd.h     |    4 +-
 arch/arm/plat-omap/include/dspbridge/proc.h     |    4 +-
 arch/arm/plat-omap/include/dspbridge/wcdioctl.h |    4 +-
 drivers/dsp/bridge/pmgr/wcd.c                   |   12 +-
 drivers/dsp/bridge/rmgr/proc.c                  |  152 ++++++++++++++++++-----
 5 files changed, 134 insertions(+), 42 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/_dcd.h b/arch/arm/plat-omap/include/dspbridge/_dcd.h
index 1350feb..0af4a31 100644
--- a/arch/arm/plat-omap/include/dspbridge/_dcd.h
+++ b/arch/arm/plat-omap/include/dspbridge/_dcd.h
@@ -110,9 +110,9 @@ extern u32 procwrap_reserve_memory(union Trapped_Args *args, void *pr_ctxt);
 extern u32 procwrap_un_reserve_memory(union Trapped_Args *args, void *pr_ctxt);
 extern u32 procwrap_map(union Trapped_Args *args, void *pr_ctxt);
 extern u32 procwrap_un_map(union Trapped_Args *args, void *pr_ctxt);
-extern u32 procwrap_flush_memory(union Trapped_Args *args, void *pr_ctxt);
+extern u32 procwrap_begin_dma_to_dsp(union Trapped_Args *args, void *pr_ctxt);
 extern u32 procwrap_stop(union Trapped_Args *args, void *pr_ctxt);
-extern u32 procwrap_invalidate_memory(union Trapped_Args *args, void *pr_ctxt);
+extern u32 procwrap_begin_dma_from_dsp(union Trapped_Args *args, void *pr_ctxt);
 
 /* NODE wrapper functions */
 extern u32 nodewrap_allocate(union Trapped_Args *args, void *pr_ctxt);
diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/plat-omap/include/dspbridge/proc.h
index 0707739..f8450a6 100644
--- a/arch/arm/plat-omap/include/dspbridge/proc.h
+++ b/arch/arm/plat-omap/include/dspbridge/proc.h
@@ -472,7 +472,7 @@ extern dsp_status proc_stop(void *hprocessor);
  *  Details:
  *      All the arguments are currently ignored.
  */
-extern dsp_status proc_flush_memory(void *hprocessor,
+extern dsp_status proc_begin_dma_to_dsp(void *hprocessor,
 				    void *pmpu_addr, u32 ul_size, u32 ul_flags);
 
 /*
@@ -493,7 +493,7 @@ extern dsp_status proc_flush_memory(void *hprocessor,
  *  Details:
  *      All the arguments are currently ignored.
  */
-extern dsp_status proc_invalidate_memory(void *hprocessor,
+extern dsp_status proc_begin_dma_from_dsp(void *hprocessor,
 					 void *pmpu_addr, u32 ul_size);
 
 /*
diff --git a/arch/arm/plat-omap/include/dspbridge/wcdioctl.h b/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
index b6a4dda..aba2078 100644
--- a/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
+++ b/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
@@ -452,9 +452,9 @@ union Trapped_Args {
 #define PROC_UNRSVMEM		_IOW(DB, DB_IOC(DB_PROC, 11), unsigned long)
 #define PROC_MAPMEM		_IOWR(DB, DB_IOC(DB_PROC, 12), unsigned long)
 #define PROC_UNMAPMEM		_IOR(DB, DB_IOC(DB_PROC, 13), unsigned long)
-#define PROC_FLUSHMEMORY	_IOW(DB, DB_IOC(DB_PROC, 14), unsigned long)
+#define PROC_BEGINDMATODSP	_IOW(DB, DB_IOC(DB_PROC, 14), unsigned long)
 #define PROC_STOP		_IOWR(DB, DB_IOC(DB_PROC, 15), unsigned long)
-#define PROC_INVALIDATEMEMORY	_IOW(DB, DB_IOC(DB_PROC, 16), unsigned long)
+#define PROC_BEGINDMAFROMDSP	_IOW(DB, DB_IOC(DB_PROC, 16), unsigned long)
 
 /* NODE Module */
 #define NODE_ALLOCATE		_IOWR(DB, DB_IOC(DB_NODE, 0), unsigned long)
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 15a05a6..89243f1 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -111,9 +111,9 @@ static struct wcd_cmd proc_cmd[] = {
 	{procwrap_un_reserve_memory},	/* PROC_UNRSVMEM */
 	{procwrap_map},		/* PROC_MAPMEM */
 	{procwrap_un_map},	/* PROC_UNMAPMEM */
-	{procwrap_flush_memory},	/* PROC_FLUSHMEMORY */
+	{procwrap_begin_dma_to_dsp},	/* PROC_BEGINDMATODSP */
 	{procwrap_stop},	/* PROC_STOP */
-	{procwrap_invalidate_memory},	/* PROC_INVALIDATEMEMORY */
+	{procwrap_begin_dma_from_dsp},	/* PROC_BEGINDMAFROMDSP */
 };
 
 /* NODE wrapper functions */
@@ -680,7 +680,7 @@ u32 procwrap_enum_node_info(union Trapped_Args *args, void *pr_ctxt)
 /*
  * ======== procwrap_flush_memory ========
  */
-u32 procwrap_flush_memory(union Trapped_Args *args, void *pr_ctxt)
+u32 procwrap_begin_dma_to_dsp(union Trapped_Args *args, void *pr_ctxt)
 {
 	dsp_status status;
 
@@ -688,7 +688,7 @@ u32 procwrap_flush_memory(union Trapped_Args *args, void *pr_ctxt)
 	    PROC_WRITEBACK_INVALIDATE_MEM)
 		return DSP_EINVALIDARG;
 
-	status = proc_flush_memory(args->args_proc_flushmemory.hprocessor,
+	status = proc_begin_dma_to_dsp(args->args_proc_flushmemory.hprocessor,
 				   args->args_proc_flushmemory.pmpu_addr,
 				   args->args_proc_flushmemory.ul_size,
 				   args->args_proc_flushmemory.ul_flags);
@@ -698,12 +698,12 @@ u32 procwrap_flush_memory(union Trapped_Args *args, void *pr_ctxt)
 /*
  * ======== procwrap_invalidate_memory ========
  */
-u32 procwrap_invalidate_memory(union Trapped_Args *args, void *pr_ctxt)
+u32 procwrap_begin_dma_from_dsp(union Trapped_Args *args, void *pr_ctxt)
 {
 	dsp_status status;
 
 	status =
-	    proc_invalidate_memory(args->args_proc_invalidatememory.hprocessor,
+	    proc_begin_dma_from_dsp(args->args_proc_invalidatememory.hprocessor,
 				   args->args_proc_invalidatememory.pmpu_addr,
 				   args->args_proc_invalidatememory.ul_size);
 	return status;
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index bbc7e0f..8a76681 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -18,6 +18,8 @@
 
 /* ------------------------------------ Host OS */
 #include <linux/list.h>
+#include <linux/dma-mapping.h>
+#include <linux/scatterlist.h>
 #include <linux/spinlock.h>
 #include <dspbridge/host_os.h>
 
@@ -80,6 +82,7 @@
 #define WBUF		0x8000		/* Output Buffer */
 
 extern char *iva_img;
+extern struct device *bridge;
 
 /*  ----------------------------------- Globals */
 
@@ -110,6 +113,18 @@ struct proc_object {
 	spinlock_t maps_lock;
 };
 
+/* used to cache dma mapping information */
+struct bridge_dma_map_info {
+	/* direction of DMA in action, or DMA_NONE */
+	enum dma_data_direction dir;
+	/* number of elements requested by us */
+	int num_pages;
+	/* number of elements returned from dma_map_sg */
+	int sg_num;
+	/* list of buffers used in this DMA action */
+	struct scatterlist *sg;
+};
+
 /* used to cache memory mapping information */
 struct memory_map_info {
 	struct list_head node;
@@ -118,6 +133,7 @@ struct memory_map_info {
 	u32 dsp_addr;
 	u32 size;
 	u32 num_usr_pgs;
+	struct bridge_dma_map_info dma_info;
 };
 
 static u32 refs;
@@ -130,7 +146,23 @@ static s32 get_envp_count(char **envp);
 static char **prepend_envp(char **new_envp, char **envp, s32 envp_elems,
 			   s32 cnew_envp, char *szVar);
 
-/* remember mapping information */
+/* Mapping and Page info caching
+ *
+ * The map_info mechanism is built to remember the (struct page *)
+ * pointers of all pages per a specific memory mapping of a specific
+ * process.
+ * Whenever a memory area is mapped, get_user_pages is used to pin the
+ * relevant pages in memory. As a result of running get_user_pages,
+ * we get the pointers to the page structures, which we now keep in
+ * the memory_map_info struct.
+ * Then, any time the user (the MM application) intends to begin
+ * a DMA (Direct Memory Access) operation to/from the remote processor,
+ * we use this cached page information to build a scatter gatter list
+ * which is given to the standard DMA API (which takes care of low
+ * level cache manipulation).
+ * Currently a simple linked list is used to cache the memory mapping
+ * info per process. This can be further optimized if needed.
+ */
 static struct memory_map_info *add_mapping_info(struct proc_object *pr_obj,
 				u32 mpu_addr, u32 dsp_addr, u32 size)
 {
@@ -197,6 +229,7 @@ static void remove_mapping_information(struct proc_object *pr_obj,
 		if (match_exact_map_info(map_info, dsp_addr, size)) {
 			pr_debug("%s: match, deleting map info\n", __func__);
 			list_del(&map_info->node);
+			kfree(map_info->dma_info.sg);
 			kfree(map_info->pages);
 			kfree(map_info);
 			goto out;
@@ -625,50 +658,109 @@ dsp_status proc_enum_nodes(void *hprocessor, void **node_tab,
 	return status;
 }
 
-/* Cache operation against kernel address instead of users */
-static int memory_sync_page(struct memory_map_info *map_info,
-		unsigned long start, ssize_t len, enum dsp_flushtype ftype)
+static int build_dma_sg(struct memory_map_info *map_info, unsigned long start,
+						ssize_t len, int pg_i)
 {
 	struct page *page;
-	void *kaddr;
 	unsigned long offset;
 	ssize_t rest;
-	int pg_i;
-
-	pg_i = find_first_page_in_cache(map_info, start);
-	if (pg_i < 0) {
-		pr_err("%s: failed to find first page in cache\n", __func__);
-		return -EINVAL;
-	}
+	int ret = 0, i = 0;
+	struct scatterlist *sg = map_info->dma_info.sg;
 
 	while (len) {
 		page = get_mapping_page(map_info, pg_i);
 		if (!page) {
 			pr_err("%s: no page for %08lx\n", __func__, start);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		} else if (IS_ERR(page)) {
 			pr_err("%s: err page for %08lx(%lu)\n", __func__, start,
 			       PTR_ERR(page));
-			return PTR_ERR(page);
+			ret = PTR_ERR(page);
+			goto out;
 		}
 
 		offset = start & ~PAGE_MASK;
-		kaddr = kmap(page) + offset;
 		rest = min_t(ssize_t, PAGE_SIZE - offset, len);
-		mem_flush_cache(kaddr, rest, ftype);
 
-		kunmap(page);
+		sg_set_page(&sg[i], page, rest, offset);
+
 		len -= rest;
 		start += rest;
-		pg_i++;
+		pg_i++, i++;
+	}
+
+	if (i != map_info->dma_info.num_pages) {
+		pr_err("%s: bad number of sg iterations\n", __func__);
+		ret = -EFAULT;
+		goto out;
+	}
+
+out:
+	return ret;
+}
+
+/* Cache operation against kernel address instead of users */
+static int memory_release_ownership(struct memory_map_info *map_info,
+		unsigned long start, ssize_t len, enum dma_data_direction dir)
+{
+	int pg_i, ret, sg_num;
+	struct scatterlist *sg;
+	unsigned long first_data_page = start >> PAGE_SHIFT;
+	unsigned long last_data_page = ((u32)(start + len - 1) >> PAGE_SHIFT);
+	/* calculating the number of pages this area spans */
+	unsigned long num_pages = last_data_page - first_data_page + 1;
+
+	pg_i = find_first_page_in_cache(map_info, start);
+	if (pg_i < 0) {
+		pr_err("%s: failed to find first page in cache\n", __func__);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	sg = kcalloc(num_pages, sizeof(*sg), GFP_KERNEL);
+	if (!sg) {
+		pr_err("%s: kcalloc failed\n", __func__);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	sg_init_table(sg, num_pages);
+
+	/* cleanup a previous sg allocation */
+	/* this may happen if application doesn't signal for e/o DMA */
+	kfree(map_info->dma_info.sg);
+
+	map_info->dma_info.sg = sg;
+	map_info->dma_info.dir = dir;
+	map_info->dma_info.num_pages = num_pages;
+
+	ret = build_dma_sg(map_info, start, len, pg_i);
+	if (ret)
+		goto kfree_sg;
+
+	sg_num = dma_map_sg(bridge, sg, num_pages, dir);
+	if (sg_num < 1) {
+		pr_err("%s: dma_map_sg failed: %d\n", __func__, sg_num);
+		ret = -EFAULT;
+		goto kfree_sg;
 	}
 
+	pr_debug("%s: dma_map_sg mapped %d elements\n", __func__, sg_num);
+	map_info->dma_info.sg_num = sg_num;
+
 	return 0;
+
+kfree_sg:
+	kfree(sg);
+	map_info->dma_info.sg = NULL;
+out:
+	return ret;
 }
 
-static dsp_status proc_memory_sync(void *hprocessor, void *pmpu_addr,
-				   u32 ul_size, u32 ul_flags,
-				   enum dsp_flushtype ftype)
+static dsp_status proc_begin_dma(void *hprocessor, void *pmpu_addr,
+					u32 ul_size, u32 ul_flags,
+					enum dma_data_direction dir)
 {
 	/* Keep STATUS here for future additions to this function */
 	dsp_status status = DSP_SOK;
@@ -684,7 +776,7 @@ static dsp_status proc_memory_sync(void *hprocessor, void *pmpu_addr,
 
 	pr_debug("%s: addr 0x%x, size 0x%x, type %d\n", __func__,
 							(u32)pmpu_addr,
-							ul_size, ftype);
+							ul_size, dir);
 
 	/* find requested memory are in cached mapping information */
 	map_info = find_containing_mapping(p_proc_object, (u32) pmpu_addr,
@@ -695,7 +787,8 @@ static dsp_status proc_memory_sync(void *hprocessor, void *pmpu_addr,
 		goto err_out;
 	}
 
-	if (memory_sync_page(map_info, (u32) pmpu_addr, ul_size, ftype)) {
+	if (memory_release_ownership(map_info, (u32) pmpu_addr, ul_size,
+								dir)) {
 		pr_err("%s: InValid address parameters %p %x\n",
 		       __func__, pmpu_addr, ul_size);
 		status = DSP_EHANDLE;
@@ -710,13 +803,12 @@ err_out:
  *  Purpose:
  *     Flush cache
  */
-dsp_status proc_flush_memory(void *hprocessor, void *pmpu_addr,
+dsp_status proc_begin_dma_to_dsp(void *hprocessor, void *pmpu_addr,
 			     u32 ul_size, u32 ul_flags)
 {
-	enum dsp_flushtype mtype = PROC_WRITEBACK_INVALIDATE_MEM;
+	enum dma_data_direction dir = DMA_BIDIRECTIONAL;
 
-	return proc_memory_sync(hprocessor, pmpu_addr, ul_size, ul_flags,
-				mtype);
+	return proc_begin_dma(hprocessor, pmpu_addr, ul_size, ul_flags, dir);
 }
 
 /*
@@ -724,12 +816,12 @@ dsp_status proc_flush_memory(void *hprocessor, void *pmpu_addr,
  *  Purpose:
  *     Invalidates the memory specified
  */
-dsp_status proc_invalidate_memory(void *hprocessor, void *pmpu_addr,
+dsp_status proc_begin_dma_from_dsp(void *hprocessor, void *pmpu_addr,
 				  u32 ul_size)
 {
-	enum dsp_flushtype mtype = PROC_INVALIDATE_MEM;
+	enum dma_data_direction dir = DMA_FROM_DEVICE;
 
-	return proc_memory_sync(hprocessor, pmpu_addr, ul_size, 0, mtype);
+	return proc_begin_dma(hprocessor, pmpu_addr, ul_size, 0, dir);
 }
 
 /*
-- 
1.6.3.3

