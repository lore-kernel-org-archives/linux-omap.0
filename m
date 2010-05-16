From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/5] dspbridge: use CONFIG_OMAP_DSP_DEBUG for debug trace
Date: Sun, 16 May 2010 18:47:00 +0300
Message-ID: <1274024821-21178-5-git-send-email-felipe.contreras@gmail.com>
References: <1274024821-21178-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53342 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753895Ab0EPPrP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 11:47:15 -0400
Received: by mail-fx0-f46.google.com with SMTP id 6so2978216fxm.19
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 08:47:15 -0700 (PDT)
In-Reply-To: <1274024821-21178-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Obviously nobody was using DSP_TRACEBUF_DISABLED, since it wasn't even
standarized between TRACEBUF and TRACE_BUF.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/plat-omap/include/dspbridge/io_sm.h |    2 +-
 drivers/dsp/bridge/core/io_sm.c              |   16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/io_sm.h b/arch/arm/plat-omap/include/dspbridge/io_sm.h
index 732aa4f..bc74dbf 100644
--- a/arch/arm/plat-omap/include/dspbridge/io_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/io_sm.h
@@ -302,7 +302,7 @@ dsp_status dump_dsp_stack(struct bridge_dev_context *bridge_context);
 
 void dump_dl_modules(struct bridge_dev_context *bridge_context);
 
-#ifndef DSP_TRACEBUF_DISABLED
+#ifdef CONFIG_OMAP_DSP_DEBUG
 void print_dsp_debug_trace(struct io_mgr *hio_mgr);
 #endif
 
diff --git a/drivers/dsp/bridge/core/io_sm.c b/drivers/dsp/bridge/core/io_sm.c
index 161b598..268d4e6 100644
--- a/drivers/dsp/bridge/core/io_sm.c
+++ b/drivers/dsp/bridge/core/io_sm.c
@@ -113,7 +113,7 @@ struct io_mgr {
 	struct mgr_processorextinfo ext_proc_info;
 	struct cmm_object *hcmm_mgr;	/* Shared Mem Mngr */
 	struct work_struct io_workq;	/* workqueue */
-#ifndef DSP_TRACEBUF_DISABLED
+#ifdef CONFIG_OMAP_DSP_DEBUG
 	u32 ul_trace_buffer_begin;	/* Trace message start address */
 	u32 ul_trace_buffer_end;	/* Trace message end address */
 	u32 ul_trace_buffer_current;	/* Trace message current address */
@@ -209,7 +209,7 @@ dsp_status bridge_io_create(OUT struct io_mgr **phIOMgr,
 	}
 
 	/* Initialize chnl_mgr object */
-#ifndef DSP_TRACEBUF_DISABLED
+#ifdef CONFIG_OMAP_DSP_DEBUG
 	pio_mgr->pmsg = NULL;
 #endif
 	pio_mgr->hchnl_mgr = hchnl_mgr;
@@ -264,7 +264,7 @@ dsp_status bridge_io_destroy(struct io_mgr *hio_mgr)
 		/* Free IO DPC object */
 		tasklet_kill(&hio_mgr->dpc_tasklet);
 
-#ifndef DSP_TRACEBUF_DISABLED
+#ifdef CONFIG_OMAP_DSP_DEBUG
 		kfree(hio_mgr->pmsg);
 #endif
 		dsp_wdt_exit();
@@ -404,7 +404,7 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
 		status = CHNL_E_NOMEMMAP;
 	}
 	if (DSP_SUCCEEDED(status)) {
-#ifndef DSP_TRACEBUF_DISABLED
+#ifdef CONFIG_OMAP_DSP_DEBUG
 		status =
 		    cod_get_sym_value(cod_man, DSP_TRACESEC_END, &shm0_end);
 #else
@@ -746,7 +746,7 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
 		hmsg_mgr->max_msgs);
 	memset((void *)hio_mgr->shared_mem, 0, sizeof(struct shm));
 
-#ifndef DSP_TRACEBUF_DISABLED
+#ifdef CONFIG_OMAP_DSP_DEBUG
 	/* Get the start address of trace buffer */
 	status = cod_get_sym_value(cod_man, SYS_PUTCBEG,
 				   &hio_mgr->ul_trace_buffer_begin);
@@ -943,7 +943,7 @@ void io_dpc(IN OUT unsigned long pRefData)
 		    (pio_mgr->intr_val < DEH_LIMIT)) {
 			/* Notify DSP/BIOS exception */
 			if (hdeh_mgr) {
-#ifndef DSP_TRACE_BUF_DISABLED
+#ifdef CONFIG_OMAP_DSP_DEBUG
 				print_dsp_debug_trace(pio_mgr);
 #endif
 				bridge_deh_notify(hdeh_mgr, DSP_SYSERROR,
@@ -955,7 +955,7 @@ void io_dpc(IN OUT unsigned long pRefData)
 		if (msg_mgr_obj)
 			io_dispatch_msg(pio_mgr, msg_mgr_obj);
 #endif
-#ifndef DSP_TRACEBUF_DISABLED
+#ifdef CONFIG_OMAP_DSP_DEBUG
 		if (pio_mgr->intr_val & MBX_DBG_SYSPRINTF) {
 			/* Notify DSP Trace message */
 			print_dsp_debug_trace(pio_mgr);
@@ -1804,7 +1804,7 @@ dsp_status bridge_io_get_proc_load(IN struct io_mgr *hio_mgr,
 	return DSP_SOK;
 }
 
-#ifndef DSP_TRACEBUF_DISABLED
+#ifdef CONFIG_OMAP_DSP_DEBUG
 void print_dsp_debug_trace(struct io_mgr *hio_mgr)
 {
 	u32 ul_new_message_length = 0, ul_gpp_cur_pointer;
-- 
1.7.1

