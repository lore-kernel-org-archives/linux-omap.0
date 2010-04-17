From: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Subject: [PATCH 2/5] DSPBRIDGE: Remove host resources from registry
Date: Fri, 16 Apr 2010 22:32:16 -0500
Message-ID: <B852767254C5C94EBB1040EE0EFA060092D76407@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47592 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758713Ab0DQDcW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 23:32:22 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>

>From 805fb981c83356788e0a3eaefb35d9eb74ced10c Mon Sep 17 00:00:00 2001
From: Ernesto Ramos <ernesto@ti.com>
Date: Fri, 16 Apr 2010 20:47:06 -0500
Subject: [PATCH 2/5] DSPBRIDGE: Remove host resources from registry

Remove host resources from registry.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/cfg.h |   22 ---
 arch/arm/plat-omap/include/dspbridge/dev.h |    2 -
 arch/arm/plat-omap/include/dspbridge/drv.h |    6 +
 arch/arm/plat-omap/include/dspbridge/wmd.h |    2 +-
 drivers/dsp/bridge/pmgr/dev.c              |   51 ++++----
 drivers/dsp/bridge/rmgr/drv.c              |  216 ++++++----------------------
 drivers/dsp/bridge/rmgr/node.c             |   37 +++--
 drivers/dsp/bridge/services/cfg.c          |   30 ----
 drivers/dsp/bridge/wmd/_tiomap.h           |    1 +
 drivers/dsp/bridge/wmd/io_sm.c             |   35 +++--
 drivers/dsp/bridge/wmd/mmu_fault.c         |   33 ++---
 drivers/dsp/bridge/wmd/tiomap3430.c        |  217 ++++++++++++++++++----------
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c    |  177 ++++++++++++-----------
 drivers/dsp/bridge/wmd/tiomap_io.c         |   46 +++----
 drivers/dsp/bridge/wmd/ue_deh.c            |   21 +--
 15 files changed, 386 insertions(+), 510 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/cfg.h b/arch/arm/plat-omap/include/dspbridge/cfg.h
index 30e75c1..db46ea7 100644
--- a/arch/arm/plat-omap/include/dspbridge/cfg.h
+++ b/arch/arm/plat-omap/include/dspbridge/cfg.h
@@ -118,28 +118,6 @@ extern dsp_status cfg_get_exec_file(IN struct cfg_devnode *dev_node_obj,
                                    IN u32 buf_size, OUT char *pstrExecFile);

 /*
- *  ======== cfg_get_host_resources ========
- *  Purpose:
- *      Get the Host PC allocated resources assigned to a given device.
- *  Parameters:
- *      dev_node_obj:  Handle to the DEVNODE who's resources we are querying.
- *      pHostResTable:  Ptr to a location to store the host resource table.
- *  Returns:
- *      DSP_SOK:                On success.
- *      CFG_E_INVALIDPOINTER:   pHostResTable is invalid.
- *      CFG_E_INVALIDHDEVNODE:  dev_node_obj is invalid.
- *      CFG_E_RESOURCENOTAVAIL: The resource is not available.
- *  Requires:
- *      CFG initialized.
- *  Ensures:
- *      DSP_SOK:    pHostResTable points to a filled table of resources
- *                  allocated for the specified WMD.
- *
- */
-extern dsp_status cfg_get_host_resources(IN struct cfg_devnode *dev_node_obj,
-                                        OUT struct cfg_hostres *pHostResTable);
-
-/*
  *  ======== cfg_get_object ========
  *  Purpose:
  *      Retrieve the Driver Object handle From the Registry
diff --git a/arch/arm/plat-omap/include/dspbridge/dev.h b/arch/arm/plat-omap/include/dspbridge/dev.h
index 7771ad1..40567b8 100644
--- a/arch/arm/plat-omap/include/dspbridge/dev.h
+++ b/arch/arm/plat-omap/include/dspbridge/dev.h
@@ -99,8 +99,6 @@ extern u32 dev_brd_write_fxn(void *pArb,
 extern dsp_status dev_create_device(OUT struct dev_object
                                    **phDevObject,
                                    IN CONST char *pstrWMDFileName,
-                                   IN CONST struct cfg_hostres
-                                   *pHostConfig,
                                    struct cfg_devnode *dev_node_obj);

 /*
diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-omap/include/dspbridge/drv.h
index 9307001..588aa8e 100644
--- a/arch/arm/plat-omap/include/dspbridge/drv.h
+++ b/arch/arm/plat-omap/include/dspbridge/drv.h
@@ -385,6 +385,12 @@ extern dsp_status drv_request_resources(IN u32 dw_context,
 extern dsp_status drv_release_resources(IN u32 dw_context,
                                        struct drv_object *hdrv_obj);

+/**
+ * drv_request_bridge_res_dsp() - Reserves shared memory for bridge.
+ *  @phost_resources:  pointer to host resources.
+ */
+extern dsp_status drv_request_bridge_res_dsp(void **phost_resources);
+
 #ifdef CONFIG_BRIDGE_RECOVERY
 void bridge_recover_schedule(void);
 #endif
diff --git a/arch/arm/plat-omap/include/dspbridge/wmd.h b/arch/arm/plat-omap/include/dspbridge/wmd.h
index 9294a96..f4f9c8e 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmd.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmd.h
@@ -689,7 +689,7 @@ typedef dsp_status(*fxn_dev_create) (OUT struct wmd_dev_context
                                     **phDevContext,
                                     struct dev_object
                                     * hdev_obj,
-                                    IN CONST struct cfg_hostres
+                                    IN struct cfg_hostres
                                     * pConfig);

 /*
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index f3ca4c7..cf10fdf 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -135,9 +135,9 @@ u32 dev_brd_write_fxn(void *pArb, u32 ulDspAddr, void *pHostBuf,
  */
 dsp_status dev_create_device(OUT struct dev_object **phDevObject,
                             IN CONST char *pstrWMDFileName,
-                            IN CONST struct cfg_hostres *pHostConfig,
                             struct cfg_devnode *dev_node_obj)
 {
+       struct cfg_hostres *host_res;
        struct ldr_module *module_obj = NULL;
        struct bridge_drv_interface *drv_fxns = NULL;
        struct dev_object *dev_obj = NULL;
@@ -149,7 +149,12 @@ dsp_status dev_create_device(OUT struct dev_object **phDevObject,
        DBC_REQUIRE(refs > 0);
        DBC_REQUIRE(phDevObject != NULL);
        DBC_REQUIRE(pstrWMDFileName != NULL);
-       DBC_REQUIRE(pHostConfig != NULL);
+
+       status = drv_request_bridge_res_dsp((void *)&host_res);
+
+       if (DSP_FAILED(status))
+               dev_dbg(bridge, "%s: Failed to reserve bridge resources\n",
+                       __func__);

        /*  Get the WMD interface functions */
        bridge_drv_entry(&drv_fxns, pstrWMDFileName);
@@ -176,11 +181,12 @@ dsp_status dev_create_device(OUT struct dev_object **phDevObject,
                        /* Store this WMD's interface functions, based on its
                         * version. */
                        store_interface_fxns(drv_fxns, &dev_obj->wmd_interface);
+
                        /* Call fxn_dev_create() to get the WMD's device
                         * context handle. */
                        status = (dev_obj->wmd_interface.pfn_dev_create)
                            (&dev_obj->hwmd_context, dev_obj,
-                            pHostConfig);
+                            host_res);
                        /* Assert bridge_dev_create()'s ensure clause: */
                        DBC_ASSERT(DSP_FAILED(status)
                                   || (dev_obj->hwmd_context != NULL));
@@ -195,19 +201,19 @@ dsp_status dev_create_device(OUT struct dev_object **phDevObject,
        /* Attempt to create the channel manager for this device: */
        if (DSP_SUCCEEDED(status)) {
                mgr_attrs.max_channels = CHNL_MAXCHANNELS;
-               io_mgr_attrs.birq = pHostConfig->birq_registers;
+               io_mgr_attrs.birq = host_res->birq_registers;
                io_mgr_attrs.irq_shared =
-                   (pHostConfig->birq_attrib & CFG_IRQSHARED);
+                   (host_res->birq_attrib & CFG_IRQSHARED);
                io_mgr_attrs.word_size = DSPWORDSIZE;
                mgr_attrs.word_size = DSPWORDSIZE;
-               num_windows = pHostConfig->num_mem_windows;
+               num_windows = host_res->num_mem_windows;
                if (num_windows) {
                        /* Assume last memory window is for CHNL */
-                       io_mgr_attrs.shm_base = pHostConfig->dw_mem_base[1] +
-                           pHostConfig->dw_offset_for_monitor;
+                       io_mgr_attrs.shm_base = host_res->dw_mem_base[1] +
+                           host_res->dw_offset_for_monitor;
                        io_mgr_attrs.usm_length =
-                           pHostConfig->dw_mem_length[1] -
-                           pHostConfig->dw_offset_for_monitor;
+                           host_res->dw_mem_length[1] -
+                           host_res->dw_offset_for_monitor;
                } else {
                        io_mgr_attrs.shm_base = 0;
                        io_mgr_attrs.usm_length = 0;
@@ -879,7 +885,6 @@ void dev_set_msg_mgr(struct dev_object *hdev_obj, struct msg_mgr *hmgr)
 dsp_status dev_start_device(struct cfg_devnode *dev_node_obj)
 {
        struct dev_object *hdev_obj = NULL;     /* handle to 'Bridge Device */
-       struct cfg_hostres host_res;    /* resources struct. */
        /* wmd filename */
        char sz_wmd_file_name[CFG_MAXSEARCHPATHLEN] = "UMA";
        dsp_status status;
@@ -887,22 +892,18 @@ dsp_status dev_start_device(struct cfg_devnode *dev_node_obj)

        DBC_REQUIRE(refs > 0);

-       status = cfg_get_host_resources(dev_node_obj, &host_res);
-
+       /* Given all resources, create a device object. */
+       status =
+           dev_create_device(&hdev_obj, sz_wmd_file_name,
+                            dev_node_obj);
        if (DSP_SUCCEEDED(status)) {
-               /* Given all resources, create a device object. */
+               /* Store away the hdev_obj with the DEVNODE */
                status =
-                   dev_create_device(&hdev_obj, sz_wmd_file_name, &host_res,
-                                     dev_node_obj);
-               if (DSP_SUCCEEDED(status)) {
-                       /* Store away the hdev_obj with the DEVNODE */
-                       status =
-                           cfg_set_dev_object(dev_node_obj, (u32) hdev_obj);
-                       if (DSP_FAILED(status)) {
-                               /* Clean up */
-                               dev_destroy_device(hdev_obj);
-                               hdev_obj = NULL;
-                       }
+                   cfg_set_dev_object(dev_node_obj, (u32) hdev_obj);
+               if (DSP_FAILED(status)) {
+                       /* Clean up */
+                       dev_destroy_device(hdev_obj);
+                       hdev_obj = NULL;
                }
        }
        if (DSP_SUCCEEDED(status)) {
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 2d04a14..e9bb9a8 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -66,8 +66,8 @@ struct drv_ext {
 static s32 refs;

 /*  ----------------------------------- Function Prototypes */
-static dsp_status request_bridge_resources(u32 dw_context, s32 fRequest);
-static dsp_status request_bridge_resources_dsp(u32 dw_context, s32 fRequest);
+static dsp_status request_bridge_resources(struct cfg_hostres *res);
+

 /* GPP PROCESS CLEANUP CODE */

@@ -660,18 +660,6 @@ dsp_status drv_request_resources(u32 dw_context, u32 *pDevNodeString)
                *pDevNodeString = 0;
        }

-       if (!(strcmp((char *)dw_context, "TIOMAP1510"))) {
-               dev_dbg(bridge, "%s: Allocating resources for UMA\n", __func__);
-               status = request_bridge_resources_dsp(dw_context, DRV_ASSIGN);
-       } else {
-               status = DSP_EFAIL;
-               dev_dbg(bridge, "%s: Unknown Device\n", __func__);
-       }
-
-       if (DSP_FAILED(status))
-               dev_dbg(bridge, "%s: Failed to reserve bridge resources\n",
-                       __func__);
-
        DBC_ENSURE((DSP_SUCCEEDED(status) && pDevNodeString != NULL &&
                    !LST_IS_EMPTY(pdrv_object->dev_node_string)) ||
                   (DSP_FAILED(status) && *pDevNodeString == 0));
@@ -690,16 +678,6 @@ dsp_status drv_release_resources(u32 dw_context, struct drv_object *hdrv_obj)
        struct drv_object *pdrv_object = (struct drv_object *)hdrv_obj;
        struct drv_ext *pszdev_node;

-       if (!(strcmp((char *)((struct drv_ext *)dw_context)->sz_string,
-                    "TIOMAP1510")))
-               status = request_bridge_resources(dw_context, DRV_RELEASE);
-       else
-               dev_dbg(bridge, "%s: Unknown device\n", __func__);
-
-       if (DSP_FAILED(status))
-               dev_dbg(bridge, "%s: Failed to relese bridge resources\n",
-                       __func__);
-
        /*
         *  Irrespective of the status go ahead and clean it
         *  The following will over write the status.
@@ -733,149 +711,53 @@ dsp_status drv_release_resources(u32 dw_context, struct drv_object *hdrv_obj)
  *  Purpose:
  *      Reserves shared memory for bridge.
  */
-static dsp_status request_bridge_resources(u32 dw_context, s32 bRequest)
+static dsp_status request_bridge_resources(struct cfg_hostres *res)
 {
        dsp_status status = DSP_SOK;
-       struct cfg_hostres *host_res;
-       u32 dw_buff_size;
-
-       struct drv_ext *driver_ext;
-       u32 shm_size;
-
-       DBC_REQUIRE(dw_context != 0);
-
-       if (!bRequest) {
-               driver_ext = (struct drv_ext *)dw_context;
-               /* Releasing resources by deleting the registry key */
-               dw_buff_size = sizeof(struct cfg_hostres);
-               host_res = mem_calloc(dw_buff_size, MEM_NONPAGED);
-               if (host_res != NULL) {
-                       if (DSP_FAILED(reg_get_value(CURRENTCONFIG,
-                                                    (u8 *) host_res,
-                                                    &dw_buff_size))) {
-                               status = CFG_E_RESOURCENOTAVAIL;
-                       }
-
-                       dw_buff_size = sizeof(shm_size);
-                       status = reg_get_value(SHMSIZE, (u8 *) &shm_size,
-                                              &dw_buff_size);
-                       if (DSP_SUCCEEDED(status)) {
-                               if ((host_res->dw_mem_base[1]) &&
-                                   (host_res->dw_mem_phys[1])) {
-                                       mem_free_phys_mem((void *)
-                                                         host_res->dw_mem_base
-                                                         [1],
-                                                         host_res->dw_mem_phys
-                                                         [1], shm_size);
-                               }
-                       } else {
-                               dev_dbg(bridge, "%s: Error getting shm size "
-                                       "from registry: %x. Not calling "
-                                       "mem_free_phys_mem\n", __func__,
-                                       status);
-                       }
-                       host_res->dw_mem_base[1] = 0;
-                       host_res->dw_mem_phys[1] = 0;
-
-                       if (host_res->dw_prm_base)
-                               iounmap(host_res->dw_prm_base);
-                       if (host_res->dw_cm_base)
-                               iounmap(host_res->dw_cm_base);
-                       if (host_res->dw_mem_base[0])
-                               iounmap((void *)host_res->dw_mem_base[0]);
-                       if (host_res->dw_mem_base[2])
-                               iounmap((void *)host_res->dw_mem_base[2]);
-                       if (host_res->dw_mem_base[3])
-                               iounmap((void *)host_res->dw_mem_base[3]);
-                       if (host_res->dw_mem_base[4])
-                               iounmap((void *)host_res->dw_mem_base[4]);
-                       if (host_res->dw_wd_timer_dsp_base)
-                               iounmap(host_res->dw_wd_timer_dsp_base);
-                       if (host_res->dw_dmmu_base)
-                               iounmap(host_res->dw_dmmu_base);
-                       if (host_res->dw_per_base)
-                               iounmap(host_res->dw_per_base);
-                       if (host_res->dw_per_pm_base)
-                               iounmap((void *)host_res->dw_per_pm_base);
-                       if (host_res->dw_core_pm_base)
-                               iounmap((void *)host_res->dw_core_pm_base);
-                       if (host_res->dw_sys_ctrl_base)
-                               iounmap(host_res->dw_sys_ctrl_base);
-
-                       host_res->dw_prm_base = NULL;
-                       host_res->dw_cm_base = NULL;
-                       host_res->dw_mem_base[0] = (u32) NULL;
-                       host_res->dw_mem_base[2] = (u32) NULL;
-                       host_res->dw_mem_base[3] = (u32) NULL;
-                       host_res->dw_mem_base[4] = (u32) NULL;
-                       host_res->dw_wd_timer_dsp_base = NULL;
-                       host_res->dw_dmmu_base = NULL;
-                       host_res->dw_sys_ctrl_base = NULL;
-
-                       dw_buff_size = sizeof(struct cfg_hostres);
-                       status = reg_set_value(CURRENTCONFIG, (u8 *) host_res,
-                                              (u32) dw_buff_size);
-                       /*  Set all the other entries to NULL */
-                       kfree(host_res);
-               } else {
-                       status = DSP_EMEMORY;
-               }
-               return status;
-       }
-       dw_buff_size = sizeof(struct cfg_hostres);
-       host_res = mem_calloc(dw_buff_size, MEM_NONPAGED);
-       if (host_res != NULL) {
-               /* num_mem_windows must not be more than CFG_MAXMEMREGISTERS */
-               host_res->num_mem_windows = 2;
-               /* First window is for DSP internal memory */
-
-               host_res->dw_prm_base = ioremap(OMAP_IVA2_PRM_BASE,
-                                               OMAP_IVA2_PRM_SIZE);
-               host_res->dw_cm_base = ioremap(OMAP_IVA2_CM_BASE,
-                                              OMAP_IVA2_CM_SIZE);
-               host_res->dw_sys_ctrl_base = ioremap(OMAP_SYSC_BASE,
-                                                    OMAP_SYSC_SIZE);
-               dev_dbg(bridge, "dw_mem_base[0] 0x%x\n",
-                       host_res->dw_mem_base[0]);
-               dev_dbg(bridge, "dw_mem_base[3] 0x%x\n",
-                       host_res->dw_mem_base[3]);
-               dev_dbg(bridge, "dw_prm_base %p\n", host_res->dw_prm_base);
-               dev_dbg(bridge, "dw_cm_base %p\n", host_res->dw_cm_base);
-               dev_dbg(bridge, "dw_wd_timer_dsp_base %p\n",
-                       host_res->dw_wd_timer_dsp_base);
-               dev_dbg(bridge, "dw_dmmu_base %p\n", host_res->dw_dmmu_base);
+       struct cfg_hostres *host_res = res;
+
+       /* num_mem_windows must not be more than CFG_MAXMEMREGISTERS */
+       host_res->num_mem_windows = 2;
+       /* First window is for DSP internal memory */
+
+       host_res->dw_prm_base = ioremap(OMAP_IVA2_PRM_BASE,
+                                       OMAP_IVA2_PRM_SIZE);
+       host_res->dw_cm_base = ioremap(OMAP_IVA2_CM_BASE,
+                                      OMAP_IVA2_CM_SIZE);
+       host_res->dw_sys_ctrl_base = ioremap(OMAP_SYSC_BASE,
+                                            OMAP_SYSC_SIZE);
+       dev_dbg(bridge, "dw_mem_base[0] 0x%x\n",
+               host_res->dw_mem_base[0]);
+       dev_dbg(bridge, "dw_mem_base[3] 0x%x\n",
+               host_res->dw_mem_base[3]);
+       dev_dbg(bridge, "dw_prm_base %p\n", host_res->dw_prm_base);
+       dev_dbg(bridge, "dw_cm_base %p\n", host_res->dw_cm_base);
+       dev_dbg(bridge, "dw_wd_timer_dsp_base %p\n",
+               host_res->dw_wd_timer_dsp_base);
+       dev_dbg(bridge, "dw_dmmu_base %p\n", host_res->dw_dmmu_base);
+
+       /* for 24xx base port is not mapping the mamory for DSP
+        * internal memory TODO Do a ioremap here */
+       /* Second window is for DSP external memory shared with MPU */
+
+       /* For Linux, these are hard-coded values */
+       host_res->birq_registers = 0;
+       host_res->birq_attrib = 0;
+       host_res->dw_offset_for_monitor = 0;
+       host_res->dw_chnl_offset = 0;
+       /* CHNL_MAXCHANNELS */
+       host_res->dw_num_chnls = CHNL_MAXCHANNELS;
+       host_res->dw_chnl_buf_size = 0x400;

-               /* for 24xx base port is not mapping the mamory for DSP
-                * internal memory TODO Do a ioremap here */
-               /* Second window is for DSP external memory shared with MPU */
-
-               /* For Linux, these are hard-coded values */
-               host_res->birq_registers = 0;
-               host_res->birq_attrib = 0;
-               host_res->dw_offset_for_monitor = 0;
-               host_res->dw_chnl_offset = 0;
-               /* CHNL_MAXCHANNELS */
-               host_res->dw_num_chnls = CHNL_MAXCHANNELS;
-               host_res->dw_chnl_buf_size = 0x400;
-               dw_buff_size = sizeof(struct cfg_hostres);
-               status = reg_set_value(CURRENTCONFIG, (u8 *) host_res,
-                                      sizeof(struct cfg_hostres));
-               if (DSP_FAILED(status)) {
-                       dev_dbg(bridge, "%s: Failed to set the registry value "
-                               "for CURRENTCONFIG\n", __func__);
-               }
-               kfree(host_res);
-       }
-       /* End Mem alloc */
        return status;
 }

 /*
- *  ======== request_bridge_resources_dsp ========
+ *  ======== drv_request_bridge_res_dsp ========
  *  Purpose:
  *      Reserves shared memory for bridge.
  */
-static dsp_status request_bridge_resources_dsp(u32 dw_context, s32 bRequest)
+dsp_status drv_request_bridge_res_dsp(void **phost_resources)
 {
        dsp_status status = DSP_SOK;
        struct cfg_hostres *host_res;
@@ -883,22 +765,12 @@ static dsp_status request_bridge_resources_dsp(u32 dw_context, s32 bRequest)
        u32 dma_addr;
        u32 shm_size;

-       DBC_REQUIRE(dw_context != 0);
-
        dw_buff_size = sizeof(struct cfg_hostres);

        host_res = mem_calloc(dw_buff_size, MEM_NONPAGED);

        if (host_res != NULL) {
-               if (DSP_FAILED(cfg_get_host_resources((struct cfg_devnode *)
-                                                     dw_context, host_res))) {
-                       status = request_bridge_resources(dw_context, bRequest);
-                       if (DSP_SUCCEEDED(status)) {
-                               status = cfg_get_host_resources
-                                   ((struct cfg_devnode *)dw_context,
-                                    host_res);
-                       }
-               }
+               request_bridge_resources(host_res);
                /* num_mem_windows must not be more than CFG_MAXMEMREGISTERS */
                host_res->num_mem_windows = 4;

@@ -966,14 +838,8 @@ static dsp_status request_bridge_resources_dsp(u32 dw_context, s32 bRequest)
                        host_res->dw_num_chnls = CHNL_MAXCHANNELS;
                        host_res->dw_chnl_buf_size = 0x400;
                        dw_buff_size = sizeof(struct cfg_hostres);
-                       status = reg_set_value(CURRENTCONFIG, (u8 *) host_res,
-                                              sizeof(struct cfg_hostres));
-                       if (DSP_FAILED(status)) {
-                               dev_dbg(bridge, "%s: Failed to set the registry"
-                                       " value for CURRENTCONFIG\n", __func__);
-                       }
                }
-               kfree(host_res);
+               *phost_resources = host_res;
        }
        /* End Mem alloc */
        return status;
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index ad57cbe..8ec0df9 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -66,6 +66,7 @@
 #include <dspbridge/drv.h>
 #include <dspbridge/drvdefs.h>
 #include <dspbridge/resourcecleanup.h>
+#include <_tiomap.h>

 #define NODE_SIGNATURE      0x45444f4e /* "EDON" */
 #define NODEMGR_SIGNATURE   0x52474d4e /* "RGMN" */
@@ -318,7 +319,8 @@ dsp_status node_allocate(struct proc_object *hprocessor,
        u32 off_set = 0;
        u32 ul_stack_seg_addr, ul_stack_seg_val;
        u32 ul_gpp_mem_base;
-       struct cfg_hostres host_res;
+       struct cfg_hostres *host_res;
+       struct wmd_dev_context *pwmd_context;
        u32 mapped_addr = 0;
        u32 map_attrs = 0x0;
        struct dsp_processorstate proc_state;
@@ -352,6 +354,12 @@ dsp_status node_allocate(struct proc_object *hprocessor,
        if (DSP_FAILED(status))
                goto func_end;

+       status = dev_get_wmd_context(hdev_obj, &pwmd_context);
+       if (!pwmd_context) {
+               status = DSP_EHANDLE;
+               goto func_end;
+       }
+
        status = proc_get_state(hprocessor, &proc_state,
                                sizeof(struct dsp_processorstate));
        if (DSP_FAILED(status))
@@ -608,9 +616,9 @@ func_cont:
                                pr_err("%s: Failed to get addr for L1DSRAM_HEAP"
                                       " status = 0x%x\n", __func__, status);

-                       status = cfg_get_host_resources((struct cfg_devnode *)
-                                               drv_get_first_dev_extension(),
-                                               &host_res);
+                       host_res = pwmd_context->resources;
+                       if (!host_res)
+                               status = DSP_EFAIL;

                        if (DSP_FAILED(status)) {
                                pr_err("%s: Failed to get host resource, status"
@@ -618,7 +626,7 @@ func_cont:
                                goto func_end;
                        }

-                       ul_gpp_mem_base = (u32) host_res.dw_mem_base[1];
+                       ul_gpp_mem_base = (u32) host_res->dw_mem_base[1];
                        off_set = pul_value - dynext_base;
                        ul_stack_seg_addr = ul_gpp_mem_base + off_set;
                        ul_stack_seg_val = (u32) *((reg_uword32 *)
@@ -2987,18 +2995,21 @@ static dsp_status get_node_props(struct dcd_manager *hdcd_mgr,
 static dsp_status get_proc_props(struct node_mgr *hnode_mgr,
                                 struct dev_object *hdev_obj)
 {
-       struct cfg_devnode *dev_node_obj;
-       struct cfg_hostres host_res;
+       struct cfg_hostres *host_res;
+       struct wmd_dev_context *pwmd_context;
        dsp_status status = DSP_SOK;

-       status = dev_get_dev_node(hdev_obj, &dev_node_obj);
-       if (DSP_SUCCEEDED(status))
-               status = cfg_get_host_resources(dev_node_obj, &host_res);
+       status = dev_get_wmd_context(hdev_obj, &pwmd_context);
+       if (!pwmd_context)
+               status = DSP_EHANDLE;

        if (DSP_SUCCEEDED(status)) {
-               hnode_mgr->ul_chnl_offset = host_res.dw_chnl_offset;
-               hnode_mgr->ul_chnl_buf_size = host_res.dw_chnl_buf_size;
-               hnode_mgr->ul_num_chnls = host_res.dw_num_chnls;
+               host_res = pwmd_context->resources;
+               if (!host_res)
+                       return DSP_EFAIL;
+               hnode_mgr->ul_chnl_offset = host_res->dw_chnl_offset;
+               hnode_mgr->ul_chnl_buf_size = host_res->dw_chnl_buf_size;
+               hnode_mgr->ul_num_chnls = host_res->dw_num_chnls;

                /*
                 *  PROC will add an API to get dsp_processorinfo.
diff --git a/drivers/dsp/bridge/services/cfg.c b/drivers/dsp/bridge/services/cfg.c
index 629cab1..f0d0dba 100644
--- a/drivers/dsp/bridge/services/cfg.c
+++ b/drivers/dsp/bridge/services/cfg.c
@@ -142,36 +142,6 @@ dsp_status cfg_get_exec_file(struct cfg_devnode *dev_node_obj, u32 ul_buf_size,
 }

 /*
- *  ======== cfg_get_host_resources ========
- *  Purpose:
- *      Get the Host allocated resources assigned to a given device.
- */
-dsp_status cfg_get_host_resources(struct cfg_devnode *dev_node_obj,
-                                 OUT struct cfg_hostres *pHostResTable)
-{
-       dsp_status status = DSP_SOK;
-       u32 dw_buf_size;
-
-       if (!dev_node_obj)
-               status = CFG_E_INVALIDHDEVNODE;
-
-       if (!pHostResTable)
-               status = CFG_E_INVALIDPOINTER;
-
-       if (DSP_SUCCEEDED(status)) {
-               dw_buf_size = sizeof(struct cfg_hostres);
-               if (DSP_FAILED
-                   (reg_get_value
-                    (CURRENTCONFIG, (u8 *) pHostResTable, &dw_buf_size))) {
-                       status = CFG_E_RESOURCENOTAVAIL;
-               }
-       }
-       if (DSP_FAILED(status))
-               dev_dbg(bridge, "%s Failed, status 0x%x\n", __func__, status);
-       return status;
-}
-
-/*
  *  ======== cfg_get_object ========
  *  Purpose:
  *      Retrieve the Object handle from the Registry
diff --git a/drivers/dsp/bridge/wmd/_tiomap.h b/drivers/dsp/bridge/wmd/_tiomap.h
index 71ef731..40a9162 100644
--- a/drivers/dsp/bridge/wmd/_tiomap.h
+++ b/drivers/dsp/bridge/wmd/_tiomap.h
@@ -328,6 +328,7 @@ struct wmd_dev_context {

        struct omap_mbox *mbox;         /* Mail box handle */

+       struct cfg_hostres *resources;  /* Host Resources */
        /*
         * Processor specific info is set when prog loaded and read from DCD.
         * [See WMD_BRD_Ctrl()]  PROC info contains DSP-MMU TLB entries.
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 72f3bd6..b320bb0 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -181,7 +181,6 @@ dsp_status bridge_io_create(OUT struct io_mgr **phIOMgr,
        struct io_mgr *pio_mgr = NULL;
        struct shm *shared_mem = NULL;
        struct wmd_dev_context *hwmd_context = NULL;
-       struct cfg_hostres host_res;
        struct cfg_devnode *dev_node_obj;
        struct chnl_mgr *hchnl_mgr;
        u32 dev_type;
@@ -243,11 +242,7 @@ dsp_status bridge_io_create(OUT struct io_mgr **phIOMgr,
                if (DSP_SUCCEEDED(status))
                        status = dev_get_dev_node(hdev_obj, &dev_node_obj);
        }
-       if (DSP_SUCCEEDED(status)) {
-               status = cfg_get_host_resources((struct cfg_devnode *)
-                                               drv_get_first_dev_extension(),
-                                               &host_res);
-       }
+
        if (DSP_SUCCEEDED(status)) {
                pio_mgr->hwmd_context = hwmd_context;
                pio_mgr->shared_irq = pMgrAttrs->irq_shared;
@@ -276,9 +271,7 @@ func_end:
 dsp_status bridge_io_destroy(struct io_mgr *hio_mgr)
 {
        dsp_status status = DSP_SOK;
-       struct wmd_dev_context *hwmd_context;
        if (MEM_IS_VALID_HANDLE(hio_mgr, IO_MGRSIGNATURE)) {
-               status = dev_get_wmd_context(hio_mgr->hdev_obj, &hwmd_context);

                /* Free IO DPC object */
                tasklet_kill(&hio_mgr->dpc_tasklet);
@@ -327,7 +320,8 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
        s32 ndx = 0;
        /* DSP MMU setup table */
        struct wmdioctl_extproc ae_proc[WMDIOCTL_NUMOFMMUTLB];
-       struct cfg_hostres host_res;
+       struct cfg_hostres *host_res;
+       struct wmd_dev_context *pwmd_context;
        u32 map_attrs;
        u32 shm0_end;
        u32 ul_dyn_ext_base;
@@ -341,6 +335,17 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
                HW_PAGE_SIZE64KB, HW_PAGE_SIZE4KB
        };

+       status = dev_get_wmd_context(hio_mgr->hdev_obj, &pwmd_context);
+       if (!pwmd_context) {
+               status = DSP_EHANDLE;
+               goto func_end;
+       }
+
+       host_res = pwmd_context->resources;
+       if (!host_res) {
+               status = DSP_EHANDLE;
+               goto func_end;
+       }
        status = dev_get_cod_mgr(hio_mgr->hdev_obj, &cod_man);
        if (DSP_FAILED(status))
                goto func_end;
@@ -439,13 +444,11 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
                                              sizeof(struct
                                                     mgr_processorextinfo),
                                              &num_procs);
-               cfg_get_host_resources((struct cfg_devnode *)
-                                      drv_get_first_dev_extension(),
-                                      &host_res);
+
                /* The first MMU TLB entry(TLB_0) in DCD is ShmBase. */
                ndx = 0;
-               ul_gpp_pa = host_res.dw_mem_phys[1];
-               ul_gpp_va = host_res.dw_mem_base[1];
+               ul_gpp_pa = host_res->dw_mem_phys[1];
+               ul_gpp_va = host_res->dw_mem_base[1];
                /* This is the virtual uncached ioremapped address!!! */
                /* Why can't we directly take the DSPVA from the symbols? */
                ul_dsp_va = hio_mgr->ext_proc_info.ty_tlb[0].ul_dsp_virt;
@@ -468,9 +471,9 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
                        ul_dyn_ext_base, ul_ext_end, ul_seg_size, ul_seg1_size);

                if ((ul_seg_size + ul_seg1_size + ul_pad_size) >
-                   host_res.dw_mem_length[1]) {
+                   host_res->dw_mem_length[1]) {
                        pr_err("%s: shm Error, reserved 0x%x required 0x%x\n",
-                              __func__, host_res.dw_mem_length[1],
+                              __func__, host_res->dw_mem_length[1],
                               ul_seg_size + ul_seg1_size + ul_pad_size);
                        status = DSP_EMEMORY;
                }
diff --git a/drivers/dsp/bridge/wmd/mmu_fault.c b/drivers/dsp/bridge/wmd/mmu_fault.c
index bb6e7fd..69244ce 100644
--- a/drivers/dsp/bridge/wmd/mmu_fault.c
+++ b/drivers/dsp/bridge/wmd/mmu_fault.c
@@ -69,8 +69,7 @@ irqreturn_t mmu_fault_isr(int irq, IN void *pRefData)
 {
        struct deh_mgr *deh_mgr_obj = (struct deh_mgr *)pRefData;
        struct wmd_dev_context *dev_context;
-       struct cfg_hostres resources;
-       dsp_status status = DSP_SOK;
+       struct cfg_hostres *resources;

        DBC_REQUIRE(irq == INT_DSP_MMU_IRQ);
        DBC_REQUIRE(MEM_IS_VALID_HANDLE(deh_mgr_obj, SIGNATURE));
@@ -79,12 +78,14 @@ irqreturn_t mmu_fault_isr(int irq, IN void *pRefData)

                dev_context =
                    (struct wmd_dev_context *)deh_mgr_obj->hwmd_context;
-               status = cfg_get_host_resources((struct cfg_devnode *)
-                                               drv_get_first_dev_extension(),
-                                               &resources);
-               if (DSP_FAILED(status))
+
+               resources = dev_context->resources;
+
+               if (!resources) {
                        dev_dbg(bridge, "%s: Failed to get Host Resources\n",
                                __func__);
+                       return IRQ_HANDLED;
+               }
                if (mmu_check_if_fault(dev_context)) {
                        printk(KERN_INFO "***** DSPMMU FAULT ***** IRQStatus "
                               "0x%x\n", dmmu_event_mask);
@@ -104,10 +105,10 @@ irqreturn_t mmu_fault_isr(int irq, IN void *pRefData)
                        deh_mgr_obj->err_info.dw_val3 = 0L;
                        /* Disable the MMU events, else once we clear it will
                         * start to raise INTs again */
-                       hw_mmu_event_disable(resources.dw_dmmu_base,
+                       hw_mmu_event_disable(resources->dw_dmmu_base,
                                             HW_MMU_TRANSLATION_FAULT);
                } else {
-                       hw_mmu_event_disable(resources.dw_dmmu_base,
+                       hw_mmu_event_disable(resources->dw_dmmu_base,
                                             HW_MMU_ALL_INTERRUPTS);
                }
        }
@@ -123,20 +124,18 @@ static bool mmu_check_if_fault(struct wmd_dev_context *dev_context)
 {

        bool ret = false;
-       dsp_status status = DSP_SOK;
        hw_status hw_status_obj;
-       struct cfg_hostres resources;
-       status = cfg_get_host_resources((struct cfg_devnode *)
-                                       drv_get_first_dev_extension(),
-                                       &resources);
-       if (DSP_FAILED(status))
+       struct cfg_hostres *resources = dev_context->resources;
+
+       if (!resources) {
                dev_dbg(bridge, "%s: Failed to get Host Resources in\n",
                        __func__);
-
+               return ret;
+       }
        hw_status_obj =
-           hw_mmu_event_status(resources.dw_dmmu_base, &dmmu_event_mask);
+           hw_mmu_event_status(resources->dw_dmmu_base, &dmmu_event_mask);
        if (dmmu_event_mask == HW_MMU_TRANSLATION_FAULT) {
-               hw_mmu_fault_addr_read(resources.dw_dmmu_base, &fault_addr);
+               hw_mmu_fault_addr_read(resources->dw_dmmu_base, &fault_addr);
                ret = true;
        }
        return ret;
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index a5a21eb..609cd5b 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -112,7 +112,7 @@ static dsp_status bridge_brd_mem_un_map(struct wmd_dev_context *hDevContext,
                                     u32 ulVirtAddr, u32 ul_num_bytes);
 static dsp_status bridge_dev_create(OUT struct wmd_dev_context **ppDevContext,
                                    struct dev_object *hdev_obj,
-                                   IN CONST struct cfg_hostres *pConfig);
+                                   IN struct cfg_hostres *pConfig);
 static dsp_status bridge_dev_ctrl(struct wmd_dev_context *dev_context,
                                  u32 dw_cmd, IN OUT void *pargs);
 static dsp_status bridge_dev_destroy(struct wmd_dev_context *dev_context);
@@ -317,44 +317,43 @@ static dsp_status bridge_brd_monitor(struct wmd_dev_context *hDevContext)
 {
        dsp_status status = DSP_SOK;
        struct wmd_dev_context *dev_context = hDevContext;
-       struct cfg_hostres resources;
+       struct cfg_hostres *resources;
        u32 temp;
        enum hw_pwr_state_t pwr_state;

-       status = cfg_get_host_resources((struct cfg_devnode *)
-                                       drv_get_first_dev_extension(),
-                                       &resources);
-       if (DSP_FAILED(status))
-               goto error_return;
+       resources = dev_context->resources;

-       get_hw_regs(resources.dw_prm_base, resources.dw_cm_base);
-       hw_pwrst_iva2_reg_get(resources.dw_prm_base, &temp);
+       if (!resources)
+               return DSP_EFAIL;
+
+       get_hw_regs(resources->dw_prm_base, resources->dw_cm_base);
+       hw_pwrst_iva2_reg_get(resources->dw_prm_base, &temp);
        if ((temp & 0x03) != 0x03 || (temp & 0x03) != 0x02) {
                /* IVA2 is not in ON state */
                /* Read and set PM_PWSTCTRL_IVA2  to ON */
-               hw_pwr_iva2_power_state_set(resources.dw_prm_base,
+               hw_pwr_iva2_power_state_set(resources->dw_prm_base,
                                            HW_PWR_DOMAIN_DSP, HW_PWR_STATE_ON);
                /* Set the SW supervised state transition */
-               hw_pwr_clkctrl_iva2_reg_set(resources.dw_cm_base,
+               hw_pwr_clkctrl_iva2_reg_set(resources->dw_cm_base,
                                            HW_SW_SUP_WAKEUP);
                /* Wait until the state has moved to ON */
-               hw_pwr_iva2_state_get(resources.dw_prm_base, HW_PWR_DOMAIN_DSP,
+               hw_pwr_iva2_state_get(resources->dw_prm_base, HW_PWR_DOMAIN_DSP,
                                      &pwr_state);
                /* Disable Automatic transition */
-               hw_pwr_clkctrl_iva2_reg_set(resources.dw_cm_base,
+               hw_pwr_clkctrl_iva2_reg_set(resources->dw_cm_base,
                                            HW_AUTOTRANS_DIS);
        }

-       get_hw_regs(resources.dw_prm_base, resources.dw_cm_base);
-       hw_rst_un_reset(resources.dw_prm_base, HW_RST2_IVA2);
+       get_hw_regs(resources->dw_prm_base, resources->dw_cm_base);
+       hw_rst_un_reset(resources->dw_prm_base, HW_RST2_IVA2);
        services_clk_enable(SERVICESCLK_IVA2_CK);

        if (DSP_SUCCEEDED(status)) {
                /* set the device state to IDLE */
                dev_context->dw_brd_state = BRD_IDLE;
        }
-error_return:
-       get_hw_regs(resources.dw_prm_base, resources.dw_cm_base);
+
+       get_hw_regs(resources->dw_prm_base, resources->dw_cm_base);
        return status;
 }

@@ -428,7 +427,7 @@ static dsp_status bridge_brd_start(struct wmd_dev_context *hDevContext,
        u32 ul_shm_offset_virt;
        s32 entry_ndx;
        s32 itmp_entry_ndx = 0; /* DSP-MMU TLB entry base address */
-       struct cfg_hostres resources;
+       struct cfg_hostres *resources = NULL;
        u32 temp;
        u32 ul_dsp_clk_rate;
        u32 ul_dsp_clk_addr;
@@ -468,26 +467,26 @@ static dsp_status bridge_brd_start(struct wmd_dev_context *hDevContext,
                *((volatile u32 *)dw_sync_addr) = 0xffffffff;

        if (DSP_SUCCEEDED(status)) {
-               status = cfg_get_host_resources((struct cfg_devnode *)
-                                               drv_get_first_dev_extension(),
-                                               &resources);
-               /* Assert RST1 i.e only the RST only for DSP megacell */
-               /* hw_rst_reset(resources.dwPrcmBase, HW_RST1_IVA2); */
+               resources = dev_context->resources;
+
+               if (!resources)
+                       status = DSP_EFAIL;
+
                if (DSP_SUCCEEDED(status)) {
-                       hw_rst_reset(resources.dw_prm_base, HW_RST1_IVA2);
+                       hw_rst_reset(resources->dw_prm_base, HW_RST1_IVA2);
                        if (dsp_debug) {
                                /* Set the bootmode to self loop */
                                dev_dbg(bridge, "Set boot mode to self loop"
                                        " for IVA2 Device\n");
                                hw_dspss_boot_mode_set
-                                   (resources.dw_sys_ctrl_base,
+                                   (resources->dw_sys_ctrl_base,
                                     HW_DSPSYSC_SELFLOOPBOOT, dwDSPAddr);
                        } else {
                                /* Set the bootmode to '0' - direct boot */
                                dev_dbg(bridge, "Set boot mode to direct boot"
                                        " for IVA2 Device\n");
                                hw_dspss_boot_mode_set
-                                   (resources.dw_sys_ctrl_base,
+                                   (resources->dw_sys_ctrl_base,
                                     HW_DSPSYSC_DIRECTBOOT, dwDSPAddr);
                        }
                }
@@ -495,16 +494,16 @@ static dsp_status bridge_brd_start(struct wmd_dev_context *hDevContext,
        if (DSP_SUCCEEDED(status)) {
                /* Reset and Unreset the RST2, so that BOOTADDR is copied to
                 * IVA2 SYSC register */
-               hw_rst_reset(resources.dw_prm_base, HW_RST2_IVA2);
+               hw_rst_reset(resources->dw_prm_base, HW_RST2_IVA2);
                udelay(100);
-               hw_rst_un_reset(resources.dw_prm_base, HW_RST2_IVA2);
+               hw_rst_un_reset(resources->dw_prm_base, HW_RST2_IVA2);
                udelay(100);

-               get_hw_regs(resources.dw_prm_base, resources.dw_cm_base);
+               get_hw_regs(resources->dw_prm_base, resources->dw_cm_base);
                /* Disbale the DSP MMU */
-               hw_mmu_disable(resources.dw_dmmu_base);
+               hw_mmu_disable(resources->dw_dmmu_base);
                /* Disable TWL */
-               hw_mmu_twl_disable(resources.dw_dmmu_base);
+               hw_mmu_twl_disable(resources->dw_dmmu_base);

                /* Only make TLB entry if both addresses are non-zero */
                for (entry_ndx = 0; entry_ndx < WMDIOCTL_NUMOFMMUTLB;
@@ -549,19 +548,19 @@ static dsp_status bridge_brd_start(struct wmd_dev_context *hDevContext,
        /* Lock the above TLB entries and get the BIOS and load monitor timer
         * information */
        if (DSP_SUCCEEDED(status)) {
-               hw_mmu_num_locked_set(resources.dw_dmmu_base, itmp_entry_ndx);
-               hw_mmu_victim_num_set(resources.dw_dmmu_base, itmp_entry_ndx);
-               hw_mmu_ttb_set(resources.dw_dmmu_base,
+               hw_mmu_num_locked_set(resources->dw_dmmu_base, itmp_entry_ndx);
+               hw_mmu_victim_num_set(resources->dw_dmmu_base, itmp_entry_ndx);
+               hw_mmu_ttb_set(resources->dw_dmmu_base,
                               dev_context->pt_attrs->l1_base_pa);
-               hw_mmu_twl_enable(resources.dw_dmmu_base);
+               hw_mmu_twl_enable(resources->dw_dmmu_base);
                /* Enable the SmartIdle and AutoIdle bit for MMU_SYSCONFIG */

-               temp = __raw_readl((resources.dw_dmmu_base) + 0x10);
+               temp = __raw_readl((resources->dw_dmmu_base) + 0x10);
                temp = (temp & 0xFFFFFFEF) | 0x11;
-               __raw_writel(temp, (resources.dw_dmmu_base) + 0x10);
+               __raw_writel(temp, (resources->dw_dmmu_base) + 0x10);

                /* Let the DSP MMU run */
-               hw_mmu_enable(resources.dw_dmmu_base);
+               hw_mmu_enable(resources->dw_dmmu_base);

                /* Enable the BIOS clock */
                (void)dev_get_symbol(dev_context->hdev_obj,
@@ -647,9 +646,9 @@ static dsp_status bridge_brd_start(struct wmd_dev_context *hDevContext,
                                     "_BRIDGEINIT_DSP_FREQ", &ul_dsp_clk_addr);
                /*Set Autoidle Mode for IVA2 PLL */
                temp = (u32) *((reg_uword32 *)
-                               ((u32) (resources.dw_cm_base) + 0x34));
+                               ((u32) (resources->dw_cm_base) + 0x34));
                temp = (temp & 0xFFFFFFFE) | 0x1;
-               *((reg_uword32 *) ((u32) (resources.dw_cm_base) + 0x34)) =
+               *((reg_uword32 *) ((u32) (resources->dw_cm_base) + 0x34)) =
                    (u32) temp;
                if ((unsigned int *)ul_dsp_clk_addr != NULL) {
                        /* Get the clock rate */
@@ -679,38 +678,38 @@ static dsp_status bridge_brd_start(struct wmd_dev_context *hDevContext,

 /*PM_IVA2GRPSEL_PER = 0xC0;*/
                temp = (u32) *((reg_uword32 *)
-                               ((u32) (resources.dw_per_pm_base) + 0xA8));
+                               ((u32) (resources->dw_per_pm_base) + 0xA8));
                temp = (temp & 0xFFFFFF30) | 0xC0;
-               *((reg_uword32 *) ((u32) (resources.dw_per_pm_base) + 0xA8)) =
+               *((reg_uword32 *) ((u32) (resources->dw_per_pm_base) + 0xA8)) =
                    (u32) temp;

 /*PM_MPUGRPSEL_PER &= 0xFFFFFF3F; */
                temp = (u32) *((reg_uword32 *)
-                               ((u32) (resources.dw_per_pm_base) + 0xA4));
+                               ((u32) (resources->dw_per_pm_base) + 0xA4));
                temp = (temp & 0xFFFFFF3F);
-               *((reg_uword32 *) ((u32) (resources.dw_per_pm_base) + 0xA4)) =
+               *((reg_uword32 *) ((u32) (resources->dw_per_pm_base) + 0xA4)) =
                    (u32) temp;
 /*CM_SLEEPDEP_PER |= 0x04; */
                temp = (u32) *((reg_uword32 *)
-                               ((u32) (resources.dw_per_base) + 0x44));
+                               ((u32) (resources->dw_per_base) + 0x44));
                temp = (temp & 0xFFFFFFFB) | 0x04;
-               *((reg_uword32 *) ((u32) (resources.dw_per_base) + 0x44)) =
+               *((reg_uword32 *) ((u32) (resources->dw_per_base) + 0x44)) =
                    (u32) temp;

 /*CM_CLKSTCTRL_IVA2 = 0x00000003 -To Allow automatic transitions */
                temp = (u32) *((reg_uword32 *)
-                               ((u32) (resources.dw_cm_base) + 0x48));
+                               ((u32) (resources->dw_cm_base) + 0x48));
                temp = (temp & 0xFFFFFFFC) | 0x03;
-               *((reg_uword32 *) ((u32) (resources.dw_cm_base) + 0x48)) =
+               *((reg_uword32 *) ((u32) (resources->dw_cm_base) + 0x48)) =
                    (u32) temp;

                /* Let DSP go */
                dev_dbg(bridge, "%s Unreset\n", __func__);
                /* Enable DSP MMU Interrupts */
-               hw_mmu_event_enable(resources.dw_dmmu_base,
+               hw_mmu_event_enable(resources->dw_dmmu_base,
                                    HW_MMU_ALL_INTERRUPTS);
                /* release the RST1, DSP starts executing now .. */
-               hw_rst_un_reset(resources.dw_prm_base, HW_RST1_IVA2);
+               hw_rst_un_reset(resources->dw_prm_base, HW_RST1_IVA2);

                dev_dbg(bridge, "Waiting for Sync @ 0x%x\n", dw_sync_addr);
                dev_dbg(bridge, "DSP c_int00 Address =  0x%x\n", dwDSPAddr);
@@ -753,7 +752,7 @@ static dsp_status bridge_brd_stop(struct wmd_dev_context *hDevContext)
 {
        dsp_status status = DSP_SOK;
        struct wmd_dev_context *dev_context = hDevContext;
-       struct cfg_hostres resources;
+       struct cfg_hostres *resources;
        struct pg_table_attrs *pt_attrs;
        u32 dsp_pwr_state;
        dsp_status clk_status;
@@ -764,28 +763,28 @@ static dsp_status bridge_brd_stop(struct wmd_dev_context *hDevContext)
        /* as per TRM, it is advised to first drive the IVA2 to 'Standby' mode,
         * before turning off the clocks.. This is to ensure that there are no
         * pending L3 or other transactons from IVA2 */
-       status = cfg_get_host_resources((struct cfg_devnode *)
-                                       drv_get_first_dev_extension(),
-                                       &resources);
-       if (DSP_FAILED(status))
+       resources = dev_context->resources;
+
+       if (!resources)
                return DSP_EFAIL;

-       hw_pwrst_iva2_reg_get(resources.dw_prm_base, &dsp_pwr_state);
+
+       hw_pwrst_iva2_reg_get(resources->dw_prm_base, &dsp_pwr_state);
        if (dsp_pwr_state != HW_PWR_STATE_OFF && dev_context->mbox) {
                sm_interrupt_dsp(dev_context, MBX_PM_DSPIDLE);
                mdelay(10);
-               get_hw_regs(resources.dw_prm_base, resources.dw_cm_base);
+               get_hw_regs(resources->dw_prm_base, resources->dw_cm_base);
                udelay(50);

                clk_status = services_clk_disable(SERVICESCLK_IVA2_CK);

                /* IVA2 is not in OFF state */
                /* Set PM_PWSTCTRL_IVA2  to OFF */
-               hw_pwr_iva2_power_state_set(resources.dw_prm_base,
+               hw_pwr_iva2_power_state_set(resources->dw_prm_base,
                                            HW_PWR_DOMAIN_DSP,
                                            HW_PWR_STATE_OFF);
                /* Set the SW supervised state transition for Sleep */
-               hw_pwr_clkctrl_iva2_reg_set(resources.dw_cm_base,
+               hw_pwr_clkctrl_iva2_reg_set(resources->dw_cm_base,
                                            HW_SW_SUP_SLEEP);
        } else {
                clk_status = services_clk_disable(SERVICESCLK_IVA2_CK);
@@ -813,9 +812,9 @@ static dsp_status bridge_brd_stop(struct wmd_dev_context *hDevContext)
                dev_context->mbox = NULL;
        }

-       hw_rst_reset(resources.dw_prm_base, HW_RST1_IVA2);
-       hw_rst_reset(resources.dw_prm_base, HW_RST2_IVA2);
-       hw_rst_reset(resources.dw_prm_base, HW_RST3_IVA2);
+       hw_rst_reset(resources->dw_prm_base, HW_RST1_IVA2);
+       hw_rst_reset(resources->dw_prm_base, HW_RST2_IVA2);
+       hw_rst_reset(resources->dw_prm_base, HW_RST3_IVA2);

        return status;
 }
@@ -832,7 +831,7 @@ static dsp_status wmd_brd_delete(struct wmd_dev_context *hDevContext)
 {
        dsp_status status = DSP_SOK;
        struct wmd_dev_context *dev_context = hDevContext;
-       struct cfg_hostres resources;
+       struct cfg_hostres *resources;
        struct pg_table_attrs *pt_attrs;
        dsp_status clk_status;

@@ -843,10 +842,9 @@ static dsp_status wmd_brd_delete(struct wmd_dev_context *hDevContext)
         * the IVA2 to 'Standby' mode, before turning off the clocks.. This is
         * to ensure that there are no pending L3 or other transactons from
         * IVA2 */
-       status = cfg_get_host_resources((struct cfg_devnode *)
-                                       drv_get_first_dev_extension(),
-                                       &resources);
-       if (DSP_FAILED(status))
+       resources = dev_context->resources;
+
+       if (!resources)
                return DSP_EFAIL;

        status = sleep_dsp(dev_context, PWR_EMERGENCYDEEPSLEEP, NULL);
@@ -874,9 +872,9 @@ static dsp_status wmd_brd_delete(struct wmd_dev_context *hDevContext)
                dev_context->mbox = NULL;
        }

-       hw_rst_reset(resources.dw_prm_base, HW_RST1_IVA2);
-       hw_rst_reset(resources.dw_prm_base, HW_RST2_IVA2);
-       hw_rst_reset(resources.dw_prm_base, HW_RST3_IVA2);
+       hw_rst_reset(resources->dw_prm_base, HW_RST1_IVA2);
+       hw_rst_reset(resources->dw_prm_base, HW_RST2_IVA2);
+       hw_rst_reset(resources->dw_prm_base, HW_RST3_IVA2);

        return status;
 }
@@ -926,14 +924,13 @@ static dsp_status bridge_brd_write(struct wmd_dev_context *hDevContext,
  */
 static dsp_status bridge_dev_create(OUT struct wmd_dev_context **ppDevContext,
                                    struct dev_object *hdev_obj,
-                                   IN CONST struct cfg_hostres *pConfig)
+                                   IN struct cfg_hostres *host_config)
 {
        dsp_status status = DSP_SOK;
        struct wmd_dev_context *dev_context = NULL;
        s32 entry_ndx;
        s32 tc_word_swap;
        u32 tc_word_swap_size = sizeof(tc_word_swap);
-       struct cfg_hostres resources;
        struct pg_table_attrs *pt_attrs;
        u32 pg_tbl_pa;
        u32 pg_tbl_va;
@@ -946,9 +943,7 @@ static dsp_status bridge_dev_create(OUT struct wmd_dev_context **ppDevContext,
                status = DSP_EMEMORY;
                goto func_end;
        }
-       status = cfg_get_host_resources((struct cfg_devnode *)
-                                       drv_get_first_dev_extension(),
-                                       &resources);
+
        if (DSP_FAILED(status)) {
                status = DSP_EMEMORY;
                goto func_end;
@@ -966,10 +961,10 @@ static dsp_status bridge_dev_create(OUT struct wmd_dev_context **ppDevContext,
        }
        dev_context->num_tlb_entries = 0;
        dev_context->dw_dsp_base_addr = (u32) MEM_LINEAR_ADDRESS((void *)
-                                                                (pConfig->
+                                                                (host_config->
                                                                  dw_mem_base
                                                                  [3]),
-                                                                pConfig->
+                                                                host_config->
                                                                 dw_mem_length
                                                                 [3]);
        if (!dev_context->dw_dsp_base_addr)
@@ -1068,13 +1063,14 @@ static dsp_status bridge_dev_create(OUT struct wmd_dev_context **ppDevContext,
        if (DSP_SUCCEEDED(status)) {
                /* 24xx-Linux MMU address is obtained from the host
                 * resources struct */
-               dev_context->dw_dsp_mmu_base = resources.dw_dmmu_base;
+               dev_context->dw_dsp_mmu_base = host_config->dw_dmmu_base;
        }
        if (DSP_SUCCEEDED(status)) {
                dev_context->hdev_obj = hdev_obj;
                dev_context->ul_int_mask = 0;
                /* Store current board state. */
                dev_context->dw_brd_state = BRD_STOPPED;
+               dev_context->resources = host_config;
                /* Return ptr to our device state to the WCD for storage */
                *ppDevContext = dev_context;
        } else {
@@ -1165,6 +1161,9 @@ static dsp_status bridge_dev_destroy(struct wmd_dev_context *hDevContext)
        dsp_status status = DSP_SOK;
        struct wmd_dev_context *dev_context = (struct wmd_dev_context *)
            hDevContext;
+       struct cfg_hostres *host_res;
+       u32 dw_buff_size;
+       u32 shm_size;

        /* It should never happen */
        if (!hDevContext)
@@ -1189,6 +1188,68 @@ static dsp_status bridge_dev_destroy(struct wmd_dev_context *hDevContext)
                kfree(pt_attrs);

        }
+
+       if (dev_context->resources) {
+               host_res = dev_context->resources;
+               dw_buff_size = sizeof(shm_size);
+               status = reg_get_value(SHMSIZE, (u8 *) &shm_size,
+                                              &dw_buff_size);
+               if (DSP_SUCCEEDED(status)) {
+                       if ((host_res->dw_mem_base[1]) &&
+                           (host_res->dw_mem_phys[1])) {
+                               mem_free_phys_mem((void *)
+                                                 host_res->dw_mem_base
+                                                 [1],
+                                                 host_res->dw_mem_phys
+                                                 [1], shm_size);
+                       }
+               } else {
+                       dev_dbg(bridge, "%s: Error getting shm size "
+                               "from registry: %x. Not calling "
+                               "mem_free_phys_mem\n", __func__,
+                               status);
+               }
+               host_res->dw_mem_base[1] = 0;
+               host_res->dw_mem_phys[1] = 0;
+
+               if (host_res->dw_prm_base)
+                       iounmap(host_res->dw_prm_base);
+               if (host_res->dw_cm_base)
+                       iounmap(host_res->dw_cm_base);
+               if (host_res->dw_mem_base[0])
+                       iounmap((void *)host_res->dw_mem_base[0]);
+               if (host_res->dw_mem_base[2])
+                       iounmap((void *)host_res->dw_mem_base[2]);
+               if (host_res->dw_mem_base[3])
+                       iounmap((void *)host_res->dw_mem_base[3]);
+               if (host_res->dw_mem_base[4])
+                       iounmap((void *)host_res->dw_mem_base[4]);
+               if (host_res->dw_wd_timer_dsp_base)
+                       iounmap(host_res->dw_wd_timer_dsp_base);
+               if (host_res->dw_dmmu_base)
+                       iounmap(host_res->dw_dmmu_base);
+               if (host_res->dw_per_base)
+                       iounmap(host_res->dw_per_base);
+               if (host_res->dw_per_pm_base)
+                       iounmap((void *)host_res->dw_per_pm_base);
+               if (host_res->dw_core_pm_base)
+                       iounmap((void *)host_res->dw_core_pm_base);
+               if (host_res->dw_sys_ctrl_base)
+                       iounmap(host_res->dw_sys_ctrl_base);
+
+               host_res->dw_prm_base = NULL;
+               host_res->dw_cm_base = NULL;
+               host_res->dw_mem_base[0] = (u32) NULL;
+               host_res->dw_mem_base[2] = (u32) NULL;
+               host_res->dw_mem_base[3] = (u32) NULL;
+               host_res->dw_mem_base[4] = (u32) NULL;
+               host_res->dw_wd_timer_dsp_base = NULL;
+               host_res->dw_dmmu_base = NULL;
+               host_res->dw_sys_ctrl_base = NULL;
+
+               kfree(host_res);
+       }
+
        /* Free the driver's device context: */
        kfree((void *)hDevContext);
        return status;
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 9174a80..8d08267 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -87,7 +87,7 @@ dsp_status handle_hibernation_from_dsp(struct wmd_dev_context *dev_context)
        dsp_status status = DSP_SOK;
 #ifdef CONFIG_PM
        u16 timeout = PWRSTST_TIMEOUT / 10;
-       struct cfg_hostres resources;
+       struct cfg_hostres *resources = dev_context->resources;
        enum hw_pwr_state_t pwr_state;
 #ifdef CONFIG_BRIDGE_DVFS
        u32 opplevel;
@@ -96,13 +96,7 @@ dsp_status handle_hibernation_from_dsp(struct wmd_dev_context *dev_context)
            omap_dspbridge_dev->dev.platform_data;
 #endif

-       status = cfg_get_host_resources((struct cfg_devnode *)
-                                       drv_get_first_dev_extension(),
-                                       &resources);
-       if (DSP_FAILED(status))
-               return status;
-
-       hw_pwr_iva2_state_get(resources.dw_prm_base, HW_PWR_DOMAIN_DSP,
+       hw_pwr_iva2_state_get(resources->dw_prm_base, HW_PWR_DOMAIN_DSP,
                              &pwr_state);
        /* Wait for DSP to move into OFF state */
        while ((pwr_state != HW_PWR_STATE_OFF) && --timeout) {
@@ -110,7 +104,7 @@ dsp_status handle_hibernation_from_dsp(struct wmd_dev_context *dev_context)
                        pr_err("Waiting for DSP OFF mode interrupted\n");
                        return DSP_EFAIL;
                }
-               hw_pwr_iva2_state_get(resources.dw_prm_base, HW_PWR_DOMAIN_DSP,
+               hw_pwr_iva2_state_get(resources->dw_prm_base, HW_PWR_DOMAIN_DSP,
                                      &pwr_state);
        }
        if (timeout == 0) {
@@ -158,7 +152,7 @@ dsp_status sleep_dsp(struct wmd_dev_context *dev_context, IN u32 dw_cmd,
 {
        dsp_status status = DSP_SOK;
 #ifdef CONFIG_PM
-       struct cfg_hostres resources;
+       struct cfg_hostres *resources = dev_context->resources;
 #ifdef CONFIG_BRIDGE_NTFY_PWRERR
        struct deh_mgr *hdeh_mgr;
 #endif /* CONFIG_BRIDGE_NTFY_PWRERR */
@@ -169,11 +163,8 @@ dsp_status sleep_dsp(struct wmd_dev_context *dev_context, IN u32 dw_cmd,
        if ((dw_cmd != PWR_DEEPSLEEP) && (dw_cmd != PWR_EMERGENCYDEEPSLEEP))
                return DSP_EINVALIDARG;

-       status = cfg_get_host_resources((struct cfg_devnode *)
-                                       drv_get_first_dev_extension(),
-                                       &resources);
-       if (DSP_FAILED(status))
-               return status;
+       if (!resources)
+               return DSP_EFAIL;

        switch (dev_context->dw_brd_state) {
        case BRD_RUNNING:
@@ -211,7 +202,7 @@ dsp_status sleep_dsp(struct wmd_dev_context *dev_context, IN u32 dw_cmd,
        }

        /* Get the PRCM DSP power domain status */
-       hw_pwr_iva2_state_get(resources.dw_prm_base, HW_PWR_DOMAIN_DSP,
+       hw_pwr_iva2_state_get(resources->dw_prm_base, HW_PWR_DOMAIN_DSP,
                              &pwr_state);

        /* Wait for DSP to move into target power state */
@@ -220,7 +211,7 @@ dsp_status sleep_dsp(struct wmd_dev_context *dev_context, IN u32 dw_cmd,
                        pr_err("Waiting for DSP to Suspend interrupted\n");
                        return DSP_EFAIL;
                }
-               hw_pwr_iva2_state_get(resources.dw_prm_base, HW_PWR_DOMAIN_DSP,
+               hw_pwr_iva2_state_get(resources->dw_prm_base, HW_PWR_DOMAIN_DSP,
                                      &pwr_state);
        }

@@ -301,18 +292,14 @@ dsp_status dsp_peripheral_clk_ctrl(struct wmd_dev_context *dev_context,
        u32 dsp_per_clks_before;
        dsp_status status = DSP_SOK;
        dsp_status status1 = DSP_SOK;
-       struct cfg_hostres resources;
+       struct cfg_hostres *resources = dev_context->resources;
        u32 value;

        dsp_per_clks_before = dev_context->dsp_per_clks;

        ext_clk = (u32) *((u32 *) pargs);

-       status = cfg_get_host_resources((struct cfg_devnode *)
-                                       drv_get_first_dev_extension(),
-                                       &resources);
-
-       if (DSP_FAILED(status))
+       if (!resources)
                return DSP_EFAIL;

        ext_clk_id = ext_clk & MBX_PM_CLK_IDMASK;
@@ -339,14 +326,18 @@ dsp_status dsp_peripheral_clk_ctrl(struct wmd_dev_context *dev_context,
                status = services_clk_disable(bpwr_clks[clk_id_index].fun_clk);
                if (bpwr_clkid[clk_id_index] == BPWR_MCBSP1) {
                        /* clear MCBSP1_CLKS, on McBSP1 OFF */
-                       value = __raw_readl(resources.dw_sys_ctrl_base + 0x274);
+                       value = __raw_readl(
+                               resources->dw_sys_ctrl_base + 0x274);
                        value &= ~(1 << 2);
-                       __raw_writel(value, resources.dw_sys_ctrl_base + 0x274);
+                       __raw_writel(value,
+                               resources->dw_sys_ctrl_base + 0x274);
                } else if (bpwr_clkid[clk_id_index] == BPWR_MCBSP2) {
                        /* clear MCBSP2_CLKS, on McBSP2 OFF */
-                       value = __raw_readl(resources.dw_sys_ctrl_base + 0x274);
+                       value = __raw_readl(
+                               resources->dw_sys_ctrl_base + 0x274);
                        value &= ~(1 << 6);
-                       __raw_writel(value, resources.dw_sys_ctrl_base + 0x274);
+                       __raw_writel(value,
+                               resources->dw_sys_ctrl_base + 0x274);
                }
                dsp_clk_wakeup_event_ctrl(bpwr_clks[clk_id_index].clk_id,
                                          false);
@@ -360,14 +351,18 @@ dsp_status dsp_peripheral_clk_ctrl(struct wmd_dev_context *dev_context,
                status = services_clk_enable(bpwr_clks[clk_id_index].fun_clk);
                if (bpwr_clkid[clk_id_index] == BPWR_MCBSP1) {
                        /* set MCBSP1_CLKS, on McBSP1 ON */
-                       value = __raw_readl(resources.dw_sys_ctrl_base + 0x274);
+                       value = __raw_readl(
+                               resources->dw_sys_ctrl_base + 0x274);
                        value |= 1 << 2;
-                       __raw_writel(value, resources.dw_sys_ctrl_base + 0x274);
+                       __raw_writel(value,
+                               resources->dw_sys_ctrl_base + 0x274);
                } else if (bpwr_clkid[clk_id_index] == BPWR_MCBSP2) {
                        /* set MCBSP2_CLKS, on McBSP2 ON */
-                       value = __raw_readl(resources.dw_sys_ctrl_base + 0x274);
+                       value = __raw_readl(
+                               resources->dw_sys_ctrl_base + 0x274);
                        value |= 1 << 6;
-                       __raw_writel(value, resources.dw_sys_ctrl_base + 0x274);
+                       __raw_writel(value,
+                               resources->dw_sys_ctrl_base + 0x274);
                }
                dsp_clk_wakeup_event_ctrl(bpwr_clks[clk_id_index].clk_id, true);
                if ((DSP_SUCCEEDED(status)) && (DSP_SUCCEEDED(status1))) {
@@ -467,12 +462,11 @@ dsp_status dsp_peripheral_clocks_disable(struct wmd_dev_context *dev_context,
 {
        u32 clk_idx;
        dsp_status status = DSP_SOK;
-       struct cfg_hostres resources;
+       struct cfg_hostres *resources = dev_context->resources;
        u32 value;

-       status = cfg_get_host_resources((struct cfg_devnode *)
-                                       drv_get_first_dev_extension(),
-                                       &resources);
+       if (!resources)
+               return DSP_EFAIL;

        for (clk_idx = 0; clk_idx < MBX_PM_MAX_RESOURCES; clk_idx++) {
                if (((dev_context->dsp_per_clks) >> clk_idx) & 0x01) {
@@ -481,17 +475,17 @@ dsp_status dsp_peripheral_clocks_disable(struct wmd_dev_context *dev_context,
                            services_clk_disable(bpwr_clks[clk_idx].int_clk);
                        if (bpwr_clkid[clk_idx] == BPWR_MCBSP1) {
                                /* clear MCBSP1_CLKS, on McBSP1 OFF */
-                               value = __raw_readl(resources.dw_sys_ctrl_base
+                               value = __raw_readl(resources->dw_sys_ctrl_base
                                                    + 0x274);
                                value &= ~(1 << 2);
-                               __raw_writel(value, resources.dw_sys_ctrl_base
+                               __raw_writel(value, resources->dw_sys_ctrl_base
                                             + 0x274);
                        } else if (bpwr_clkid[clk_idx] == BPWR_MCBSP2) {
                                /* clear MCBSP2_CLKS, on McBSP2 OFF */
-                               value = __raw_readl(resources.dw_sys_ctrl_base
+                               value = __raw_readl(resources->dw_sys_ctrl_base
                                                    + 0x274);
                                value &= ~(1 << 6);
-                               __raw_writel(value, resources.dw_sys_ctrl_base
+                               __raw_writel(value, resources->dw_sys_ctrl_base
                                             + 0x274);
                        }

@@ -512,11 +506,11 @@ dsp_status dsp_peripheral_clocks_enable(struct wmd_dev_context *dev_context,
 {
        u32 clk_idx;
        dsp_status int_clk_status = DSP_EFAIL, fun_clk_status = DSP_EFAIL;
-       struct cfg_hostres resources;
+       struct cfg_hostres *resources = dev_context->resources;
        u32 value;

-       cfg_get_host_resources((struct cfg_devnode *)
-                              drv_get_first_dev_extension(), &resources);
+       if (!resources)
+               return DSP_EFAIL;

        for (clk_idx = 0; clk_idx < MBX_PM_MAX_RESOURCES; clk_idx++) {
                if (((dev_context->dsp_per_clks) >> clk_idx) & 0x01) {
@@ -525,17 +519,17 @@ dsp_status dsp_peripheral_clocks_enable(struct wmd_dev_context *dev_context,
                            services_clk_enable(bpwr_clks[clk_idx].int_clk);
                        if (bpwr_clkid[clk_idx] == BPWR_MCBSP1) {
                                /* set MCBSP1_CLKS, on McBSP1 ON */
-                               value = __raw_readl(resources.dw_sys_ctrl_base
+                               value = __raw_readl(resources->dw_sys_ctrl_base
                                                    + 0x274);
                                value |= 1 << 2;
-                               __raw_writel(value, resources.dw_sys_ctrl_base
+                               __raw_writel(value, resources->dw_sys_ctrl_base
                                             + 0x274);
                        } else if (bpwr_clkid[clk_idx] == BPWR_MCBSP2) {
                                /* set MCBSP2_CLKS, on McBSP2 ON */
-                               value = __raw_readl(resources.dw_sys_ctrl_base
+                               value = __raw_readl(resources->dw_sys_ctrl_base
                                                    + 0x274);
                                value |= 1 << 6;
-                               __raw_writel(value, resources.dw_sys_ctrl_base
+                               __raw_writel(value, resources->dw_sys_ctrl_base
                                             + 0x274);
                        }
                        /* Enable the functional clock of the periphearl */
@@ -550,24 +544,33 @@ dsp_status dsp_peripheral_clocks_enable(struct wmd_dev_context *dev_context,

 void dsp_clk_wakeup_event_ctrl(u32 ClkId, bool enable)
 {
-       struct cfg_hostres resources;
+       struct cfg_hostres *resources;
        dsp_status status = DSP_SOK;
        u32 iva2_grpsel;
        u32 mpu_grpsel;
+       struct dev_object *hdev_object = NULL;
+       struct wmd_dev_context *wmd_context = NULL;
+
+       hdev_object = (struct dev_object *)drv_get_first_dev_object();
+       if (!hdev_object)
+               return;
+
+       status = dev_get_wmd_context(hdev_object, &wmd_context);
+
+       if (!wmd_context)
+               return;

-       status = cfg_get_host_resources((struct cfg_devnode *)
-                                       drv_get_first_dev_extension(),
-                                       &resources);
-       if (DSP_FAILED(status))
+       resources = wmd_context->resources;
+       if (!resources)
                return;

        switch (ClkId) {
        case BPWR_GP_TIMER5:
                iva2_grpsel = (u32) *((reg_uword32 *)
-                                      ((u32) (resources.dw_per_pm_base) +
+                                      ((u32) (resources->dw_per_pm_base) +
                                        0xA8));
                mpu_grpsel = (u32) *((reg_uword32 *)
-                                     ((u32) (resources.dw_per_pm_base) +
+                                     ((u32) (resources->dw_per_pm_base) +
                                       0xA4));
                if (enable) {
                        iva2_grpsel |= OMAP3430_GRPSEL_GPT5;
@@ -576,17 +579,17 @@ void dsp_clk_wakeup_event_ctrl(u32 ClkId, bool enable)
                        mpu_grpsel |= OMAP3430_GRPSEL_GPT5;
                        iva2_grpsel &= ~OMAP3430_GRPSEL_GPT5;
                }
-               *((reg_uword32 *) ((u32) (resources.dw_per_pm_base) + 0xA8))
+               *((reg_uword32 *) ((u32) (resources->dw_per_pm_base) + 0xA8))
                    = iva2_grpsel;
-               *((reg_uword32 *) ((u32) (resources.dw_per_pm_base) + 0xA4))
+               *((reg_uword32 *) ((u32) (resources->dw_per_pm_base) + 0xA4))
                    = mpu_grpsel;
                break;
        case BPWR_GP_TIMER6:
                iva2_grpsel = (u32) *((reg_uword32 *)
-                                      ((u32) (resources.dw_per_pm_base) +
+                                      ((u32) (resources->dw_per_pm_base) +
                                        0xA8));
                mpu_grpsel = (u32) *((reg_uword32 *)
-                                     ((u32) (resources.dw_per_pm_base) +
+                                     ((u32) (resources->dw_per_pm_base) +
                                       0xA4));
                if (enable) {
                        iva2_grpsel |= OMAP3430_GRPSEL_GPT6;
@@ -595,17 +598,17 @@ void dsp_clk_wakeup_event_ctrl(u32 ClkId, bool enable)
                        mpu_grpsel |= OMAP3430_GRPSEL_GPT6;
                        iva2_grpsel &= ~OMAP3430_GRPSEL_GPT6;
                }
-               *((reg_uword32 *) ((u32) (resources.dw_per_pm_base) + 0xA8))
+               *((reg_uword32 *) ((u32) (resources->dw_per_pm_base) + 0xA8))
                    = iva2_grpsel;
-               *((reg_uword32 *) ((u32) (resources.dw_per_pm_base) + 0xA4))
+               *((reg_uword32 *) ((u32) (resources->dw_per_pm_base) + 0xA4))
                    = mpu_grpsel;
                break;
        case BPWR_GP_TIMER7:
                iva2_grpsel = (u32) *((reg_uword32 *)
-                                      ((u32) (resources.dw_per_pm_base) +
+                                      ((u32) (resources->dw_per_pm_base) +
                                        0xA8));
                mpu_grpsel = (u32) *((reg_uword32 *)
-                                     ((u32) (resources.dw_per_pm_base) +
+                                     ((u32) (resources->dw_per_pm_base) +
                                       0xA4));
                if (enable) {
                        iva2_grpsel |= OMAP3430_GRPSEL_GPT7;
@@ -614,17 +617,17 @@ void dsp_clk_wakeup_event_ctrl(u32 ClkId, bool enable)
                        mpu_grpsel |= OMAP3430_GRPSEL_GPT7;
                        iva2_grpsel &= ~OMAP3430_GRPSEL_GPT7;
                }
-               *((reg_uword32 *) ((u32) (resources.dw_per_pm_base) + 0xA8))
+               *((reg_uword32 *) ((u32) (resources->dw_per_pm_base) + 0xA8))
                    = iva2_grpsel;
-               *((reg_uword32 *) ((u32) (resources.dw_per_pm_base) + 0xA4))
+               *((reg_uword32 *) ((u32) (resources->dw_per_pm_base) + 0xA4))
                    = mpu_grpsel;
                break;
        case BPWR_GP_TIMER8:
                iva2_grpsel = (u32) *((reg_uword32 *)
-                                      ((u32) (resources.dw_per_pm_base) +
+                                      ((u32) (resources->dw_per_pm_base) +
                                        0xA8));
                mpu_grpsel = (u32) *((reg_uword32 *)
-                                     ((u32) (resources.dw_per_pm_base) +
+                                     ((u32) (resources->dw_per_pm_base) +
                                       0xA4));
                if (enable) {
                        iva2_grpsel |= OMAP3430_GRPSEL_GPT8;
@@ -633,17 +636,17 @@ void dsp_clk_wakeup_event_ctrl(u32 ClkId, bool enable)
                        mpu_grpsel |= OMAP3430_GRPSEL_GPT8;
                        iva2_grpsel &= ~OMAP3430_GRPSEL_GPT8;
                }
-               *((reg_uword32 *) ((u32) (resources.dw_per_pm_base) + 0xA8))
+               *((reg_uword32 *) ((u32) (resources->dw_per_pm_base) + 0xA8))
                    = iva2_grpsel;
-               *((reg_uword32 *) ((u32) (resources.dw_per_pm_base) + 0xA4))
+               *((reg_uword32 *) ((u32) (resources->dw_per_pm_base) + 0xA4))
                    = mpu_grpsel;
                break;
        case BPWR_MCBSP1:
                iva2_grpsel = (u32) *((reg_uword32 *)
-                                      ((u32) (resources.dw_core_pm_base) +
+                                      ((u32) (resources->dw_core_pm_base) +
                                        0xA8));
                mpu_grpsel = (u32) *((reg_uword32 *)
-                                     ((u32) (resources.dw_core_pm_base) +
+                                     ((u32) (resources->dw_core_pm_base) +
                                       0xA4));
                if (enable) {
                        iva2_grpsel |= OMAP3430_GRPSEL_MCBSP1;
@@ -652,17 +655,17 @@ void dsp_clk_wakeup_event_ctrl(u32 ClkId, bool enable)
                        mpu_grpsel |= OMAP3430_GRPSEL_MCBSP1;
                        iva2_grpsel &= ~OMAP3430_GRPSEL_MCBSP1;
                }
-               *((reg_uword32 *) ((u32) (resources.dw_core_pm_base) + 0xA8))
+               *((reg_uword32 *) ((u32) (resources->dw_core_pm_base) + 0xA8))
                    = iva2_grpsel;
-               *((reg_uword32 *) ((u32) (resources.dw_core_pm_base) + 0xA4))
+               *((reg_uword32 *) ((u32) (resources->dw_core_pm_base) + 0xA4))
                    = mpu_grpsel;
                break;
        case BPWR_MCBSP2:
                iva2_grpsel = (u32) *((reg_uword32 *)
-                                      ((u32) (resources.dw_per_pm_base) +
+                                      ((u32) (resources->dw_per_pm_base) +
                                        0xA8));
                mpu_grpsel = (u32) *((reg_uword32 *)
-                                     ((u32) (resources.dw_per_pm_base) +
+                                     ((u32) (resources->dw_per_pm_base) +
                                       0xA4));
                if (enable) {
                        iva2_grpsel |= OMAP3430_GRPSEL_MCBSP2;
@@ -671,17 +674,17 @@ void dsp_clk_wakeup_event_ctrl(u32 ClkId, bool enable)
                        mpu_grpsel |= OMAP3430_GRPSEL_MCBSP2;
                        iva2_grpsel &= ~OMAP3430_GRPSEL_MCBSP2;
                }
-               *((reg_uword32 *) ((u32) (resources.dw_per_pm_base) + 0xA8))
+               *((reg_uword32 *) ((u32) (resources->dw_per_pm_base) + 0xA8))
                    = iva2_grpsel;
-               *((reg_uword32 *) ((u32) (resources.dw_per_pm_base) + 0xA4))
+               *((reg_uword32 *) ((u32) (resources->dw_per_pm_base) + 0xA4))
                    = mpu_grpsel;
                break;
        case BPWR_MCBSP3:
                iva2_grpsel = (u32) *((reg_uword32 *)
-                                      ((u32) (resources.dw_per_pm_base) +
+                                      ((u32) (resources->dw_per_pm_base) +
                                        0xA8));
                mpu_grpsel = (u32) *((reg_uword32 *)
-                                     ((u32) (resources.dw_per_pm_base) +
+                                     ((u32) (resources->dw_per_pm_base) +
                                       0xA4));
                if (enable) {
                        iva2_grpsel |= OMAP3430_GRPSEL_MCBSP3;
@@ -690,17 +693,17 @@ void dsp_clk_wakeup_event_ctrl(u32 ClkId, bool enable)
                        mpu_grpsel |= OMAP3430_GRPSEL_MCBSP3;
                        iva2_grpsel &= ~OMAP3430_GRPSEL_MCBSP3;
                }
-               *((reg_uword32 *) ((u32) (resources.dw_per_pm_base) + 0xA8))
+               *((reg_uword32 *) ((u32) (resources->dw_per_pm_base) + 0xA8))
                    = iva2_grpsel;
-               *((reg_uword32 *) ((u32) (resources.dw_per_pm_base) + 0xA4))
+               *((reg_uword32 *) ((u32) (resources->dw_per_pm_base) + 0xA4))
                    = mpu_grpsel;
                break;
        case BPWR_MCBSP4:
                iva2_grpsel = (u32) *((reg_uword32 *)
-                                      ((u32) (resources.dw_per_pm_base) +
+                                      ((u32) (resources->dw_per_pm_base) +
                                        0xA8));
                mpu_grpsel = (u32) *((reg_uword32 *)
-                                     ((u32) (resources.dw_per_pm_base) +
+                                     ((u32) (resources->dw_per_pm_base) +
                                       0xA4));
                if (enable) {
                        iva2_grpsel |= OMAP3430_GRPSEL_MCBSP4;
@@ -709,17 +712,17 @@ void dsp_clk_wakeup_event_ctrl(u32 ClkId, bool enable)
                        mpu_grpsel |= OMAP3430_GRPSEL_MCBSP4;
                        iva2_grpsel &= ~OMAP3430_GRPSEL_MCBSP4;
                }
-               *((reg_uword32 *) ((u32) (resources.dw_per_pm_base) + 0xA8))
+               *((reg_uword32 *) ((u32) (resources->dw_per_pm_base) + 0xA8))
                    = iva2_grpsel;
-               *((reg_uword32 *) ((u32) (resources.dw_per_pm_base) + 0xA4))
+               *((reg_uword32 *) ((u32) (resources->dw_per_pm_base) + 0xA4))
                    = mpu_grpsel;
                break;
        case BPWR_MCBSP5:
                iva2_grpsel = (u32) *((reg_uword32 *)
-                                      ((u32) (resources.dw_core_pm_base) +
+                                      ((u32) (resources->dw_core_pm_base) +
                                        0xA8));
                mpu_grpsel = (u32) *((reg_uword32 *)
-                                     ((u32) (resources.dw_core_pm_base) +
+                                     ((u32) (resources->dw_core_pm_base) +
                                       0xA4));
                if (enable) {
                        iva2_grpsel |= OMAP3430_GRPSEL_MCBSP5;
@@ -728,9 +731,9 @@ void dsp_clk_wakeup_event_ctrl(u32 ClkId, bool enable)
                        mpu_grpsel |= OMAP3430_GRPSEL_MCBSP5;
                        iva2_grpsel &= ~OMAP3430_GRPSEL_MCBSP5;
                }
-               *((reg_uword32 *) ((u32) (resources.dw_core_pm_base) + 0xA8))
+               *((reg_uword32 *) ((u32) (resources->dw_core_pm_base) + 0xA8))
                    = iva2_grpsel;
-               *((reg_uword32 *) ((u32) (resources.dw_core_pm_base) + 0xA4))
+               *((reg_uword32 *) ((u32) (resources->dw_core_pm_base) + 0xA4))
                    = mpu_grpsel;
                break;
        }
diff --git a/drivers/dsp/bridge/wmd/tiomap_io.c b/drivers/dsp/bridge/wmd/tiomap_io.c
index b5504a9..32f4358 100644
--- a/drivers/dsp/bridge/wmd/tiomap_io.c
+++ b/drivers/dsp/bridge/wmd/tiomap_io.c
@@ -185,32 +185,28 @@ dsp_status write_dsp_data(struct wmd_dev_context *hDevContext,
 {
        u32 offset;
        u32 dw_base_addr = hDevContext->dw_dsp_base_addr;
-       struct cfg_hostres resources;
-       dsp_status status;
+       struct cfg_hostres *resources = hDevContext->resources;
+       dsp_status status = DSP_SOK;
        u32 base1, base2, base3;
        base1 = OMAP_DSP_MEM1_SIZE;
        base2 = OMAP_DSP_MEM2_BASE - OMAP_DSP_MEM1_BASE;
        base3 = OMAP_DSP_MEM3_BASE - OMAP_DSP_MEM1_BASE;

-       status = cfg_get_host_resources((struct cfg_devnode *)
-                                       drv_get_first_dev_extension(),
-                                       &resources);
-
-       if (DSP_FAILED(status))
-               return status;
+       if (!resources)
+               return DSP_EFAIL;

        offset = dwDSPAddr - hDevContext->dw_dsp_start_add;
        if (offset < base1) {
-               dw_base_addr = MEM_LINEAR_ADDRESS(resources.dw_mem_base[2],
-                                                 resources.dw_mem_length[2]);
+               dw_base_addr = MEM_LINEAR_ADDRESS(resources->dw_mem_base[2],
+                                                 resources->dw_mem_length[2]);
        } else if (offset > base1 && offset < base2 + OMAP_DSP_MEM2_SIZE) {
-               dw_base_addr = MEM_LINEAR_ADDRESS(resources.dw_mem_base[3],
-                                                 resources.dw_mem_length[3]);
+               dw_base_addr = MEM_LINEAR_ADDRESS(resources->dw_mem_base[3],
+                                                 resources->dw_mem_length[3]);
                offset = offset - base2;
        } else if (offset >= base2 + OMAP_DSP_MEM2_SIZE &&
                   offset < base3 + OMAP_DSP_MEM3_SIZE) {
-               dw_base_addr = MEM_LINEAR_ADDRESS(resources.dw_mem_base[4],
-                                                 resources.dw_mem_length[4]);
+               dw_base_addr = MEM_LINEAR_ADDRESS(resources->dw_mem_base[4],
+                                                 resources->dw_mem_length[4]);
                offset = offset - base3;
        } else {
                return DSP_EFAIL;
@@ -243,7 +239,7 @@ dsp_status write_ext_dsp_data(struct wmd_dev_context *dev_context,
        u32 dw_ext_prog_virt_mem;
        u32 ul_tlb_base_virt = 0;
        u32 ul_shm_offset_virt = 0;
-       struct cfg_hostres host_res;
+       struct cfg_hostres *host_res = dev_context->resources;
        bool trace_load = false;
        temp_byte1 = 0x0;
        temp_byte2 = 0x0;
@@ -346,10 +342,7 @@ dsp_status write_ext_dsp_data(struct wmd_dev_context *dev_context,
                                dw_ext_prog_virt_mem =
                                    dev_context->atlb_entry[0].ul_gpp_va;
                        } else {
-                               cfg_get_host_resources((struct cfg_devnode *)
-                                               drv_get_first_dev_extension(),
-                                               &host_res);
-                               dw_ext_prog_virt_mem = host_res.dw_mem_base[1];
+                               dw_ext_prog_virt_mem = host_res->dw_mem_base[1];
                                dw_ext_prog_virt_mem +=
                                    (ul_ext_base - ul_dyn_ext_base);
                        }
@@ -401,17 +394,14 @@ dsp_status sm_interrupt_dsp(struct wmd_dev_context *dev_context, u16 mb_val)
                omap_dspbridge_dev->dev.platform_data;
        u32 opplevel = 0;
 #endif
-       struct cfg_hostres resources;
+       struct cfg_hostres *resources = dev_context->resources;
        dsp_status status = DSP_SOK;
        u32 temp;

        if (!dev_context->mbox)
                return DSP_SOK;

-       status = cfg_get_host_resources((struct cfg_devnode *)
-                                       drv_get_first_dev_extension(),
-                                       &resources);
-       if (DSP_FAILED(status))
+       if (!resources)
                return DSP_EFAIL;

        if (dev_context->dw_brd_state == BRD_DSP_HIBERNATION ||
@@ -431,22 +421,22 @@ dsp_status sm_interrupt_dsp(struct wmd_dev_context *dev_context, u16 mb_val)
                 * 2:0 AUTO_IVA2_DPLL - Enabling IVA2 DPLL auto control
                 *     in CM_AUTOIDLE_PLL_IVA2 register
                 */
-               *(reg_uword32 *) (resources.dw_cm_base + 0x34) = 0x1;
+               *(reg_uword32 *) (resources->dw_cm_base + 0x34) = 0x1;

                /*
                 * 7:4 IVA2_DPLL_FREQSEL - IVA2 internal frq set to
                 *     0.75 MHz - 1.0 MHz
                 * 2:0 EN_IVA2_DPLL - Enable IVA2 DPLL in lock mode
                 */
-               temp = *(reg_uword32 *) (resources.dw_cm_base + 0x4);
+               temp = *(reg_uword32 *) (resources->dw_cm_base + 0x4);
                temp = (temp & 0xFFFFFF08) | 0x37;
-               *(reg_uword32 *) (resources.dw_cm_base + 0x4) = temp;
+               *(reg_uword32 *) (resources->dw_cm_base + 0x4) = temp;

                /* Restore mailbox settings */
                omap_mbox_restore_ctx(dev_context->mbox);

                /* Access MMU SYS CONFIG register to generate a short wakeup */
-               temp = *(reg_uword32 *) (resources.dw_dmmu_base + 0x10);
+               temp = *(reg_uword32 *) (resources->dw_dmmu_base + 0x10);

                dev_context->dw_brd_state = BRD_RUNNING;
        } else if (dev_context->dw_brd_state == BRD_RETENTION) {
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 4d74acd..c38638b 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -81,8 +81,6 @@ dsp_status bridge_deh_create(OUT struct deh_mgr **phDehMgr,
 {
        dsp_status status = DSP_SOK;
        struct deh_mgr *deh_mgr_obj = NULL;
-       struct cfg_hostres cfg_host_res;
-       struct cfg_devnode *dev_node_obj;
        struct wmd_dev_context *hwmd_context = NULL;

        /*  Message manager will be created when a file is loaded, since
@@ -109,13 +107,6 @@ dsp_status bridge_deh_create(OUT struct deh_mgr **phDehMgr,
                tasklet_init(&deh_mgr_obj->dpc_tasklet, mmu_fault_dpc,
                             (u32) deh_mgr_obj);

-               if (DSP_SUCCEEDED(status))
-                       status = dev_get_dev_node(hdev_obj, &dev_node_obj);
-
-               if (DSP_SUCCEEDED(status))
-                       status =
-                           cfg_get_host_resources(dev_node_obj, &cfg_host_res);
-
                if (DSP_SUCCEEDED(status)) {
                        /* Fill in context structure */
                        deh_mgr_obj->hwmd_context = hwmd_context;
@@ -212,14 +203,10 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
        u32 mem_physical = 0;
        u32 hw_mmu_max_tlb_count = 31;
        extern u32 fault_addr;
-       struct cfg_hostres resources;
+       struct cfg_hostres *resources;
        hw_status hw_status_obj;
        u32 cnt = 0;

-       status = cfg_get_host_resources((struct cfg_devnode *)
-                                       drv_get_first_dev_extension(),
-                                       &resources);
-
        if (MEM_IS_VALID_HANDLE(deh_mgr_obj, SIGNATURE)) {
                printk(KERN_INFO
                       "bridge_deh_notify: ********** DEVICE EXCEPTION "
@@ -227,6 +214,8 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
                dev_context =
                    (struct wmd_dev_context *)deh_mgr_obj->hwmd_context;

+               resources = dev_context->resources;
+
                switch (ulEventMask) {
                case DSP_SYSERROR:
                        /* reset err_info structure before use */
@@ -280,7 +269,7 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
                        }
                        if (DSP_SUCCEEDED(status)) {
                                hw_status_obj =
-                                   hw_mmu_tlb_add(resources.dw_dmmu_base,
+                                   hw_mmu_tlb_add(resources->dw_dmmu_base,
                                                   mem_physical, fault_addr,
                                                   HW_PAGE_SIZE4KB, 1,
                                                   &map_attrs, HW_SET, HW_SET);
@@ -321,7 +310,7 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
                        }

                        /* Clear MMU interrupt */
-                       hw_mmu_event_ack(resources.dw_dmmu_base,
+                       hw_mmu_event_ack(resources->dw_dmmu_base,
                                         HW_MMU_TRANSLATION_FAULT);
                        dump_dsp_stack(deh_mgr_obj->hwmd_context);
                        break;
--
1.5.4.5

