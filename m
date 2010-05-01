From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [RFC/PATCH 6/6] DSPBRIDGE: add dspbridge API to mark end of DMA
Date: Sat,  1 May 2010 23:44:31 +0300
Message-ID: <1272746671-13423-7-git-send-email-ohad@wizery.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:38080 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021Ab0EAUsF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 May 2010 16:48:05 -0400
Received: by fg-out-1718.google.com with SMTP id 19so364986fgg.1
        for <linux-omap@vger.kernel.org>; Sat, 01 May 2010 13:48:04 -0700 (PDT)
In-Reply-To: <1272746671-13423-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>

Standard DMA API is built upon the notion of "buffer ownership".
The buffer is either exclusively owned by the MPU (and therefore
may be accessed by it) or exclusively owned by the DMA device
(in our case, the dsp remote processor).
This patch adds the missing dspbridge API with which the MM
application can mark the end of a DMA transfer (and thus regain
ownership of the buffer).

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
If you want, you can also reach me at <  ohadb at ti dot com  >.

 arch/arm/plat-omap/include/dspbridge/_dcd.h     |    2 +
 arch/arm/plat-omap/include/dspbridge/proc.h     |    4 +
 arch/arm/plat-omap/include/dspbridge/wcdioctl.h |    2 +
 drivers/dsp/bridge/pmgr/wcd.c                   |   27 +++++++
 drivers/dsp/bridge/rmgr/proc.c                  |   87 +++++++++++++++++++++++
 5 files changed, 122 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/_dcd.h b/arch/arm/plat-omap/include/dspbridge/_dcd.h
index 0af4a31..adfcf67 100644
--- a/arch/arm/plat-omap/include/dspbridge/_dcd.h
+++ b/arch/arm/plat-omap/include/dspbridge/_dcd.h
@@ -113,6 +113,8 @@ extern u32 procwrap_un_map(union Trapped_Args *args, void *pr_ctxt);
 extern u32 procwrap_begin_dma_to_dsp(union Trapped_Args *args, void *pr_ctxt);
 extern u32 procwrap_stop(union Trapped_Args *args, void *pr_ctxt);
 extern u32 procwrap_begin_dma_from_dsp(union Trapped_Args *args, void *pr_ctxt);
+extern u32 procwrap_end_dma_to_dsp(union Trapped_Args *args, void *pr_ctxt);
+extern u32 procwrap_end_dma_from_dsp(union Trapped_Args *args, void *pr_ctxt);
 
 /* NODE wrapper functions */
 extern u32 nodewrap_allocate(union Trapped_Args *args, void *pr_ctxt);
diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/plat-omap/include/dspbridge/proc.h
index f8450a6..7a7b8e8 100644
--- a/arch/arm/plat-omap/include/dspbridge/proc.h
+++ b/arch/arm/plat-omap/include/dspbridge/proc.h
@@ -474,6 +474,8 @@ extern dsp_status proc_stop(void *hprocessor);
  */
 extern dsp_status proc_begin_dma_to_dsp(void *hprocessor,
 				    void *pmpu_addr, u32 ul_size, u32 ul_flags);
+extern dsp_status proc_end_dma_to_dsp(void *hprocessor,
+				    void *pmpu_addr, u32 ul_size, u32 ul_flags);
 
 /*
  *  ======== proc_invalidate_memory ========
@@ -495,6 +497,8 @@ extern dsp_status proc_begin_dma_to_dsp(void *hprocessor,
  */
 extern dsp_status proc_begin_dma_from_dsp(void *hprocessor,
 					 void *pmpu_addr, u32 ul_size);
+extern dsp_status proc_end_dma_from_dsp(void *hprocessor,
+					 void *pmpu_addr, u32 ul_size);
 
 /*
  *  ======== proc_map ========
diff --git a/arch/arm/plat-omap/include/dspbridge/wcdioctl.h b/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
index aba2078..a6debf2 100644
--- a/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
+++ b/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
@@ -455,6 +455,8 @@ union Trapped_Args {
 #define PROC_BEGINDMATODSP	_IOW(DB, DB_IOC(DB_PROC, 14), unsigned long)
 #define PROC_STOP		_IOWR(DB, DB_IOC(DB_PROC, 15), unsigned long)
 #define PROC_BEGINDMAFROMDSP	_IOW(DB, DB_IOC(DB_PROC, 16), unsigned long)
+#define PROC_ENDDMATODSP	_IOW(DB, DB_IOC(DB_PROC, 17), unsigned long)
+#define PROC_ENDDMAFROMDSP	_IOW(DB, DB_IOC(DB_PROC, 18), unsigned long)
 
 /* NODE Module */
 #define NODE_ALLOCATE		_IOWR(DB, DB_IOC(DB_NODE, 0), unsigned long)
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 89243f1..ae6e8ab 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -114,6 +114,8 @@ static struct wcd_cmd proc_cmd[] = {
 	{procwrap_begin_dma_to_dsp},	/* PROC_BEGINDMATODSP */
 	{procwrap_stop},	/* PROC_STOP */
 	{procwrap_begin_dma_from_dsp},	/* PROC_BEGINDMAFROMDSP */
+	{procwrap_end_dma_to_dsp},	/* PROC_ENDDMATODSP */
+	{procwrap_end_dma_from_dsp},	/* PROC_ENDDMAFROMDSP */
 };
 
 /* NODE wrapper functions */
@@ -709,6 +711,31 @@ u32 procwrap_begin_dma_from_dsp(union Trapped_Args *args, void *pr_ctxt)
 	return status;
 }
 
+u32 procwrap_end_dma_to_dsp(union Trapped_Args *args, void *pr_ctxt)
+{
+	dsp_status status;
+
+	if (args->args_proc_flushmemory.ul_flags >
+	    PROC_WRITEBACK_INVALIDATE_MEM)
+		return DSP_EINVALIDARG;
+
+	status = proc_end_dma_to_dsp(args->args_proc_flushmemory.hprocessor,
+				   args->args_proc_flushmemory.pmpu_addr,
+				   args->args_proc_flushmemory.ul_size,
+				   args->args_proc_flushmemory.ul_flags);
+	return status;
+}
+
+u32 procwrap_end_dma_from_dsp(union Trapped_Args *args, void *pr_ctxt)
+{
+	dsp_status status;
+
+	status =
+	    proc_end_dma_from_dsp(args->args_proc_invalidatememory.hprocessor,
+				   args->args_proc_invalidatememory.pmpu_addr,
+				   args->args_proc_invalidatememory.ul_size);
+	return status;
+}
 /*
  * ======== procwrap_enum_resources ========
  */
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 8a76681..c185cd1 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -700,6 +700,36 @@ out:
 	return ret;
 }
 
+static int memory_regain_ownership(struct memory_map_info *map_info,
+		unsigned long start, ssize_t len, enum dma_data_direction dir)
+{
+	int ret = 0;
+	unsigned long first_data_page = start >> PAGE_SHIFT;
+	unsigned long last_data_page = ((u32)(start + len - 1) >> PAGE_SHIFT);
+	/* calculating the number of pages this area spans */
+	unsigned long num_pages = last_data_page - first_data_page + 1;
+	struct bridge_dma_map_info *dma_info = &map_info->dma_info;
+
+	if (!dma_info->sg)
+		goto out;
+
+	if (dma_info->dir != dir || dma_info->num_pages != num_pages) {
+		pr_err("%s: dma info doesn't match given params\n", __func__);
+		return -EINVAL;
+	}
+
+	dma_unmap_sg(bridge, dma_info->sg, num_pages, dma_info->dir);
+
+	pr_debug("%s: dma_map_sg unmapped\n", __func__);
+
+	kfree(dma_info->sg);
+
+	map_info->dma_info.sg = NULL;
+
+out:
+	return ret;
+}
+
 /* Cache operation against kernel address instead of users */
 static int memory_release_ownership(struct memory_map_info *map_info,
 		unsigned long start, ssize_t len, enum dma_data_direction dir)
@@ -798,6 +828,47 @@ err_out:
 	return status;
 }
 
+static dsp_status proc_end_dma(void *hprocessor, void *pmpu_addr,
+				   u32 ul_size, u32 ul_flags,
+				   enum dsp_flushtype ftype)
+{
+	/* Keep STATUS here for future additions to this function */
+	dsp_status status = DSP_SOK;
+	struct proc_object *p_proc_object = (struct proc_object *)hprocessor;
+	struct memory_map_info *map_info;
+
+	DBC_REQUIRE(refs > 0);
+
+	if (!MEM_IS_VALID_HANDLE(p_proc_object, PROC_SIGNATURE)) {
+		status = DSP_EHANDLE;
+		goto err_out;
+	}
+
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
+
+	if (memory_regain_ownership(map_info, (u32) pmpu_addr, ul_size,
+								ftype)) {
+		pr_err("%s: InValid address parameters %p %x\n",
+		       __func__, pmpu_addr, ul_size);
+		status = DSP_EHANDLE;
+		goto err_out;
+	}
+
+err_out:
+	return status;
+}
+
 /*
  *  ======== proc_flush_memory ========
  *  Purpose:
@@ -824,6 +895,22 @@ dsp_status proc_begin_dma_from_dsp(void *hprocessor, void *pmpu_addr,
 	return proc_begin_dma(hprocessor, pmpu_addr, ul_size, 0, dir);
 }
 
+dsp_status proc_end_dma_to_dsp(void *hprocessor, void *pmpu_addr,
+			     u32 ul_size, u32 ul_flags)
+{
+	enum dma_data_direction dir = DMA_BIDIRECTIONAL;
+
+	return proc_end_dma(hprocessor, pmpu_addr, ul_size, ul_flags, dir);
+}
+
+dsp_status proc_end_dma_from_dsp(void *hprocessor, void *pmpu_addr,
+							u32 ul_size)
+{
+	enum dma_data_direction dir = DMA_FROM_DEVICE;
+
+	return proc_end_dma(hprocessor, pmpu_addr, ul_size, 0, dir);
+}
+
 /*
  *  ======== proc_get_resource_info ========
  *  Purpose:
-- 
1.6.3.3

