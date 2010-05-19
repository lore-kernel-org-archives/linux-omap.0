From: Ivan Gomez Castellanos <ivan.gomez@ti.com>
Subject: [PATCH 1/4] DSPBRIDGE: Remove comments refering to WMD.
Date: Wed, 19 May 2010 17:21:39 -0500
Message-ID: <1274307702-22637-2-git-send-email-ivan.gomez@ti.com>
References: <1274307702-22637-1-git-send-email-ivan.gomez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45524 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751643Ab0ESW3I (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 May 2010 18:29:08 -0400
In-Reply-To: <1274307702-22637-1-git-send-email-ivan.gomez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi.DOYU@nokia.com, ameya.palande@nokia.com, felipe.contreras@nokia.com, Ivan Gomez Castellanos <ivan.gomez@ti.com>

This patch removes comments refering to WMD (Windows Mini Driver).
This is a complement of the patch series to remove code refering
to other OS.

Signed-off-by: Ivan Gomez Castellanos <ivan.gomez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/_chnl_sm.h |    2 +-
 arch/arm/plat-omap/include/dspbridge/brddefs.h  |    2 +-
 arch/arm/plat-omap/include/dspbridge/cfg.h      |    6 +-
 arch/arm/plat-omap/include/dspbridge/chnlpriv.h |    3 +-
 arch/arm/plat-omap/include/dspbridge/dev.h      |   57 +++++++++++------------
 arch/arm/plat-omap/include/dspbridge/devdefs.h  |    2 +-
 arch/arm/plat-omap/include/dspbridge/dspchnl.h  |    4 +-
 arch/arm/plat-omap/include/dspbridge/dspdefs.h  |   46 ++++++++----------
 arch/arm/plat-omap/include/dspbridge/dspdeh.h   |    2 +-
 arch/arm/plat-omap/include/dspbridge/dspio.h    |    4 +-
 arch/arm/plat-omap/include/dspbridge/dspioctl.h |    2 +-
 arch/arm/plat-omap/include/dspbridge/dspmsg.h   |    4 +-
 arch/arm/plat-omap/include/dspbridge/io_sm.h    |    6 +-
 arch/arm/plat-omap/include/dspbridge/memdefs.h  |    2 +-
 arch/arm/plat-omap/include/dspbridge/proc.h     |    2 +-
 drivers/dsp/bridge/core/_msg_sm.h               |    4 +-
 drivers/dsp/bridge/core/_tiomap.h               |    4 +-
 drivers/dsp/bridge/core/chnl_sm.c               |    6 +-
 drivers/dsp/bridge/core/io_sm.c                 |   14 +++--
 drivers/dsp/bridge/core/msg_sm.c                |    2 +-
 drivers/dsp/bridge/core/tiomap3430.c            |    6 +-
 drivers/dsp/bridge/core/tiomap3430_pwr.c        |    4 +-
 drivers/dsp/bridge/core/ue_deh.c                |    2 +-
 drivers/dsp/bridge/pmgr/chnl.c                  |    4 +-
 drivers/dsp/bridge/pmgr/chnlobj.h               |   14 +++---
 drivers/dsp/bridge/pmgr/dev.c                   |   38 ++++++++-------
 drivers/dsp/bridge/pmgr/io.c                    |    4 +-
 drivers/dsp/bridge/pmgr/ioobj.h                 |    8 ++--
 drivers/dsp/bridge/pmgr/msg.c                   |    4 +-
 drivers/dsp/bridge/pmgr/msgobj.h                |    9 ++--
 drivers/dsp/bridge/rmgr/disp.c                  |    5 +-
 drivers/dsp/bridge/rmgr/node.c                  |    9 ++-
 drivers/dsp/bridge/rmgr/proc.c                  |    9 ++--
 drivers/dsp/bridge/rmgr/strm.c                  |    5 +-
 34 files changed, 152 insertions(+), 143 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
index 7a728b1..89c196c 100644
--- a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
@@ -112,7 +112,7 @@ struct shm {
 
 	/* Channel Manager: only one created per board: */
 struct chnl_mgr {
-	/* Function interface to WMD */
+	/* Function interface to Bridge driver */
 	struct bridge_drv_interface *intf_fxns;
 	struct io_mgr *hio_mgr;	/* IO manager */
 	/* Device this board represents */
diff --git a/arch/arm/plat-omap/include/dspbridge/brddefs.h b/arch/arm/plat-omap/include/dspbridge/brddefs.h
index fefddb9..f80d9a5 100644
--- a/arch/arm/plat-omap/include/dspbridge/brddefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/brddefs.h
@@ -3,7 +3,7 @@
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
- * Global BRD constants and types, shared between WCD and WMD.
+ * Global BRD constants and types, shared between DSP API and Bridge driver.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/cfg.h b/arch/arm/plat-omap/include/dspbridge/cfg.h
index 547cacb..e58f20b 100644
--- a/arch/arm/plat-omap/include/dspbridge/cfg.h
+++ b/arch/arm/plat-omap/include/dspbridge/cfg.h
@@ -39,7 +39,7 @@ extern void cfg_exit(void);
  *  Purpose:
  *      Retreive the autostart mask, if any, for this board.
  *  Parameters:
- *      dev_node_obj:       Handle to the dev_node who's WMD we are querying.
+ *      dev_node_obj:  Handle to the dev_node who's driver we are querying.
  *      pdwAutoStart:   Ptr to location for 32 bit autostart mask.
  *  Returns:
  *      DSP_SOK:                Success.
@@ -99,7 +99,7 @@ extern dsp_status cfg_get_dev_object(IN struct cfg_devnode *dev_node_obj,
  *  Purpose:
  *      Retreive the default executable, if any, for this board.
  *  Parameters:
- *      dev_node_obj:       Handle to the dev_node who's WMD we are querying.
+ *      dev_node_obj: Handle to the dev_node who's driver we are querying.
  *      buf_size:       Size of buffer.
  *      pstrExecFile:   Ptr to character buf to hold ExecFile.
  *  Returns:
@@ -155,7 +155,7 @@ extern void cfg_get_perf_value(OUT bool *pfEnablePerf);
  *  Purpose:
  *      Retreive the ZLFile, if any, for this board.
  *  Parameters:
- *      dev_node_obj:       Handle to the dev_node who's WMD we are querying.
+ *      dev_node_obj: Handle to the dev_node who's driver we are querying.
  *      buf_size:       Size of buffer.
  *      pstrZLFileName: Ptr to character buf to hold ZLFileName.
  *  Returns:
diff --git a/arch/arm/plat-omap/include/dspbridge/chnlpriv.h b/arch/arm/plat-omap/include/dspbridge/chnlpriv.h
index 7a7c420..fce5ebd 100644
--- a/arch/arm/plat-omap/include/dspbridge/chnlpriv.h
+++ b/arch/arm/plat-omap/include/dspbridge/chnlpriv.h
@@ -3,7 +3,8 @@
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
- * Private channel header shared between DSPSYS, WCD and WMD modules.
+ * Private channel header shared between DSPSYS, DSPAPI and
+ * Bridge driver modules.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/dev.h b/arch/arm/plat-omap/include/dspbridge/dev.h
index aa79064..8f3b6fc 100644
--- a/arch/arm/plat-omap/include/dspbridge/dev.h
+++ b/arch/arm/plat-omap/include/dspbridge/dev.h
@@ -65,24 +65,22 @@ extern u32 dev_brd_write_fxn(void *pArb,
  *      'Bridge device.
  *  Parameters:
  *      phDevObject:    Ptr to location to receive the device object handle.
- *      driver_file_name: Name of WMD PE DLL file to load.  If the absolute
- *                      path is not provided, the file is loaded through
- *                      'Bridge's module search path.
+ *      driver_file_name: Name of Bridge driver PE DLL file to load.  If the
+ *                      absolute path is not provided, the file is loaded
+ *                      through 'Bridge's module search path.
  *      pHostConfig:    Host configuration information, to be passed down
- *                      to the WMD when bridge_dev_create() is called.
- *      pDspConfig:     DSP resources, to be passed down to the WMD when
- *                      bridge_dev_create() is called.
+ *                      to the Bridge driver when bridge_dev_create() is called.
+ *      pDspConfig:     DSP resources, to be passed down to the Bridge driver
+ *                      when bridge_dev_create() is called.
  *      dev_node_obj:       Platform specific device node.
  *  Returns:
  *      DSP_SOK:            Module is loaded, device object has been created
  *      -ENOMEM:        Insufficient memory to create needed resources.
- *      DEV_E_NEWWMD:       The WMD was compiled for a newer version of WCD.
- *      DEV_E_NULLWMDINTF:  WMD passed back a NULL fxn Interface Struct Ptr
  *      DEV_E_NOCODMODULE:  No ZL file name was specified in the registry
  *                          for this dev_node_obj.
- *      LDR_E_FILEUNABLETOOPEN: Unable to open the specified WMD.
+ *      LDR_E_FILEUNABLETOOPEN: Unable to open the specified Bridge driver.
  *      LDR_E_NOMEMORY:         PELDR is out of resources.
- *      -EPERM:              Unable to find WMD entry point function.
+ *      -EPERM:              Unable to find Bridge driver entry point function.
  *      COD_E_NOZLFUNCTIONS:    One or more ZL functions exports not found.
  *      COD_E_ZLCREATEFAILED:   Unable to load ZL DLL.
  *  Requires:
@@ -93,8 +91,8 @@ extern u32 dev_brd_write_fxn(void *pArb,
  *      pDspConfig != NULL.
  *  Ensures:
  *      DSP_SOK:  *phDevObject will contain handle to the new device object.
- *      Otherwise, does not create the device object, ensures the WMD module is
- *      unloaded, and sets *phDevObject to NULL.
+ *      Otherwise, does not create the device object, ensures the Bridge driver
+ *      module is unloaded, and sets *phDevObject to NULL.
  */
 extern dsp_status dev_create_device(OUT struct dev_object
 				    **phDevObject,
@@ -107,24 +105,22 @@ extern dsp_status dev_create_device(OUT struct dev_object
  *      Called by the operating system to load the 'Bridge Mini Driver for IVA.
  *  Parameters:
  *      phDevObject:    Ptr to location to receive the device object handle.
- *      driver_file_name: Name of WMD PE DLL file to load.  If the absolute
- *                      path is not provided, the file is loaded through
- *                      'Bridge's module search path.
+ *      driver_file_name: Name of Bridge driver PE DLL file to load.  If the
+ *                      absolute path is not provided, the file is loaded
+ *                      through 'Bridge's module search path.
  *      pHostConfig:    Host configuration information, to be passed down
- *                      to the WMD when bridge_dev_create() is called.
- *      pDspConfig:     DSP resources, to be passed down to the WMD when
- *                      bridge_dev_create() is called.
+ *                      to the Bridge driver when bridge_dev_create() is called.
+ *      pDspConfig:     DSP resources, to be passed down to the Bridge driver
+ *                      when bridge_dev_create() is called.
  *      dev_node_obj:       Platform specific device node.
  *  Returns:
  *      DSP_SOK:            Module is loaded, device object has been created
  *      -ENOMEM:        Insufficient memory to create needed resources.
- *      DEV_E_NEWWMD:       The WMD was compiled for a newer version of WCD.
- *      DEV_E_NULLWMDINTF:  WMD passed back a NULL fxn Interface Struct Ptr
  *      DEV_E_NOCODMODULE:  No ZL file name was specified in the registry
  *                          for this dev_node_obj.
- *      LDR_E_FILEUNABLETOOPEN: Unable to open the specified WMD.
+ *      LDR_E_FILEUNABLETOOPEN: Unable to open the specified Bridge driver.
  *      LDR_E_NOMEMORY:         PELDR is out of resources.
- *      -EPERM:              Unable to find WMD entry point function.
+ *      -EPERM:              Unable to find Bridge driver entry point function.
  *      COD_E_NOZLFUNCTIONS:    One or more ZL functions exports not found.
  *      COD_E_ZLCREATEFAILED:   Unable to load ZL DLL.
  *  Requires:
@@ -135,8 +131,8 @@ extern dsp_status dev_create_device(OUT struct dev_object
  *      pDspConfig != NULL.
  *  Ensures:
  *      DSP_SOK:  *phDevObject will contain handle to the new device object.
- *      Otherwise, does not create the device object, ensures the WMD module is
- *      unloaded, and sets *phDevObject to NULL.
+ *      Otherwise, does not create the device object, ensures the Bridge driver
+ *      module is unloaded, and sets *phDevObject to NULL.
  */
 extern dsp_status dev_create_iva_device(OUT struct dev_object
 					**phDevObject,
@@ -187,14 +183,14 @@ extern dsp_status dev_destroy2(IN struct dev_object *hdev_obj);
  *  ======== dev_destroy_device ========
  *  Purpose:
  *      Destroys the channel manager for this device, if any, calls
- *      bridge_dev_destroy(), and then attempts to unload the WMD module.
+ *      bridge_dev_destroy(), and then attempts to unload the Bridge module.
  *  Parameters:
  *      hdev_obj:     Handle to device object created with
  *                      dev_create_device().
  *  Returns:
  *      DSP_SOK:        Success.
  *      -EFAULT:    Invalid hdev_obj.
- *      -EPERM:      The WMD failed it's bridge_dev_destroy() function.
+ *      -EPERM:     The Bridge driver failed it's bridge_dev_destroy() function.
  *  Requires:
  *      DEV Initialized.
  *  Ensures:
@@ -376,7 +372,8 @@ extern struct dev_object *dev_get_first(void);
 /*
  *  ======== dev_get_intf_fxns ========
  *  Purpose:
- *      Retrieve the WMD interface function structure for the loaded WMD.
+ *      Retrieve the Bridge driver interface function structure for the
+ *      loaded Bridge driver.
  *  Parameters:
  *      hdev_obj:     Handle to device object created with
  *                      dev_create_device().
@@ -388,7 +385,8 @@ extern struct dev_object *dev_get_first(void);
  *      ppIntfFxns != NULL.
  *      DEV Initialized.
  *  Ensures:
- *      DSP_SOK:        *ppIntfFxns contains a pointer to the WMD interface;
+ *      DSP_SOK:        *ppIntfFxns contains a pointer to the Bridge
+ *                      driver interface;
  *      else:           *ppIntfFxns is NULL.
  */
 extern dsp_status dev_get_intf_fxns(struct dev_object *hdev_obj,
@@ -507,7 +505,8 @@ extern dsp_status dev_get_symbol(struct dev_object *hdev_obj,
 /*
  *  ======== dev_get_bridge_context ========
  *  Purpose:
- *      Retrieve the WMD Context handle, as returned by the WMD_Create fxn.
+ *      Retrieve the Bridge Context handle, as returned by the
+ *      bridge_dev_create fxn.
  *  Parameters:
  *      hdev_obj:     Handle to device object created with dev_create_device()
  *      *phbridge_context:  Ptr to location to store context handle.
diff --git a/arch/arm/plat-omap/include/dspbridge/devdefs.h b/arch/arm/plat-omap/include/dspbridge/devdefs.h
index 600be0e..8b56748 100644
--- a/arch/arm/plat-omap/include/dspbridge/devdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/devdefs.h
@@ -4,7 +4,7 @@
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
  * Definition of common include typedef between dspdefs.h and dev.h. Required
- * to break circular dependency between WMD and DEV include files.
+ * to break circular dependency between Bridge driver and DEV include files.
  *
  * Copyright (C) 2008 Texas Instruments, Inc.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/dspchnl.h b/arch/arm/plat-omap/include/dspbridge/dspchnl.h
index d1af155..25246e1 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspchnl.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspchnl.h
@@ -4,8 +4,8 @@
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
  * Declares the upper edge channel class library functions required by
- * all WMD / WCD driver interface tables.  These functions are implemented
- * by every class of WMD channel library.
+ * all Bridge driver / DSP API driver interface tables. These functions are
+ * implemented by every class of Bridge channel library.
  *
  * Notes:
  *   The function comment headers reside in dspdefs.h.
diff --git a/arch/arm/plat-omap/include/dspbridge/dspdefs.h b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
index 3dfe406..47f631c 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
@@ -9,11 +9,11 @@
  *   The Bridge class driver obtains it's function interface to
  *   the Bridge mini driver via a call to bridge_drv_entry().
  *
- *   Bridge Class Driver services exported to WMD's are initialized by the
- *   WCD on behalf of the WMD.
+ *   Bridge services exported to Bridge drivers are initialized by the
+ *   DSP API on behalf of the Bridge driver.
  *
- *   WMD function DBC Requires and Ensures are also made by the WCD on
- *   behalf of the WMD, to simplify the WMD code.
+ *   Bridge function DBC Requires and Ensures are also made by the DSP API on
+ *   behalf of the Bridge driver, to simplify the Bridge driver code.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
  *
@@ -38,7 +38,7 @@
 #include <dspbridge/msgdefs.h>
 
 /*
- *  Any IOCTLS at or above this value are reserved for standard WMD
+ *  Any IOCTLS at or above this value are reserved for standard Bridge driver
  *  interfaces.
  */
 #define BRD_RESERVEDIOCTLBASE   0x8000
@@ -58,7 +58,6 @@ struct bridge_dev_context;
  *      hDevContext:    Handle to mini-driver defined device context.
  *  Returns:
  *      DSP_SOK:        Success.
- *      WMD_E_HARDWARE: A test of hardware assumptions/integrity failed.
  *      -ETIMEDOUT:  Timeout occured waiting for a response from hardware.
  *      -EPERM:      Other, unspecified error.
  *  Requires:
@@ -651,7 +650,7 @@ typedef dsp_status(*fxn_chnl_registernotify)
  *  Purpose:
  *      Complete creation of the device object for this board.
  *  Parameters:
- *      phDevContext:   Ptr to location to store a WMD device context.
+ *      phDevContext:   Ptr to location to store a Bridge device context.
  *      hdev_obj:     Handle to a Device Object, created and managed by WCD.
  *      pConfig:        Ptr to configuration parameters provided by the
  *                      Configuration Manager during device loading.
@@ -660,9 +659,6 @@ typedef dsp_status(*fxn_chnl_registernotify)
  *  Returns:
  *      DSP_SOK:            Success.
  *      -ENOMEM:        Unable to allocate memory for device context.
- *      WMD_E_BADCONFIG:    One or more of the host or DSP configuration
- *                          parameters did not satisfy hardware assumptions
- *                          made by this WMD.
  *  Requires:
  *      phDevContext != NULL;
  *      hdev_obj != NULL;
@@ -672,14 +668,14 @@ typedef dsp_status(*fxn_chnl_registernotify)
  *  Ensures:
  *      DSP_SOK:        All mini-driver specific DSP resource and other
  *                      board context has been allocated.
- *      -ENOMEM:    WMD failed to allocate resources.
+ *      -ENOMEM:    Bridge failed to allocate resources.
  *                      Any acquired resources have been freed.  The WCD will
  *                      not call bridge_dev_destroy() if bridge_dev_create()
  *                      fails.
  *  Details:
  *      Called during the CONFIGMG's Device_Init phase. Based on host and
  *      DSP configuration information, create a board context, a handle to
- *      which is passed into other WMD BRD and CHNL functions.  The
+ *      which is passed into other Bridge BRD and CHNL functions.  The
  *      board context contains state information for the device. Since the
  *      addresses of all IN pointer parameters may be invalid when this
  *      function returns, they must not be stored into the device context
@@ -698,11 +694,11 @@ typedef dsp_status(*fxn_dev_create) (OUT struct bridge_dev_context
  *      Mini-driver specific interface.
  *  Parameters:
  *      hDevContext:    Handle to mini-driver defined device info.
- *      dw_cmd:          WMD defined command code.
+ *      dw_cmd:          Bridge driver defined command code.
  *      pargs:          Pointer to an arbitrary argument structure.
  *  Returns:
- *      DSP_SOK or -EPERM. Actual command error codes should be passed back
- *      in the pargs structure, and are defined by the WMD implementor.
+ *      DSP_SOK or -EPERM. Actual command error codes should be passed back in
+ *      the pargs structure, and are defined by the Bridge driver implementor.
  *  Requires:
  *      All calls are currently assumed to be synchronous.  There are no
  *      IOCTL completion routines provided.
@@ -714,7 +710,7 @@ typedef dsp_status(*fxn_dev_ctrl) (struct bridge_dev_context *hDevContext,
 /*
  *  ======== bridge_dev_destroy ========
  *  Purpose:
- *      Deallocate WMD device extension structures and all other resources
+ *      Deallocate Bridge device extension structures and all other resources
  *      acquired by the mini-driver.
  *      No calls to other mini driver functions may subsequently
  *      occur, except for bridge_dev_create().
@@ -1037,21 +1033,21 @@ typedef void (*fxn_msg_setqueueid) (struct msg_queue *msg_queue_obj,
 				    u32 msgq_id);
 
 /*
- *  'Bridge Mini Driver (WMD) interface function table.
+ *  Bridge Driver interface function table.
  *
  *  The information in this table is filled in by the specific mini-driver,
  *  and copied into the 'Bridge class driver's own space.  If any interface
  *  function field is set to a value of NULL, then the class driver will
  *  consider that function not implemented, and return the error code
- *  -ENOSYS when a WMD client attempts to call that function.
+ *  -ENOSYS when a Bridge driver client attempts to call that function.
  *
  *  This function table contains WCD version numbers, which are used by the
- *  WMD loader to help ensure backwards compatility between older WMD's and a
- *  newer 'Bridge Class Driver.  These must be set to WCD_MAJOR_VERSION
- *  and WCD_MINOR_VERSION, respectively.
+ *  Bridge driver loader to help ensure backwards compatility between older
+ *  Bridge drivers and newer 'Bridge Class Driver.  These must be set to
+ *  WCD_MAJOR_VERSION and WCD_MINOR_VERSION, respectively.
  *
  *  A mini-driver need not export a CHNL interface.  In this case, *all* of
- *  the WMD_CHNL_* entries must be set to NULL.
+ *  the bridge_chnl_* entries must be set to NULL.
  */
 struct bridge_drv_interface {
 	u32 brd_api_major_version;	/* Set to BRD_API_MAJOR_VERSION. */
@@ -1112,7 +1108,7 @@ struct bridge_drv_interface {
 /*
  *  ======== bridge_drv_entry ========
  *  Purpose:
- *      Registers WMD functions with the class driver. Called only once
+ *      Registers Bridge driver functions with the DSP API. Called only once
  *      by the WCD.  The caller will first check WCD version compatibility, and
  *      then copy the interface functions into its own memory space.
  *  Parameters:
@@ -1123,8 +1119,8 @@ struct bridge_drv_interface {
  *      The code segment this function resides in must expect to be discarded
  *      after completion.
  *  Ensures:
- *      ppDrvInterface pointer initialized to WMD's function interface.
- *      No system resources are acquired by this function.
+ *      ppDrvInterface pointer initialized to Bridge driver's function
+ *      interface. No system resources are acquired by this function.
  *  Details:
  *      Called during the Device_Init phase.
  */
diff --git a/arch/arm/plat-omap/include/dspbridge/dspdeh.h b/arch/arm/plat-omap/include/dspbridge/dspdeh.h
index 33cce90..a0707eb 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspdeh.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspdeh.h
@@ -3,7 +3,7 @@
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
- * Defines upper edge DEH functions required by all WMD/WCD driver
+ * Defines upper edge DEH functions required by all Bridge driver/DSP API
  * interface tables.
  *
  * Notes:
diff --git a/arch/arm/plat-omap/include/dspbridge/dspio.h b/arch/arm/plat-omap/include/dspbridge/dspio.h
index a826d9d..329083e 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspio.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspio.h
@@ -3,8 +3,8 @@
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
- * Declares the upper edge IO functions required by all WMD / WCD
- * driver interface tables.
+ * Declares the upper edge IO functions required by all Bridge driver /DSP API
+ * interface tables.
  *
  * Notes:
  *   Function comment headers reside in dspdefs.h.
diff --git a/arch/arm/plat-omap/include/dspbridge/dspioctl.h b/arch/arm/plat-omap/include/dspbridge/dspioctl.h
index 380fff5..111422c 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspioctl.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspioctl.h
@@ -24,7 +24,7 @@
 #include <hw_mmu.h>
 
 /*
- * Any IOCTLS at or above this value are reserved for standard WMD
+ * Any IOCTLS at or above this value are reserved for standard Bridge driver
  * interfaces.
  */
 #define BRDIOCTL_RESERVEDBASE       0x8000
diff --git a/arch/arm/plat-omap/include/dspbridge/dspmsg.h b/arch/arm/plat-omap/include/dspbridge/dspmsg.h
index cd34ff7..e6f677a 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspmsg.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspmsg.h
@@ -4,8 +4,8 @@
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
  * Declares the upper edge message class library functions required by
- * all WMD / WCD driver interface tables.  These functions are
- * implemented by every class of WMD channel library.
+ * all Bridge driver / DSP API interface tables.  These functions are
+ * implemented by every class of Bridge driver channel library.
  *
  * Notes:
  *   Function comment headers reside in dspdefs.h.
diff --git a/arch/arm/plat-omap/include/dspbridge/io_sm.h b/arch/arm/plat-omap/include/dspbridge/io_sm.h
index ce87eb3..8a1869f 100644
--- a/arch/arm/plat-omap/include/dspbridge/io_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/io_sm.h
@@ -83,9 +83,9 @@ extern void io_dpc(IN OUT unsigned long pRefData);
 /*
  *  ======== io_mbox_msg ========
  *  Purpose:
- *      Main interrupt handler for the shared memory WMD channel manager.
- *      Calls the WMD's chnlsm_isr to determine if this interrupt is ours, then
- *      schedules a DPC to dispatch I/O..
+ *      Main interrupt handler for the shared memory Bridge channel manager.
+ *      Calls the Bridge's chnlsm_isr to determine if this interrupt is ours,
+ *      then schedules a DPC to dispatch I/O.
  *  Parameters:
  *      pRefData:   Pointer to the channel manager object for this board.
  *                  Set in an initial call to ISR_Install().
diff --git a/arch/arm/plat-omap/include/dspbridge/memdefs.h b/arch/arm/plat-omap/include/dspbridge/memdefs.h
index cce6957..78d2c5d 100644
--- a/arch/arm/plat-omap/include/dspbridge/memdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/memdefs.h
@@ -3,7 +3,7 @@
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
- * Global MEM constants and types, shared between WCD and WMD.
+ * Global MEM constants and types, shared between Bridge driver and DSP API.
  *
  * Copyright (C) 2008 Texas Instruments, Inc.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/plat-omap/include/dspbridge/proc.h
index 18b51c5..3546c80 100644
--- a/arch/arm/plat-omap/include/dspbridge/proc.h
+++ b/arch/arm/plat-omap/include/dspbridge/proc.h
@@ -100,7 +100,7 @@ extern dsp_status proc_auto_start(struct cfg_devnode *dev_node_obj,
  *      PROC Initialized.
  *  Ensures
  *  Details:
- *      This function Calls WMD_BRD_Ioctl.
+ *      This function Calls bridge_dev_ctrl.
  */
 extern dsp_status proc_ctrl(void *hprocessor,
 			    u32 dw_cmd, IN struct dsp_cbdata *pargs);
diff --git a/drivers/dsp/bridge/core/_msg_sm.h b/drivers/dsp/bridge/core/_msg_sm.h
index 99e8640..556de5c 100644
--- a/drivers/dsp/bridge/core/_msg_sm.h
+++ b/drivers/dsp/bridge/core/_msg_sm.h
@@ -81,7 +81,9 @@ struct msg_ctrl {
  */
 struct msg_mgr {
 	/* The first field must match that in msgobj.h */
-	struct bridge_drv_interface *intf_fxns;	/* Function interface to WMD. */
+
+	/* Function interface to Bridge driver */
+	struct bridge_drv_interface *intf_fxns;
 
 	struct io_mgr *hio_mgr;	/* IO manager */
 	struct lst_list *queue_list;	/* List of MSG_QUEUEs */
diff --git a/drivers/dsp/bridge/core/_tiomap.h b/drivers/dsp/bridge/core/_tiomap.h
index df73964..62eee09 100644
--- a/drivers/dsp/bridge/core/_tiomap.h
+++ b/drivers/dsp/bridge/core/_tiomap.h
@@ -3,7 +3,7 @@
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
- * Definitions and types private to this WMD.
+ * Definitions and types private to this Bridge driver.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
  *
@@ -335,7 +335,7 @@ struct bridge_dev_context {
 
 	/*
 	 * Processor specific info is set when prog loaded and read from DCD.
-	 * [See WMD_BRD_Ctrl()]  PROC info contains DSP-MMU TLB entries.
+	 * [See bridge_dev_ctrl()]  PROC info contains DSP-MMU TLB entries.
 	 */
 	/* DMMU TLB entries */
 	struct bridge_ioctl_extproc atlb_entry[BRDIOCTL_NUMOFMMUTLB];
diff --git a/drivers/dsp/bridge/core/chnl_sm.c b/drivers/dsp/bridge/core/chnl_sm.c
index 0515edd..34d515f 100644
--- a/drivers/dsp/bridge/core/chnl_sm.c
+++ b/drivers/dsp/bridge/core/chnl_sm.c
@@ -3,7 +3,7 @@
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
- * Implements upper edge functions for WMD channel module.
+ * Implements upper edge functions for Bridge driver channel module.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
  *
@@ -17,8 +17,8 @@
  */
 
 /*
- *      The lower edge functions must be implemented by the WMD writer, and
- *      are declared in chnl_sm.h.
+ *      The lower edge functions must be implemented by the Bridge driver
+ *      writer, and are declared in chnl_sm.h.
  *
  *      Care is taken in this code to prevent simulataneous access to channel
  *      queues from
diff --git a/drivers/dsp/bridge/core/io_sm.c b/drivers/dsp/bridge/core/io_sm.c
index d6c1a98..8d306ad 100644
--- a/drivers/dsp/bridge/core/io_sm.c
+++ b/drivers/dsp/bridge/core/io_sm.c
@@ -89,8 +89,10 @@
 /* IO Manager: only one created per board */
 struct io_mgr {
 	/* These four fields must be the first fields in a io_mgr_ struct */
-	struct bridge_dev_context *hbridge_context;	/* WMD device context */
-	struct bridge_drv_interface *intf_fxns;	/* Function interface to WMD */
+	/* Bridge device context */
+	struct bridge_dev_context *hbridge_context;
+	/* Function interface to Bridge driver */
+	struct bridge_drv_interface *intf_fxns;
 	struct dev_object *hdev_obj;	/* Device this board represents */
 
 	/* These fields initialized in bridge_io_create() */
@@ -691,8 +693,8 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
 		ul_shm_base_offset = (ul_shm_base - ae_proc[0].ul_dsp_va) *
 		    hio_mgr->word_size;
 		/*
-		 * WMD_BRD_Ctrl() will set dev context dsp-mmu info. In
-		 * _BRD_Start() the MMU will be re-programed with MMU
+		 * bridge_dev_ctrl() will set dev context dsp-mmu info. In
+		 * bridge_brd_start() the MMU will be re-programed with MMU
 		 * DSPVa-GPPPa pair info while DSP is in a known
 		 * (reset) state.
 		 */
@@ -877,7 +879,7 @@ static void io_dispatch_pm(struct io_mgr *pio_mgr)
 	/* Perform Power message processing here */
 	parg[0] = pio_mgr->intr_val;
 
-	/* Send the command to the WMD clk/pwr manager to handle */
+	/* Send the command to the Bridge clk/pwr manager to handle */
 	if (parg[0] == MBX_PM_HIBERNATE_EN) {
 		dev_dbg(bridge, "PM: Hibernate command\n");
 		status = pio_mgr->intf_fxns->
@@ -971,7 +973,7 @@ func_end:
 /*
  *  ======== io_mbox_msg ========
  *      Main interrupt handler for the shared memory IO manager.
- *      Calls the WMD's CHNL_ISR to determine if this interrupt is ours, then
+ *      Calls the Bridge's CHNL_ISR to determine if this interrupt is ours, then
  *      schedules a DPC to dispatch I/O.
  */
 void io_mbox_msg(u32 msg)
diff --git a/drivers/dsp/bridge/core/msg_sm.c b/drivers/dsp/bridge/core/msg_sm.c
index d418ecf..f043f91 100644
--- a/drivers/dsp/bridge/core/msg_sm.c
+++ b/drivers/dsp/bridge/core/msg_sm.c
@@ -3,7 +3,7 @@
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
- * Implements upper edge functions for WMD message module.
+ * Implements upper edge functions for Bridge message module.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
  *
diff --git a/drivers/dsp/bridge/core/tiomap3430.c b/drivers/dsp/bridge/core/tiomap3430.c
index c7b0d83..72a5bdf 100644
--- a/drivers/dsp/bridge/core/tiomap3430.c
+++ b/drivers/dsp/bridge/core/tiomap3430.c
@@ -826,8 +826,8 @@ static dsp_status bridge_dev_create(OUT struct bridge_dev_context
 	u32 align_size;
 	struct drv_data *drv_datap = dev_get_drvdata(bridge);
 
-	/* Allocate and initialize a data structure to contain the mini driver
-	 *  state, which becomes the context for later calls into this WMD. */
+	/* Allocate and initialize a data structure to contain the bridge driver
+	 *  state, which becomes the context for later calls into this driver */
 	dev_context = kzalloc(sizeof(struct bridge_dev_context), GFP_KERNEL);
 	if (!dev_context) {
 		status = -ENOMEM;
@@ -839,7 +839,7 @@ static dsp_status bridge_dev_create(OUT struct bridge_dev_context
 	dev_context->dsp_per_clks = 0;
 	dev_context->dw_internal_size = OMAP_DSP_SIZE;
 	/*  Clear dev context MMU table entries.
-	 *  These get set on WMD_BRD_IOCTL() call after program loaded. */
+	 *  These get set on bridge_io_on_loaded() call after program loaded. */
 	for (entry_ndx = 0; entry_ndx < BRDIOCTL_NUMOFMMUTLB; entry_ndx++) {
 		dev_context->atlb_entry[entry_ndx].ul_gpp_pa =
 		    dev_context->atlb_entry[entry_ndx].ul_dsp_va = 0;
diff --git a/drivers/dsp/bridge/core/tiomap3430_pwr.c b/drivers/dsp/bridge/core/tiomap3430_pwr.c
index 1897c50..aa896b7 100644
--- a/drivers/dsp/bridge/core/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/core/tiomap3430_pwr.c
@@ -251,10 +251,10 @@ dsp_status wake_dsp(struct bridge_dev_context *dev_context, IN void *pargs)
 	dsp_status status = DSP_SOK;
 #ifdef CONFIG_PM
 
-	/* Check the BRD/WMD state, if it is not 'SLEEP' then return failure */
+	/* Check the board state, if it is not 'SLEEP' then return */
 	if (dev_context->dw_brd_state == BRD_RUNNING ||
 	    dev_context->dw_brd_state == BRD_STOPPED) {
-		/* The Device is in 'RET' or 'OFF' state and WMD state is not
+		/* The Device is in 'RET' or 'OFF' state and Bridge state is not
 		 * 'SLEEP', this means state inconsistency, so return */
 		return DSP_SOK;
 	}
diff --git a/drivers/dsp/bridge/core/ue_deh.c b/drivers/dsp/bridge/core/ue_deh.c
index 605f312..450534e 100644
--- a/drivers/dsp/bridge/core/ue_deh.c
+++ b/drivers/dsp/bridge/core/ue_deh.c
@@ -81,7 +81,7 @@ dsp_status bridge_deh_create(struct deh_mgr **ret_deh_mgr,
 	/*  Message manager will be created when a file is loaded, since
 	 *  size of message buffer in shared memory is configurable in
 	 *  the base image. */
-	/* Get WMD context info. */
+	/* Get Bridge context info. */
 	dev_get_bridge_context(hdev_obj, &hbridge_context);
 	DBC_ASSERT(hbridge_context);
 	dummy_va_addr = NULL;
diff --git a/drivers/dsp/bridge/pmgr/chnl.c b/drivers/dsp/bridge/pmgr/chnl.c
index bc5c3e9..6eb8f7e 100644
--- a/drivers/dsp/bridge/pmgr/chnl.c
+++ b/drivers/dsp/bridge/pmgr/chnl.c
@@ -88,7 +88,7 @@ dsp_status chnl_create(OUT struct chnl_mgr **phChnlMgr,
 	if (DSP_SUCCEEDED(status)) {
 		struct bridge_drv_interface *intf_fxns;
 		dev_get_intf_fxns(hdev_obj, &intf_fxns);
-		/* Let WMD channel module finish the create: */
+		/* Let Bridge channel module finish the create: */
 		status = (*intf_fxns->pfn_chnl_create) (&hchnl_mgr, hdev_obj,
 							pMgrAttrs);
 		if (DSP_SUCCEEDED(status)) {
@@ -121,7 +121,7 @@ dsp_status chnl_destroy(struct chnl_mgr *hchnl_mgr)
 
 	if (chnl_mgr_obj) {
 		intf_fxns = chnl_mgr_obj->intf_fxns;
-		/* Let WMD channel module destroy the chnl_mgr: */
+		/* Let Bridge channel module destroy the chnl_mgr: */
 		status = (*intf_fxns->pfn_chnl_destroy) (hchnl_mgr);
 	} else {
 		status = -EFAULT;
diff --git a/drivers/dsp/bridge/pmgr/chnlobj.h b/drivers/dsp/bridge/pmgr/chnlobj.h
index 39ce007..13b637b 100644
--- a/drivers/dsp/bridge/pmgr/chnlobj.h
+++ b/drivers/dsp/bridge/pmgr/chnlobj.h
@@ -24,19 +24,19 @@
 #include <dspbridge/dspdefs.h>
 
 /*
- *  This struct is the first field in a chnl_mgr struct, as implemented in
- *  a WMD channel class library.  Other, implementation specific fields
- *  follow this structure in memory.
+ *  This struct is the first field in a chnl_mgr struct. Other. implementation
+ *  specific fields follow this structure in memory.
  */
 struct chnl_mgr_ {
 	/* These must be the first fields in a chnl_mgr struct: */
-	struct bridge_drv_interface *intf_fxns;	/* Function interface to WMD. */
+
+	/* Function interface to Bridge driver. */
+	struct bridge_drv_interface *intf_fxns;
 };
 
 /*
- *  This struct is the first field in a chnl_object struct, as implemented in
- *  a WMD channel class library.  Other, implementation specific fields
- *  follow this structure in memory.
+ *  This struct is the first field in a chnl_object struct. Other,
+ *  implementation specific fields follow this structure in memory.
  */
 struct chnl_object_ {
 	/* These must be the first fields in a chnl_object struct: */
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index c85a4fa..47c9715 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -59,13 +59,14 @@
 #define BRD_API_VERSION		MAKEVERSION(BRD_API_MAJOR_VERSION,	\
 				BRD_API_MINOR_VERSION)
 
-/* The WMD device object: */
+/* The Bridge device object: */
 struct dev_object {
 	/* LST requires "link" to be first field! */
 	struct list_head link;	/* Link to next dev_object. */
 	u8 dev_type;		/* Device Type */
 	struct cfg_devnode *dev_node_obj;	/* Platform specific dev id */
-	struct bridge_dev_context *hbridge_context;	/* WMD Context Handle */
+	/* Bridge Context Handle */
+	struct bridge_dev_context *hbridge_context;
 	/* Function interface to Bridge driver. */
 	struct bridge_drv_interface bridge_interface;
 	struct brd_object *lock_owner;	/* Client with exclusive access. */
@@ -76,7 +77,7 @@ struct dev_object {
 	struct io_mgr *hio_mgr;	/* IO manager (CHNL, msg_ctrl) */
 	struct cmm_object *hcmm_mgr;	/* SM memory manager. */
 	struct dmm_object *dmm_mgr;	/* Dynamic memory manager. */
-	struct ldr_module *module_obj;	/* WMD Module handle. */
+	struct ldr_module *module_obj;	/* Bridge Module handle. */
 	u32 word_size;		/* DSP word size: quick access. */
 	struct drv_object *hdrv_obj;	/* Driver Object */
 	struct lst_list *proc_list;	/* List of Proceeosr attached to
@@ -153,13 +154,13 @@ dsp_status dev_create_device(OUT struct dev_object **phDevObject,
 		dev_dbg(bridge, "%s: Failed to reserve bridge resources\n",
 			__func__);
 
-	/*  Get the WMD interface functions */
+	/*  Get the Bridge driver interface functions */
 	bridge_drv_entry(&drv_fxns, driver_file_name);
 	if (DSP_FAILED(cfg_get_object((u32 *) &hdrv_obj, REG_DRV_OBJECT))) {
 		/* don't propogate CFG errors from this PROC function */
 		status = -EPERM;
 	}
-	/* Create the device object, and pass a handle to the WMD for
+	/* Create the device object, and pass a handle to the Bridge driver for
 	 * storage. */
 	if (DSP_SUCCEEDED(status)) {
 		DBC_ASSERT(drv_fxns);
@@ -175,12 +176,12 @@ dsp_status dev_create_device(OUT struct dev_object **phDevObject,
 			dev_obj->word_size = DSPWORDSIZE;
 			dev_obj->hdrv_obj = hdrv_obj;
 			dev_obj->dev_type = DSP_UNIT;
-			/* Store this WMD's interface functions, based on its
+			/* Store this Bridge's interface functions, based on its
 			 * version. */
 			store_interface_fxns(drv_fxns,
 						&dev_obj->bridge_interface);
 
-			/* Call fxn_dev_create() to get the WMD's device
+			/* Call fxn_dev_create() to get the Bridge's device
 			 * context handle. */
 			status = (dev_obj->bridge_interface.pfn_dev_create)
 			    (&dev_obj->hbridge_context, dev_obj,
@@ -335,7 +336,7 @@ dsp_status dev_destroy2(struct dev_object *hdev_obj)
  *  ======== dev_destroy_device ========
  *  Purpose:
  *      Destroys the channel manager for this device, if any, calls
- *      bridge_dev_destroy(), and then attempts to unload the WMD module.
+ *      bridge_dev_destroy(), and then attempts to unload the Bridge module.
  */
 dsp_status dev_destroy_device(struct dev_object *hdev_obj)
 {
@@ -585,7 +586,7 @@ struct dev_object *dev_get_first(void)
 /*
  *  ======== dev_get_intf_fxns ========
  *  Purpose:
- *      Retrieve the WMD interface function structure for the loaded WMD.
+ *      Retrieve the Bridge interface function structure for the loaded driver.
  *      ppIntfFxns != NULL.
  */
 dsp_status dev_get_intf_fxns(struct dev_object *hdev_obj,
@@ -718,7 +719,8 @@ dsp_status dev_get_symbol(struct dev_object *hdev_obj,
 /*
  *  ======== dev_get_bridge_context ========
  *  Purpose:
- *      Retrieve the WMD Context handle, as returned by the WMD_Create fxn.
+ *      Retrieve the Bridge Context handle, as returned by the
+ *      bridge_dev_create fxn.
  */
 dsp_status dev_get_bridge_context(struct dev_object *hdev_obj,
 			       OUT struct bridge_dev_context **phbridge_context)
@@ -882,7 +884,7 @@ void dev_set_msg_mgr(struct dev_object *hdev_obj, struct msg_mgr *hmgr)
 dsp_status dev_start_device(struct cfg_devnode *dev_node_obj)
 {
 	struct dev_object *hdev_obj = NULL;	/* handle to 'Bridge Device */
-	/* wmd filename */
+	/* Bridge driver filename */
 	char bridge_file_name[CFG_MAXSEARCHPATHLEN] = "UMA";
 	dsp_status status;
 	struct mgr_object *hmgr_obj = NULL;
@@ -919,7 +921,7 @@ dsp_status dev_start_device(struct cfg_devnode *dev_node_obj)
 /*
  *  ======== fxn_not_implemented ========
  *  Purpose:
- *      Takes the place of a WMD Null Function.
+ *      Takes the place of a Bridge Null Function.
  *  Parameters:
  *      Multiple, optional.
  *  Returns:
@@ -1054,20 +1056,20 @@ dsp_status dev_get_dev_type(struct dev_object *hdevObject, u8 *dev_type)
 /*
  *  ======== store_interface_fxns ========
  *  Purpose:
- *      Copy the WMD's interface functions into the device object,
+ *      Copy the Bridge's interface functions into the device object,
  *      ensuring that fxn_not_implemented() is set for:
  *
- *      1. All WMD function pointers which are NULL; and
+ *      1. All Bridge function pointers which are NULL; and
  *      2. All function slots in the struct dev_object structure which have no
- *         corresponding slots in the the WMD's interface, because the WMD
+ *         corresponding slots in the the Bridge's interface, because the Bridge
  *         is of an *older* version.
  *  Parameters:
  *      intf_fxns:      Interface fxn Structure of the WCD's Dev Object.
- *      drv_fxns:       Interface Fxns offered by the WMD during DEV_Create().
+ *      drv_fxns:      Interface Fxns offered by the Bridge during DEV_Create().
  *  Returns:
  *  Requires:
  *      Input pointers are valid.
- *      WMD is *not* written for a newer WCD.
+ *      Bridge driver is *not* written for a newer DSP API.
  *  Ensures:
  *      All function pointers in the dev object's fxn interface are not NULL.
  */
@@ -1135,7 +1137,7 @@ static void store_interface_fxns(struct bridge_drv_interface *drv_fxns,
 		STORE_FXN(fxn_msg_registernotify, pfn_msg_register_notify);
 		STORE_FXN(fxn_msg_setqueueid, pfn_msg_set_queue_id);
 	}
-	/* Add code for any additional functions in newer WMD versions here: */
+	/* Add code for any additional functions in newerBridge versions here */
 	/* Ensure postcondition: */
 	DBC_ENSURE(intf_fxns->pfn_dev_create != NULL);
 	DBC_ENSURE(intf_fxns->pfn_dev_destroy != NULL);
diff --git a/drivers/dsp/bridge/pmgr/io.c b/drivers/dsp/bridge/pmgr/io.c
index e16d47b..1fdcbdc 100644
--- a/drivers/dsp/bridge/pmgr/io.c
+++ b/drivers/dsp/bridge/pmgr/io.c
@@ -71,7 +71,7 @@ dsp_status io_create(OUT struct io_mgr **phIOMgr, struct dev_object *hdev_obj,
 	if (DSP_SUCCEEDED(status)) {
 		dev_get_intf_fxns(hdev_obj, &intf_fxns);
 
-		/* Let WMD channel module finish the create: */
+		/* Let Bridge channel module finish the create: */
 		status = (*intf_fxns->pfn_io_create) (&hio_mgr, hdev_obj,
 						      pMgrAttrs);
 
@@ -103,7 +103,7 @@ dsp_status io_destroy(struct io_mgr *hio_mgr)
 
 	intf_fxns = pio_mgr->intf_fxns;
 
-	/* Let WMD channel module destroy the io_mgr: */
+	/* Let Bridge channel module destroy the io_mgr: */
 	status = (*intf_fxns->pfn_io_destroy) (hio_mgr);
 
 	return status;
diff --git a/drivers/dsp/bridge/pmgr/ioobj.h b/drivers/dsp/bridge/pmgr/ioobj.h
index 010ddcf..18542d8 100644
--- a/drivers/dsp/bridge/pmgr/ioobj.h
+++ b/drivers/dsp/bridge/pmgr/ioobj.h
@@ -24,14 +24,14 @@
 #include <dspbridge/dspdefs.h>
 
 /*
- *  This struct is the first field in a io_mgr struct, as implemented in
- *  a WMD channel class library.  Other, implementation specific fields
- *  follow this structure in memory.
+ *  This struct is the first field in a io_mgr struct. Other, implementation
+ *  specific fields follow this structure in memory.
  */
 struct io_mgr_ {
 	/* These must be the first fields in a io_mgr struct: */
 	struct bridge_dev_context *hbridge_context;	/* Bridge context. */
-	struct bridge_drv_interface *intf_fxns;	/* Function interface to WMD. */
+	/* Function interface to Bridge driver. */
+	struct bridge_drv_interface *intf_fxns;
 	struct dev_object *hdev_obj;	/* Device this board represents. */
 };
 
diff --git a/drivers/dsp/bridge/pmgr/msg.c b/drivers/dsp/bridge/pmgr/msg.c
index 95848a6..7d605b1 100644
--- a/drivers/dsp/bridge/pmgr/msg.c
+++ b/drivers/dsp/bridge/pmgr/msg.c
@@ -63,7 +63,7 @@ dsp_status msg_create(OUT struct msg_mgr **phMsgMgr,
 
 	dev_get_intf_fxns(hdev_obj, &intf_fxns);
 
-	/* Let WMD message module finish the create: */
+	/* Let Bridge message module finish the create: */
 	status =
 	    (*intf_fxns->pfn_msg_create) (&hmsg_mgr, hdev_obj, msgCallback);
 
@@ -96,7 +96,7 @@ void msg_delete(struct msg_mgr *hmsg_mgr)
 	if (msg_mgr_obj) {
 		intf_fxns = msg_mgr_obj->intf_fxns;
 
-		/* Let WMD message module destroy the msg_mgr: */
+		/* Let Bridge message module destroy the msg_mgr: */
 		(*intf_fxns->pfn_msg_delete) (hmsg_mgr);
 	} else {
 		dev_dbg(bridge, "%s: Error hmsg_mgr handle: %p\n",
diff --git a/drivers/dsp/bridge/pmgr/msgobj.h b/drivers/dsp/bridge/pmgr/msgobj.h
index d19e26b..7e215a3 100644
--- a/drivers/dsp/bridge/pmgr/msgobj.h
+++ b/drivers/dsp/bridge/pmgr/msgobj.h
@@ -25,13 +25,14 @@
 #include <dspbridge/msgdefs.h>
 
 /*
- *  This struct is the first field in a msg_mgr struct, as implemented in
- *  a WMD channel class library.  Other, implementation specific fields
- *  follow this structure in memory.
+ *  This struct is the first field in a msg_mgr struct. Other, implementation
+ *  specific fields follow this structure in memory.
  */
 struct msg_mgr_ {
 	/* The first field must match that in _msg_sm.h */
-	struct bridge_drv_interface *intf_fxns;	/* Function interface to WMD. */
+
+	/* Function interface to Bridge driver. */
+	struct bridge_drv_interface *intf_fxns;
 };
 
 #endif /* MSGOBJ_ */
diff --git a/drivers/dsp/bridge/rmgr/disp.c b/drivers/dsp/bridge/rmgr/disp.c
index 2808868..35a4457 100644
--- a/drivers/dsp/bridge/rmgr/disp.c
+++ b/drivers/dsp/bridge/rmgr/disp.c
@@ -62,7 +62,8 @@
  */
 struct disp_object {
 	struct dev_object *hdev_obj;	/* Device for this processor */
-	struct bridge_drv_interface *intf_fxns;	/* Function interface to WMD */
+	/* Function interface to Bridge driver */
+	struct bridge_drv_interface *intf_fxns;
 	struct chnl_mgr *hchnl_mgr;	/* Channel manager */
 	struct chnl_object *chnl_to_dsp;	/* Chnl for commands to RMS */
 	struct chnl_object *chnl_from_dsp;	/* Chnl for replies from RMS */
@@ -112,7 +113,7 @@ dsp_status disp_create(OUT struct disp_object **phDispObject,
 	else
 		disp_obj->hdev_obj = hdev_obj;
 
-	/* Get Channel manager and WMD function interface */
+	/* Get Channel manager and Bridge function interface */
 	if (DSP_SUCCEEDED(status)) {
 		status = dev_get_chnl_mgr(hdev_obj, &(disp_obj->hchnl_mgr));
 		if (DSP_SUCCEEDED(status)) {
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index cdd60e6..dda006e 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -125,7 +125,8 @@
  */
 struct node_mgr {
 	struct dev_object *hdev_obj;	/* Device object */
-	struct bridge_drv_interface *intf_fxns;	/* Function interface to WMD */
+	/* Function interface to Bridge driver */
+	struct bridge_drv_interface *intf_fxns;
 	struct dcd_manager *hdcd_mgr;	/* Proc/Node data manager */
 	struct disp_object *disp_obj;	/* Node dispatcher */
 	struct lst_list *node_list;	/* List of all allocated nodes */
@@ -3132,7 +3133,8 @@ static u32 ovly(void *priv_ref, u32 ulDspRunAddr, u32 ulDspLoadAddr,
 	u32 ul_timeout;
 	dsp_status status = DSP_SOK;
 	struct bridge_dev_context *hbridge_context;
-	struct bridge_drv_interface *intf_fxns;	/* Function interface to WMD */
+	/* Function interface to Bridge driver*/
+	struct bridge_drv_interface *intf_fxns;
 
 	DBC_REQUIRE(hnode);
 
@@ -3174,7 +3176,8 @@ static u32 mem_write(void *priv_ref, u32 ulDspAddr, void *pbuf,
 	u32 ul_timeout;
 	dsp_status status = DSP_SOK;
 	struct bridge_dev_context *hbridge_context;
-	struct bridge_drv_interface *intf_fxns;	/* Function interface to WMD */
+	/* Function interface to Bridge driver */
+	struct bridge_drv_interface *intf_fxns;
 
 	DBC_REQUIRE(hnode);
 	DBC_REQUIRE(nMemSpace & DBLL_CODE || nMemSpace & DBLL_DATA);
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 7dc9b5c..bdb3c53 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -92,8 +92,10 @@ struct proc_object {
 					 * GPP Client attached
 					 */
 	struct ntfy_object *ntfy_obj;	/* Manages  notifications */
-	struct bridge_dev_context *hbridge_context;	/* WMD Context Handle */
-	struct bridge_drv_interface *intf_fxns;	/* Function interface to WMD */
+	/* Bridge Context Handle */
+	struct bridge_dev_context *hbridge_context;
+	/* Function interface to Bridge driver */
+	struct bridge_drv_interface *intf_fxns;
 	char *psz_last_coff;
 	struct list_head proc_list;
 };
@@ -333,7 +335,7 @@ func_end:
  *
  *      This will be an OEM-only function, and not part of the DSP/BIOS Bridge
  *      application developer's API.
- *      Call the WMD_ICOTL fxn with the Argument This is a Synchronous
+ *      Call the bridge_dev_ctrl fxn with the Argument. This is a Synchronous
  *      Operation. arg can be null.
  */
 dsp_status proc_ctrl(void *hprocessor, u32 dw_cmd, IN struct dsp_cbdata * arg)
@@ -835,7 +837,6 @@ dsp_status proc_load(void *hprocessor, IN CONST s32 argc_index,
 #ifdef OPT_LOAD_TIME_INSTRUMENTATION
 	do_gettimeofday(&tv1);
 #endif
-	/* Call the WMD_BRD_Load fxn */
 	if (!p_proc_object) {
 		status = -EFAULT;
 		goto func_end;
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index b654b0a..b508b48 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -57,7 +57,8 @@
 struct strm_mgr {
 	struct dev_object *dev_obj;	/* Device for this processor */
 	struct chnl_mgr *hchnl_mgr;	/* Channel manager */
-	struct bridge_drv_interface *intf_fxns;	/* Function interface to WMD */
+	/* Function interface to Bridge driver */
+	struct bridge_drv_interface *intf_fxns;
 };
 
 /*
@@ -217,7 +218,7 @@ dsp_status strm_create(OUT struct strm_mgr **phStrmMgr,
 	else
 		strm_mgr_obj->dev_obj = dev_obj;
 
-	/* Get Channel manager and WMD function interface */
+	/* Get Channel manager and Bridge function interface */
 	if (DSP_SUCCEEDED(status)) {
 		status = dev_get_chnl_mgr(dev_obj, &(strm_mgr_obj->hchnl_mgr));
 		if (DSP_SUCCEEDED(status)) {
-- 
1.7.0.3

