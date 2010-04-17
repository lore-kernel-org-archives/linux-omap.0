From: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Subject: [PATCH 3/5] DSPBRIDGE: Remove DSP resources from registry
Date: Fri, 16 Apr 2010 22:33:15 -0500
Message-ID: <B852767254C5C94EBB1040EE0EFA060092D76408@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51782 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758713Ab0DQDdW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 23:33:22 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>

>From 10010c14048a946190356cc682089d35b1bf7f48 Mon Sep 17 00:00:00 2001
From: Ernesto Ramos <ernesto@ti.com>
Date: Fri, 16 Apr 2010 21:40:57 -0500
Subject: [PATCH 3/5] DSPBRIDGE: Remove DSP resources from registry

Remove DSP resources from registry.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dbdefs.h |    7 ----
 arch/arm/plat-omap/include/dspbridge/drv.h    |    7 ++++
 drivers/dsp/bridge/rmgr/drv.c                 |    8 ++--
 drivers/dsp/bridge/rmgr/drv_interface.c       |   43 ++++++++++++-------------
 drivers/dsp/bridge/rmgr/proc.c                |   10 +++++-
 drivers/dsp/bridge/services/cfg.c             |   27 ++++++---------
 drivers/dsp/bridge/wmd/tiomap3430.c           |   20 +++++-------
 7 files changed, 60 insertions(+), 62 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbdefs.h b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
index 9dcfbfb..150ad05 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
@@ -543,11 +543,4 @@ bit 15 - Output (writeable) buffer
 /* Max registry path length. Also the max registry value length. */
 #define MAXREGPATHLENGTH	255
 
-/* MiniDriver related definitions */
-#define DEFEXEC		"DefaultExecutable"	/* Default executable */
-#define AUTOSTART	"AutoStart"	/* Statically load flag */
-#define CURRENTCONFIG	"CurrentConfig"	/* Current resources */
-#define SHMSIZE		"SHMSize"	/* Size of shm reservd on MPU */
-#define TCWORDSWAP	"TCWordSwap"	/* Traffic Controller WordSwp */
-
 #endif /* DBDEFS_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-omap/include/dspbridge/drv.h
index 588aa8e..210ca68 100644
--- a/arch/arm/plat-omap/include/dspbridge/drv.h
+++ b/arch/arm/plat-omap/include/dspbridge/drv.h
@@ -123,6 +123,13 @@ enum gpp_proc_res_state {
 	PROC_RES_FREED
 };
 
+/* Bridge Data */
+struct drv_data {
+	char *base_img;
+	s32 shm_size;
+	int tc_wordswapon;
+};
+
 /* Process Context */
 struct process_context {
 	/* Process State */
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index e9bb9a8..21b6098 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -764,6 +764,7 @@ dsp_status drv_request_bridge_res_dsp(void **phost_resources)
 	u32 dw_buff_size;
 	u32 dma_addr;
 	u32 shm_size;
+	struct drv_data *drv_datap = dev_get_drvdata(bridge);
 
 	dw_buff_size = sizeof(struct cfg_hostres);
 
@@ -806,10 +807,9 @@ dsp_status drv_request_bridge_res_dsp(void **phost_resources)
 		dev_dbg(bridge, "dw_wd_timer_dsp_base %p\n",
 			host_res->dw_wd_timer_dsp_base);
 		dev_dbg(bridge, "dw_dmmu_base %p\n", host_res->dw_dmmu_base);
-		dw_buff_size = sizeof(shm_size);
-		status =
-		    reg_get_value(SHMSIZE, (u8 *) &shm_size, &dw_buff_size);
-		if (DSP_SUCCEEDED(status)) {
+
+		shm_size = drv_datap->shm_size;
+		if (shm_size >= 0x10000) {
 			/* Allocate Physically contiguous,
 			 * non-cacheable  memory */
 			host_res->dw_mem_base[1] =
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 06b3803..d9dcd14 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -247,10 +247,10 @@ static struct notifier_block iva_clk_notifier = {
 static int __devinit omap34_xx_bridge_probe(struct platform_device *pdev)
 {
 	int status;
-	u32 init_status;
-	u32 temp;
+	u32 init_status = DSP_SOK;
 	dev_t dev = 0;
 	int result;
+	struct drv_data *drv_datap = NULL;
 #ifdef CONFIG_BRIDGE_DVFS
 	int i = 0;
 #endif
@@ -300,21 +300,23 @@ static int __devinit omap34_xx_bridge_probe(struct platform_device *pdev)
 
 	/*  Autostart flag.  This should be set to true if the DSP image should
 	 *  be loaded and run during bridge module initialization */
-
-	if (base_img) {
-		temp = true;
-		reg_set_value(AUTOSTART, (u8 *) &temp, sizeof(temp));
-		reg_set_value(DEFEXEC, (u8 *) base_img, strlen(base_img) + 1);
+	drv_datap = mem_calloc(sizeof(struct drv_data), MEM_PAGED);
+	if (drv_datap) {
+		drv_datap->shm_size = shm_size;
+		drv_datap->tc_wordswapon = tc_wordswapon;
+		if (base_img) {
+			drv_datap->base_img = kmalloc(strlen(base_img) + 1,
+								GFP_KERNEL);
+			if (drv_datap->base_img)
+				strncpy(drv_datap->base_img, base_img,
+							strlen(base_img) + 1);
+			else
+				status = DSP_EMEMORY;
+		}
 	} else {
-		temp = false;
-		reg_set_value(AUTOSTART, (u8 *) &temp, sizeof(temp));
-		reg_set_value(DEFEXEC, (u8 *) "\0", (u32) 2);
+		init_status = DSP_EMEMORY;
 	}
-
-	if (shm_size >= 0x10000) {	/* 64 KB */
-		init_status = reg_set_value(SHMSIZE, (u8 *) &shm_size,
-					    sizeof(shm_size));
-	} else {
+	if (shm_size < 0x10000) {	/* 64 KB */
 		init_status = DSP_EINVALIDARG;
 		status = -1;
 		pr_err("%s: shm size must be at least 64 KB\n", __func__);
@@ -333,15 +335,11 @@ static int __devinit omap34_xx_bridge_probe(struct platform_device *pdev)
 		phys_mempool_base);
 	if ((phys_mempool_base > 0x0) && (phys_mempool_size > 0x0))
 		mem_ext_phys_pool_init(phys_mempool_base, phys_mempool_size);
-	if (tc_wordswapon) {
+	if (tc_wordswapon)
 		dev_dbg(bridge, "%s: TC Word Swap is enabled\n", __func__);
-		reg_set_value(TCWORDSWAP, (u8 *) &tc_wordswapon,
-			      sizeof(tc_wordswapon));
-	} else {
+	else
 		dev_dbg(bridge, "%s: TC Word Swap is disabled\n", __func__);
-		reg_set_value(TCWORDSWAP, (u8 *) &tc_wordswapon,
-			      sizeof(tc_wordswapon));
-	}
+
 	if (DSP_SUCCEEDED(init_status)) {
 #ifdef CONFIG_BRIDGE_DVFS
 		for (i = 0; i < 6; i++)
@@ -356,6 +354,7 @@ static int __devinit omap34_xx_bridge_probe(struct platform_device *pdev)
 			pr_err("%s: clk_notifier_register failed for iva2_ck\n",
 			       __func__);
 #endif
+		dev_set_drvdata(bridge, drv_datap);
 		driver_context = dsp_init(&init_status);
 		if (DSP_FAILED(init_status)) {
 			status = -1;
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 1f7dd09..c821be4 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -824,6 +824,7 @@ dsp_status proc_load(void *hprocessor, IN CONST s32 argc_index,
 	u32 dw_ext_end;
 	u32 proc_id;
 	int brd_state;
+	struct drv_data *drv_datap = dev_get_drvdata(bridge);
 
 #ifdef OPT_LOAD_TIME_INSTRUMENTATION
 	struct timeval tv1;
@@ -1034,8 +1035,15 @@ dsp_status proc_load(void *hprocessor, IN CONST s32 argc_index,
 		if (DSP_SUCCEEDED((*p_proc_object->intf_fxns->pfn_brd_status)
 				  (p_proc_object->hwmd_context, &brd_state))) {
 			pr_info("%s: Processor Loaded %s\n", __func__, pargv0);
-			reg_set_value(DEFEXEC, (u8 *)pargv0,
+
+			kfree(drv_datap->base_img);
+			drv_datap->base_img = kmalloc(strlen(pargv0) + 1,
+								GFP_KERNEL);
+			if (drv_datap->base_img)
+				strncpy(drv_datap->base_img, pargv0,
 							strlen(pargv0) + 1);
+			else
+				status = DSP_EMEMORY;
 			DBC_ASSERT(brd_state == BRD_LOADED);
 		}
 	}
diff --git a/drivers/dsp/bridge/services/cfg.c b/drivers/dsp/bridge/services/cfg.c
index f0d0dba..8f9f84c 100644
--- a/drivers/dsp/bridge/services/cfg.c
+++ b/drivers/dsp/bridge/services/cfg.c
@@ -29,6 +29,7 @@
 
 /*  ----------------------------------- This */
 #include <dspbridge/cfg.h>
+#include <dspbridge/drv.h>
 
 struct drv_ext {
 	struct list_head link;
@@ -55,18 +56,15 @@ dsp_status cfg_get_auto_start(struct cfg_devnode *dev_node_obj,
 {
 	dsp_status status = DSP_SOK;
 	u32 dw_buf_size;
+	struct drv_data *drv_datap = dev_get_drvdata(bridge);
 
 	dw_buf_size = sizeof(*pdwAutoStart);
 	if (!dev_node_obj)
 		status = CFG_E_INVALIDHDEVNODE;
-	if (!pdwAutoStart)
+	if (!pdwAutoStart || !drv_datap)
 		status = CFG_E_INVALIDPOINTER;
-	if (DSP_SUCCEEDED(status)) {
-		status = reg_get_value(AUTOSTART, (u8 *) pdwAutoStart,
-				       &dw_buf_size);
-		if (DSP_FAILED(status))
-			status = CFG_E_RESOURCENOTAVAIL;
-	}
+	if (DSP_SUCCEEDED(status))
+		*pdwAutoStart = drv_datap->base_img ? 1 : 0;
 
 	DBC_ENSURE((status == DSP_SOK &&
 		    (*pdwAutoStart == 0 || *pdwAutoStart == 1))
@@ -117,22 +115,19 @@ dsp_status cfg_get_exec_file(struct cfg_devnode *dev_node_obj, u32 ul_buf_size,
 			     OUT char *pstrExecFile)
 {
 	dsp_status status = DSP_SOK;
-	u32 exec_size = ul_buf_size;
+	struct drv_data *drv_datap = dev_get_drvdata(bridge);
 
 	if (!dev_node_obj)
 		status = CFG_E_INVALIDHDEVNODE;
-	else if (!pstrExecFile)
+	else if (!pstrExecFile || !drv_datap)
 		status = CFG_E_INVALIDPOINTER;
 
-	if (DSP_SUCCEEDED(status)) {
-		status =
-		    reg_get_value(DEFEXEC, (u8 *) pstrExecFile, &exec_size);
-		if (DSP_FAILED(status))
-			status = CFG_E_RESOURCENOTAVAIL;
-		else if (exec_size > ul_buf_size)
+	if (strlen(drv_datap->base_img) > ul_buf_size)
 			status = DSP_ESIZE;
 
-	}
+	if (DSP_SUCCEEDED(status) && drv_datap->base_img)
+		strcpy(pstrExecFile, drv_datap->base_img);
+
 	if (DSP_FAILED(status))
 		pr_err("%s: Failed, status 0x%x\n", __func__, status);
 	DBC_ENSURE(((status == DSP_SOK) &&
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 609cd5b..87830ec 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -929,12 +929,11 @@ static dsp_status bridge_dev_create(OUT struct wmd_dev_context **ppDevContext,
 	dsp_status status = DSP_SOK;
 	struct wmd_dev_context *dev_context = NULL;
 	s32 entry_ndx;
-	s32 tc_word_swap;
-	u32 tc_word_swap_size = sizeof(tc_word_swap);
 	struct pg_table_attrs *pt_attrs;
 	u32 pg_tbl_pa;
 	u32 pg_tbl_va;
 	u32 align_size;
+	struct drv_data *drv_datap = dev_get_drvdata(bridge);
 
 	/* Allocate and initialize a data structure to contain the mini driver
 	 *  state, which becomes the context for later calls into this WMD. */
@@ -1054,11 +1053,7 @@ static dsp_status bridge_dev_create(OUT struct wmd_dev_context **ppDevContext,
 	if (DSP_SUCCEEDED(status)) {
 		spin_lock_init(&pt_attrs->pg_lock);
 		/* Set the Endianism Register *//* Need to set this */
-		/* Retrieve the TC u16 SWAP Option */
-		status = reg_get_value(TCWORDSWAP, (u8 *) &tc_word_swap,
-				       &tc_word_swap_size);
-		/* Save the value */
-		dev_context->tc_word_swap_on = tc_word_swap;
+		dev_context->tc_word_swap_on = drv_datap->tc_wordswapon;
 	}
 	if (DSP_SUCCEEDED(status)) {
 		/* 24xx-Linux MMU address is obtained from the host
@@ -1162,8 +1157,8 @@ static dsp_status bridge_dev_destroy(struct wmd_dev_context *hDevContext)
 	struct wmd_dev_context *dev_context = (struct wmd_dev_context *)
 	    hDevContext;
 	struct cfg_hostres *host_res;
-	u32 dw_buff_size;
 	u32 shm_size;
+	struct drv_data *drv_datap = dev_get_drvdata(bridge);
 
 	/* It should never happen */
 	if (!hDevContext)
@@ -1191,10 +1186,8 @@ static dsp_status bridge_dev_destroy(struct wmd_dev_context *hDevContext)
 
 	if (dev_context->resources) {
 		host_res = dev_context->resources;
-		dw_buff_size = sizeof(shm_size);
-		status = reg_get_value(SHMSIZE, (u8 *) &shm_size,
-					       &dw_buff_size);
-		if (DSP_SUCCEEDED(status)) {
+		shm_size = drv_datap->shm_size;
+		if (shm_size >= 0x10000) {
 			if ((host_res->dw_mem_base[1]) &&
 			    (host_res->dw_mem_phys[1])) {
 				mem_free_phys_mem((void *)
@@ -1251,6 +1244,9 @@ static dsp_status bridge_dev_destroy(struct wmd_dev_context *hDevContext)
 	}
 
 	/* Free the driver's device context: */
+	kfree(drv_datap->base_img);
+	kfree(drv_datap);
+	dev_set_drvdata(bridge, NULL);
 	kfree((void *)hDevContext);
 	return status;
 }
-- 
1.5.4.5

