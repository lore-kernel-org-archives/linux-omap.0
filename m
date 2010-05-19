From: Ivan Gomez Castellanos <ivan.gomez@ti.com>
Subject: [PATCH 2/4] DSPBRIDGE: Remove comments refering to WCD.
Date: Wed, 19 May 2010 17:21:40 -0500
Message-ID: <1274307702-22637-3-git-send-email-ivan.gomez@ti.com>
References: <1274307702-22637-1-git-send-email-ivan.gomez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45549 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751189Ab0ESW3T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 May 2010 18:29:19 -0400
In-Reply-To: <1274307702-22637-1-git-send-email-ivan.gomez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi.DOYU@nokia.com, ameya.palande@nokia.com, felipe.contreras@nokia.com, Ivan Gomez Castellanos <ivan.gomez@ti.com>

This patch removes comments refering to WCD (Windows Class Driver).
This is a complement of the patch series to remove code refering
to other OS.

Signed-off-by: Ivan Gomez Castellanos <ivan.gomez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/chnl.h     |    2 +-
 arch/arm/plat-omap/include/dspbridge/devdefs.h  |    2 +-
 arch/arm/plat-omap/include/dspbridge/drvdefs.h  |    2 +-
 arch/arm/plat-omap/include/dspbridge/dspdefs.h  |   19 ++++++++++---------
 arch/arm/plat-omap/include/dspbridge/mgrpriv.h  |    2 +-
 arch/arm/plat-omap/include/dspbridge/procpriv.h |    2 +-
 arch/arm/plat-omap/include/dspbridge/utildefs.h |    2 +-
 drivers/dsp/bridge/core/_tiomap.h               |    2 +-
 drivers/dsp/bridge/core/tiomap3430.c            |    2 +-
 drivers/dsp/bridge/pmgr/chnl.c                  |    4 ++--
 drivers/dsp/bridge/pmgr/dev.c                   |    6 +++---
 drivers/dsp/bridge/pmgr/dspapi.c                |    2 +-
 drivers/dsp/bridge/pmgr/msg.c                   |    2 +-
 drivers/dsp/bridge/services/cfg.c               |    2 +-
 14 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/chnl.h b/arch/arm/plat-omap/include/dspbridge/chnl.h
index 9a7f4a0..6d2d3c4 100644
--- a/arch/arm/plat-omap/include/dspbridge/chnl.h
+++ b/arch/arm/plat-omap/include/dspbridge/chnl.h
@@ -3,7 +3,7 @@
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
- * WCD channel interface: multiplexes data streams through the single
+ * DSP API channel interface: multiplexes data streams through the single
  * physical link managed by a mini-driver.
  *
  * See DSP API chnl.h for more details.
diff --git a/arch/arm/plat-omap/include/dspbridge/devdefs.h b/arch/arm/plat-omap/include/dspbridge/devdefs.h
index 8b56748..a2f9241 100644
--- a/arch/arm/plat-omap/include/dspbridge/devdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/devdefs.h
@@ -20,7 +20,7 @@
 #ifndef DEVDEFS_
 #define DEVDEFS_
 
-/* WCD Device Object */
+/* Bridge Device Object */
 struct dev_object;
 
 #endif /* DEVDEFS_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/drvdefs.h b/arch/arm/plat-omap/include/dspbridge/drvdefs.h
index c0dea57..2920917 100644
--- a/arch/arm/plat-omap/include/dspbridge/drvdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/drvdefs.h
@@ -19,7 +19,7 @@
 #ifndef DRVDEFS_
 #define DRVDEFS_
 
-/* WCD Driver Object */
+/* Bridge Driver Object */
 struct drv_object;
 
 #endif /* DRVDEFS_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/dspdefs.h b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
index 47f631c..7729993 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
@@ -651,7 +651,7 @@ typedef dsp_status(*fxn_chnl_registernotify)
  *      Complete creation of the device object for this board.
  *  Parameters:
  *      phDevContext:   Ptr to location to store a Bridge device context.
- *      hdev_obj:     Handle to a Device Object, created and managed by WCD.
+ *      hdev_obj:     Handle to a Device Object, created and managed by DSP API.
  *      pConfig:        Ptr to configuration parameters provided by the
  *                      Configuration Manager during device loading.
  *      pDspConfig:     DSP resources, as specified in the registry key for this
@@ -669,9 +669,9 @@ typedef dsp_status(*fxn_chnl_registernotify)
  *      DSP_SOK:        All mini-driver specific DSP resource and other
  *                      board context has been allocated.
  *      -ENOMEM:    Bridge failed to allocate resources.
- *                      Any acquired resources have been freed.  The WCD will
- *                      not call bridge_dev_destroy() if bridge_dev_create()
- *                      fails.
+ *                      Any acquired resources have been freed.  The DSP API
+ *                      will not call bridge_dev_destroy() if
+ *                      bridge_dev_create() fails.
  *  Details:
  *      Called during the CONFIGMG's Device_Init phase. Based on host and
  *      DSP configuration information, create a board context, a handle to
@@ -1041,10 +1041,10 @@ typedef void (*fxn_msg_setqueueid) (struct msg_queue *msg_queue_obj,
  *  consider that function not implemented, and return the error code
  *  -ENOSYS when a Bridge driver client attempts to call that function.
  *
- *  This function table contains WCD version numbers, which are used by the
+ *  This function table contains DSP API version numbers, which are used by the
  *  Bridge driver loader to help ensure backwards compatility between older
- *  Bridge drivers and newer 'Bridge Class Driver.  These must be set to
- *  WCD_MAJOR_VERSION and WCD_MINOR_VERSION, respectively.
+ *  Bridge drivers and newer DSP API.  These must be set to
+ *  BRD_API_MAJOR_VERSION and BRD_API_MINOR_VERSION, respectively.
  *
  *  A mini-driver need not export a CHNL interface.  In this case, *all* of
  *  the bridge_chnl_* entries must be set to NULL.
@@ -1109,8 +1109,9 @@ struct bridge_drv_interface {
  *  ======== bridge_drv_entry ========
  *  Purpose:
  *      Registers Bridge driver functions with the DSP API. Called only once
- *      by the WCD.  The caller will first check WCD version compatibility, and
- *      then copy the interface functions into its own memory space.
+ *      by the DSP API.  The caller will first check DSP API version
+ *      compatibility, and then copy the interface functions into its own
+ *      memory space.
  *  Parameters:
  *      ppDrvInterface  Pointer to a location to receive a pointer to the
  *                      mini driver interface.
diff --git a/arch/arm/plat-omap/include/dspbridge/mgrpriv.h b/arch/arm/plat-omap/include/dspbridge/mgrpriv.h
index 12ac32f..bca4e10 100644
--- a/arch/arm/plat-omap/include/dspbridge/mgrpriv.h
+++ b/arch/arm/plat-omap/include/dspbridge/mgrpriv.h
@@ -3,7 +3,7 @@
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
- * Global MGR constants and types, shared by PROC, MGR, and WCD.
+ * Global MGR constants and types, shared by PROC, MGR, and DSP API.
  *
  * Copyright (C) 2008 Texas Instruments, Inc.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/procpriv.h b/arch/arm/plat-omap/include/dspbridge/procpriv.h
index 1cd38ba..77d1f0e 100644
--- a/arch/arm/plat-omap/include/dspbridge/procpriv.h
+++ b/arch/arm/plat-omap/include/dspbridge/procpriv.h
@@ -3,7 +3,7 @@
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
- * Global PROC constants and types, shared by PROC, MGR and WCD.
+ * Global PROC constants and types, shared by PROC, MGR and DSP API.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/utildefs.h b/arch/arm/plat-omap/include/dspbridge/utildefs.h
index 5c67b04..8fe5414 100644
--- a/arch/arm/plat-omap/include/dspbridge/utildefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/utildefs.h
@@ -3,7 +3,7 @@
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
- * Global UTIL constants and types, shared between WCD and DSPSYS.
+ * Global UTIL constants and types, shared between DSP API and DSPSYS.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
  *
diff --git a/drivers/dsp/bridge/core/_tiomap.h b/drivers/dsp/bridge/core/_tiomap.h
index 62eee09..9deb726 100644
--- a/drivers/dsp/bridge/core/_tiomap.h
+++ b/drivers/dsp/bridge/core/_tiomap.h
@@ -310,7 +310,7 @@ static const struct bpwr_clk_t bpwr_clks[] = {
 
 /* This mini driver's device context: */
 struct bridge_dev_context {
-	struct dev_object *hdev_obj;	/* Handle to WCD device object. */
+	struct dev_object *hdev_obj;	/* Handle to Bridge device object. */
 	u32 dw_dsp_base_addr;	/* Arm's API to DSP virt base addr */
 	/*
 	 * DSP External memory prog address as seen virtually by the OS on
diff --git a/drivers/dsp/bridge/core/tiomap3430.c b/drivers/dsp/bridge/core/tiomap3430.c
index 72a5bdf..7a3ed32 100644
--- a/drivers/dsp/bridge/core/tiomap3430.c
+++ b/drivers/dsp/bridge/core/tiomap3430.c
@@ -951,7 +951,7 @@ static dsp_status bridge_dev_create(OUT struct bridge_dev_context
 		/* Store current board state. */
 		dev_context->dw_brd_state = BRD_STOPPED;
 		dev_context->resources = resources;
-		/* Return ptr to our device state to the WCD for storage */
+		/* Return ptr to our device state to the DSP API for storage */
 		*ppDevContext = dev_context;
 	} else {
 		if (pt_attrs != NULL) {
diff --git a/drivers/dsp/bridge/pmgr/chnl.c b/drivers/dsp/bridge/pmgr/chnl.c
index 6eb8f7e..e6437dc 100644
--- a/drivers/dsp/bridge/pmgr/chnl.c
+++ b/drivers/dsp/bridge/pmgr/chnl.c
@@ -3,7 +3,7 @@
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
- * WCD channel interface: multiplexes data streams through the single
+ * DSP API channel interface: multiplexes data streams through the single
  * physical link managed by a Bridge mini-driver.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
@@ -92,7 +92,7 @@ dsp_status chnl_create(OUT struct chnl_mgr **phChnlMgr,
 		status = (*intf_fxns->pfn_chnl_create) (&hchnl_mgr, hdev_obj,
 							pMgrAttrs);
 		if (DSP_SUCCEEDED(status)) {
-			/* Fill in WCD channel module's fields of the
+			/* Fill in DSP API channel module's fields of the
 			 * chnl_mgr structure */
 			chnl_mgr_obj = (struct chnl_mgr_ *)hchnl_mgr;
 			chnl_mgr_obj->intf_fxns = intf_fxns;
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index 47c9715..580c018 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -43,7 +43,7 @@
 #include <dspbridge/node.h>
 
 /*  ----------------------------------- Others */
-#include <dspbridge/dspapi.h>	/* WCD version info. */
+#include <dspbridge/dspapi.h>	/* DSP API version info. */
 
 #include <dspbridge/chnl.h>
 #include <dspbridge/io.h>
@@ -1064,7 +1064,7 @@ dsp_status dev_get_dev_type(struct dev_object *hdevObject, u8 *dev_type)
  *         corresponding slots in the the Bridge's interface, because the Bridge
  *         is of an *older* version.
  *  Parameters:
- *      intf_fxns:      Interface fxn Structure of the WCD's Dev Object.
+ *      intf_fxns:      Interface fxn Structure of the Bridge's Dev Object.
  *      drv_fxns:      Interface Fxns offered by the Bridge during DEV_Create().
  *  Returns:
  *  Requires:
@@ -1091,7 +1091,7 @@ static void store_interface_fxns(struct bridge_drv_interface *drv_fxns,
 				     drv_fxns->brd_api_minor_version);
 	intf_fxns->brd_api_major_version = drv_fxns->brd_api_major_version;
 	intf_fxns->brd_api_minor_version = drv_fxns->brd_api_minor_version;
-	/* Install functions up to WCD version .80 (first alpha): */
+	/* Install functions up to DSP API version .80 (first alpha): */
 	if (bridge_version > 0) {
 		STORE_FXN(fxn_dev_create, pfn_dev_create);
 		STORE_FXN(fxn_dev_destroy, pfn_dev_destroy);
diff --git a/drivers/dsp/bridge/pmgr/dspapi.c b/drivers/dsp/bridge/pmgr/dspapi.c
index 05ea853..21456a8 100644
--- a/drivers/dsp/bridge/pmgr/dspapi.c
+++ b/drivers/dsp/bridge/pmgr/dspapi.c
@@ -3,7 +3,7 @@
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
- * Common WCD functions, also includes the wrapper
+ * Common DSP API functions, also includes the wrapper
  * functions called directly by the DeviceIOControl interface.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
diff --git a/drivers/dsp/bridge/pmgr/msg.c b/drivers/dsp/bridge/pmgr/msg.c
index 7d605b1..cb43eca 100644
--- a/drivers/dsp/bridge/pmgr/msg.c
+++ b/drivers/dsp/bridge/pmgr/msg.c
@@ -68,7 +68,7 @@ dsp_status msg_create(OUT struct msg_mgr **phMsgMgr,
 	    (*intf_fxns->pfn_msg_create) (&hmsg_mgr, hdev_obj, msgCallback);
 
 	if (DSP_SUCCEEDED(status)) {
-		/* Fill in WCD message module's fields of the msg_mgr
+		/* Fill in DSP API message module's fields of the msg_mgr
 		 * structure */
 		msg_mgr_obj = (struct msg_mgr_ *)hmsg_mgr;
 		msg_mgr_obj->intf_fxns = intf_fxns;
diff --git a/drivers/dsp/bridge/services/cfg.c b/drivers/dsp/bridge/services/cfg.c
index 6a0b5c3..81321f1 100644
--- a/drivers/dsp/bridge/services/cfg.c
+++ b/drivers/dsp/bridge/services/cfg.c
@@ -212,7 +212,7 @@ dsp_status cfg_set_dev_object(struct cfg_devnode *dev_node_obj, u32 dwValue)
 		status = -EFAULT;
 
 	if (DSP_SUCCEEDED(status)) {
-		/* Store the WCD device object in the Registry */
+		/* Store the Bridge device object in the Registry */
 
 		if (!(strcmp((char *)dev_node_obj, "TIOMAP1510")))
 			drv_datap->dev_object = (void *) dwValue;
-- 
1.7.0.3

