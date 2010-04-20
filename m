From: Ernesto Ramos <ernesto@ti.com>
Subject: [PATCH 3/5v3] DSPBRIDGE: Use processor handle from context instead of user's.
Date: Tue, 20 Apr 2010 18:02:58 -0500
Message-ID: <1271804580-17072-3-git-send-email-ernesto@ti.com>
References: <1271804580-17072-1-git-send-email-ernesto@ti.com>
 <1271804580-17072-2-git-send-email-ernesto@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35612 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752004Ab0DTXCF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Apr 2010 19:02:05 -0400
In-Reply-To: <1271804580-17072-2-git-send-email-ernesto@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.contreras@nokia.com, ameya.palande@nokia.com, hiroshi.doyu@nokia.com, Ernesto Ramos <ernesto@ti.com>

Make sure dspbridge driver uses a valid processor handle by
using the handle stored in process context.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 drivers/dsp/bridge/pmgr/wcd.c |   56 ++++++++++++++++++++++++-----------------
 1 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 692bfd9..e6e193d 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -613,6 +613,7 @@ u32 procwrap_ctrl(union Trapped_Args *args, void *pr_ctxt)
 	    args->args_proc_ctrl.pargs;
 	u8 *pargs = NULL;
 	dsp_status status = DSP_SOK;
+	void *hprocessor = ((struct process_context *)pr_ctxt)->hprocessor;
 
 	if (psize) {
 		if (get_user(cb_data_size, psize)) {
@@ -630,7 +631,7 @@ u32 procwrap_ctrl(union Trapped_Args *args, void *pr_ctxt)
 			  cb_data_size);
 	}
 	if (DSP_SUCCEEDED(status)) {
-		status = proc_ctrl(args->args_proc_ctrl.hprocessor,
+		status = proc_ctrl(hprocessor,
 				   args->args_proc_ctrl.dw_cmd,
 				   (struct dsp_cbdata *)pargs);
 	}
@@ -660,11 +661,12 @@ u32 procwrap_enum_node_info(union Trapped_Args *args, void *pr_ctxt)
 	void *node_tab[MAX_NODES];
 	u32 num_nodes;
 	u32 alloc_cnt;
+	void *hprocessor = ((struct process_context *)pr_ctxt)->hprocessor;
 
 	if (!args->args_proc_enumnode_info.node_tab_size)
 		return DSP_ESIZE;
 
-	status = proc_enum_nodes(args->args_proc_enumnode_info.hprocessor,
+	status = proc_enum_nodes(hprocessor,
 				 node_tab,
 				 args->args_proc_enumnode_info.node_tab_size,
 				 &num_nodes, &alloc_cnt);
@@ -683,12 +685,13 @@ u32 procwrap_enum_node_info(union Trapped_Args *args, void *pr_ctxt)
 u32 procwrap_flush_memory(union Trapped_Args *args, void *pr_ctxt)
 {
 	dsp_status status;
+	void *hprocessor = ((struct process_context *)pr_ctxt)->hprocessor;
 
 	if (args->args_proc_flushmemory.ul_flags >
 	    PROC_WRITEBACK_INVALIDATE_MEM)
 		return DSP_EINVALIDARG;
 
-	status = proc_flush_memory(args->args_proc_flushmemory.hprocessor,
+	status = proc_flush_memory(hprocessor,
 				   args->args_proc_flushmemory.pmpu_addr,
 				   args->args_proc_flushmemory.ul_size,
 				   args->args_proc_flushmemory.ul_flags);
@@ -701,9 +704,10 @@ u32 procwrap_flush_memory(union Trapped_Args *args, void *pr_ctxt)
 u32 procwrap_invalidate_memory(union Trapped_Args *args, void *pr_ctxt)
 {
 	dsp_status status;
+	void *hprocessor = ((struct process_context *)pr_ctxt)->hprocessor;
 
 	status =
-	    proc_invalidate_memory(args->args_proc_invalidatememory.hprocessor,
+	    proc_invalidate_memory(hprocessor,
 				   args->args_proc_invalidatememory.pmpu_addr,
 				   args->args_proc_invalidatememory.ul_size);
 	return status;
@@ -716,13 +720,14 @@ u32 procwrap_enum_resources(union Trapped_Args *args, void *pr_ctxt)
 {
 	dsp_status status = DSP_SOK;
 	struct dsp_resourceinfo resource_info;
+	void *hprocessor = ((struct process_context *)pr_ctxt)->hprocessor;
 
 	if (args->args_proc_enumresources.resource_info_size <
 	    sizeof(struct dsp_resourceinfo))
 		return DSP_ESIZE;
 
 	status =
-	    proc_get_resource_info(args->args_proc_enumresources.hprocessor,
+	    proc_get_resource_info(hprocessor,
 				   args->args_proc_enumresources.resource_type,
 				   &resource_info,
 				   args->args_proc_enumresources.
@@ -742,13 +747,13 @@ u32 procwrap_get_state(union Trapped_Args *args, void *pr_ctxt)
 {
 	dsp_status status;
 	struct dsp_processorstate proc_state;
+	void *hprocessor = ((struct process_context *)pr_ctxt)->hprocessor;
 
 	if (args->args_proc_getstate.state_info_size <
 	    sizeof(struct dsp_processorstate))
 		return DSP_ESIZE;
 
-	status =
-	    proc_get_state(args->args_proc_getstate.hprocessor, &proc_state,
+	status = proc_get_state(hprocessor, &proc_state,
 			   args->args_proc_getstate.state_info_size);
 	CP_TO_USR(args->args_proc_getstate.proc_state_obj, &proc_state, status,
 		  1);
@@ -763,14 +768,14 @@ u32 procwrap_get_trace(union Trapped_Args *args, void *pr_ctxt)
 {
 	dsp_status status;
 	u8 *pbuf;
+	void *hprocessor = ((struct process_context *)pr_ctxt)->hprocessor;
 
 	if (args->args_proc_gettrace.max_size > MAX_TRACEBUFLEN)
 		return DSP_ESIZE;
 
 	pbuf = mem_calloc(args->args_proc_gettrace.max_size, MEM_NONPAGED);
 	if (pbuf != NULL) {
-		status = proc_get_trace(args->args_proc_gettrace.hprocessor,
-					pbuf,
+		status = proc_get_trace(hprocessor, pbuf,
 					args->args_proc_gettrace.max_size);
 	} else {
 		status = DSP_EMEMORY;
@@ -792,6 +797,7 @@ u32 procwrap_load(union Trapped_Args *args, void *pr_ctxt)
 	char *temp;
 	s32 count = args->args_proc_load.argc_index;
 	u8 **argv = NULL, **envp = NULL;
+	void *hprocessor = ((struct process_context *)pr_ctxt)->hprocessor;
 
 	if (count <= 0 || count > MAX_LOADARGS) {
 		status = DSP_EINVALIDARG;
@@ -874,7 +880,7 @@ u32 procwrap_load(union Trapped_Args *args, void *pr_ctxt)
 	}
 
 	if (DSP_SUCCEEDED(status)) {
-		status = proc_load(args->args_proc_load.hprocessor,
+		status = proc_load(hprocessor,
 				   args->args_proc_load.argc_index,
 				   (CONST char **)argv, (CONST char **)envp);
 	}
@@ -905,6 +911,7 @@ u32 procwrap_map(union Trapped_Args *args, void *pr_ctxt)
 {
 	dsp_status status;
 	void *map_addr;
+	void *hprocessor = ((struct process_context *)pr_ctxt)->hprocessor;
 
 	if (!args->args_proc_mapmem.ul_size)
 		return DSP_ESIZE;
@@ -917,8 +924,7 @@ u32 procwrap_map(union Trapped_Args *args, void *pr_ctxt)
 	if (DSP_SUCCEEDED(status)) {
 		if (put_user(map_addr, args->args_proc_mapmem.pp_map_addr)) {
 			status = DSP_EINVALIDARG;
-			proc_un_map(args->args_proc_mapmem.hprocessor,
-				    map_addr, pr_ctxt);
+			proc_un_map(hprocessor, map_addr, pr_ctxt);
 		}
 
 	}
@@ -932,13 +938,13 @@ u32 procwrap_register_notify(union Trapped_Args *args, void *pr_ctxt)
 {
 	dsp_status status;
 	struct dsp_notification notification;
+	void *hprocessor = ((struct process_context *)pr_ctxt)->hprocessor;
 
 	/* Initialize the notification data structure */
 	notification.ps_name = NULL;
 	notification.handle = NULL;
 
-	status =
-	    proc_register_notify(args->args_proc_register_notify.hprocessor,
+	status = proc_register_notify(hprocessor,
 				 args->args_proc_register_notify.event_mask,
 				 args->args_proc_register_notify.notify_type,
 				 &notification);
@@ -954,12 +960,13 @@ u32 procwrap_reserve_memory(union Trapped_Args *args, void *pr_ctxt)
 {
 	dsp_status status;
 	void *prsv_addr;
+	void *hprocessor = ((struct process_context *)pr_ctxt)->hprocessor;
 
 	if ((args->args_proc_rsvmem.ul_size <= 0) ||
 	    (args->args_proc_rsvmem.ul_size & (PG_SIZE4K - 1)) != 0)
 		return DSP_ESIZE;
 
-	status = proc_reserve_memory(args->args_proc_rsvmem.hprocessor,
+	status = proc_reserve_memory(hprocessor,
 				     args->args_proc_rsvmem.ul_size, &prsv_addr,
 				     pr_ctxt);
 	if (DSP_SUCCEEDED(status)) {
@@ -979,7 +986,7 @@ u32 procwrap_start(union Trapped_Args *args, void *pr_ctxt)
 {
 	u32 ret;
 
-	ret = proc_start(args->args_proc_start.hprocessor);
+	ret = proc_start(((struct process_context *)pr_ctxt)->hprocessor);
 	return ret;
 }
 
@@ -990,7 +997,7 @@ u32 procwrap_un_map(union Trapped_Args *args, void *pr_ctxt)
 {
 	dsp_status status;
 
-	status = proc_un_map(args->args_proc_unmapmem.hprocessor,
+	status = proc_un_map(((struct process_context *)pr_ctxt)->hprocessor,
 			     args->args_proc_unmapmem.map_addr, pr_ctxt);
 	return status;
 }
@@ -1001,8 +1008,9 @@ u32 procwrap_un_map(union Trapped_Args *args, void *pr_ctxt)
 u32 procwrap_un_reserve_memory(union Trapped_Args *args, void *pr_ctxt)
 {
 	dsp_status status;
+	void *hprocessor = ((struct process_context *)pr_ctxt)->hprocessor;
 
-	status = proc_un_reserve_memory(args->args_proc_unrsvmem.hprocessor,
+	status = proc_un_reserve_memory(hprocessor,
 					args->args_proc_unrsvmem.prsv_addr,
 					pr_ctxt);
 	return status;
@@ -1015,7 +1023,7 @@ u32 procwrap_stop(union Trapped_Args *args, void *pr_ctxt)
 {
 	u32 ret;
 
-	ret = proc_stop(args->args_proc_stop.hprocessor);
+	ret = proc_stop(((struct process_context *)pr_ctxt)->hprocessor);
 
 	return ret;
 }
@@ -1047,6 +1055,7 @@ u32 nodewrap_allocate(union Trapped_Args *args, void *pr_ctxt)
 	struct dsp_nodeattrin proc_attr_in, *attr_in = NULL;
 	struct node_res_object *node_res;
 	int nodeid;
+	void *hprocessor = ((struct process_context *)pr_ctxt)->hprocessor;
 
 	/* Optional argument */
 	if (psize) {
@@ -1077,7 +1086,7 @@ u32 nodewrap_allocate(union Trapped_Args *args, void *pr_ctxt)
 
 	}
 	if (DSP_SUCCEEDED(status)) {
-		status = node_allocate(args->args_node_allocate.hprocessor,
+		status = node_allocate(hprocessor,
 				       &node_uuid, (struct dsp_cbdata *)pargs,
 				       attr_in, &node_res, pr_ctxt);
 	}
@@ -1462,6 +1471,7 @@ u32 nodewrap_get_uuid_props(union Trapped_Args *args, void *pr_ctxt)
 	dsp_status status = DSP_SOK;
 	struct dsp_uuid node_uuid;
 	struct dsp_ndbprops *pnode_props = NULL;
+	void *hprocessor = ((struct process_context *)pr_ctxt)->hprocessor;
 
 	CP_FM_USR(&node_uuid, args->args_node_getuuidprops.node_id_ptr, status,
 		  1);
@@ -1470,8 +1480,7 @@ u32 nodewrap_get_uuid_props(union Trapped_Args *args, void *pr_ctxt)
 	pnode_props = mem_alloc(sizeof(struct dsp_ndbprops), MEM_NONPAGED);
 	if (pnode_props != NULL) {
 		status =
-		    node_get_uuid_props(args->args_node_getuuidprops.hprocessor,
-					&node_uuid, pnode_props);
+		    node_get_uuid_props(hprocessor, &node_uuid, pnode_props);
 		CP_TO_USR(args->args_node_getuuidprops.node_props, pnode_props,
 			  status, 1);
 	} else
@@ -1753,8 +1762,9 @@ u32 cmmwrap_get_handle(union Trapped_Args *args, void *pr_ctxt)
 {
 	dsp_status status = DSP_SOK;
 	struct cmm_object *hcmm_mgr;
+	void *hprocessor = ((struct process_context *)pr_ctxt)->hprocessor;
 
-	status = cmm_get_handle(args->args_cmm_gethandle.hprocessor, &hcmm_mgr);
+	status = cmm_get_handle(hprocessor, &hcmm_mgr);
 
 	CP_TO_USR(args->args_cmm_gethandle.ph_cmm_mgr, &hcmm_mgr, status, 1);
 
-- 
1.5.4.5

