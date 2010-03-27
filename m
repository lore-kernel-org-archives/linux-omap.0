From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC][PATCH v1 8/19] DSPBRIDGE: Cleanup custom error code
 (DSP_ENOTIMPL -> -ENOSYS)
Date: Sat, 27 Mar 2010 07:57:56 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DEBEE0E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39526 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752724Ab0C0C2C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Mar 2010 22:28:02 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2R2RwqG006238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 26 Mar 2010 21:28:01 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o2R2Rwv8026603
	for <linux-omap@vger.kernel.org>; Sat, 27 Mar 2010 07:57:58 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From ca9fb2edaa1934aeea76403a12377bfff6ed22c4 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Tue, 23 Mar 2010 12:19:38 -0600
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code (DSP_ENOTIMPL -> -ENOSYS)

This patch replaces DSP_ENOTIMPL with -ENOSYS

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/cod.h      |    2 +-
 arch/arm/plat-omap/include/dspbridge/dblldefs.h |    4 ++--
 arch/arm/plat-omap/include/dspbridge/errbase.h  |    3 ---
 arch/arm/plat-omap/include/dspbridge/node.h     |    2 +-
 arch/arm/plat-omap/include/dspbridge/proc.h     |    2 +-
 arch/arm/plat-omap/include/dspbridge/strm.h     |    2 +-
 arch/arm/plat-omap/include/dspbridge/wmd.h      |    2 +-
 drivers/dsp/bridge/pmgr/cod.c                   |    2 +-
 drivers/dsp/bridge/pmgr/dbll.c                  |    4 ++--
 drivers/dsp/bridge/pmgr/dev.c                   |    6 +++---
 drivers/dsp/bridge/pmgr/wcd.c                   |    8 ++++----
 drivers/dsp/bridge/rmgr/node.c                  |    2 +-
 drivers/dsp/bridge/rmgr/proc.c                  |    2 +-
 drivers/dsp/bridge/rmgr/strm.c                  |    4 ++--
 drivers/dsp/bridge/services/ntfy.c              |    4 ++--
 15 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/cod.h b/arch/arm/plat-omap/include/dspbridge/cod.h
index 3d76a6b..381291c 100644
--- a/arch/arm/plat-omap/include/dspbridge/cod.h
+++ b/arch/arm/plat-omap/include/dspbridge/cod.h
@@ -87,7 +87,7 @@ extern void cod_close(struct cod_libraryobj *lib);
  *      DSP_SOK:                Success.
  *      COD_E_NOZLFUNCTIONS:    Could not initialize ZL functions.
  *      COD_E_ZLCREATEFAILED:   ZL_Create failed.
- *      DSP_ENOTIMPL:           attrs was not NULL.  We don't yet support
+ *      -ENOSYS:           attrs was not NULL.  We don't yet support
  *                              non default values of attrs.
  *  Requires:
  *      COD module initialized.
diff --git a/arch/arm/plat-omap/include/dspbridge/dblldefs.h b/arch/arm/plat-omap/include/dspbridge/dblldefs.h
index 90683a2..fce35ab 100644
--- a/arch/arm/plat-omap/include/dspbridge/dblldefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dblldefs.h
@@ -361,7 +361,7 @@ typedef dsp_status(*dbll_load_fxn) (struct dbll_library_obj *lib,
  *      DSP_SOK:        Success.
  *      DSP_ENOSECT:    Section not found.
  *      DSP_EFWRITE:    Write function failed.
- *      DSP_ENOTIMPL:   Function not implemented.
+ *      -ENOSYS:   Function not implemented.
  *  Requires:
  *      Valid lib.
  *      sectName != NULL.
@@ -466,7 +466,7 @@ typedef void (*dbll_unload_fxn) (struct dbll_library_obj *library,
  *  Returns:
  *      DSP_SOK:        Success.
  *      DSP_ENOSECT:    Named section not found.
- *      DSP_ENOTIMPL
+ *      -ENOSYS
  *  Requires:
  *      DBL initialized.
  *      Valid lib.
diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index 5b8d9e5..09ae0c6 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -96,9 +96,6 @@
 /* No more connections can be made for this node. */
 #define DSP_ENOMORECONNECTIONS      (DSP_EBASE + 0xf)
 
-/* The indicated operation is not supported. */
-#define DSP_ENOTIMPL                (DSP_EBASE + 0x10)
-
 /* I/O is currently pending. */
 #define DSP_EPENDING                (DSP_EBASE + 0x11)
 
diff --git a/arch/arm/plat-omap/include/dspbridge/node.h b/arch/arm/plat-omap/include/dspbridge/node.h
index 66afafe..3bf8a03 100644
--- a/arch/arm/plat-omap/include/dspbridge/node.h
+++ b/arch/arm/plat-omap/include/dspbridge/node.h
@@ -493,7 +493,7 @@ extern dsp_status node_put_message(struct node_object *hnode,
  *      -EFAULT:    Invalid hnode.
  *      -ENOMEM:    Insufficient memory on GPP.
  *      DSP_EVALUE:     event_mask is invalid.
- *      DSP_ENOTIMPL:   Notification type specified by notify_type is not
+ *      -ENOSYS:   Notification type specified by notify_type is not
  *                      supported.
  *  Requires:
  *      node_init(void) called.
diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/plat-omap/include/dspbridge/proc.h
index dfae597..5220a1b 100644
--- a/arch/arm/plat-omap/include/dspbridge/proc.h
+++ b/arch/arm/plat-omap/include/dspbridge/proc.h
@@ -184,7 +184,7 @@ extern dsp_status proc_enum_nodes(void *hprocessor,
  *  Ensures:
  *  Details:
  *      This function currently returns
- *      DSP_ENOTIMPL, and does not write any data to the resource_info struct.
+ *      -ENOSYS, and does not write any data to the resource_info struct.
  */
 extern dsp_status proc_get_resource_info(void *hprocessor,
 					 u32 resource_type,
diff --git a/arch/arm/plat-omap/include/dspbridge/strm.h b/arch/arm/plat-omap/include/dspbridge/strm.h
index 33b2676..c2a5ed7 100644
--- a/arch/arm/plat-omap/include/dspbridge/strm.h
+++ b/arch/arm/plat-omap/include/dspbridge/strm.h
@@ -340,7 +340,7 @@ extern dsp_status strm_reclaim(struct strm_object *hStrm,
  *      -EFAULT:    Invalid hStrm.
  *      -ENOMEM:    Insufficient memory on GPP.
  *      DSP_EVALUE:     event_mask is invalid.
- *      DSP_ENOTIMPL:   Notification type specified by notify_type is not
+ *      -ENOSYS:   Notification type specified by notify_type is not
  *                      supported.
  *  Requires:
  *      strm_init(void) called.
diff --git a/arch/arm/plat-omap/include/dspbridge/wmd.h b/arch/arm/plat-omap/include/dspbridge/wmd.h
index bbfa800..6cc0084 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmd.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmd.h
@@ -1044,7 +1044,7 @@ typedef void (*fxn_msg_setqueueid) (struct msg_queue *msg_queue_obj,
  *  and copied into the 'Bridge class driver's own space.  If any interface
  *  function field is set to a value of NULL, then the class driver will
  *  consider that function not implemented, and return the error code
- *  DSP_ENOTIMPL when a WMD client attempts to call that function.
+ *  -ENOSYS when a WMD client attempts to call that function.
  *
  *  This function table contains WCD version numbers, which are used by the
  *  WMD loader to help ensure backwards compatility between older WMD's and a
diff --git a/drivers/dsp/bridge/pmgr/cod.c b/drivers/dsp/bridge/pmgr/cod.c
index 43e7632..b4b71fc 100644
--- a/drivers/dsp/bridge/pmgr/cod.c
+++ b/drivers/dsp/bridge/pmgr/cod.c
@@ -232,7 +232,7 @@ dsp_status cod_create(OUT struct cod_manager **phMgr, char *pstrDummyFile,
 
 	/* we don't support non-default attrs yet */
 	if (attrs != NULL)
-		return DSP_ENOTIMPL;
+		return -ENOSYS;
 
 	mgr_new = mem_calloc(sizeof(struct cod_manager), MEM_NONPAGED);
 	if (mgr_new == NULL)
diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index f2e9278..8d6f9ea 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -589,7 +589,7 @@ dsp_status dbll_load_sect(struct dbll_library_obj *zl_lib, char *sectName,
 {
 	DBC_REQUIRE(MEM_IS_VALID_HANDLE(zl_lib, DBLL_LIBSIGNATURE));
 
-	return DSP_ENOTIMPL;
+	return -ENOSYS;
 }
 
 /*
@@ -874,7 +874,7 @@ dsp_status dbll_unload_sect(struct dbll_library_obj *lib, char *sectName,
 	DBC_REQUIRE(refs > 0);
 	DBC_REQUIRE(sectName != NULL);
 
-	return DSP_ENOTIMPL;
+	return -ENOSYS;
 }
 
 /*
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index d382c1d..03524c0 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -217,7 +217,7 @@ dsp_status dev_create_device(OUT struct dev_object **phDevObject,
 			       __func__);
 		}
 		status = chnl_create(&dev_obj->hchnl_mgr, dev_obj, &mgr_attrs);
-		if (status == DSP_ENOTIMPL) {
+		if (status == -ENOSYS) {
 			/* It's OK for a device not to have a channel
 			 * manager: */
 			status = DSP_SOK;
@@ -933,11 +933,11 @@ dsp_status dev_start_device(struct cfg_devnode *dev_node_obj)
  *  Parameters:
  *      Multiple, optional.
  *  Returns:
- *      DSP_ENOTIMPL:   Always.
+ *      -ENOSYS:   Always.
  */
 static dsp_status fxn_not_implemented(int arg, ...)
 {
-	return DSP_ENOTIMPL;
+	return -ENOSYS;
 }
 
 /*
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index b86c17a..a7ed6af 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -1441,7 +1441,7 @@ u32 __deprecated strmwrap_get_event_handle(union Trapped_Args * args,
 					   void *pr_ctxt)
 {
 	pr_err("%s: deprecated dspbridge ioctl\n", __func__);
-	return DSP_ENOTIMPL;
+	return -ENOSYS;
 }
 
 /*
@@ -1523,7 +1523,7 @@ u32 strmwrap_open(union Trapped_Args *args, void *pr_ctxt)
 		if (DSP_SUCCEEDED(status)) {
 			attr.stream_attr_in = &strm_attr_in;
 			if (attr.stream_attr_in->strm_mode == STRMMODE_LDMA)
-				return DSP_ENOTIMPL;
+				return -ENOSYS;
 		}
 
 	}
@@ -1613,7 +1613,7 @@ u32 __deprecated cmmwrap_calloc_buf(union Trapped_Args * args, void *pr_ctxt)
 {
 	/* This operation is done in kernel */
 	pr_err("%s: deprecated dspbridge ioctl\n", __func__);
-	return DSP_ENOTIMPL;
+	return -ENOSYS;
 }
 
 /*
@@ -1623,7 +1623,7 @@ u32 __deprecated cmmwrap_free_buf(union Trapped_Args * args, void *pr_ctxt)
 {
 	/* This operation is done in kernel */
 	pr_err("%s: deprecated dspbridge ioctl\n", __func__);
-	return DSP_ENOTIMPL;
+	return -ENOSYS;
 }
 
 /*
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 159d227..f242580 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -2046,7 +2046,7 @@ dsp_status node_pause(struct node_object *hnode)
 	status = proc_get_processor_id(pnode->hprocessor, &proc_id);
 
 	if (proc_id == IVA_UNIT)
-		status = DSP_ENOTIMPL;
+		status = -ENOSYS;
 
 	if (DSP_SUCCEEDED(status)) {
 		hnode_mgr = hnode->hnode_mgr;
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 581774a..af9f2c2 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -765,7 +765,7 @@ dsp_status proc_get_state(void *hprocessor,
 dsp_status proc_get_trace(void *hprocessor, u8 * pbuf, u32 max_size)
 {
 	dsp_status status;
-	status = DSP_ENOTIMPL;
+	status = -ENOSYS;
 	return status;
 }
 
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index 16025b4..13826fc 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -727,7 +727,7 @@ dsp_status strm_register_notify(struct strm_object *hStrm, u32 event_mask,
 		status = DSP_EVALUE;
 	} else {
 		if (notify_type != DSP_SIGNALEVENT)
-			status = DSP_ENOTIMPL;
+			status = -ENOSYS;
 
 	}
 	if (DSP_SUCCEEDED(status)) {
@@ -742,7 +742,7 @@ dsp_status strm_register_notify(struct strm_object *hStrm, u32 event_mask,
 	/* ensure we return a documented return code */
 	DBC_ENSURE(DSP_SUCCEEDED(status) || status == -EFAULT ||
 		   status == DSP_ETIMEOUT || status == DSP_ETRANSLATE ||
-		   status == DSP_ENOTIMPL || status == DSP_EFAIL);
+		   status == -ENOSYS || status == DSP_EFAIL);
 	return status;
 }
 
diff --git a/drivers/dsp/bridge/services/ntfy.c b/drivers/dsp/bridge/services/ntfy.c
index badff77..e64928b 100644
--- a/drivers/dsp/bridge/services/ntfy.c
+++ b/drivers/dsp/bridge/services/ntfy.c
@@ -213,10 +213,10 @@ dsp_status ntfy_register(struct ntfy_object *ntfy_obj,
 	if (hnotification == NULL)
 		status = -EFAULT;
 
-	/* Return DSP_ENOTIMPL if notify_type is not supported */
+	/* Return -ENOSYS if notify_type is not supported */
 	if (DSP_SUCCEEDED(status)) {
 		if (!IS_VALID_NOTIFY_MASK(notify_type))
-			status = DSP_ENOTIMPL;
+			status = -ENOSYS;
 
 	}
 
-- 
1.6.0.4

