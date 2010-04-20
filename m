From: Ernesto Ramos <ernesto@ti.com>
Subject: [PATCH 4/5v3] DSPBRIDGE: Use stream id instead of kernel address.
Date: Tue, 20 Apr 2010 18:02:59 -0500
Message-ID: <1271804580-17072-4-git-send-email-ernesto@ti.com>
References: <1271804580-17072-1-git-send-email-ernesto@ti.com>
 <1271804580-17072-2-git-send-email-ernesto@ti.com>
 <1271804580-17072-3-git-send-email-ernesto@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36104 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751767Ab0DTXCF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Apr 2010 19:02:05 -0400
In-Reply-To: <1271804580-17072-3-git-send-email-ernesto@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.contreras@nokia.com, ameya.palande@nokia.com, hiroshi.doyu@nokia.com, Ernesto Ramos <ernesto@ti.com>

Send stream ids to the user instead of handles, then when
the id is coming from user dspbridge can retrive the handle
using id and avoid using invalid handles.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/drv.h         |    5 +-
 .../plat-omap/include/dspbridge/resourcecleanup.h  |    6 -
 arch/arm/plat-omap/include/dspbridge/strm.h        |    8 +-
 drivers/dsp/bridge/pmgr/wcd.c                      |  115 +++++++++++++---
 drivers/dsp/bridge/rmgr/drv.c                      |  151 +++++++-------------
 drivers/dsp/bridge/rmgr/drv_interface.c            |   13 ++-
 drivers/dsp/bridge/rmgr/strm.c                     |   75 +++++-----
 7 files changed, 198 insertions(+), 175 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-omap/include/dspbridge/drv.h
index 02f93f5..9307001 100644
--- a/arch/arm/plat-omap/include/dspbridge/drv.h
+++ b/arch/arm/plat-omap/include/dspbridge/drv.h
@@ -114,7 +114,7 @@ struct strm_res_object {
 	void *hstream;
 	u32 num_bufs;
 	u32 dir;
-	struct strm_res_object *next;
+	int id;
 };
 
 /* Overall Bridge process resource usage state */
@@ -146,8 +146,7 @@ struct process_context {
 	struct dspheap_res_object *pdspheap_list;
 
 	/* Stream resources */
-	struct strm_res_object *pstrm_list;
-	struct mutex strm_mutex;
+	struct idr *strm_idp;
 };
 
 /*
diff --git a/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h b/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
index 00d5148..4e93446 100644
--- a/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
+++ b/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
@@ -47,12 +47,6 @@ extern dsp_status drv_proc_insert_strm_res_element(bhandle hStrm,
 						   bhandle strm_res,
 						   bhandle pPctxt);
 
-extern dsp_status drv_get_strm_res_element(bhandle hStrm, bhandle strm_res,
-					   bhandle ctxt);
-
-extern dsp_status drv_proc_remove_strm_res_element(bhandle strm_res,
-						   bhandle ctxt);
-
 extern dsp_status drv_remove_all_strm_res_elements(bhandle ctxt);
 
 extern enum node_state node_get_state(bhandle hnode);
diff --git a/arch/arm/plat-omap/include/dspbridge/strm.h b/arch/arm/plat-omap/include/dspbridge/strm.h
index 51a897f..4f12989 100644
--- a/arch/arm/plat-omap/include/dspbridge/strm.h
+++ b/arch/arm/plat-omap/include/dspbridge/strm.h
@@ -44,7 +44,7 @@
  *      ap_buffer != NULL.
  *  Ensures:
  */
-extern dsp_status strm_allocate_buffer(struct strm_object *hStrm,
+extern dsp_status strm_allocate_buffer(struct strm_res_object *strmres,
 				       u32 usize,
 				       OUT u8 **ap_buffer,
 				       u32 num_bufs,
@@ -66,7 +66,7 @@ extern dsp_status strm_allocate_buffer(struct strm_object *hStrm,
  *      strm_init(void) called.
  *  Ensures:
  */
-extern dsp_status strm_close(struct strm_object *hStrm,
+extern dsp_status strm_close(struct strm_res_object *strmres,
 			     struct process_context *pr_ctxt);
 
 /*
@@ -137,7 +137,7 @@ extern void strm_exit(void);
  *      ap_buffer != NULL.
  *  Ensures:
  */
-extern dsp_status strm_free_buffer(struct strm_object *hStrm,
+extern dsp_status strm_free_buffer(struct strm_res_object *strmres,
 				   u8 **ap_buffer, u32 num_bufs,
 				   struct process_context *pr_ctxt);
 
@@ -273,7 +273,7 @@ extern dsp_status strm_issue(struct strm_object *hStrm, IN u8 * pbuf,
  */
 extern dsp_status strm_open(struct node_object *hnode, u32 dir,
 			    u32 index, IN struct strm_attr *pattr,
-			    OUT struct strm_object **phStrm,
+			    OUT struct strm_res_object **strmres,
 			    struct process_context *pr_ctxt);
 
 /*
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index e6e193d..7c52c6b 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -1491,6 +1491,19 @@ func_cont:
 }
 
 /*
+ * ======== find_strm_handle =========
+ */
+inline void find_strm_handle(struct strm_res_object **strmres,
+				void *pr_ctxt, void *hstream)
+{
+	rcu_read_lock();
+	*strmres = idr_find(((struct process_context *)pr_ctxt)->strm_idp,
+							(int)hstream);
+	rcu_read_unlock();
+	return;
+}
+
+/*
  * ======== strmwrap_allocate_buffer ========
  */
 u32 strmwrap_allocate_buffer(union Trapped_Args *args, void *pr_ctxt)
@@ -1498,13 +1511,20 @@ u32 strmwrap_allocate_buffer(union Trapped_Args *args, void *pr_ctxt)
 	dsp_status status;
 	u8 **ap_buffer = NULL;
 	u32 num_bufs = args->args_strm_allocatebuffer.num_bufs;
+	struct strm_res_object *strm_res;
+
+	find_strm_handle(&strm_res, pr_ctxt,
+		args->args_strm_allocatebuffer.hstream);
+
+	if (!strm_res)
+		return DSP_EHANDLE;
 
 	if (num_bufs > MAX_BUFS)
 		return DSP_EINVALIDARG;
 
 	ap_buffer = mem_alloc((num_bufs * sizeof(u8 *)), MEM_NONPAGED);
 
-	status = strm_allocate_buffer(args->args_strm_allocatebuffer.hstream,
+	status = strm_allocate_buffer(strm_res,
 				      args->args_strm_allocatebuffer.usize,
 				      ap_buffer, num_bufs, pr_ctxt);
 	if (DSP_SUCCEEDED(status)) {
@@ -1512,7 +1532,7 @@ u32 strmwrap_allocate_buffer(union Trapped_Args *args, void *pr_ctxt)
 			  status, num_bufs);
 		if (DSP_FAILED(status)) {
 			status = DSP_EPOINTER;
-			strm_free_buffer(args->args_strm_allocatebuffer.hstream,
+			strm_free_buffer(strm_res,
 					 ap_buffer, num_bufs, pr_ctxt);
 		}
 	}
@@ -1526,7 +1546,14 @@ u32 strmwrap_allocate_buffer(union Trapped_Args *args, void *pr_ctxt)
  */
 u32 strmwrap_close(union Trapped_Args *args, void *pr_ctxt)
 {
-	return strm_close(args->args_strm_close.hstream, pr_ctxt);
+	struct strm_res_object *strm_res;
+
+	find_strm_handle(&strm_res, pr_ctxt, args->args_strm_close.hstream);
+
+	if (!strm_res)
+		return DSP_EHANDLE;
+
+	return strm_close(strm_res, pr_ctxt);
 }
 
 /*
@@ -1537,6 +1564,13 @@ u32 strmwrap_free_buffer(union Trapped_Args *args, void *pr_ctxt)
 	dsp_status status = DSP_SOK;
 	u8 **ap_buffer = NULL;
 	u32 num_bufs = args->args_strm_freebuffer.num_bufs;
+	struct strm_res_object *strm_res;
+
+	find_strm_handle(&strm_res, pr_ctxt,
+			args->args_strm_freebuffer.hstream);
+
+	if (!strm_res)
+		return DSP_EHANDLE;
 
 	if (num_bufs > MAX_BUFS)
 		return DSP_EINVALIDARG;
@@ -1546,10 +1580,10 @@ u32 strmwrap_free_buffer(union Trapped_Args *args, void *pr_ctxt)
 	CP_FM_USR(ap_buffer, args->args_strm_freebuffer.ap_buffer, status,
 		  num_bufs);
 
-	if (DSP_SUCCEEDED(status)) {
-		status = strm_free_buffer(args->args_strm_freebuffer.hstream,
+	if (DSP_SUCCEEDED(status))
+		status = strm_free_buffer(strm_res,
 					  ap_buffer, num_bufs, pr_ctxt);
-	}
+
 	CP_TO_USR(args->args_strm_freebuffer.ap_buffer, ap_buffer, status,
 		  num_bufs);
 	kfree(ap_buffer);
@@ -1576,6 +1610,13 @@ u32 strmwrap_get_info(union Trapped_Args *args, void *pr_ctxt)
 	struct stream_info strm_info;
 	struct dsp_streaminfo user;
 	struct dsp_streaminfo *temp;
+	struct strm_res_object *strm_res;
+
+	find_strm_handle(&strm_res, pr_ctxt,
+			args->args_strm_getinfo.hstream);
+
+	if (!strm_res)
+		return DSP_EHANDLE;
 
 	CP_FM_USR(&strm_info, args->args_strm_getinfo.stream_info, status, 1);
 	temp = strm_info.user_strm;
@@ -1583,7 +1624,7 @@ u32 strmwrap_get_info(union Trapped_Args *args, void *pr_ctxt)
 	strm_info.user_strm = &user;
 
 	if (DSP_SUCCEEDED(status)) {
-		status = strm_get_info(args->args_strm_getinfo.hstream,
+		status = strm_get_info(strm_res->hstream,
 				       &strm_info,
 				       args->args_strm_getinfo.
 				       stream_info_size);
@@ -1600,9 +1641,14 @@ u32 strmwrap_get_info(union Trapped_Args *args, void *pr_ctxt)
 u32 strmwrap_idle(union Trapped_Args *args, void *pr_ctxt)
 {
 	u32 ret;
+	struct strm_res_object *strm_res;
+
+	find_strm_handle(&strm_res, pr_ctxt, args->args_strm_idle.hstream);
 
-	ret = strm_idle(args->args_strm_idle.hstream,
-			args->args_strm_idle.flush_flag);
+	if (!strm_res)
+		return DSP_EHANDLE;
+
+	ret = strm_idle(strm_res->hstream, args->args_strm_idle.flush_flag);
 
 	return ret;
 }
@@ -1613,6 +1659,12 @@ u32 strmwrap_idle(union Trapped_Args *args, void *pr_ctxt)
 u32 strmwrap_issue(union Trapped_Args *args, void *pr_ctxt)
 {
 	dsp_status status = DSP_SOK;
+	struct strm_res_object *strm_res;
+
+	find_strm_handle(&strm_res, pr_ctxt, args->args_strm_issue.hstream);
+
+	if (!strm_res)
+		return DSP_EHANDLE;
 
 	if (!args->args_strm_issue.pbuffer)
 		return DSP_EPOINTER;
@@ -1620,7 +1672,7 @@ u32 strmwrap_issue(union Trapped_Args *args, void *pr_ctxt)
 	/* No need of doing CP_FM_USR for the user buffer (pbuffer)
 	   as this is done in Bridge internal function bridge_chnl_add_io_req
 	   in chnl_sm.c */
-	status = strm_issue(args->args_strm_issue.hstream,
+	status = strm_issue(strm_res->hstream,
 			    args->args_strm_issue.pbuffer,
 			    args->args_strm_issue.dw_bytes,
 			    args->args_strm_issue.dw_buf_size,
@@ -1636,7 +1688,7 @@ u32 strmwrap_open(union Trapped_Args *args, void *pr_ctxt)
 {
 	dsp_status status = DSP_SOK;
 	struct strm_attr attr;
-	struct strm_object *strm_obj;
+	struct strm_res_object *strm_res_obj;
 	struct dsp_streamattrin strm_attr_in;
 	struct node_res_object *node_res;
 
@@ -1658,9 +1710,9 @@ u32 strmwrap_open(union Trapped_Args *args, void *pr_ctxt)
 	}
 	status = strm_open(node_res->hnode,
 			   args->args_strm_open.direction,
-			   args->args_strm_open.index, &attr, &strm_obj,
+			   args->args_strm_open.index, &attr, &strm_res_obj,
 			   pr_ctxt);
-	CP_TO_USR(args->args_strm_open.ph_stream, &strm_obj, status, 1);
+	CP_TO_USR(args->args_strm_open.ph_stream, &strm_res_obj->id, status, 1);
 	return status;
 }
 
@@ -1674,8 +1726,14 @@ u32 strmwrap_reclaim(union Trapped_Args *args, void *pr_ctxt)
 	u32 ul_bytes;
 	u32 dw_arg;
 	u32 ul_buf_size;
+	struct strm_res_object *strm_res;
+
+	find_strm_handle(&strm_res, pr_ctxt, args->args_strm_reclaim.hstream);
+
+	if (!strm_res)
+		return DSP_EHANDLE;
 
-	status = strm_reclaim(args->args_strm_reclaim.hstream, &buf_ptr,
+	status = strm_reclaim(strm_res->hstream, &buf_ptr,
 			      &ul_bytes, &ul_buf_size, &dw_arg);
 	CP_TO_USR(args->args_strm_reclaim.buf_ptr, &buf_ptr, status, 1);
 	CP_TO_USR(args->args_strm_reclaim.bytes, &ul_bytes, status, 1);
@@ -1696,12 +1754,19 @@ u32 strmwrap_register_notify(union Trapped_Args *args, void *pr_ctxt)
 {
 	dsp_status status = DSP_SOK;
 	struct dsp_notification notification;
+	struct strm_res_object *strm_res;
+
+	find_strm_handle(&strm_res, pr_ctxt,
+			args->args_strm_registernotify.hstream);
+
+	if (!strm_res)
+		return DSP_EHANDLE;
 
 	/* Initialize the notification data structure */
 	notification.ps_name = NULL;
 	notification.handle = NULL;
 
-	status = strm_register_notify(args->args_strm_registernotify.hstream,
+	status = strm_register_notify(strm_res->hstream,
 				      args->args_strm_registernotify.event_mask,
 				      args->args_strm_registernotify.
 				      notify_type, &notification);
@@ -1719,12 +1784,28 @@ u32 strmwrap_select(union Trapped_Args *args, void *pr_ctxt)
 	u32 mask;
 	struct strm_object *strm_tab[MAX_STREAMS];
 	dsp_status status = DSP_SOK;
+	struct strm_res_object *strm_res;
+	int *ids[MAX_STREAMS];
+	int i;
 
 	if (args->args_strm_select.strm_num > MAX_STREAMS)
 		return DSP_EINVALIDARG;
 
-	CP_FM_USR(strm_tab, args->args_strm_select.stream_tab, status,
-		  args->args_strm_select.strm_num);
+	CP_FM_USR(ids, args->args_strm_select.stream_tab, status,
+		args->args_strm_select.strm_num);
+
+	if (DSP_FAILED(status))
+		return status;
+
+	for (i = 0; i < args->args_strm_select.strm_num; i++) {
+		find_strm_handle(&strm_res, pr_ctxt, ids[i]);
+
+		if (!strm_res)
+			return DSP_EHANDLE;
+
+		strm_tab[i] = strm_res->hstream;
+	}
+
 	if (DSP_SUCCEEDED(status)) {
 		status = strm_select(strm_tab, args->args_strm_select.strm_num,
 				     &mask, args->args_strm_select.utimeout);
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index b41c753..ad0391f 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -207,75 +207,44 @@ dsp_status drv_remove_all_node_res_elements(bhandle hPCtxt)
 dsp_status drv_proc_insert_strm_res_element(bhandle hStreamHandle,
 					    bhandle hstrm_res, bhandle hPCtxt)
 {
-	struct strm_res_object **pstrm_res =
-	    (struct strm_res_object **)hstrm_res;
-	struct process_context *ctxt = (struct process_context *)hPCtxt;
+	struct strm_res_object **pstrm_res = hstrm_res;
+	struct process_context *ctxt = hPCtxt;
 	dsp_status status = DSP_SOK;
-	struct strm_res_object *temp_strm_res = NULL;
+	int retval;
 
 	*pstrm_res = (struct strm_res_object *)
 	    mem_calloc(1 * sizeof(struct strm_res_object), MEM_PAGED);
-	if (*pstrm_res == NULL)
+	if (*pstrm_res == NULL) {
 		status = DSP_EHANDLE;
+		goto func_end;
+	}
 
-	if (DSP_SUCCEEDED(status)) {
-		if (mutex_lock_interruptible(&ctxt->strm_mutex)) {
-			kfree(*pstrm_res);
-			return DSP_EFAIL;
+	(*pstrm_res)->hstream = hStreamHandle;
+	retval = idr_get_new(ctxt->strm_idp, *pstrm_res,
+						&(*pstrm_res)->id);
+	if (retval == -EAGAIN) {
+		if (!idr_pre_get(ctxt->strm_idp, GFP_KERNEL)) {
+			pr_err("%s: OUT OF MEMORY\n", __func__);
+			status = DSP_EMEMORY;
+			goto func_end;
 		}
-		(*pstrm_res)->hstream = hStreamHandle;
-		if (ctxt->pstrm_list != NULL) {
-			temp_strm_res = ctxt->pstrm_list;
-			while (temp_strm_res->next != NULL)
-				temp_strm_res = temp_strm_res->next;
 
-			temp_strm_res->next = *pstrm_res;
-		} else {
-			ctxt->pstrm_list = *pstrm_res;
-		}
-		mutex_unlock(&ctxt->strm_mutex);
+		retval = idr_get_new(ctxt->strm_idp, *pstrm_res,
+						&(*pstrm_res)->id);
 	}
-	return status;
-}
-
-/* Release Stream resource element context
-* This function called after the actual resource is freed
- */
-dsp_status drv_proc_remove_strm_res_element(bhandle hstrm_res, bhandle hPCtxt)
-{
-	struct strm_res_object *pstrm_res = (struct strm_res_object *)hstrm_res;
-	struct process_context *ctxt = (struct process_context *)hPCtxt;
-	struct strm_res_object *temp_strm_res;
-	dsp_status status = DSP_SOK;
-
-	if (mutex_lock_interruptible(&ctxt->strm_mutex))
-		return DSP_EFAIL;
-	temp_strm_res = ctxt->pstrm_list;
-
-	if (ctxt->pstrm_list == pstrm_res) {
-		ctxt->pstrm_list = pstrm_res->next;
-	} else {
-		while (temp_strm_res && temp_strm_res->next != pstrm_res)
-			temp_strm_res = temp_strm_res->next;
-		if (temp_strm_res == NULL)
-			status = DSP_ENOTFOUND;
-		else
-			temp_strm_res->next = pstrm_res->next;
+	if (retval) {
+		pr_err("%s: FAILED, IDR is FULL\n", __func__);
+		status = DSP_EFAIL;
 	}
-	mutex_unlock(&ctxt->strm_mutex);
-	kfree(pstrm_res);
+
+func_end:
 	return status;
 }
 
-/* Release all Stream resources and its context
-* This is called from .bridge_release.
- */
-dsp_status drv_remove_all_strm_res_elements(bhandle hPCtxt)
+static int drv_proc_free_strm_res(int id, void *p, void *data)
 {
-	struct process_context *ctxt = (struct process_context *)hPCtxt;
-	dsp_status status = DSP_SOK;
-	struct strm_res_object *strm_res = NULL;
-	struct strm_res_object *strm_tmp = NULL;
+	struct process_context *ctxt = data;
+	struct strm_res_object *strm_res = p;
 	struct stream_info strm_info;
 	struct dsp_streaminfo user;
 	u8 **ap_buffer = NULL;
@@ -284,60 +253,38 @@ dsp_status drv_remove_all_strm_res_elements(bhandle hPCtxt)
 	u32 dw_arg;
 	s32 ul_buf_size;
 
-	strm_tmp = ctxt->pstrm_list;
-	while (strm_tmp) {
-		strm_res = strm_tmp;
-		strm_tmp = strm_tmp->next;
-		if (strm_res->num_bufs) {
-			ap_buffer = mem_alloc((strm_res->num_bufs *
-					       sizeof(u8 *)), MEM_NONPAGED);
-			if (ap_buffer) {
-				status = strm_free_buffer(strm_res->hstream,
-							  ap_buffer,
-							  strm_res->num_bufs,
-							  ctxt);
-				kfree(ap_buffer);
-			}
+	if (strm_res->num_bufs) {
+		ap_buffer = mem_alloc((strm_res->num_bufs *
+				       sizeof(u8 *)), MEM_NONPAGED);
+		if (ap_buffer) {
+			strm_free_buffer(strm_res,
+						  ap_buffer,
+						  strm_res->num_bufs,
+						  ctxt);
+			kfree(ap_buffer);
 		}
-		strm_info.user_strm = &user;
-		user.number_bufs_in_stream = 0;
-		strm_get_info(strm_res->hstream, &strm_info, sizeof(strm_info));
-		while (user.number_bufs_in_stream--)
-			strm_reclaim(strm_res->hstream, &buf_ptr, &ul_bytes,
-				     (u32 *) &ul_buf_size, &dw_arg);
-		status = strm_close(strm_res->hstream, ctxt);
 	}
-	return status;
+	strm_info.user_strm = &user;
+	user.number_bufs_in_stream = 0;
+	strm_get_info(strm_res->hstream, &strm_info, sizeof(strm_info));
+	while (user.number_bufs_in_stream--)
+		strm_reclaim(strm_res->hstream, &buf_ptr, &ul_bytes,
+			     (u32 *) &ul_buf_size, &dw_arg);
+	strm_close(strm_res, ctxt);
+	return 0;
 }
 
-/* Getting the stream resource element */
-dsp_status drv_get_strm_res_element(bhandle hStrm, bhandle hstrm_res,
-				    bhandle hPCtxt)
+/* Release all Stream resources and its context
+* This is called from .bridge_release.
+ */
+dsp_status drv_remove_all_strm_res_elements(bhandle hPCtxt)
 {
-	struct strm_res_object **strm_res =
-	    (struct strm_res_object **)hstrm_res;
 	struct process_context *ctxt = (struct process_context *)hPCtxt;
-	dsp_status status = DSP_SOK;
-	struct strm_res_object *temp_strm2 = NULL;
-	struct strm_res_object *temp_strm;
 
-	if (mutex_lock_interruptible(&ctxt->strm_mutex))
-		return DSP_EFAIL;
+	idr_for_each(ctxt->strm_idp, drv_proc_free_strm_res, ctxt);
+	idr_destroy(ctxt->strm_idp);
 
-	temp_strm = ctxt->pstrm_list;
-	while ((temp_strm != NULL) && (temp_strm->hstream != hStrm)) {
-		temp_strm2 = temp_strm;
-		temp_strm = temp_strm->next;
-	}
-
-	mutex_unlock(&ctxt->strm_mutex);
-
-	if (temp_strm != NULL)
-		*strm_res = temp_strm;
-	else
-		status = DSP_ENOTFOUND;
-
-	return status;
+	return DSP_SOK;
 }
 
 /* Updating the stream resource element */
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index be5efb7..77d63fc 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -506,17 +506,24 @@ static int bridge_open(struct inode *ip, struct file *filp)
 		INIT_LIST_HEAD(&pr_ctxt->dmm_map_list);
 		spin_lock_init(&pr_ctxt->dmm_rsv_lock);
 		INIT_LIST_HEAD(&pr_ctxt->dmm_rsv_list);
-		mutex_init(&pr_ctxt->strm_mutex);
 
 		pr_ctxt->node_idp = mem_calloc(sizeof(struct idr), MEM_PAGED);
-		if (pr_ctxt->node_idp)
+		if (pr_ctxt->node_idp) {
 			idr_init(pr_ctxt->node_idp);
+		} else {
+			status = -ENOMEM;
+			goto err;
+		}
+
+		pr_ctxt->strm_idp = mem_calloc(sizeof(struct idr), MEM_PAGED);
+		if (pr_ctxt->strm_idp)
+			idr_init(pr_ctxt->strm_idp);
 		else
 			status = -ENOMEM;
 	} else {
 		status = -ENOMEM;
 	}
-
+err:
 	filp->private_data = pr_ctxt;
 #ifdef CONFIG_BRIDGE_RECOVERY
 	if (!status)
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index 699f2dc..ddfb1f6 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -102,20 +102,19 @@ static void delete_strm_mgr(struct strm_mgr *strm_mgr_obj);
  *  Purpose:
  *      Allocates buffers for a stream.
  */
-dsp_status strm_allocate_buffer(struct strm_object *hStrm, u32 usize,
+dsp_status strm_allocate_buffer(struct strm_res_object *strmres, u32 usize,
 				OUT u8 **ap_buffer, u32 num_bufs,
 				struct process_context *pr_ctxt)
 {
 	dsp_status status = DSP_SOK;
 	u32 alloc_cnt = 0;
 	u32 i;
-
-	bhandle hstrm_res;
+	struct strm_object *hstrm = strmres->hstream;
 
 	DBC_REQUIRE(refs > 0);
 	DBC_REQUIRE(ap_buffer != NULL);
 
-	if (MEM_IS_VALID_HANDLE(hStrm, STRM_SIGNATURE)) {
+	if (MEM_IS_VALID_HANDLE(hstrm, STRM_SIGNATURE)) {
 		/*
 		 * Allocate from segment specified at time of stream open.
 		 */
@@ -130,8 +129,8 @@ dsp_status strm_allocate_buffer(struct strm_object *hStrm, u32 usize,
 		goto func_end;
 
 	for (i = 0; i < num_bufs; i++) {
-		DBC_ASSERT(hStrm->xlator != NULL);
-		(void)cmm_xlator_alloc_buf(hStrm->xlator, &ap_buffer[i], usize);
+		DBC_ASSERT(hstrm->xlator != NULL);
+		(void)cmm_xlator_alloc_buf(hstrm->xlator, &ap_buffer[i], usize);
 		if (ap_buffer[i] == NULL) {
 			status = DSP_EMEMORY;
 			alloc_cnt = i;
@@ -139,14 +138,12 @@ dsp_status strm_allocate_buffer(struct strm_object *hStrm, u32 usize,
 		}
 	}
 	if (DSP_FAILED(status))
-		strm_free_buffer(hStrm, ap_buffer, alloc_cnt, pr_ctxt);
+		strm_free_buffer(strmres, ap_buffer, alloc_cnt, pr_ctxt);
 
 	if (DSP_FAILED(status))
 		goto func_end;
 
-	if (drv_get_strm_res_element(hStrm, &hstrm_res, pr_ctxt) !=
-	    DSP_ENOTFOUND)
-		drv_proc_update_strm_res(num_bufs, hstrm_res);
+	drv_proc_update_strm_res(num_bufs, strmres);
 
 func_end:
 	return status;
@@ -157,46 +154,43 @@ func_end:
  *  Purpose:
  *      Close a stream opened with strm_open().
  */
-dsp_status strm_close(struct strm_object *hStrm,
+dsp_status strm_close(struct strm_res_object *strmres,
 		      struct process_context *pr_ctxt)
 {
 	struct bridge_drv_interface *intf_fxns;
 	struct chnl_info chnl_info_obj;
 	dsp_status status = DSP_SOK;
-
-	bhandle hstrm_res;
+	struct strm_object *hstrm = strmres->hstream;
 
 	DBC_REQUIRE(refs > 0);
 
-	if (!MEM_IS_VALID_HANDLE(hStrm, STRM_SIGNATURE)) {
+	if (!MEM_IS_VALID_HANDLE(hstrm, STRM_SIGNATURE)) {
 		status = DSP_EHANDLE;
 	} else {
 		/* Have all buffers been reclaimed? If not, return
 		 * DSP_EPENDING */
-		intf_fxns = hStrm->strm_mgr_obj->intf_fxns;
+		intf_fxns = hstrm->strm_mgr_obj->intf_fxns;
 		status =
-		    (*intf_fxns->pfn_chnl_get_info) (hStrm->chnl_obj,
+		    (*intf_fxns->pfn_chnl_get_info) (hstrm->chnl_obj,
 						     &chnl_info_obj);
 		DBC_ASSERT(DSP_SUCCEEDED(status));
 
 		if (chnl_info_obj.cio_cs > 0 || chnl_info_obj.cio_reqs > 0)
 			status = DSP_EPENDING;
 		else
-			status = delete_strm(hStrm);
+			status = delete_strm(hstrm);
 	}
 
 	if (DSP_FAILED(status))
 		goto func_end;
 
-	if (drv_get_strm_res_element(hStrm, &hstrm_res, pr_ctxt) !=
-	    DSP_ENOTFOUND)
-		drv_proc_remove_strm_res_element(hstrm_res, pr_ctxt);
+	idr_remove(pr_ctxt->strm_idp, strmres->id);
 func_end:
 	DBC_ENSURE(status == DSP_SOK || status == DSP_EHANDLE ||
 		   status == DSP_EPENDING || status == DSP_EFAIL);
 
-	dev_dbg(bridge, "%s: hStrm: %p, status 0x%x\n", __func__,
-		hStrm, status);
+	dev_dbg(bridge, "%s: hstrm: %p, status 0x%x\n", __func__,
+		hstrm, status);
 	return status;
 }
 
@@ -279,33 +273,30 @@ void strm_exit(void)
  *  Purpose:
  *      Frees the buffers allocated for a stream.
  */
-dsp_status strm_free_buffer(struct strm_object *hStrm, u8 ** ap_buffer,
+dsp_status strm_free_buffer(struct strm_res_object *strmres, u8 ** ap_buffer,
 			    u32 num_bufs, struct process_context *pr_ctxt)
 {
 	dsp_status status = DSP_SOK;
 	u32 i = 0;
-
-	bhandle hstrm_res = NULL;
+	struct strm_object *hstrm = strmres->hstream;
 
 	DBC_REQUIRE(refs > 0);
 	DBC_REQUIRE(ap_buffer != NULL);
 
-	if (!MEM_IS_VALID_HANDLE(hStrm, STRM_SIGNATURE))
+	if (!MEM_IS_VALID_HANDLE(hstrm, STRM_SIGNATURE))
 		status = DSP_EHANDLE;
 
 	if (DSP_SUCCEEDED(status)) {
 		for (i = 0; i < num_bufs; i++) {
-			DBC_ASSERT(hStrm->xlator != NULL);
+			DBC_ASSERT(hstrm->xlator != NULL);
 			status =
-			    cmm_xlator_free_buf(hStrm->xlator, ap_buffer[i]);
+			    cmm_xlator_free_buf(hstrm->xlator, ap_buffer[i]);
 			if (DSP_FAILED(status))
 				break;
 			ap_buffer[i] = NULL;
 		}
 	}
-	if (drv_get_strm_res_element(hStrm, hstrm_res, pr_ctxt) !=
-	    DSP_ENOTFOUND)
-		drv_proc_update_strm_res(num_bufs - i, hstrm_res);
+	drv_proc_update_strm_res(num_bufs - i, strmres);
 
 	return status;
 }
@@ -473,7 +464,7 @@ dsp_status strm_issue(struct strm_object *hStrm, IN u8 *pbuf, u32 ul_bytes,
  */
 dsp_status strm_open(struct node_object *hnode, u32 dir, u32 index,
 		     IN struct strm_attr *pattr,
-		     OUT struct strm_object **phStrm,
+		     OUT struct strm_res_object **strmres,
 		     struct process_context *pr_ctxt)
 {
 	struct strm_mgr *strm_mgr_obj;
@@ -488,9 +479,9 @@ dsp_status strm_open(struct node_object *hnode, u32 dir, u32 index,
 	bhandle hstrm_res;
 
 	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(phStrm != NULL);
+	DBC_REQUIRE(strmres != NULL);
 	DBC_REQUIRE(pattr != NULL);
-	*phStrm = NULL;
+	*strmres = NULL;
 	if (dir != DSP_TONODE && dir != DSP_FROMNODE) {
 		status = DSP_EDIRECTION;
 	} else {
@@ -600,23 +591,27 @@ func_cont:
 		}
 	}
 	if (DSP_SUCCEEDED(status)) {
-		*phStrm = strm_obj;
-		drv_proc_insert_strm_res_element(*phStrm, &hstrm_res, pr_ctxt);
+		status = drv_proc_insert_strm_res_element(strm_obj,
+							&hstrm_res, pr_ctxt);
+		if (DSP_FAILED(status))
+			delete_strm(strm_obj);
+		else
+			*strmres = (struct strm_res_object *)hstrm_res;
 	} else {
 		(void)delete_strm(strm_obj);
 	}
 
 	/* ensure we return a documented error code */
 	DBC_ENSURE((DSP_SUCCEEDED(status) &&
-		    MEM_IS_VALID_HANDLE((*phStrm), STRM_SIGNATURE)) ||
-		   (*phStrm == NULL && (status == DSP_EHANDLE ||
+		    MEM_IS_VALID_HANDLE(strm_obj, STRM_SIGNATURE)) ||
+		   (*strmres == NULL && (status == DSP_EHANDLE ||
 					status == DSP_EDIRECTION
 					|| status == DSP_EVALUE
 					|| status == DSP_EFAIL)));
 
 	dev_dbg(bridge, "%s: hnode: %p dir: 0x%x index: 0x%x pattr: %p "
-		"phStrm: %p status: 0x%x\n", __func__,
-		hnode, dir, index, pattr, phStrm, status);
+		"strmres: %p status: 0x%x\n", __func__,
+		hnode, dir, index, pattr, strmres, status);
 	return status;
 }
 
-- 
1.5.4.5

