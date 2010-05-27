From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH v3 7/7] DSPBRIDGE: add new PROC_BEGINDMA and PROC_ENDDMA ioctls
Date: Thu, 27 May 2010 19:02:14 +0300
Message-ID: <1274976134-22769-8-git-send-email-ohad@wizery.com>
References: <1274976134-22769-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:14152 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932132Ab0E0QCt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 May 2010 12:02:49 -0400
Received: by fg-out-1718.google.com with SMTP id d23so83476fga.1
        for <linux-omap@vger.kernel.org>; Thu, 27 May 2010 09:02:49 -0700 (PDT)
In-Reply-To: <1274976134-22769-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Contreras <felipe.contreras@gmail.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>

Add two new dspbridge ioctls that mark the
beginnind and end of a DMA transfer.
The direction of the DMA transfer is given as a parameter,
thus all three directions (DMA_BIDIRECTIONAL, DMA_TO_DEVICE
and DMA_FROM_DEVICE) are supported.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
If you want, you can also reach me at <  ohadb at ti dot com  >.

 .../arm/plat-omap/include/dspbridge/dspapi-ioctl.h |    9 ++++++
 arch/arm/plat-omap/include/dspbridge/dspapi.h      |    2 +
 arch/arm/plat-omap/include/dspbridge/proc.h        |   29 +++++++++++++++++++
 drivers/dsp/bridge/pmgr/dspapi.c                   |   30 ++++++++++++++++++++
 drivers/dsp/bridge/rmgr/proc.c                     |    4 +-
 5 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dspapi-ioctl.h b/arch/arm/plat-omap/include/dspbridge/dspapi-ioctl.h
index 1780855..6ed2dcc 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspapi-ioctl.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspapi-ioctl.h
@@ -153,6 +153,13 @@ union Trapped_Args {
 		void *hprocessor;
 		void *pmpu_addr;
 		u32 ul_size;
+		u32 dir;
+	} args_proc_dma;
+
+	struct {
+		void *hprocessor;
+		void *pmpu_addr;
+		u32 ul_size;
 		u32 ul_flags;
 	} args_proc_flushmemory;
 
@@ -426,6 +433,8 @@ union Trapped_Args {
 #define PROC_FLUSHMEMORY	_IOW(DB, DB_IOC(DB_PROC, 14), unsigned long)
 #define PROC_STOP		_IOWR(DB, DB_IOC(DB_PROC, 15), unsigned long)
 #define PROC_INVALIDATEMEMORY	_IOW(DB, DB_IOC(DB_PROC, 16), unsigned long)
+#define PROC_BEGINDMA		_IOW(DB, DB_IOC(DB_PROC, 17), unsigned long)
+#define PROC_ENDDMA		_IOW(DB, DB_IOC(DB_PROC, 18), unsigned long)
 
 /* NODE Module */
 #define NODE_ALLOCATE		_IOWR(DB, DB_IOC(DB_NODE, 0), unsigned long)
diff --git a/arch/arm/plat-omap/include/dspbridge/dspapi.h b/arch/arm/plat-omap/include/dspbridge/dspapi.h
index 565c800..e821c7b 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspapi.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspapi.h
@@ -126,6 +126,8 @@ extern u32 procwrap_un_map(union Trapped_Args *args, void *pr_ctxt);
 extern u32 procwrap_flush_memory(union Trapped_Args *args, void *pr_ctxt);
 extern u32 procwrap_stop(union Trapped_Args *args, void *pr_ctxt);
 extern u32 procwrap_invalidate_memory(union Trapped_Args *args, void *pr_ctxt);
+extern u32 procwrap_begin_dma(union Trapped_Args *args, void *pr_ctxt);
+extern u32 procwrap_end_dma(union Trapped_Args *args, void *pr_ctxt);
 
 /* NODE wrapper functions */
 extern u32 nodewrap_allocate(union Trapped_Args *args, void *pr_ctxt);
diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/plat-omap/include/dspbridge/proc.h
index 18b51c5..58fcdea 100644
--- a/arch/arm/plat-omap/include/dspbridge/proc.h
+++ b/arch/arm/plat-omap/include/dspbridge/proc.h
@@ -456,6 +456,35 @@ extern dsp_status proc_start(void *hprocessor);
 extern dsp_status proc_stop(void *hprocessor);
 
 /*
+ *  ======== proc_end_dma ========
+ *  Purpose:
+ *      Begin a DMA transfer
+ *  Parameters:
+ *      hprocessor      :   The processor handle.
+ *      pmpu_addr	:   Buffer start address
+ *      ul_size		:   Buffer size
+ *      dir		:   The direction of the transfer
+ *  Requires:
+ *      Memory was previously mapped.
+ */
+extern int proc_end_dma(void *hprocessor, void *pmpu_addr, u32 ul_size,
+						enum dma_data_direction dir);
+/*
+ *  ======== proc_begin_dma ========
+ *  Purpose:
+ *      Begin a DMA transfer
+ *  Parameters:
+ *      hprocessor      :   The processor handle.
+ *      pmpu_addr	:   Buffer start address
+ *      ul_size		:   Buffer size
+ *      dir		:   The direction of the transfer
+ *  Requires:
+ *      Memory was previously mapped.
+ */
+extern int proc_begin_dma(void *hprocessor, void *pmpu_addr, u32 ul_size,
+						enum dma_data_direction dir);
+
+/*
  *  ======== proc_flush_memory ========
  *  Purpose:
  *      Flushes a buffer from the MPU data cache.
diff --git a/drivers/dsp/bridge/pmgr/dspapi.c b/drivers/dsp/bridge/pmgr/dspapi.c
index cc64a99..2da2021 100644
--- a/drivers/dsp/bridge/pmgr/dspapi.c
+++ b/drivers/dsp/bridge/pmgr/dspapi.c
@@ -113,6 +113,8 @@ static struct api_cmd proc_cmd[] = {
 	{procwrap_flush_memory},	/* PROC_FLUSHMEMORY */
 	{procwrap_stop},	/* PROC_STOP */
 	{procwrap_invalidate_memory},	/* PROC_INVALIDATEMEMORY */
+	{procwrap_begin_dma},	/* PROC_BEGINDMA */
+	{procwrap_end_dma},	/* PROC_ENDDMA */
 };
 
 /* NODE wrapper functions */
@@ -677,6 +679,34 @@ u32 procwrap_enum_node_info(union Trapped_Args *args, void *pr_ctxt)
 	return status;
 }
 
+u32 procwrap_end_dma(union Trapped_Args *args, void *pr_ctxt)
+{
+	dsp_status status;
+
+	if (args->args_proc_dma.dir >= DMA_NONE)
+		return -EINVAL;
+
+	status = proc_end_dma(pr_ctxt,
+				   args->args_proc_dma.pmpu_addr,
+				   args->args_proc_dma.ul_size,
+				   args->args_proc_dma.dir);
+	return status;
+}
+
+u32 procwrap_begin_dma(union Trapped_Args *args, void *pr_ctxt)
+{
+	dsp_status status;
+
+	if (args->args_proc_dma.dir >= DMA_NONE)
+		return -EINVAL;
+
+	status = proc_begin_dma(pr_ctxt,
+				   args->args_proc_dma.pmpu_addr,
+				   args->args_proc_dma.ul_size,
+				   args->args_proc_dma.dir);
+	return status;
+}
+
 /*
  * ======== procwrap_flush_memory ========
  */
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index e952d2e..93db51b 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -741,7 +741,7 @@ out:
 	return ret;
 }
 
-static int proc_begin_dma(void *hprocessor, void *pmpu_addr, u32 ul_size,
+int proc_begin_dma(void *hprocessor, void *pmpu_addr, u32 ul_size,
 				enum dma_data_direction dir)
 {
 	/* Keep STATUS here for future additions to this function */
@@ -779,7 +779,7 @@ err_out:
 	return status;
 }
 
-static int proc_end_dma(void *hprocessor, void *pmpu_addr, u32 ul_size,
+int proc_end_dma(void *hprocessor, void *pmpu_addr, u32 ul_size,
 			enum dma_data_direction dir)
 {
 	/* Keep STATUS here for future additions to this function */
-- 
1.7.0.4

