From: Ivan Gomez Castellanos <ivan.gomez@ti.com>
Subject: [PATCH 10/11] DSPBRIDGE: Remove OS specific comments
Date: Fri, 30 Apr 2010 19:45:50 -0500
Message-ID: <1272674751-21557-11-git-send-email-ivan.gomez@ti.com>
References: <1272674751-21557-1-git-send-email-ivan.gomez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35607 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758095Ab0EAAwz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Apr 2010 20:52:55 -0400
In-Reply-To: <1272674751-21557-1-git-send-email-ivan.gomez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi.DOYU@nokia.com, ameya.palande@nokia.com, felipe.contreras@nokia.com, Omar Ramirez Luna <omar.ramirez@ti.com>

From: Omar Ramirez Luna <omar.ramirez@ti.com>

As this is generic to Linux, remove obvious references to
this and other OS.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dev.h     |   14 +++++++-------
 arch/arm/plat-omap/include/dspbridge/dspdefs.h |    4 ++--
 arch/arm/plat-omap/include/dspbridge/mgr.h     |    2 +-
 drivers/dsp/bridge/core/chnl_sm.c              |    2 +-
 drivers/dsp/bridge/core/tiomap3430.c           |    6 ++----
 drivers/dsp/bridge/rmgr/drv.c                  |    4 ++--
 6 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dev.h b/arch/arm/plat-omap/include/dspbridge/dev.h
index ac011cd..70eb55d 100644
--- a/arch/arm/plat-omap/include/dspbridge/dev.h
+++ b/arch/arm/plat-omap/include/dspbridge/dev.h
@@ -72,7 +72,7 @@ extern u32 dev_brd_write_fxn(void *pArb,
  *                      to the WMD when bridge_dev_create() is called.
  *      pDspConfig:     DSP resources, to be passed down to the WMD when
  *                      bridge_dev_create() is called.
- *      dev_node_obj:       Platform (Windows) specific device node.
+ *      dev_node_obj:       Platform specific device node.
  *  Returns:
  *      DSP_SOK:            Module is loaded, device object has been created
  *      DSP_EMEMORY:        Insufficient memory to create needed resources.
@@ -117,7 +117,7 @@ extern dsp_status dev_create_device(OUT struct dev_object
  *                      to the WMD when bridge_dev_create() is called.
  *      pDspConfig:     DSP resources, to be passed down to the WMD when
  *                      bridge_dev_create() is called.
- *      dev_node_obj:       Platform (Windows) specific device node.
+ *      dev_node_obj:       Platform specific device node.
  *  Returns:
  *      DSP_SOK:            Module is loaded, device object has been created
  *      DSP_EMEMORY:        Insufficient memory to create needed resources.
@@ -324,7 +324,7 @@ extern dsp_status dev_get_deh_mgr(struct dev_object *hdev_obj,
  *                      dev_create_device().
  *      phDevNode:      Ptr to location to get the device node handle.
  *  Returns:
- *      DSP_SOK:        In Win95, returns a DEVNODE in *dev_node_obj; In NT, ???
+ *      DSP_SOK:        Returns a DEVNODE in *dev_node_obj.
  *      DSP_EHANDLE:    Invalid hdev_obj.
  *  Requires:
  *      phDevNode != NULL.
@@ -700,10 +700,10 @@ extern void dev_set_msg_mgr(struct dev_object *hdev_obj, struct msg_mgr *hmgr);
 /*
  *  ======== dev_start_device ========
  *  Purpose:
- *      Initializes the new device with the WinBRIDGE environment.  This
- *      involves querying CM for allocated resources, querying the registry
- *      for necessary dsp resources (requested in the INF file), and using
- *      this information to create a WinBRIDGE device object.
+ *      Initializes the new device with bridge environment.  This involves
+ *      querying CM for allocated resources, querying the registry for
+ *      necessary dsp resources (requested in the INF file), and using this
+ *      information to create a bridge device object.
  *  Parameters:
  *      dev_node_obj:       Device node as it is know to OS.
  *  Returns:
diff --git a/arch/arm/plat-omap/include/dspbridge/dspdefs.h b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
index 8a1d38c..26a9988 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
@@ -653,7 +653,7 @@ typedef dsp_status(*fxn_chnl_registernotify)
  *  Parameters:
  *      phDevContext:   Ptr to location to store a WMD device context.
  *      hdev_obj:     Handle to a Device Object, created and managed by WCD.
- *      pConfig:        Ptr to configuration parameters provided by the Windows
+ *      pConfig:        Ptr to configuration parameters provided by the
  *                      Configuration Manager during device loading.
  *      pDspConfig:     DSP resources, as specified in the registry key for this
  *                      device.
@@ -1127,7 +1127,7 @@ struct bridge_drv_interface {
  *      ppDrvInterface pointer initialized to WMD's function interface.
  *      No system resources are acquired by this function.
  *  Details:
- *      Win95: Called during the Device_Init phase.
+ *      Called during the Device_Init phase.
  */
 void bridge_drv_entry(OUT struct bridge_drv_interface **ppDrvInterface,
 		   IN CONST char *driver_file_name);
diff --git a/arch/arm/plat-omap/include/dspbridge/mgr.h b/arch/arm/plat-omap/include/dspbridge/mgr.h
index feb1b61..193e5e0 100644
--- a/arch/arm/plat-omap/include/dspbridge/mgr.h
+++ b/arch/arm/plat-omap/include/dspbridge/mgr.h
@@ -50,7 +50,7 @@ dsp_status mgr_wait_for_bridge_events(struct dsp_notification
  *      There is only one Manager Object in the DSP/BIOS Bridge.
  *  Parameters:
  *      phMgrObject:    Location to store created MGR Object handle.
- *      dev_node_obj:       Device object as known to Windows system.
+ *      dev_node_obj:       Device object as known to the system.
  *  Returns:
  *      DSP_SOK:        Success
  *      DSP_EMEMORY:    Failed to Create the Object
diff --git a/drivers/dsp/bridge/core/chnl_sm.c b/drivers/dsp/bridge/core/chnl_sm.c
index 9befa77..8b7e0a8 100644
--- a/drivers/dsp/bridge/core/chnl_sm.c
+++ b/drivers/dsp/bridge/core/chnl_sm.c
@@ -853,7 +853,7 @@ dsp_status bridge_chnl_open(OUT struct chnl_object **phChnl,
 			pchnl->chnl_mgr_obj = chnl_mgr_obj;
 			pchnl->chnl_id = uChnlId;
 			pchnl->chnl_mode = chnl_mode;
-			pchnl->user_event = sync_event;	/* for Linux */
+			pchnl->user_event = sync_event;
 			pchnl->sync_event = sync_event;
 			/* Get the process handle */
 			pchnl->process = current->tgid;
diff --git a/drivers/dsp/bridge/core/tiomap3430.c b/drivers/dsp/bridge/core/tiomap3430.c
index 1ccec2d..3555de2 100644
--- a/drivers/dsp/bridge/core/tiomap3430.c
+++ b/drivers/dsp/bridge/core/tiomap3430.c
@@ -1019,7 +1019,7 @@ static dsp_status bridge_dev_create(OUT struct bridge_dev_context
 		dev_context->tc_word_swap_on = tc_word_swap;
 	}
 	if (DSP_SUCCEEDED(status)) {
-		/* 24xx-Linux MMU address is obtained from the host
+		/* MMU address is obtained from the host
 		 * resources struct */
 		dev_context->dw_dsp_mmu_base = resources.dw_dmmu_base;
 	}
@@ -1413,7 +1413,6 @@ static dsp_status bridge_brd_mem_map(struct bridge_dev_context *hDevContext,
 	}
 	up_read(&mm->mmap_sem);
 func_cont:
-	/* Don't propogate Linux or HW status to upper layers */
 	if (DSP_SUCCEEDED(status)) {
 		status = DSP_SOK;
 	} else {
@@ -1641,7 +1640,7 @@ EXIT_LOOP:
 /*
  *  ======== user_va2_pa ========
  *  Purpose:
- *      This function walks through the Linux page tables to convert a userland
+ *      This function walks through the page tables to convert a userland
  *      virtual address to physical address
  */
 static u32 user_va2_pa(struct mm_struct *mm, u32 address)
@@ -1874,7 +1873,6 @@ static dsp_status mem_map_vmalloc(struct bridge_dev_context *dev_context,
 				    hw_attrs);
 		va_curr += size_curr;
 	}
-	/* Don't propogate Linux or HW status to upper layers */
 	if (DSP_SUCCEEDED(status))
 		status = DSP_SOK;
 	else
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index c3df5f5..9d3d0c1 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -947,7 +947,7 @@ static dsp_status request_bridge_resources(u32 dw_context, s32 bRequest)
 		 * internal memory TODO Do a ioremap here */
 		/* Second window is for DSP external memory shared with MPU */
 
-		/* For Linux, these are hard-coded values */
+		/* These are hard-coded values */
 		host_res->birq_registers = 0;
 		host_res->birq_attrib = 0;
 		host_res->dw_offset_for_monitor = 0;
@@ -1050,7 +1050,7 @@ static dsp_status request_bridge_resources_dsp(u32 dw_context, s32 bRequest)
 			}
 		}
 		if (DSP_SUCCEEDED(status)) {
-			/* for Linux, these are hard-coded values */
+			/* These are hard-coded values */
 			host_res->birq_registers = 0;
 			host_res->birq_attrib = 0;
 			host_res->dw_offset_for_monitor = 0;
-- 
1.7.0.3

