From: Ivan Gomez Castellanos <ivan.gomez@ti.com>
Subject: [PATCH 04/11] DSPBRIDGE: Rename functions which contain "wmd" and remove unused prototypes
Date: Fri, 30 Apr 2010 19:45:44 -0500
Message-ID: <1272674751-21557-5-git-send-email-ivan.gomez@ti.com>
References: <1272674751-21557-1-git-send-email-ivan.gomez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35606 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757698Ab0EAAwz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Apr 2010 20:52:55 -0400
In-Reply-To: <1272674751-21557-1-git-send-email-ivan.gomez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi.DOYU@nokia.com, ameya.palande@nokia.com, felipe.contreras@nokia.com, Ivan Gomez Castellanos <ivan.gomez@ti.com>

Since the "wmd" (windows mini driver) refers to Windows OS, the
following functions are renamed:

wmd_brd_delete ==> bridge_brd_delete
dev_get_wmd_context ==> dev_get_bridge_context

And the folowing prototypes are removed because they are not used:

cfg_get_wmd_file_name
wmd_tlb_dsp_va_to_mpu_pa

Signed-off-by: Ivan Gomez Castellanos <ivan.gomez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/cfg.h |   23 -----------------------
 arch/arm/plat-omap/include/dspbridge/dev.h |    7 ++++---
 drivers/dsp/bridge/pmgr/dev.c              |    7 ++++---
 drivers/dsp/bridge/rmgr/node.c             |    4 ++--
 drivers/dsp/bridge/rmgr/proc.c             |    4 ++--
 drivers/dsp/bridge/rmgr/pwr.c              |    8 ++++----
 drivers/dsp/bridge/wmd/_tiomap.h           |   10 ----------
 drivers/dsp/bridge/wmd/chnl_sm.c           |    4 ++--
 drivers/dsp/bridge/wmd/io_sm.c             |    4 ++--
 drivers/dsp/bridge/wmd/tiomap3430.c        |    6 +++---
 drivers/dsp/bridge/wmd/ue_deh.c            |    2 +-
 11 files changed, 24 insertions(+), 55 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/cfg.h b/arch/arm/plat-omap/include/dspbridge/cfg.h
index 80c8fde..e99d4b4 100644
--- a/arch/arm/plat-omap/include/dspbridge/cfg.h
+++ b/arch/arm/plat-omap/include/dspbridge/cfg.h
@@ -194,29 +194,6 @@ extern dsp_status cfg_get_object(OUT u32 *pdwValue, u32 dw_type);
 extern void cfg_get_perf_value(OUT bool *pfEnablePerf);
 
 /*
- *  ======== cfg_get_wmd_file_name ========
- *  Purpose:
- *    Get the mini-driver file name for a given device.
- *  Parameters:
- *      dev_node_obj:       Handle to the dev_node who's WMD we are querying.
- *      buf_size:       Size of buffer.
- *      pWMDFileName:   Ptr to a character buffer to hold the WMD filename.
- *  Returns:
- *      DSP_SOK:                On success.
- *      CFG_E_INVALIDHDEVNODE:  dev_node_obj is invalid.
- *      CFG_E_RESOURCENOTAVAIL: The filename is not available.
- *  Requires:
- *      CFG initialized.
- *  Ensures:
- *      DSP_SOK:        Not more than buf_size bytes were copied
- *                      into pWMDFileName.
- *
- */
-extern dsp_status cfg_get_wmd_file_name(IN struct cfg_devnode *dev_node_obj,
-					IN u32 buf_size,
-					OUT char *pWMDFileName);
-
-/*
  *  ======== cfg_get_zl_file ========
  *  Purpose:
  *      Retreive the ZLFile, if any, for this board.
diff --git a/arch/arm/plat-omap/include/dspbridge/dev.h b/arch/arm/plat-omap/include/dspbridge/dev.h
index d86ecd8..c26e9d0 100644
--- a/arch/arm/plat-omap/include/dspbridge/dev.h
+++ b/arch/arm/plat-omap/include/dspbridge/dev.h
@@ -509,9 +509,10 @@ extern dsp_status dev_get_symbol(struct dev_object *hdev_obj,
 				 IN CONST char *pstrSym, OUT u32 * pul_value);
 
 /*
- *  ======== dev_get_wmd_context ========
+ *  ======== dev_get_bridge_context ========
  *  Purpose:
- *      Retrieve the WMD Context handle, as returned by the WMD_Create fxn.
+ *      Retrieve the Bridge Context handle, as returned by the
+ *      bridge_dev_create fxn.
  *  Parameters:
  *      hdev_obj:     Handle to device object created with dev_create_device()
  *      *phbridge_context:  Ptr to location to store context handle.
@@ -525,7 +526,7 @@ extern dsp_status dev_get_symbol(struct dev_object *hdev_obj,
  *      DSP_SOK:        *phbridge_context contains context handle;
  *      else:           *phbridge_context is NULL;
  */
-extern dsp_status dev_get_wmd_context(struct dev_object *hdev_obj,
+extern dsp_status dev_get_bridge_context(struct dev_object *hdev_obj,
 				      OUT struct bridge_dev_context
 				      **phbridge_context);
 
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index 14e0b49..e1ebb5d 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -711,11 +711,12 @@ dsp_status dev_get_symbol(struct dev_object *hdev_obj,
 }
 
 /*
- *  ======== dev_get_wmd_context ========
+ *  ======== dev_get_bridge_context ========
  *  Purpose:
- *      Retrieve the WMD Context handle, as returned by the WMD_Create fxn.
+ *      Retrieve the Bridge Context handle, as returned by the
+ *      bridge_dev_create fxn.
  */
-dsp_status dev_get_wmd_context(struct dev_object *hdev_obj,
+dsp_status dev_get_bridge_context(struct dev_object *hdev_obj,
 			       OUT struct bridge_dev_context **phbridge_context)
 {
 	dsp_status status = DSP_SOK;
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 80a54d4..ddf54df 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -3144,7 +3144,7 @@ static u32 ovly(void *priv_ref, u32 ulDspRunAddr, u32 ulDspLoadAddr,
 
 	/* Call new MemCopy function */
 	intf_fxns = hnode_mgr->intf_fxns;
-	status = dev_get_wmd_context(hnode_mgr->hdev_obj, &hbridge_context);
+	status = dev_get_bridge_context(hnode_mgr->hdev_obj, &hbridge_context);
 	if (DSP_SUCCEEDED(status)) {
 		status = (*intf_fxns->pfn_brd_mem_copy) (hbridge_context,
 						ulDspRunAddr, ulDspLoadAddr,
@@ -3186,7 +3186,7 @@ static u32 mem_write(void *priv_ref, u32 ulDspAddr, void *pbuf,
 
 	/* Call new MemWrite function */
 	intf_fxns = hnode_mgr->intf_fxns;
-	status = dev_get_wmd_context(hnode_mgr->hdev_obj, &hbridge_context);
+	status = dev_get_bridge_context(hnode_mgr->hdev_obj, &hbridge_context);
 	status = (*intf_fxns->pfn_brd_mem_write) (hbridge_context, pbuf,
 					ulDspAddr, ul_num_bytes, mem_sect_type);
 
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index e3b9be0..6e32ad6 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -174,7 +174,7 @@ proc_attach(u32 processor_id,
 
 	status = dev_get_intf_fxns(hdev_obj, &p_proc_object->intf_fxns);
 	if (DSP_SUCCEEDED(status)) {
-		status = dev_get_wmd_context(hdev_obj,
+		status = dev_get_bridge_context(hdev_obj,
 					     &p_proc_object->hbridge_context);
 		if (DSP_FAILED(status))
 			kfree(p_proc_object);
@@ -295,7 +295,7 @@ dsp_status proc_auto_start(struct cfg_devnode *dev_node_obj,
 	p_proc_object->hmgr_obj = hmgr_obj;
 	status = dev_get_intf_fxns(hdev_obj, &p_proc_object->intf_fxns);
 	if (DSP_SUCCEEDED(status))
-		status = dev_get_wmd_context(hdev_obj,
+		status = dev_get_bridge_context(hdev_obj,
 					     &p_proc_object->hbridge_context);
 	if (DSP_FAILED(status))
 		goto func_cont;
diff --git a/drivers/dsp/bridge/rmgr/pwr.c b/drivers/dsp/bridge/rmgr/pwr.c
index e70f676..51eeb65 100644
--- a/drivers/dsp/bridge/rmgr/pwr.c
+++ b/drivers/dsp/bridge/rmgr/pwr.c
@@ -49,7 +49,7 @@ dsp_status pwr_sleep_dsp(IN CONST u32 sleepCode, IN CONST u32 timeout)
 	     hdev_obj != NULL;
 	     hdev_obj =
 	     (struct dev_object *)drv_get_next_dev_object((u32) hdev_obj)) {
-		if (DSP_FAILED(dev_get_wmd_context(hdev_obj,
+		if (DSP_FAILED(dev_get_bridge_context(hdev_obj,
 						(struct bridge_dev_context **)
 						   &dw_context))) {
 			continue;
@@ -91,7 +91,7 @@ dsp_status pwr_wake_dsp(IN CONST u32 timeout)
 	     hdev_obj != NULL;
 	     hdev_obj = (struct dev_object *)drv_get_next_dev_object
 	     ((u32) hdev_obj)) {
-		if (DSP_SUCCEEDED(dev_get_wmd_context(hdev_obj,
+		if (DSP_SUCCEEDED(dev_get_bridge_context(hdev_obj,
 						      (struct bridge_dev_context
 						       **)&dw_context))) {
 			if (DSP_SUCCEEDED
@@ -127,7 +127,7 @@ dsp_status pwr_pm_pre_scale(IN u16 voltage_domain, u32 level)
 	     hdev_obj != NULL;
 	     hdev_obj = (struct dev_object *)drv_get_next_dev_object
 	     ((u32) hdev_obj)) {
-		if (DSP_SUCCEEDED(dev_get_wmd_context(hdev_obj,
+		if (DSP_SUCCEEDED(dev_get_bridge_context(hdev_obj,
 						      (struct bridge_dev_context
 						       **)&dw_context))) {
 			if (DSP_SUCCEEDED
@@ -163,7 +163,7 @@ dsp_status pwr_pm_post_scale(IN u16 voltage_domain, u32 level)
 	     hdev_obj != NULL;
 	     hdev_obj = (struct dev_object *)drv_get_next_dev_object
 	     ((u32) hdev_obj)) {
-		if (DSP_SUCCEEDED(dev_get_wmd_context(hdev_obj,
+		if (DSP_SUCCEEDED(dev_get_bridge_context(hdev_obj,
 						      (struct bridge_dev_context
 						       **)&dw_context))) {
 			if (DSP_SUCCEEDED
diff --git a/drivers/dsp/bridge/wmd/_tiomap.h b/drivers/dsp/bridge/wmd/_tiomap.h
index 9e27e1c..b670b02 100644
--- a/drivers/dsp/bridge/wmd/_tiomap.h
+++ b/drivers/dsp/bridge/wmd/_tiomap.h
@@ -350,16 +350,6 @@ struct bridge_dev_context {
 	u32 dsp_per_clks;
 };
 
-	/*
-	 * ======== wmd_tlb_dsp_va_to_mpu_pa ========
-	 *     Given a DSP virtual address, traverse the page table and return
-	 *     a corresponding MPU physical address and size.
-	 */
-extern dsp_status wmd_tlb_dsp_va_to_mpu_pa(struct bridge_dev_context
-						*dev_context, IN u32 ulVirtAddr,
-						OUT u32 *ulPhysAddr,
-						OUT u32 *sizeTlb);
-
 /*
  *  ======== sm_interrupt_dsp ========
  *  Purpose:
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index 199a33e..51017f1 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -133,7 +133,7 @@ dsp_status bridge_chnl_add_io_req(struct chnl_object *chnl_obj, void *pHostBuf,
 	}
 
 	dev_obj = dev_get_first();
-	dev_get_wmd_context(dev_obj, &dev_ctxt);
+	dev_get_bridge_context(dev_obj, &dev_ctxt);
 	if (!dev_ctxt)
 		status = DSP_EHANDLE;
 
@@ -594,7 +594,7 @@ dsp_status bridge_chnl_get_ioc(struct chnl_object *chnl_obj, u32 dwTimeOut,
 	}
 
 	dev_obj = dev_get_first();
-	dev_get_wmd_context(dev_obj, &dev_ctxt);
+	dev_get_bridge_context(dev_obj, &dev_ctxt);
 	if (!dev_ctxt)
 		status = DSP_EHANDLE;
 
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index edb03d1..62624ad 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -193,7 +193,7 @@ dsp_status bridge_io_create(OUT struct io_mgr **phIOMgr,
 	 * size of message buffer in shared memory is configurable in
 	 * the base image.
 	 */
-	dev_get_wmd_context(hdev_obj, &hbridge_context);
+	dev_get_bridge_context(hdev_obj, &hbridge_context);
 	if (!hbridge_context) {
 		status = DSP_EHANDLE;
 		goto func_end;
@@ -272,7 +272,7 @@ dsp_status bridge_io_destroy(struct io_mgr *hio_mgr)
 	dsp_status status = DSP_SOK;
 	struct bridge_dev_context *hbridge_context;
 	if (hio_mgr) {
-		status = dev_get_wmd_context(hio_mgr->hdev_obj,
+		status = dev_get_bridge_context(hio_mgr->hdev_obj,
 						&hbridge_context);
 
 		/* Free IO DPC object */
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index c9be788..a8a2d02 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -773,14 +773,14 @@ static dsp_status bridge_brd_stop(struct bridge_dev_context *hDevContext)
 }
 
 /*
- *  ======== wmd_brd_delete ========
+ *  ======== bridge_brd_delete ========
  *  purpose:
  *      Puts DSP in Low power mode
  *
  *  Preconditions :
  *  a) None
  */
-static dsp_status wmd_brd_delete(struct bridge_dev_context *hDevContext)
+static dsp_status bridge_brd_delete(struct bridge_dev_context *hDevContext)
 {
 	dsp_status status = DSP_SOK;
 	struct bridge_dev_context *dev_context = hDevContext;
@@ -1125,7 +1125,7 @@ static dsp_status bridge_dev_destroy(struct bridge_dev_context *hDevContext)
 		return DSP_EHANDLE;
 
 	/* first put the device to stop state */
-	wmd_brd_delete(dev_context);
+	bridge_brd_delete(dev_context);
 	if (dev_context->pt_attrs) {
 		pt_attrs = dev_context->pt_attrs;
 		kfree(pt_attrs->pg_info);
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index fa8fc57..2473d3d 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -77,7 +77,7 @@ dsp_status bridge_deh_create(OUT struct deh_mgr **phDehMgr,
 	 *  size of message buffer in shared memory is configurable in
 	 *  the base image. */
 	/* Get WMD context info. */
-	dev_get_wmd_context(hdev_obj, &hbridge_context);
+	dev_get_bridge_context(hdev_obj, &hbridge_context);
 	DBC_ASSERT(hbridge_context);
 	dummy_va_addr = 0;
 	/* Allocate IO manager object: */
-- 
1.7.0.3

