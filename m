From: "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>
Subject: [PATCH 12/13] DSPBRIDGE: Remove dw_signature field from structures
Date: Thu, 8 Apr 2010 19:12:29 -0500
Message-ID: <818EF96F5A7CC84789DD014773DB09548E64D157@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50988 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758653Ab0DIAMp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 20:12:45 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ameya.Palande@nokia.com" <Ameya.Palande@nokia.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

>From a6e48d27dcc2f71f1948b4f882f212a964382474 Mon Sep 17 00:00:00 2001
From: Ivan Gomez Castellanos <ivan.gomez@ti.com>
Date: Mon, 29 Mar 2010 19:03:32 -0600
Subject: [PATCH 12/13] DSPBRIDGE: Remove dw_signature field from structures

dw_signature is not needed for object validation. It does not improve
a simple pointer check. So this field is removed from structures.

This patch depends on the fommowing patches:

DSPBRIDGE: Replace MEM_ALLOC_OBJECT macro by kzalloc function
DSPBRIDGE: Replace MEM_FREE_OBJECT macro by kfree function
DSPBRIDGE: Check pointer instead of using MEM_IS_VALID_HANDLE macro
DSPBRIDGE: Remove CHNL_IS_VALID_MGR and CHNL_IS_VALID_CHNL
DSPBRIDGE: Remove IS_VALID_HANDLE function and macro

Signed-off-by: Ivan Gomez Castellanos <ivan.gomez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/_chnl_sm.h |    2 --
 drivers/dsp/bridge/pmgr/chnlobj.h               |    2 --
 drivers/dsp/bridge/pmgr/cmm.c                   |    3 ---
 drivers/dsp/bridge/pmgr/dbll.c                  |    2 --
 drivers/dsp/bridge/pmgr/dev.c                   |    1 -
 drivers/dsp/bridge/pmgr/dmm.c                   |    1 -
 drivers/dsp/bridge/pmgr/ioobj.h                 |    1 -
 drivers/dsp/bridge/pmgr/msgobj.h                |    3 +--
 drivers/dsp/bridge/rmgr/dbdcd.c                 |    1 -
 drivers/dsp/bridge/rmgr/disp.c                  |    1 -
 drivers/dsp/bridge/rmgr/drv.c                   |    1 -
 drivers/dsp/bridge/rmgr/mgr.c                   |    1 -
 drivers/dsp/bridge/rmgr/nldr.c                  |    2 --
 drivers/dsp/bridge/rmgr/node.c                  |    2 --
 drivers/dsp/bridge/rmgr/proc.c                  |    1 -
 drivers/dsp/bridge/rmgr/rmm.c                   |    1 -
 drivers/dsp/bridge/rmgr/strm.c                  |    2 --
 drivers/dsp/bridge/wmd/_deh.h                   |    1 -
 drivers/dsp/bridge/wmd/_msg_sm.h                |    4 +---
 drivers/dsp/bridge/wmd/chnl_sm.c                |    2 --
 drivers/dsp/bridge/wmd/io_sm.c                  |    1 -
 21 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
index f8bdc93..8bba33f 100644
--- a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
@@ -112,7 +112,6 @@ struct shm {

        /* Channel Manager: only one created per board: */
 struct chnl_mgr {
-       u32 dw_signature;       /* Used for object validation */
        /* Function interface to WMD */
        struct bridge_drv_interface *intf_fxns;
        struct io_mgr *hio_mgr; /* IO manager */
@@ -138,7 +137,6 @@ struct chnl_mgr {
  *     up to CHNL_MAXCHANNELS + CHNL_MAXDDMACHNLS per board.
  */
 struct chnl_object {
-       u32 dw_signature;       /* Used for object validation */
        /* Pointer back to channel manager */
        struct chnl_mgr *chnl_mgr_obj;
        u32 chnl_id;            /* Channel id */
diff --git a/drivers/dsp/bridge/pmgr/chnlobj.h b/drivers/dsp/bridge/pmgr/chnlobj.h
index 6750273..2cc7c22 100644
--- a/drivers/dsp/bridge/pmgr/chnlobj.h
+++ b/drivers/dsp/bridge/pmgr/chnlobj.h
@@ -30,7 +30,6 @@
  */
 struct chnl_mgr_ {
        /* These must be the first fields in a chnl_mgr struct: */
-       u32 dw_signature;       /* Used for object validation. */
        struct bridge_drv_interface *intf_fxns; /* Function interface to WMD. */
 };

@@ -41,7 +40,6 @@ struct chnl_mgr_ {
  */
 struct chnl_object_ {
        /* These must be the first fields in a chnl_object struct: */
-       u32 dw_signature;       /* Used for object validation. */
        struct chnl_mgr_ *chnl_mgr_obj; /* Pointer back to channel manager. */
 };

diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c
index e1fcc38..e86294a 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -70,7 +70,6 @@
  *      vma - virtual memory allocator.(not used).
  */
 struct cmm_allocator {         /* sma */
-       u32 dw_signature;       /* SMA allocator signature SMEMSIGNATURE */
        unsigned int shm_base;  /* Start of physical SM block */
        u32 ul_sm_size;         /* Size of SM block in bytes */
        unsigned int dw_vm_base;        /* Start of VM block. (Dev driver
@@ -88,7 +87,6 @@ struct cmm_allocator {                /* sma */
 };

 struct cmm_xlator {            /* Pa<->Va translator object */
-       u32 dw_signature;       /* "CMMX" */
        /* CMM object this translator associated */
        struct cmm_object *hcmm_mgr;
        /*
@@ -103,7 +101,6 @@ struct cmm_xlator {         /* Pa<->Va translator object */

 /* CMM Mgr */
 struct cmm_object {
-       u32 dw_signature;       /* Used for object validation */
        /*
         * Cmm Lock is used to serialize access mem manager for multi-threads.
         */
diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index 18bc662..f10715a 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -60,7 +60,6 @@
  *  ======== dbll_tar_obj ========
  */
 struct dbll_tar_obj {
-       u32 dw_signature;       /* For object validation */
        struct dbll_attrs attrs;
        struct dbll_library_obj *head;  /* List of all opened libraries */
 };
@@ -113,7 +112,6 @@ struct dbll_init_obj {
  *  ======== dbll_library_obj ========
  */
 struct dbll_library_obj {
-       u32 dw_signature;       /* For object validation */
        struct dbll_library_obj *next;  /* Next library in target's list */
        struct dbll_library_obj *prev;  /* Previous in the list */
        struct dbll_tar_obj *target_obj;        /* target for this library */
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index 09884ca..bc42520 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -64,7 +64,6 @@ struct dev_object {
        /* LST requires "link" to be first field! */
        struct list_head link;  /* Link to next dev_object. */
        u32 dev_type;           /* Device Type */
-       u32 dw_signature;       /* Used for object validation. */
        struct cfg_devnode *dev_node_obj;       /* Platform specific dev id */
        struct wmd_dev_context *hwmd_context;   /* WMD Context Handle */
        struct bridge_drv_interface wmd_interface;      /* Function interface to WMD. */
diff --git a/drivers/dsp/bridge/pmgr/dmm.c b/drivers/dsp/bridge/pmgr/dmm.c
index e2e47f2..c6965b5 100644
--- a/drivers/dsp/bridge/pmgr/dmm.c
+++ b/drivers/dsp/bridge/pmgr/dmm.c
@@ -53,7 +53,6 @@

 /* DMM Mgr */
 struct dmm_object {
-       u32 dw_signature;       /* Used for object validation */
        /* Dmm Lock is used to serialize access mem manager for
         * multi-threads. */
        spinlock_t dmm_lock;    /* Lock to access dmm mgr */
diff --git a/drivers/dsp/bridge/pmgr/ioobj.h b/drivers/dsp/bridge/pmgr/ioobj.h
index 298d1a2..f481765 100644
--- a/drivers/dsp/bridge/pmgr/ioobj.h
+++ b/drivers/dsp/bridge/pmgr/ioobj.h
@@ -30,7 +30,6 @@
  */
 struct io_mgr_ {
        /* These must be the first fields in a io_mgr struct: */
-       u32 dw_signature;       /* Used for object validation. */
        struct wmd_dev_context *hwmd_context;   /* WMD device context. */
        struct bridge_drv_interface *intf_fxns; /* Function interface to WMD. */
        struct dev_object *hdev_obj;    /* Device this board represents. */
diff --git a/drivers/dsp/bridge/pmgr/msgobj.h b/drivers/dsp/bridge/pmgr/msgobj.h
index 420ba00..3eb1098 100644
--- a/drivers/dsp/bridge/pmgr/msgobj.h
+++ b/drivers/dsp/bridge/pmgr/msgobj.h
@@ -30,8 +30,7 @@
  *  follow this structure in memory.
  */
 struct msg_mgr_ {
-       /* The first two fields must match those in msgobj.h */
-       u32 dw_signature;
+       /* The first field must match that in _msg_sm.h */
        struct bridge_drv_interface *intf_fxns; /* Function interface to WMD. */
 };

diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index 5c7fed0..05bd46e 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -55,7 +55,6 @@

 /* DCD specific structures. */
 struct dcd_manager {
-       u32 dw_signature;       /* Used for object validation. */
        struct cod_manager *cod_mgr;    /* Handle to COD manager object. */
 };

diff --git a/drivers/dsp/bridge/rmgr/disp.c b/drivers/dsp/bridge/rmgr/disp.c
index b7ddc4e..05ce538 100644
--- a/drivers/dsp/bridge/rmgr/disp.c
+++ b/drivers/dsp/bridge/rmgr/disp.c
@@ -63,7 +63,6 @@
  *  ======== disp_object ========
  */
 struct disp_object {
-       u32 dw_signature;       /* Used for object validation */
        struct dev_object *hdev_obj;    /* Device for this processor */
        struct bridge_drv_interface *intf_fxns; /* Function interface to WMD */
        struct chnl_mgr *hchnl_mgr;     /* Channel manager */
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 2c01c4a..eedf5fa 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -47,7 +47,6 @@
 #define SIGNATURE   0x5f52474d /* "DRV_" (in reverse) */

 struct drv_object {
-       u32 dw_signature;
        struct lst_list *dev_list;
        struct lst_list *dev_node_string;
 };
diff --git a/drivers/dsp/bridge/rmgr/mgr.c b/drivers/dsp/bridge/rmgr/mgr.c
index e8a9a33..70522b4 100644
--- a/drivers/dsp/bridge/rmgr/mgr.c
+++ b/drivers/dsp/bridge/rmgr/mgr.c
@@ -43,7 +43,6 @@
 #define SIGNATURE               0x5f52474d     /* "MGR_" (in reverse) */

 struct mgr_object {
-       u32 dw_signature;
        struct dcd_manager *hdcd_mgr;   /* Proc/Node data manager */
 };

diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index ed6d08b..c12f089 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -207,7 +207,6 @@ struct ovly_node {
  *  Overlay loader object.
  */
 struct nldr_object {
-       u32 dw_signature;       /* For object validation */
        struct dev_object *hdev_obj;    /* Device object */
        struct dcd_manager *hdcd_mgr;   /* Proc/Node data manager */
        struct dbll_tar_obj *dbll;      /* The DBL loader */
@@ -233,7 +232,6 @@ struct nldr_object {
  *  Dynamic node object. This object is created when a node is allocated.
  */
 struct nldr_nodeobject {
-       u32 dw_signature;       /* For object validation */
        struct nldr_object *nldr_obj;   /* Dynamic loader handle */
        void *priv_ref;         /* Handle to pass to dbl_write_fxn */
        struct dsp_uuid uuid;   /* Node's UUID */
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index d918e24..4da3ead 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -125,7 +125,6 @@
  *  ======== node_mgr ========
  */
 struct node_mgr {
-       u32 dw_signature;       /* For object validation */
        struct dev_object *hdev_obj;    /* Device object */
        struct bridge_drv_interface *intf_fxns; /* Function interface to WMD */
        struct dcd_manager *hdcd_mgr;   /* Proc/Node data manager */
@@ -186,7 +185,6 @@ struct stream_chnl {
  */
 struct node_object {
        struct list_head list_elem;
-       u32 dw_signature;       /* For object validation */
        struct node_mgr *hnode_mgr;     /* The manager of this node */
        struct proc_object *hprocessor; /* Back pointer to processor */
        struct dsp_uuid node_uuid;      /* Node's ID */
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index b85a90f..9d71fea 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -83,7 +83,6 @@ extern char *iva_img;
 /* The proc_object structure. */
 struct proc_object {
        struct list_head link;  /* Link to next proc_object */
-       u32 dw_signature;       /* Used for object validation */
        struct dev_object *hdev_obj;    /* Device this PROC represents */
        u32 process;            /* Process owning this Processor */
        struct mgr_object *hmgr_obj;    /* Manager Object Handle */
diff --git a/drivers/dsp/bridge/rmgr/rmm.c b/drivers/dsp/bridge/rmgr/rmm.c
index ac721da..d1699e4 100644
--- a/drivers/dsp/bridge/rmgr/rmm.c
+++ b/drivers/dsp/bridge/rmgr/rmm.c
@@ -78,7 +78,6 @@ struct rmm_ovly_sect {
  *  ======== rmm_target_obj ========
  */
 struct rmm_target_obj {
-       u32 dw_signature;
        struct rmm_segment *seg_tab;
        struct rmm_header **free_list;
        u32 num_segs;
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index d6f2012..b02ca45 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -58,7 +58,6 @@
  *  channels of a stream.
  */
 struct strm_mgr {
-       u32 dw_signature;
        struct dev_object *dev_obj;     /* Device for this processor */
        struct chnl_mgr *hchnl_mgr;     /* Channel manager */
        struct bridge_drv_interface *intf_fxns; /* Function interface to WMD */
@@ -69,7 +68,6 @@ struct strm_mgr {
  *  This object is allocated in strm_open().
  */
 struct strm_object {
-       u32 dw_signature;
        struct strm_mgr *strm_mgr_obj;
        struct chnl_object *chnl_obj;
        u32 dir;                /* DSP_TONODE or DSP_FROMNODE */
diff --git a/drivers/dsp/bridge/wmd/_deh.h b/drivers/dsp/bridge/wmd/_deh.h
index 214ac7d..bfe26fc 100644
--- a/drivers/dsp/bridge/wmd/_deh.h
+++ b/drivers/dsp/bridge/wmd/_deh.h
@@ -26,7 +26,6 @@

 /* DEH Manager: only one created per board: */
 struct deh_mgr {
-       u32 dw_signature;       /* Used for object validation. */
        struct wmd_dev_context *hwmd_context;   /* WMD device context. */
        struct ntfy_object *ntfy_obj;   /* NTFY object */
        struct dsp_errorinfo err_info;  /* DSP exception info. */
diff --git a/drivers/dsp/bridge/wmd/_msg_sm.h b/drivers/dsp/bridge/wmd/_msg_sm.h
index bb28d4f..e2233e2 100644
--- a/drivers/dsp/bridge/wmd/_msg_sm.h
+++ b/drivers/dsp/bridge/wmd/_msg_sm.h
@@ -80,8 +80,7 @@ struct msg_ctrl {
  *  ready to go to the DSP.
  */
 struct msg_mgr {
-       /* The first two fields must match those in msgobj.h */
-       u32 dw_signature;
+       /* The first field must match that in msgobj.h */
        struct bridge_drv_interface *intf_fxns; /* Function interface to WMD. */

        struct io_mgr *hio_mgr; /* IO manager */
@@ -107,7 +106,6 @@ struct msg_mgr {
  */
 struct msg_queue {
        struct list_head list_elem;
-       u32 dw_signature;
        struct msg_mgr *hmsg_mgr;
        u32 max_msgs;           /* Node message depth */
        u32 msgq_id;            /* Node environment pointer */
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index 1a5d84d..600710d 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -338,7 +338,6 @@ func_cont:
                DBC_ASSERT((pchnl->dw_state & CHNL_STATECANCEL));
                /* Invalidate channel object: Protects from
                 * CHNL_GetIOCompletion(). */
-               pchnl->dw_signature = 0x0000;
                /* Free the slot in the channel manager: */
                pchnl->chnl_mgr_obj->ap_channel[pchnl->chnl_id] = NULL;
                spin_lock_bh(&pchnl->chnl_mgr_obj->chnl_mgr_lock);
@@ -898,7 +897,6 @@ dsp_status bridge_chnl_open(OUT struct chnl_object **phChnl,
                chnl_mgr_obj->open_channels++;
                spin_unlock_bh(&chnl_mgr_obj->chnl_mgr_lock);
                /* Return result... */
-               pchnl->dw_signature = CHNL_SIGNATURE;
                pchnl->dw_state = CHNL_STATEREADY;
                *phChnl = pchnl;
        }
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 885e25c..5744b03 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -83,7 +83,6 @@
 /* IO Manager: only one created per board */
 struct io_mgr {
        /* These four fields must be the first fields in a io_mgr_ struct */
-       u32 dw_signature;       /* Used for object validation */
        struct wmd_dev_context *hwmd_context;   /* WMD device context */
        struct bridge_drv_interface *intf_fxns; /* Function interface to WMD */
        struct dev_object *hdev_obj;    /* Device this board represents */
--
1.7.0.3
