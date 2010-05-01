From: Ivan Gomez Castellanos <ivan.gomez@ti.com>
Subject: [PATCH 03/11] DSPBRIDGE: Rename variables and structures which contain "wmd"
Date: Fri, 30 Apr 2010 19:45:43 -0500
Message-ID: <1272674751-21557-4-git-send-email-ivan.gomez@ti.com>
References: <1272674751-21557-1-git-send-email-ivan.gomez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36816 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986Ab0EAAwu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Apr 2010 20:52:50 -0400
In-Reply-To: <1272674751-21557-1-git-send-email-ivan.gomez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi.DOYU@nokia.com, ameya.palande@nokia.com, felipe.contreras@nokia.com, Ivan Gomez Castellanos <ivan.gomez@ti.com>

This patch removes code that refers to Windows OS (wmd = windows
mini driver). The following are renamed:

wmd_interface ==> bridge_interface
sz_wmd_file_name ==> bridge_file_name
dw_wmd_version ==> version
wmdioct_extproc ==> bridge_ioctl_extproc
pstrWMDFileName ==> driver_file_name

Signed-off-by: Ivan Gomez Castellanos <ivan.gomez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dev.h      |   12 ++++----
 arch/arm/plat-omap/include/dspbridge/wmd.h      |    2 +-
 arch/arm/plat-omap/include/dspbridge/wmdioctl.h |    2 +-
 drivers/dsp/bridge/pmgr/dev.c                   |   35 ++++++++++++-----------
 drivers/dsp/bridge/wmd/_tiomap.h                |    4 +-
 drivers/dsp/bridge/wmd/io_sm.c                  |    2 +-
 drivers/dsp/bridge/wmd/tiomap3430.c             |    9 +++--
 7 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dev.h b/arch/arm/plat-omap/include/dspbridge/dev.h
index 5bff0b8..d86ecd8 100644
--- a/arch/arm/plat-omap/include/dspbridge/dev.h
+++ b/arch/arm/plat-omap/include/dspbridge/dev.h
@@ -65,7 +65,7 @@ extern u32 dev_brd_write_fxn(void *pArb,
  *      'Bridge device.
  *  Parameters:
  *      phDevObject:    Ptr to location to receive the device object handle.
- *      pstrWMDFileName: Name of WMD PE DLL file to load.  If the absolute
+ *      driver_file_name: Name of WMD PE DLL file to load.  If the absolute
  *                      path is not provided, the file is loaded through
  *                      'Bridge's module search path.
  *      pHostConfig:    Host configuration information, to be passed down
@@ -88,7 +88,7 @@ extern u32 dev_brd_write_fxn(void *pArb,
  *  Requires:
  *      DEV Initialized.
  *      phDevObject != NULL.
- *      pstrWMDFileName != NULL.
+ *      driver_file_name != NULL.
  *      pHostConfig != NULL.
  *      pDspConfig != NULL.
  *  Ensures:
@@ -98,7 +98,7 @@ extern u32 dev_brd_write_fxn(void *pArb,
  */
 extern dsp_status dev_create_device(OUT struct dev_object
 				    **phDevObject,
-				    IN CONST char *pstrWMDFileName,
+				    IN CONST char *driver_file_name,
 				    IN CONST struct cfg_hostres
 				    *pHostConfig, IN CONST struct cfg_dspres
 				    *pDspConfig,
@@ -110,7 +110,7 @@ extern dsp_status dev_create_device(OUT struct dev_object
  *      Called by the operating system to load the 'Bridge Mini Driver for IVA.
  *  Parameters:
  *      phDevObject:    Ptr to location to receive the device object handle.
- *      pstrWMDFileName: Name of WMD PE DLL file to load.  If the absolute
+ *      driver_file_name: Name of WMD PE DLL file to load.  If the absolute
  *                      path is not provided, the file is loaded through
  *                      'Bridge's module search path.
  *      pHostConfig:    Host configuration information, to be passed down
@@ -133,7 +133,7 @@ extern dsp_status dev_create_device(OUT struct dev_object
  *  Requires:
  *      DEV Initialized.
  *      phDevObject != NULL.
- *      pstrWMDFileName != NULL.
+ *      driver_file_name != NULL.
  *      pHostConfig != NULL.
  *      pDspConfig != NULL.
  *  Ensures:
@@ -143,7 +143,7 @@ extern dsp_status dev_create_device(OUT struct dev_object
  */
 extern dsp_status dev_create_iva_device(OUT struct dev_object
 					**phDevObject,
-					IN CONST char *pstrWMDFileName,
+					IN CONST char *driver_file_name,
 					IN CONST struct cfg_hostres
 					*pHostConfig,
 					IN CONST struct cfg_dspres *pDspConfig,
diff --git a/arch/arm/plat-omap/include/dspbridge/wmd.h b/arch/arm/plat-omap/include/dspbridge/wmd.h
index 40be6da..4355590 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmd.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmd.h
@@ -1130,6 +1130,6 @@ struct bridge_drv_interface {
  *      Win95: Called during the Device_Init phase.
  */
 void bridge_drv_entry(OUT struct bridge_drv_interface **ppDrvInterface,
-		   IN CONST char *pstrWMDFileName);
+		   IN CONST char *driver_file_name);
 
 #endif /* WMD_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/wmdioctl.h b/arch/arm/plat-omap/include/dspbridge/wmdioctl.h
index 6547e38..ba921bc 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmdioctl.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmdioctl.h
@@ -59,7 +59,7 @@
 /* Number of actual DSP-MMU TLB entrries */
 #define WMDIOCTL_NUMOFMMUTLB        32
 
-struct wmdioctl_extproc {
+struct bridge_ioctl_extproc {
 	u32 ul_dsp_va;		/* DSP virtual address */
 	u32 ul_gpp_pa;		/* GPP physical address */
 	/* GPP virtual address. __va does not work for ioremapped addresses */
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index 164b65d..14e0b49 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -65,7 +65,8 @@ struct dev_object {
 	u32 dev_type;		/* Device Type */
 	struct cfg_devnode *dev_node_obj;	/* Platform specific dev id */
 	struct bridge_dev_context *hbridge_context;	/* WMD Context Handle */
-	struct bridge_drv_interface wmd_interface;	/* Function interface to WMD. */
+	/* Function interface to WMD. */
+	struct bridge_drv_interface bridge_interface;
 	struct brd_object *lock_owner;	/* Client with exclusive access. */
 	struct cod_manager *cod_mgr;	/* Code manager handle. */
 	struct chnl_mgr *hchnl_mgr;	/* Channel manager. */
@@ -109,7 +110,7 @@ u32 dev_brd_write_fxn(void *pArb, u32 ulDspAddr, void *pHostBuf,
 	if (dev_obj) {
 		/* Require of BrdWrite() */
 		DBC_ASSERT(dev_obj->hbridge_context != NULL);
-		status = (*dev_obj->wmd_interface.pfn_brd_write)
+		status = (*dev_obj->bridge_interface.pfn_brd_write)
 				(dev_obj->hbridge_context, pHostBuf, ulDspAddr,
 				ul_num_bytes, nMemSpace);
 		/* Special case of getting the address only */
@@ -129,7 +130,7 @@ u32 dev_brd_write_fxn(void *pArb, u32 ulDspAddr, void *pHostBuf,
  *      PM board (device).
  */
 dsp_status dev_create_device(OUT struct dev_object **phDevObject,
-			     IN CONST char *pstrWMDFileName,
+			     IN CONST char *driver_file_name,
 			     IN CONST struct cfg_hostres *pHostConfig,
 			     IN CONST struct cfg_dspres *pDspConfig,
 			     struct cfg_devnode *dev_node_obj)
@@ -144,12 +145,12 @@ dsp_status dev_create_device(OUT struct dev_object **phDevObject,
 	dsp_status status = DSP_SOK;
 	DBC_REQUIRE(refs > 0);
 	DBC_REQUIRE(phDevObject != NULL);
-	DBC_REQUIRE(pstrWMDFileName != NULL);
+	DBC_REQUIRE(driver_file_name != NULL);
 	DBC_REQUIRE(pHostConfig != NULL);
 	DBC_REQUIRE(pDspConfig != NULL);
 
 	/*  Get the WMD interface functions */
-	bridge_drv_entry(&drv_fxns, pstrWMDFileName);
+	bridge_drv_entry(&drv_fxns, driver_file_name);
 	if (DSP_FAILED(cfg_get_object((u32 *) &hdrv_obj, REG_DRV_OBJECT))) {
 		/* don't propogate CFG errors from this PROC function */
 		status = DSP_EFAIL;
@@ -172,10 +173,11 @@ dsp_status dev_create_device(OUT struct dev_object **phDevObject,
 			dev_obj->dev_type = DSP_UNIT;
 			/* Store this WMD's interface functions, based on its
 			 * version. */
-			store_interface_fxns(drv_fxns, &dev_obj->wmd_interface);
+			store_interface_fxns(drv_fxns,
+						&dev_obj->bridge_interface);
 			/* Call fxn_dev_create() to get the WMD's device
 			 * context handle. */
-			status = (dev_obj->wmd_interface.pfn_dev_create)
+			status = (dev_obj->bridge_interface.pfn_dev_create)
 			    (&dev_obj->hbridge_context, dev_obj,
 			     pHostConfig, pDspConfig);
 			/* Assert bridge_dev_create()'s ensure clause: */
@@ -228,7 +230,7 @@ dsp_status dev_create_device(OUT struct dev_object **phDevObject,
 		/* Only create DEH manager if we have an IO manager */
 		if (DSP_SUCCEEDED(status)) {
 			/* Instantiate the DEH module */
-			status = (*dev_obj->wmd_interface.pfn_deh_create)
+			status = (*dev_obj->bridge_interface.pfn_deh_create)
 			    (&dev_obj->hdeh_mgr, dev_obj);
 		}
 		/* Create DMM mgr . */
@@ -364,7 +366,7 @@ dsp_status dev_destroy_device(struct dev_object *hdev_obj)
 
 		if (dev_obj->hdeh_mgr) {
 			/* Uninitialize DEH module. */
-			(*dev_obj->wmd_interface.pfn_deh_destroy)
+			(*dev_obj->bridge_interface.pfn_deh_destroy)
 			    (dev_obj->hdeh_mgr);
 			dev_obj->hdeh_mgr = NULL;
 		}
@@ -381,7 +383,7 @@ dsp_status dev_destroy_device(struct dev_object *hdev_obj)
 		/* Call the driver's bridge_dev_destroy() function: */
 		/* Require of DevDestroy */
 		if (dev_obj->hbridge_context) {
-			status = (*dev_obj->wmd_interface.pfn_dev_destroy)
+			status = (*dev_obj->bridge_interface.pfn_dev_destroy)
 			    (dev_obj->hbridge_context);
 			dev_obj->hbridge_context = NULL;
 		} else
@@ -591,7 +593,7 @@ dsp_status dev_get_intf_fxns(struct dev_object *hdev_obj,
 	DBC_REQUIRE(ppIntfFxns != NULL);
 
 	if (hdev_obj) {
-		*ppIntfFxns = &dev_obj->wmd_interface;
+		*ppIntfFxns = &dev_obj->bridge_interface;
 	} else {
 		*ppIntfFxns = NULL;
 		status = DSP_EHANDLE;
@@ -877,8 +879,7 @@ dsp_status dev_start_device(struct cfg_devnode *dev_node_obj)
 	struct dev_object *hdev_obj = NULL;	/* handle to 'Bridge Device */
 	struct cfg_hostres host_res;	/* resources struct. */
 	struct cfg_dspres dsp_res;	/* DSP resources struct */
-	/* wmd filename */
-	char sz_wmd_file_name[CFG_MAXSEARCHPATHLEN] = "UMA";
+	char bridge_file_name[CFG_MAXSEARCHPATHLEN] = "UMA";
 	dsp_status status;
 	struct mgr_object *hmgr_obj = NULL;
 
@@ -892,7 +893,7 @@ dsp_status dev_start_device(struct cfg_devnode *dev_node_obj)
 	if (DSP_SUCCEEDED(status)) {
 		/* Given all resources, create a device object. */
 		status =
-		    dev_create_device(&hdev_obj, sz_wmd_file_name, &host_res,
+		    dev_create_device(&hdev_obj, bridge_file_name, &host_res,
 				      &dsp_res, dev_node_obj);
 		if (DSP_SUCCEEDED(status)) {
 			/* Store away the hdev_obj with the DEVNODE */
@@ -1078,7 +1079,7 @@ dsp_status dev_get_dev_type(struct dev_object *hdevObject, u32 *dev_type)
 static void store_interface_fxns(struct bridge_drv_interface *drv_fxns,
 				 OUT struct bridge_drv_interface *intf_fxns)
 {
-	u32 dw_wmd_version;
+	u32 version;
 
 	/* Local helper macro: */
 #define  STORE_FXN(cast, pfn) \
@@ -1089,12 +1090,12 @@ static void store_interface_fxns(struct bridge_drv_interface *drv_fxns,
 	DBC_REQUIRE(drv_fxns != NULL);
 	DBC_REQUIRE(MAKEVERSION(drv_fxns->dw_wcd_major_version,
 				drv_fxns->dw_wcd_minor_version) <= WCDVERSION);
-	dw_wmd_version = MAKEVERSION(drv_fxns->dw_wcd_major_version,
+	version = MAKEVERSION(drv_fxns->dw_wcd_major_version,
 				     drv_fxns->dw_wcd_minor_version);
 	intf_fxns->dw_wcd_major_version = drv_fxns->dw_wcd_major_version;
 	intf_fxns->dw_wcd_minor_version = drv_fxns->dw_wcd_minor_version;
 	/* Install functions up to WCD version .80 (first alpha): */
-	if (dw_wmd_version > 0) {
+	if (version > 0) {
 		STORE_FXN(fxn_dev_create, pfn_dev_create);
 		STORE_FXN(fxn_dev_destroy, pfn_dev_destroy);
 		STORE_FXN(fxn_dev_ctrl, pfn_dev_cntrl);
diff --git a/drivers/dsp/bridge/wmd/_tiomap.h b/drivers/dsp/bridge/wmd/_tiomap.h
index 4cbf1d3..9e27e1c 100644
--- a/drivers/dsp/bridge/wmd/_tiomap.h
+++ b/drivers/dsp/bridge/wmd/_tiomap.h
@@ -25,7 +25,7 @@
 #include <mach-omap2/cm-regbits-34xx.h>
 #include <dspbridge/devdefs.h>
 #include <hw_defs.h>
-#include <dspbridge/wmdioctl.h>	/* for wmdioctl_extproc defn */
+#include <dspbridge/wmdioctl.h>	/* for bridge_ioctl_extproc defn */
 #include <dspbridge/sync.h>
 #include <dspbridge/clk.h>
 
@@ -337,7 +337,7 @@ struct bridge_dev_context {
 	 * [See WMD_BRD_Ctrl()]  PROC info contains DSP-MMU TLB entries.
 	 */
 	/* DMMU TLB entries */
-	struct wmdioctl_extproc atlb_entry[WMDIOCTL_NUMOFMMUTLB];
+	struct bridge_ioctl_extproc atlb_entry[WMDIOCTL_NUMOFMMUTLB];
 	u32 dw_brd_state;	/* Last known board state. */
 	u32 ul_int_mask;	/* int mask */
 	u16 io_base;		/* Board I/O base */
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index aff0898..edb03d1 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -322,7 +322,7 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
 	u32 num_procs = 0;
 	s32 ndx = 0;
 	/* DSP MMU setup table */
-	struct wmdioctl_extproc ae_proc[WMDIOCTL_NUMOFMMUTLB];
+	struct bridge_ioctl_extproc ae_proc[WMDIOCTL_NUMOFMMUTLB];
 	struct cfg_hostres host_res;
 	u32 map_attrs;
 	u32 shm0_end;
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 29519bf..c9be788 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -255,14 +255,14 @@ static void bad_page_dump(u32 pa, struct page *pg)
  *      Mini Driver entry point.
  */
 void bridge_drv_entry(OUT struct bridge_drv_interface **ppDrvInterface,
-		   IN CONST char *pstrWMDFileName)
+		   IN CONST char *driver_file_name)
 {
 
-	DBC_REQUIRE(pstrWMDFileName != NULL);
+	DBC_REQUIRE(driver_file_name != NULL);
 
 	io_sm_init();		/* Initialization of io_sm module */
 
-	if (strcmp(pstrWMDFileName, "UMA") == 0)
+	if (strcmp(driver_file_name, "UMA") == 0)
 		*ppDrvInterface = &drv_interface_fxns;
 	else
 		dev_dbg(bridge, "%s Unknown WMD file name", __func__);
@@ -1062,7 +1062,8 @@ static dsp_status bridge_dev_ctrl(struct bridge_dev_context *dev_context,
 				  u32 dw_cmd, IN OUT void *pargs)
 {
 	dsp_status status = DSP_SOK;
-	struct wmdioctl_extproc *pa_ext_proc = (struct wmdioctl_extproc *)pargs;
+	struct bridge_ioctl_extproc *pa_ext_proc =
+					(struct bridge_ioctl_extproc *)pargs;
 	s32 ndx;
 
 	switch (dw_cmd) {
-- 
1.7.0.3

