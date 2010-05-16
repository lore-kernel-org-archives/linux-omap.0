From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 5/5] dspbridge: add CONFIG_OMAP_DSP_BACKTRACE
Date: Sun, 16 May 2010 18:47:01 +0300
Message-ID: <1274024821-21178-6-git-send-email-felipe.contreras@gmail.com>
References: <1274024821-21178-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:65511 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044Ab0EPPrS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 11:47:18 -0400
Received: by fg-out-1718.google.com with SMTP id 22so178779fge.1
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 08:47:17 -0700 (PDT)
In-Reply-To: <1274024821-21178-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

We only want this code when testing.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/plat-omap/include/dspbridge/dbll.h  |    2 ++
 arch/arm/plat-omap/include/dspbridge/gh.h    |    2 ++
 arch/arm/plat-omap/include/dspbridge/io_sm.h |    4 +++-
 arch/arm/plat-omap/include/dspbridge/nldr.h  |    2 ++
 arch/arm/plat-omap/include/dspbridge/node.h  |    2 ++
 drivers/dsp/bridge/Kconfig                   |    7 +++++++
 drivers/dsp/bridge/core/io_sm.c              |   26 ++++++++++++++------------
 drivers/dsp/bridge/core/ue_deh.c             |   13 +++++++++++++
 drivers/dsp/bridge/gen/gh.c                  |    2 ++
 drivers/dsp/bridge/pmgr/dbll.c               |    2 ++
 drivers/dsp/bridge/rmgr/nldr.c               |    2 ++
 drivers/dsp/bridge/rmgr/node.c               |    3 ++-
 12 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbll.h b/arch/arm/plat-omap/include/dspbridge/dbll.h
index 9c4c448..539e19c 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbll.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbll.h
@@ -53,7 +53,9 @@ extern void dbll_set_attrs(struct dbll_tar_obj *target,
 extern void dbll_unload(struct dbll_library_obj *lib, struct dbll_attrs *attrs);
 extern dsp_status dbll_unload_sect(struct dbll_library_obj *lib,
 				   char *sectName, struct dbll_attrs *attrs);
+#ifdef CONFIG_OMAP_DSP_BACKTRACE
 bool dbll_find_dsp_symbol(struct dbll_library_obj *zl_lib, u32 address,
 		u32 offset_range, u32 *sym_addr_output, char *name_output);
+#endif
 
 #endif /* DBLL_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/gh.h b/arch/arm/plat-omap/include/dspbridge/gh.h
index 55c0489..6ec7a10 100644
--- a/arch/arm/plat-omap/include/dspbridge/gh.h
+++ b/arch/arm/plat-omap/include/dspbridge/gh.h
@@ -27,6 +27,8 @@ extern void gh_exit(void);
 extern void *gh_find(struct gh_t_hash_tab *hash_tab, void *key);
 extern void gh_init(void);
 extern void *gh_insert(struct gh_t_hash_tab *hash_tab, void *key, void *value);
+#ifdef CONFIG_OMAP_DSP_BACKTRACE
 void gh_iterate(struct gh_t_hash_tab *hash_tab,
 	void (*callback)(void *, void *), void *user_data);
+#endif
 #endif /* GH_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/io_sm.h b/arch/arm/plat-omap/include/dspbridge/io_sm.h
index bc74dbf..95a6597 100644
--- a/arch/arm/plat-omap/include/dspbridge/io_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/io_sm.h
@@ -291,6 +291,7 @@ extern void io_intr_dsp2(IN struct io_mgr *pio_mgr, IN u16 mb_val);
 
 extern void io_sm_init(void);
 
+#ifdef CONFIG_OMAP_DSP_BACKTRACE
 /*
  *  ========print_dsp_trace_buffer ========
  *      Print DSP tracebuffer.
@@ -302,7 +303,8 @@ dsp_status dump_dsp_stack(struct bridge_dev_context *bridge_context);
 
 void dump_dl_modules(struct bridge_dev_context *bridge_context);
 
-#ifdef CONFIG_OMAP_DSP_DEBUG
+#endif
+#if defined(CONFIG_OMAP_DSP_BACKTRACE) || defined(CONFIG_OMAP_DSP_DEBUG)
 void print_dsp_debug_trace(struct io_mgr *hio_mgr);
 #endif
 
diff --git a/arch/arm/plat-omap/include/dspbridge/nldr.h b/arch/arm/plat-omap/include/dspbridge/nldr.h
index 2b930d1..22e8475 100644
--- a/arch/arm/plat-omap/include/dspbridge/nldr.h
+++ b/arch/arm/plat-omap/include/dspbridge/nldr.h
@@ -49,7 +49,9 @@ extern dsp_status nldr_load(struct nldr_nodeobject *nldr_node_obj,
 			    enum nldr_phase phase);
 extern dsp_status nldr_unload(struct nldr_nodeobject *nldr_node_obj,
 			      enum nldr_phase phase);
+#ifdef CONFIG_OMAP_DSP_BACKTRACE
 dsp_status nldr_find_addr(struct nldr_nodeobject *nldr_node, u32 sym_addr,
 	u32 offset_range, void *offset_output, char *sym_name);
+#endif
 
 #endif /* NLDR_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/node.h b/arch/arm/plat-omap/include/dspbridge/node.h
index d1135f7..91fa675 100644
--- a/arch/arm/plat-omap/include/dspbridge/node.h
+++ b/arch/arm/plat-omap/include/dspbridge/node.h
@@ -566,6 +566,7 @@ extern dsp_status node_get_uuid_props(void *hprocessor,
 				      OUT struct dsp_ndbprops
 				      *node_props);
 
+#ifdef CONFIG_OMAP_DSP_BACKTRACE
 /**
  * node_find_addr() - Find the closest symbol to the given address.
  *
@@ -583,5 +584,6 @@ dsp_status node_find_addr(struct node_mgr *node_mgr, u32 sym_addr,
 				char *sym_name);
 
 enum node_state node_get_state(void *hnode);
+#endif
 
 #endif /* NODE_ */
diff --git a/drivers/dsp/bridge/Kconfig b/drivers/dsp/bridge/Kconfig
index b2af858..e8896dc 100644
--- a/drivers/dsp/bridge/Kconfig
+++ b/drivers/dsp/bridge/Kconfig
@@ -81,3 +81,10 @@ config OMAP_DSP_NTFY_PWRERR
 	  Enable notifications to registered clients on the event of power errror
 	  trying to suspend bridge driver. Say Y, to signal this event as a fatal
 	  error, this will require a bridge restart to recover.
+
+config OMAP_DSP_BACKTRACE
+	bool "Dump backtraces on fatal errors"
+	depends on OMAP_DSP
+	help
+	  Enable useful information to backtrace fatal errors. Say Y if you
+	  want to dump information for testing purposes.
diff --git a/drivers/dsp/bridge/core/io_sm.c b/drivers/dsp/bridge/core/io_sm.c
index 268d4e6..0dde919 100644
--- a/drivers/dsp/bridge/core/io_sm.c
+++ b/drivers/dsp/bridge/core/io_sm.c
@@ -113,7 +113,7 @@ struct io_mgr {
 	struct mgr_processorextinfo ext_proc_info;
 	struct cmm_object *hcmm_mgr;	/* Shared Mem Mngr */
 	struct work_struct io_workq;	/* workqueue */
-#ifdef CONFIG_OMAP_DSP_DEBUG
+#if defined(CONFIG_OMAP_DSP_BACKTRACE) || defined(CONFIG_OMAP_DSP_DEBUG)
 	u32 ul_trace_buffer_begin;	/* Trace message start address */
 	u32 ul_trace_buffer_end;	/* Trace message end address */
 	u32 ul_trace_buffer_current;	/* Trace message current address */
@@ -209,7 +209,7 @@ dsp_status bridge_io_create(OUT struct io_mgr **phIOMgr,
 	}
 
 	/* Initialize chnl_mgr object */
-#ifdef CONFIG_OMAP_DSP_DEBUG
+#if defined(CONFIG_OMAP_DSP_BACKTRACE) || defined(CONFIG_OMAP_DSP_DEBUG)
 	pio_mgr->pmsg = NULL;
 #endif
 	pio_mgr->hchnl_mgr = hchnl_mgr;
@@ -264,7 +264,7 @@ dsp_status bridge_io_destroy(struct io_mgr *hio_mgr)
 		/* Free IO DPC object */
 		tasklet_kill(&hio_mgr->dpc_tasklet);
 
-#ifdef CONFIG_OMAP_DSP_DEBUG
+#if defined(CONFIG_OMAP_DSP_BACKTRACE) || defined(CONFIG_OMAP_DSP_DEBUG)
 		kfree(hio_mgr->pmsg);
 #endif
 		dsp_wdt_exit();
@@ -404,7 +404,7 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
 		status = CHNL_E_NOMEMMAP;
 	}
 	if (DSP_SUCCEEDED(status)) {
-#ifdef CONFIG_OMAP_DSP_DEBUG
+#if defined(CONFIG_OMAP_DSP_BACKTRACE) || defined(CONFIG_OMAP_DSP_DEBUG)
 		status =
 		    cod_get_sym_value(cod_man, DSP_TRACESEC_END, &shm0_end);
 #else
@@ -746,7 +746,7 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
 		hmsg_mgr->max_msgs);
 	memset((void *)hio_mgr->shared_mem, 0, sizeof(struct shm));
 
-#ifdef CONFIG_OMAP_DSP_DEBUG
+#if defined(CONFIG_OMAP_DSP_BACKTRACE) || defined(CONFIG_OMAP_DSP_DEBUG)
 	/* Get the start address of trace buffer */
 	status = cod_get_sym_value(cod_man, SYS_PUTCBEG,
 				   &hio_mgr->ul_trace_buffer_begin);
@@ -943,7 +943,7 @@ void io_dpc(IN OUT unsigned long pRefData)
 		    (pio_mgr->intr_val < DEH_LIMIT)) {
 			/* Notify DSP/BIOS exception */
 			if (hdeh_mgr) {
-#ifdef CONFIG_OMAP_DSP_DEBUG
+#ifdef CONFIG_OMAP_DSP_BACKTRACE
 				print_dsp_debug_trace(pio_mgr);
 #endif
 				bridge_deh_notify(hdeh_mgr, DSP_SYSERROR,
@@ -1804,7 +1804,12 @@ dsp_status bridge_io_get_proc_load(IN struct io_mgr *hio_mgr,
 	return DSP_SOK;
 }
 
-#ifdef CONFIG_OMAP_DSP_DEBUG
+void io_sm_init(void)
+{
+	/* Do nothing */
+}
+
+#if defined(CONFIG_OMAP_DSP_BACKTRACE) || defined(CONFIG_OMAP_DSP_DEBUG)
 void print_dsp_debug_trace(struct io_mgr *hio_mgr)
 {
 	u32 ul_new_message_length = 0, ul_gpp_cur_pointer;
@@ -1865,6 +1870,7 @@ void print_dsp_debug_trace(struct io_mgr *hio_mgr)
 }
 #endif
 
+#ifdef CONFIG_OMAP_DSP_BACKTRACE
 /*
  *  ======== print_dsp_trace_buffer ========
  *      Prints the trace buffer returned from the DSP (if DBG_Trace is enabled).
@@ -2037,10 +2043,6 @@ func_end:
 	return status;
 }
 
-void io_sm_init(void)
-{
-	/* Do nothing */
-}
 /**
  * dump_dsp_stack() - This function dumps the data on the DSP stack.
  * @bridge_context:	Mini driver's device context pointer.
@@ -2363,4 +2365,4 @@ void dump_dl_modules(struct bridge_dev_context *bridge_context)
 func_end:
 	kfree(module_struct);
 }
-
+#endif
diff --git a/drivers/dsp/bridge/core/ue_deh.c b/drivers/dsp/bridge/core/ue_deh.c
index 6611929..dc3bb67 100644
--- a/drivers/dsp/bridge/core/ue_deh.c
+++ b/drivers/dsp/bridge/core/ue_deh.c
@@ -31,6 +31,7 @@
 #include <dspbridge/drv.h>
 #include <dspbridge/wdt.h>
 
+#ifdef CONFIG_OMAP_DSP_BACKTRACE
 /* GP Timer number to trigger interrupt for MMU-fault ISR on DSP */
 #define GPTIMER_FOR_DSP_MMU_FAULT      8
 /* Bit mask to enable overflow interrupt */
@@ -39,6 +40,8 @@
 #define GPTIMER_IRQ_WAIT_MAX_CNT       1000
 
 static struct omap_dm_timer *timer;
+#endif
+
 static u32 fault_addr;
 
 static void mmu_fault_dpc(unsigned long data)
@@ -129,6 +132,7 @@ int bridge_deh_create(struct deh_mgr **ret_deh,
 	if (status < 0)
 		goto err;
 
+#ifdef CONFIG_OMAP_DSP_BACKTRACE
 	timer = omap_dm_timer_request_specific(GPTIMER_FOR_DSP_MMU_FAULT);
 	if (!timer) {
 		pr_err("%s: GPTimer not available\n", __func__);
@@ -136,6 +140,7 @@ int bridge_deh_create(struct deh_mgr **ret_deh,
 		goto err;
 	}
 	omap_dm_timer_disable(timer);
+#endif
 
 	*ret_deh = deh;
 	return 0;
@@ -165,9 +170,11 @@ int bridge_deh_destroy(struct deh_mgr *deh)
 	/* Deallocate the DEH manager object */
 	kfree(deh);
 
+#ifdef CONFIG_OMAP_DSP_BACKTRACE
 	/* The GPTimer is no longer needed */
 	omap_dm_timer_free(timer);
 	timer = NULL;
+#endif
 
 	return 0;
 }
@@ -186,6 +193,7 @@ int bridge_deh_register_notify(struct deh_mgr *deh, u32 event_mask,
 		return ntfy_unregister(deh->ntfy_obj, hnotification);
 }
 
+#ifdef CONFIG_OMAP_DSP_BACKTRACE
 static void wait_for_timer(void)
 {
 	int c;
@@ -248,6 +256,7 @@ static void mmu_fault_print_stack(struct bridge_dev_context *dev_context)
 	hw_mmu_disable(resources->dw_dmmu_base);
 	free_page((unsigned long)dummy_va_addr);
 }
+#endif
 
 static inline const char *event_to_string(int event)
 {
@@ -275,15 +284,19 @@ void bridge_deh_notify(struct deh_mgr *deh, int event, int info)
 	case DSP_SYSERROR:
 		dev_err(bridge, "%s: %s, info=0x%x", __func__,
 				str, info);
+#ifdef CONFIG_OMAP_DSP_BACKTRACE
 		dump_dl_modules(dev_context);
 		dump_dsp_stack(dev_context);
+#endif
 		break;
 	case DSP_MMUFAULT:
 		dev_err(bridge, "%s: %s, addr=0x%x", __func__,
 				str, fault_addr);
+#ifdef CONFIG_OMAP_DSP_BACKTRACE
 		print_dsp_trace_buffer(dev_context);
 		dump_dl_modules(dev_context);
 		mmu_fault_print_stack(dev_context);
+#endif
 		break;
 	default:
 		dev_err(bridge, "%s: %s", __func__, str);
diff --git a/drivers/dsp/bridge/gen/gh.c b/drivers/dsp/bridge/gen/gh.c
index d1e7b38..ebb11ab 100644
--- a/drivers/dsp/bridge/gen/gh.c
+++ b/drivers/dsp/bridge/gen/gh.c
@@ -188,6 +188,7 @@ static void myfree(void *ptr, s32 size)
 	gs_free(ptr);
 }
 
+#ifdef CONFIG_OMAP_DSP_BACKTRACE
 /**
  * gh_iterate() - This function goes through all the elements in the hash table
  *		looking for the dsp symbols.
@@ -211,3 +212,4 @@ void gh_iterate(struct gh_t_hash_tab *hash_tab,
 			}
 		}
 }
+#endif
diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index 020c948..4a3920d 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -1501,6 +1501,7 @@ static void release(struct dynamic_loader_initialize *this)
 {
 }
 
+#ifdef CONFIG_OMAP_DSP_BACKTRACE
 /**
  *  find_symbol_context - Basic symbol context structure
  * @address:		Symbol Adress
@@ -1584,3 +1585,4 @@ bool dbll_find_dsp_symbol(struct dbll_library_obj *zl_lib, u32 address,
 
 	return status;
 }
+#endif
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index 6d8c646..41f0853 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -1919,6 +1919,7 @@ static u32 find_gcf(u32 a, u32 b)
 	return b;
 }
 
+#ifdef CONFIG_OMAP_DSP_BACKTRACE
 /**
  * nldr_find_addr() - Find the closest symbol to the given address based on
  *		dynamic node object.
@@ -1997,3 +1998,4 @@ dsp_status nldr_find_addr(struct nldr_nodeobject *nldr_node, u32 sym_addr,
 
 	return status;
 }
+#endif
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 43f3890..ff614b9 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -3194,6 +3194,7 @@ static u32 mem_write(void *priv_ref, u32 ulDspAddr, void *pbuf,
 	return ul_num_bytes;
 }
 
+#ifdef CONFIG_OMAP_DSP_BACKTRACE
 /*
  *  ======== node_find_addr ========
  */
@@ -3223,4 +3224,4 @@ dsp_status node_find_addr(struct node_mgr *node_mgr, u32 sym_addr,
 
 	return status;
 }
-
+#endif
-- 
1.7.1

