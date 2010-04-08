From: "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>
Subject: [PATCH 02/13] DSPBRIDGE: Replace mem_alloc() by kmalloc()
Date: Thu, 8 Apr 2010 18:44:58 -0500
Message-ID: <818EF96F5A7CC84789DD014773DB09548F6481CD@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43321 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933983Ab0DHXpE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 19:45:04 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, "Menon, Nishanth" <nm@ti.com>

>From 5256a37e6f27df70f8333a02dd87ef9a202ed2b4 Mon Sep 17 00:00:00 2001
From: Ivan Gomez Castellanos <ivan.gomez@ti.com>
Date: Fri, 19 Mar 2010 18:19:55 -0600
Subject: [PATCH 02/13] DSPBRIDGE: Replace mem_alloc() by kmalloc()

This is needed because the file drivers/dsp/bridge/services/mem.c
is going to be deleted. The changes should be as follows:

mem_alloc(x, MEM_PAGED) ==> kmalloc(x, GFP_KERNEL)
mem_alloc(x, MEM_NONPAGED) ==> kmalloc(x, GFP_KERNEL)
mem_alloc(x, MEM_MEM_LARGEVIRTMEM) ==> vmalloc(x)

If running in atomic context, then the GFP_KERNEL argument
is changed to GFP_ATOMIC.

Signed-off-by: Ivan Gomez Castellanos <ivan.gomez@ti.com>
---
 drivers/dsp/bridge/pmgr/wcd.c        |   26 +++++++++++++-------------
 drivers/dsp/bridge/rmgr/drv.c        |    4 ++--
 drivers/dsp/bridge/rmgr/strm.c       |    4 ++--
 drivers/dsp/bridge/services/regsup.c |    4 ++--
 drivers/dsp/bridge/wmd/chnl_sm.c     |    2 +-
 drivers/dsp/bridge/wmd/io_sm.c       |    6 +++---
 6 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 1b9c76f..5b2c1f5 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -420,7 +420,7 @@ u32 mgrwrap_enum_node_info(union Trapped_Args *args, void *pr_ctxt)
 	if (size < sizeof(struct dsp_ndbprops))
 		return DSP_ESIZE;
 
-	pndb_props = mem_alloc(size, MEM_NONPAGED);
+	pndb_props = kmalloc(size, GFP_KERNEL);
 	if (pndb_props == NULL)
 		status = DSP_EMEMORY;
 
@@ -452,7 +452,7 @@ u32 mgrwrap_enum_proc_info(union Trapped_Args *args, void *pr_ctxt)
 	if (size < sizeof(struct dsp_processorinfo))
 		return DSP_ESIZE;
 
-	processor_info = mem_alloc(size, MEM_NONPAGED);
+	processor_info = kmalloc(size, GFP_KERNEL);
 	if (processor_info == NULL)
 		status = DSP_EMEMORY;
 
@@ -491,7 +491,7 @@ u32 mgrwrap_register_object(union Trapped_Args *args, void *pr_ctxt)
 	path_size = strlen_user((char *)
 				args->args_mgr_registerobject.psz_path_name) +
 	    1;
-	psz_path_name = mem_alloc(path_size, MEM_NONPAGED);
+	psz_path_name = kmalloc(path_size, GFP_KERNEL);
 	if (!psz_path_name)
 		goto func_end;
 	ret = strncpy_from_user(psz_path_name,
@@ -620,7 +620,7 @@ u32 procwrap_ctrl(union Trapped_Args *args, void *pr_ctxt)
 			goto func_end;
 		}
 		cb_data_size += sizeof(u32);
-		pargs = mem_alloc(cb_data_size, MEM_NONPAGED);
+		pargs = kmalloc(cb_data_size, GFP_KERNEL);
 		if (pargs == NULL) {
 			status = DSP_EMEMORY;
 			goto func_end;
@@ -798,7 +798,7 @@ u32 procwrap_load(union Trapped_Args *args, void *pr_ctxt)
 		goto func_cont;
 	}
 
-	argv = mem_alloc(count * sizeof(u8 *), MEM_NONPAGED);
+	argv = kmalloc(count * sizeof(u8 *), GFP_KERNEL);
 	if (!argv) {
 		status = DSP_EMEMORY;
 		goto func_cont;
@@ -818,7 +818,7 @@ u32 procwrap_load(union Trapped_Args *args, void *pr_ctxt)
 			/* len is increased by 1 to accommodate NULL */
 			len = strlen_user((char *)temp) + 1;
 			/* Kernel space pointer to argument */
-			argv[i] = mem_alloc(len, MEM_NONPAGED);
+			argv[i] = kmalloc(len, GFP_KERNEL);
 			if (argv[i]) {
 				CP_FM_USR(argv[i], temp, status, len);
 				if (DSP_FAILED(status)) {
@@ -840,7 +840,7 @@ u32 procwrap_load(union Trapped_Args *args, void *pr_ctxt)
 			get_user(temp, args->args_proc_load.user_envp + count);
 			count++;
 		} while (temp);
-		envp = mem_alloc(count * sizeof(u8 *), MEM_NONPAGED);
+		envp = kmalloc(count * sizeof(u8 *), GFP_KERNEL);
 		if (!envp) {
 			status = DSP_EMEMORY;
 			goto func_cont;
@@ -858,7 +858,7 @@ u32 procwrap_load(union Trapped_Args *args, void *pr_ctxt)
 			/* len is increased by 1 to accommodate NULL */
 			len = strlen_user((char *)temp) + 1;
 			/* Kernel space pointer to argument */
-			envp[i] = mem_alloc(len, MEM_NONPAGED);
+			envp[i] = kmalloc(len, GFP_KERNEL);
 			if (envp[i]) {
 				CP_FM_USR(envp[i], temp, status, len);
 				if (DSP_FAILED(status)) {
@@ -1040,7 +1040,7 @@ u32 nodewrap_allocate(union Trapped_Args *args, void *pr_ctxt)
 
 		cb_data_size += sizeof(u32);
 		if (DSP_SUCCEEDED(status)) {
-			pargs = mem_alloc(cb_data_size, MEM_NONPAGED);
+			pargs = kmalloc(cb_data_size, GFP_KERNEL);
 			if (pargs == NULL)
 				status = DSP_EMEMORY;
 
@@ -1141,7 +1141,7 @@ u32 nodewrap_connect(union Trapped_Args *args, void *pr_ctxt)
 
 		cb_data_size += sizeof(u32);
 		if (DSP_SUCCEEDED(status)) {
-			pargs = mem_alloc(cb_data_size, MEM_NONPAGED);
+			pargs = kmalloc(cb_data_size, GFP_KERNEL);
 			if (pargs == NULL) {
 				status = DSP_EMEMORY;
 				goto func_cont;
@@ -1351,7 +1351,7 @@ u32 nodewrap_get_uuid_props(union Trapped_Args *args, void *pr_ctxt)
 		  1);
 	if (DSP_FAILED(status))
 		goto func_cont;
-	pnode_props = mem_alloc(sizeof(struct dsp_ndbprops), MEM_NONPAGED);
+	pnode_props = kmalloc(sizeof(struct dsp_ndbprops), GFP_KERNEL);
 	if (pnode_props != NULL) {
 		status =
 		    node_get_uuid_props(args->args_node_getuuidprops.hprocessor,
@@ -1377,7 +1377,7 @@ u32 strmwrap_allocate_buffer(union Trapped_Args *args, void *pr_ctxt)
 	if (num_bufs > MAX_BUFS)
 		return DSP_EINVALIDARG;
 
-	ap_buffer = mem_alloc((num_bufs * sizeof(u8 *)), MEM_NONPAGED);
+	ap_buffer = kmalloc((num_bufs * sizeof(u8 *)), GFP_KERNEL);
 
 	status = strm_allocate_buffer(args->args_strm_allocatebuffer.hstream,
 				      args->args_strm_allocatebuffer.usize,
@@ -1416,7 +1416,7 @@ u32 strmwrap_free_buffer(union Trapped_Args *args, void *pr_ctxt)
 	if (num_bufs > MAX_BUFS)
 		return DSP_EINVALIDARG;
 
-	ap_buffer = mem_alloc((num_bufs * sizeof(u8 *)), MEM_NONPAGED);
+	ap_buffer = kmalloc((num_bufs * sizeof(u8 *)), GFP_KERNEL);
 
 	CP_FM_USR(ap_buffer, args->args_strm_freebuffer.ap_buffer, status,
 		  num_bufs);
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 6070944..77b54d8 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -357,8 +357,8 @@ dsp_status drv_remove_all_strm_res_elements(bhandle hPCtxt)
 		strm_res = strm_tmp;
 		strm_tmp = strm_tmp->next;
 		if (strm_res->num_bufs) {
-			ap_buffer = mem_alloc((strm_res->num_bufs *
-					       sizeof(u8 *)), MEM_NONPAGED);
+			ap_buffer = kmalloc((strm_res->num_bufs *
+					sizeof(u8 *)), GFP_KERNEL);
 			if (ap_buffer) {
 				status = strm_free_buffer(strm_res->hstream,
 							  ap_buffer,
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index 699f2dc..1c59db1 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -788,8 +788,8 @@ dsp_status strm_select(IN struct strm_object **strm_tab, u32 nStrms,
 	}
 	if (DSP_SUCCEEDED(status) && utimeout > 0 && *pmask == 0) {
 		/* Non-zero timeout */
-		sync_events = (struct sync_object **)mem_alloc(nStrms *
-			      sizeof(struct sync_object *), MEM_PAGED);
+		sync_events = kmalloc(nStrms * sizeof(struct sync_object *),
+								GFP_KERNEL);
 
 		if (sync_events == NULL) {
 			status = DSP_EMEMORY;
diff --git a/drivers/dsp/bridge/services/regsup.c b/drivers/dsp/bridge/services/regsup.c
index 542ce62..49b6fb9 100644
--- a/drivers/dsp/bridge/services/regsup.c
+++ b/drivers/dsp/bridge/services/regsup.c
@@ -123,7 +123,7 @@ dsp_status regsup_set_value(char *valName, void *pbuf, u32 data_size)
 			if (data_size != rv->data_size) {
 				/*  The caller needs a different data size! */
 				kfree(rv->pdata);
-				rv->pdata = mem_alloc(data_size, MEM_NONPAGED);
+				rv->pdata = kmalloc(data_size, GFP_KERNEL);
 				if (rv->pdata == NULL)
 					break;
 			}
@@ -149,7 +149,7 @@ dsp_status regsup_set_value(char *valName, void *pbuf, u32 data_size)
 							GFP_KERNEL);
 
 		strncat(new->name, valName, MAXREGPATHLENGTH - 1);
-		new->pdata = mem_alloc(data_size, MEM_NONPAGED);
+		new->pdata = kmalloc(data_size, GFP_KERNEL);
 		if (new->pdata != NULL) {
 			memcpy(new->pdata, pbuf, data_size);
 			new->data_size = data_size;
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index b6a1a22..7b24022 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -147,7 +147,7 @@ dsp_status bridge_chnl_add_io_req(struct chnl_object *chnl_obj, void *pHostBuf,
 			goto func_cont;
 		}
 		/* if addr in user mode, then copy to kernel space */
-		host_sys_buf = mem_alloc(buf_size, MEM_NONPAGED);
+		host_sys_buf = kmalloc(buf_size, GFP_KERNEL);
 		if (host_sys_buf == NULL) {
 			status = DSP_EMEMORY;
 			goto func_end;
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 7516e7e..2bdfc2a 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -787,9 +787,9 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
 	    (hio_mgr->ul_trace_buffer_current - ul_dsp_va);
 	/* Calculate the size of trace buffer */
 	kfree(hio_mgr->pmsg);
-	hio_mgr->pmsg = mem_alloc(((hio_mgr->ul_trace_buffer_end -
-				    hio_mgr->ul_trace_buffer_begin) *
-				   hio_mgr->word_size) + 2, MEM_NONPAGED);
+	hio_mgr->pmsg = kmalloc(((hio_mgr->ul_trace_buffer_end -
+				hio_mgr->ul_trace_buffer_begin) *
+				hio_mgr->word_size) + 2, GFP_KERNEL);
 	if (!hio_mgr->pmsg)
 		status = DSP_EMEMORY;
 
-- 
1.7.0.3

