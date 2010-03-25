From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC][PATCH 5/19] DSPBRIDGE: Cleanup custom error code
 (DSP_EINVALIDARG -> EINVAL)
Date: Fri, 26 Mar 2010 01:36:26 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DEBEB21@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42899 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667Ab0CYUGi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 16:06:38 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>

>From abbca2b727ef2554790430b4c412902a6783267d Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Tue, 23 Mar 2010 11:32:19 -0600
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code (DSP_EINVALIDARG -> EINVAL)

This patch replaces DSP_EINVALIDARG with EINVAL.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/_dcd.h    |    2 +-
 arch/arm/plat-omap/include/dspbridge/chnl.h    |    2 +-
 arch/arm/plat-omap/include/dspbridge/cmm.h     |    8 ++++----
 arch/arm/plat-omap/include/dspbridge/dev.h     |    2 +-
 arch/arm/plat-omap/include/dspbridge/errbase.h |    3 ---
 arch/arm/plat-omap/include/dspbridge/mgr.h     |    4 ++--
 arch/arm/plat-omap/include/dspbridge/pwr.h     |    2 +-
 arch/arm/plat-omap/include/dspbridge/sync.h    |    2 +-
 arch/arm/plat-omap/include/dspbridge/wmd.h     |    2 +-
 drivers/dsp/bridge/pmgr/chnl.c                 |    2 +-
 drivers/dsp/bridge/pmgr/cmm.c                  |    4 ++--
 drivers/dsp/bridge/pmgr/cod.c                  |    2 +-
 drivers/dsp/bridge/pmgr/wcd.c                  |   18 +++++++++---------
 drivers/dsp/bridge/rmgr/dbdcd.c                |    2 +-
 drivers/dsp/bridge/rmgr/drv_interface.c        |    2 +-
 drivers/dsp/bridge/rmgr/mgr.c                  |    2 +-
 drivers/dsp/bridge/rmgr/node.c                 |    2 +-
 drivers/dsp/bridge/rmgr/pwr.c                  |    4 ++--
 drivers/dsp/bridge/rmgr/strm.c                 |    2 +-
 drivers/dsp/bridge/services/cfg.c              |    4 ++--
 drivers/dsp/bridge/wmd/chnl_sm.c               |    4 ++--
 drivers/dsp/bridge/wmd/tiomap3430.c            |    6 +++---
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c        |    2 +-
 23 files changed, 40 insertions(+), 43 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/_dcd.h b/arch/arm/plat-omap/include/dspbridge/_dcd.h
index 1350feb..242774c 100644
--- a/arch/arm/plat-omap/include/dspbridge/_dcd.h
+++ b/arch/arm/plat-omap/include/dspbridge/_dcd.h
@@ -31,7 +31,7 @@
  *      args:       Argument structure.
  *      pResult:
  *  Returns:
- *      DSP_SOK if command called; DSP_EINVALIDARG if command not in IOCTL
+ *      DSP_SOK if command called; EINVAL if command not in IOCTL
  *      table.
  *  Requires:
  *  Ensures:
diff --git a/arch/arm/plat-omap/include/dspbridge/chnl.h b/arch/arm/plat-omap/include/dspbridge/chnl.h
index e70c90f..48e2aaf 100644
--- a/arch/arm/plat-omap/include/dspbridge/chnl.h
+++ b/arch/arm/plat-omap/include/dspbridge/chnl.h
@@ -61,7 +61,7 @@ extern dsp_status chnl_close(struct chnl_object *chnl_obj);
  *  Returns:
  *      DSP_SOK:                Success;
  *      EFAULT:            hdev_obj is invalid.
- *      DSP_EINVALIDARG:        max_channels is 0.
+ *      EINVAL:        max_channels is 0.
  *      DSP_EMEMORY:            Insufficient memory for requested resources.
  *      CHNL_E_ISR:             Unable to plug channel ISR for configured IRQ.
  *      CHNL_E_MAXCHANNELS:     This manager cannot handle this many channels.
diff --git a/arch/arm/plat-omap/include/dspbridge/cmm.h b/arch/arm/plat-omap/include/dspbridge/cmm.h
index bc60035..5fc8f97 100644
--- a/arch/arm/plat-omap/include/dspbridge/cmm.h
+++ b/arch/arm/plat-omap/include/dspbridge/cmm.h
@@ -176,7 +176,7 @@ extern dsp_status cmm_get_handle(void *hprocessor,
  *  Returns:
  *      DSP_SOK:        Success.
  *      EFAULT:    Invalid handle.
- *      DSP_EINVALIDARG Invalid input argument.
+ *      EINVAL Invalid input argument.
  *  Requires:
  *  Ensures:
  *
@@ -214,7 +214,7 @@ extern bool cmm_init(void);
  *  Returns:
  *      DSP_SOK:         Success.
  *      EFAULT:     Invalid hcmm_mgr handle.
- *      DSP_EINVALIDARG: Invalid input argument.
+ *      EINVAL: Invalid input argument.
  *      DSP_EFAIL:       Unable to register.
  *      - On success *pulSegId is a valid SM segment ID.
  *  Requires:
@@ -245,7 +245,7 @@ extern dsp_status cmm_register_gppsm_seg(struct cmm_object *hcmm_mgr,
  *  Returns:
  *       DSP_SOK:         Success.
  *       EFAULT:     Invalid handle.
- *       DSP_EINVALIDARG: Invalid ul_seg_id.
+ *       EINVAL: Invalid ul_seg_id.
  *       DSP_EFAIL:       Unable to unregister for unknown reason.
  *  Requires:
  *  Ensures:
@@ -286,7 +286,7 @@ extern void *cmm_xlator_alloc_buf(struct cmm_xlatorobject *xlator,
  *     pXlatorAttrs:   Translator attributes used for the client NODE or STREAM.
  *  Returns:
  *     DSP_SOK:            Success.
- *     DSP_EINVALIDARG:    Bad input Attrs.
+ *     EINVAL:    Bad input Attrs.
  *     DSP_EMEMORY:   Insufficient memory(local) for requested resources.
  *  Requires:
  *     phXlator != NULL
diff --git a/arch/arm/plat-omap/include/dspbridge/dev.h b/arch/arm/plat-omap/include/dspbridge/dev.h
index fdf15dc..26cf971 100644
--- a/arch/arm/plat-omap/include/dspbridge/dev.h
+++ b/arch/arm/plat-omap/include/dspbridge/dev.h
@@ -640,7 +640,7 @@ extern dsp_status dev_remove_proc_object(struct dev_object
  *      ulStatus:    A status word, most likely a BRD_STATUS.
  *  Returns:
  *      DSP_SOK:     All registered clients were asynchronously notified.
- *      DSP_EINVALIDARG:   Invalid hdev_obj.
+ *      EINVAL:   Invalid hdev_obj.
  *  Requires:
  *      DEV Initialized.
  *  Ensures:
diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index 9cc95b1..3ce4c6f 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -90,9 +90,6 @@
 /* A general failure occurred */
 #define DSP_EFAIL                   (DSP_EBASE + 8)

-/* An invalid argument was specified. */
-#define DSP_EINVALIDARG             (DSP_EBASE + 0xb)
-
 /* A memory allocation failure occurred. */
 #define DSP_EMEMORY                 (DSP_EBASE + 0xc)

diff --git a/arch/arm/plat-omap/include/dspbridge/mgr.h b/arch/arm/plat-omap/include/dspbridge/mgr.h
index feb1b61..df20ccc 100644
--- a/arch/arm/plat-omap/include/dspbridge/mgr.h
+++ b/arch/arm/plat-omap/include/dspbridge/mgr.h
@@ -102,7 +102,7 @@ extern dsp_status mgr_destroy(struct mgr_object *hmgr_obj);
  *                          in the database will be returned.
  *  Returns:
  *      DSP_SOK:            Success.
- *      DSP_EINVALIDARG:    Parameter node_id is > than the number of nodes.
+ *      EINVAL:    Parameter node_id is > than the number of nodes.
  *                          configutred in the system
  *      DSP_ECHANGEDURINGENUM:  During Enumeration there has been a change in
  *                              the number of nodes configured or in the
@@ -136,7 +136,7 @@ extern dsp_status mgr_enum_node_info(u32 node_id,
  *                          in the database will be returned
  *  Returns:
  *      DSP_SOK:            Success.
- *      DSP_EINVALIDARG:    Parameter processor_id is > than the number of
+ *      EINVAL:    Parameter processor_id is > than the number of
  *                          DSP Processors in the system.
  *      DSP_EFAIL:          Failed to querry the Node Data Base
  *  Requires:
diff --git a/arch/arm/plat-omap/include/dspbridge/pwr.h b/arch/arm/plat-omap/include/dspbridge/pwr.h
index 1ce54a1..f753833 100644
--- a/arch/arm/plat-omap/include/dspbridge/pwr.h
+++ b/arch/arm/plat-omap/include/dspbridge/pwr.h
@@ -40,7 +40,7 @@
  *  Returns:
  *      DSP_SOK:            Success.
  *      DSP_SALREADYASLEEP: Success, but the DSP was already asleep.
- *      DSP_EINVALIDARG:    The specified sleepCode is not supported.
+ *      EINVAL:    The specified sleepCode is not supported.
  *      DSP_ETIMEOUT:       A timeout occured while waiting for DSP sleep
  *                          confirmation.
  *      DSP_EFAIL:          General failure, unable to send sleep command to
diff --git a/arch/arm/plat-omap/include/dspbridge/sync.h b/arch/arm/plat-omap/include/dspbridge/sync.h
index 30daf3d..e73bda0 100644
--- a/arch/arm/plat-omap/include/dspbridge/sync.h
+++ b/arch/arm/plat-omap/include/dspbridge/sync.h
@@ -186,7 +186,7 @@ extern dsp_status sync_leave_cs(IN struct sync_csobject *hcs_obj);
  *      DSP_SOK:        Success.
  *      DSP_EFAIL:      Unable to create user mode event.
  *      DSP_EMEMORY:    Insufficient memory.
- *      DSP_EINVALIDARG sync_attrs values are invalid.
+ *      EINVAL sync_attrs values are invalid.
  *  Requires:
  *      - SYNC initialized.
  *      - ph_event != NULL.
diff --git a/arch/arm/plat-omap/include/dspbridge/wmd.h b/arch/arm/plat-omap/include/dspbridge/wmd.h
index 500a7a3..6bfc496 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmd.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmd.h
@@ -391,7 +391,7 @@ typedef void (*fxn_deh_notify) (struct deh_mgr *hdeh_mgr,
  *      DSP_SOK:                Success.
  *      EFAULT:            hchnl_mgr is invalid.
  *      DSP_EMEMORY:            Insufficient memory for requested resources.
- *      DSP_EINVALIDARG:        Invalid number of IOReqs.
+ *      EINVAL:        Invalid number of IOReqs.
  *      CHNL_E_OUTOFSTREAMS:    No free channels available.
  *      CHNL_E_BADCHANID:       Channel ID is out of range.
  *      CHNL_E_CHANBUSY:        Channel is in use.
diff --git a/drivers/dsp/bridge/pmgr/chnl.c b/drivers/dsp/bridge/pmgr/chnl.c
index ae87810..252a456 100644
--- a/drivers/dsp/bridge/pmgr/chnl.c
+++ b/drivers/dsp/bridge/pmgr/chnl.c
@@ -72,7 +72,7 @@ dsp_status chnl_create(OUT struct chnl_mgr **phChnlMgr,
            (pMgrAttrs->max_channels <= CHNL_MAXCHANNELS))
                status = DSP_SOK;
        else if (pMgrAttrs->max_channels == 0)
-               status = DSP_EINVALIDARG;
+               status = EINVAL;
        else
                status = CHNL_E_MAXCHANNELS;

diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c
index 089de6e..14a75b3 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -584,7 +584,7 @@ dsp_status cmm_register_gppsm_seg(struct cmm_object *hcmm_mgr,
        /* Check if input ul_size is big enough to alloc at least one block */
        if (DSP_SUCCEEDED(status)) {
                if (ul_size < cmm_mgr_obj->ul_min_block_size) {
-                       status = DSP_EINVALIDARG;
+                       status = EINVAL;
                        goto func_end;
                }
        }
@@ -698,7 +698,7 @@ dsp_status cmm_un_register_gppsm_seg(struct cmm_object *hcmm_mgr,
                                ul_id++;
                        }       /* end while */
                } else {
-                       status = DSP_EINVALIDARG;
+                       status = EINVAL;
                }
        } else {
                status = EFAULT;
diff --git a/drivers/dsp/bridge/pmgr/cod.c b/drivers/dsp/bridge/pmgr/cod.c
index 2b9e0ac..aa759ca 100644
--- a/drivers/dsp/bridge/pmgr/cod.c
+++ b/drivers/dsp/bridge/pmgr/cod.c
@@ -154,7 +154,7 @@ static s32 cod_f_read(void __user *pbuffer, s32 size, s32 cCount,
                return dw_bytes_read / size;
        }

-       return DSP_EINVALIDARG;
+       return EINVAL;
 }

 static s32 cod_f_seek(struct file *filp, s32 lOffset, s32 cOrigin)
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index cd9db42..2046749 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -505,7 +505,7 @@ u32 mgrwrap_register_object(union Trapped_Args *args, void *pr_ctxt)
        }

        if (args->args_mgr_registerobject.obj_type >= DSP_DCDMAXOBJTYPE)
-               return DSP_EINVALIDARG;
+               return EINVAL;

        status = dcd_register_object(&uuid_obj,
                                     args->args_mgr_registerobject.obj_type,
@@ -547,7 +547,7 @@ u32 mgrwrap_wait_for_bridge_events(union Trapped_Args *args, void *pr_ctxt)
        u32 count = args->args_mgr_wait.count;

        if (count > MAX_EVENTS)
-               status = DSP_EINVALIDARG;
+               status = EINVAL;

        /* get the array of pointers to user structures */
        CP_FM_USR(anotifications, args->args_mgr_wait.anotifications,
@@ -688,7 +688,7 @@ u32 procwrap_flush_memory(union Trapped_Args *args, void *pr_ctxt)

        if (args->args_proc_flushmemory.ul_flags >
            PROC_WRITEBACK_INVALIDATE_MEM)
-               return DSP_EINVALIDARG;
+               return EINVAL;

        status = proc_flush_memory(args->args_proc_flushmemory.hprocessor,
                                   args->args_proc_flushmemory.pmpu_addr,
@@ -796,7 +796,7 @@ u32 procwrap_load(union Trapped_Args *args, void *pr_ctxt)
        u8 **argv = NULL, **envp = NULL;

        if (count <= 0 || count > MAX_LOADARGS) {
-               status = DSP_EINVALIDARG;
+               status = EINVAL;
                goto func_cont;
        }

@@ -918,7 +918,7 @@ u32 procwrap_map(union Trapped_Args *args, void *pr_ctxt)
                          args->args_proc_mapmem.ul_map_attr, pr_ctxt);
        if (DSP_SUCCEEDED(status)) {
                if (put_user(map_addr, args->args_proc_mapmem.pp_map_addr)) {
-                       status = DSP_EINVALIDARG;
+                       status = EINVAL;
                        proc_un_map(args->args_proc_mapmem.hprocessor,
                                    map_addr, pr_ctxt);
                }
@@ -966,7 +966,7 @@ u32 procwrap_reserve_memory(union Trapped_Args *args, void *pr_ctxt)
                                     pr_ctxt);
        if (DSP_SUCCEEDED(status)) {
                if (put_user(prsv_addr, args->args_proc_rsvmem.pp_rsv_addr)) {
-                       status = DSP_EINVALIDARG;
+                       status = EINVAL;
                        proc_un_reserve_memory(args->args_proc_rsvmem.
                                               hprocessor, prsv_addr, pr_ctxt);
                }
@@ -1377,7 +1377,7 @@ u32 strmwrap_allocate_buffer(union Trapped_Args *args, void *pr_ctxt)
        u32 num_bufs = args->args_strm_allocatebuffer.num_bufs;

        if (num_bufs > MAX_BUFS)
-               return DSP_EINVALIDARG;
+               return EINVAL;

        ap_buffer = mem_alloc((num_bufs * sizeof(u8 *)), MEM_NONPAGED);

@@ -1416,7 +1416,7 @@ u32 strmwrap_free_buffer(union Trapped_Args *args, void *pr_ctxt)
        u32 num_bufs = args->args_strm_freebuffer.num_bufs;

        if (num_bufs > MAX_BUFS)
-               return DSP_EINVALIDARG;
+               return EINVAL;

        ap_buffer = mem_alloc((num_bufs * sizeof(u8 *)), MEM_NONPAGED);

@@ -1592,7 +1592,7 @@ u32 strmwrap_select(union Trapped_Args *args, void *pr_ctxt)
        dsp_status status = DSP_SOK;

        if (args->args_strm_select.strm_num > MAX_STREAMS)
-               return DSP_EINVALIDARG;
+               return EINVAL;

        CP_FM_USR(strm_tab, args->args_strm_select.stream_tab, status,
                  args->args_strm_select.strm_num);
diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index 72bfe08..1a0d8a0 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -676,7 +676,7 @@ dsp_status dcd_get_library_name(IN struct dcd_manager *hdcd_mgr,
                sprintf(sz_obj_type, "%d", DSP_DCDLIBRARYTYPE);
                break;
        default:
-               status = DSP_EINVALIDARG;
+               status = EINVAL;
                DBC_ASSERT(false);
        }
        if (DSP_SUCCEEDED(status)) {
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index d592181..809a115 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -274,7 +274,7 @@ static int __devinit omap34_xx_bridge_probe(struct platform_device *pdev)
                init_status = reg_set_value(SHMSIZE, (u8 *) &shm_size,
                                            sizeof(shm_size));
        } else {
-               init_status = DSP_EINVALIDARG;
+               init_status = EINVAL;
                status = -1;
                pr_err("%s: shm size must be at least 64 KB\n", __func__);
        }
diff --git a/drivers/dsp/bridge/rmgr/mgr.c b/drivers/dsp/bridge/rmgr/mgr.c
index d02f50c..431ecd9 100644
--- a/drivers/dsp/bridge/rmgr/mgr.c
+++ b/drivers/dsp/bridge/rmgr/mgr.c
@@ -157,7 +157,7 @@ dsp_status mgr_enum_node_info(u32 node_id, OUT struct dsp_ndbprops *pndb_props,
        }
        if (DSP_SUCCEEDED(status)) {
                if (node_id > (node_index - 1)) {
-                       status = DSP_EINVALIDARG;
+                       status = EINVAL;
                } else {
                        status = dcd_get_object_def(pmgr_obj->hdcd_mgr,
                                                    (struct dsp_uuid *)
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 1ac7060..df66ffb 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -422,7 +422,7 @@ dsp_status node_allocate(struct proc_object *hprocessor,
        if (((attr_in->heap_size) & (PG_SIZE4K - 1))) {
                pr_err("%s: node heap size not aligned to 4K, size = 0x%x \n",
                       __func__, attr_in->heap_size);
-               status = DSP_EINVALIDARG;
+               status = EINVAL;
        } else {
                pnode->create_args.asa.task_arg_obj.heap_size =
                    attr_in->heap_size;
diff --git a/drivers/dsp/bridge/rmgr/pwr.c b/drivers/dsp/bridge/rmgr/pwr.c
index 51d8f44..5af6d8f 100644
--- a/drivers/dsp/bridge/rmgr/pwr.c
+++ b/drivers/dsp/bridge/rmgr/pwr.c
@@ -64,9 +64,9 @@ dsp_status pwr_sleep_dsp(IN CONST u32 sleepCode, IN CONST u32 timeout)
                else if (sleepCode == PWR_EMERGENCYDEEPSLEEP)
                        ioctlcode = WMDIOCTL_EMERGENCYSLEEP;
                else
-                       status = DSP_EINVALIDARG;
+                       status = EINVAL;

-               if (status != DSP_EINVALIDARG) {
+               if (status != EINVAL) {
                        status = (*intf_fxns->pfn_dev_cntrl) (dw_context,
                                                              ioctlcode,
                                                              (void *)&arg);
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index d45566d..9ccfee5 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -586,7 +586,7 @@ func_cont:
                         * something documented
                         */
                        if (status != DSP_EMEMORY && status !=
-                           DSP_EINVALIDARG && status != DSP_EFAIL) {
+                           EINVAL && status != DSP_EFAIL) {
                                /*
                                 * We got a status that's not return-able.
                                 * Assert that we got something we were
diff --git a/drivers/dsp/bridge/services/cfg.c b/drivers/dsp/bridge/services/cfg.c
index a878b6c..85b4b26 100644
--- a/drivers/dsp/bridge/services/cfg.c
+++ b/drivers/dsp/bridge/services/cfg.c
@@ -210,7 +210,7 @@ dsp_status cfg_get_host_resources(struct cfg_devnode *dev_node_obj,
  */
 dsp_status cfg_get_object(OUT u32 *pdwValue, u8 dw_type)
 {
-       dsp_status status = DSP_EINVALIDARG;
+       dsp_status status = EINVAL;
        u32 dw_buf_size;
        DBC_REQUIRE(pdwValue != NULL);

@@ -298,7 +298,7 @@ dsp_status cfg_set_dev_object(struct cfg_devnode *dev_node_obj, u32 dwValue)
  */
 dsp_status cfg_set_object(u32 dwValue, u32 dw_type)
 {
-       dsp_status status = DSP_EINVALIDARG;
+       dsp_status status = EINVAL;
        u32 dw_buff_size;

        dw_buff_size = sizeof(dwValue);
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index e6bf700..a9d1c0d 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -499,7 +499,7 @@ dsp_status bridge_chnl_flush_io(struct chnl_object *chnl_obj, u32 dwTimeOut)
        if (MEM_IS_VALID_HANDLE(pchnl, CHNL_SIGNATURE)) {
                if ((dwTimeOut == CHNL_IOCNOWAIT)
                    && CHNL_IS_OUTPUT(pchnl->chnl_mode)) {
-                       status = DSP_EINVALIDARG;
+                       status = EINVAL;
                } else {
                        chnl_mode = pchnl->chnl_mode;
                        chnl_mgr_obj = pchnl->chnl_mgr_obj;
@@ -801,7 +801,7 @@ dsp_status bridge_chnl_open(OUT struct chnl_object **phChnl,
        *phChnl = NULL;
        /* Validate Args: */
        if (pattrs->uio_reqs == 0) {
-               status = DSP_EINVALIDARG;
+               status = EINVAL;
        } else {
                if (!MEM_IS_VALID_HANDLE(hchnl_mgr, CHNL_MGRSIGNATURE)) {
                        status = EFAULT;
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index b9fb61c..de857b0 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -1306,7 +1306,7 @@ static dsp_status bridge_brd_mem_map(struct wmd_dev_context *hDevContext,
                __func__, hDevContext, ul_mpu_addr, ulVirtAddr, ul_num_bytes,
                ul_map_attr);
        if (ul_num_bytes == 0)
-               return DSP_EINVALIDARG;
+               return EINVAL;

        if (ul_map_attr != 0) {
                attrs = ul_map_attr;
@@ -1341,7 +1341,7 @@ static dsp_status bridge_brd_mem_map(struct wmd_dev_context *hDevContext,
                         * Mixedsize isn't enabled, so size can't be
                         * zero here
                         */
-                       return DSP_EINVALIDARG;
+                       return EINVAL;
                }
        }
        if (attrs & DSP_MAPDONOTLOCK)
@@ -1395,7 +1395,7 @@ static dsp_status bridge_brd_mem_map(struct wmd_dev_context *hDevContext,
        if (!vma) {
                pr_err("%s: Failed to get VMA region for 0x%x (%d)\n",
                       __func__, ul_mpu_addr, ul_num_bytes);
-               status = DSP_EINVALIDARG;
+               status = EINVAL;
                up_read(&mm->mmap_sem);
                goto func_cont;
        }
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 37cd470..48dbeae 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -167,7 +167,7 @@ dsp_status sleep_dsp(struct wmd_dev_context *dev_context, IN u32 dw_cmd,

        /* Check if sleep code is valid */
        if ((dw_cmd != PWR_DEEPSLEEP) && (dw_cmd != PWR_EMERGENCYDEEPSLEEP))
-               return DSP_EINVALIDARG;
+               return EINVAL;

        status = cfg_get_host_resources((struct cfg_devnode *)
                                        drv_get_first_dev_extension(),
--
1.6.0.4

