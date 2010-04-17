From: "Uribe de Leon, Armando" <x0095078@ti.com>
Subject: [PATCH 3/5] DSPBRIDGE: Remove checkpatch errors: externs
Date: Sat, 17 Apr 2010 13:47:28 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90EC26227EF@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53810 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab0DQSrf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Apr 2010 14:47:35 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "hiroshi.DOYU@nokia.com" <hiroshi.DOYU@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

>From e1d6cb8395225dc9b74ccf33440b819555c948c9 Mon Sep 17 00:00:00 2001
From: Armando Uribe De Leon <x0095078@ti.com>
Date: Thu, 8 Apr 2010 16:35:05 -0500
Subject: [PATCH 3/5] DSPBRIDGE: Remove checkpatch errors: externs

This patche is intented to remove the
checkpatch errors due to the definition
of externs in c source files.

Signed-off-by: Armando Uribe De Leon <x0095078@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dbll.h  |    1 +
 arch/arm/plat-omap/include/dspbridge/dmm.h   |    5 +++++
 arch/arm/plat-omap/include/dspbridge/io_sm.h |   11 +++++++++++
 arch/arm/plat-omap/include/dspbridge/node.h  |    2 ++
 arch/arm/plat-omap/include/dspbridge/proc.h  |    2 ++
 drivers/dsp/bridge/pmgr/dbll.c               |    1 -
 drivers/dsp/bridge/pmgr/dmm.c                |    3 ---
 drivers/dsp/bridge/rmgr/drv.c                |    1 -
 drivers/dsp/bridge/rmgr/node.c               |    4 +---
 drivers/dsp/bridge/rmgr/proc.c               |    2 --
 drivers/dsp/bridge/wmd/_tiomap.h             |    6 ++++++
 drivers/dsp/bridge/wmd/_tiomap_pwr.h         |    6 ++++++
 drivers/dsp/bridge/wmd/io_sm.c               |   10 ----------
 drivers/dsp/bridge/wmd/mmu_fault.h           |    2 ++
 drivers/dsp/bridge/wmd/tiomap3430.c          |    6 ------
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c      |    4 ----
 drivers/dsp/bridge/wmd/tiomap_io.c           |    2 +-
 drivers/dsp/bridge/wmd/ue_deh.c              |    1 -
 18 files changed, 37 insertions(+), 32 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbll.h b/arch/arm/plat-omap/include/dspbridge/dbll.h
index daf8a0a..3d40026 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbll.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbll.h
@@ -51,5 +51,6 @@ extern void dbll_set_attrs(struct dbll_tar_obj *target,  extern void dbll_unload(struct dbll_library_obj *lib, struct dbll_attrs *attrs);  extern dsp_status dbll_unload_sect(struct dbll_library_obj *lib,
 				   char *sectName, struct dbll_attrs *attrs);
+extern bool symbols_reloaded;
 
 #endif /* DBLL_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/dmm.h b/arch/arm/plat-omap/include/dspbridge/dmm.h
index c8f6549..740af6b 100644
--- a/arch/arm/plat-omap/include/dspbridge/dmm.h
+++ b/arch/arm/plat-omap/include/dspbridge/dmm.h
@@ -67,4 +67,9 @@ extern void dmm_exit(void);
 
 extern dsp_status dmm_create_tables(struct dmm_object *dmm_mgr,
 				    u32 addr, u32 size);
+
+#ifdef DSP_DMM_DEBUG
+u32 dmm_mem_map_dump(struct dmm_object *dmm_mgr); #endif
+
 #endif /* DMM_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/io_sm.h b/arch/arm/plat-omap/include/dspbridge/io_sm.h
index aa4d0cf..41e49d0 100644
--- a/arch/arm/plat-omap/include/dspbridge/io_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/io_sm.h
@@ -293,4 +293,15 @@ extern void io_sm_init(void);  extern dsp_status print_dsp_trace_buffer(struct wmd_dev_context
 					 *hwmd_context);
 
+#ifndef DSP_TRACEBUF_DISABLED
+void print_dsp_debug_trace(struct io_mgr *hio_mgr); #endif
+
+#ifdef CONFIG_BRIDGE_DVFS
+/* The maximum number of OPPs that are supported */ extern s32 
+dsp_max_opps;
+/* The Vdd1 opp table information */
+extern u32 vdd1_dsp_freq[6][4];
+#endif
+
 #endif /* IOSM_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/node.h b/arch/arm/plat-omap/include/dspbridge/node.h
index ec0dcf3..55c9d45 100644
--- a/arch/arm/plat-omap/include/dspbridge/node.h
+++ b/arch/arm/plat-omap/include/dspbridge/node.h
@@ -566,4 +566,6 @@ extern dsp_status node_get_uuid_props(void *hprocessor,
 				      OUT struct dsp_ndbprops
 				      *node_props);
 
+extern enum node_state node_get_state(bhandle hnode);
+
 #endif /* NODE_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/plat-omap/include/dspbridge/proc.h
index 0707739..24f06b6 100644
--- a/arch/arm/plat-omap/include/dspbridge/proc.h
+++ b/arch/arm/plat-omap/include/dspbridge/proc.h
@@ -598,4 +598,6 @@ extern dsp_status proc_un_reserve_memory(void *hprocessor,
 					 void *prsv_addr,
 					 struct process_context *pr_ctxt);
 
+extern char *iva_img;
+
 #endif /* PROC_ */
diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c index c983d6d..10cc303 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -143,7 +143,6 @@ struct dbll_symbol {
 	struct dbll_sym_val value;
 	char *name;
 };
-extern bool symbols_reloaded;
 
 static void dof_close(struct dbll_library_obj *zl_lib);  static dsp_status dof_open(struct dbll_library_obj *zl_lib); diff --git a/drivers/dsp/bridge/pmgr/dmm.c b/drivers/dsp/bridge/pmgr/dmm.c index be84c1e..cd47a06 100644
--- a/drivers/dsp/bridge/pmgr/dmm.c
+++ b/drivers/dsp/bridge/pmgr/dmm.c
@@ -80,9 +80,6 @@ static u32 table_size;		/* The size of virt and phys pages tables */
 static struct map_page *get_region(u32 addr);  static struct map_page *get_free_region(u32 aSize);  static struct map_page *get_mapped_region(u32 aAddr); -#ifdef DSP_DMM_DEBUG
-u32 dmm_mem_map_dump(struct dmm_object *dmm_mgr); -#endif
 
 /*  ======== dmm_create_tables ========
  *  Purpose:
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c index d970e0f..651c6eb 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -72,7 +72,6 @@ static dsp_status request_bridge_resources_dsp(u32 dw_context, s32 fRequest);
 /* GPP PROCESS CLEANUP CODE */
 
 static dsp_status drv_proc_free_node_res(bhandle hPCtxt); -extern enum node_state node_get_state(bhandle hnode);
 
 /* Allocate and add a node resource element
 * This function is called from .Node_Allocate. */ diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c index be68fa7..4c0b6e3 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -58,6 +58,7 @@
 /*  ----------------------------------- This */  #include <dspbridge/nodepriv.h>  #include <dspbridge/node.h>
+#include <dspbridge/dmm.h>
 
 /* Static/Dynamic Loader includes */
 #include <dspbridge/dbll.h>
@@ -263,9 +264,6 @@ static u32 ovly(void *priv_ref, u32 ulDspRunAddr, u32 ulDspLoadAddr,  static u32 mem_write(void *priv_ref, u32 ulDspAddr, void *pbuf,
 		     u32 ul_num_bytes, u32 nMemSpace);
 
-#ifdef DSP_DMM_DEBUG
-extern u32 dmm_mem_map_dump(struct dmm_object *dmm_mgr); -#endif
 
 static u32 refs;		/* module reference count */
 
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c index 1f7dd09..73b9572 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -77,8 +77,6 @@
 #define RBUF		0x4000		/* Input buffer */
 #define WBUF		0x8000		/* Output Buffer */
 
-extern char *iva_img;
-
 /*  ----------------------------------- Globals */
 
 /* The proc_object structure. */
diff --git a/drivers/dsp/bridge/wmd/_tiomap.h b/drivers/dsp/bridge/wmd/_tiomap.h
index a23c373..a046ef6 100644
--- a/drivers/dsp/bridge/wmd/_tiomap.h
+++ b/drivers/dsp/bridge/wmd/_tiomap.h
@@ -377,4 +377,10 @@ extern dsp_status wmd_tlb_dsp_va_to_mpu_pa(struct wmd_dev_context *dev_context,
  */
 dsp_status sm_interrupt_dsp(struct wmd_dev_context *dev_context, u16 mb_val);
 
+/*
+ *  If dsp_debug is true, do not branch to the DSP entry point and wait 
+for DSP
+ *  to boot
+ */
+extern s32 dsp_debug;
+
 #endif /* _TIOMAP_ */
diff --git a/drivers/dsp/bridge/wmd/_tiomap_pwr.h b/drivers/dsp/bridge/wmd/_tiomap_pwr.h
index a7a4fc2..f9f826c 100644
--- a/drivers/dsp/bridge/wmd/_tiomap_pwr.h
+++ b/drivers/dsp/bridge/wmd/_tiomap_pwr.h
@@ -89,4 +89,10 @@ dsp_status dsp_peripheral_clocks_enable(struct wmd_dev_context *dev_context,
  */
 void dsp_clk_wakeup_event_ctrl(u32 ClkId, bool enable);
 
+#ifdef CONFIG_PM
+extern s32 dsp_test_sleepstate;
+#endif
+
+extern struct mailbox_context mboxsetting;
+
 #endif /* _TIOMAP_PWR_ */
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c index 0517f1a..1aae17d 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -146,21 +146,11 @@ static u32 read_data(struct wmd_dev_context *hDevContext, void *dest,  static u32 write_data(struct wmd_dev_context *hDevContext, void *dest,
 		      void *pSrc, u32 usize);
 
-#ifndef DSP_TRACEBUF_DISABLED
-void print_dsp_debug_trace(struct io_mgr *hio_mgr); -#endif
-
 /* Bus Addr (cached kernel) */
 static dsp_status register_shm_segs(struct io_mgr *hio_mgr,
 				    struct cod_manager *cod_man,
 				    u32 dw_gpp_base_pa);
 
-#ifdef CONFIG_BRIDGE_DVFS
-/* The maximum number of OPPs that are supported */ -extern s32 dsp_max_opps;
-/* The Vdd1 opp table information */
-extern u32 vdd1_dsp_freq[6][4];
-#endif
 
 /*
  *  ======== bridge_io_create ========
diff --git a/drivers/dsp/bridge/wmd/mmu_fault.h b/drivers/dsp/bridge/wmd/mmu_fault.h
index 537e6e7..4a05779 100644
--- a/drivers/dsp/bridge/wmd/mmu_fault.h
+++ b/drivers/dsp/bridge/wmd/mmu_fault.h
@@ -31,4 +31,6 @@ void mmu_fault_dpc(IN unsigned long pRefData);
  */
 irqreturn_t mmu_fault_isr(int irq, IN void *pRefData);
 
+extern u32 fault_addr;
+
 #endif /* MMU_FAULT_ */
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 6480118..4d1768f 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -162,12 +162,6 @@ struct pg_table_attrs {  };
 
 /*
- *  If dsp_debug is true, do not branch to the DSP entry point and wait for DSP
- *  to boot
- */
-extern s32 dsp_debug;
-
-/*
  *  This mini driver's function interface table.
  */
 static struct bridge_drv_interface drv_interface_fxns = { diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 938d86d..e11754d 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -47,10 +47,6 @@
 #include <mach-omap2/prm-regbits-34xx.h>  #include <mach-omap2/cm-regbits-34xx.h>
 
-#ifdef CONFIG_PM
-extern s32 dsp_test_sleepstate;
-#endif
-extern struct mailbox_context mboxsetting;
 
 /*
  *  ======== handle_constraints_set ======== diff --git a/drivers/dsp/bridge/wmd/tiomap_io.c b/drivers/dsp/bridge/wmd/tiomap_io.c
index 34d3d7c..b8f43f8 100644
--- a/drivers/dsp/bridge/wmd/tiomap_io.c
+++ b/drivers/dsp/bridge/wmd/tiomap_io.c
@@ -465,4 +465,4 @@ dsp_status sm_interrupt_dsp(struct wmd_dev_context *dev_context, u16 mb_val)
 	}
 
 	return DSP_SOK;
-}
\ No newline at end of file
+}
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c index 14dd8ae..fb6022a 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -195,7 +195,6 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
 	dsp_status status = DSP_SOK;
 	u32 mem_physical = 0;
 	u32 hw_mmu_max_tlb_count = 31;
-	extern u32 fault_addr;
 	struct cfg_hostres resources;
 	hw_status hw_status_obj;
 
--
1.6.0.4

