From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC][PATCH 6/19] DSPBRIDGE: Cleanup custom error code (DSP_ENOMEM
 -> ENOMEM)
Date: Fri, 26 Mar 2010 01:36:29 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DEBEB22@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50120 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754667Ab0CYUGn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 16:06:43 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

>From 0a93e5f20456158f3ec2dec935ece24da0c480d0 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Tue, 23 Mar 2010 11:53:55 -0600
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code (DSP_ENOMEM -> ENOMEM)

This patch replaces DSP_ENOMEM with ENOMEM.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/chnl.h     |    2 +-
 arch/arm/plat-omap/include/dspbridge/cmm.h      |    4 +-
 arch/arm/plat-omap/include/dspbridge/dbdcd.h    |    6 ++--
 arch/arm/plat-omap/include/dspbridge/dblldefs.h |    4 +-
 arch/arm/plat-omap/include/dspbridge/dev.h      |    4 +-
 arch/arm/plat-omap/include/dspbridge/disp.h     |    2 +-
 arch/arm/plat-omap/include/dspbridge/drv.h      |    2 +-
 arch/arm/plat-omap/include/dspbridge/errbase.h  |    3 --
 arch/arm/plat-omap/include/dspbridge/io.h       |    2 +-
 arch/arm/plat-omap/include/dspbridge/mgr.h      |    2 +-
 arch/arm/plat-omap/include/dspbridge/nldrdefs.h |    8 +++---
 arch/arm/plat-omap/include/dspbridge/node.h     |   12 +++++-----
 arch/arm/plat-omap/include/dspbridge/ntfy.h     |    4 +-
 arch/arm/plat-omap/include/dspbridge/proc.h     |    4 +-
 arch/arm/plat-omap/include/dspbridge/rmm.h      |    4 +-
 arch/arm/plat-omap/include/dspbridge/strm.h     |    6 ++--
 arch/arm/plat-omap/include/dspbridge/sync.h     |    8 +++---
 arch/arm/plat-omap/include/dspbridge/wmd.h      |   22 +++++++++---------
 drivers/dsp/bridge/pmgr/cmm.c                   |   14 ++++++------
 drivers/dsp/bridge/pmgr/cod.c                   |    4 +-
 drivers/dsp/bridge/pmgr/dbll.c                  |   12 +++++-----
 drivers/dsp/bridge/pmgr/dev.c                   |    2 +-
 drivers/dsp/bridge/pmgr/dmm.c                   |    6 ++--
 drivers/dsp/bridge/pmgr/wcd.c                   |   24 ++++++++++----------
 drivers/dsp/bridge/rmgr/dbdcd.c                 |   10 ++++----
 drivers/dsp/bridge/rmgr/disp.c                  |    4 +-
 drivers/dsp/bridge/rmgr/drv.c                   |   10 ++++----
 drivers/dsp/bridge/rmgr/mgr.c                   |    2 +-
 drivers/dsp/bridge/rmgr/nldr.c                  |   26 +++++++++++-----------
 drivers/dsp/bridge/rmgr/node.c                  |   24 ++++++++++----------
 drivers/dsp/bridge/rmgr/proc.c                  |    6 ++--
 drivers/dsp/bridge/rmgr/rmm.c                   |   14 ++++++------
 drivers/dsp/bridge/rmgr/strm.c                  |   10 ++++----
 drivers/dsp/bridge/services/ntfy.c              |    6 ++--
 drivers/dsp/bridge/services/sync.c              |    8 +++---
 drivers/dsp/bridge/wmd/chnl_sm.c                |   10 ++++----
 drivers/dsp/bridge/wmd/io_sm.c                  |   14 ++++++------
 drivers/dsp/bridge/wmd/msg_sm.c                 |   16 +++++++-------
 drivers/dsp/bridge/wmd/tiomap3430.c             |   10 ++++----
 drivers/dsp/bridge/wmd/ue_deh.c                 |    2 +-
 40 files changed, 165 insertions(+), 168 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/chnl.h b/arch/arm/plat-omap/include/dspbridge/chnl.h
index 48e2aaf..cbf96c9 100644
--- a/arch/arm/plat-omap/include/dspbridge/chnl.h
+++ b/arch/arm/plat-omap/include/dspbridge/chnl.h
@@ -62,7 +62,7 @@ extern dsp_status chnl_close(struct chnl_object *chnl_obj);
  *      DSP_SOK:                Success;
  *      EFAULT:            hdev_obj is invalid.
  *      EINVAL:        max_channels is 0.
- *      DSP_EMEMORY:            Insufficient memory for requested resources.
+ *      ENOMEM:            Insufficient memory for requested resources.
  *      CHNL_E_ISR:             Unable to plug channel ISR for configured IRQ.
  *      CHNL_E_MAXCHANNELS:     This manager cannot handle this many channels.
  *      CHNL_E_INVALIDIRQ:      Invalid IRQ number. Must be 0 <= birq <= 15.
diff --git a/arch/arm/plat-omap/include/dspbridge/cmm.h b/arch/arm/plat-omap/include/dspbridge/cmm.h
index 5fc8f97..41a5834 100644
--- a/arch/arm/plat-omap/include/dspbridge/cmm.h
+++ b/arch/arm/plat-omap/include/dspbridge/cmm.h
@@ -75,7 +75,7 @@ extern void *cmm_calloc_buf(struct cmm_object *hcmm_mgr,
  *      pMgrAttrs:  Comm mem manager attributes.
  *  Returns:
  *      DSP_SOK:        Success;
- *      DSP_EMEMORY:    Insufficient memory for requested resources.
+ *      ENOMEM:    Insufficient memory for requested resources.
  *      DSP_EFAIL:      Failed to initialize critical sect sync object.
  *
  *  Requires:
@@ -287,7 +287,7 @@ extern void *cmm_xlator_alloc_buf(struct cmm_xlatorobject *xlator,
  *  Returns:
  *     DSP_SOK:            Success.
  *     EINVAL:    Bad input Attrs.
- *     DSP_EMEMORY:   Insufficient memory(local) for requested resources.
+ *     ENOMEM:   Insufficient memory(local) for requested resources.
  *  Requires:
  *     phXlator != NULL
  *     hcmm_mgr != NULL
diff --git a/arch/arm/plat-omap/include/dspbridge/dbdcd.h b/arch/arm/plat-omap/include/dspbridge/dbdcd.h
index 1de9d18..2d0dd60 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbdcd.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdcd.h
@@ -84,7 +84,7 @@ extern dsp_status dcd_auto_unregister(IN struct dcd_manager *hdcd_mgr,
  *      phDcdMgr:       A pointer to a DCD manager handle.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EMEMORY:    Unable to allocate memory for DCD manager handle.
+ *      ENOMEM:    Unable to allocate memory for DCD manager handle.
  *      DSP_EFAIL:      General failure.
  *  Requires:
  *      DCD initialized.
@@ -163,7 +163,7 @@ extern void dcd_exit(void);
  *      phase: phase to obtain correct input library
  *  Returns:
  *      DSP_SOK: Success.
- *      DSP_EMEMORY: Memory allocation failure.
+ *      ENOMEM: Memory allocation failure.
  *      DSP_EDCDREADSECT: Failure to read section containing library info.
  *      DSP_EFAIL: General failure.
  *  Requires:
@@ -193,7 +193,7 @@ extern dsp_status dcd_get_dep_libs(IN struct dcd_manager *hdcd_mgr,
  *      phase:          Phase to obtain correct input library
  *  Returns:
  *      DSP_SOK: Success.
- *      DSP_EMEMORY: Memory allocation failure.
+ *      ENOMEM: Memory allocation failure.
  *      DSP_EDCDREADSECT: Failure to read section containing library info.
  *      DSP_EFAIL: General failure.
  *  Requires:
diff --git a/arch/arm/plat-omap/include/dspbridge/dblldefs.h b/arch/arm/plat-omap/include/dspbridge/dblldefs.h
index e223518..b9ad305 100644
--- a/arch/arm/plat-omap/include/dspbridge/dblldefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dblldefs.h
@@ -196,7 +196,7 @@ typedef void (*dbll_close_fxn) (struct dbll_library_obj *library);
  *      pattrs          - Attributes.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EMEMORY:    Memory allocation failed.
+ *      ENOMEM:    Memory allocation failed.
  *  Requires:
  *      DBL initialized.
  *      pattrs != NULL.
@@ -384,7 +384,7 @@ typedef dsp_status(*dbll_load_sect_fxn) (struct dbll_library_obj *lib,
  *      pLib            - Location to store library handle on output.
  *  Returns:
  *      DSP_SOK:            Success.
- *      DSP_EMEMORY:        Memory allocation failure.
+ *      ENOMEM:        Memory allocation failure.
  *      DSP_EFOPEN:         File open failure.
  *      DSP_EFREAD:         File read failure.
  *      DSP_ECORRUPTFILE:   Unable to determine target type.
diff --git a/arch/arm/plat-omap/include/dspbridge/dev.h b/arch/arm/plat-omap/include/dspbridge/dev.h
index 26cf971..5f2e15a 100644
--- a/arch/arm/plat-omap/include/dspbridge/dev.h
+++ b/arch/arm/plat-omap/include/dspbridge/dev.h
@@ -75,7 +75,7 @@ extern u32 dev_brd_write_fxn(void *pArb,
  *      dev_node_obj:       Platform (Windows) specific device node.
  *  Returns:
  *      DSP_SOK:            Module is loaded, device object has been created
- *      DSP_EMEMORY:        Insufficient memory to create needed resources.
+ *      ENOMEM:        Insufficient memory to create needed resources.
  *      DEV_E_NEWWMD:       The WMD was compiled for a newer version of WCD.
  *      DEV_E_NULLWMDINTF:  WMD passed back a NULL fxn Interface Struct Ptr
  *      DEV_E_NOCODMODULE:  No ZL file name was specified in the registry
@@ -120,7 +120,7 @@ extern dsp_status dev_create_device(OUT struct dev_object
  *      dev_node_obj:       Platform (Windows) specific device node.
  *  Returns:
  *      DSP_SOK:            Module is loaded, device object has been created
- *      DSP_EMEMORY:        Insufficient memory to create needed resources.
+ *      ENOMEM:        Insufficient memory to create needed resources.
  *      DEV_E_NEWWMD:       The WMD was compiled for a newer version of WCD.
  *      DEV_E_NULLWMDINTF:  WMD passed back a NULL fxn Interface Struct Ptr
  *      DEV_E_NOCODMODULE:  No ZL file name was specified in the registry
diff --git a/arch/arm/plat-omap/include/dspbridge/disp.h b/arch/arm/plat-omap/include/dspbridge/disp.h
index a6c8054..81b6b38 100644
--- a/arch/arm/plat-omap/include/dspbridge/disp.h
+++ b/arch/arm/plat-omap/include/dspbridge/disp.h
@@ -37,7 +37,7 @@
  *      pDispAttrs:     Node dispatcher attributes.
  *  Returns:
  *      DSP_SOK:                Success;
- *      DSP_EMEMORY:            Insufficient memory for requested resources.
+ *      ENOMEM:            Insufficient memory for requested resources.
  *      DSP_EFAIL:              Unable to create dispatcher.
  *  Requires:
  *      disp_init(void) called.
diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-omap/include/dspbridge/drv.h
index 41deb86..95272ac 100644
--- a/arch/arm/plat-omap/include/dspbridge/drv.h
+++ b/arch/arm/plat-omap/include/dspbridge/drv.h
@@ -159,7 +159,7 @@ struct process_context {
  *      phDrvObject:    Location to store created DRV Object handle.
  *  Returns:
  *      DSP_SOK:        Sucess
- *      DSP_EMEMORY:    Failed in Memory allocation
+ *      ENOMEM:    Failed in Memory allocation
  *      DSP_EFAIL:      General Failure
  *  Requires:
  *      DRV Initialized (refs > 0 )
diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index 3ce4c6f..2ba76d4 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -90,9 +90,6 @@
 /* A general failure occurred */
 #define DSP_EFAIL                   (DSP_EBASE + 8)

-/* A memory allocation failure occurred. */
-#define DSP_EMEMORY                 (DSP_EBASE + 0xc)
-
 /* The requested operation is invalid for this node type. */
 #define DSP_ENODETYPE               (DSP_EBASE + 0xd)

diff --git a/arch/arm/plat-omap/include/dspbridge/io.h b/arch/arm/plat-omap/include/dspbridge/io.h
index a1a4e64..984d88a 100644
--- a/arch/arm/plat-omap/include/dspbridge/io.h
+++ b/arch/arm/plat-omap/include/dspbridge/io.h
@@ -39,7 +39,7 @@
  *      pMgrAttrs->word_size:   DSP Word size in equivalent PC bytes..
  *  Returns:
  *      DSP_SOK:                Success;
- *      DSP_EMEMORY:            Insufficient memory for requested resources.
+ *      ENOMEM:            Insufficient memory for requested resources.
  *      CHNL_E_ISR:             Unable to plug channel ISR for configured IRQ.
  *      CHNL_E_INVALIDIRQ:      Invalid IRQ number. Must be 0 <= birq <= 15.
  *      CHNL_E_INVALIDWORDSIZE: Invalid DSP word size.  Must be > 0.
diff --git a/arch/arm/plat-omap/include/dspbridge/mgr.h b/arch/arm/plat-omap/include/dspbridge/mgr.h
index df20ccc..c2e841c 100644
--- a/arch/arm/plat-omap/include/dspbridge/mgr.h
+++ b/arch/arm/plat-omap/include/dspbridge/mgr.h
@@ -53,7 +53,7 @@ dsp_status mgr_wait_for_bridge_events(struct dsp_notification
  *      dev_node_obj:       Device object as known to Windows system.
  *  Returns:
  *      DSP_SOK:        Success
- *      DSP_EMEMORY:    Failed to Create the Object
+ *      ENOMEM:    Failed to Create the Object
  *      DSP_EFAIL:      General Failure
  *  Requires:
  *      MGR Initialized (refs > 0 )
diff --git a/arch/arm/plat-omap/include/dspbridge/nldrdefs.h b/arch/arm/plat-omap/include/dspbridge/nldrdefs.h
index e55634b..11677a0 100644
--- a/arch/arm/plat-omap/include/dspbridge/nldrdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/nldrdefs.h
@@ -117,7 +117,7 @@ enum nldr_phase {
  *      pf_phase_split:   pointer to boolean variable referenced in node.c
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EMEMORY:    Insufficient memory on GPP.
+ *      ENOMEM:    Insufficient memory on GPP.
  *  Requires:
  *      nldr_init(void) called.
  *      Valid nldr_obj.
@@ -146,7 +146,7 @@ typedef dsp_status(*nldr_allocatefxn) (struct nldr_object *nldr_obj,
  *      pattrs:         Loader attributes.
  *  Returns:
  *      DSP_SOK:        Success;
- *      DSP_EMEMORY:    Insufficient memory for requested resources.
+ *      ENOMEM:    Insufficient memory for requested resources.
  *  Requires:
  *      nldr_init(void) called.
  *      phNldr != NULL.
@@ -246,7 +246,7 @@ typedef bool(*nldr_initfxn) (void);
  *      phase:          Type of function to load (create, delete, or execute).
  *  Returns:
  *      DSP_SOK:                Success.
- *      DSP_EMEMORY:            Insufficient memory on GPP.
+ *      ENOMEM:            Insufficient memory on GPP.
  *      DSP_EOVERLAYMEMORY:     Can't overlay phase because overlay memory
  *                              is already in use.
  *      DSP_EDYNLOAD:           Failure in dynamic loader library.
@@ -268,7 +268,7 @@ typedef dsp_status(*nldr_loadfxn) (struct nldr_nodeobject *nldr_node_obj,
  *      phase:          Node function to unload (create, delete, or execute).
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EMEMORY:    Insufficient memory on GPP.
+ *      ENOMEM:    Insufficient memory on GPP.
  *  Requires:
  *      nldr_init(void) called.
  *      Valid nldr_node_obj.
diff --git a/arch/arm/plat-omap/include/dspbridge/node.h b/arch/arm/plat-omap/include/dspbridge/node.h
index 4e94151..4f5f356 100644
--- a/arch/arm/plat-omap/include/dspbridge/node.h
+++ b/arch/arm/plat-omap/include/dspbridge/node.h
@@ -39,7 +39,7 @@
  *      ph_node:             Location to store node handle on output.
  *  Returns:
  *      DSP_SOK:            Success.
- *      DSP_EMEMORY:        Insufficient memory on GPP.
+ *      ENOMEM:        Insufficient memory on GPP.
  *      DSP_EUUID:          Node UUID has not been registered.
  *      DSP_ESYMBOL:        iAlg functions not found for a DAIS node.
  *      DSP_ERANGE:         attr_in != NULL and attr_in->prio out of
@@ -77,7 +77,7 @@ extern dsp_status node_allocate(struct proc_object *hprocessor,
  *  Returns:
  *      DSP_SOK:        Success.
  *      EFAULT:    Invalid node handle.
- *      DSP_EMEMORY:    Insufficent memory.
+ *      ENOMEM:    Insufficent memory.
  *      DSP_EFAIL:      General Failure.
  *      DSP_ESIZE:      Invalid Size.
  *  Requires:
@@ -166,7 +166,7 @@ extern dsp_status node_close_orphans(struct node_mgr *hnode_mgr,
  *  Returns:
  *      DSP_SOK:                Success.
  *      EFAULT:            Invalid hNode1 or hNode2.
- *      DSP_EMEMORY:            Insufficient host memory.
+ *      ENOMEM:            Insufficient host memory.
  *      DSP_EVALUE:             A stream index parameter is invalid.
  *      DSP_EALREADYCONNECTED:  A connection already exists for one of the
  *                              indices uStream1 or uStream2.
@@ -201,7 +201,7 @@ extern dsp_status node_connect(struct node_object *hNode1,
  *      EFAULT:        Invalid hnode.
  *      DSP_ESYMBOL:        Create function not found in the COFF file.
  *      DSP_EWRONGSTATE:    Node is not in the NODE_ALLOCATED state.
- *      DSP_EMEMORY:        Memory allocation failure on the DSP.
+ *      ENOMEM:        Memory allocation failure on the DSP.
  *      DSP_ETASK:          Unable to create node's task or process on the DSP.
  *      DSP_ESTREAM:        Stream creation failure on the DSP.
  *      DSP_ETIMEOUT:       A timeout occurred before the DSP responded.
@@ -226,7 +226,7 @@ extern dsp_status node_create(struct node_object *hnode);
  *      hdev_obj:     Device for this processor.
  *  Returns:
  *      DSP_SOK:        Success;
- *      DSP_EMEMORY:    Insufficient memory for requested resources.
+ *      ENOMEM:    Insufficient memory for requested resources.
  *      DSP_EFAIL:      General failure.
  *  Requires:
  *      node_init(void) called.
@@ -491,7 +491,7 @@ extern dsp_status node_put_message(struct node_object *hnode,
  *  Returns:
  *      DSP_SOK:        Success.
  *      EFAULT:    Invalid hnode.
- *      DSP_EMEMORY:    Insufficient memory on GPP.
+ *      ENOMEM:    Insufficient memory on GPP.
  *      DSP_EVALUE:     event_mask is invalid.
  *      DSP_ENOTIMPL:   Notification type specified by notify_type is not
  *                      supported.
diff --git a/arch/arm/plat-omap/include/dspbridge/ntfy.h b/arch/arm/plat-omap/include/dspbridge/ntfy.h
index ab1011c..e7d44eb 100644
--- a/arch/arm/plat-omap/include/dspbridge/ntfy.h
+++ b/arch/arm/plat-omap/include/dspbridge/ntfy.h
@@ -29,7 +29,7 @@ struct ntfy_object;
  *      phNtfy:         Location to store handle on output.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EMEMORY:    Memory allocation failure.
+ *      ENOMEM:    Memory allocation failure.
  *  Requires:
  *      ntfy_init(void) called.
  *      phNtfy != NULL.
@@ -106,7 +106,7 @@ extern void ntfy_notify(IN struct ntfy_object *ntfy_obj, IN u32 event_mask);
  *      notify_type:        Type of notification: DSP_SIGNALEVENT.
  *  Returns:
  *      DSP_SOK:            Success.
- *      DSP_EMEMORY:        Insufficient memory.
+ *      ENOMEM:        Insufficient memory.
  *      DSP_EVALUE:         event_mask is 0 and hnotification was not
  *                          previously registered.
  *      EFAULT:        NULL hnotification, hnotification event name
diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/plat-omap/include/dspbridge/proc.h
index ddb3aec..fa748fe 100644
--- a/arch/arm/plat-omap/include/dspbridge/proc.h
+++ b/arch/arm/plat-omap/include/dspbridge/proc.h
@@ -512,7 +512,7 @@ extern dsp_status proc_invalidate_memory(void *hprocessor,
  *      DSP_SOK         :   Success.
  *      EFAULT     :   Invalid processor handle.
  *      DSP_EFAIL       :   General failure.
- *      DSP_EMEMORY     :   MPU side memory allocation error.
+ *      ENOMEM     :   MPU side memory allocation error.
  *      DSP_ENOTFOUND   :   Cannot find a reserved region starting with this
  *                   :   address.
  *  Requires:
@@ -542,7 +542,7 @@ extern dsp_status proc_map(void *hprocessor,
  *      DSP_SOK         :   Success.
  *      EFAULT     :   Invalid processor handle.
  *      DSP_EFAIL       :   General failure.
- *      DSP_EMEMORY     :   Cannot reserve chunk of this size.
+ *      ENOMEM     :   Cannot reserve chunk of this size.
  *  Requires:
  *      pp_rsv_addr is not NULL
  *      PROC Initialized.
diff --git a/arch/arm/plat-omap/include/dspbridge/rmm.h b/arch/arm/plat-omap/include/dspbridge/rmm.h
index b22b5c5..12c390d 100644
--- a/arch/arm/plat-omap/include/dspbridge/rmm.h
+++ b/arch/arm/plat-omap/include/dspbridge/rmm.h
@@ -62,7 +62,7 @@ struct rmm_target_obj;
  *      reserve         - If TRUE, reserve the memory specified by dspAddr.
  *  Returns:
  *      DSP_SOK:                Success.
- *      DSP_EMEMORY:            Memory allocation on GPP failed.
+ *      ENOMEM:            Memory allocation on GPP failed.
  *      DSP_EOVERLAYMEMORY:     Cannot "allocate" overlay memory because it's
  *                              already in use.
  *  Requires:
@@ -88,7 +88,7 @@ extern dsp_status rmm_alloc(struct rmm_target_obj *target, u32 segid, u32 size,
  *      num_segs:        - Number of memory segments.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EMEMORY:    Memory allocation failed.
+ *      ENOMEM:    Memory allocation failed.
  *  Requires:
  *      RMM initialized.
  *      target_obj != NULL.
diff --git a/arch/arm/plat-omap/include/dspbridge/strm.h b/arch/arm/plat-omap/include/dspbridge/strm.h
index caebf8a..4b1ce21 100644
--- a/arch/arm/plat-omap/include/dspbridge/strm.h
+++ b/arch/arm/plat-omap/include/dspbridge/strm.h
@@ -36,7 +36,7 @@
  *  Returns:
  *      DSP_SOK:        Success.
  *      EFAULT:    Invalid hStrm.
- *      DSP_EMEMORY:    Insufficient memory.
+ *      ENOMEM:    Insufficient memory.
  *      DSP_EFAIL:      Failure occurred, unable to allocate buffers.
  *      DSP_ESIZE:      usize must be > 0 bytes.
  *  Requires:
@@ -80,7 +80,7 @@ extern dsp_status strm_close(struct strm_object *hStrm,
  *      dev_obj:           Device for this processor.
  *  Returns:
  *      DSP_SOK:        Success;
- *      DSP_EMEMORY:    Insufficient memory for requested resources.
+ *      ENOMEM:    Insufficient memory for requested resources.
  *      DSP_EFAIL:      General failure.
  *  Requires:
  *      strm_init(void) called.
@@ -338,7 +338,7 @@ extern dsp_status strm_reclaim(struct strm_object *hStrm,
  *  Returns:
  *      DSP_SOK:        Success.
  *      EFAULT:    Invalid hStrm.
- *      DSP_EMEMORY:    Insufficient memory on GPP.
+ *      ENOMEM:    Insufficient memory on GPP.
  *      DSP_EVALUE:     event_mask is invalid.
  *      DSP_ENOTIMPL:   Notification type specified by notify_type is not
  *                      supported.
diff --git a/arch/arm/plat-omap/include/dspbridge/sync.h b/arch/arm/plat-omap/include/dspbridge/sync.h
index e73bda0..30c71c8 100644
--- a/arch/arm/plat-omap/include/dspbridge/sync.h
+++ b/arch/arm/plat-omap/include/dspbridge/sync.h
@@ -127,7 +127,7 @@ extern bool sync_init(void);
  *      hcs_obj: critical section handle.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EMEMORY:    Out of memory.
+ *      ENOMEM:    Out of memory.
  *  Requires:
  *  Ensures:
  */
@@ -141,7 +141,7 @@ extern dsp_status sync_initialize_cs(OUT struct sync_csobject **phCSObj);
  *      hcs_obj: critical section handle.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EMEMORY:    Out of memory.
+ *      ENOMEM:    Out of memory.
  *  Requires:
  *  Ensures:
  */
@@ -185,7 +185,7 @@ extern dsp_status sync_leave_cs(IN struct sync_csobject *hcs_obj);
  *  Returns:
  *      DSP_SOK:        Success.
  *      DSP_EFAIL:      Unable to create user mode event.
- *      DSP_EMEMORY:    Insufficient memory.
+ *      ENOMEM:    Insufficient memory.
  *      EINVAL sync_attrs values are invalid.
  *  Requires:
  *      - SYNC initialized.
@@ -290,7 +290,7 @@ extern dsp_status sync_wait_on_event(IN struct sync_object *event_obj,
  *      DSP_SOK:        The object was signalled.
  *      SYNC_E_FAIL:    Wait failed, possibly because the process terminated.
  *      SYNC_E_TIMEOUT: Timeout expired before event was signalled.
- *      DSP_EMEMORY:    Memory allocation failed.
+ *      ENOMEM:    Memory allocation failed.
  *  Requires:
  *  Ensures:
  */
diff --git a/arch/arm/plat-omap/include/dspbridge/wmd.h b/arch/arm/plat-omap/include/dspbridge/wmd.h
index 6bfc496..91f41a8 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmd.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmd.h
@@ -308,7 +308,7 @@ typedef dsp_status(*fxn_brd_write) (struct wmd_dev_context *hDevContext,
  *      pMgrAttrs->usm_length: Bytes of shared memory block.
  *  Returns:
  *      DSP_SOK:            Success;
- *      DSP_EMEMORY:        Insufficient memory for requested resources.
+ *      ENOMEM:        Insufficient memory for requested resources.
  *      CHNL_E_ISR:         Unable to plug ISR for given IRQ.
  *      CHNL_E_NOMEMMAP:    Couldn't map physical address to a virtual one.
  *  Requires:
@@ -390,7 +390,7 @@ typedef void (*fxn_deh_notify) (struct deh_mgr *hdeh_mgr,
  *  Returns:
  *      DSP_SOK:                Success.
  *      EFAULT:            hchnl_mgr is invalid.
- *      DSP_EMEMORY:            Insufficient memory for requested resources.
+ *      ENOMEM:            Insufficient memory for requested resources.
  *      EINVAL:        Invalid number of IOReqs.
  *      CHNL_E_OUTOFSTREAMS:    No free channels available.
  *      CHNL_E_BADCHANID:       Channel ID is out of range.
@@ -630,7 +630,7 @@ typedef dsp_status(*fxn_chnl_idle) (struct chnl_object *chnl_obj,
  *      hnotification:  Handle of a dsp_notification object.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EMEMORY:    Insufficient memory.
+ *      ENOMEM:    Insufficient memory.
  *      DSP_EVALUE:     event_mask is 0 and hnotification was not
  *                      previously registered.
  *      EFAULT:    NULL hnotification, hnotification event name
@@ -659,7 +659,7 @@ typedef dsp_status(*fxn_chnl_registernotify)
  *                      device.
  *  Returns:
  *      DSP_SOK:            Success.
- *      DSP_EMEMORY:        Unable to allocate memory for device context.
+ *      ENOMEM:        Unable to allocate memory for device context.
  *      WMD_E_BADCONFIG:    One or more of the host or DSP configuration
  *                          parameters did not satisfy hardware assumptions
  *                          made by this WMD.
@@ -672,7 +672,7 @@ typedef dsp_status(*fxn_chnl_registernotify)
  *  Ensures:
  *      DSP_SOK:        All mini-driver specific DSP resource and other
  *                      board context has been allocated.
- *      DSP_EMEMORY:    WMD failed to allocate resources.
+ *      ENOMEM:    WMD failed to allocate resources.
  *                      Any acquired resources have been freed.  The WCD will
  *                      not call bridge_dev_destroy() if bridge_dev_create()
  *                      fails.
@@ -740,7 +740,7 @@ typedef dsp_status(*fxn_dev_destroy) (struct wmd_dev_context *hDevContext);
  *      hdev_obj:     Handle to DEV object.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EMEMORY:    Memory allocation failure.
+ *      ENOMEM:    Memory allocation failure.
  *      DSP_EFAIL:      Creation failed.
  *  Requires:
  *      hdev_obj != NULL;
@@ -810,7 +810,7 @@ typedef dsp_status(*fxn_deh_getinfo) (struct deh_mgr *phDehMgr,
  *      hmsg_mgr:        Handle to message manager.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EMEMORY:    Memory allocation failure.
+ *      ENOMEM:    Memory allocation failure.
  *      DSP_EFAIL:      Creation failed.
  *  Requires:
  *      hdev_obj != NULL;
@@ -832,7 +832,7 @@ typedef dsp_status(*fxn_io_create) (OUT struct io_mgr **phIOMgr,
  *      hio_mgr:         IO Manager.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EMEMORY:    Memory allocation failure.
+ *      ENOMEM:    Memory allocation failure.
  *      DSP_EFAIL:      Creation failed.
  *  Requires:
  *      Valid hio_mgr;
@@ -886,7 +886,7 @@ typedef dsp_status(*fxn_io_getprocload) (struct io_mgr *hio_mgr,
  *      msgCallback:        Called whenever an RMS_EXIT message is received.
  *  Returns:
  *      DSP_SOK:            Success.
- *      DSP_EMEMORY:        Insufficient memory.
+ *      ENOMEM:        Insufficient memory.
  *  Requires:
  *      phMsgMgr != NULL.
  *      msgCallback != NULL.
@@ -911,7 +911,7 @@ typedef dsp_status(*fxn_msg_create)
  *      h:                  Handle passed to hmsg_mgr->msgCallback().
  *  Returns:
  *      DSP_SOK:            Success.
- *      DSP_EMEMORY:        Insufficient memory.
+ *      ENOMEM:        Insufficient memory.
  *  Requires:
  *      phMsgQueue != NULL.
  *      h != NULL.
@@ -1007,7 +1007,7 @@ typedef dsp_status(*fxn_msg_put) (struct msg_queue *msg_queue_obj,
  *      hnotification:  Handle of notification object.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EMEMORY:    Insufficient memory.
+ *      ENOMEM:    Insufficient memory.
  *  Requires:
  *      Valid msg_queue_obj.
  *      hnotification != NULL.
diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c
index 14a75b3..84bec40 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -290,7 +290,7 @@ dsp_status cmm_create(OUT struct cmm_object **ph_cmm_mgr,
                                        mem_calloc(sizeof(struct lst_list),
                                                   MEM_NONPAGED);
                        if (cmm_obj->node_free_list_head == NULL)
-                               status = DSP_EMEMORY;
+                               status = ENOMEM;
                        else
                                INIT_LIST_HEAD(&cmm_obj->
                                               node_free_list_head->head);
@@ -304,7 +304,7 @@ dsp_status cmm_create(OUT struct cmm_object **ph_cmm_mgr,
                        cmm_destroy(cmm_obj, true);

        } else {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
        }
        return status;
 }
@@ -613,7 +613,7 @@ dsp_status cmm_register_gppsm_seg(struct cmm_object *hcmm_mgr,
                                                                 lst_list),
                                                          MEM_NONPAGED);
                        if (psma->free_list_head == NULL) {
-                               status = DSP_EMEMORY;
+                               status = ENOMEM;
                                goto func_end;
                        }
                        INIT_LIST_HEAD(&psma->free_list_head->head);
@@ -624,7 +624,7 @@ dsp_status cmm_register_gppsm_seg(struct cmm_object *hcmm_mgr,
                                                                   lst_list),
                                                            MEM_NONPAGED);
                        if (psma->in_use_list_head == NULL) {
-                               status = DSP_EMEMORY;
+                               status = ENOMEM;
                                goto func_end;
                        }
                        INIT_LIST_HEAD(&psma->in_use_list_head->head);
@@ -638,7 +638,7 @@ dsp_status cmm_register_gppsm_seg(struct cmm_object *hcmm_mgr,
                                lst_put_tail(psma->free_list_head,
                                             (struct list_head *)new_node);
                        } else {
-                               status = DSP_EMEMORY;
+                               status = ENOMEM;
                                goto func_end;
                        }
                }
@@ -647,7 +647,7 @@ dsp_status cmm_register_gppsm_seg(struct cmm_object *hcmm_mgr,
                        un_register_gppsm_seg(psma);
                }
        } else {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
                goto func_end;
        }
        /* make entry */
@@ -989,7 +989,7 @@ dsp_status cmm_xlator_create(OUT struct cmm_xlatorobject **phXlator,
                /* SM seg_id */
                xlator_object->ul_seg_id = pXlatorAttrs->ul_seg_id;
        } else {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
        }
        if (DSP_SUCCEEDED(status))
                *phXlator = (struct cmm_xlatorobject *)xlator_object;
diff --git a/drivers/dsp/bridge/pmgr/cod.c b/drivers/dsp/bridge/pmgr/cod.c
index aa759ca..746a6df 100644
--- a/drivers/dsp/bridge/pmgr/cod.c
+++ b/drivers/dsp/bridge/pmgr/cod.c
@@ -236,7 +236,7 @@ dsp_status cod_create(OUT struct cod_manager **phMgr, char *pstrDummyFile,

        mgr_new = mem_calloc(sizeof(struct cod_manager), MEM_NONPAGED);
        if (mgr_new == NULL)
-               return DSP_EMEMORY;
+               return ENOMEM;

        mgr_new->ul_magic = MAGIC;

@@ -568,7 +568,7 @@ dsp_status cod_open(struct cod_manager *hmgr, IN char *pszCoffPath,

        lib = mem_calloc(sizeof(struct cod_libraryobj), MEM_NONPAGED);
        if (lib == NULL)
-               status = DSP_EMEMORY;
+               status = ENOMEM;

        if (DSP_SUCCEEDED(status)) {
                lib->cod_mgr = hmgr;
diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index 948fa85..1f1c974 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -260,7 +260,7 @@ dsp_status dbll_create(struct dbll_tar_obj **target_obj,
        if (target_obj != NULL) {
                if (pzl_target == NULL) {
                        *target_obj = NULL;
-                       status = DSP_EMEMORY;
+                       status = ENOMEM;
                } else {
                        pzl_target->attrs = *pattrs;
                        *target_obj = (struct dbll_tar_obj *)pzl_target;
@@ -489,7 +489,7 @@ dsp_status dbll_load(struct dbll_library_obj *lib, dbll_flags flags,
                                                    name_hash,
                                                    name_match, sym_delete);
                        if (zl_lib->sym_tab == NULL)
-                               status = DSP_EMEMORY;
+                               status = ENOMEM;

                }
                /*
@@ -623,7 +623,7 @@ dsp_status dbll_open(struct dbll_tar_obj *target, char *file, dbll_flags flags,
                MEM_ALLOC_OBJECT(zl_lib, struct dbll_library_obj,
                                 DBLL_LIBSIGNATURE);
                if (zl_lib == NULL) {
-                       status = DSP_EMEMORY;
+                       status = ENOMEM;
                } else {
                        zl_lib->ul_pos = 0;
                        /* Increment ref count to allow close on failure
@@ -634,7 +634,7 @@ dsp_status dbll_open(struct dbll_tar_obj *target, char *file, dbll_flags flags,
                        zl_lib->file_name = mem_calloc(strlen(file) + 1,
                                                       MEM_PAGED);
                        if (zl_lib->file_name == NULL) {
-                               status = DSP_EMEMORY;
+                               status = ENOMEM;
                        } else {
                                strncpy(zl_lib->file_name, file,
                                        strlen(file) + 1);
@@ -685,7 +685,7 @@ dsp_status dbll_open(struct dbll_tar_obj *target, char *file, dbll_flags flags,
            gh_create(MAXBUCKETS, sizeof(struct dbll_symbol), name_hash,
                      name_match, sym_delete);
        if (zl_lib->sym_tab == NULL) {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
        } else {
                /* Do a fake load to get symbols - set write func to no_op */
                zl_lib->init.dl_init.writemem = no_op;
@@ -1275,7 +1275,7 @@ static int dbll_rmm_alloc(struct dynamic_loader_allocate *this,

        if (sz_sect_name == NULL || sz_sec_last_token == NULL ||
            sz_last_token == NULL) {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
                goto func_cont;
        }
        strncpy(sz_sect_name, (char *)(info->name), token_len);
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index f141de8..372692a 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -187,7 +187,7 @@ dsp_status dev_create_device(OUT struct dev_object **phDevObject,
                        DBC_ASSERT(DSP_FAILED(status)
                                   || (dev_obj->hwmd_context != NULL));
                } else {
-                       status = DSP_EMEMORY;
+                       status = ENOMEM;
                }
        }
        /* Attempt to create the COD manager for this device: */
diff --git a/drivers/dsp/bridge/pmgr/dmm.c b/drivers/dsp/bridge/pmgr/dmm.c
index ade59ef..341c9c3 100644
--- a/drivers/dsp/bridge/pmgr/dmm.c
+++ b/drivers/dsp/bridge/pmgr/dmm.c
@@ -105,7 +105,7 @@ dsp_status dmm_create_tables(struct dmm_object *dmm_mgr, u32 addr, u32 size)
                virtual_mapping_table = (struct map_page *)mem_calloc
                    (table_size * sizeof(struct map_page), MEM_LARGEVIRTMEM);
                if (virtual_mapping_table == NULL)
-                       status = DSP_EMEMORY;
+                       status = ENOMEM;
                else {
                        /* On successful allocation,
                         * all entries are zero ('free') */
@@ -146,7 +146,7 @@ dsp_status dmm_create(OUT struct dmm_object **phDmmMgr,
                else
                        dmm_destroy(dmm_obj);
        } else {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
        }

        return status;
@@ -331,7 +331,7 @@ dsp_status dmm_reserve_memory(struct dmm_object *dmm_mgr, u32 size,
                *prsv_addr = rsv_addr;
        } else
                /*dSP chunk of given size is not available */
-               status = DSP_EMEMORY;
+               status = ENOMEM;

        sync_leave_cs(dmm_obj->dmm_lock);

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 2046749..d7185e7 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -424,7 +424,7 @@ u32 mgrwrap_enum_node_info(union Trapped_Args *args, void *pr_ctxt)

        pndb_props = mem_alloc(size, MEM_NONPAGED);
        if (pndb_props == NULL)
-               status = DSP_EMEMORY;
+               status = ENOMEM;

        if (DSP_SUCCEEDED(status)) {
                status =
@@ -456,7 +456,7 @@ u32 mgrwrap_enum_proc_info(union Trapped_Args *args, void *pr_ctxt)

        processor_info = mem_alloc(size, MEM_NONPAGED);
        if (processor_info == NULL)
-               status = DSP_EMEMORY;
+               status = ENOMEM;

        if (DSP_SUCCEEDED(status)) {
                status =
@@ -624,7 +624,7 @@ u32 procwrap_ctrl(union Trapped_Args *args, void *pr_ctxt)
                cb_data_size += sizeof(u32);
                pargs = mem_alloc(cb_data_size, MEM_NONPAGED);
                if (pargs == NULL) {
-                       status = DSP_EMEMORY;
+                       status = ENOMEM;
                        goto func_end;
                }

@@ -775,7 +775,7 @@ u32 procwrap_get_trace(union Trapped_Args *args, void *pr_ctxt)
                                        pbuf,
                                        args->args_proc_gettrace.max_size);
        } else {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
        }
        CP_TO_USR(args->args_proc_gettrace.pbuf, pbuf, status,
                  args->args_proc_gettrace.max_size);
@@ -802,7 +802,7 @@ u32 procwrap_load(union Trapped_Args *args, void *pr_ctxt)

        argv = mem_alloc(count * sizeof(u8 *), MEM_NONPAGED);
        if (!argv) {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
                goto func_cont;
        }

@@ -829,7 +829,7 @@ u32 procwrap_load(union Trapped_Args *args, void *pr_ctxt)
                                        goto func_cont;
                                }
                        } else {
-                               status = DSP_EMEMORY;
+                               status = ENOMEM;
                                goto func_cont;
                        }
                }
@@ -844,7 +844,7 @@ u32 procwrap_load(union Trapped_Args *args, void *pr_ctxt)
                } while (temp);
                envp = mem_alloc(count * sizeof(u8 *), MEM_NONPAGED);
                if (!envp) {
-                       status = DSP_EMEMORY;
+                       status = ENOMEM;
                        goto func_cont;
                }

@@ -869,7 +869,7 @@ u32 procwrap_load(union Trapped_Args *args, void *pr_ctxt)
                                        goto func_cont;
                                }
                        } else {
-                               status = DSP_EMEMORY;
+                               status = ENOMEM;
                                goto func_cont;
                        }
                }
@@ -1044,7 +1044,7 @@ u32 nodewrap_allocate(union Trapped_Args *args, void *pr_ctxt)
                if (DSP_SUCCEEDED(status)) {
                        pargs = mem_alloc(cb_data_size, MEM_NONPAGED);
                        if (pargs == NULL)
-                               status = DSP_EMEMORY;
+                               status = ENOMEM;

                }
                CP_FM_USR(pargs, args->args_node_allocate.pargs, status,
@@ -1060,7 +1060,7 @@ u32 nodewrap_allocate(union Trapped_Args *args, void *pr_ctxt)
                if (DSP_SUCCEEDED(status))
                        attr_in = &proc_attr_in;
                else
-                       status = DSP_EMEMORY;
+                       status = ENOMEM;

        }
        if (DSP_SUCCEEDED(status)) {
@@ -1145,7 +1145,7 @@ u32 nodewrap_connect(union Trapped_Args *args, void *pr_ctxt)
                if (DSP_SUCCEEDED(status)) {
                        pargs = mem_alloc(cb_data_size, MEM_NONPAGED);
                        if (pargs == NULL) {
-                               status = DSP_EMEMORY;
+                               status = ENOMEM;
                                goto func_cont;
                        }

@@ -1361,7 +1361,7 @@ u32 nodewrap_get_uuid_props(union Trapped_Args *args, void *pr_ctxt)
                CP_TO_USR(args->args_node_getuuidprops.node_props, pnode_props,
                          status, 1);
        } else
-               status = DSP_EMEMORY;
+               status = ENOMEM;
 func_cont:
        kfree(pnode_props);
        return status;
diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index 1a0d8a0..23961f9 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -153,7 +153,7 @@ dsp_status dcd_create_manager(IN char *pszZlDllName,
                /* Return handle to this DCD interface. */
                *phDcdMgr = dcd_mgr_obj;
        } else {
-               status = DSP_EMEMORY;
+               status = ENOMEM;

                /*
                 * If allocation of DcdManager object failed, delete the
@@ -164,7 +164,7 @@ dsp_status dcd_create_manager(IN char *pszZlDllName,

        DBC_ENSURE((DSP_SUCCEEDED(status)) || ((cod_mgr == NULL) &&
                                               (status == DSP_EFAIL))
-                  || ((dcd_mgr_obj == NULL) && (status == DSP_EMEMORY)));
+                  || ((dcd_mgr_obj == NULL) && (status == ENOMEM)));

 func_end:
        return status;
@@ -389,7 +389,7 @@ dsp_status dcd_get_object_def(IN struct dcd_manager *hdcd_mgr,

        sz_uuid = (char *)mem_calloc(MAXUUIDLEN, MEM_PAGED);
        if (!sz_uuid) {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
                goto func_end;
        }

@@ -1322,7 +1322,7 @@ static dsp_status get_dep_lib_info(IN struct dcd_manager *hdcd_mgr,
        /* Allocate a buffer for file name */
        psz_file_name = mem_calloc(dw_data_size, MEM_PAGED);
        if (psz_file_name == NULL) {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
        } else {
                /* Get the name of the library */
                status = dcd_get_library_name(hdcd_mgr, uuid_obj, psz_file_name,
@@ -1351,7 +1351,7 @@ static dsp_status get_dep_lib_info(IN struct dcd_manager *hdcd_mgr,
        /* Allocate zeroed buffer. */
        psz_coff_buf = mem_calloc(ul_len + 4, MEM_PAGED);
        if (psz_coff_buf == NULL)
-               status = DSP_EMEMORY;
+               status = ENOMEM;

        /* Read section contents. */
        status = cod_read_section(lib, DEPLIBSECT, psz_coff_buf, ul_len);
diff --git a/drivers/dsp/bridge/rmgr/disp.c b/drivers/dsp/bridge/rmgr/disp.c
index d8e0c84..2bf176c 100644
--- a/drivers/dsp/bridge/rmgr/disp.c
+++ b/drivers/dsp/bridge/rmgr/disp.c
@@ -112,7 +112,7 @@ dsp_status disp_create(OUT struct disp_object **phDispObject,
        /* Allocate Node Dispatcher object */
        MEM_ALLOC_OBJECT(disp_obj, struct disp_object, DISP_SIGNATURE);
        if (disp_obj == NULL)
-               status = DSP_EMEMORY;
+               status = ENOMEM;
        else
                disp_obj->hdev_obj = hdev_obj;

@@ -166,7 +166,7 @@ dsp_status disp_create(OUT struct disp_object **phDispObject,
                disp_obj->ul_bufsize_rms = RMS_COMMANDBUFSIZE;
                disp_obj->pbuf = mem_calloc(disp_obj->ul_bufsize, MEM_PAGED);
                if (disp_obj->pbuf == NULL)
-                       status = DSP_EMEMORY;
+                       status = ENOMEM;
        }
 func_cont:
        if (DSP_SUCCEEDED(status))
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 6f3292c..6b8ba1b 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -454,10 +454,10 @@ dsp_status drv_create(OUT struct drv_object **phDRVObject)
                                INIT_LIST_HEAD(&pdrv_object->dev_list->head);
                        }
                } else {
-                       status = DSP_EMEMORY;
+                       status = ENOMEM;
                }
        } else {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
        }
        /* Store the DRV Object in the Registry */
        if (DSP_SUCCEEDED(status))
@@ -766,7 +766,7 @@ dsp_status drv_request_resources(u32 dw_context, u32 *pDevNodeString)
                        lst_put_tail(pdrv_object->dev_node_string,
                                     (struct list_head *)pszdev_node);
                } else {
-                       status = DSP_EMEMORY;
+                       status = ENOMEM;
                        *pDevNodeString = 0;
                }
        } else {
@@ -933,7 +933,7 @@ static dsp_status request_bridge_resources(u32 dw_context, s32 bRequest)
                        /*  Set all the other entries to NULL */
                        kfree(host_res);
                } else {
-                       status = DSP_EMEMORY;
+                       status = ENOMEM;
                }
                return status;
        }
@@ -1059,7 +1059,7 @@ static dsp_status request_bridge_resources_dsp(u32 dw_context, s32 bRequest)
                            (u32) mem_alloc_phys_mem(shm_size, 0x100000,
                                                     &dma_addr);
                        if (host_res->dw_mem_base[1] == 0) {
-                               status = DSP_EMEMORY;
+                               status = ENOMEM;
                                pr_err("shm reservation Failed\n");
                        } else {
                                host_res->dw_mem_length[1] = shm_size;
diff --git a/drivers/dsp/bridge/rmgr/mgr.c b/drivers/dsp/bridge/rmgr/mgr.c
index 431ecd9..dd31d8b 100644
--- a/drivers/dsp/bridge/rmgr/mgr.c
+++ b/drivers/dsp/bridge/rmgr/mgr.c
@@ -82,7 +82,7 @@ dsp_status mgr_create(OUT struct mgr_object **phMgrObject,
                        MEM_FREE_OBJECT(pmgr_obj);
                }
        } else {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
        }

        DBC_ENSURE(DSP_FAILED(status) ||
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index 43a655b..144f9bf 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -351,7 +351,7 @@ dsp_status nldr_allocate(struct nldr_object *nldr_obj, void *priv_ref,
                         NLDR_NODESIGNATURE);

        if (nldr_node_obj == NULL) {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
        } else {
                nldr_node_obj->pf_phase_split = pf_phase_split;
                nldr_node_obj->pers_libs = 0;
@@ -481,10 +481,10 @@ dsp_status nldr_create(OUT struct nldr_object **phNldr,
                nldr_obj->us_dsp_word_size = pattrs->us_dsp_word_size;
                nldr_obj->ldr_fxns = ldr_fxns;
                if (!(nldr_obj->ldr_fxns.init_fxn()))
-                       status = DSP_EMEMORY;
+                       status = ENOMEM;

        } else {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
        }
        /* Create the DCD Manager */
        if (DSP_SUCCEEDED(status))
@@ -501,7 +501,7 @@ dsp_status nldr_create(OUT struct nldr_object **phNldr,
                            mem_calloc(ul_len * nldr_obj->us_dsp_mau_size,
                                       MEM_PAGED);
                        if (!psz_coff_buf)
-                               status = DSP_EMEMORY;
+                               status = ENOMEM;
                } else {
                        /* Ok to not have dynamic loading memory */
                        status = DSP_SOK;
@@ -530,7 +530,7 @@ dsp_status nldr_create(OUT struct nldr_object **phNldr,
                nldr_obj->seg_table =
                    mem_calloc(sizeof(u32) * dload_segs, MEM_PAGED);
                if (rmm_segs == NULL || nldr_obj->seg_table == NULL) {
-                       status = DSP_EMEMORY;
+                       status = ENOMEM;
                } else {
                        nldr_obj->dload_segs = dload_segs;
                        mem_info_obj = (struct mem_seg_info *)(psz_coff_buf +
@@ -1057,7 +1057,7 @@ static dsp_status add_ovly_node(struct dsp_uuid *uuid_obj,
                        node_name = obj_def.obj_data.node_obj.ndb_props.ac_name;
                        pbuf = mem_calloc(len + 1, MEM_PAGED);
                        if (pbuf == NULL) {
-                               status = DSP_EMEMORY;
+                               status = ENOMEM;
                        } else {
                                strncpy(pbuf, node_name, len);
                                nldr_obj->ovly_table[nldr_obj->ovly_nid].
@@ -1112,7 +1112,7 @@ static dsp_status add_ovly_sect(struct nldr_object *nldr_obj,
                /* New section */
                new_sect = mem_calloc(sizeof(struct ovly_sect), MEM_PAGED);
                if (new_sect == NULL) {
-                       status = DSP_EMEMORY;
+                       status = ENOMEM;
                } else {
                        new_sect->sect_load_addr = addr;
                        new_sect->sect_run_addr = pSectInfo->sect_run_addr +
@@ -1283,7 +1283,7 @@ static dsp_status load_lib(struct nldr_nodeobject *nldr_node_obj,
        /* Allocate a buffer for library file name of size DBL_MAXPATHLENGTH */
        psz_file_name = mem_calloc(DBLL_MAXPATHLENGTH, MEM_PAGED);
        if (psz_file_name == NULL)
-               status = DSP_EMEMORY;
+               status = ENOMEM;

        if (DSP_SUCCEEDED(status)) {
                /* Get the name of the library */
@@ -1353,7 +1353,7 @@ static dsp_status load_lib(struct nldr_nodeobject *nldr_node_obj,
                        persistent_dep_libs =
                            mem_calloc(sizeof(bool) * nd_libs, MEM_PAGED);
                        if (!dep_lib_uui_ds || !persistent_dep_libs)
-                               status = DSP_EMEMORY;
+                               status = ENOMEM;

                        if (root->dep_libs > 0) {
                                /* Allocate arrays for dependent lib UUIDs,
@@ -1362,7 +1362,7 @@ static dsp_status load_lib(struct nldr_nodeobject *nldr_node_obj,
                                    (sizeof(struct lib_node) *
                                     (root->dep_libs), MEM_PAGED);
                                if (!(root->dep_libs_tree))
-                                       status = DSP_EMEMORY;
+                                       status = ENOMEM;

                        }

@@ -1650,7 +1650,7 @@ static dsp_status remote_alloc(void **pRef, u16 space, u32 size,
        u32 word_size;
        struct rmm_addr *rmm_addr_obj = (struct rmm_addr *)dspAddr;
        bool mem_load_req = false;
-       dsp_status status = DSP_EMEMORY;        /* Set to fail */
+       dsp_status status = ENOMEM;     /* Set to fail */
        DBC_REQUIRE(MEM_IS_VALID_HANDLE(hnode, NLDR_NODESIGNATURE));
        DBC_REQUIRE(space == DBLL_CODE || space == DBLL_DATA ||
                    space == DBLL_BSS);
@@ -1734,7 +1734,7 @@ static dsp_status remote_alloc(void **pRef, u16 space, u32 size,
        }
 func_cont:
        /* Haven't found memory yet, attempt to find any segment that works */
-       if (status == DSP_EMEMORY && !mem_load_req) {
+       if (status == ENOMEM && !mem_load_req) {
                dev_dbg(bridge, "%s: Preferred segment unavailable, trying "
                        "another\n", __func__);
                for (i = 0; i < nldr_obj->dload_segs; i++) {
@@ -1762,7 +1762,7 @@ static dsp_status remote_free(void **pRef, u16 space, u32 dspAddr,
        struct nldr_object *nldr_obj = (struct nldr_object *)pRef;
        struct rmm_target_obj *rmm;
        u32 word_size;
-       dsp_status status = DSP_EMEMORY;        /* Set to fail */
+       dsp_status status = ENOMEM;     /* Set to fail */

        DBC_REQUIRE(MEM_IS_VALID_HANDLE(nldr_obj, NLDR_SIGNATURE));

diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index df66ffb..ed26dff 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -383,7 +383,7 @@ dsp_status node_allocate(struct proc_object *hprocessor,

        MEM_ALLOC_OBJECT(pnode, struct node_object, NODE_SIGNATURE);
        if (pnode == NULL) {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
                goto func_end;
        }
        pnode->hnode_mgr = hnode_mgr;
@@ -487,7 +487,7 @@ func_cont:
                                        sizeof(struct dsp_streamconnect),
                                        MEM_PAGED);
                        if (num_streams > 0 && pnode->stream_connect == NULL)
-                               status = DSP_EMEMORY;
+                               status = ENOMEM;

                }
                if (DSP_SUCCEEDED(status) && (node_type == NODE_TASK ||
@@ -512,7 +512,7 @@ func_cont:
                            || (MAX_OUTPUTS(pnode) > 0
                                && (pnode->outputs == NULL
                                    || ptask_args->strm_out_def == NULL)))
-                               status = DSP_EMEMORY;
+                               status = ENOMEM;
                }
        }
        if (DSP_SUCCEEDED(status) && (node_type != NODE_DEVICE)) {
@@ -537,7 +537,7 @@ func_cont:
                                pmsg_args->pdata =
                                    mem_calloc(pargs->cb_data, MEM_PAGED);
                                if (pmsg_args->pdata == NULL) {
-                                       status = DSP_EMEMORY;
+                                       status = ENOMEM;
                                } else {
                                        pmsg_args->arg_length = pargs->cb_data;
                                        memcpy(pmsg_args->pdata,
@@ -752,7 +752,7 @@ DBAPI node_alloc_msg_buf(struct node_object *hnode, u32 usize,
                        if (*pbuffer == NULL) {
                                pr_err("%s: error - Out of shared memory\n",
                                       __func__);
-                               status = DSP_EMEMORY;
+                               status = ENOMEM;
                        }
                }
        }
@@ -973,7 +973,7 @@ dsp_status node_connect(struct node_object *hNode1, u32 uStream1,
                                output->sz_device = NULL;
                                input->sz_device = NULL;
                                gb_clear(hnode_mgr->pipe_map, pipe_id);
-                               status = DSP_EMEMORY;
+                               status = ENOMEM;
                        } else {
                                /* Copy "/dbpipe<pipId>" name to device names */
                                sprintf(output->sz_device, "%s%d",
@@ -1047,7 +1047,7 @@ dsp_status node_connect(struct node_object *hNode1, u32 uStream1,
                } else {
                        gb_clear(hnode_mgr->chnl_map, chnl_id);
                }
-               status = DSP_EMEMORY;
+               status = ENOMEM;
 func_cont2:
                if (DSP_SUCCEEDED(status)) {
                        if (hNode1 == (struct node_object *)DSP_HGPPNODE) {
@@ -1090,7 +1090,7 @@ func_cont2:
                                                          MEM_PAGED);
                }
                if (pstrm_def->sz_device == NULL) {
-                       status = DSP_EMEMORY;
+                       status = ENOMEM;
                } else {
                        /* Copy device name */
                        strncpy(pstrm_def->sz_device,
@@ -1331,14 +1331,14 @@ dsp_status node_create_mgr(OUT struct node_mgr **phNodeMgr,
                if (node_mgr_obj->node_list == NULL
                    || node_mgr_obj->pipe_map == NULL
                    || node_mgr_obj->pipe_done_map == NULL) {
-                       status = DSP_EMEMORY;
+                       status = ENOMEM;
                } else {
                        INIT_LIST_HEAD(&node_mgr_obj->node_list->head);
                        status = ntfy_create(&node_mgr_obj->ntfy_obj);
                }
                node_mgr_obj->num_created = 0;
        } else {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
        }
        /* get devNodeType */
        if (DSP_SUCCEEDED(status))
@@ -1382,7 +1382,7 @@ dsp_status node_create_mgr(OUT struct node_mgr **phNodeMgr,
                if ((node_mgr_obj->chnl_map == NULL)
                    || (node_mgr_obj->dma_chnl_map == NULL)
                    || (node_mgr_obj->zc_chnl_map == NULL)) {
-                       status = DSP_EMEMORY;
+                       status = ENOMEM;
                } else {
                        /* Block out reserved channels */
                        for (i = 0; i < node_mgr_obj->ul_chnl_offset; i++)
@@ -2958,7 +2958,7 @@ static dsp_status get_node_props(struct dcd_manager *hdcd_mgr,
                        DBC_ASSERT(len < MAXDEVNAMELEN);
                        hnode->pstr_dev_name = mem_calloc(len + 1, MEM_PAGED);
                        if (hnode->pstr_dev_name == NULL) {
-                               status = DSP_EMEMORY;
+                               status = ENOMEM;
                        } else {
                                strncpy(hnode->pstr_dev_name,
                                        pndb_props->ac_name, len);
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index b94234f..9e31510 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -150,7 +150,7 @@ proc_attach(u32 processor_id,
        MEM_ALLOC_OBJECT(p_proc_object, struct proc_object, PROC_SIGNATURE);
        /* Fill out the Processor Object: */
        if (p_proc_object == NULL) {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
                goto func_end;
        }
        p_proc_object->hdev_obj = hdev_obj;
@@ -278,7 +278,7 @@ dsp_status proc_auto_start(struct cfg_devnode *dev_node_obj,

        MEM_ALLOC_OBJECT(p_proc_object, struct proc_object, PROC_SIGNATURE);
        if (p_proc_object == NULL) {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
                goto func_end;
        }
        p_proc_object->hdev_obj = hdev_obj;
@@ -897,7 +897,7 @@ dsp_status proc_load(void *hprocessor, IN CONST s32 argc_index,
                                               COD_SYMB);
                }
        } else {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
        }
        if (DSP_SUCCEEDED(status)) {
                /* Auto-register data base */
diff --git a/drivers/dsp/bridge/rmgr/rmm.c b/drivers/dsp/bridge/rmgr/rmm.c
index d5a8bfb..058f96a 100644
--- a/drivers/dsp/bridge/rmgr/rmm.c
+++ b/drivers/dsp/bridge/rmgr/rmm.c
@@ -113,7 +113,7 @@ dsp_status rmm_alloc(struct rmm_target_obj *target, u32 segid, u32 size,

        if (!reserve) {
                if (!alloc_block(target, segid, size, align, dspAddr)) {
-                       status = DSP_EMEMORY;
+                       status = ENOMEM;
                } else {
                        /* Increment the number of allocated blocks in this
                         * segment */
@@ -147,7 +147,7 @@ dsp_status rmm_alloc(struct rmm_target_obj *target, u32 segid, u32 size,
                /* No overlap - allocate list element for new section. */
                new_sect = mem_calloc(sizeof(struct rmm_ovly_sect), MEM_PAGED);
                if (new_sect == NULL) {
-                       status = DSP_EMEMORY;
+                       status = ENOMEM;
                } else {
                        lst_init_elem((struct list_head *)new_sect);
                        new_sect->addr = addr;
@@ -188,7 +188,7 @@ dsp_status rmm_create(struct rmm_target_obj **target_obj,
        MEM_ALLOC_OBJECT(target, struct rmm_target_obj, RMM_TARGSIGNATURE);

        if (target == NULL)
-               status = DSP_EMEMORY;
+               status = ENOMEM;

        if (DSP_FAILED(status))
                goto func_cont;
@@ -201,14 +201,14 @@ dsp_status rmm_create(struct rmm_target_obj **target_obj,
        target->free_list = mem_calloc(num_segs * sizeof(struct rmm_header *),
                                       MEM_PAGED);
        if (target->free_list == NULL) {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
        } else {
                /* Allocate headers for each element on the free list */
                for (i = 0; i < (s32) num_segs; i++) {
                        target->free_list[i] =
                            mem_calloc(sizeof(struct rmm_header), MEM_PAGED);
                        if (target->free_list[i] == NULL) {
-                               status = DSP_EMEMORY;
+                               status = ENOMEM;
                                break;
                        }
                }
@@ -217,7 +217,7 @@ dsp_status rmm_create(struct rmm_target_obj **target_obj,
                                             sizeof(struct rmm_segment),
                                             MEM_PAGED);
                if (target->seg_tab == NULL) {
-                       status = DSP_EMEMORY;
+                       status = ENOMEM;
                } else {
                        /* Initialize segment table and free list */
                        sptr = target->seg_tab;
@@ -239,7 +239,7 @@ func_cont:
                target->ovly_list = mem_calloc(sizeof(struct lst_list),
                                               MEM_NONPAGED);
                if (target->ovly_list == NULL)
-                       status = DSP_EMEMORY;
+                       status = ENOMEM;
                else
                        INIT_LIST_HEAD(&target->ovly_list->head);
        }
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index 9ccfee5..1e788b9 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -134,7 +134,7 @@ dsp_status strm_allocate_buffer(struct strm_object *hStrm, u32 usize,
                DBC_ASSERT(hStrm->xlator != NULL);
                (void)cmm_xlator_alloc_buf(hStrm->xlator, &ap_buffer[i], usize);
                if (ap_buffer[i] == NULL) {
-                       status = DSP_EMEMORY;
+                       status = ENOMEM;
                        alloc_cnt = i;
                        break;
                }
@@ -220,7 +220,7 @@ dsp_status strm_create(OUT struct strm_mgr **phStrmMgr,
        /* Allocate STRM manager object */
        MEM_ALLOC_OBJECT(strm_mgr_obj, struct strm_mgr, STRMMGR_SIGNATURE);
        if (strm_mgr_obj == NULL)
-               status = DSP_EMEMORY;
+               status = ENOMEM;
        else
                strm_mgr_obj->dev_obj = dev_obj;

@@ -506,7 +506,7 @@ dsp_status strm_open(struct node_object *hnode, u32 dir, u32 index,
        if (DSP_SUCCEEDED(status)) {
                MEM_ALLOC_OBJECT(strm_obj, struct strm_object, STRM_SIGNATURE);
                if (strm_obj == NULL) {
-                       status = DSP_EMEMORY;
+                       status = ENOMEM;
                } else {
                        strm_obj->strm_mgr_obj = strm_mgr_obj;
                        strm_obj->dir = dir;
@@ -585,7 +585,7 @@ func_cont:
                         * over-ride non-returnable status codes so we return
                         * something documented
                         */
-                       if (status != DSP_EMEMORY && status !=
+                       if (status != ENOMEM && status !=
                            EINVAL && status != DSP_EFAIL) {
                                /*
                                 * We got a status that's not return-able.
@@ -795,7 +795,7 @@ dsp_status strm_select(IN struct strm_object **strm_tab, u32 nStrms,
                                                sizeof(struct sync_object *),
                                                MEM_PAGED);
                if (sync_events == NULL) {
-                       status = DSP_EMEMORY;
+                       status = ENOMEM;
                } else {
                        for (i = 0; i < nStrms; i++) {
                                intf_fxns =
diff --git a/drivers/dsp/bridge/services/ntfy.c b/drivers/dsp/bridge/services/ntfy.c
index 41e2dad..2635ecd 100644
--- a/drivers/dsp/bridge/services/ntfy.c
+++ b/drivers/dsp/bridge/services/ntfy.c
@@ -92,14 +92,14 @@ dsp_status ntfy_create(struct ntfy_object **phNtfy)
                        if (notify_obj->notify_list == NULL) {
                                (void)sync_delete_cs(notify_obj->sync_obj);
                                MEM_FREE_OBJECT(notify_obj);
-                               status = DSP_EMEMORY;
+                               status = ENOMEM;
                        } else {
                                INIT_LIST_HEAD(&notify_obj->notify_list->head);
                                *phNtfy = notify_obj;
                        }
                }
        } else {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
        }

        DBC_ENSURE((DSP_FAILED(status) && *phNtfy == NULL) ||
@@ -248,7 +248,7 @@ dsp_status ntfy_register(struct ntfy_object *ntfy_obj,
                        notifier_obj = mem_calloc(sizeof(struct notifier),
                                                  MEM_PAGED);
                        if (notifier_obj == NULL)
-                               status = DSP_EMEMORY;
+                               status = ENOMEM;

                }
                if (DSP_SUCCEEDED(status)) {
diff --git a/drivers/dsp/bridge/services/sync.c b/drivers/dsp/bridge/services/sync.c
index 6325dfb..e7f5c06 100644
--- a/drivers/dsp/bridge/services/sync.c
+++ b/drivers/dsp/bridge/services/sync.c
@@ -140,7 +140,7 @@ dsp_status sync_open_event(OUT struct sync_object **ph_event,
                event->wait_obj = NULL;
                spin_lock_init(&event->sync_lock);
        } else {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
        }

        *ph_event = event;
@@ -245,7 +245,7 @@ dsp_status sync_wait_on_multiple_events(struct sync_object **sync_events,

        wp = mem_calloc(sizeof(struct wait_object), MEM_NONPAGED);
        if (wp == NULL)
-               return DSP_EMEMORY;
+               return ENOMEM;

        wp->state = WO_WAITING;
        wp->signalling_event = NULL;
@@ -387,7 +387,7 @@ dsp_status sync_initialize_cs(OUT struct sync_csobject **phCSObj)
        if (pcs_obj != NULL)
                init_MUTEX(&pcs_obj->sem);
        else
-               status = DSP_EMEMORY;
+               status = ENOMEM;

        /* return CS object */
        *phCSObj = pcs_obj;
@@ -410,7 +410,7 @@ dsp_status sync_initialize_dpccs(OUT struct sync_csobject **phCSObj)
                        pcs_obj->count = 1;
                        spin_lock_init(&pcs_obj->sync_dpccs_lock);
                } else {
-                       status = DSP_EMEMORY;
+                       status = ENOMEM;
                }

                /* return CS object */
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index a9d1c0d..43f2731 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -149,7 +149,7 @@ dsp_status bridge_chnl_add_io_req(struct chnl_object *chnl_obj, void *pHostBuf,
                /* if addr in user mode, then copy to kernel space */
                host_sys_buf = mem_alloc(buf_size, MEM_NONPAGED);
                if (host_sys_buf == NULL) {
-                       status = DSP_EMEMORY;
+                       status = ENOMEM;
                        goto func_end;
                }
                if (CHNL_IS_OUTPUT(pchnl->chnl_mode)) {
@@ -428,10 +428,10 @@ dsp_status bridge_chnl_create(OUT struct chnl_mgr **phChnlMgr,
                                    sync_initialize_dpccs
                                    (&chnl_mgr_obj->hcs_obj);
                } else {
-                       status = DSP_EMEMORY;
+                       status = ENOMEM;
                }
        } else {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
        }

        if (DSP_FAILED(status)) {
@@ -826,7 +826,7 @@ dsp_status bridge_chnl_open(OUT struct chnl_object **phChnl,
        /* Create channel object: */
        MEM_ALLOC_OBJECT(pchnl, struct chnl_object, 0x0000);
        if (!pchnl) {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
                goto func_end;
        }
        /* Protect queues from io_dpc: */
@@ -858,7 +858,7 @@ dsp_status bridge_chnl_open(OUT struct chnl_object **phChnl,
                        /* Default to proc-copy */
                        pchnl->chnl_type = CHNL_PCPY;
                } else {
-                       status = DSP_EMEMORY;
+                       status = ENOMEM;
                }
        }

diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 8de2adf..fe1378c 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -212,7 +212,7 @@ dsp_status bridge_io_create(OUT struct io_mgr **phIOMgr,
        /* Allocate IO manager object */
        MEM_ALLOC_OBJECT(pio_mgr, struct io_mgr, IO_MGRSIGNATURE);
        if (pio_mgr == NULL) {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
                goto func_end;
        }

@@ -469,7 +469,7 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
                        pr_err("%s: shm Error, reserved 0x%x required 0x%x\n",
                               __func__, host_res.dw_mem_length[1],
                               ul_seg_size + ul_seg1_size + ul_pad_size);
-                       status = DSP_EMEMORY;
+                       status = ENOMEM;
                }
        }
        if (DSP_FAILED(status))
@@ -791,7 +791,7 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
                                    hio_mgr->ul_trace_buffer_begin) *
                                   hio_mgr->word_size) + 2, MEM_NONPAGED);
        if (!hio_mgr->pmsg)
-               status = DSP_EMEMORY;
+               status = ENOMEM;

        hio_mgr->ul_dsp_va = ul_dsp_va;
        hio_mgr->ul_gpp_va = (ul_gpp_va + ul_seg1_size + ul_pad_size);
@@ -1878,7 +1878,7 @@ void print_dsp_debug_trace(struct io_mgr *hio_mgr)
  *                      number of extra carriage returns to generate.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EMEMORY:    Unable to allocate memory.
+ *      ENOMEM:    Unable to allocate memory.
  *  Requires:
  *      lpBuf must be a fully allocated writable block of at least bytes.
  *      There are no more than ul_num_words extra characters needed (the number
@@ -1896,7 +1896,7 @@ static dsp_status pack_trace_buffer(char *lpBuf, u32 bytes, u32 ul_num_words)
        /* Tmp workspace, 1 KB longer than input buf */
        lp_tmp_buf = mem_calloc((bytes + ul_num_words), MEM_PAGED);
        if (lp_tmp_buf == NULL)
-               status = DSP_EMEMORY;
+               status = ENOMEM;

        if (DSP_SUCCEEDED(status)) {
                lp_buf_start = lpBuf;
@@ -1938,7 +1938,7 @@ static dsp_status pack_trace_buffer(char *lpBuf, u32 bytes, u32 ul_num_words)
  *                      number of extra carriage returns to generate.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EMEMORY:    Unable to allocate memory.
+ *      ENOMEM:    Unable to allocate memory.
  *  Requires:
  *      hdeh_mgr muse be valid. Checked in bridge_deh_notify.
  */
@@ -2007,7 +2007,7 @@ dsp_status print_dsp_trace_buffer(struct wmd_dev_context *hwmd_context)
                        kfree(psz_buf);
                        kfree(lpsz_buf);
                } else {
-                       status = DSP_EMEMORY;
+                       status = ENOMEM;
                }
        }
        return status;
diff --git a/drivers/dsp/bridge/wmd/msg_sm.c b/drivers/dsp/bridge/wmd/msg_sm.c
index 91df9a8..1863c28 100644
--- a/drivers/dsp/bridge/wmd/msg_sm.c
+++ b/drivers/dsp/bridge/wmd/msg_sm.c
@@ -90,7 +90,7 @@ dsp_status bridge_msg_create(OUT struct msg_mgr **phMsgMgr,
                if (msg_mgr_obj->queue_list == NULL ||
                    msg_mgr_obj->msg_free_list == NULL ||
                    msg_mgr_obj->msg_used_list == NULL) {
-                       status = DSP_EMEMORY;
+                       status = ENOMEM;
                } else {
                        INIT_LIST_HEAD(&msg_mgr_obj->queue_list->head);
                        INIT_LIST_HEAD(&msg_mgr_obj->msg_free_list->head);
@@ -110,7 +110,7 @@ dsp_status bridge_msg_create(OUT struct msg_mgr **phMsgMgr,
                        delete_msg_mgr(msg_mgr_obj);

        } else {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
        }
 func_end:
        return status;
@@ -140,7 +140,7 @@ dsp_status bridge_msg_create_queue(struct msg_mgr *hmsg_mgr,
        /* Allocate msg_queue object */
        MEM_ALLOC_OBJECT(msg_q, struct msg_queue, MSGQ_SIGNATURE);
        if (!msg_q) {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
                goto func_end;
        }
        lst_init_elem((struct list_head *)msg_q);
@@ -154,7 +154,7 @@ dsp_status bridge_msg_create_queue(struct msg_mgr *hmsg_mgr,
        msg_q->msg_used_list =
            mem_calloc(sizeof(struct lst_list), MEM_NONPAGED);
        if (msg_q->msg_free_list == NULL || msg_q->msg_used_list == NULL)
-               status = DSP_EMEMORY;
+               status = ENOMEM;
        else {
                INIT_LIST_HEAD(&msg_q->msg_free_list->head);
                INIT_LIST_HEAD(&msg_q->msg_used_list->head);
@@ -279,7 +279,7 @@ dsp_status bridge_msg_get(struct msg_queue *msg_queue_obj,

        if (!MEM_IS_VALID_HANDLE(msg_queue_obj, MSGQ_SIGNATURE) ||
            pmsg == NULL) {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
                goto func_end;
        }

@@ -377,7 +377,7 @@ dsp_status bridge_msg_put(struct msg_queue *msg_queue_obj,

        if (!MEM_IS_VALID_HANDLE(msg_queue_obj, MSGQ_SIGNATURE) || !pmsg ||
            !msg_queue_obj->hmsg_mgr) {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
                goto func_end;
        }
        hmsg_mgr = msg_queue_obj->hmsg_mgr;
@@ -485,7 +485,7 @@ dsp_status bridge_msg_register_notify(struct msg_queue *msg_queue_obj,

        if (!MEM_IS_VALID_HANDLE(msg_queue_obj, MSGQ_SIGNATURE)
            || !hnotification) {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
                goto func_end;
        }

@@ -544,7 +544,7 @@ static dsp_status add_new_msg(struct lst_list *msgList)
                lst_init_elem((struct list_head *)pmsg);
                lst_put_tail(msgList, (struct list_head *)pmsg);
        } else {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
        }

        return status;
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index de857b0..647643d 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -945,14 +945,14 @@ static dsp_status bridge_dev_create(OUT struct wmd_dev_context **ppDevContext,
         *  state, which becomes the context for later calls into this WMD. */
        dev_context = mem_calloc(sizeof(struct wmd_dev_context), MEM_NONPAGED);
        if (!dev_context) {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
                goto func_end;
        }
        status = cfg_get_host_resources((struct cfg_devnode *)
                                        drv_get_first_dev_extension(),
                                        &resources);
        if (DSP_FAILED(status)) {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
                goto func_end;
        }

@@ -1056,7 +1056,7 @@ static dsp_status bridge_dev_create(OUT struct wmd_dev_context **ppDevContext,
            (pt_attrs->l2_base_va != 0) && (pt_attrs->pg_info != NULL))
                dev_context->pt_attrs = pt_attrs;
        else
-               status = DSP_EMEMORY;
+               status = ENOMEM;

        if (DSP_SUCCEEDED(status))
                status = sync_initialize_cs(&pt_attrs->hcs_obj);
@@ -1832,7 +1832,7 @@ static dsp_status pte_set(struct pg_table_attrs *pt, u32 pa, u32 va,
                                                   HW_MMU_COARSE_PAGE_SIZE,
                                                   attrs);
                        } else {
-                               status = DSP_EMEMORY;
+                               status = ENOMEM;
                        }
                } else {
                        /* Found valid L1 PTE of another size.
@@ -1916,7 +1916,7 @@ static dsp_status mem_map_vmalloc(struct wmd_dev_context *dev_context,

                }
                if (pa_next == 0) {
-                       status = DSP_EMEMORY;
+                       status = ENOMEM;
                        break;
                }
                pa = pa_curr;
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index d8d2f6a..4209481 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -83,7 +83,7 @@ dsp_status bridge_deh_create(OUT struct deh_mgr **phDehMgr,
        /* Allocate IO manager object: */
        MEM_ALLOC_OBJECT(deh_mgr_obj, struct deh_mgr, SIGNATURE);
        if (deh_mgr_obj == NULL) {
-               status = DSP_EMEMORY;
+               status = ENOMEM;
        } else {
                /* Create an NTFY object to manage notifications */
                status = ntfy_create(&deh_mgr_obj->ntfy_obj);
--
1.6.0.4

