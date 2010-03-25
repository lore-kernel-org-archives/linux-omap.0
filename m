From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC][PATCH 10/19] DSPBRIDGE: Cleanup custom error code
 (DSP_EPOINTER -> EFAULT)
Date: Fri, 26 Mar 2010 01:36:41 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DEBEB26@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50123 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754667Ab0CYUGs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 16:06:48 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>

>From c4c2d2e82b5329c5fced3730c8b9ea7612bf861c Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Wed, 24 Mar 2010 11:26:00 -0600
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code (DSP_EPOINTER -> EFAULT).

This patch replaces DSP_EPOINTER with EFAULT

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/errbase.h |    3 ---
 arch/arm/plat-omap/include/dspbridge/wmd.h     |    8 ++++----
 drivers/dsp/bridge/pmgr/cmm.c                  |    2 +-
 drivers/dsp/bridge/pmgr/wcd.c                  |   18 +++++++++---------
 drivers/dsp/bridge/services/sync.c             |    2 +-
 drivers/dsp/bridge/wmd/chnl_sm.c               |   14 +++++++-------
 drivers/dsp/bridge/wmd/io_sm.c                 |    2 +-
 drivers/dsp/bridge/wmd/msg_sm.c                |    6 +++---
 8 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index aa848c8..da2900c 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -99,9 +99,6 @@
 /* I/O is currently pending. */
 #define DSP_EPENDING                (DSP_EBASE + 0x11)
 
-/* An invalid pointer was specified. */
-#define DSP_EPOINTER                (DSP_EBASE + 0x12)
-
 /* A parameter is specified outside its valid range. */
 #define DSP_ERANGE                  (DSP_EBASE + 0x13)
 
diff --git a/arch/arm/plat-omap/include/dspbridge/wmd.h b/arch/arm/plat-omap/include/dspbridge/wmd.h
index 6fe5d3f..8624538 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmd.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmd.h
@@ -451,7 +451,7 @@ typedef dsp_status(*fxn_chnl_close) (struct chnl_object *chnl_obj);
  *  Returns:
  *      DSP_SOK:        Success;
  *      EFAULT:    Invalid chnl_obj.
- *      DSP_EPOINTER:   pHostBuf is invalid.
+ *      EFAULT:   pHostBuf is invalid.
  *      CHNL_E_NOEOS:   User cannot mark EOS on an input channel.
  *      CHNL_E_CANCELLED: I/O has been cancelled on this channel.  No further
  *                      I/O is allowed.
@@ -492,7 +492,7 @@ typedef dsp_status(*fxn_chnl_addioreq) (struct chnl_object
  *  Returns:
  *      DSP_SOK:        Success.
  *      EFAULT:    Invalid chnl_obj.
- *      DSP_EPOINTER:   pIOC is invalid.
+ *      EFAULT:   pIOC is invalid.
  *      CHNL_E_NOIOC:   CHNL_IOCNOWAIT was specified as the dwTimeOut parameter
  *                      yet no I/O completions were queued.
  *  Requires:
@@ -556,7 +556,7 @@ typedef dsp_status(*fxn_chnl_flushio) (struct chnl_object *chnl_obj,
  *  Returns:
  *      DSP_SOK:        Success;
  *      EFAULT:    Invalid chnl_obj.
- *      DSP_EPOINTER:   pInfo == NULL.
+ *      EFAULT:   pInfo == NULL.
  *  Requires:
  *  Ensures:
  *      DSP_SOK:        pInfo points to a filled in chnl_info struct,
@@ -576,7 +576,7 @@ typedef dsp_status(*fxn_chnl_getinfo) (struct chnl_object *chnl_obj,
  *  Returns:
  *      DSP_SOK:            Success;
  *      EFAULT:        Invalid hchnl_mgr.
- *      DSP_EPOINTER:       pMgrInfo == NULL.
+ *      EFAULT:       pMgrInfo == NULL.
  *      CHNL_E_BADCHANID:   Invalid channel ID.
  *  Requires:
  *  Ensures:
diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c
index 84bec40..69fbf03 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -391,7 +391,7 @@ dsp_status cmm_free_buf(struct cmm_object *hcmm_mgr, void *buf_pa,
 			u32 ul_seg_id)
 {
 	struct cmm_object *cmm_mgr_obj = (struct cmm_object *)hcmm_mgr;
-	dsp_status status = DSP_EPOINTER;
+	dsp_status status = EFAULT;
 	struct cmm_mnode *mnode_obj = NULL;
 	struct cmm_allocator *allocator = NULL;
 	struct cmm_attrs *pattrs;
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index d062d22..8b0aeea 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -174,12 +174,12 @@ static inline void _cp_fm_usr(void *to, const void __user * from,
 		return;
 
 	if (unlikely(!from)) {
-		*err = DSP_EPOINTER;
+		*err = EFAULT;
 		return;
 	}
 
 	if (unlikely(copy_from_user(to, from, bytes)))
-		*err = DSP_EPOINTER;
+		*err = EFAULT;
 }
 
 #define CP_FM_USR(to, from, err, n)				\
@@ -192,12 +192,12 @@ static inline void _cp_to_usr(void __user *to, const void *from,
 		return;
 
 	if (unlikely(!to)) {
-		*err = DSP_EPOINTER;
+		*err = EFAULT;
 		return;
 	}
 
 	if (unlikely(copy_to_user(to, from, bytes)))
-		*err = DSP_EPOINTER;
+		*err = EFAULT;
 }
 
 #define CP_TO_USR(to, from, err, n)				\
@@ -500,7 +500,7 @@ u32 mgrwrap_register_object(union Trapped_Args *args, void *pr_ctxt)
 				(char *)args->args_mgr_registerobject.
 				psz_path_name, path_size);
 	if (!ret) {
-		status = DSP_EPOINTER;
+		status = EFAULT;
 		goto func_end;
 	}
 
@@ -1071,7 +1071,7 @@ u32 nodewrap_allocate(union Trapped_Args *args, void *pr_ctxt)
 	if (DSP_SUCCEEDED(status)) {
 		CP_TO_USR(args->args_node_allocate.ph_node, &hnode, status, 1);
 		if (DSP_FAILED(status)) {
-			status = DSP_EPOINTER;
+			status = EFAULT;
 			node_delete(hnode, pr_ctxt);
 		}
 	}
@@ -1214,7 +1214,7 @@ u32 nodewrap_free_msg_buf(union Trapped_Args *args, void *pr_ctxt)
 	}
 
 	if (!args->args_node_freemsgbuf.pbuffer)
-		return DSP_EPOINTER;
+		return EFAULT;
 
 	if (DSP_SUCCEEDED(status)) {
 		status = node_free_msg_buf(args->args_node_freemsgbuf.hnode,
@@ -1388,7 +1388,7 @@ u32 strmwrap_allocate_buffer(union Trapped_Args *args, void *pr_ctxt)
 		CP_TO_USR(args->args_strm_allocatebuffer.ap_buffer, ap_buffer,
 			  status, num_bufs);
 		if (DSP_FAILED(status)) {
-			status = DSP_EPOINTER;
+			status = EFAULT;
 			strm_free_buffer(args->args_strm_allocatebuffer.hstream,
 					 ap_buffer, num_bufs, pr_ctxt);
 		}
@@ -1492,7 +1492,7 @@ u32 strmwrap_issue(union Trapped_Args *args, void *pr_ctxt)
 	dsp_status status = DSP_SOK;
 
 	if (!args->args_strm_issue.pbuffer)
-		return DSP_EPOINTER;
+		return EFAULT;
 
 	/* No need of doing CP_FM_USR for the user buffer (pbuffer)
 	   as this is done in Bridge internal function bridge_chnl_add_io_req
diff --git a/drivers/dsp/bridge/services/sync.c b/drivers/dsp/bridge/services/sync.c
index e7f5c06..6d095c6 100644
--- a/drivers/dsp/bridge/services/sync.c
+++ b/drivers/dsp/bridge/services/sync.c
@@ -416,7 +416,7 @@ dsp_status sync_initialize_dpccs(OUT struct sync_csobject **phCSObj)
 		/* return CS object */
 		*phCSObj = (struct sync_csobject *)pcs_obj;
 	} else {
-		status = DSP_EPOINTER;
+		status = EFAULT;
 	}
 
 	DBC_ASSERT(DSP_FAILED(status) || (pcs_obj));
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index 43f2731..96488b9 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -110,7 +110,7 @@ dsp_status bridge_chnl_add_io_req(struct chnl_object *chnl_obj, void *pHostBuf,
 
 	/* Validate args */
 	if (!pHostBuf) {
-		status = DSP_EPOINTER;
+		status = EFAULT;
 	} else if (!MEM_IS_VALID_HANDLE(pchnl, CHNL_SIGNATURE)) {
 		status = EFAULT;
 	} else if (is_eos && CHNL_IS_INPUT(pchnl->chnl_mode)) {
@@ -158,7 +158,7 @@ dsp_status bridge_chnl_add_io_req(struct chnl_object *chnl_obj, void *pHostBuf,
 			if (status) {
 				kfree(host_sys_buf);
 				host_sys_buf = NULL;
-				status = DSP_EPOINTER;
+				status = EFAULT;
 				goto func_end;
 			}
 		}
@@ -563,7 +563,7 @@ dsp_status bridge_chnl_get_info(struct chnl_object *chnl_obj,
 			status = EFAULT;
 		}
 	} else {
-		status = DSP_EPOINTER;
+		status = EFAULT;
 	}
 	return status;
 }
@@ -590,7 +590,7 @@ dsp_status bridge_chnl_get_ioc(struct chnl_object *chnl_obj, u32 dwTimeOut,
 
 	/* Check args: */
 	if (pIOC == NULL) {
-		status = DSP_EPOINTER;
+		status = EFAULT;
 	} else if (!MEM_IS_VALID_HANDLE(pchnl, CHNL_SIGNATURE)) {
 		status = EFAULT;
 	} else if (dwTimeOut == CHNL_IOCNOWAIT) {
@@ -692,7 +692,7 @@ dsp_status bridge_chnl_get_ioc(struct chnl_object *chnl_obj, u32 dwTimeOut,
 
 		/* If the addr is in user mode, then copy it */
 		if (!host_sys_buf || !ioc.pbuf) {
-			status = DSP_EPOINTER;
+			status = EFAULT;
 			goto func_cont;
 		}
 		if (!CHNL_IS_INPUT(pchnl->chnl_mode))
@@ -705,7 +705,7 @@ dsp_status bridge_chnl_get_ioc(struct chnl_object *chnl_obj, u32 dwTimeOut,
 				status = 0;
 		}
 		if (status)
-			status = DSP_EPOINTER;
+			status = EFAULT;
 func_cont1:
 		kfree(host_sys_buf);
 	}
@@ -745,7 +745,7 @@ dsp_status bridge_chnl_get_mgr_info(struct chnl_mgr *hchnl_mgr, u32 uChnlID,
 			status = CHNL_E_BADCHANID;
 		}
 	} else {
-		status = DSP_EPOINTER;
+		status = EFAULT;
 	}
 
 	return status;
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index fe1378c..96bbb9b 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -715,7 +715,7 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
 		ul_shm_base = (u32) MEM_LINEAR_ADDRESS((void *)ul_shm_base,
 						       ul_mem_length);
 		if (ul_shm_base == 0) {
-			status = DSP_EPOINTER;
+			status = EFAULT;
 			goto func_end;
 		}
 		/* Register SM */
diff --git a/drivers/dsp/bridge/wmd/msg_sm.c b/drivers/dsp/bridge/wmd/msg_sm.c
index 89c13e3..217631a 100644
--- a/drivers/dsp/bridge/wmd/msg_sm.c
+++ b/drivers/dsp/bridge/wmd/msg_sm.c
@@ -62,12 +62,12 @@ dsp_status bridge_msg_create(OUT struct msg_mgr **phMsgMgr,
 	dsp_status status = DSP_SOK;
 
 	if (!phMsgMgr || !msgCallback || !hdev_obj) {
-		status = DSP_EPOINTER;
+		status = EFAULT;
 		goto func_end;
 	}
 	dev_get_io_mgr(hdev_obj, &hio_mgr);
 	if (!hio_mgr) {
-		status = DSP_EPOINTER;
+		status = EFAULT;
 		goto func_end;
 	}
 	*phMsgMgr = NULL;
@@ -437,7 +437,7 @@ dsp_status bridge_msg_put(struct msg_queue *msg_queue_obj,
 			status = DSP_EFAIL;
 		} else {
 			if (LST_IS_EMPTY(hmsg_mgr->msg_free_list)) {
-				status = DSP_EPOINTER;
+				status = EFAULT;
 				goto func_cont;
 			}
 			/* Get msg from free list */
-- 
1.6.0.4

