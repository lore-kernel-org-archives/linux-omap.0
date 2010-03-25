From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC][PATCH 4/19] DSPBRIDGE: Cleanup custom error code (DSP_EHANDLE
 -> EFAULT)
Date: Fri, 26 Mar 2010 01:36:23 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DEBEB20@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50104 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754667Ab0CYUGc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 16:06:32 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2PK6S7k011284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 25 Mar 2010 15:06:30 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o2PK6RoS027587
	for <linux-omap@vger.kernel.org>; Fri, 26 Mar 2010 01:36:27 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 9aa080c6aa716f835396d2b3654fb95594e1f02b Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Tue, 23 Mar 2010 10:33:17 -0600
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code (DSP_EHANDLE -> EFAULT)

This patch replaces DSP_EHANDLE with EFAULT.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/chnl.h     |    6 ++--
 arch/arm/plat-omap/include/dspbridge/cmm.h      |   16 ++++----
 arch/arm/plat-omap/include/dspbridge/dbdcd.h    |   10 +++---
 arch/arm/plat-omap/include/dspbridge/dev.h      |   30 ++++++++--------
 arch/arm/plat-omap/include/dspbridge/errbase.h  |    3 --
 arch/arm/plat-omap/include/dspbridge/io.h       |    4 +-
 arch/arm/plat-omap/include/dspbridge/node.h     |   28 +++++++-------
 arch/arm/plat-omap/include/dspbridge/nodepriv.h |    4 +-
 arch/arm/plat-omap/include/dspbridge/ntfy.h     |    2 +-
 arch/arm/plat-omap/include/dspbridge/proc.h     |   40 ++++++++++----------
 arch/arm/plat-omap/include/dspbridge/strm.h     |   26 +++++++-------
 arch/arm/plat-omap/include/dspbridge/sync.h     |   16 ++++----
 arch/arm/plat-omap/include/dspbridge/wmd.h      |   22 ++++++------
 drivers/dsp/bridge/pmgr/chnl.c                  |    2 +-
 drivers/dsp/bridge/pmgr/cmm.c                   |   14 ++++----
 drivers/dsp/bridge/pmgr/cod.c                   |    8 ++--
 drivers/dsp/bridge/pmgr/dbll.c                  |    4 +-
 drivers/dsp/bridge/pmgr/dev.c                   |   28 +++++++-------
 drivers/dsp/bridge/pmgr/dmm.c                   |    4 +-
 drivers/dsp/bridge/rmgr/dbdcd.c                 |   10 +++---
 drivers/dsp/bridge/rmgr/drv.c                   |    4 +-
 drivers/dsp/bridge/rmgr/nldr.c                  |    2 +-
 drivers/dsp/bridge/rmgr/node.c                  |   44 +++++++++++-----------
 drivers/dsp/bridge/rmgr/proc.c                  |   38 ++++++++++----------
 drivers/dsp/bridge/rmgr/strm.c                  |   30 ++++++++--------
 drivers/dsp/bridge/services/ntfy.c              |    2 +-
 drivers/dsp/bridge/services/sync.c              |   14 ++++----
 drivers/dsp/bridge/wmd/chnl_sm.c                |   22 ++++++------
 drivers/dsp/bridge/wmd/io_sm.c                  |   10 +++---
 drivers/dsp/bridge/wmd/msg_sm.c                 |    6 ++--
 drivers/dsp/bridge/wmd/tiomap3430.c             |    2 +-
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c         |    2 +-
 drivers/dsp/bridge/wmd/ue_deh.c                 |    2 +-
 33 files changed, 226 insertions(+), 229 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/chnl.h b/arch/arm/plat-omap/include/dspbridge/chnl.h
index da9115b..e70c90f 100644
--- a/arch/arm/plat-omap/include/dspbridge/chnl.h
+++ b/arch/arm/plat-omap/include/dspbridge/chnl.h
@@ -35,7 +35,7 @@
  *      chnl_obj:          Channel object handle.
  *  Returns:
  *      DSP_SOK:        Success;
- *      DSP_EHANDLE:    Invalid chnl_obj.
+ *      EFAULT:    Invalid chnl_obj.
  *  Requires:
  *      chnl_init(void) called.
  *      No thread must be blocked on this channel's I/O completion event.
@@ -60,7 +60,7 @@ extern dsp_status chnl_close(struct chnl_object *chnl_obj);
  *      pMgrAttrs->word_size:   DSP Word size in equivalent PC bytes..
  *  Returns:
  *      DSP_SOK:                Success;
- *      DSP_EHANDLE:            hdev_obj is invalid.
+ *      EFAULT:            hdev_obj is invalid.
  *      DSP_EINVALIDARG:        max_channels is 0.
  *      DSP_EMEMORY:            Insufficient memory for requested resources.
  *      CHNL_E_ISR:             Unable to plug channel ISR for configured IRQ.
@@ -90,7 +90,7 @@ extern dsp_status chnl_create(OUT struct chnl_mgr **phChnlMgr,
  *      hchnl_mgr:           Channel manager object.
  *  Returns:
  *      DSP_SOK:            Success.
- *      DSP_EHANDLE:        hchnl_mgr was invalid.
+ *      EFAULT:        hchnl_mgr was invalid.
  *  Requires:
  *      chnl_init(void) called.
  *  Ensures:
diff --git a/arch/arm/plat-omap/include/dspbridge/cmm.h b/arch/arm/plat-omap/include/dspbridge/cmm.h
index 797323a..bc60035 100644
--- a/arch/arm/plat-omap/include/dspbridge/cmm.h
+++ b/arch/arm/plat-omap/include/dspbridge/cmm.h
@@ -101,7 +101,7 @@ extern dsp_status cmm_create(OUT struct cmm_object **ph_cmm_mgr,
  *  Returns:
  *      DSP_SOK:        CMM object & resources deleted.
  *      DSP_EFAIL:      Unable to free CMM object due to outstanding allocation.
- *      DSP_EHANDLE:    Unable to free CMM due to bad handle.
+ *      EFAULT:    Unable to free CMM due to bad handle.
  *  Requires:
  *      CMM is initialized.
  *      hcmm_mgr != NULL.
@@ -156,7 +156,7 @@ extern dsp_status cmm_free_buf(struct cmm_object *hcmm_mgr,
  *
  *  Returns:
  *      DSP_SOK:        Cmm Mgr opaque handle returned.
- *      DSP_EHANDLE:    Invalid handle.
+ *      EFAULT:    Invalid handle.
  *  Requires:
  *      ph_cmm_mgr != NULL
  *      hdev_obj != NULL
@@ -175,7 +175,7 @@ extern dsp_status cmm_get_handle(void *hprocessor,
  *
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid handle.
+ *      EFAULT:    Invalid handle.
  *      DSP_EINVALIDARG Invalid input argument.
  *  Requires:
  *  Ensures:
@@ -213,7 +213,7 @@ extern bool cmm_init(void);
  *
  *  Returns:
  *      DSP_SOK:         Success.
- *      DSP_EHANDLE:     Invalid hcmm_mgr handle.
+ *      EFAULT:     Invalid hcmm_mgr handle.
  *      DSP_EINVALIDARG: Invalid input argument.
  *      DSP_EFAIL:       Unable to register.
  *      - On success *pulSegId is a valid SM segment ID.
@@ -244,7 +244,7 @@ extern dsp_status cmm_register_gppsm_seg(struct cmm_object *hcmm_mgr,
  *      ul_seg_id     Segment identifier returned by cmm_register_gppsm_seg.
  *  Returns:
  *       DSP_SOK:         Success.
- *       DSP_EHANDLE:     Invalid handle.
+ *       EFAULT:     Invalid handle.
  *       DSP_EINVALIDARG: Invalid ul_seg_id.
  *       DSP_EFAIL:       Unable to unregister for unknown reason.
  *  Requires:
@@ -308,7 +308,7 @@ extern dsp_status cmm_xlator_create(OUT struct cmm_xlatorobject **phXlator,
  *      bForce:     bForce = TRUE will free XLators SM buffers/dscriptrs.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Bad translator handle.
+ *      EFAULT:    Bad translator handle.
  *      DSP_EFAIL:      Unable to free translator resources.
  *  Requires:
  *      refs > 0
@@ -328,7 +328,7 @@ extern dsp_status cmm_xlator_delete(struct cmm_xlatorobject *xlator,
  *      pBufVa      Virtual address of PA to free.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Bad translator handle.
+ *      EFAULT:    Bad translator handle.
  *  Requires:
  *  Ensures:
  *
@@ -350,7 +350,7 @@ extern dsp_status cmm_xlator_free_buf(struct cmm_xlatorobject *xlator,
  *     set_info     Set xlator fields if TRUE, else return base addr
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Bad translator handle.
+ *      EFAULT:    Bad translator handle.
  *  Requires:
  *      (refs > 0)
  *      (paddr != NULL)
diff --git a/arch/arm/plat-omap/include/dspbridge/dbdcd.h b/arch/arm/plat-omap/include/dspbridge/dbdcd.h
index c782c8d..1de9d18 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbdcd.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdcd.h
@@ -37,7 +37,7 @@
  *      DSP_EDCDNOAUTOREGISTER: Unable to find auto-registration section.
  *      DSP_EDCDREADSECT:       Unable to read object code section.
  *      DSP_EDCDLOADBASE:       Unable to load code base.
- *      DSP_EHANDLE:            Invalid DCD_HMANAGER handle..
+ *      EFAULT:            Invalid DCD_HMANAGER handle..
  *  Requires:
  *      DCD initialized.
  *  Ensures:
@@ -63,7 +63,7 @@ extern dsp_status dcd_auto_register(IN struct dcd_manager *hdcd_mgr,
  *      DSP_EDCDNOAUTOREGISTER: Unable to find auto-registration section.
  *      DSP_EDCDREADSECT:       Unable to read object code section.
  *      DSP_EDCDLOADBASE:       Unable to load code base.
- *      DSP_EHANDLE:            Invalid DCD_HMANAGER handle..
+ *      EFAULT:            Invalid DCD_HMANAGER handle..
  *  Requires:
  *      DCD initialized.
  *  Ensures:
@@ -104,7 +104,7 @@ extern dsp_status dcd_create_manager(IN char *pszZlDllName,
  *      hdcd_mgr:        A DCD manager handle.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid DCD manager handle.
+ *      EFAULT:    Invalid DCD manager handle.
  *  Requires:
  *      DCD initialized.
  *  Ensures:
@@ -260,7 +260,7 @@ extern dsp_status dcd_get_library_name(IN struct dcd_manager *hdcd_mgr,
  *      DSP_EDCDGETSECT:    Unable to access object code section.
  *      DSP_EDCDLOADBASE:   Unable to load code base.
  *      DSP_EFAIL:          General failure.
- *      DSP_EHANDLE:        Invalid DCD_HMANAGER handle.
+ *      EFAULT:        Invalid DCD_HMANAGER handle.
  *  Requires:
  *      DCD initialized.
  *      pObjUuid is non-NULL.
@@ -292,7 +292,7 @@ extern dsp_status dcd_get_object_def(IN struct dcd_manager *hdcd_mgr,
  *      DSP_EDCDNOAUTOREGISTER: Unable to find .dcd_register section.
  *      DSP_EDCDREADSECT:       Unable to read object code section.
  *      DSP_EDCDLOADBASE:       Unable to load code base.
- *      DSP_EHANDLE:            Invalid DCD_HMANAGER handle..
+ *      EFAULT:            Invalid DCD_HMANAGER handle..
  *  Requires:
  *      DCD initialized.
  *  Ensures:
diff --git a/arch/arm/plat-omap/include/dspbridge/dev.h b/arch/arm/plat-omap/include/dspbridge/dev.h
index 417af59..fdf15dc 100644
--- a/arch/arm/plat-omap/include/dspbridge/dev.h
+++ b/arch/arm/plat-omap/include/dspbridge/dev.h
@@ -197,7 +197,7 @@ extern dsp_status dev_destroy2(IN struct dev_object *hdev_obj);
  *                      dev_create_device().
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid hdev_obj.
+ *      EFAULT:    Invalid hdev_obj.
  *      DSP_EFAIL:      The WMD failed it's bridge_dev_destroy() function.
  *  Requires:
  *      DEV Initialized.
@@ -216,7 +216,7 @@ extern dsp_status dev_destroy_device(struct dev_object
  *      *phMgr:         Ptr to location to store handle.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid hdev_obj.
+ *      EFAULT:    Invalid hdev_obj.
  *  Requires:
  *      phMgr != NULL.
  *      DEV Initialized.
@@ -239,7 +239,7 @@ extern dsp_status dev_get_chnl_mgr(struct dev_object *hdev_obj,
  *      *phMgr:         Ptr to location to store handle.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid hdev_obj.
+ *      EFAULT:    Invalid hdev_obj.
  *  Requires:
  *      phMgr != NULL.
  *      DEV Initialized.
@@ -262,7 +262,7 @@ extern dsp_status dev_get_cmm_mgr(struct dev_object *hdev_obj,
  *      *phMgr:         Ptr to location to store handle.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid hdev_obj.
+ *      EFAULT:    Invalid hdev_obj.
  *  Requires:
  *      phMgr != NULL.
  *      DEV Initialized.
@@ -284,7 +284,7 @@ extern dsp_status dev_get_dmm_mgr(struct dev_object *hdev_obj,
  *      *phCodMgr:      Ptr to location to store handle.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid hdev_obj.
+ *      EFAULT:    Invalid hdev_obj.
  *  Requires:
  *      phCodMgr != NULL.
  *      DEV Initialized.
@@ -304,7 +304,7 @@ extern dsp_status dev_get_cod_mgr(struct dev_object *hdev_obj,
  *      *phDehMgr:  Ptr to location to store handle.
  *  Returns:
  *      DSP_SOK:    Success.
- *      DSP_EHANDLE:   Invalid hdev_obj.
+ *      EFAULT:   Invalid hdev_obj.
  *  Requires:
  *      phDehMgr != NULL.
  *      DEH Initialized.
@@ -325,7 +325,7 @@ extern dsp_status dev_get_deh_mgr(struct dev_object *hdev_obj,
  *      phDevNode:      Ptr to location to get the device node handle.
  *  Returns:
  *      DSP_SOK:        In Win95, returns a DEVNODE in *dev_node_obj; In NT, ???
- *      DSP_EHANDLE:    Invalid hdev_obj.
+ *      EFAULT:    Invalid hdev_obj.
  *  Requires:
  *      phDevNode != NULL.
  *      DEV Initialized.
@@ -346,7 +346,7 @@ extern dsp_status dev_get_dev_node(struct dev_object *hdev_obj,
  *      phDevNode:      Ptr to location to get the device node handle.
  *  Returns:
  *      DSP_SOK:        Success
- *      DSP_EHANDLE:    Invalid hdev_obj.
+ *      EFAULT:    Invalid hdev_obj.
  *  Requires:
  *      phDevNode != NULL.
  *      DEV Initialized.
@@ -387,7 +387,7 @@ extern struct dev_object *dev_get_first(void);
  *      *ppIntfFxns:    Ptr to location to store fxn interface.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid hdev_obj.
+ *      EFAULT:    Invalid hdev_obj.
  *  Requires:
  *      ppIntfFxns != NULL.
  *      DEV Initialized.
@@ -408,7 +408,7 @@ extern dsp_status dev_get_intf_fxns(struct dev_object *hdev_obj,
  *      *phMgr:         Ptr to location to store handle.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid hdev_obj.
+ *      EFAULT:    Invalid hdev_obj.
  *  Requires:
  *      phMgr != NULL.
  *      DEV Initialized.
@@ -472,7 +472,7 @@ extern void dev_get_msg_mgr(struct dev_object *hdev_obj,
  *                      returned..
  *  Returns:
  *      DSP_SOK:        Success
- *      DSP_EHANDLE:    Invalid Dev Object handle.
+ *      EFAULT:    Invalid Dev Object handle.
  *  Requires:
  *      DEV Initialized.
  *      phNodeMgr is not null
@@ -495,7 +495,7 @@ extern dsp_status dev_get_node_manager(struct dev_object
  *      pul_value:       Ptr to symbol value.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid hdev_obj.
+ *      EFAULT:    Invalid hdev_obj.
  *      COD_E_NOSYMBOLSLOADED:  Symbols have not been loaded onto the board.
  *      COD_E_SYMBOLNOTFOUND:   The symbol could not be found.
  *  Requires:
@@ -517,7 +517,7 @@ extern dsp_status dev_get_symbol(struct dev_object *hdev_obj,
  *      *phWmdContext:  Ptr to location to store context handle.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid hdev_obj.
+ *      EFAULT:    Invalid hdev_obj.
  *  Requires:
  *      phWmdContext != NULL.
  *      DEV Initialized.
@@ -567,7 +567,7 @@ extern bool dev_init(void);
  *  Returns:
  *      DSP_SOK:        TRUE: device has been locked.
  *      DSP_SFALSE:     FALSE: device not locked.
- *      DSP_EHANDLE:    hdev_obj was invalid.
+ *      EFAULT:    hdev_obj was invalid.
  *  Requires:
  *      DEV Initialized.
  *  Ensures:
@@ -674,7 +674,7 @@ extern dsp_status dev_remove_device(struct cfg_devnode *dev_node_obj);
  *      hmgr:           Handle to a channel manager, or NULL.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid hdev_obj.
+ *      EFAULT:    Invalid hdev_obj.
  *  Requires:
  *      DEV Initialized.
  *  Ensures:
diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index 30d13f9..9cc95b1 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -90,9 +90,6 @@
 /* A general failure occurred */
 #define DSP_EFAIL                   (DSP_EBASE + 8)

-/* The specified handle is invalid. */
-#define DSP_EHANDLE                 (DSP_EBASE + 0xa)
-
 /* An invalid argument was specified. */
 #define DSP_EINVALIDARG             (DSP_EBASE + 0xb)

diff --git a/arch/arm/plat-omap/include/dspbridge/io.h b/arch/arm/plat-omap/include/dspbridge/io.h
index 6b51274..a1a4e64 100644
--- a/arch/arm/plat-omap/include/dspbridge/io.h
+++ b/arch/arm/plat-omap/include/dspbridge/io.h
@@ -62,7 +62,7 @@ extern dsp_status io_create(OUT struct io_mgr **phIOMgr,
  *      hio_mgr:         IOmanager object.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    hio_mgr was invalid.
+ *      EFAULT:    hio_mgr was invalid.
  *  Requires:
  *      io_init(void) called.
  *  Ensures:
@@ -105,7 +105,7 @@ extern bool io_init(void);
  *      hio_mgr:         IOmanager object.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    hio_mgr was invalid.
+ *      EFAULT:    hio_mgr was invalid.
  *  Requires:
  *      io_init(void) called.
  *  Ensures:
diff --git a/arch/arm/plat-omap/include/dspbridge/node.h b/arch/arm/plat-omap/include/dspbridge/node.h
index ec0dcf3..4e94151 100644
--- a/arch/arm/plat-omap/include/dspbridge/node.h
+++ b/arch/arm/plat-omap/include/dspbridge/node.h
@@ -76,7 +76,7 @@ extern dsp_status node_allocate(struct proc_object *hprocessor,
  *                      buffer on output.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid node handle.
+ *      EFAULT:    Invalid node handle.
  *      DSP_EMEMORY:    Insufficent memory.
  *      DSP_EFAIL:      General Failure.
  *      DSP_ESIZE:      Invalid Size.
@@ -98,7 +98,7 @@ extern dsp_status node_alloc_msg_buf(struct node_object *hnode,
  *      prio:          New priority level to set node's priority to.
  *  Returns:
  *      DSP_SOK:            Success.
- *      DSP_EHANDLE:        Invalid hnode.
+ *      EFAULT:        Invalid hnode.
  *      DSP_ERANGE:         prio is out of range.
  *      DSP_ENODETYPE:      The specified node is not a task node.
  *      DSP_EWRONGSTATE:    Node is not in the NODE_ALLOCATED, NODE_PAUSED,
@@ -165,7 +165,7 @@ extern dsp_status node_close_orphans(struct node_mgr *hnode_mgr,
  *                      pass binary data.
  *  Returns:
  *      DSP_SOK:                Success.
- *      DSP_EHANDLE:            Invalid hNode1 or hNode2.
+ *      EFAULT:            Invalid hNode1 or hNode2.
  *      DSP_EMEMORY:            Insufficient host memory.
  *      DSP_EVALUE:             A stream index parameter is invalid.
  *      DSP_EALREADYCONNECTED:  A connection already exists for one of the
@@ -198,7 +198,7 @@ extern dsp_status node_connect(struct node_object *hNode1,
  *      hnode:              Node handle returned from node_allocate().
  *  Returns:
  *      DSP_SOK:            Success.
- *      DSP_EHANDLE:        Invalid hnode.
+ *      EFAULT:        Invalid hnode.
  *      DSP_ESYMBOL:        Create function not found in the COFF file.
  *      DSP_EWRONGSTATE:    Node is not in the NODE_ALLOCATED state.
  *      DSP_EMEMORY:        Memory allocation failure on the DSP.
@@ -250,7 +250,7 @@ extern dsp_status node_create_mgr(OUT struct node_mgr **phNodeMgr,
  *      hnode:              Node handle returned from node_allocate().
  *  Returns:
  *      DSP_SOK:            Success.
- *      DSP_EHANDLE:        Invalid hnode.
+ *      EFAULT:        Invalid hnode.
  *      DSP_ETIMEOUT:       A timeout occurred before the DSP responded.
  *      DSP_EDELETE:        A deletion failure occurred.
  *      DSP_EUSER1-16:      Node specific failure occurred on the DSP.
@@ -333,7 +333,7 @@ extern void node_exit(void);
  *      pattr:          Same buffer attributes passed to node_alloc_msg_buf.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid node handle.
+ *      EFAULT:    Invalid node handle.
  *      DSP_EFAIL:      Failure to free the buffer.
  *  Requires:
  *      node_init(void) called.
@@ -357,7 +357,7 @@ extern dsp_status node_free_msg_buf(struct node_object *hnode,
  *      attr_size:      Size of pattr.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid hnode.
+ *      EFAULT:    Invalid hnode.
  *  Requires:
  *      node_init(void) called.
  *      pattr != NULL.
@@ -381,7 +381,7 @@ extern dsp_status node_get_attr(struct node_object *hnode,
  *      utimeout:       Timeout in milliseconds to wait for message.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid hnode.
+ *      EFAULT:    Invalid hnode.
  *      DSP_ENODETYPE:  Cannot retrieve messages from this type of node.
  *      DSP_ETIMEOUT:   Timeout occurred and no message is available.
  *      DSP_EFAIL:      Error occurred while trying to retrieve a message.
@@ -402,7 +402,7 @@ extern dsp_status node_get_message(struct node_object *hnode,
  *      phNldrObj:      Pointer to a Nldr manager handle
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid hnode.
+ *      EFAULT:    Invalid hnode.
  *  Ensures:
  */
 extern dsp_status node_get_nldr_obj(struct node_mgr *hnode_mgr,
@@ -442,7 +442,7 @@ void node_on_exit(struct node_object *hnode, s32 nStatus);
  *                          running on the DSP.
  *  Returns:
  *      DSP_SOK:            Success.
- *      DSP_EHANDLE:        Invalid hnode.
+ *      EFAULT:        Invalid hnode.
  *      DSP_ENODETYPE:      Node is not a task or socket node.
  *      DSP_ETIMEOUT:       A timeout occurred before the DSP responded.
  *      DSP_EWRONGSTSATE:   Node is not in NODE_RUNNING state.
@@ -466,7 +466,7 @@ extern dsp_status node_pause(struct node_object *hnode);
  *      utimeout:           Timeout in msecs to wait.
  *  Returns:
  *      DSP_SOK:            Success.
- *      DSP_EHANDLE:        Invalid hnode.
+ *      EFAULT:        Invalid hnode.
  *      DSP_ENODETYPE:      Messages can't be sent to this type of node.
  *      DSP_ETIMEOUT:       Timeout occurred before message could be set.
  *      DSP_EWRONGSTATE:    Node is in invalid state for sending messages.
@@ -490,7 +490,7 @@ extern dsp_status node_put_message(struct node_object *hnode,
  *      hnotification:  Handle to be used for notification.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid hnode.
+ *      EFAULT:    Invalid hnode.
  *      DSP_EMEMORY:    Insufficient memory on GPP.
  *      DSP_EVALUE:     event_mask is invalid.
  *      DSP_ENOTIMPL:   Notification type specified by notify_type is not
@@ -516,7 +516,7 @@ extern dsp_status node_register_notify(struct node_object *hnode,
  *                          running on the DSP.
  *  Returns:
  *      DSP_SOK:            Success.
- *      DSP_EHANDLE:        Invalid hnode.
+ *      EFAULT:        Invalid hnode.
  *      DSP_ENODETYPE:      hnode doesn't represent a message, task or dais
  *                          socket node.
  *      DSP_ETIMEOUT:       A timeout occurred before the DSP responded.
@@ -541,7 +541,7 @@ extern dsp_status node_run(struct node_object *hnode);
  *                          value (DSP_EUSER1-16).
  *  Returns:
  *      DSP_SOK:            Success.
- *      DSP_EHANDLE:        Invalid hnode.
+ *      EFAULT:        Invalid hnode.
  *      DSP_ETIMEOUT:       A timeout occurred before the DSP responded.
  *      DSP_ENODETYPE:      Type of node specified cannot be terminated.
  *      DSP_EWRONGSTATE:    Operation not valid for the current node state.
diff --git a/arch/arm/plat-omap/include/dspbridge/nodepriv.h b/arch/arm/plat-omap/include/dspbridge/nodepriv.h
index ca3c696..a0108e9 100644
--- a/arch/arm/plat-omap/include/dspbridge/nodepriv.h
+++ b/arch/arm/plat-omap/include/dspbridge/nodepriv.h
@@ -91,7 +91,7 @@ struct node_createargs {
  *      pulId:          Location to store channel index.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid hnode.
+ *      EFAULT:    Invalid hnode.
  *      DSP_ENODETYPE:  Not a task or DAIS socket node.
  *      DSP_EVALUE:     The node's stream corresponding to index and dir
  *                      is not a stream to or from the host.
@@ -113,7 +113,7 @@ extern dsp_status node_get_channel_id(struct node_object *hnode,
  *      phStrmMgr:      Location to store STRM manager on output.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid hnode.
+ *      EFAULT:    Invalid hnode.
  *  Requires:
  *      phStrmMgr != NULL.
  *  Ensures:
diff --git a/arch/arm/plat-omap/include/dspbridge/ntfy.h b/arch/arm/plat-omap/include/dspbridge/ntfy.h
index 11fa4b6..ab1011c 100644
--- a/arch/arm/plat-omap/include/dspbridge/ntfy.h
+++ b/arch/arm/plat-omap/include/dspbridge/ntfy.h
@@ -109,7 +109,7 @@ extern void ntfy_notify(IN struct ntfy_object *ntfy_obj, IN u32 event_mask);
  *      DSP_EMEMORY:        Insufficient memory.
  *      DSP_EVALUE:         event_mask is 0 and hnotification was not
  *                          previously registered.
- *      DSP_EHANDLE:        NULL hnotification, hnotification event name
+ *      EFAULT:        NULL hnotification, hnotification event name
  *                          too long, or hnotification event name NULL.
  *  Requires:
  *      ntfy_init(void) called.
diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/plat-omap/include/dspbridge/proc.h
index 0707739..ddb3aec 100644
--- a/arch/arm/plat-omap/include/dspbridge/proc.h
+++ b/arch/arm/plat-omap/include/dspbridge/proc.h
@@ -37,7 +37,7 @@
  *  Returns:
  *      DSP_SOK     :     Success.
  *      DSP_EFAIL   :     General failure.
- *      DSP_EHANDLE :     Invalid processor handle.
+ *      EFAULT :          Invalid processor handle.
  *      DSP_SALREADYATTACHED:   Success; Processor already attached.
  *  Requires:
  *      ph_processor != NULL.
@@ -86,7 +86,7 @@ extern dsp_status proc_auto_start(struct cfg_devnode *dev_node_obj,
  *      pargs       :       Ptr to an driver defined argument structure.
  *  Returns:
  *      DSP_SOK     :       SUCCESS
- *      DSP_EHANDLE :       Invalid processor handle.
+ *      EFAULT :       Invalid processor handle.
  *      DSP_ETIMEOUT:       A Timeout Occured before the Control information
  *                       could be sent.
  *      DSP_EACCESSDENIED:  Client does not have the access rights required
@@ -112,7 +112,7 @@ extern dsp_status proc_ctrl(void *hprocessor,
  *      pr_ctxt     :   The processor handle.
  *  Returns:
  *      DSP_SOK     :   Success.
- *      DSP_EHANDLE :   InValid Handle.
+ *      EFAULT :   InValid Handle.
  *      DSP_EFAIL   :   General failure.
  *  Requires:
  *      PROC Initialized.
@@ -137,7 +137,7 @@ extern dsp_status proc_detach(struct process_context *pr_ctxt);
  *                   the number of nodes that are allocated on the DSP.
  *  Returns:
  *      DSP_SOK     :   Success.
- *      DSP_EHANDLE :   Invalid processor handle.
+ *      EFAULT :   Invalid processor handle.
  *      DSP_ESIZE   :   The amount of memory allocated for node_tab is
  *                   insufficent. That is the number of nodes actually
  *                   allocated on the DSP is greater than the value
@@ -169,7 +169,7 @@ extern dsp_status proc_enum_nodes(void *hprocessor,
  *      resource_info_size:  Size of the structure.
  *  Returns:
  *      DSP_SOK     :       Success.
- *      DSP_EHANDLE :       Invalid processor handle.
+ *      EFAULT :       Invalid processor handle.
  *      DSP_EWRONGSTATE:    The processor is not in the PROC_RUNNING state.
  *      DSP_ETIMEOUT:       A timeout occured before the DSP responded to the
  *                       querry.
@@ -251,7 +251,7 @@ extern bool proc_init(void);
  *      state_info_size: Size of dsp_processorstate.
  *  Returns:
  *      DSP_SOK     :   Success.
- *      DSP_EHANDLE :   Invalid processor handle.
+ *      EFAULT :   Invalid processor handle.
  *      DSP_EFAIL   :   General failure while querying processor state.
  *  Requires:
  *      proc_state_obj is not NULL
@@ -273,7 +273,7 @@ extern dsp_status proc_get_state(void *hprocessor, OUT struct dsp_processorstate
  *
  *  Returns:
  *      DSP_SOK     :   Success.
- *      DSP_EHANDLE :   Invalid processor handle.
+ *      EFAULT :   Invalid processor handle.
  *      DSP_EFAIL   :   General failure while querying processor state.
  *  Requires:
  *      proc_state_obj is not NULL
@@ -294,7 +294,7 @@ extern dsp_status proc_get_processor_id(void *hprocessor, u32 * procID);
  *      max_size    :   Maximum size of the output buffer.
  *  Returns:
  *      DSP_SOK     :   Success.
- *      DSP_EHANDLE :   Invalid processor handle.
+ *      EFAULT :   Invalid processor handle.
  *      DSP_EFAIL   :   General failure while retireving processor trace
  *                   Buffer.
  *  Requires:
@@ -319,7 +319,7 @@ extern dsp_status proc_get_trace(void *hprocessor, u8 * pbuf, u32 max_size);
  *  Returns:
  *      DSP_SOK:       Success.
  *      DSP_EFILE:       The DSP Execuetable was not found.
- *      DSP_EHANDLE:       Invalid processor handle.
+ *      EFAULT:       Invalid processor handle.
  *      DSP_ECORRUTFILE:    Unable to Parse the DSP Execuetable
  *      DSP_EATTACHED:      Abort because a GPP Client is attached to the
  *                       specified Processor
@@ -352,7 +352,7 @@ extern dsp_status proc_load(void *hprocessor,
  *      hnotification:  Handle to be used for notification.
  *  Returns:
  *      DSP_SOK     :   Success.
- *      DSP_EHANDLE :   Invalid processor handle or hnotification.
+ *      EFAULT :   Invalid processor handle or hnotification.
  *      DSP_EVALUE  :   Parameter event_mask is Invalid
  *      DSP_ENOTIMP :   The notification type specified in uNotifyMask
  *                   is not supported.
@@ -377,7 +377,7 @@ extern dsp_status proc_register_notify(void *hprocessor,
  *      uEvents     :   Event to be notified about.
  *  Returns:
  *      DSP_SOK     :   Success.
- *      DSP_EHANDLE :   Invalid processor handle.
+ *      EFAULT :   Invalid processor handle.
  *      DSP_EFAIL   :   Failure to Set or Reset the Event
  *  Requires:
  *      uEvents is Supported or Valid type of Event
@@ -396,7 +396,7 @@ extern dsp_status proc_notify_clients(void *hProc, u32 uEvents);
  *      uEvents     :   Event to be notified about.
  *  Returns:
  *      DSP_SOK     :   Success.
- *      DSP_EHANDLE :   Invalid processor handle.
+ *      EFAULT :   Invalid processor handle.
  *      DSP_EFAIL   :   Failure to Set or Reset the Event
  *  Requires:
  *      uEvents is Supported or Valid type of Event
@@ -420,7 +420,7 @@ extern dsp_status proc_notify_all_clients(void *hProc, u32 uEvents);
  *      hprocessor  :       The processor handle.
  *  Returns:
  *      DSP_SOK     :       Success.
- *      DSP_EHANDLE :       Invalid processor handle.
+ *      EFAULT :       Invalid processor handle.
  *      DSP_EWRONGSTATE:    Processor is not in PROC_LOADED state.
  *      DSP_EFAIL   :       Unable to start the processor.
  *  Requires:
@@ -442,7 +442,7 @@ extern dsp_status proc_start(void *hprocessor);
  *      hprocessor  :       The processor handle.
  *  Returns:
  *      DSP_SOK     :       Success.
- *      DSP_EHANDLE :       Invalid processor handle.
+ *      EFAULT :       Invalid processor handle.
  *      DSP_EWRONGSTATE:    Processor is not in PROC_LOADED state.
  *      DSP_EFAIL   :       Unable to start the processor.
  *  Requires:
@@ -464,7 +464,7 @@ extern dsp_status proc_stop(void *hprocessor);
  *      ul_flags        :   Reserved.
  *  Returns:
  *      DSP_SOK         :   Success.
- *      DSP_EHANDLE     :   Invalid processor handle.
+ *      EFAULT     :   Invalid processor handle.
  *      DSP_EFAIL       :   General failure.
  *  Requires:
  *      PROC Initialized.
@@ -485,7 +485,7 @@ extern dsp_status proc_flush_memory(void *hprocessor,
  *      ul_size          :   Buffer size
  *  Returns:
  *      DSP_SOK         :   Success.
- *      DSP_EHANDLE     :   Invalid processor handle.
+ *      EFAULT     :   Invalid processor handle.
  *      DSP_EFAIL       :   General failure.
  *  Requires:
  *      PROC Initialized.
@@ -510,7 +510,7 @@ extern dsp_status proc_invalidate_memory(void *hprocessor,
  *      ul_map_attr       :   Optional endianness attributes, virt to phys flag.
  *  Returns:
  *      DSP_SOK         :   Success.
- *      DSP_EHANDLE     :   Invalid processor handle.
+ *      EFAULT     :   Invalid processor handle.
  *      DSP_EFAIL       :   General failure.
  *      DSP_EMEMORY     :   MPU side memory allocation error.
  *      DSP_ENOTFOUND   :   Cannot find a reserved region starting with this
@@ -540,7 +540,7 @@ extern dsp_status proc_map(void *hprocessor,
  *      pp_rsv_addr       :   Ptr to DSP side reserved u8 address.
  *  Returns:
  *      DSP_SOK         :   Success.
- *      DSP_EHANDLE     :   Invalid processor handle.
+ *      EFAULT     :   Invalid processor handle.
  *      DSP_EFAIL       :   General failure.
  *      DSP_EMEMORY     :   Cannot reserve chunk of this size.
  *  Requires:
@@ -562,7 +562,7 @@ extern dsp_status proc_reserve_memory(void *hprocessor,
  *      map_addr       :   Starting address of the mapped memory region.
  *  Returns:
  *      DSP_SOK         :   Success.
- *      DSP_EHANDLE     :   Invalid processor handle.
+ *      EFAULT     :   Invalid processor handle.
  *      DSP_EFAIL       :   General failure.
  *      DSP_ENOTFOUND   :   Cannot find a mapped region starting with this
  *                   :   address.
@@ -584,7 +584,7 @@ extern dsp_status proc_un_map(void *hprocessor, void *map_addr,
  *      prsv_addr      :   Ptr to DSP side reservedBYTE address.
  *  Returns:
  *      DSP_SOK         :   Success.
- *      DSP_EHANDLE     :   Invalid processor handle.
+ *      EFAULT     :   Invalid processor handle.
  *      DSP_EFAIL       :   General failure.
  *      DSP_ENOTFOUND   :   Cannot find a reserved region starting with this
  *                   :   address.
diff --git a/arch/arm/plat-omap/include/dspbridge/strm.h b/arch/arm/plat-omap/include/dspbridge/strm.h
index 51a897f..caebf8a 100644
--- a/arch/arm/plat-omap/include/dspbridge/strm.h
+++ b/arch/arm/plat-omap/include/dspbridge/strm.h
@@ -35,7 +35,7 @@
  *      ap_buffer:       Array to hold buffer addresses.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid hStrm.
+ *      EFAULT:    Invalid hStrm.
  *      DSP_EMEMORY:    Insufficient memory.
  *      DSP_EFAIL:      Failure occurred, unable to allocate buffers.
  *      DSP_ESIZE:      usize must be > 0 bytes.
@@ -58,7 +58,7 @@ extern dsp_status strm_allocate_buffer(struct strm_object *hStrm,
  *      hStrm:          Stream handle returned from strm_open().
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid hStrm.
+ *      EFAULT:    Invalid hStrm.
  *      DSP_EPENDING:   Some data buffers issued to the stream have not
  *                      been reclaimed.
  *      DSP_EFAIL:      Failure to close stream.
@@ -130,7 +130,7 @@ extern void strm_exit(void);
  *      num_bufs:       Number of buffers to be freed.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid stream handle.
+ *      EFAULT:    Invalid stream handle.
  *      DSP_EFAIL:      Failure occurred, unable to free buffers.
  *  Requires:
  *      strm_init(void) called.
@@ -151,7 +151,7 @@ extern dsp_status strm_free_buffer(struct strm_object *hStrm,
  *      ph_event:        Location to store event handle on output.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid hStrm.
+ *      EFAULT:    Invalid hStrm.
  *  Requires:
  *      strm_init(void) called.
  *      ph_event != NULL.
@@ -171,7 +171,7 @@ extern dsp_status strm_get_event_handle(struct strm_object *hStrm,
  *      uSteamInfoSize:     Size of user's dsp_streaminfo structure.
  *  Returns:
  *      DSP_SOK:            Success.
- *      DSP_EHANDLE:        Invalid hStrm.
+ *      EFAULT:        Invalid hStrm.
  *      DSP_ESIZE:          stream_info_size < sizeof(dsp_streaminfo).
  *      DSP_EFAIL:          Unable to get stream info.
  *  Requires:
@@ -199,7 +199,7 @@ extern dsp_status strm_get_info(struct strm_object *hStrm,
  *      fFlush:         If TRUE, discard output buffers.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid hStrm.
+ *      EFAULT:    Invalid hStrm.
  *      DSP_ETIMEOUT:   A timeout occurred before the stream could be idled.
  *      DSP_ERESTART:   A critical error occurred, DSP is being restarted.
  *      DSP_EFAIL:      Unable to idle stream.
@@ -233,7 +233,7 @@ extern bool strm_init(void);
  *      dw_arg:              A user argument that travels with the buffer.
  *  Returns:
  *      DSP_SOK:            Success.
- *      DSP_EHANDLE:        Invalid hStrm.
+ *      EFAULT:        Invalid hStrm.
  *      DSP_ESTREAMFULL:    The stream is full.
  *      DSP_EFAIL:          Failure occurred, unable to issue buffer.
  *  Requires:
@@ -258,7 +258,7 @@ extern dsp_status strm_issue(struct strm_object *hStrm, IN u8 * pbuf,
  *      phStrm:         Location to store stream handle on output.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid hnode.
+ *      EFAULT:    Invalid hnode.
  *      DSP_EDIRECTION: Invalid dir.
  *      DSP_EVALUE:     Invalid index.
  *      DSP_ENODETYPE:  hnode is not a task or DAIS socket node.
@@ -287,7 +287,7 @@ extern dsp_status strm_open(struct node_object *hnode, u32 dir,
  *      pbuffer:        Buffer address.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid hStrm.
+ *      EFAULT:    Invalid hStrm.
  *      DSP_EFAIL:      Failure occurred, unable to prepare buffer.
  *  Requires:
  *      strm_init(void) called.
@@ -311,7 +311,7 @@ extern dsp_status strm_prepare_buffer(struct strm_object *hStrm,
  *                      the buffer will be written.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid hStrm.
+ *      EFAULT:    Invalid hStrm.
  *      DSP_ETIMEOUT:   A timeout occurred before a buffer could be
  *                      retrieved.
  *      DSP_EFAIL:      Failure occurred, unable to reclaim buffer.
@@ -337,7 +337,7 @@ extern dsp_status strm_reclaim(struct strm_object *hStrm,
  *      hnotification:  Handle to be used for notification.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid hStrm.
+ *      EFAULT:    Invalid hStrm.
  *      DSP_EMEMORY:    Insufficient memory on GPP.
  *      DSP_EVALUE:     event_mask is invalid.
  *      DSP_ENOTIMPL:   Notification type specified by notify_type is not
@@ -365,7 +365,7 @@ extern dsp_status strm_register_notify(struct strm_object *hStrm,
  *      DSP_SOK:        Success.
  *      DSP_ERANGE:     nStrms out of range.

- *      DSP_EHANDLE:    Invalid stream handle in array.
+ *      EFAULT:    Invalid stream handle in array.
  *      DSP_ETIMEOUT:   A timeout occurred before a stream became ready.
  *      DSP_EFAIL:      Failure occurred, unable to select a stream.
  *  Requires:
@@ -392,7 +392,7 @@ extern dsp_status strm_select(IN struct strm_object **strm_tab,
  *      pbuffer:        Buffer address.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid hStrm.
+ *      EFAULT:    Invalid hStrm.
  *      DSP_EFAIL:      Failure occurred, unable to unprepare buffer.
  *  Requires:
  *      strm_init(void) called.
diff --git a/arch/arm/plat-omap/include/dspbridge/sync.h b/arch/arm/plat-omap/include/dspbridge/sync.h
index 6b46e2f..30daf3d 100644
--- a/arch/arm/plat-omap/include/dspbridge/sync.h
+++ b/arch/arm/plat-omap/include/dspbridge/sync.h
@@ -56,7 +56,7 @@ struct sync_attrs {
  *  Returns:
  *      DSP_SOK:        Success;
  *      DSP_EFAIL:      Failed to close event handle.
- *      DSP_EHANDLE:    Invalid handle.
+ *      EFAULT:    Invalid handle.
  *  Requires:
  *      SYNC initialized.
  *  Ensures:
@@ -72,7 +72,7 @@ extern dsp_status sync_close_event(IN struct sync_object *event_obj);
  *      hcs_obj: critical section handle.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid handle.
+ *      EFAULT:    Invalid handle.
  *  Requires:
  *  Ensures:
  */
@@ -86,7 +86,7 @@ extern dsp_status sync_delete_cs(IN struct sync_csobject *hcs_obj);
  *      hcs_obj: critical section handle.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid handle.
+ *      EFAULT:    Invalid handle.
  *  Requires:
  *  Ensures:
  */
@@ -156,7 +156,7 @@ extern dsp_status sync_initialize_dpccs(OUT struct sync_csobject
  *      hcs_obj: critical section handle.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid handle.
+ *      EFAULT:    Invalid handle.
  *  Requires:
  *  Ensures:
  */
@@ -206,7 +206,7 @@ extern dsp_status sync_open_event(OUT struct sync_object **ph_event,
  *  Returns:
  *      DSP_SOK:        Success
  *      DSP_EFAIL:      Post message failed
- *      DSP_EHANDLE:    Invalid Window handle
+ *      EFAULT:    Invalid Window handle
  *  Requires:
  *      SYNC initialized
  *  Ensures
@@ -222,7 +222,7 @@ extern dsp_status sync_post_message(IN bhandle hWindow, IN u32 uMsg);
  *  Returns:
  *      DSP_SOK:        Success;
  *      DSP_EFAIL:      Failed to reset event.
- *      DSP_EHANDLE:    Invalid handle.
+ *      EFAULT:    Invalid handle.
  *  Requires:
  *      SYNC initialized.
  *  Ensures:
@@ -238,7 +238,7 @@ extern dsp_status sync_reset_event(IN struct sync_object *event_obj);
  *  Returns:
  *      DSP_SOK:        Success.
  *      DSP_EFAIL:      Failed to signal event.
- *      DSP_EHANDLE:    Invalid handle.
+ *      EFAULT:    Invalid handle.
  *  Requires:
  *      SYNC initialized.
  *  Ensures:
@@ -260,7 +260,7 @@ extern dsp_status sync_set_event(IN struct sync_object *event_obj);
  *                      never elapses.
  *  Returns:
  *      DSP_SOK:        The object was signalled.
- *      DSP_EHANDLE:    Invalid handle.
+ *      EFAULT:    Invalid handle.
  *      SYNC_E_FAIL:    Wait failed, possibly because the process terminated.
  *      SYNC_E_TIMEOUT: Timeout expired while waiting for event to be signalled.
  *  Requires:
diff --git a/arch/arm/plat-omap/include/dspbridge/wmd.h b/arch/arm/plat-omap/include/dspbridge/wmd.h
index a798ec9..500a7a3 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmd.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmd.h
@@ -337,7 +337,7 @@ typedef dsp_status(*fxn_chnl_create) (OUT struct chnl_mgr
  *      hchnl_mgr:       Channel manager object.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    hchnl_mgr was invalid.
+ *      EFAULT:    hchnl_mgr was invalid.
  *  Requires:
  *  Ensures:
  *      DSP_SOK: Cancels I/O on each open channel. Closes each open channel.
@@ -389,7 +389,7 @@ typedef void (*fxn_deh_notify) (struct deh_mgr *hdeh_mgr,
  *
  *  Returns:
  *      DSP_SOK:                Success.
- *      DSP_EHANDLE:            hchnl_mgr is invalid.
+ *      EFAULT:            hchnl_mgr is invalid.
  *      DSP_EMEMORY:            Insufficient memory for requested resources.
  *      DSP_EINVALIDARG:        Invalid number of IOReqs.
  *      CHNL_E_OUTOFSTREAMS:    No free channels available.
@@ -425,7 +425,7 @@ typedef dsp_status(*fxn_chnl_open) (OUT struct chnl_object
  *      chnl_obj:          Handle to a channel object.
  *  Returns:
  *      DSP_SOK:        Success;
- *      DSP_EHANDLE:    Invalid chnl_obj.
+ *      EFAULT:    Invalid chnl_obj.
  *  Requires:
  *      No thread must be blocked on this channel's I/O completion event.
  *  Ensures:
@@ -450,7 +450,7 @@ typedef dsp_status(*fxn_chnl_close) (struct chnl_object *chnl_obj);
  *      dw_arg:          A user argument that travels with the buffer.
  *  Returns:
  *      DSP_SOK:        Success;
- *      DSP_EHANDLE:    Invalid chnl_obj.
+ *      EFAULT:    Invalid chnl_obj.
  *      DSP_EPOINTER:   pHostBuf is invalid.
  *      CHNL_E_NOEOS:   User cannot mark EOS on an input channel.
  *      CHNL_E_CANCELLED: I/O has been cancelled on this channel.  No further
@@ -491,7 +491,7 @@ typedef dsp_status(*fxn_chnl_addioreq) (struct chnl_object
  *      pIOC->status:   See chnldefs.h.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    Invalid chnl_obj.
+ *      EFAULT:    Invalid chnl_obj.
  *      DSP_EPOINTER:   pIOC is invalid.
  *      CHNL_E_NOIOC:   CHNL_IOCNOWAIT was specified as the dwTimeOut parameter
  *                      yet no I/O completions were queued.
@@ -519,7 +519,7 @@ typedef dsp_status(*fxn_chnl_getioc) (struct chnl_object *chnl_obj,
  *      chnl_obj:          Channel object handle.
  *  Returns:
  *      DSP_SOK:        Success;
- *      DSP_EHANDLE:    Invalid chnl_obj.
+ *      EFAULT:    Invalid chnl_obj.
  *  Requires:
  *  Ensures:
  *      Subsequent I/O requests to this channel will not be accepted.
@@ -538,7 +538,7 @@ typedef dsp_status(*fxn_chnl_cancelio) (struct chnl_object *chnl_obj);
  *  Returns:
  *      DSP_SOK:            Success;
  *      S_CHNLIOREQUEST:    Returned if any IORequests are in the output queue.
- *      DSP_EHANDLE:        Invalid chnl_obj.
+ *      EFAULT:        Invalid chnl_obj.
  *  Requires:
  *  Ensures:
  *      DSP_SOK:            No I/O requests will be pending on this channel.
@@ -555,7 +555,7 @@ typedef dsp_status(*fxn_chnl_flushio) (struct chnl_object *chnl_obj,
  *      pInfo:          Location to store channel info.
  *  Returns:
  *      DSP_SOK:        Success;
- *      DSP_EHANDLE:    Invalid chnl_obj.
+ *      EFAULT:    Invalid chnl_obj.
  *      DSP_EPOINTER:   pInfo == NULL.
  *  Requires:
  *  Ensures:
@@ -575,7 +575,7 @@ typedef dsp_status(*fxn_chnl_getinfo) (struct chnl_object *chnl_obj,
  *      pMgrInfo:           Location to store channel manager info.
  *  Returns:
  *      DSP_SOK:            Success;
- *      DSP_EHANDLE:        Invalid hchnl_mgr.
+ *      EFAULT:        Invalid hchnl_mgr.
  *      DSP_EPOINTER:       pMgrInfo == NULL.
  *      CHNL_E_BADCHANID:   Invalid channel ID.
  *  Requires:
@@ -609,7 +609,7 @@ typedef dsp_status(*fxn_chnl_getmgrinfo) (struct chnl_mgr
  *                      occurs first. fFlush is ignored for input channel.
  *  Returns:
  *      DSP_SOK:            Success;
- *      DSP_EHANDLE:        Invalid chnl_obj.
+ *      EFAULT:        Invalid chnl_obj.
  *      CHNL_E_WAITTIMEOUT: Timeout occured before channel could be idled.
  *  Requires:
  *  Ensures:
@@ -633,7 +633,7 @@ typedef dsp_status(*fxn_chnl_idle) (struct chnl_object *chnl_obj,
  *      DSP_EMEMORY:    Insufficient memory.
  *      DSP_EVALUE:     event_mask is 0 and hnotification was not
  *                      previously registered.
- *      DSP_EHANDLE:    NULL hnotification, hnotification event name
+ *      EFAULT:    NULL hnotification, hnotification event name
  *                      too long, or hnotification event name NULL.
  *  Requires:
  *      Valid chnl_obj.
diff --git a/drivers/dsp/bridge/pmgr/chnl.c b/drivers/dsp/bridge/pmgr/chnl.c
index 66f59ce..ae87810 100644
--- a/drivers/dsp/bridge/pmgr/chnl.c
+++ b/drivers/dsp/bridge/pmgr/chnl.c
@@ -125,7 +125,7 @@ dsp_status chnl_destroy(struct chnl_mgr *hchnl_mgr)
                /* Let WMD channel module destroy the chnl_mgr: */
                status = (*intf_fxns->pfn_chnl_destroy) (hchnl_mgr);
        } else {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }

        DBC_ENSURE(DSP_FAILED(status) || !CHNL_IS_VALID_MGR(chnl_mgr_obj));
diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c
index 798f601..089de6e 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -324,7 +324,7 @@ dsp_status cmm_destroy(struct cmm_object *hcmm_mgr, bool bForce)

        DBC_REQUIRE(refs > 0);
        if (!MEM_IS_VALID_HANDLE(hcmm_mgr, CMMSIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                return status;
        }
        sync_enter_cs(cmm_mgr_obj->cmm_lock);
@@ -405,7 +405,7 @@ dsp_status cmm_free_buf(struct cmm_object *hcmm_mgr, void *buf_pa,
        }
        if (!(MEM_IS_VALID_HANDLE(hcmm_mgr, CMMSIGNATURE)) ||
            !(ul_seg_id > 0)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                return status;
        }
        /* get the allocator for this segment id */
@@ -475,7 +475,7 @@ dsp_status cmm_get_info(struct cmm_object *hcmm_mgr,
        DBC_REQUIRE(cmm_info_obj != NULL);

        if (!MEM_IS_VALID_HANDLE(hcmm_mgr, CMMSIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                return status;
        }
        sync_enter_cs(cmm_mgr_obj->cmm_lock);
@@ -570,7 +570,7 @@ dsp_status cmm_register_gppsm_seg(struct cmm_object *hcmm_mgr,
                dw_gpp_base_pa, ul_size, dwDSPAddrOffset, dw_dsp_base,
                ul_dsp_size, dw_gpp_base_va);
        if (!MEM_IS_VALID_HANDLE(hcmm_mgr, CMMSIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                return status;
        }
        /* make sure we have room for another allocator */
@@ -701,7 +701,7 @@ dsp_status cmm_un_register_gppsm_seg(struct cmm_object *hcmm_mgr,
                        status = DSP_EINVALIDARG;
                }
        } else {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }
        return status;
 }
@@ -1013,7 +1013,7 @@ dsp_status cmm_xlator_delete(struct cmm_xlatorobject *xlator, bool bForce)
        if (MEM_IS_VALID_HANDLE(xlator_obj, CMMXLATESIGNATURE)) {
                MEM_FREE_OBJECT(xlator_obj);
        } else {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }

        return status;
@@ -1109,7 +1109,7 @@ dsp_status cmm_xlator_info(struct cmm_xlatorobject *xlator, IN OUT u8 ** paddr,
                        *paddr = (u8 *) xlator_obj->dw_virt_base;
                }
        } else {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }
        return status;
 }
diff --git a/drivers/dsp/bridge/pmgr/cod.c b/drivers/dsp/bridge/pmgr/cod.c
index 548f1eb..2b9e0ac 100644
--- a/drivers/dsp/bridge/pmgr/cod.c
+++ b/drivers/dsp/bridge/pmgr/cod.c
@@ -103,7 +103,7 @@ static s32 cod_f_close(struct file *filp)
 {
        /* Check for valid handle */
        if (!filp)
-               return DSP_EHANDLE;
+               return EFAULT;

        filp_close(filp, NULL);

@@ -135,7 +135,7 @@ static s32 cod_f_read(void __user *pbuffer, s32 size, s32 cCount,
 {
        /* check for valid file handle */
        if (!filp)
-               return DSP_EHANDLE;
+               return EFAULT;

        if ((size > 0) && (cCount > 0) && pbuffer) {
                u32 dw_bytes_read;
@@ -163,7 +163,7 @@ static s32 cod_f_seek(struct file *filp, s32 lOffset, s32 cOrigin)

        /* check for valid file handle */
        if (!filp)
-               return DSP_EHANDLE;
+               return EFAULT;

        /* based on the origin flag, move the internal pointer */
        dw_cur_pos = filp->f_op->llseek(filp, lOffset, cOrigin);
@@ -180,7 +180,7 @@ static s32 cod_f_tell(struct file *filp)
        loff_t dw_cur_pos;

        if (!filp)
-               return DSP_EHANDLE;
+               return EFAULT;

        /* Get current position */
        dw_cur_pos = filp->f_op->llseek(filp, 0, SEEK_CUR);
diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index 0e7c4a4..948fa85 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -415,7 +415,7 @@ dsp_status dbll_get_sect(struct dbll_library_obj *lib, char *name, u32 *paddr,
                                                              SEEK_SET);
                }
        } else {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }
        if (DSP_SUCCEEDED(status)) {
                byte_size = 1;
@@ -770,7 +770,7 @@ dsp_status dbll_read_sect(struct dbll_library_obj *lib, char *name,
                                                              SEEK_SET);
                }
        } else {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }
        if (DSP_FAILED(status))
                goto func_cont;
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index 2470264..f141de8 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -405,7 +405,7 @@ dsp_status dev_destroy_device(struct dev_object *hdev_obj)
                        dev_obj = NULL;
                }
        } else {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }

        return status;
@@ -430,7 +430,7 @@ dsp_status dev_get_chnl_mgr(struct dev_object *hdev_obj,
                *phMgr = dev_obj->hchnl_mgr;
        } else {
                *phMgr = NULL;
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }

        DBC_ENSURE(DSP_SUCCEEDED(status) || ((phMgr != NULL) &&
@@ -457,7 +457,7 @@ dsp_status dev_get_cmm_mgr(struct dev_object *hdev_obj,
                *phMgr = dev_obj->hcmm_mgr;
        } else {
                *phMgr = NULL;
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }

        DBC_ENSURE(DSP_SUCCEEDED(status) || ((phMgr != NULL) &&
@@ -484,7 +484,7 @@ dsp_status dev_get_dmm_mgr(struct dev_object *hdev_obj,
                *phMgr = dev_obj->dmm_mgr;
        } else {
                *phMgr = NULL;
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }

        DBC_ENSURE(DSP_SUCCEEDED(status) || ((phMgr != NULL) &&
@@ -510,7 +510,7 @@ dsp_status dev_get_cod_mgr(struct dev_object *hdev_obj,
                *phCodMgr = dev_obj->cod_mgr;
        } else {
                *phCodMgr = NULL;
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }

        DBC_ENSURE(DSP_SUCCEEDED(status) || ((phCodMgr != NULL) &&
@@ -533,7 +533,7 @@ dsp_status dev_get_deh_mgr(struct dev_object *hdev_obj,
                *phDehMgr = hdev_obj->hdeh_mgr;
        } else {
                *phDehMgr = NULL;
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }
        return status;
 }
@@ -556,7 +556,7 @@ dsp_status dev_get_dev_node(struct dev_object *hdev_obj,
                *phDevNode = dev_obj->dev_node_obj;
        } else {
                *phDevNode = NULL;
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }

        DBC_ENSURE(DSP_SUCCEEDED(status) || ((phDevNode != NULL) &&
@@ -600,7 +600,7 @@ dsp_status dev_get_intf_fxns(struct dev_object *hdev_obj,
                *ppIntfFxns = &dev_obj->wmd_interface;
        } else {
                *ppIntfFxns = NULL;
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }

        DBC_ENSURE(DSP_SUCCEEDED(status) || ((ppIntfFxns != NULL) &&
@@ -624,7 +624,7 @@ dsp_status dev_get_io_mgr(struct dev_object *hdev_obj,
                *phIOMgr = hdev_obj->hio_mgr;
        } else {
                *phIOMgr = NULL;
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }

        return status;
@@ -680,7 +680,7 @@ dsp_status dev_get_node_manager(struct dev_object *hdev_obj,
                *phNodeMgr = dev_obj->hnode_mgr;
        } else {
                *phNodeMgr = NULL;
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }

        DBC_ENSURE(DSP_SUCCEEDED(status) || ((phNodeMgr != NULL) &&
@@ -708,7 +708,7 @@ dsp_status dev_get_symbol(struct dev_object *hdev_obj,
                                                   pul_value);
                }
        } else {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }

        return status;
@@ -732,7 +732,7 @@ dsp_status dev_get_wmd_context(struct dev_object *hdev_obj,
                *phWmdContext = dev_obj->hwmd_context;
        } else {
                *phWmdContext = NULL;
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }

        DBC_ENSURE(DSP_SUCCEEDED(status) || ((phWmdContext != NULL) &&
@@ -854,7 +854,7 @@ dsp_status dev_set_chnl_mgr(struct dev_object *hdev_obj,
        if (IS_VALID_HANDLE(hdev_obj))
                dev_obj->hchnl_mgr = hmgr;
        else
-               status = DSP_EHANDLE;
+               status = EFAULT;

        DBC_ENSURE(DSP_FAILED(status) || (dev_obj->hchnl_mgr == hmgr));
        return status;
@@ -970,7 +970,7 @@ static bool IS_VALID_HANDLE(struct dev_object *hObj)
  *                              dev_create_device()
  *  Returns:
  *      DSP_SOK:                Success.
- *      DSP_EHANDLE:            Invalid hdev_obj.
+ *      EFAULT:            Invalid hdev_obj.
  *  Requires:
  *      Should only be called once by dev_create_device() for a given DevObject.
  *  Ensures:
diff --git a/drivers/dsp/bridge/pmgr/dmm.c b/drivers/dsp/bridge/pmgr/dmm.c
index c8979cc..ade59ef 100644
--- a/drivers/dsp/bridge/pmgr/dmm.c
+++ b/drivers/dsp/bridge/pmgr/dmm.c
@@ -171,7 +171,7 @@ dsp_status dmm_destroy(struct dmm_object *dmm_mgr)
                        MEM_FREE_OBJECT(dmm_obj);
                }
        } else
-               status = DSP_EHANDLE;
+               status = EFAULT;

        return status;
 }
@@ -195,7 +195,7 @@ dsp_status dmm_delete_tables(struct dmm_object *dmm_mgr)

                sync_leave_cs(dmm_obj->dmm_lock);
        } else
-               status = DSP_EHANDLE;
+               status = EFAULT;
        return status;
 }

diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index fd90c99..72bfe08 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -98,7 +98,7 @@ dsp_status dcd_auto_register(IN struct dcd_manager *hdcd_mgr,
                                         (dcd_registerfxn) dcd_register_object,
                                         (void *)pszCoffPath);
        else
-               status = DSP_EHANDLE;
+               status = EFAULT;

        return status;
 }
@@ -120,7 +120,7 @@ dsp_status dcd_auto_unregister(IN struct dcd_manager *hdcd_mgr,
                                         (dcd_registerfxn) dcd_register_object,
                                         NULL);
        else
-               status = DSP_EHANDLE;
+               status = EFAULT;

        return status;
 }
@@ -178,7 +178,7 @@ func_end:
 dsp_status dcd_destroy_manager(IN struct dcd_manager *hdcd_mgr)
 {
        struct dcd_manager *dcd_mgr_obj = hdcd_mgr;
-       dsp_status status = DSP_EHANDLE;
+       dsp_status status = EFAULT;

        DBC_REQUIRE(refs >= 0);

@@ -394,7 +394,7 @@ dsp_status dcd_get_object_def(IN struct dcd_manager *hdcd_mgr,
        }

        if (!IS_VALID_HANDLE(hdcd_mgr)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_end;
        }

@@ -534,7 +534,7 @@ dsp_status dcd_get_objects(IN struct dcd_manager *hdcd_mgr,

        DBC_REQUIRE(refs > 0);
        if (!IS_VALID_HANDLE(hdcd_mgr)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_end;
        }

diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 98f9b78..6f3292c 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -88,7 +88,7 @@ dsp_status drv_insert_node_res_element(bhandle hnode, bhandle hNodeRes,
        *node_res_obj = (struct node_res_object *)mem_calloc
            (1 * sizeof(struct node_res_object), MEM_PAGED);
        if (*node_res_obj == NULL)
-               status = DSP_EHANDLE;
+               status = EFAULT;

        if (DSP_SUCCEEDED(status)) {
                if (mutex_lock_interruptible(&ctxt->node_mutex)) {
@@ -286,7 +286,7 @@ dsp_status drv_proc_insert_strm_res_element(bhandle hStreamHandle,
        *pstrm_res = (struct strm_res_object *)
            mem_calloc(1 * sizeof(struct strm_res_object), MEM_PAGED);
        if (*pstrm_res == NULL)
-               status = DSP_EHANDLE;
+               status = EFAULT;

        if (DSP_SUCCEEDED(status)) {
                if (mutex_lock_interruptible(&ctxt->strm_mutex)) {
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index aa5b0c3..43a655b 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -797,7 +797,7 @@ dsp_status nldr_get_rmm_manager(struct nldr_object *hNldrObject,
                *phRmmMgr = nldr_obj->rmm;
        } else {
                *phRmmMgr = NULL;
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }

        DBC_ENSURE(DSP_SUCCEEDED(status) || ((phRmmMgr != NULL) &&
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 9535dfc..1ac7060 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -695,7 +695,7 @@ DBAPI node_alloc_msg_buf(struct node_object *hnode, u32 usize,
        DBC_REQUIRE(usize > 0);

        if (!MEM_IS_VALID_HANDLE(pnode, NODE_SIGNATURE))
-               status = DSP_EHANDLE;
+               status = EFAULT;
        else if (node_get_type(pnode) == NODE_DEVICE)
                status = DSP_ENODETYPE;

@@ -778,7 +778,7 @@ dsp_status node_change_priority(struct node_object *hnode, s32 prio)
        DBC_REQUIRE(refs > 0);

        if (!MEM_IS_VALID_HANDLE(hnode, NODE_SIGNATURE) || !hnode->hnode_mgr) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        } else {
                hnode_mgr = hnode->hnode_mgr;
                node_type = node_get_type(hnode);
@@ -854,7 +854,7 @@ dsp_status node_connect(struct node_object *hNode1, u32 uStream1,
             !MEM_IS_VALID_HANDLE(hNode1, NODE_SIGNATURE)) ||
            (hNode2 != (struct node_object *)DSP_HGPPNODE &&
             !MEM_IS_VALID_HANDLE(hNode2, NODE_SIGNATURE)))
-               status = DSP_EHANDLE;
+               status = EFAULT;

        if (DSP_SUCCEEDED(status)) {
                /* The two nodes must be on the same processor */
@@ -1164,7 +1164,7 @@ dsp_status node_create(struct node_object *hnode)

        DBC_REQUIRE(refs > 0);
        if (!MEM_IS_VALID_HANDLE(pnode, NODE_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_end;
        }
        hprocessor = hnode->hprocessor;
@@ -1459,7 +1459,7 @@ dsp_status node_delete(struct node_object *hnode,
        DBC_REQUIRE(refs > 0);

        if (!MEM_IS_VALID_HANDLE(hnode, NODE_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_end;
        }
        /* create struct dsp_cbdata struct for PWR call */
@@ -1607,7 +1607,7 @@ dsp_status node_delete_mgr(struct node_mgr *hnode_mgr)
        if (MEM_IS_VALID_HANDLE(hnode_mgr, NODEMGR_SIGNATURE))
                delete_node_mgr(hnode_mgr);
        else
-               status = DSP_EHANDLE;
+               status = EFAULT;

        return status;
 }
@@ -1630,7 +1630,7 @@ dsp_status node_enum_nodes(struct node_mgr *hnode_mgr, void **node_tab,
        DBC_REQUIRE(pu_allocated != NULL);

        if (!MEM_IS_VALID_HANDLE(hnode_mgr, NODEMGR_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_end;
        }
        /* Enter critical section */
@@ -1692,7 +1692,7 @@ dsp_status node_free_msg_buf(struct node_object *hnode, IN u8 * pbuffer,
        DBC_REQUIRE(pnode->xlator != NULL);

        if (!MEM_IS_VALID_HANDLE(hnode, NODE_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_end;
        }
        status = proc_get_processor_id(pnode->hprocessor, &proc_id);
@@ -1732,7 +1732,7 @@ dsp_status node_get_attr(struct node_object *hnode,
        DBC_REQUIRE(attr_size >= sizeof(struct dsp_nodeattr));

        if (!MEM_IS_VALID_HANDLE(hnode, NODE_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        } else {
                hnode_mgr = hnode->hnode_mgr;
                /* Enter hnode_mgr critical section (since we're accessing
@@ -1778,7 +1778,7 @@ dsp_status node_get_channel_id(struct node_object *hnode, u32 dir, u32 index,
        DBC_REQUIRE(pulId != NULL);

        if (!MEM_IS_VALID_HANDLE(hnode, NODE_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                return status;
        }
        node_type = node_get_type(hnode);
@@ -1825,7 +1825,7 @@ dsp_status node_get_message(struct node_object *hnode,
        DBC_REQUIRE(pmsg != NULL);

        if (!MEM_IS_VALID_HANDLE(hnode, NODE_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_end;
        }
        hprocessor = hnode->hprocessor;
@@ -1894,7 +1894,7 @@ dsp_status node_get_nldr_obj(struct node_mgr *hnode_mgr,
        DBC_REQUIRE(phNldrObj != NULL);

        if (!MEM_IS_VALID_HANDLE(hnode_mgr, NODEMGR_SIGNATURE))
-               status = DSP_EHANDLE;
+               status = EFAULT;
        else
                *phNldrObj = node_mgr_obj->nldr_obj;

@@ -1916,7 +1916,7 @@ dsp_status node_get_strm_mgr(struct node_object *hnode,
        DBC_REQUIRE(refs > 0);

        if (!MEM_IS_VALID_HANDLE(hnode, NODE_SIGNATURE))
-               status = DSP_EHANDLE;
+               status = EFAULT;
        else
                *phStrmMgr = hnode->hnode_mgr->strm_mgr_obj;

@@ -2034,7 +2034,7 @@ dsp_status node_pause(struct node_object *hnode)
        DBC_REQUIRE(refs > 0);

        if (!MEM_IS_VALID_HANDLE(hnode, NODE_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        } else {
                node_type = node_get_type(hnode);
                if (node_type != NODE_TASK && node_type != NODE_DAISSOCKET)
@@ -2126,7 +2126,7 @@ dsp_status node_put_message(struct node_object *hnode,
        DBC_REQUIRE(pmsg != NULL);

        if (!MEM_IS_VALID_HANDLE(hnode, NODE_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_end;
        }
        hprocessor = hnode->hprocessor;
@@ -2220,7 +2220,7 @@ dsp_status node_register_notify(struct node_object *hnode, u32 event_mask,
        DBC_REQUIRE(hnotification != NULL);

        if (!MEM_IS_VALID_HANDLE(hnode, NODE_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        } else {
                /* Check if event mask is a valid node related event */
                if (event_mask & ~(DSP_NODESTATECHANGE | DSP_NODEMESSAGEREADY))
@@ -2280,7 +2280,7 @@ dsp_status node_run(struct node_object *hnode)
        DBC_REQUIRE(refs > 0);

        if (!MEM_IS_VALID_HANDLE(hnode, NODE_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_end;
        }
        hprocessor = hnode->hprocessor;
@@ -2301,7 +2301,7 @@ dsp_status node_run(struct node_object *hnode)

        hnode_mgr = hnode->hnode_mgr;
        if (!MEM_IS_VALID_HANDLE(hnode_mgr, NODEMGR_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_end;
        }
        intf_fxns = hnode_mgr->intf_fxns;
@@ -2403,11 +2403,11 @@ dsp_status node_terminate(struct node_object *hnode, OUT dsp_status *pstatus)
        DBC_REQUIRE(pstatus != NULL);

        if (!MEM_IS_VALID_HANDLE(hnode, NODE_SIGNATURE) || !hnode->hnode_mgr) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_end;
        }
        if (pnode->hprocessor == NULL) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_end;
        }
        status = proc_get_processor_id(pnode->hprocessor, &proc_id);
@@ -3045,7 +3045,7 @@ dsp_status node_get_uuid_props(void *hprocessor,
        DBC_REQUIRE(pNodeId != NULL);

        if (hprocessor == NULL || pNodeId == NULL) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_end;
        }
        status = proc_get_state(hprocessor, &proc_state,
@@ -3063,7 +3063,7 @@ dsp_status node_get_uuid_props(void *hprocessor,
        if (hdev_obj) {
                status = dev_get_node_manager(hdev_obj, &hnode_mgr);
                if (hnode_mgr == NULL) {
-                       status = DSP_EHANDLE;
+                       status = EFAULT;
                        goto func_end;
                }
        }
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index b154102..b94234f 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -371,7 +371,7 @@ dsp_status proc_ctrl(void *hprocessor, u32 dw_cmd, IN struct dsp_cbdata * arg)
                        status = DSP_EFAIL;
                }
        } else {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }

        return status;
@@ -408,7 +408,7 @@ dsp_status proc_detach(struct process_context *pr_ctxt)
                MEM_FREE_OBJECT(p_proc_object);
                pr_ctxt->hprocessor = NULL;
        } else {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }

        return status;
@@ -444,7 +444,7 @@ dsp_status proc_enum_nodes(void *hprocessor, void **node_tab,
                        }
                }
        } else {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }

        return status;
@@ -533,7 +533,7 @@ static dsp_status proc_memory_sync(void *hprocessor, void *pmpu_addr,
        DBC_REQUIRE(refs > 0);

        if (!MEM_IS_VALID_HANDLE(p_proc_object, PROC_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto err_out;
        }

@@ -542,7 +542,7 @@ static dsp_status proc_memory_sync(void *hprocessor, void *pmpu_addr,
        if (memory_sync_vma((u32) pmpu_addr, ul_size, FlushMemType)) {
                pr_err("%s: InValid address parameters %p %x\n",
                       __func__, pmpu_addr, ul_size);
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }

        up_read(&current->mm->mmap_sem);
@@ -600,7 +600,7 @@ dsp_status proc_get_resource_info(void *hprocessor, u32 resource_type,
        DBC_REQUIRE(resource_info_size >= sizeof(struct dsp_resourceinfo));

        if (!MEM_IS_VALID_HANDLE(p_proc_object, PROC_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_end;
        }
        switch (resource_type) {
@@ -683,7 +683,7 @@ dsp_status proc_get_dev_object(void *hprocessor,
                status = DSP_SOK;
        } else {
                *phDevObject = NULL;
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }

        DBC_ENSURE((DSP_SUCCEEDED(status) && *phDevObject != NULL) ||
@@ -743,7 +743,7 @@ dsp_status proc_get_state(void *hprocessor,
                        status = (*p_proc_object->intf_fxns->pfn_deh_get_info)
                            (hdeh_mgr, &(proc_state_obj->err_info));
        } else {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }
        dev_dbg(bridge, "%s, results: status: 0x%x proc_state_obj: 0x%x\n",
                __func__, status, proc_state_obj->proc_state);
@@ -837,7 +837,7 @@ dsp_status proc_load(void *hprocessor, IN CONST s32 argc_index,
 #endif
        /* Call the WMD_BRD_Load fxn */
        if (!MEM_IS_VALID_HANDLE(p_proc_object, PROC_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_end;
        }
        if (DSP_FAILED(dev_get_cod_mgr(p_proc_object->hdev_obj, &cod_mgr))) {
@@ -1074,7 +1074,7 @@ dsp_status proc_map(void *hprocessor, void *pmpu_addr, u32 ul_size,
                                   PG_SIZE4K);

        if (!MEM_IS_VALID_HANDLE(p_proc_object, PROC_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_end;
        }
        /* Critical section */
@@ -1143,7 +1143,7 @@ dsp_status proc_register_notify(void *hprocessor, u32 event_mask,

        /* Check processor handle */
        if (!MEM_IS_VALID_HANDLE(p_proc_object, PROC_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_end;
        }
        /* Check if event mask is a valid processor related event */
@@ -1215,7 +1215,7 @@ dsp_status proc_reserve_memory(void *hprocessor, u32 ul_size,
        struct dmm_rsv_object *rsv_obj;

        if (!MEM_IS_VALID_HANDLE(p_proc_object, PROC_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_end;
        }

@@ -1262,7 +1262,7 @@ dsp_status proc_start(void *hprocessor)

        DBC_REQUIRE(refs > 0);
        if (!MEM_IS_VALID_HANDLE(p_proc_object, PROC_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_end;
        }
        /* Call the bridge_brd_start */
@@ -1338,7 +1338,7 @@ dsp_status proc_stop(void *hprocessor)

        DBC_REQUIRE(refs > 0);
        if (!MEM_IS_VALID_HANDLE(p_proc_object, PROC_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_end;
        }
        if (DSP_SUCCEEDED((*p_proc_object->intf_fxns->pfn_brd_status)
@@ -1405,7 +1405,7 @@ dsp_status proc_un_map(void *hprocessor, void *map_addr,

        va_align = PG_ALIGN_LOW((u32) map_addr, PG_SIZE4K);
        if (!MEM_IS_VALID_HANDLE(p_proc_object, PROC_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_end;
        }

@@ -1464,7 +1464,7 @@ dsp_status proc_un_reserve_memory(void *hprocessor, void *prsv_addr,
        struct dmm_rsv_object *rsv_obj;

        if (!MEM_IS_VALID_HANDLE(p_proc_object, PROC_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_end;
        }

@@ -1608,7 +1608,7 @@ dsp_status proc_notify_clients(void *hProc, u32 uEvents)
        DBC_REQUIRE(IS_VALID_PROC_EVENT(uEvents));
        DBC_REQUIRE(refs > 0);
        if (!MEM_IS_VALID_HANDLE(p_proc_object, PROC_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_end;
        }

@@ -1632,7 +1632,7 @@ dsp_status proc_notify_all_clients(void *hProc, u32 uEvents)
        DBC_REQUIRE(refs > 0);

        if (!MEM_IS_VALID_HANDLE(p_proc_object, PROC_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_end;
        }

@@ -1655,7 +1655,7 @@ dsp_status proc_get_processor_id(void *hProc, u32 * procID)
        if (MEM_IS_VALID_HANDLE(p_proc_object, PROC_SIGNATURE))
                *procID = p_proc_object->processor_id;
        else
-               status = DSP_EHANDLE;
+               status = EFAULT;

        return status;
 }
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index 113b9bd..d45566d 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -124,7 +124,7 @@ dsp_status strm_allocate_buffer(struct strm_object *hStrm, u32 usize,
                        status = DSP_ESIZE;

        } else {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }

        if (DSP_FAILED(status))
@@ -170,7 +170,7 @@ dsp_status strm_close(struct strm_object *hStrm,
        DBC_REQUIRE(refs > 0);

        if (!MEM_IS_VALID_HANDLE(hStrm, STRM_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        } else {
                /* Have all buffers been reclaimed? If not, return
                 * DSP_EPENDING */
@@ -193,7 +193,7 @@ dsp_status strm_close(struct strm_object *hStrm,
            DSP_ENOTFOUND)
                drv_proc_remove_strm_res_element(hstrm_res, pr_ctxt);
 func_end:
-       DBC_ENSURE(status == DSP_SOK || status == DSP_EHANDLE ||
+       DBC_ENSURE(status == DSP_SOK || status == EFAULT ||
                   status == DSP_EPENDING || status == DSP_EFAIL);

        dev_dbg(bridge, "%s: hStrm: %p, status 0x%x\n", __func__,
@@ -294,7 +294,7 @@ dsp_status strm_free_buffer(struct strm_object *hStrm, u8 ** ap_buffer,
        DBC_REQUIRE(ap_buffer != NULL);

        if (!MEM_IS_VALID_HANDLE(hStrm, STRM_SIGNATURE))
-               status = DSP_EHANDLE;
+               status = EFAULT;

        if (DSP_SUCCEEDED(status)) {
                for (i = 0; i < num_bufs; i++) {
@@ -332,7 +332,7 @@ dsp_status strm_get_info(struct strm_object *hStrm,
        DBC_REQUIRE(stream_info_size >= sizeof(struct stream_info));

        if (!MEM_IS_VALID_HANDLE(hStrm, STRM_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        } else {
                if (stream_info_size < sizeof(struct stream_info)) {
                        /* size of users info */
@@ -393,7 +393,7 @@ dsp_status strm_idle(struct strm_object *hStrm, bool fFlush)
        DBC_REQUIRE(refs > 0);

        if (!MEM_IS_VALID_HANDLE(hStrm, STRM_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        } else {
                intf_fxns = hStrm->strm_mgr_obj->intf_fxns;

@@ -441,7 +441,7 @@ dsp_status strm_issue(struct strm_object *hStrm, IN u8 *pbuf, u32 ul_bytes,
        DBC_REQUIRE(pbuf != NULL);

        if (!MEM_IS_VALID_HANDLE(hStrm, STRM_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        } else {
                intf_fxns = hStrm->strm_mgr_obj->intf_fxns;

@@ -590,7 +590,7 @@ func_cont:
                                /*
                                 * We got a status that's not return-able.
                                 * Assert that we got something we were
-                                * expecting (DSP_EHANDLE isn't acceptable,
+                                * expecting (EFAULT isn't acceptable,
                                 * strm_mgr_obj->hchnl_mgr better be valid or we
                                 * assert here), and then return DSP_EFAIL.
                                 */
@@ -612,7 +612,7 @@ func_cont:
        /* ensure we return a documented error code */
        DBC_ENSURE((DSP_SUCCEEDED(status) &&
                    MEM_IS_VALID_HANDLE((*phStrm), STRM_SIGNATURE)) ||
-                  (*phStrm == NULL && (status == DSP_EHANDLE ||
+                  (*phStrm == NULL && (status == EFAULT ||
                                        status == DSP_EDIRECTION
                                        || status == DSP_EVALUE
                                        || status == DSP_EFAIL)));
@@ -642,7 +642,7 @@ dsp_status strm_reclaim(struct strm_object *hStrm, OUT u8 ** buf_ptr,
        DBC_REQUIRE(pdw_arg != NULL);

        if (!MEM_IS_VALID_HANDLE(hStrm, STRM_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_end;
        }
        intf_fxns = hStrm->strm_mgr_obj->intf_fxns;
@@ -695,7 +695,7 @@ dsp_status strm_reclaim(struct strm_object *hStrm, OUT u8 ** buf_ptr,
        }
 func_end:
        /* ensure we return a documented return code */
-       DBC_ENSURE(DSP_SUCCEEDED(status) || status == DSP_EHANDLE ||
+       DBC_ENSURE(DSP_SUCCEEDED(status) || status == EFAULT ||
                   status == DSP_ETIMEOUT || status == DSP_ETRANSLATE ||
                   status == DSP_EFAIL);

@@ -721,7 +721,7 @@ dsp_status strm_register_notify(struct strm_object *hStrm, u32 event_mask,
        DBC_REQUIRE(hnotification != NULL);

        if (!MEM_IS_VALID_HANDLE(hStrm, STRM_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        } else if ((event_mask & ~((DSP_STREAMIOCOMPLETION) |
                                   DSP_STREAMDONE)) != 0) {
                status = DSP_EVALUE;
@@ -740,7 +740,7 @@ dsp_status strm_register_notify(struct strm_object *hStrm, u32 event_mask,
                                                            hnotification);
        }
        /* ensure we return a documented return code */
-       DBC_ENSURE(DSP_SUCCEEDED(status) || status == DSP_EHANDLE ||
+       DBC_ENSURE(DSP_SUCCEEDED(status) || status == EFAULT ||
                   status == DSP_ETIMEOUT || status == DSP_ETRANSLATE ||
                   status == DSP_ENOTIMPL || status == DSP_EFAIL);
        return status;
@@ -769,7 +769,7 @@ dsp_status strm_select(IN struct strm_object **strm_tab, u32 nStrms,
        *pmask = 0;
        for (i = 0; i < nStrms; i++) {
                if (!MEM_IS_VALID_HANDLE(strm_tab[i], STRM_SIGNATURE)) {
-                       status = DSP_EHANDLE;
+                       status = EFAULT;
                        break;
                }
        }
@@ -858,7 +858,7 @@ static dsp_status delete_strm(struct strm_object *hStrm)
                }
                MEM_FREE_OBJECT(hStrm);
        } else {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }
        return status;
 }
diff --git a/drivers/dsp/bridge/services/ntfy.c b/drivers/dsp/bridge/services/ntfy.c
index 6eb222f..41e2dad 100644
--- a/drivers/dsp/bridge/services/ntfy.c
+++ b/drivers/dsp/bridge/services/ntfy.c
@@ -211,7 +211,7 @@ dsp_status ntfy_register(struct ntfy_object *ntfy_obj,
        DBC_REQUIRE(MEM_IS_VALID_HANDLE(ntfy_obj, NTFY_SIGNATURE));

        if (hnotification == NULL)
-               status = DSP_EHANDLE;
+               status = EFAULT;

        /* Return DSP_ENOTIMPL if notify_type is not supported */
        if (DSP_SUCCEEDED(status)) {
diff --git a/drivers/dsp/bridge/services/sync.c b/drivers/dsp/bridge/services/sync.c
index b11d644..6325dfb 100644
--- a/drivers/dsp/bridge/services/sync.c
+++ b/drivers/dsp/bridge/services/sync.c
@@ -94,7 +94,7 @@ dsp_status sync_close_event(struct sync_object *event_obj)
                MEM_FREE_OBJECT(event);

        } else {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }

        return status;
@@ -161,7 +161,7 @@ dsp_status sync_reset_event(struct sync_object *event_obj)
        if (MEM_IS_VALID_HANDLE(event_obj, SIGNATURE))
                event->state = SO_RESET;
        else
-               status = DSP_EHANDLE;
+               status = EFAULT;

        return status;
 }
@@ -195,7 +195,7 @@ dsp_status sync_set_event(struct sync_object *event_obj)
                }
                spin_unlock_irqrestore(&event_obj->sync_lock, flags);
        } else {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }
        return status;
 }
@@ -216,7 +216,7 @@ dsp_status sync_wait_on_event(struct sync_object *event_obj, u32 dwTimeout)
                status = sync_wait_on_multiple_events(&event, 1, dwTimeout,
                                                      &temp);
        else
-               status = DSP_EHANDLE;
+               status = EFAULT;

        return status;
 }
@@ -336,7 +336,7 @@ dsp_status sync_delete_cs(struct sync_csobject *hcs_obj)

                MEM_FREE_OBJECT(pdpccs_obj);
        } else {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }

        return status;
@@ -368,7 +368,7 @@ dsp_status sync_enter_cs(struct sync_csobject *hcs_obj)
                        DBC_ASSERT(0);
                }
        } else {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }

        return status;
@@ -446,7 +446,7 @@ dsp_status sync_leave_cs(struct sync_csobject *hcs_obj)
                }
                spin_unlock_bh(&pdpccs_obj->sync_dpccs_lock);
        } else {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }

        return status;
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index ebb4827..e6bf700 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -112,7 +112,7 @@ dsp_status bridge_chnl_add_io_req(struct chnl_object *chnl_obj, void *pHostBuf,
        if (!pHostBuf) {
                status = DSP_EPOINTER;
        } else if (!MEM_IS_VALID_HANDLE(pchnl, CHNL_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        } else if (is_eos && CHNL_IS_INPUT(pchnl->chnl_mode)) {
                status = CHNL_E_NOEOS;
        } else {
@@ -136,7 +136,7 @@ dsp_status bridge_chnl_add_io_req(struct chnl_object *chnl_obj, void *pHostBuf,
        dev_obj = dev_get_first();
        dev_get_wmd_context(dev_obj, &dev_ctxt);
        if (!dev_ctxt)
-               status = DSP_EHANDLE;
+               status = EFAULT;

        if (DSP_FAILED(status))
                goto func_end;
@@ -267,7 +267,7 @@ dsp_status bridge_chnl_cancel_io(struct chnl_object *chnl_obj)
                chnl_mode = pchnl->chnl_mode;
                chnl_mgr_obj = pchnl->chnl_mgr_obj;
        } else {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }
        if (DSP_FAILED(status))
                goto func_end;
@@ -324,7 +324,7 @@ dsp_status bridge_chnl_close(struct chnl_object *chnl_obj)

        /* Check args: */
        if (!MEM_IS_VALID_HANDLE(pchnl, CHNL_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_cont;
        }
        {
@@ -478,7 +478,7 @@ dsp_status bridge_chnl_destroy(struct chnl_mgr *hchnl_mgr)
                /* Free this Chnl Mgr object: */
                MEM_FREE_OBJECT(hchnl_mgr);
        } else {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }
        return status;
 }
@@ -505,7 +505,7 @@ dsp_status bridge_chnl_flush_io(struct chnl_object *chnl_obj, u32 dwTimeOut)
                        chnl_mgr_obj = pchnl->chnl_mgr_obj;
                }
        } else {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }
        if (DSP_SUCCEEDED(status)) {
                /* Note: Currently, if another thread continues to add IO
@@ -560,7 +560,7 @@ dsp_status bridge_chnl_get_info(struct chnl_object *chnl_obj,
                        pInfo->cio_reqs = pchnl->cio_reqs;
                        pInfo->dw_state = pchnl->dw_state;
                } else {
-                       status = DSP_EHANDLE;
+                       status = EFAULT;
                }
        } else {
                status = DSP_EPOINTER;
@@ -592,7 +592,7 @@ dsp_status bridge_chnl_get_ioc(struct chnl_object *chnl_obj, u32 dwTimeOut,
        if (pIOC == NULL) {
                status = DSP_EPOINTER;
        } else if (!MEM_IS_VALID_HANDLE(pchnl, CHNL_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        } else if (dwTimeOut == CHNL_IOCNOWAIT) {
                if (LST_IS_EMPTY(pchnl->pio_completions))
                        status = CHNL_E_NOIOC;
@@ -602,7 +602,7 @@ dsp_status bridge_chnl_get_ioc(struct chnl_object *chnl_obj, u32 dwTimeOut,
        dev_obj = dev_get_first();
        dev_get_wmd_context(dev_obj, &dev_ctxt);
        if (!dev_ctxt)
-               status = DSP_EHANDLE;
+               status = EFAULT;

        if (DSP_FAILED(status))
                goto func_end;
@@ -739,7 +739,7 @@ dsp_status bridge_chnl_get_mgr_info(struct chnl_mgr *hchnl_mgr, u32 uChnlID,
                                pMgrInfo->max_channels =
                                    chnl_mgr_obj->max_channels;
                        } else {
-                               status = DSP_EHANDLE;
+                               status = EFAULT;
                        }
                } else {
                        status = CHNL_E_BADCHANID;
@@ -804,7 +804,7 @@ dsp_status bridge_chnl_open(OUT struct chnl_object **phChnl,
                status = DSP_EINVALIDARG;
        } else {
                if (!MEM_IS_VALID_HANDLE(hchnl_mgr, CHNL_MGRSIGNATURE)) {
-                       status = DSP_EHANDLE;
+                       status = EFAULT;
                } else {
                        if (uChnlId != CHNL_PICKFREE) {
                                if (uChnlId >= chnl_mgr_obj->max_channels)
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 47afbf8..8de2adf 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -182,12 +182,12 @@ dsp_status bridge_io_create(OUT struct io_mgr **phIOMgr,

        /* Check requirements */
        if (!phIOMgr || !pMgrAttrs || pMgrAttrs->word_size == 0) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_end;
        }
        dev_get_chnl_mgr(hdev_obj, &hchnl_mgr);
        if (!hchnl_mgr || hchnl_mgr->hio_mgr) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_end;
        }
        /*
@@ -197,7 +197,7 @@ dsp_status bridge_io_create(OUT struct io_mgr **phIOMgr,
         */
        dev_get_wmd_context(hdev_obj, &hwmd_context);
        if (!hwmd_context) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_end;
        }
        dev_get_dev_type(hdev_obj, &dev_type);
@@ -286,7 +286,7 @@ dsp_status bridge_io_destroy(struct io_mgr *hio_mgr)
                /* Free this IO manager object */
                MEM_FREE_OBJECT(hio_mgr);
        } else {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }

        return status;
@@ -347,7 +347,7 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
        hmsg_mgr = hio_mgr->hmsg_mgr;
        if (!MEM_IS_VALID_HANDLE(hchnl_mgr, CHNL_MGRSIGNATURE) ||
            !MEM_IS_VALID_HANDLE(hmsg_mgr, MSGMGR_SIGNATURE)) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_end;
        }
        if (hio_mgr->shared_mem)
diff --git a/drivers/dsp/bridge/wmd/msg_sm.c b/drivers/dsp/bridge/wmd/msg_sm.c
index 4b65b8b..91df9a8 100644
--- a/drivers/dsp/bridge/wmd/msg_sm.c
+++ b/drivers/dsp/bridge/wmd/msg_sm.c
@@ -132,7 +132,7 @@ dsp_status bridge_msg_create_queue(struct msg_mgr *hmsg_mgr,

        if (!MEM_IS_VALID_HANDLE(hmsg_mgr, MSGMGR_SIGNATURE) ||
            phMsgQueue == NULL || !hmsg_mgr->msg_free_list) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_end;
        }

@@ -285,7 +285,7 @@ dsp_status bridge_msg_get(struct msg_queue *msg_queue_obj,

        hmsg_mgr = msg_queue_obj->hmsg_mgr;
        if (!msg_queue_obj->msg_used_list) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_end;
        }

@@ -382,7 +382,7 @@ dsp_status bridge_msg_put(struct msg_queue *msg_queue_obj,
        }
        hmsg_mgr = msg_queue_obj->hmsg_mgr;
        if (!hmsg_mgr->msg_free_list) {
-               status = DSP_EHANDLE;
+               status = EFAULT;
                goto func_end;
        }

diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index d90518a..b9fb61c 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -1175,7 +1175,7 @@ static dsp_status bridge_dev_destroy(struct wmd_dev_context *hDevContext)

        /* It should never happen */
        if (!hDevContext)
-               return DSP_EHANDLE;
+               return EFAULT;

        /* first put the device to stop state */
        wmd_brd_delete(dev_context);
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 9174a80..37cd470 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -431,7 +431,7 @@ dsp_status post_scale_dsp(struct wmd_dev_context *dev_context, IN void *pargs)

        status = dev_get_io_mgr(dev_context->hdev_obj, &hio_mgr);
        if (!hio_mgr)
-               return DSP_EHANDLE;
+               return EFAULT;

        voltage_domain = *((u32 *) pargs);
        level = *((u32 *) pargs + 1);
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index b88112e..d8d2f6a 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -311,7 +311,7 @@ dsp_status bridge_deh_get_info(struct deh_mgr *hdeh_mgr,
                pErrInfo->dw_val2 = deh_mgr_obj->err_info.dw_val2;
                pErrInfo->dw_val3 = deh_mgr_obj->err_info.dw_val3;
        } else {
-               status = DSP_EHANDLE;
+               status = EFAULT;
        }

        return status;
--
1.6.0.4

