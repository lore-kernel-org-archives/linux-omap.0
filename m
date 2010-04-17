From: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Subject: [PATCH 1/5] DSPBRIDGE: Remove DSP resources from registry
Date: Fri, 16 Apr 2010 22:30:38 -0500
Message-ID: <B852767254C5C94EBB1040EE0EFA060092D76406@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43599 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932408Ab0DQDao convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 23:30:44 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>

>From 9ac5e14af1471b79a64076aec6b866abe87b3365 Mon Sep 17 00:00:00 2001
From: Ernesto Ramos <ernesto@ti.com>
Date: Wed, 31 Mar 2010 21:10:16 -0600
Subject: [PATCH 1/5] DSPBRIDGE: Remove DSP resources from registry

Remove DSP resources from registry.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/cfg.h     |   21 -----------
 arch/arm/plat-omap/include/dspbridge/cfgdefs.h |    9 -----
 arch/arm/plat-omap/include/dspbridge/dbdefs.h  |    1 -
 arch/arm/plat-omap/include/dspbridge/dev.h     |    4 +--
 arch/arm/plat-omap/include/dspbridge/wmd.h     |    3 +-
 drivers/dsp/bridge/pmgr/dev.c                  |   18 +++------
 drivers/dsp/bridge/rmgr/mgr.c                  |   14 ++-----
 drivers/dsp/bridge/services/cfg.c              |   45 ------------------------
 drivers/dsp/bridge/wmd/tiomap3430.c            |    6 +--
 9 files changed, 14 insertions(+), 107 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/cfg.h b/arch/arm/plat-omap/include/dspbridge/cfg.h
index 80c8fde..30e75c1 100644
--- a/arch/arm/plat-omap/include/dspbridge/cfg.h
+++ b/arch/arm/plat-omap/include/dspbridge/cfg.h
@@ -95,27 +95,6 @@ extern dsp_status cfg_get_dev_object(IN struct cfg_devnode *dev_node_obj,
 				     OUT u32 *pdwValue);
 
 /*
- *  ======== cfg_get_dsp_resources ========
- *  Purpose:
- *      Get the DSP resources available to a given device.
- *  Parameters:
- *      dev_node_obj:	Handle to the DEVNODE who's resources we are querying.
- *      pDSPResTable:   Ptr to a location to store the DSP resource table.
- *  Returns:
- *      DSP_SOK:                On success.
- *      CFG_E_INVALIDHDEVNODE:  dev_node_obj is invalid.
- *      CFG_E_RESOURCENOTAVAIL: The DSP Resource information is not
- *                              available
- *  Requires:
- *      CFG initialized.
- *  Ensures:
- *      DSP_SOK:    pDSPResTable points to a filled table of resources allocated
- *                  for the specified WMD.
- */
-extern dsp_status cfg_get_dsp_resources(IN struct cfg_devnode *dev_node_obj,
-					OUT struct cfg_dspres *pDSPResTable);
-
-/*
  *  ======== cfg_get_exec_file ========
  *  Purpose:
  *      Retreive the default executable, if any, for this board.
diff --git a/arch/arm/plat-omap/include/dspbridge/cfgdefs.h b/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
index bd24611..982eb59 100644
--- a/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
@@ -81,13 +81,4 @@ struct cfg_dspmemdesc {
 	u32 ul_max;		/* Maximum amount of memory of this type. */
 };
 
-struct cfg_dspres {
-	u32 chip_type;		/* DSP chip type. */
-	u32 word_size;		/* Number of bytes in a word */
-	u32 chip_number;	/* Number of chips. */
-	u32 mem_types;		/* Types of memory. */
-	struct cfg_dspmemdesc mem_desc[CFG_DSPMAXMEMTYPES];
-	/* DSP Memory types */
-};
-
 #endif /* CFGDEFS_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/dbdefs.h b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
index d01d9ae..9dcfbfb 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
@@ -549,6 +549,5 @@ bit 15 - Output (writeable) buffer
 #define CURRENTCONFIG	"CurrentConfig"	/* Current resources */
 #define SHMSIZE		"SHMSize"	/* Size of shm reservd on MPU */
 #define TCWORDSWAP	"TCWordSwap"	/* Traffic Controller WordSwp */
-#define DSPRESOURCES	"DspTMSResources"	/* C55 DSP resurces on OMAP */
 
 #endif /* DBDEFS_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/dev.h b/arch/arm/plat-omap/include/dspbridge/dev.h
index 13b0cad..7771ad1 100644
--- a/arch/arm/plat-omap/include/dspbridge/dev.h
+++ b/arch/arm/plat-omap/include/dspbridge/dev.h
@@ -100,8 +100,7 @@ extern dsp_status dev_create_device(OUT struct dev_object
 				    **phDevObject,
 				    IN CONST char *pstrWMDFileName,
 				    IN CONST struct cfg_hostres
-				    *pHostConfig, IN CONST struct cfg_dspres
-				    *pDspConfig,
+				    *pHostConfig,
 				    struct cfg_devnode *dev_node_obj);
 
 /*
@@ -146,7 +145,6 @@ extern dsp_status dev_create_iva_device(OUT struct dev_object
 					IN CONST char *pstrWMDFileName,
 					IN CONST struct cfg_hostres
 					*pHostConfig,
-					IN CONST struct cfg_dspres *pDspConfig,
 					struct cfg_devnode *dev_node_obj);
 
 /*
diff --git a/arch/arm/plat-omap/include/dspbridge/wmd.h b/arch/arm/plat-omap/include/dspbridge/wmd.h
index f9883db..9294a96 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmd.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmd.h
@@ -690,8 +690,7 @@ typedef dsp_status(*fxn_dev_create) (OUT struct wmd_dev_context
 				     struct dev_object
 				     * hdev_obj,
 				     IN CONST struct cfg_hostres
-				     * pConfig,
-				     IN CONST struct cfg_dspres *pDspConfig);
+				     * pConfig);
 
 /*
  *  ======== bridge_dev_ctrl ========
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index 5bc16e9..f3ca4c7 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -136,7 +136,6 @@ u32 dev_brd_write_fxn(void *pArb, u32 ulDspAddr, void *pHostBuf,
 dsp_status dev_create_device(OUT struct dev_object **phDevObject,
 			     IN CONST char *pstrWMDFileName,
 			     IN CONST struct cfg_hostres *pHostConfig,
-			     IN CONST struct cfg_dspres *pDspConfig,
 			     struct cfg_devnode *dev_node_obj)
 {
 	struct ldr_module *module_obj = NULL;
@@ -151,7 +150,6 @@ dsp_status dev_create_device(OUT struct dev_object **phDevObject,
 	DBC_REQUIRE(phDevObject != NULL);
 	DBC_REQUIRE(pstrWMDFileName != NULL);
 	DBC_REQUIRE(pHostConfig != NULL);
-	DBC_REQUIRE(pDspConfig != NULL);
 
 	/*  Get the WMD interface functions */
 	bridge_drv_entry(&drv_fxns, pstrWMDFileName);
@@ -172,7 +170,7 @@ dsp_status dev_create_device(OUT struct dev_object **phDevObject,
 			dev_obj->hchnl_mgr = NULL;
 			dev_obj->hdeh_mgr = NULL;
 			dev_obj->lock_owner = NULL;
-			dev_obj->word_size = pDspConfig->word_size;
+			dev_obj->word_size = DSPWORDSIZE;
 			dev_obj->hdrv_obj = hdrv_obj;
 			dev_obj->dev_type = DSP_UNIT;
 			/* Store this WMD's interface functions, based on its
@@ -182,7 +180,7 @@ dsp_status dev_create_device(OUT struct dev_object **phDevObject,
 			 * context handle. */
 			status = (dev_obj->wmd_interface.pfn_dev_create)
 			    (&dev_obj->hwmd_context, dev_obj,
-			     pHostConfig, pDspConfig);
+			     pHostConfig);
 			/* Assert bridge_dev_create()'s ensure clause: */
 			DBC_ASSERT(DSP_FAILED(status)
 				   || (dev_obj->hwmd_context != NULL));
@@ -200,8 +198,8 @@ dsp_status dev_create_device(OUT struct dev_object **phDevObject,
 		io_mgr_attrs.birq = pHostConfig->birq_registers;
 		io_mgr_attrs.irq_shared =
 		    (pHostConfig->birq_attrib & CFG_IRQSHARED);
-		io_mgr_attrs.word_size = pDspConfig->word_size;
-		mgr_attrs.word_size = pDspConfig->word_size;
+		io_mgr_attrs.word_size = DSPWORDSIZE;
+		mgr_attrs.word_size = DSPWORDSIZE;
 		num_windows = pHostConfig->num_mem_windows;
 		if (num_windows) {
 			/* Assume last memory window is for CHNL */
@@ -882,7 +880,6 @@ dsp_status dev_start_device(struct cfg_devnode *dev_node_obj)
 {
 	struct dev_object *hdev_obj = NULL;	/* handle to 'Bridge Device */
 	struct cfg_hostres host_res;	/* resources struct. */
-	struct cfg_dspres dsp_res;	/* DSP resources struct */
 	/* wmd filename */
 	char sz_wmd_file_name[CFG_MAXSEARCHPATHLEN] = "UMA";
 	dsp_status status;
@@ -891,15 +888,12 @@ dsp_status dev_start_device(struct cfg_devnode *dev_node_obj)
 	DBC_REQUIRE(refs > 0);
 
 	status = cfg_get_host_resources(dev_node_obj, &host_res);
-	if (DSP_SUCCEEDED(status)) {
-		/* Get DSP resources of device from Registry: */
-		status = cfg_get_dsp_resources(dev_node_obj, &dsp_res);
-	}
+
 	if (DSP_SUCCEEDED(status)) {
 		/* Given all resources, create a device object. */
 		status =
 		    dev_create_device(&hdev_obj, sz_wmd_file_name, &host_res,
-				      &dsp_res, dev_node_obj);
+				      dev_node_obj);
 		if (DSP_SUCCEEDED(status)) {
 			/* Store away the hdev_obj with the DEVNODE */
 			status =
diff --git a/drivers/dsp/bridge/rmgr/mgr.c b/drivers/dsp/bridge/rmgr/mgr.c
index cece9da..d1b67d6 100644
--- a/drivers/dsp/bridge/rmgr/mgr.c
+++ b/drivers/dsp/bridge/rmgr/mgr.c
@@ -202,7 +202,6 @@ dsp_status mgr_enum_processor_info(u32 processor_id,
 	struct drv_object *hdrv_obj;
 	s32 dev_type;
 	struct cfg_devnode *dev_node;
-	struct cfg_dspres chip_resources;
 	bool proc_detect = false;
 
 	DBC_REQUIRE(processor_info != NULL);
@@ -217,15 +216,11 @@ dsp_status mgr_enum_processor_info(u32 processor_id,
 		if (DSP_SUCCEEDED(status)) {
 			status = dev_get_dev_type(hdev_obj, (u32 *) &dev_type);
 			status = dev_get_dev_node(hdev_obj, &dev_node);
-			if (dev_type == DSP_UNIT)
-				status = cfg_get_dsp_resources(dev_node,
-							       &chip_resources);
-			else
+			if (dev_type != DSP_UNIT)
 				status = DSP_EFAIL;
 
 			if (DSP_SUCCEEDED(status)) {
-				processor_info->processor_type =
-				    chip_resources.chip_type;
+				processor_info->processor_type = DSPTYPE64;
 			}
 		}
 	}
@@ -281,8 +276,7 @@ dsp_status mgr_enum_processor_info(u32 processor_id,
 			}
 			/* User applciatiuons aonly check for chip type, so
 			 * this clumsy overwrite */
-			processor_info->processor_type =
-			    chip_resources.chip_type;
+			processor_info->processor_type = DSPTYPE64;
 		} else {
 			dev_dbg(bridge, "%s: Failed to get DCD processor info "
 				"%x\n", __func__, status2);
@@ -293,7 +287,7 @@ dsp_status mgr_enum_processor_info(u32 processor_id,
 	if (proc_detect == false) {
 		dev_dbg(bridge, "%s: Failed to get proc info from DCD, so use "
 			"CFG registry\n", __func__);
-		processor_info->processor_type = chip_resources.chip_type;
+		processor_info->processor_type = DSPTYPE64;
 	}
 func_end:
 	return status;
diff --git a/drivers/dsp/bridge/services/cfg.c b/drivers/dsp/bridge/services/cfg.c
index a3daad7..629cab1 100644
--- a/drivers/dsp/bridge/services/cfg.c
+++ b/drivers/dsp/bridge/services/cfg.c
@@ -109,38 +109,6 @@ dsp_status cfg_get_dev_object(struct cfg_devnode *dev_node_obj,
 }
 
 /*
- *  ======== cfg_get_dsp_resources ========
- *  Purpose:
- *      Get the DSP resources available to a given device.
- */
-dsp_status cfg_get_dsp_resources(struct cfg_devnode *dev_node_obj,
-				 OUT struct cfg_dspres *pDSPResTable)
-{
-	dsp_status status = DSP_SOK;	/* return value */
-	u32 dw_res_size;
-
-	if (!dev_node_obj) {
-		status = CFG_E_INVALIDHDEVNODE;
-	} else if (!pDSPResTable) {
-		status = CFG_E_INVALIDPOINTER;
-	} else {
-		status = reg_get_value(DSPRESOURCES, (u8 *) pDSPResTable,
-				       &dw_res_size);
-	}
-	if (DSP_FAILED(status)) {
-		status = CFG_E_RESOURCENOTAVAIL;
-		pr_err("%s: Failed, status 0x%x\n", __func__, status);
-	}
-	/* assert that resource values are reasonable */
-	DBC_ASSERT(pDSPResTable->chip_type < 256);
-	DBC_ASSERT(pDSPResTable->word_size > 0);
-	DBC_ASSERT(pDSPResTable->word_size < 32);
-	DBC_ASSERT(pDSPResTable->chip_number > 0);
-	DBC_ASSERT(pDSPResTable->chip_number < 256);
-	return status;
-}
-
-/*
  *  ======== cfg_get_exec_file ========
  *  Purpose:
  *      Retreive the default executable, if any, for this board.
@@ -247,19 +215,6 @@ dsp_status cfg_get_object(OUT u32 *pdwValue, u32 dw_type)
  */
 bool cfg_init(void)
 {
-	struct cfg_dspres dsp_resources;
-
-	dsp_resources.chip_type = DSPTYPE64;
-	dsp_resources.chip_number = 1;
-	dsp_resources.word_size = DSPWORDSIZE;
-	dsp_resources.mem_types = 0;
-	dsp_resources.mem_desc[0].mem_type = 0;
-	dsp_resources.mem_desc[0].ul_min = 0;
-	dsp_resources.mem_desc[0].ul_max = 0;
-	if (DSP_FAILED(reg_set_value(DSPRESOURCES, (u8 *) &dsp_resources,
-				     sizeof(struct cfg_dspres))))
-		pr_err("Failed to initialize DSP resources in registry\n");
-
 	return true;
 }
 
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 0c6cf2f..a5a21eb 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -112,8 +112,7 @@ static dsp_status bridge_brd_mem_un_map(struct wmd_dev_context *hDevContext,
 				     u32 ulVirtAddr, u32 ul_num_bytes);
 static dsp_status bridge_dev_create(OUT struct wmd_dev_context **ppDevContext,
 				    struct dev_object *hdev_obj,
-				    IN CONST struct cfg_hostres *pConfig,
-				    IN CONST struct cfg_dspres *pDspConfig);
+				    IN CONST struct cfg_hostres *pConfig);
 static dsp_status bridge_dev_ctrl(struct wmd_dev_context *dev_context,
 				  u32 dw_cmd, IN OUT void *pargs);
 static dsp_status bridge_dev_destroy(struct wmd_dev_context *dev_context);
@@ -927,8 +926,7 @@ static dsp_status bridge_brd_write(struct wmd_dev_context *hDevContext,
  */
 static dsp_status bridge_dev_create(OUT struct wmd_dev_context **ppDevContext,
 				    struct dev_object *hdev_obj,
-				    IN CONST struct cfg_hostres *pConfig,
-				    IN CONST struct cfg_dspres *pDspConfig)
+				    IN CONST struct cfg_hostres *pConfig)
 {
 	dsp_status status = DSP_SOK;
 	struct wmd_dev_context *dev_context = NULL;
-- 
1.5.4.5

