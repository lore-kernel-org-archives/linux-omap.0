From: Ernesto Ramos <ernesto@ti.com>
Subject: [PATCH 1/5v3] DSPBRIDGE: Use node id instead of kernel address
Date: Tue, 20 Apr 2010 18:02:56 -0500
Message-ID: <1271804580-17072-1-git-send-email-ernesto@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35623 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752118Ab0DTXCL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Apr 2010 19:02:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.contreras@nokia.com, ameya.palande@nokia.com, hiroshi.doyu@nokia.com, Ernesto Ramos <ernesto@ti.com>

Use idr kernel library to send/receive node ids to the
user instead of kernel address.
This id will be use to access the node handles at the
kernel side, if id does not match to any handle
DSP error DSP_EHANDlE is returned.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/drv.h         |    6 +-
 arch/arm/plat-omap/include/dspbridge/node.h        |    4 +-
 .../plat-omap/include/dspbridge/resourcecleanup.h  |    5 -
 drivers/dsp/bridge/pmgr/wcd.c                      |  158 +++++++++++++++++---
 drivers/dsp/bridge/rmgr/drv.c                      |  150 ++++++-------------
 drivers/dsp/bridge/rmgr/drv_interface.c            |    7 +-
 drivers/dsp/bridge/rmgr/node.c                     |  100 +++++++------
 7 files changed, 246 insertions(+), 184 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-omap/include/dspbridge/drv.h
index 947cbdd..02f93f5 100644
--- a/arch/arm/plat-omap/include/dspbridge/drv.h
+++ b/arch/arm/plat-omap/include/dspbridge/drv.h
@@ -24,6 +24,7 @@
 #include <dspbridge/devdefs.h>
 
 #include <dspbridge/drvdefs.h>
+#include <linux/idr.h>
 
 #define DRV_ASSIGN     1
 #define DRV_RELEASE    0
@@ -81,7 +82,7 @@ struct node_res_object {
 	s32 node_allocated;	/* Node status */
 	s32 heap_allocated;	/* Heap status */
 	s32 streams_allocated;	/* Streams status */
-	struct node_res_object *next;
+	int id;
 };
 
 /* Used for DMM mapped memory accounting */
@@ -131,8 +132,7 @@ struct process_context {
 	void *hprocessor;
 
 	/* DSP Node resources */
-	struct node_res_object *node_list;
-	struct mutex node_mutex;
+	struct idr *node_idp;
 
 	/* DMM mapped memory resources */
 	struct list_head dmm_map_list;
diff --git a/arch/arm/plat-omap/include/dspbridge/node.h b/arch/arm/plat-omap/include/dspbridge/node.h
index ec0dcf3..f2375a2 100644
--- a/arch/arm/plat-omap/include/dspbridge/node.h
+++ b/arch/arm/plat-omap/include/dspbridge/node.h
@@ -60,7 +60,7 @@ extern dsp_status node_allocate(struct proc_object *hprocessor,
 				OPTIONAL IN CONST struct dsp_cbdata
 				*pargs, OPTIONAL IN CONST struct dsp_nodeattrin
 				*attr_in,
-				OUT struct node_object **ph_node,
+				OUT struct node_res_object **noderes,
 				struct process_context *pr_ctxt);
 
 /*
@@ -261,7 +261,7 @@ extern dsp_status node_create_mgr(OUT struct node_mgr **phNodeMgr,
  *  Ensures:
  *      DSP_SOK:            hnode is invalid.
  */
-extern dsp_status node_delete(struct node_object *hnode,
+extern dsp_status node_delete(struct node_res_object *hnoderes,
 			      struct process_context *pr_ctxt);
 
 /*
diff --git a/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h b/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
index ef18477..00d5148 100644
--- a/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
+++ b/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
@@ -34,16 +34,11 @@ extern dsp_status drv_remove_all_resources(bhandle pPctxt);
 extern dsp_status drv_remove_proc_context(struct drv_object *hDRVObject,
 					  bhandle pr_ctxt);
 
-extern dsp_status drv_get_node_res_element(bhandle hnode, bhandle node_res,
-					   bhandle ctxt);
-
 extern dsp_status drv_insert_node_res_element(bhandle hnode, bhandle node_res,
 					      bhandle ctxt);
 
 extern void drv_proc_node_update_heap_status(bhandle hNodeRes, s32 status);
 
-extern dsp_status drv_remove_node_res_element(bhandle node_res, bhandle status);
-
 extern void drv_proc_node_update_status(bhandle hNodeRes, s32 status);
 
 extern dsp_status drv_proc_update_strm_res(u32 num_bufs, bhandle strm_res);
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 15a05a6..20e02f1 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -1021,6 +1021,20 @@ u32 procwrap_stop(union Trapped_Args *args, void *pr_ctxt)
 }
 
 /*
+ * ======== find_handle =========
+ */
+inline void find_node_handle(struct node_res_object **noderes,
+				void *pr_ctxt, void *hnode)
+{
+	rcu_read_lock();
+	*noderes = idr_find(((struct process_context *)pr_ctxt)->node_idp,
+								(int)hnode);
+	rcu_read_unlock();
+	return;
+}
+
+
+/*
  * ======== nodewrap_allocate ========
  */
 u32 nodewrap_allocate(union Trapped_Args *args, void *pr_ctxt)
@@ -1031,7 +1045,7 @@ u32 nodewrap_allocate(union Trapped_Args *args, void *pr_ctxt)
 	u32 __user *psize = (u32 __user *) args->args_node_allocate.pargs;
 	u8 *pargs = NULL;
 	struct dsp_nodeattrin proc_attr_in, *attr_in = NULL;
-	struct node_object *hnode;
+	struct node_res_object *node_res;
 
 	/* Optional argument */
 	if (psize) {
@@ -1064,13 +1078,14 @@ u32 nodewrap_allocate(union Trapped_Args *args, void *pr_ctxt)
 	if (DSP_SUCCEEDED(status)) {
 		status = node_allocate(args->args_node_allocate.hprocessor,
 				       &node_uuid, (struct dsp_cbdata *)pargs,
-				       attr_in, &hnode, pr_ctxt);
+				       attr_in, &node_res, pr_ctxt);
 	}
 	if (DSP_SUCCEEDED(status)) {
-		CP_TO_USR(args->args_node_allocate.ph_node, &hnode, status, 1);
+		CP_TO_USR(args->args_node_allocate.ph_node, &node_res->id,
+			status, 1);
 		if (DSP_FAILED(status)) {
 			status = DSP_EPOINTER;
-			node_delete(hnode, pr_ctxt);
+			node_delete(node_res, pr_ctxt);
 		}
 	}
 func_cont:
@@ -1088,6 +1103,13 @@ u32 nodewrap_alloc_msg_buf(union Trapped_Args *args, void *pr_ctxt)
 	struct dsp_bufferattr *pattr = NULL;
 	struct dsp_bufferattr attr;
 	u8 *pbuffer = NULL;
+	struct node_res_object *node_res;
+
+	find_node_handle(&node_res,  pr_ctxt,
+				args->args_node_allocmsgbuf.hnode);
+
+	if (!node_res)
+		return DSP_EHANDLE;
 
 	if (!args->args_node_allocmsgbuf.usize)
 		return DSP_ESIZE;
@@ -1101,7 +1123,7 @@ u32 nodewrap_alloc_msg_buf(union Trapped_Args *args, void *pr_ctxt)
 	/* IN OUT argument */
 	CP_FM_USR(&pbuffer, args->args_node_allocmsgbuf.pbuffer, status, 1);
 	if (DSP_SUCCEEDED(status)) {
-		status = node_alloc_msg_buf(args->args_node_allocmsgbuf.hnode,
+		status = node_alloc_msg_buf(node_res->hnode,
 					    args->args_node_allocmsgbuf.usize,
 					    pattr, &pbuffer);
 	}
@@ -1115,8 +1137,15 @@ u32 nodewrap_alloc_msg_buf(union Trapped_Args *args, void *pr_ctxt)
 u32 nodewrap_change_priority(union Trapped_Args *args, void *pr_ctxt)
 {
 	u32 ret;
+	struct node_res_object *node_res;
+
+	find_node_handle(&node_res, pr_ctxt,
+				args->args_node_changepriority.hnode);
+
+	if (!node_res)
+		return DSP_EHANDLE;
 
-	ret = node_change_priority(args->args_node_changepriority.hnode,
+	ret = node_change_priority(node_res->hnode,
 				   args->args_node_changepriority.prio);
 
 	return ret;
@@ -1133,6 +1162,29 @@ u32 nodewrap_connect(union Trapped_Args *args, void *pr_ctxt)
 	u32 cb_data_size;
 	u32 __user *psize = (u32 __user *) args->args_node_connect.conn_param;
 	u8 *pargs = NULL;
+	struct node_res_object *node_res1, *node_res2;
+	struct node_object *node1 = NULL, *node2 = NULL;
+
+	if ((int)args->args_node_connect.hnode != DSP_HGPPNODE) {
+		find_node_handle(&node_res1, pr_ctxt,
+				args->args_node_connect.hnode);
+		if (node_res1)
+			node1 = node_res1->hnode;
+	} else {
+		node1 = args->args_node_connect.hnode;
+	}
+
+	if ((int)args->args_node_connect.other_node != DSP_HGPPNODE) {
+		find_node_handle(&node_res2, pr_ctxt,
+				args->args_node_connect.other_node);
+		if (node_res2)
+			node2 = node_res2->hnode;
+	} else {
+		node2 = args->args_node_connect.other_node;
+	}
+
+	if (!node1 || !node2)
+		return DSP_EHANDLE;
 
 	/* Optional argument */
 	if (psize) {
@@ -1160,9 +1212,9 @@ u32 nodewrap_connect(union Trapped_Args *args, void *pr_ctxt)
 
 	}
 	if (DSP_SUCCEEDED(status)) {
-		status = node_connect(args->args_node_connect.hnode,
+		status = node_connect(node1,
 				      args->args_node_connect.stream_id,
-				      args->args_node_connect.other_node,
+				      node2,
 				      args->args_node_connect.other_stream,
 				      pattrs, (struct dsp_cbdata *)pargs);
 	}
@@ -1178,8 +1230,14 @@ func_cont:
 u32 nodewrap_create(union Trapped_Args *args, void *pr_ctxt)
 {
 	u32 ret;
+	struct node_res_object *node_res;
+
+	find_node_handle(&node_res, pr_ctxt, args->args_node_create.hnode);
+
+	if (!node_res)
+		return DSP_EHANDLE;
 
-	ret = node_create(args->args_node_create.hnode);
+	ret = node_create(node_res->hnode);
 
 	return ret;
 }
@@ -1190,8 +1248,14 @@ u32 nodewrap_create(union Trapped_Args *args, void *pr_ctxt)
 u32 nodewrap_delete(union Trapped_Args *args, void *pr_ctxt)
 {
 	u32 ret;
+	struct node_res_object *node_res;
+
+	find_node_handle(&node_res, pr_ctxt, args->args_node_delete.hnode);
+
+	if (!node_res)
+		return DSP_EHANDLE;
 
-	ret = node_delete(args->args_node_delete.hnode, pr_ctxt);
+	ret = node_delete(node_res, pr_ctxt);
 
 	return ret;
 }
@@ -1204,6 +1268,13 @@ u32 nodewrap_free_msg_buf(union Trapped_Args *args, void *pr_ctxt)
 	dsp_status status = DSP_SOK;
 	struct dsp_bufferattr *pattr = NULL;
 	struct dsp_bufferattr attr;
+	struct node_res_object *node_res;
+
+	find_node_handle(&node_res, pr_ctxt, args->args_node_freemsgbuf.hnode);
+
+	if (!node_res)
+		return DSP_EHANDLE;
+
 	if (args->args_node_freemsgbuf.pattr) {	/* Optional argument */
 		CP_FM_USR(&attr, args->args_node_freemsgbuf.pattr, status, 1);
 		if (DSP_SUCCEEDED(status))
@@ -1215,7 +1286,7 @@ u32 nodewrap_free_msg_buf(union Trapped_Args *args, void *pr_ctxt)
 		return DSP_EPOINTER;
 
 	if (DSP_SUCCEEDED(status)) {
-		status = node_free_msg_buf(args->args_node_freemsgbuf.hnode,
+		status = node_free_msg_buf(node_res->hnode,
 					   args->args_node_freemsgbuf.pbuffer,
 					   pattr);
 	}
@@ -1230,8 +1301,14 @@ u32 nodewrap_get_attr(union Trapped_Args *args, void *pr_ctxt)
 {
 	dsp_status status = DSP_SOK;
 	struct dsp_nodeattr attr;
+	struct node_res_object *node_res;
+
+	find_node_handle(&node_res, pr_ctxt, args->args_node_getattr.hnode);
+
+	if (!node_res)
+		return DSP_EHANDLE;
 
-	status = node_get_attr(args->args_node_getattr.hnode, &attr,
+	status = node_get_attr(node_res->hnode, &attr,
 			       args->args_node_getattr.attr_size);
 	CP_TO_USR(args->args_node_getattr.pattr, &attr, status, 1);
 
@@ -1245,8 +1322,14 @@ u32 nodewrap_get_message(union Trapped_Args *args, void *pr_ctxt)
 {
 	dsp_status status;
 	struct dsp_msg msg;
+	struct node_res_object *node_res;
 
-	status = node_get_message(args->args_node_getmessage.hnode, &msg,
+	find_node_handle(&node_res, pr_ctxt, args->args_node_getmessage.hnode);
+
+	if (!node_res)
+		return DSP_EHANDLE;
+
+	status = node_get_message(node_res->hnode, &msg,
 				  args->args_node_getmessage.utimeout);
 
 	CP_TO_USR(args->args_node_getmessage.message, &msg, status, 1);
@@ -1260,8 +1343,14 @@ u32 nodewrap_get_message(union Trapped_Args *args, void *pr_ctxt)
 u32 nodewrap_pause(union Trapped_Args *args, void *pr_ctxt)
 {
 	u32 ret;
+	struct node_res_object *node_res;
+
+	find_node_handle(&node_res, pr_ctxt, args->args_node_pause.hnode);
 
-	ret = node_pause(args->args_node_pause.hnode);
+	if (!node_res)
+		return DSP_EHANDLE;
+
+	ret = node_pause(node_res->hnode);
 
 	return ret;
 }
@@ -1273,12 +1362,18 @@ u32 nodewrap_put_message(union Trapped_Args *args, void *pr_ctxt)
 {
 	dsp_status status = DSP_SOK;
 	struct dsp_msg msg;
+	struct node_res_object *node_res;
+
+	find_node_handle(&node_res, pr_ctxt, args->args_node_putmessage.hnode);
+
+	if (!node_res)
+		return DSP_EHANDLE;
 
 	CP_FM_USR(&msg, args->args_node_putmessage.message, status, 1);
 
 	if (DSP_SUCCEEDED(status)) {
 		status =
-		    node_put_message(args->args_node_putmessage.hnode, &msg,
+		    node_put_message(node_res->hnode, &msg,
 				     args->args_node_putmessage.utimeout);
 	}
 
@@ -1292,6 +1387,13 @@ u32 nodewrap_register_notify(union Trapped_Args *args, void *pr_ctxt)
 {
 	dsp_status status = DSP_SOK;
 	struct dsp_notification notification;
+	struct node_res_object *node_res;
+
+	find_node_handle(&node_res, pr_ctxt,
+			args->args_node_registernotify.hnode);
+
+	if (!node_res)
+		return DSP_EHANDLE;
 
 	/* Initialize the notification data structure */
 	notification.ps_name = NULL;
@@ -1302,7 +1404,7 @@ u32 nodewrap_register_notify(union Trapped_Args *args, void *pr_ctxt)
 			  args->args_proc_register_notify.hnotification,
 			  status, 1);
 
-	status = node_register_notify(args->args_node_registernotify.hnode,
+	status = node_register_notify(node_res->hnode,
 				      args->args_node_registernotify.event_mask,
 				      args->args_node_registernotify.
 				      notify_type, &notification);
@@ -1317,8 +1419,14 @@ u32 nodewrap_register_notify(union Trapped_Args *args, void *pr_ctxt)
 u32 nodewrap_run(union Trapped_Args *args, void *pr_ctxt)
 {
 	u32 ret;
+	struct node_res_object *node_res;
+
+	find_node_handle(&node_res, pr_ctxt, args->args_node_run.hnode);
+
+	if (!node_res)
+		return DSP_EHANDLE;
 
-	ret = node_run(args->args_node_run.hnode);
+	ret = node_run(node_res->hnode);
 
 	return ret;
 }
@@ -1330,8 +1438,14 @@ u32 nodewrap_terminate(union Trapped_Args *args, void *pr_ctxt)
 {
 	dsp_status status;
 	dsp_status tempstatus;
+	struct node_res_object *node_res;
 
-	status = node_terminate(args->args_node_terminate.hnode, &tempstatus);
+	find_node_handle(&node_res, pr_ctxt, args->args_node_terminate.hnode);
+
+	if (!node_res)
+		return DSP_EHANDLE;
+
+	status = node_terminate(node_res->hnode, &tempstatus);
 
 	CP_TO_USR(args->args_node_terminate.pstatus, &tempstatus, status, 1);
 
@@ -1513,6 +1627,12 @@ u32 strmwrap_open(union Trapped_Args *args, void *pr_ctxt)
 	struct strm_attr attr;
 	struct strm_object *strm_obj;
 	struct dsp_streamattrin strm_attr_in;
+	struct node_res_object *node_res;
+
+	find_node_handle(&node_res, pr_ctxt, args->args_strm_open.hnode);
+
+	if (!node_res)
+		return DSP_EHANDLE;
 
 	CP_FM_USR(&attr, args->args_strm_open.attr_in, status, 1);
 
@@ -1525,7 +1645,7 @@ u32 strmwrap_open(union Trapped_Args *args, void *pr_ctxt)
 		}
 
 	}
-	status = strm_open(args->args_strm_open.hnode,
+	status = strm_open(node_res->hnode,
 			   args->args_strm_open.direction,
 			   args->args_strm_open.index, &attr, &strm_obj,
 			   pr_ctxt);
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 75b9b9f..b41c753 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -71,7 +71,7 @@ static dsp_status request_bridge_resources_dsp(u32 dw_context, s32 fRequest);
 
 /* GPP PROCESS CLEANUP CODE */
 
-static dsp_status drv_proc_free_node_res(bhandle hPCtxt);
+static int drv_proc_free_node_res(int id, void *p, void *data);
 extern enum node_state node_get_state(bhandle hnode);
 
 /* Allocate and add a node resource element
@@ -83,89 +83,62 @@ dsp_status drv_insert_node_res_element(bhandle hnode, bhandle hNodeRes,
 	    (struct node_res_object **)hNodeRes;
 	struct process_context *ctxt = (struct process_context *)hPCtxt;
 	dsp_status status = DSP_SOK;
-	struct node_res_object *temp_node_res = NULL;
+	int retval;
 
 	*node_res_obj = (struct node_res_object *)mem_calloc
 	    (1 * sizeof(struct node_res_object), MEM_PAGED);
-	if (*node_res_obj == NULL)
-		status = DSP_EHANDLE;
+	if (!*node_res_obj) {
+		status = DSP_EMEMORY;
+		goto func_end;
+	}
 
-	if (DSP_SUCCEEDED(status)) {
-		if (mutex_lock_interruptible(&ctxt->node_mutex)) {
-			kfree(*node_res_obj);
-			return DSP_EFAIL;
+	(*node_res_obj)->hnode = hnode;
+	retval = idr_get_new(ctxt->node_idp, *node_res_obj,
+						&(*node_res_obj)->id);
+	if (retval == -EAGAIN) {
+		if (!idr_pre_get(ctxt->node_idp, GFP_KERNEL)) {
+			pr_err("%s: OUT OF MEMORY\n", __func__);
+			status = DSP_EMEMORY;
+			goto func_end;
 		}
-		(*node_res_obj)->hnode = hnode;
-		if (ctxt->node_list != NULL) {
-			temp_node_res = ctxt->node_list;
-			while (temp_node_res->next != NULL)
-				temp_node_res = temp_node_res->next;
 
-			temp_node_res->next = *node_res_obj;
-		} else {
-			ctxt->node_list = *node_res_obj;
-		}
-		mutex_unlock(&ctxt->node_mutex);
+		retval = idr_get_new(ctxt->node_idp, *node_res_obj,
+						&(*node_res_obj)->id);
+	}
+	if (retval) {
+		pr_err("%s: FAILED, IDR is FULL\n", __func__);
+		status = DSP_EFAIL;
 	}
+func_end:
+	if (DSP_FAILED(status))
+		kfree(*node_res_obj);
 
 	return status;
 }
 
 /* Release all Node resources and its context
-* This is called from .Node_Delete. */
-dsp_status drv_remove_node_res_element(bhandle hNodeRes, bhandle hPCtxt)
-{
-	struct node_res_object *node_res_obj =
-	    (struct node_res_object *)hNodeRes;
-	struct process_context *ctxt = (struct process_context *)hPCtxt;
-	struct node_res_object *temp_node;
-	dsp_status status = DSP_SOK;
-
-	if (mutex_lock_interruptible(&ctxt->node_mutex))
-		return DSP_EFAIL;
-	temp_node = ctxt->node_list;
-	if (temp_node == node_res_obj) {
-		ctxt->node_list = node_res_obj->next;
-	} else {
-		while (temp_node && temp_node->next != node_res_obj)
-			temp_node = temp_node->next;
-		if (!temp_node)
-			status = DSP_ENOTFOUND;
-		else
-			temp_node->next = node_res_obj->next;
-	}
-	mutex_unlock(&ctxt->node_mutex);
-	kfree(node_res_obj);
-	return status;
-}
-
-/* Actual Node De-Allocation */
-static dsp_status drv_proc_free_node_res(bhandle hPCtxt)
+ * Actual Node De-Allocation */
+static int drv_proc_free_node_res(int id, void *p, void *data)
 {
-	struct process_context *ctxt = (struct process_context *)hPCtxt;
-	dsp_status status = DSP_SOK;
-	struct node_res_object *node_list = NULL;
-	struct node_res_object *node_res_obj = NULL;
+	struct process_context *ctxt = data;
+	dsp_status status;
+	struct node_res_object *node_res_obj = p;
 	u32 node_state;
 
-	node_list = ctxt->node_list;
-	while (node_list != NULL) {
-		node_res_obj = node_list;
-		node_list = node_list->next;
-		if (node_res_obj->node_allocated) {
-			node_state = node_get_state(node_res_obj->hnode);
-			if (node_state <= NODE_DELETING) {
-				if ((node_state == NODE_RUNNING) ||
-				    (node_state == NODE_PAUSED) ||
-				    (node_state == NODE_TERMINATING))
-					status = node_terminate
-					    (node_res_obj->hnode, &status);
-
-				status = node_delete(node_res_obj->hnode, ctxt);
-			}
+	if (node_res_obj->node_allocated) {
+		node_state = node_get_state(node_res_obj->hnode);
+		if (node_state <= NODE_DELETING) {
+			if ((node_state == NODE_RUNNING) ||
+			    (node_state == NODE_PAUSED) ||
+			    (node_state == NODE_TERMINATING))
+				node_terminate
+				    (node_res_obj->hnode, &status);
+
+			node_delete(node_res_obj, ctxt);
 		}
 	}
-	return status;
+
+	return 0;
 }
 
 /* Release all Mapped and Reserved DMM resources */
@@ -220,49 +193,12 @@ void drv_proc_node_update_heap_status(bhandle hNodeRes, s32 status)
  */
 dsp_status drv_remove_all_node_res_elements(bhandle hPCtxt)
 {
-	struct process_context *ctxt = (struct process_context *)hPCtxt;
-	dsp_status status = DSP_SOK;
-	struct node_res_object *temp_node2 = NULL;
-	struct node_res_object *temp_node = NULL;
-
-	drv_proc_free_node_res(ctxt);
-	temp_node = ctxt->node_list;
-	while (temp_node != NULL) {
-		temp_node2 = temp_node;
-		temp_node = temp_node->next;
-		kfree(temp_node2);
-	}
-	ctxt->node_list = NULL;
-	return status;
-}
-
-/* Getting the node resource element */
-dsp_status drv_get_node_res_element(bhandle hnode, bhandle hNodeRes,
-				    bhandle hPCtxt)
-{
-	struct node_res_object **node_res = (struct node_res_object **)hNodeRes;
-	struct process_context *ctxt = (struct process_context *)hPCtxt;
-	dsp_status status = DSP_SOK;
-	struct node_res_object *temp_node2 = NULL;
-	struct node_res_object *temp_node = NULL;
-
-	if (mutex_lock_interruptible(&ctxt->node_mutex))
-		return DSP_EFAIL;
+	struct process_context *ctxt = hPCtxt;
 
-	temp_node = ctxt->node_list;
-	while ((temp_node != NULL) && (temp_node->hnode != hnode)) {
-		temp_node2 = temp_node;
-		temp_node = temp_node->next;
-	}
-
-	mutex_unlock(&ctxt->node_mutex);
-
-	if (temp_node != NULL)
-		*node_res = temp_node;
-	else
-		status = DSP_ENOTFOUND;
+	idr_for_each(ctxt->node_idp, drv_proc_free_node_res, ctxt);
+	idr_destroy(ctxt->node_idp);
 
-	return status;
+	return DSP_SOK;
 }
 
 /* Allocate the STRM resource element
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index bd693cd..be5efb7 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -506,8 +506,13 @@ static int bridge_open(struct inode *ip, struct file *filp)
 		INIT_LIST_HEAD(&pr_ctxt->dmm_map_list);
 		spin_lock_init(&pr_ctxt->dmm_rsv_lock);
 		INIT_LIST_HEAD(&pr_ctxt->dmm_rsv_list);
-		mutex_init(&pr_ctxt->node_mutex);
 		mutex_init(&pr_ctxt->strm_mutex);
+
+		pr_ctxt->node_idp = mem_calloc(sizeof(struct idr), MEM_PAGED);
+		if (pr_ctxt->node_idp)
+			idr_init(pr_ctxt->node_idp);
+		else
+			status = -ENOMEM;
 	} else {
 		status = -ENOMEM;
 	}
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 32df890..236c8f6 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -299,7 +299,7 @@ dsp_status node_allocate(struct proc_object *hprocessor,
 			 IN CONST struct dsp_uuid *pNodeId,
 			 OPTIONAL IN CONST struct dsp_cbdata *pargs,
 			 OPTIONAL IN CONST struct dsp_nodeattrin *attr_in,
-			 OUT struct node_object **ph_node,
+			 OUT struct node_res_object **noderes,
 			 struct process_context *pr_ctxt)
 {
 	struct node_mgr *hnode_mgr;
@@ -331,10 +331,10 @@ dsp_status node_allocate(struct proc_object *hprocessor,
 
 	DBC_REQUIRE(refs > 0);
 	DBC_REQUIRE(hprocessor != NULL);
-	DBC_REQUIRE(ph_node != NULL);
+	DBC_REQUIRE(noderes != NULL);
 	DBC_REQUIRE(pNodeId != NULL);
 
-	*ph_node = NULL;
+	*noderes = NULL;
 
 	status = proc_get_processor_id(hprocessor, &proc_id);
 
@@ -653,9 +653,6 @@ func_cont:
 		 * (for overlay and dll) */
 		pnode->phase_split = true;
 
-		if (DSP_SUCCEEDED(status))
-			*ph_node = pnode;
-
 		/* Notify all clients registered for DSP_NODESTATECHANGE. */
 		proc_notify_all_clients(hprocessor, DSP_NODESTATECHANGE);
 	} else {
@@ -666,17 +663,23 @@ func_cont:
 	}
 
 	if (DSP_SUCCEEDED(status)) {
-		drv_insert_node_res_element(*ph_node, &node_res, pr_ctxt);
+		status = drv_insert_node_res_element(pnode, &node_res, pr_ctxt);
+		if (DSP_FAILED(status)) {
+			delete_node(pnode, pr_ctxt);
+			goto func_end;
+		}
+
+		*noderes = (struct node_res_object *)node_res;
 		drv_proc_node_update_heap_status(node_res, true);
 		drv_proc_node_update_status(node_res, true);
 	}
-	DBC_ENSURE((DSP_FAILED(status) && (*ph_node == NULL)) ||
+	DBC_ENSURE((DSP_FAILED(status) && (*noderes == NULL)) ||
 		   (DSP_SUCCEEDED(status)
-		    && MEM_IS_VALID_HANDLE((*ph_node), NODE_SIGNATURE)));
+		    && MEM_IS_VALID_HANDLE(pnode, NODE_SIGNATURE)));
 func_end:
 	dev_dbg(bridge, "%s: hprocessor: %p pNodeId: %p pargs: %p attr_in: %p "
-		"ph_node: %p status: 0x%x\n", __func__, hprocessor,
-		pNodeId, pargs, attr_in, ph_node, status);
+		"node_res: %p status: 0x%x\n", __func__, hprocessor,
+		pNodeId, pargs, attr_in, noderes, status);
 	return status;
 }
 
@@ -1439,10 +1442,10 @@ dsp_status node_create_mgr(OUT struct node_mgr **phNodeMgr,
  *      Loads the node's delete function if necessary. Free GPP side resources
  *      after node's delete function returns.
  */
-dsp_status node_delete(struct node_object *hnode,
+dsp_status node_delete(struct node_res_object *hnoderes,
 		       struct process_context *pr_ctxt)
 {
-	struct node_object *pnode = (struct node_object *)hnode;
+	struct node_object *pnode = hnoderes->hnode;
 	struct node_mgr *hnode_mgr;
 	struct proc_object *hprocessor;
 	struct disp_object *disp_obj;
@@ -1455,32 +1458,32 @@ dsp_status node_delete(struct node_object *hnode,
 	u32 proc_id;
 	struct bridge_drv_interface *intf_fxns;
 
-	bhandle node_res;
+	bhandle node_res = hnoderes;
 
 	struct dsp_processorstate proc_state;
 	DBC_REQUIRE(refs > 0);
 
-	if (!MEM_IS_VALID_HANDLE(hnode, NODE_SIGNATURE)) {
+	if (!MEM_IS_VALID_HANDLE(pnode, NODE_SIGNATURE)) {
 		status = DSP_EHANDLE;
 		goto func_end;
 	}
 	/* create struct dsp_cbdata struct for PWR call */
 	cb_data.cb_data = PWR_TIMEOUT;
-	hnode_mgr = hnode->hnode_mgr;
-	hprocessor = hnode->hprocessor;
+	hnode_mgr = pnode->hnode_mgr;
+	hprocessor = pnode->hprocessor;
 	disp_obj = hnode_mgr->disp_obj;
-	node_type = node_get_type(hnode);
+	node_type = node_get_type(pnode);
 	intf_fxns = hnode_mgr->intf_fxns;
 	/* Enter critical section */
 	mutex_lock(&hnode_mgr->node_mgr_lock);
 
-	state = node_get_state(hnode);
+	state = node_get_state(pnode);
 	/*  Execute delete phase code for non-device node in all cases
 	 *  except when the node was only allocated. Delete phase must be
 	 *  executed even if create phase was executed, but failed.
 	 *  If the node environment pointer is non-NULL, the delete phase
 	 *  code must be  executed. */
-	if (!(state == NODE_ALLOCATED && hnode->node_env == (u32) NULL) &&
+	if (!(state == NODE_ALLOCATED && pnode->node_env == (u32) NULL) &&
 	    node_type != NODE_DEVICE) {
 		status = proc_get_processor_id(pnode->hprocessor, &proc_id);
 		if (DSP_FAILED(status))
@@ -1493,26 +1496,26 @@ dsp_status node_delete(struct node_object *hnode,
 			 *  is now ok to unload it. If the node is running, we
 			 *  will unload the execute phase only after deleting
 			 *  the node. */
-			if (state == NODE_PAUSED && hnode->loaded &&
-			    hnode->phase_split) {
+			if (state == NODE_PAUSED && pnode->loaded &&
+			    pnode->phase_split) {
 				/* Ok to unload execute code as long as node
 				 * is not * running */
 				status1 =
 				    hnode_mgr->nldr_fxns.
-				    pfn_unload(hnode->nldr_node_obj,
+				    pfn_unload(pnode->nldr_node_obj,
 					       NLDR_EXECUTE);
-				hnode->loaded = false;
-				NODE_SET_STATE(hnode, NODE_DONE);
+				pnode->loaded = false;
+				NODE_SET_STATE(pnode, NODE_DONE);
 			}
 			/* Load delete phase code if not loaded or if haven't
 			 * * unloaded EXECUTE phase */
-			if ((!(hnode->loaded) || (state == NODE_RUNNING)) &&
-			    hnode->phase_split) {
+			if ((!(pnode->loaded) || (state == NODE_RUNNING)) &&
+			    pnode->phase_split) {
 				status =
 				    hnode_mgr->nldr_fxns.
-				    pfn_load(hnode->nldr_node_obj, NLDR_DELETE);
+				    pfn_load(pnode->nldr_node_obj, NLDR_DELETE);
 				if (DSP_SUCCEEDED(status))
-					hnode->loaded = true;
+					pnode->loaded = true;
 				else
 					pr_err("%s: fail - load delete code:"
 					       " 0x%x\n", __func__, status);
@@ -1521,14 +1524,14 @@ dsp_status node_delete(struct node_object *hnode,
 func_cont1:
 		if (DSP_SUCCEEDED(status)) {
 			/* Unblock a thread trying to terminate the node */
-			(void)sync_set_event(hnode->sync_done);
+			(void)sync_set_event(pnode->sync_done);
 			if (proc_id == DSP_UNIT) {
 				/* ul_delete_fxn = address of node's delete
 				 * function */
-				status = get_fxn_address(hnode, &ul_delete_fxn,
+				status = get_fxn_address(pnode, &ul_delete_fxn,
 							 DELETEPHASE);
 			} else if (proc_id == IVA_UNIT)
-				ul_delete_fxn = (u32) hnode->node_env;
+				ul_delete_fxn = (u32) pnode->node_env;
 			if (DSP_SUCCEEDED(status)) {
 				status = proc_get_state(hprocessor,
 						&proc_state,
@@ -1536,22 +1539,22 @@ func_cont1:
 						       dsp_processorstate));
 				if (proc_state.proc_state != PROC_ERROR) {
 					status =
-					    disp_node_delete(disp_obj, hnode,
+					    disp_node_delete(disp_obj, pnode,
 							     hnode_mgr->
 							     ul_fxn_addrs
 							     [RMSDELETENODE],
 							     ul_delete_fxn,
-							     hnode->node_env);
+							     pnode->node_env);
 				} else
-					NODE_SET_STATE(hnode, NODE_DONE);
+					NODE_SET_STATE(pnode, NODE_DONE);
 
 				/* Unload execute, if not unloaded, and delete
 				 * function */
 				if (state == NODE_RUNNING &&
-				    hnode->phase_split) {
+				    pnode->phase_split) {
 					status1 =
 					    hnode_mgr->nldr_fxns.
-					    pfn_unload(hnode->nldr_node_obj,
+					    pfn_unload(pnode->nldr_node_obj,
 						       NLDR_EXECUTE);
 				}
 				if (DSP_FAILED(status1))
@@ -1559,10 +1562,10 @@ func_cont1:
 					       " 0x%x\n", __func__, status1);
 
 				status1 =
-				    hnode_mgr->nldr_fxns.pfn_unload(hnode->
+				    hnode_mgr->nldr_fxns.pfn_unload(pnode->
 							    nldr_node_obj,
 							    NLDR_DELETE);
-				hnode->loaded = false;
+				pnode->loaded = false;
 				if (DSP_FAILED(status1))
 					pr_err("%s: fail - unload delete code: "
 					       "0x%x\n", __func__, status1);
@@ -1571,25 +1574,28 @@ func_cont1:
 	}
 	/* Free host side resources even if a failure occurred */
 	/* Remove node from hnode_mgr->node_list */
-	lst_remove_elem(hnode_mgr->node_list, (struct list_head *)hnode);
+	lst_remove_elem(hnode_mgr->node_list, (struct list_head *)pnode);
 	hnode_mgr->num_nodes--;
 	/* Decrement count of nodes created on DSP */
 	if ((state != NODE_ALLOCATED) || ((state == NODE_ALLOCATED) &&
-					  (hnode->node_env != (u32) NULL)))
+					  (pnode->node_env != (u32) NULL)))
 		hnode_mgr->num_created--;
 	/*  Free host-side resources allocated by node_create()
 	 *  delete_node() fails if SM buffers not freed by client! */
-	if (drv_get_node_res_element(hnode, &node_res, pr_ctxt) !=
-	    DSP_ENOTFOUND)
-		drv_proc_node_update_status(node_res, false);
-	delete_node(hnode, pr_ctxt);
+	drv_proc_node_update_status(node_res, false);
+	delete_node(pnode, pr_ctxt);
+
+	/*
+	 * Release all Node resources and its context
+	 */
+	idr_remove(pr_ctxt->node_idp, ((struct node_res_object *)node_res)->id);
+	kfree(node_res);
 
-	drv_remove_node_res_element(node_res, pr_ctxt);
 	/* Exit critical section */
 	mutex_unlock(&hnode_mgr->node_mgr_lock);
 	proc_notify_clients(hprocessor, DSP_NODESTATECHANGE);
 func_end:
-	dev_dbg(bridge, "%s: hnode: %p status 0x%x\n", __func__, hnode, status);
+	dev_dbg(bridge, "%s: pnode: %p status 0x%x\n", __func__, pnode, status);
 	return status;
 }
 
-- 
1.5.4.5

