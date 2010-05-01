From: Ivan Gomez Castellanos <ivan.gomez@ti.com>
Subject: [PATCH 02/11] DSPBRIDGE: Rename the device context handle variables
Date: Fri, 30 Apr 2010 19:45:42 -0500
Message-ID: <1272674751-21557-3-git-send-email-ivan.gomez@ti.com>
References: <1272674751-21557-1-git-send-email-ivan.gomez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49440 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757231Ab0EAAwv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Apr 2010 20:52:51 -0400
In-Reply-To: <1272674751-21557-1-git-send-email-ivan.gomez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi.DOYU@nokia.com, ameya.palande@nokia.com, felipe.contreras@nokia.com, Ivan Gomez Castellanos <ivan.gomez@ti.com>

The name of these variables contains "wmd", which refers to Windows OS,
So they are renamed as follows:

hwmd_context ==> hbridge_context
pwmd_context ==> pbridge_context
phWmdContext ==> phbridge_context

Signed-off-by: Ivan Gomez Castellanos <ivan.gomez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dev.h   |   10 +-
 arch/arm/plat-omap/include/dspbridge/io_sm.h |    2 +-
 drivers/dsp/bridge/pmgr/dev.c                |   33 +++---
 drivers/dsp/bridge/pmgr/ioobj.h              |    2 +-
 drivers/dsp/bridge/rmgr/node.c               |   19 ++--
 drivers/dsp/bridge/rmgr/proc.c               |   34 +++---
 drivers/dsp/bridge/wmd/_deh.h                |    2 +-
 drivers/dsp/bridge/wmd/chnl_sm.c             |    4 +-
 drivers/dsp/bridge/wmd/io_sm.c               |  136 +++++++++++++-------------
 drivers/dsp/bridge/wmd/mmu_fault.c           |    2 +-
 drivers/dsp/bridge/wmd/tiomap_io.c           |   10 +-
 drivers/dsp/bridge/wmd/ue_deh.c              |   14 ++--
 12 files changed, 135 insertions(+), 133 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dev.h b/arch/arm/plat-omap/include/dspbridge/dev.h
index 6df8db7..5bff0b8 100644
--- a/arch/arm/plat-omap/include/dspbridge/dev.h
+++ b/arch/arm/plat-omap/include/dspbridge/dev.h
@@ -514,20 +514,20 @@ extern dsp_status dev_get_symbol(struct dev_object *hdev_obj,
  *      Retrieve the WMD Context handle, as returned by the WMD_Create fxn.
  *  Parameters:
  *      hdev_obj:     Handle to device object created with dev_create_device()
- *      *phWmdContext:  Ptr to location to store context handle.
+ *      *phbridge_context:  Ptr to location to store context handle.
  *  Returns:
  *      DSP_SOK:        Success.
  *      DSP_EHANDLE:    Invalid hdev_obj.
  *  Requires:
- *      phWmdContext != NULL.
+ *      phbridge_context != NULL.
  *      DEV Initialized.
  *  Ensures:
- *      DSP_SOK:        *phWmdContext contains context handle;
- *      else:           *phWmdContext is NULL;
+ *      DSP_SOK:        *phbridge_context contains context handle;
+ *      else:           *phbridge_context is NULL;
  */
 extern dsp_status dev_get_wmd_context(struct dev_object *hdev_obj,
 				      OUT struct bridge_dev_context
-				      **phWmdContext);
+				      **phbridge_context);
 
 /*
  *  ======== dev_exit ========
diff --git a/arch/arm/plat-omap/include/dspbridge/io_sm.h b/arch/arm/plat-omap/include/dspbridge/io_sm.h
index 177bfeb..1df7664 100644
--- a/arch/arm/plat-omap/include/dspbridge/io_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/io_sm.h
@@ -289,6 +289,6 @@ extern void io_sm_init(void);
  *      Print DSP tracebuffer.
  */
 extern dsp_status print_dsp_trace_buffer(struct bridge_dev_context
-					 *hwmd_context);
+					 *hbridge_context);
 
 #endif /* IOSM_ */
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index 62ff655..164b65d 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -64,7 +64,7 @@ struct dev_object {
 	struct list_head link;	/* Link to next dev_object. */
 	u32 dev_type;		/* Device Type */
 	struct cfg_devnode *dev_node_obj;	/* Platform specific dev id */
-	struct bridge_dev_context *hwmd_context;	/* WMD Context Handle */
+	struct bridge_dev_context *hbridge_context;	/* WMD Context Handle */
 	struct bridge_drv_interface wmd_interface;	/* Function interface to WMD. */
 	struct brd_object *lock_owner;	/* Client with exclusive access. */
 	struct cod_manager *cod_mgr;	/* Code manager handle. */
@@ -108,11 +108,10 @@ u32 dev_brd_write_fxn(void *pArb, u32 ulDspAddr, void *pHostBuf,
 	DBC_REQUIRE(pHostBuf != NULL);	/* Required of BrdWrite(). */
 	if (dev_obj) {
 		/* Require of BrdWrite() */
-		DBC_ASSERT(dev_obj->hwmd_context != NULL);
-		status =
-		    (*dev_obj->wmd_interface.
-		     pfn_brd_write) (dev_obj->hwmd_context, pHostBuf, ulDspAddr,
-				     ul_num_bytes, nMemSpace);
+		DBC_ASSERT(dev_obj->hbridge_context != NULL);
+		status = (*dev_obj->wmd_interface.pfn_brd_write)
+				(dev_obj->hbridge_context, pHostBuf, ulDspAddr,
+				ul_num_bytes, nMemSpace);
 		/* Special case of getting the address only */
 		if (ul_num_bytes == 0)
 			ul_num_bytes = 1;
@@ -177,11 +176,11 @@ dsp_status dev_create_device(OUT struct dev_object **phDevObject,
 			/* Call fxn_dev_create() to get the WMD's device
 			 * context handle. */
 			status = (dev_obj->wmd_interface.pfn_dev_create)
-			    (&dev_obj->hwmd_context, dev_obj,
+			    (&dev_obj->hbridge_context, dev_obj,
 			     pHostConfig, pDspConfig);
 			/* Assert bridge_dev_create()'s ensure clause: */
 			DBC_ASSERT(DSP_FAILED(status)
-				   || (dev_obj->hwmd_context != NULL));
+				   || (dev_obj->hbridge_context != NULL));
 		} else {
 			status = DSP_EMEMORY;
 		}
@@ -381,10 +380,10 @@ dsp_status dev_destroy_device(struct dev_object *hdev_obj)
 
 		/* Call the driver's bridge_dev_destroy() function: */
 		/* Require of DevDestroy */
-		if (dev_obj->hwmd_context) {
+		if (dev_obj->hbridge_context) {
 			status = (*dev_obj->wmd_interface.pfn_dev_destroy)
-			    (dev_obj->hwmd_context);
-			dev_obj->hwmd_context = NULL;
+			    (dev_obj->hbridge_context);
+			dev_obj->hbridge_context = NULL;
 		} else
 			status = DSP_EFAIL;
 		if (DSP_SUCCEEDED(status)) {
@@ -715,23 +714,23 @@ dsp_status dev_get_symbol(struct dev_object *hdev_obj,
  *      Retrieve the WMD Context handle, as returned by the WMD_Create fxn.
  */
 dsp_status dev_get_wmd_context(struct dev_object *hdev_obj,
-			       OUT struct bridge_dev_context **phWmdContext)
+			       OUT struct bridge_dev_context **phbridge_context)
 {
 	dsp_status status = DSP_SOK;
 	struct dev_object *dev_obj = hdev_obj;
 
 	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(phWmdContext != NULL);
+	DBC_REQUIRE(phbridge_context != NULL);
 
 	if (hdev_obj) {
-		*phWmdContext = dev_obj->hwmd_context;
+		*phbridge_context = dev_obj->hbridge_context;
 	} else {
-		*phWmdContext = NULL;
+		*phbridge_context = NULL;
 		status = DSP_EHANDLE;
 	}
 
-	DBC_ENSURE(DSP_SUCCEEDED(status) || ((phWmdContext != NULL) &&
-					     (*phWmdContext == NULL)));
+	DBC_ENSURE(DSP_SUCCEEDED(status) || ((phbridge_context != NULL) &&
+					     (*phbridge_context == NULL)));
 	return status;
 }
 
diff --git a/drivers/dsp/bridge/pmgr/ioobj.h b/drivers/dsp/bridge/pmgr/ioobj.h
index 5dd02bf..8717f8a 100644
--- a/drivers/dsp/bridge/pmgr/ioobj.h
+++ b/drivers/dsp/bridge/pmgr/ioobj.h
@@ -31,7 +31,7 @@
 struct io_mgr_ {
 	/* These must be the first fields in a io_mgr struct: */
 	/* WMD device context. */
-	struct bridge_dev_context *hwmd_context;
+	struct bridge_dev_context *hbridge_context;
 	struct bridge_drv_interface *intf_fxns;	/* Function interface to WMD. */
 	struct dev_object *hdev_obj;	/* Device this board represents. */
 };
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 0edf6ae..80a54d4 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -3132,7 +3132,7 @@ static u32 ovly(void *priv_ref, u32 ulDspRunAddr, u32 ulDspLoadAddr,
 	u32 ul_size;
 	u32 ul_timeout;
 	dsp_status status = DSP_SOK;
-	struct bridge_dev_context *hwmd_context;
+	struct bridge_dev_context *hbridge_context;
 	struct bridge_drv_interface *intf_fxns;	/* Function interface to WMD */
 
 	DBC_REQUIRE(hnode);
@@ -3144,12 +3144,11 @@ static u32 ovly(void *priv_ref, u32 ulDspRunAddr, u32 ulDspLoadAddr,
 
 	/* Call new MemCopy function */
 	intf_fxns = hnode_mgr->intf_fxns;
-	status = dev_get_wmd_context(hnode_mgr->hdev_obj, &hwmd_context);
+	status = dev_get_wmd_context(hnode_mgr->hdev_obj, &hbridge_context);
 	if (DSP_SUCCEEDED(status)) {
-		status =
-		    (*intf_fxns->pfn_brd_mem_copy) (hwmd_context, ulDspRunAddr,
-						    ulDspLoadAddr, ul_num_bytes,
-						    (u32) nMemSpace);
+		status = (*intf_fxns->pfn_brd_mem_copy) (hbridge_context,
+						ulDspRunAddr, ulDspLoadAddr,
+						ul_num_bytes, (u32) nMemSpace);
 		if (DSP_SUCCEEDED(status))
 			ul_bytes = ul_num_bytes;
 		else
@@ -3174,7 +3173,7 @@ static u32 mem_write(void *priv_ref, u32 ulDspAddr, void *pbuf,
 	u16 mem_sect_type;
 	u32 ul_timeout;
 	dsp_status status = DSP_SOK;
-	struct bridge_dev_context *hwmd_context;
+	struct bridge_dev_context *hbridge_context;
 	struct bridge_drv_interface *intf_fxns;	/* Function interface to WMD */
 
 	DBC_REQUIRE(hnode);
@@ -3187,9 +3186,9 @@ static u32 mem_write(void *priv_ref, u32 ulDspAddr, void *pbuf,
 
 	/* Call new MemWrite function */
 	intf_fxns = hnode_mgr->intf_fxns;
-	status = dev_get_wmd_context(hnode_mgr->hdev_obj, &hwmd_context);
-	status = (*intf_fxns->pfn_brd_mem_write) (hwmd_context, pbuf, ulDspAddr,
-						  ul_num_bytes, mem_sect_type);
+	status = dev_get_wmd_context(hnode_mgr->hdev_obj, &hbridge_context);
+	status = (*intf_fxns->pfn_brd_mem_write) (hbridge_context, pbuf,
+					ulDspAddr, ul_num_bytes, mem_sect_type);
 
 	return ul_num_bytes;
 }
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index bdcb862..e3b9be0 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -95,7 +95,7 @@ struct proc_object {
 					 * GPP Client attached
 					 */
 	struct ntfy_object *ntfy_obj;	/* Manages  notifications */
-	struct bridge_dev_context *hwmd_context;	/* WMD Context Handle */
+	struct bridge_dev_context *hbridge_context;	/* WMD Context Handle */
 	struct bridge_drv_interface *intf_fxns;	/* Function interface to WMD */
 	char *psz_last_coff;
 	struct list_head proc_list;
@@ -175,7 +175,7 @@ proc_attach(u32 processor_id,
 	status = dev_get_intf_fxns(hdev_obj, &p_proc_object->intf_fxns);
 	if (DSP_SUCCEEDED(status)) {
 		status = dev_get_wmd_context(hdev_obj,
-					     &p_proc_object->hwmd_context);
+					     &p_proc_object->hbridge_context);
 		if (DSP_FAILED(status))
 			kfree(p_proc_object);
 	} else
@@ -296,7 +296,7 @@ dsp_status proc_auto_start(struct cfg_devnode *dev_node_obj,
 	status = dev_get_intf_fxns(hdev_obj, &p_proc_object->intf_fxns);
 	if (DSP_SUCCEEDED(status))
 		status = dev_get_wmd_context(hdev_obj,
-					     &p_proc_object->hwmd_context);
+					     &p_proc_object->hbridge_context);
 	if (DSP_FAILED(status))
 		goto func_cont;
 
@@ -369,7 +369,7 @@ dsp_status proc_ctrl(void *hprocessor, u32 dw_cmd, IN struct dsp_cbdata * arg)
 			status = pwr_wake_dsp(timeout);
 		} else
 		    if (DSP_SUCCEEDED((*p_proc_object->intf_fxns->pfn_dev_cntrl)
-				      (p_proc_object->hwmd_context, dw_cmd,
+				      (p_proc_object->hbridge_context, dw_cmd,
 				       arg))) {
 			status = DSP_SOK;
 		} else {
@@ -717,7 +717,7 @@ dsp_status proc_get_state(void *hprocessor,
 	if (p_proc_object) {
 		/* First, retrieve BRD state information */
 		status = (*p_proc_object->intf_fxns->pfn_brd_status)
-		    (p_proc_object->hwmd_context, &brd_status);
+		    (p_proc_object->hbridge_context, &brd_status);
 		if (DSP_SUCCEEDED(status)) {
 			switch (brd_status) {
 			case BRD_STOPPED:
@@ -986,7 +986,7 @@ dsp_status proc_load(void *hprocessor, IN CONST s32 argc_index,
 	if (DSP_SUCCEEDED(status)) {
 		/* Update the Processor status to loaded */
 		status = (*p_proc_object->intf_fxns->pfn_brd_set_state)
-		    (p_proc_object->hwmd_context, BRD_LOADED);
+		    (p_proc_object->hbridge_context, BRD_LOADED);
 		if (DSP_SUCCEEDED(status)) {
 			p_proc_object->proc_state = PROC_LOADED;
 			if (p_proc_object->ntfy_obj)
@@ -1026,7 +1026,7 @@ dsp_status proc_load(void *hprocessor, IN CONST s32 argc_index,
 	user_args[0] = pargv0;
 	if (DSP_SUCCEEDED(status)) {
 		if (DSP_SUCCEEDED((*p_proc_object->intf_fxns->pfn_brd_status)
-				  (p_proc_object->hwmd_context, &brd_state))) {
+				(p_proc_object->hbridge_context, &brd_state))) {
 			pr_info("%s: Processor Loaded %s\n", __func__, pargv0);
 			reg_set_value(DEFEXEC, (u8 *)pargv0,
 							strlen(pargv0) + 1);
@@ -1101,7 +1101,7 @@ dsp_status proc_map(void *hprocessor, void *pmpu_addr, u32 ul_size,
 	if (DSP_SUCCEEDED(status)) {
 
 		status = (*p_proc_object->intf_fxns->pfn_brd_mem_map)
-		    (p_proc_object->hwmd_context, pa_align, va_align,
+		    (p_proc_object->hbridge_context, pa_align, va_align,
 		     size_align, ul_map_attr);
 	}
 	if (DSP_SUCCEEDED(status)) {
@@ -1295,7 +1295,7 @@ dsp_status proc_start(void *hprocessor)
 		goto func_cont;
 
 	status = (*p_proc_object->intf_fxns->pfn_brd_start)
-	    (p_proc_object->hwmd_context, dw_dsp_addr);
+	    (p_proc_object->hbridge_context, dw_dsp_addr);
 	if (DSP_FAILED(status))
 		goto func_cont;
 
@@ -1315,13 +1315,13 @@ dsp_status proc_start(void *hprocessor)
 		/* Failed to Create Node Manager and DISP Object
 		 * Stop the Processor from running. Put it in STOPPED State */
 		(void)(*p_proc_object->intf_fxns->
-		       pfn_brd_stop) (p_proc_object->hwmd_context);
+		       pfn_brd_stop) (p_proc_object->hbridge_context);
 		p_proc_object->proc_state = PROC_STOPPED;
 	}
 func_cont:
 	if (DSP_SUCCEEDED(status)) {
 		if (DSP_SUCCEEDED((*p_proc_object->intf_fxns->pfn_brd_status)
-				  (p_proc_object->hwmd_context, &brd_state))) {
+				(p_proc_object->hbridge_context, &brd_state))) {
 			pr_info("%s: dsp in running state\n", __func__);
 			DBC_ASSERT(brd_state != BRD_HIBERNATION);
 		}
@@ -1358,7 +1358,7 @@ dsp_status proc_stop(void *hprocessor)
 		goto func_end;
 	}
 	if (DSP_SUCCEEDED((*p_proc_object->intf_fxns->pfn_brd_status)
-			  (p_proc_object->hwmd_context, &brd_state))) {
+			  (p_proc_object->hbridge_context, &brd_state))) {
 		if (brd_state == BRD_ERROR)
 			bridge_deh_release_dummy_mem();
 	}
@@ -1377,7 +1377,7 @@ dsp_status proc_stop(void *hprocessor)
 	/* It is OK to stop a device that does n't have nodes OR not started */
 	status =
 	    (*p_proc_object->intf_fxns->
-	     pfn_brd_stop) (p_proc_object->hwmd_context);
+	     pfn_brd_stop) (p_proc_object->hbridge_context);
 	if (DSP_SUCCEEDED(status)) {
 		dev_dbg(bridge, "%s: processor in standby mode\n", __func__);
 		p_proc_object->proc_state = PROC_STOPPED;
@@ -1392,7 +1392,7 @@ dsp_status proc_stop(void *hprocessor)
 			if (DSP_SUCCEEDED
 			    ((*p_proc_object->
 			      intf_fxns->pfn_brd_status) (p_proc_object->
-							  hwmd_context,
+							  hbridge_context,
 							  &brd_state)))
 				DBC_ASSERT(brd_state == BRD_STOPPED);
 		}
@@ -1439,7 +1439,7 @@ dsp_status proc_un_map(void *hprocessor, void *map_addr,
 	/* Remove mapping from the page tables. */
 	if (DSP_SUCCEEDED(status)) {
 		status = (*p_proc_object->intf_fxns->pfn_brd_mem_un_map)
-		    (p_proc_object->hwmd_context, va_align, size_align);
+		    (p_proc_object->hbridge_context, va_align, size_align);
 	}
 	mutex_unlock(&proc_lock);
 	if (DSP_FAILED(status))
@@ -1552,10 +1552,10 @@ static dsp_status proc_monitor(struct proc_object *p_proc_object)
 	}
 	/* Place the Board in the Monitor State */
 	if (DSP_SUCCEEDED((*p_proc_object->intf_fxns->pfn_brd_monitor)
-			  (p_proc_object->hwmd_context))) {
+			  (p_proc_object->hbridge_context))) {
 		status = DSP_SOK;
 		if (DSP_SUCCEEDED((*p_proc_object->intf_fxns->pfn_brd_status)
-				  (p_proc_object->hwmd_context, &brd_state)))
+				  (p_proc_object->hbridge_context, &brd_state)))
 			DBC_ASSERT(brd_state == BRD_IDLE);
 	}
 
diff --git a/drivers/dsp/bridge/wmd/_deh.h b/drivers/dsp/bridge/wmd/_deh.h
index faa7a2e..a7e74b0 100644
--- a/drivers/dsp/bridge/wmd/_deh.h
+++ b/drivers/dsp/bridge/wmd/_deh.h
@@ -25,7 +25,7 @@
 /* DEH Manager: only one created per board: */
 struct deh_mgr {
 	/* Bridge device context. */
-	struct bridge_dev_context *hwmd_context;
+	struct bridge_dev_context *hbridge_context;
 	struct ntfy_object *ntfy_obj;	/* NTFY object */
 	struct dsp_errorinfo err_info;	/* DSP exception info. */
 
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index 600710d..199a33e 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -96,7 +96,7 @@ dsp_status bridge_chnl_add_io_req(struct chnl_object *chnl_obj, void *pHostBuf,
 	dsp_status status = DSP_SOK;
 	struct chnl_object *pchnl = (struct chnl_object *)chnl_obj;
 	struct chnl_irp *chnl_packet_obj = NULL;
-	struct wmd_dev_context *dev_ctxt;
+	struct bridge_dev_context *dev_ctxt;
 	struct dev_object *dev_obj;
 	u32 dw_state;
 	bool is_eos;
@@ -579,7 +579,7 @@ dsp_status bridge_chnl_get_ioc(struct chnl_object *chnl_obj, u32 dwTimeOut,
 	bool dequeue_ioc = true;
 	struct chnl_ioc ioc = { NULL, 0, 0, 0, 0 };
 	u8 *host_sys_buf = NULL;
-	struct wmd_dev_context *dev_ctxt;
+	struct bridge_dev_context *dev_ctxt;
 	struct dev_object *dev_obj;
 
 	/* Check args: */
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index d452f98..aff0898 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -83,7 +83,7 @@
 /* IO Manager: only one created per board */
 struct io_mgr {
 	/* These four fields must be the first fields in a io_mgr_ struct */
-	struct bridge_dev_context *hwmd_context;	/* WMD device context */
+	struct bridge_dev_context *hbridge_context;	/* WMD device context */
 	struct bridge_drv_interface *intf_fxns;	/* Function interface to WMD */
 	struct dev_object *hdev_obj;	/* Device this board represents */
 
@@ -172,7 +172,7 @@ dsp_status bridge_io_create(OUT struct io_mgr **phIOMgr,
 	dsp_status status = DSP_SOK;
 	struct io_mgr *pio_mgr = NULL;
 	struct shm *shared_mem = NULL;
-	struct bridge_dev_context *hwmd_context = NULL;
+	struct bridge_dev_context *hbridge_context = NULL;
 	struct cfg_hostres host_res;
 	struct cfg_devnode *dev_node_obj;
 	struct chnl_mgr *hchnl_mgr;
@@ -193,8 +193,8 @@ dsp_status bridge_io_create(OUT struct io_mgr **phIOMgr,
 	 * size of message buffer in shared memory is configurable in
 	 * the base image.
 	 */
-	dev_get_wmd_context(hdev_obj, &hwmd_context);
-	if (!hwmd_context) {
+	dev_get_wmd_context(hdev_obj, &hbridge_context);
+	if (!hbridge_context) {
 		status = DSP_EHANDLE;
 		goto func_end;
 	}
@@ -241,7 +241,7 @@ dsp_status bridge_io_create(OUT struct io_mgr **phIOMgr,
 						&host_res);
 	}
 	if (DSP_SUCCEEDED(status)) {
-		pio_mgr->hwmd_context = hwmd_context;
+		pio_mgr->hbridge_context = hbridge_context;
 		pio_mgr->shared_irq = pMgrAttrs->irq_shared;
 		if (dsp_wdt_init())
 			status = DSP_EFAIL;
@@ -270,9 +270,10 @@ func_end:
 dsp_status bridge_io_destroy(struct io_mgr *hio_mgr)
 {
 	dsp_status status = DSP_SOK;
-	struct bridge_dev_context *hwmd_context;
+	struct bridge_dev_context *hbridge_context;
 	if (hio_mgr) {
-		status = dev_get_wmd_context(hio_mgr->hdev_obj, &hwmd_context);
+		status = dev_get_wmd_context(hio_mgr->hdev_obj,
+						&hbridge_context);
 
 		/* Free IO DPC object */
 		tasklet_kill(&hio_mgr->dpc_tasklet);
@@ -504,7 +505,7 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
 							      1)) == 0)) {
 				status =
 				    hio_mgr->intf_fxns->
-				    pfn_brd_mem_map(hio_mgr->hwmd_context,
+				    pfn_brd_mem_map(hio_mgr->hbridge_context,
 						    pa_curr, va_curr,
 						    page_size[i], map_attrs);
 				if (DSP_FAILED(status))
@@ -569,7 +570,7 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
 			} else {
 				status =
 				    hio_mgr->intf_fxns->
-				    pfn_brd_mem_map(hio_mgr->hwmd_context,
+				    pfn_brd_mem_map(hio_mgr->hbridge_context,
 						    pa_curr, va_curr,
 						    page_size[i], map_attrs);
 				dev_dbg(bridge,
@@ -636,7 +637,7 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
 				ndx++;
 			} else {
 				status = hio_mgr->intf_fxns->pfn_brd_mem_map
-				    (hio_mgr->hwmd_context,
+				    (hio_mgr->hbridge_context,
 				     hio_mgr->ext_proc_info.ty_tlb[i].
 				     ul_gpp_phys,
 				     hio_mgr->ext_proc_info.ty_tlb[i].
@@ -657,7 +658,7 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
 	i = 0;
 	while (l4_peripheral_table[i].phys_addr) {
 		status = hio_mgr->intf_fxns->pfn_brd_mem_map
-		    (hio_mgr->hwmd_context, l4_peripheral_table[i].phys_addr,
+		    (hio_mgr->hbridge_context, l4_peripheral_table[i].phys_addr,
 		     l4_peripheral_table[i].dsp_virt_addr, HW_PAGE_SIZE4KB,
 		     map_attrs);
 		if (DSP_FAILED(status))
@@ -702,7 +703,7 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
 		 */
 
 		status =
-		    hio_mgr->intf_fxns->pfn_dev_cntrl(hio_mgr->hwmd_context,
+		    hio_mgr->intf_fxns->pfn_dev_cntrl(hio_mgr->hbridge_context,
 						      WMDIOCTL_SETMMUCONFIG,
 						      ae_proc);
 		if (DSP_FAILED(status))
@@ -824,10 +825,10 @@ void io_cancel_chnl(struct io_mgr *hio_mgr, u32 ulChnl)
 	sm = hio_mgr->shared_mem;
 
 	/* Inform DSP that we have no more buffers on this channel */
-	IO_AND_VALUE(pio_mgr->hwmd_context, struct shm, sm, host_free_mask,
+	IO_AND_VALUE(pio_mgr->hbridge_context, struct shm, sm, host_free_mask,
 		     (~(1 << ulChnl)));
 
-	sm_interrupt_dsp(pio_mgr->hwmd_context, MBX_PCPY_CLASS);
+	sm_interrupt_dsp(pio_mgr->hbridge_context, MBX_PCPY_CLASS);
 func_end:
 	return;
 }
@@ -885,7 +886,7 @@ static void io_dispatch_pm(struct io_mgr *pio_mgr)
 	if (parg[0] == MBX_PM_HIBERNATE_EN) {
 		dev_dbg(bridge, "PM: Hibernate command\n");
 		status = pio_mgr->intf_fxns->
-				pfn_dev_cntrl(pio_mgr->hwmd_context,
+				pfn_dev_cntrl(pio_mgr->hbridge_context,
 					      WMDIOCTL_PWR_HIBERNATE, parg);
 		if (DSP_FAILED(status))
 			pr_err("%s: hibernate cmd failed 0x%x\n",
@@ -894,7 +895,7 @@ static void io_dispatch_pm(struct io_mgr *pio_mgr)
 		parg[1] = pio_mgr->shared_mem->opp_request.rqst_opp_pt;
 		dev_dbg(bridge, "PM: Requested OPP = 0x%x\n", parg[1]);
 		status = pio_mgr->intf_fxns->
-				pfn_dev_cntrl(pio_mgr->hwmd_context,
+				pfn_dev_cntrl(pio_mgr->hbridge_context,
 					WMDIOCTL_CONSTRAINT_REQUEST, parg);
 		if (DSP_FAILED(status))
 			dev_dbg(bridge, "PM: Failed to set constraint "
@@ -903,7 +904,7 @@ static void io_dispatch_pm(struct io_mgr *pio_mgr)
 		dev_dbg(bridge, "PM: clk control value of msg = 0x%x\n",
 			parg[0]);
 		status = pio_mgr->intf_fxns->
-				pfn_dev_cntrl(pio_mgr->hwmd_context,
+				pfn_dev_cntrl(pio_mgr->hbridge_context,
 					      WMDIOCTL_CLK_CTRL, parg);
 		if (DSP_FAILED(status))
 			dev_dbg(bridge, "PM: Failed to ctrl the DSP clk"
@@ -1025,7 +1026,7 @@ void io_request_chnl(struct io_mgr *pio_mgr, struct chnl_object *pchnl,
 		DBC_ASSERT((pchnl->dw_state == CHNL_STATEREADY) ||
 			   (pchnl->dw_state == CHNL_STATEEOS));
 		/* Indicate to the DSP we have a buffer available for input */
-		IO_OR_VALUE(pio_mgr->hwmd_context, struct shm, sm,
+		IO_OR_VALUE(pio_mgr->hbridge_context, struct shm, sm,
 			    host_free_mask, (1 << pchnl->chnl_id));
 		*pwMbVal = MBX_PCPY_CLASS;
 	} else if (iMode == IO_OUTPUT) {
@@ -1125,14 +1126,15 @@ static void input_chnl(struct io_mgr *pio_mgr, struct chnl_object *pchnl,
 	chnl_mgr_obj = pio_mgr->hchnl_mgr;
 
 	/* Attempt to perform input */
-	if (!IO_GET_VALUE(pio_mgr->hwmd_context, struct shm, sm, input_full))
+	if (!IO_GET_VALUE(pio_mgr->hbridge_context, struct shm, sm, input_full))
 		goto func_end;
 
 	bytes =
-	    IO_GET_VALUE(pio_mgr->hwmd_context, struct shm, sm,
+	    IO_GET_VALUE(pio_mgr->hbridge_context, struct shm, sm,
 			 input_size) * chnl_mgr_obj->word_size;
-	chnl_id = IO_GET_VALUE(pio_mgr->hwmd_context, struct shm, sm, input_id);
-	dw_arg = IO_GET_LONG(pio_mgr->hwmd_context, struct shm, sm, arg);
+	chnl_id = IO_GET_VALUE(pio_mgr->hbridge_context, struct shm, sm,
+								input_id);
+	dw_arg = IO_GET_LONG(pio_mgr->hbridge_context, struct shm, sm, arg);
 	if (chnl_id >= CHNL_MAXCHANNELS) {
 		/* Shouldn't be here: would indicate corrupted shm. */
 		DBC_ASSERT(chnl_id);
@@ -1156,7 +1158,7 @@ static void input_chnl(struct io_mgr *pio_mgr, struct chnl_object *pchnl,
 				 */
 				bytes = min(bytes, chnl_packet_obj->byte_size);
 				/* Transfer buffer from DSP side */
-				bytes = read_data(pio_mgr->hwmd_context,
+				bytes = read_data(pio_mgr->hbridge_context,
 						  chnl_packet_obj->host_sys_buf,
 						  pio_mgr->input, bytes);
 				pchnl->bytes_moved += bytes;
@@ -1191,7 +1193,7 @@ static void input_chnl(struct io_mgr *pio_mgr, struct chnl_object *pchnl,
 				if (!pchnl->pio_requests)
 					goto func_end;
 				if (LST_IS_EMPTY(pchnl->pio_requests)) {
-					IO_AND_VALUE(pio_mgr->hwmd_context,
+					IO_AND_VALUE(pio_mgr->hbridge_context,
 						     struct shm, sm,
 						     host_free_mask,
 						     ~(1 << pchnl->chnl_id));
@@ -1217,9 +1219,9 @@ static void input_chnl(struct io_mgr *pio_mgr, struct chnl_object *pchnl,
 	}
 	if (clear_chnl) {
 		/* Indicate to the DSP we have read the input */
-		IO_SET_VALUE(pio_mgr->hwmd_context, struct shm, sm, input_full,
-			     0);
-		sm_interrupt_dsp(pio_mgr->hwmd_context, MBX_PCPY_CLASS);
+		IO_SET_VALUE(pio_mgr->hbridge_context, struct shm, sm,
+							input_full, 0);
+		sm_interrupt_dsp(pio_mgr->hbridge_context, MBX_PCPY_CLASS);
 	}
 	if (notify_client) {
 		/* Notify client with IO completion record */
@@ -1248,10 +1250,10 @@ static void input_msg(struct io_mgr *pio_mgr, struct msg_mgr *hmsg_mgr)
 	msg_ctr_obj = pio_mgr->msg_input_ctrl;
 	/* Get the number of input messages to be read */
 	input_empty =
-	    IO_GET_VALUE(pio_mgr->hwmd_context, struct msg_ctrl, msg_ctr_obj,
+	    IO_GET_VALUE(pio_mgr->hbridge_context, struct msg_ctrl, msg_ctr_obj,
 			 buf_empty);
 	num_msgs =
-	    IO_GET_VALUE(pio_mgr->hwmd_context, struct msg_ctrl, msg_ctr_obj,
+	    IO_GET_VALUE(pio_mgr->hbridge_context, struct msg_ctrl, msg_ctr_obj,
 			 size);
 	if (input_empty)
 		goto func_end;
@@ -1261,16 +1263,16 @@ static void input_msg(struct io_mgr *pio_mgr, struct msg_mgr *hmsg_mgr)
 		/* Read the next message */
 		addr = (u32) &(((struct msg_dspmsg *)msg_input)->msg.dw_cmd);
 		msg.msg.dw_cmd =
-		    read_ext32_bit_dsp_data(pio_mgr->hwmd_context, addr);
+		    read_ext32_bit_dsp_data(pio_mgr->hbridge_context, addr);
 		addr = (u32) &(((struct msg_dspmsg *)msg_input)->msg.dw_arg1);
 		msg.msg.dw_arg1 =
-		    read_ext32_bit_dsp_data(pio_mgr->hwmd_context, addr);
+		    read_ext32_bit_dsp_data(pio_mgr->hbridge_context, addr);
 		addr = (u32) &(((struct msg_dspmsg *)msg_input)->msg.dw_arg2);
 		msg.msg.dw_arg2 =
-		    read_ext32_bit_dsp_data(pio_mgr->hwmd_context, addr);
+		    read_ext32_bit_dsp_data(pio_mgr->hbridge_context, addr);
 		addr = (u32) &(((struct msg_dspmsg *)msg_input)->msgq_id);
 		msg.msgq_id =
-		    read_ext32_bit_dsp_data(pio_mgr->hwmd_context, addr);
+		    read_ext32_bit_dsp_data(pio_mgr->hbridge_context, addr);
 		msg_input += sizeof(struct msg_dspmsg);
 		if (!hmsg_mgr->queue_list)
 			goto func_end;
@@ -1342,11 +1344,11 @@ static void input_msg(struct io_mgr *pio_mgr, struct msg_mgr *hmsg_mgr)
 	/* Set the post SWI flag */
 	if (num_msgs > 0) {
 		/* Tell the DSP we've read the messages */
-		IO_SET_VALUE(pio_mgr->hwmd_context, struct msg_ctrl,
+		IO_SET_VALUE(pio_mgr->hbridge_context, struct msg_ctrl,
 			     msg_ctr_obj, buf_empty, true);
-		IO_SET_VALUE(pio_mgr->hwmd_context, struct msg_ctrl,
+		IO_SET_VALUE(pio_mgr->hbridge_context, struct msg_ctrl,
 			     msg_ctr_obj, post_swi, true);
-		sm_interrupt_dsp(pio_mgr->hwmd_context, MBX_PCPY_CLASS);
+		sm_interrupt_dsp(pio_mgr->hbridge_context, MBX_PCPY_CLASS);
 	}
 func_end:
 	return;
@@ -1407,14 +1409,14 @@ static void output_chnl(struct io_mgr *pio_mgr, struct chnl_object *pchnl,
 	chnl_mgr_obj = pio_mgr->hchnl_mgr;
 	sm = pio_mgr->shared_mem;
 	/* Attempt to perform output */
-	if (IO_GET_VALUE(pio_mgr->hwmd_context, struct shm, sm, output_full))
+	if (IO_GET_VALUE(pio_mgr->hbridge_context, struct shm, sm, output_full))
 		goto func_end;
 
 	if (pchnl && !((pchnl->dw_state & ~CHNL_STATEEOS) == CHNL_STATEREADY))
 		goto func_end;
 
 	/* Look to see if both a PC and DSP output channel are ready */
-	dw_dsp_f_mask = IO_GET_VALUE(pio_mgr->hwmd_context, struct shm, sm,
+	dw_dsp_f_mask = IO_GET_VALUE(pio_mgr->hbridge_context, struct shm, sm,
 				     dsp_free_mask);
 	chnl_id =
 	    find_ready_output(chnl_mgr_obj, pchnl,
@@ -1442,29 +1444,30 @@ static void output_chnl(struct io_mgr *pio_mgr, struct chnl_object *pchnl,
 
 	/* Transfer buffer to DSP side */
 	chnl_packet_obj->byte_size =
-	    write_data(pio_mgr->hwmd_context, pio_mgr->output,
+	    write_data(pio_mgr->hbridge_context, pio_mgr->output,
 		       chnl_packet_obj->host_sys_buf, min(pio_mgr->usm_buf_size,
 						  chnl_packet_obj->byte_size));
 	pchnl->bytes_moved += chnl_packet_obj->byte_size;
 	/* Write all 32 bits of arg */
-	IO_SET_LONG(pio_mgr->hwmd_context, struct shm, sm, arg,
+	IO_SET_LONG(pio_mgr->hbridge_context, struct shm, sm, arg,
 		    chnl_packet_obj->dw_arg);
 #if _CHNL_WORDSIZE == 2
-	IO_SET_VALUE(pio_mgr->hwmd_context, struct shm, sm, output_id,
+	IO_SET_VALUE(pio_mgr->hbridge_context, struct shm, sm, output_id,
 		     (u16) chnl_id);
-	IO_SET_VALUE(pio_mgr->hwmd_context, struct shm, sm, output_size,
+	IO_SET_VALUE(pio_mgr->hbridge_context, struct shm, sm, output_size,
 		     (u16) (chnl_packet_obj->byte_size +
 			    (chnl_mgr_obj->word_size -
 			     1)) / (u16) chnl_mgr_obj->word_size);
 #else
-	IO_SET_VALUE(pio_mgr->hwmd_context, struct shm, sm, output_id, chnl_id);
-	IO_SET_VALUE(pio_mgr->hwmd_context, struct shm, sm, output_size,
+	IO_SET_VALUE(pio_mgr->hbridge_context, struct shm, sm, output_id,
+								chnl_id);
+	IO_SET_VALUE(pio_mgr->hbridge_context, struct shm, sm, output_size,
 		     (chnl_packet_obj->byte_size +
 		      (chnl_mgr_obj->word_size - 1)) / chnl_mgr_obj->word_size);
 #endif
-	IO_SET_VALUE(pio_mgr->hwmd_context, struct shm, sm, output_full, 1);
+	IO_SET_VALUE(pio_mgr->hbridge_context, struct shm, sm, output_full, 1);
 	/* Indicate to the DSP we have written the output */
-	sm_interrupt_dsp(pio_mgr->hwmd_context, MBX_PCPY_CLASS);
+	sm_interrupt_dsp(pio_mgr->hbridge_context, MBX_PCPY_CLASS);
 	/* Notify client with IO completion record (keep EOS) */
 	chnl_packet_obj->status &= CHNL_IOCSTATEOS;
 	notify_chnl_complete(pchnl, chnl_packet_obj);
@@ -1495,7 +1498,7 @@ static void output_msg(struct io_mgr *pio_mgr, struct msg_mgr *hmsg_mgr)
 
 	/* Check if output has been cleared */
 	output_empty =
-	    IO_GET_VALUE(pio_mgr->hwmd_context, struct msg_ctrl, msg_ctr_obj,
+	    IO_GET_VALUE(pio_mgr->hbridge_context, struct msg_ctrl, msg_ctr_obj,
 			 buf_empty);
 	if (output_empty) {
 		num_msgs = (hmsg_mgr->msgs_pending > hmsg_mgr->max_msgs) ?
@@ -1514,23 +1517,23 @@ static void output_msg(struct io_mgr *pio_mgr, struct msg_mgr *hmsg_mgr)
 				val = (pmsg->msg_data).msgq_id;
 				addr = (u32) &(((struct msg_dspmsg *)
 						 msg_output)->msgq_id);
-				write_ext32_bit_dsp_data(pio_mgr->hwmd_context,
-							 addr, val);
+				write_ext32_bit_dsp_data(pio_mgr->
+						hbridge_context, addr, val);
 				val = (pmsg->msg_data).msg.dw_cmd;
 				addr = (u32) &((((struct msg_dspmsg *)
 						  msg_output)->msg).dw_cmd);
-				write_ext32_bit_dsp_data(pio_mgr->hwmd_context,
-							 addr, val);
+				write_ext32_bit_dsp_data(pio_mgr->
+						hbridge_context, addr, val);
 				val = (pmsg->msg_data).msg.dw_arg1;
 				addr = (u32) &((((struct msg_dspmsg *)
 						  msg_output)->msg).dw_arg1);
-				write_ext32_bit_dsp_data(pio_mgr->hwmd_context,
-							 addr, val);
+				write_ext32_bit_dsp_data(pio_mgr->
+						hbridge_context, addr, val);
 				val = (pmsg->msg_data).msg.dw_arg2;
 				addr = (u32) &((((struct msg_dspmsg *)
 						  msg_output)->msg).dw_arg2);
-				write_ext32_bit_dsp_data(pio_mgr->hwmd_context,
-							 addr, val);
+				write_ext32_bit_dsp_data(pio_mgr->
+						hbridge_context, addr, val);
 				msg_output += sizeof(struct msg_dspmsg);
 				if (!hmsg_mgr->msg_free_list)
 					goto func_end;
@@ -1543,19 +1546,20 @@ static void output_msg(struct io_mgr *pio_mgr, struct msg_mgr *hmsg_mgr)
 		if (num_msgs > 0) {
 			hmsg_mgr->msgs_pending -= num_msgs;
 #if _CHNL_WORDSIZE == 2
-			IO_SET_VALUE(pio_mgr->hwmd_context, struct msg_ctrl,
+			IO_SET_VALUE(pio_mgr->hbridge_context, struct msg_ctrl,
 				     msg_ctr_obj, size, (u16) num_msgs);
 #else
-			IO_SET_VALUE(pio_mgr->hwmd_context, struct msg_ctrl,
+			IO_SET_VALUE(pio_mgr->hbridge_context, struct msg_ctrl,
 				     msg_ctr_obj, size, num_msgs);
 #endif
-			IO_SET_VALUE(pio_mgr->hwmd_context, struct msg_ctrl,
+			IO_SET_VALUE(pio_mgr->hbridge_context, struct msg_ctrl,
 				     msg_ctr_obj, buf_empty, false);
 			/* Set the post SWI flag */
-			IO_SET_VALUE(pio_mgr->hwmd_context, struct msg_ctrl,
+			IO_SET_VALUE(pio_mgr->hbridge_context, struct msg_ctrl,
 				     msg_ctr_obj, post_swi, true);
 			/* Tell the DSP we have written the output. */
-			sm_interrupt_dsp(pio_mgr->hwmd_context, MBX_PCPY_CLASS);
+			sm_interrupt_dsp(pio_mgr->hbridge_context,
+						MBX_PCPY_CLASS);
 		}
 	}
 func_end:
@@ -1713,7 +1717,7 @@ static u32 write_data(struct bridge_dev_context *hDevContext, void *dest,
 /* ZCPY IO routines. */
 void io_intr_dsp2(IN struct io_mgr *pio_mgr, IN u16 mb_val)
 {
-	sm_interrupt_dsp(pio_mgr->hwmd_context, mb_val);
+	sm_interrupt_dsp(pio_mgr->hbridge_context, mb_val);
 }
 
 /*
@@ -1939,7 +1943,7 @@ static dsp_status pack_trace_buffer(char *lpBuf, u32 bytes, u32 ul_num_words)
  *  Requires:
  *      hdeh_mgr muse be valid. Checked in bridge_deh_notify.
  */
-dsp_status print_dsp_trace_buffer(struct bridge_dev_context *hwmd_context)
+dsp_status print_dsp_trace_buffer(struct bridge_dev_context *hbridge_context)
 {
 	dsp_status status = DSP_SOK;
 	struct cod_manager *cod_mgr;
@@ -1952,11 +1956,11 @@ dsp_status print_dsp_trace_buffer(struct bridge_dev_context *hwmd_context)
 	char *psz_buf;
 	u16 *lpsz_buf;
 
-	struct bridge_dev_context *pwmd_context = (struct bridge_dev_context *)
-	    hwmd_context;
+	struct bridge_dev_context *pbridge_context =
+				(struct bridge_dev_context *) hbridge_context;
 	struct bridge_drv_interface *intf_fxns;
 	struct dev_object *dev_obj = (struct dev_object *)
-	    pwmd_context->hdev_obj;
+	    pbridge_context->hdev_obj;
 
 	status = dev_get_cod_mgr(dev_obj, &cod_mgr);
 
@@ -1989,7 +1993,7 @@ dsp_status print_dsp_trace_buffer(struct bridge_dev_context *hwmd_context)
 		lpsz_buf = kzalloc(ul_num_bytes * 2, GFP_ATOMIC);
 		if (psz_buf != NULL) {
 			/* Read bytes from the DSP trace buffer... */
-			status = (*intf_fxns->pfn_brd_read) (hwmd_context,
+			status = (*intf_fxns->pfn_brd_read) (hbridge_context,
 							     (u8 *) psz_buf,
 							     (u32)
 							     ul_trace_begin,
diff --git a/drivers/dsp/bridge/wmd/mmu_fault.c b/drivers/dsp/bridge/wmd/mmu_fault.c
index 30ab29a..0e6387a 100644
--- a/drivers/dsp/bridge/wmd/mmu_fault.c
+++ b/drivers/dsp/bridge/wmd/mmu_fault.c
@@ -77,7 +77,7 @@ irqreturn_t mmu_fault_isr(int irq, IN void *pRefData)
 	if (deh_mgr_obj) {
 
 		dev_context =
-		    (struct bridge_dev_context *)deh_mgr_obj->hwmd_context;
+		    (struct bridge_dev_context *)deh_mgr_obj->hbridge_context;
 		status = cfg_get_host_resources((struct cfg_devnode *)
 						drv_get_first_dev_extension(),
 						&resources);
diff --git a/drivers/dsp/bridge/wmd/tiomap_io.c b/drivers/dsp/bridge/wmd/tiomap_io.c
index 03e1028..378cc60 100644
--- a/drivers/dsp/bridge/wmd/tiomap_io.c
+++ b/drivers/dsp/bridge/wmd/tiomap_io.c
@@ -51,12 +51,12 @@ bool symbols_reloaded = true;
  *  ======== read_ext_dsp_data ========
  *      Copies DSP external memory buffers to the host side buffers.
  */
-dsp_status read_ext_dsp_data(struct wmd_dev_context *hDevContext,
+dsp_status read_ext_dsp_data(struct bridge_dev_context *hDevContext,
 			     OUT u8 *pbHostBuf, u32 dwDSPAddr,
 			     u32 ul_num_bytes, u32 ulMemType)
 {
 	dsp_status status = DSP_SOK;
-	struct wmd_dev_context *dev_context = hDevContext;
+	struct bridge_dev_context *dev_context = hDevContext;
 	u32 offset;
 	u32 ul_tlb_base_virt = 0;
 	u32 ul_shm_offset_virt = 0;
@@ -179,7 +179,7 @@ dsp_status read_ext_dsp_data(struct wmd_dev_context *hDevContext,
  *  purpose:
  *      Copies buffers to the DSP internal/external memory.
  */
-dsp_status write_dsp_data(struct wmd_dev_context *hDevContext,
+dsp_status write_dsp_data(struct bridge_dev_context *hDevContext,
 			  IN u8 *pbHostBuf, u32 dwDSPAddr, u32 ul_num_bytes,
 			  u32 ulMemType)
 {
@@ -229,7 +229,7 @@ dsp_status write_dsp_data(struct wmd_dev_context *hDevContext,
  *      Copies buffers to the external memory.
  *
  */
-dsp_status write_ext_dsp_data(struct wmd_dev_context *dev_context,
+dsp_status write_ext_dsp_data(struct bridge_dev_context *dev_context,
 			      IN u8 *pbHostBuf, u32 dwDSPAddr,
 			      u32 ul_num_bytes, u32 ulMemType,
 			      bool bDynamicLoad)
@@ -394,7 +394,7 @@ dsp_status write_ext_dsp_data(struct wmd_dev_context *dev_context,
 	return ret;
 }
 
-dsp_status sm_interrupt_dsp(struct wmd_dev_context *dev_context, u16 mb_val)
+dsp_status sm_interrupt_dsp(struct bridge_dev_context *dev_context, u16 mb_val)
 {
 #ifdef CONFIG_BRIDGE_DVFS
 	u32 opplevel = 0;
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 3ef7f97..fa8fc57 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -71,14 +71,14 @@ dsp_status bridge_deh_create(OUT struct deh_mgr **phDehMgr,
 	struct deh_mgr *deh_mgr_obj = NULL;
 	struct cfg_hostres cfg_host_res;
 	struct cfg_devnode *dev_node_obj;
-	struct bridge_dev_context *hwmd_context = NULL;
+	struct bridge_dev_context *hbridge_context = NULL;
 
 	/*  Message manager will be created when a file is loaded, since
 	 *  size of message buffer in shared memory is configurable in
 	 *  the base image. */
 	/* Get WMD context info. */
-	dev_get_wmd_context(hdev_obj, &hwmd_context);
-	DBC_ASSERT(hwmd_context);
+	dev_get_wmd_context(hdev_obj, &hbridge_context);
+	DBC_ASSERT(hbridge_context);
 	dummy_va_addr = 0;
 	/* Allocate IO manager object: */
 	deh_mgr_obj = kzalloc(sizeof(struct deh_mgr), GFP_KERNEL);
@@ -106,7 +106,7 @@ dsp_status bridge_deh_create(OUT struct deh_mgr **phDehMgr,
 
 		if (DSP_SUCCEEDED(status)) {
 			/* Fill in context structure */
-			deh_mgr_obj->hwmd_context = hwmd_context;
+			deh_mgr_obj->hbridge_context = hbridge_context;
 			deh_mgr_obj->err_info.dw_err_mask = 0L;
 			deh_mgr_obj->err_info.dw_val1 = 0L;
 			deh_mgr_obj->err_info.dw_val2 = 0L;
@@ -208,7 +208,7 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
 		       "bridge_deh_notify: ********** DEVICE EXCEPTION "
 		       "**********\n");
 		dev_context =
-		    (struct bridge_dev_context *)deh_mgr_obj->hwmd_context;
+		    (struct bridge_dev_context *)deh_mgr_obj->hbridge_context;
 
 		switch (ulEventMask) {
 		case DSP_SYSERROR:
@@ -244,7 +244,7 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
 			    VIRT_TO_PHYS(PG_ALIGN_LOW
 					 ((u32) dummy_va_addr, PG_SIZE4K));
 			dev_context = (struct bridge_dev_context *)
-			    deh_mgr_obj->hwmd_context;
+			    deh_mgr_obj->hbridge_context;
 			/* Reset the dynamic mmu index to fixed count if it
 			 * exceeds 31. So that the dynmmuindex is always
 			 * between the range of standard/fixed entries
@@ -307,7 +307,7 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
 		/* Disable all the clocks that were enabled by DSP */
 		(void)dsp_peripheral_clocks_disable(dev_context, NULL);
 		/* Call DSP Trace Buffer */
-		print_dsp_trace_buffer(hdeh_mgr->hwmd_context);
+		print_dsp_trace_buffer(hdeh_mgr->hbridge_context);
 		/*
 		 * Avoid the subsequent WDT if it happens once,
 		 * also If fatal error occurs
-- 
1.7.0.3

