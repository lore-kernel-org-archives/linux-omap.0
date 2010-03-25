From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC][PATCH 12/19] DSPBRIDGE: Cleanup custom error code (DSP_ESIZE
 -> EINVAL)
Date: Fri, 26 Mar 2010 01:36:47 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DEBEB28@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42915 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754702Ab0CYUHA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 16:07:00 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>

>From c423abda17246b08b64ff4489a50c68697c63714 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Wed, 24 Mar 2010 11:44:03 -0600
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code(DSP_ESIZE -> EINVAL).

This patch replaces DSP_ESIZE with EINVAL.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/errbase.h |    3 ---
 arch/arm/plat-omap/include/dspbridge/node.h    |    6 +++---
 arch/arm/plat-omap/include/dspbridge/proc.h    |    2 +-
 arch/arm/plat-omap/include/dspbridge/strm.h    |    4 ++--
 drivers/dsp/bridge/pmgr/wcd.c                  |   18 +++++++++---------
 drivers/dsp/bridge/rmgr/node.c                 |    2 +-
 drivers/dsp/bridge/rmgr/proc.c                 |    2 +-
 drivers/dsp/bridge/rmgr/strm.c                 |    4 ++--
 drivers/dsp/bridge/services/cfg.c              |    2 +-
 9 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index 1cc0101..87667a6 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -99,9 +99,6 @@
 /* I/O is currently pending. */
 #define DSP_EPENDING                (DSP_EBASE + 0x11)
 
-/* An invalid size parameter was specified. */
-#define DSP_ESIZE                   (DSP_EBASE + 0x14)
-
 /* A stream creation failure occurred on the DSP. */
 #define DSP_ESTREAM                 (DSP_EBASE + 0x15)
 
diff --git a/arch/arm/plat-omap/include/dspbridge/node.h b/arch/arm/plat-omap/include/dspbridge/node.h
index e2c5c94..aff4493 100644
--- a/arch/arm/plat-omap/include/dspbridge/node.h
+++ b/arch/arm/plat-omap/include/dspbridge/node.h
@@ -79,7 +79,7 @@ extern dsp_status node_allocate(struct proc_object *hprocessor,
  *      EFAULT:    Invalid node handle.
  *      ENOMEM:    Insufficent memory.
  *      DSP_EFAIL:      General Failure.
- *      DSP_ESIZE:      Invalid Size.
+ *      EINVAL:      Invalid Size.
  *  Requires:
  *      node_init(void) called.
  *      pbuffer != NULL.
@@ -292,14 +292,14 @@ extern dsp_status node_delete_mgr(struct node_mgr *hnode_mgr);
  *      pu_allocated:    Location to write total number of allocated nodes.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_ESIZE:      node_tab is too small to hold all node handles.
+ *      EINVAL:      node_tab is too small to hold all node handles.
  *  Requires:
  *      Valid hnode_mgr.
  *      node_tab != NULL || node_tab_size == 0.
  *      pu_num_nodes != NULL.
  *      pu_allocated != NULL.
  *  Ensures:
- *      - (DSP_ESIZE && *pu_num_nodes == 0)
+ *      - (EINVAL && *pu_num_nodes == 0)
  *      - || (DSP_SOK && *pu_num_nodes <= node_tab_size)  &&
  *        (*pu_allocated == *pu_num_nodes)
  */
diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/plat-omap/include/dspbridge/proc.h
index 09a7fdf..307f1fd 100644
--- a/arch/arm/plat-omap/include/dspbridge/proc.h
+++ b/arch/arm/plat-omap/include/dspbridge/proc.h
@@ -138,7 +138,7 @@ extern dsp_status proc_detach(struct process_context *pr_ctxt);
  *  Returns:
  *      DSP_SOK     :   Success.
  *      EFAULT :   Invalid processor handle.
- *      DSP_ESIZE   :   The amount of memory allocated for node_tab is
+ *      EINVAL   :   The amount of memory allocated for node_tab is
  *		      insufficent. That is the number of nodes actually
  *		      allocated on the DSP is greater than the value
  *		      specified for node_tab_size.
diff --git a/arch/arm/plat-omap/include/dspbridge/strm.h b/arch/arm/plat-omap/include/dspbridge/strm.h
index 609a6e7..c598366 100644
--- a/arch/arm/plat-omap/include/dspbridge/strm.h
+++ b/arch/arm/plat-omap/include/dspbridge/strm.h
@@ -38,7 +38,7 @@
  *      EFAULT:    Invalid hStrm.
  *      ENOMEM:    Insufficient memory.
  *      DSP_EFAIL:      Failure occurred, unable to allocate buffers.
- *      DSP_ESIZE:      usize must be > 0 bytes.
+ *      EINVAL:      usize must be > 0 bytes.
  *  Requires:
  *      strm_init(void) called.
  *      ap_buffer != NULL.
@@ -172,7 +172,7 @@ extern dsp_status strm_get_event_handle(struct strm_object *hStrm,
  *  Returns:
  *      DSP_SOK:            Success.
  *      EFAULT:        Invalid hStrm.
- *      DSP_ESIZE:          stream_info_size < sizeof(dsp_streaminfo).
+ *      EINVAL:          stream_info_size < sizeof(dsp_streaminfo).
  *      DSP_EFAIL:          Unable to get stream info.
  *  Requires:
  *      strm_init(void) called.
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 8b0aeea..a2b0255 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -420,7 +420,7 @@ u32 mgrwrap_enum_node_info(union Trapped_Args *args, void *pr_ctxt)
 	u32 size = args->args_mgr_enumnode_info.undb_props_size;
 
 	if (size < sizeof(struct dsp_ndbprops))
-		return DSP_ESIZE;
+		return EINVAL;
 
 	pndb_props = mem_alloc(size, MEM_NONPAGED);
 	if (pndb_props == NULL)
@@ -452,7 +452,7 @@ u32 mgrwrap_enum_proc_info(union Trapped_Args *args, void *pr_ctxt)
 	u32 size = args->args_mgr_enumproc_info.processor_info_size;
 
 	if (size < sizeof(struct dsp_processorinfo))
-		return DSP_ESIZE;
+		return EINVAL;
 
 	processor_info = mem_alloc(size, MEM_NONPAGED);
 	if (processor_info == NULL)
@@ -664,7 +664,7 @@ u32 procwrap_enum_node_info(union Trapped_Args *args, void *pr_ctxt)
 	u32 alloc_cnt;
 
 	if (!args->args_proc_enumnode_info.node_tab_size)
-		return DSP_ESIZE;
+		return EINVAL;
 
 	status = proc_enum_nodes(args->args_proc_enumnode_info.hprocessor,
 				 node_tab,
@@ -721,7 +721,7 @@ u32 procwrap_enum_resources(union Trapped_Args *args, void *pr_ctxt)
 
 	if (args->args_proc_enumresources.resource_info_size <
 	    sizeof(struct dsp_resourceinfo))
-		return DSP_ESIZE;
+		return EINVAL;
 
 	status =
 	    proc_get_resource_info(args->args_proc_enumresources.hprocessor,
@@ -747,7 +747,7 @@ u32 procwrap_get_state(union Trapped_Args *args, void *pr_ctxt)
 
 	if (args->args_proc_getstate.state_info_size <
 	    sizeof(struct dsp_processorstate))
-		return DSP_ESIZE;
+		return EINVAL;
 
 	status =
 	    proc_get_state(args->args_proc_getstate.hprocessor, &proc_state,
@@ -767,7 +767,7 @@ u32 procwrap_get_trace(union Trapped_Args *args, void *pr_ctxt)
 	u8 *pbuf;
 
 	if (args->args_proc_gettrace.max_size > MAX_TRACEBUFLEN)
-		return DSP_ESIZE;
+		return EINVAL;
 
 	pbuf = mem_calloc(args->args_proc_gettrace.max_size, MEM_NONPAGED);
 	if (pbuf != NULL) {
@@ -909,7 +909,7 @@ u32 procwrap_map(union Trapped_Args *args, void *pr_ctxt)
 	void *map_addr;
 
 	if (!args->args_proc_mapmem.ul_size)
-		return DSP_ESIZE;
+		return EINVAL;
 
 	status = proc_map(args->args_proc_mapmem.hprocessor,
 			  args->args_proc_mapmem.pmpu_addr,
@@ -959,7 +959,7 @@ u32 procwrap_reserve_memory(union Trapped_Args *args, void *pr_ctxt)
 
 	if ((args->args_proc_rsvmem.ul_size <= 0) ||
 	    (args->args_proc_rsvmem.ul_size & (PG_SIZE4K - 1)) != 0)
-		return DSP_ESIZE;
+		return EINVAL;
 
 	status = proc_reserve_memory(args->args_proc_rsvmem.hprocessor,
 				     args->args_proc_rsvmem.ul_size, &prsv_addr,
@@ -1092,7 +1092,7 @@ u32 nodewrap_alloc_msg_buf(union Trapped_Args *args, void *pr_ctxt)
 	u8 *pbuffer = NULL;
 
 	if (!args->args_node_allocmsgbuf.usize)
-		return DSP_ESIZE;
+		return EINVAL;
 
 	if (args->args_node_allocmsgbuf.pattr) {	/* Optional argument */
 		CP_FM_USR(&attr, args->args_node_allocmsgbuf.pattr, status, 1);
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 6bc0e2e..5b44566 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -1639,7 +1639,7 @@ dsp_status node_enum_nodes(struct node_mgr *hnode_mgr, void **node_tab,
 		if (hnode_mgr->num_nodes > node_tab_size) {
 			*pu_allocated = hnode_mgr->num_nodes;
 			*pu_num_nodes = 0;
-			status = DSP_ESIZE;
+			status = EINVAL;
 		} else {
 			hnode = (struct node_object *)
 			    lst_first(hnode_mgr->node_list);
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 51c6a50..493009a 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -1351,7 +1351,7 @@ dsp_status proc_stop(void *hprocessor)
 	if (DSP_SUCCEEDED(status) && hnode_mgr) {
 		status = node_enum_nodes(hnode_mgr, &hnode, node_tab_size,
 					 &num_nodes, &nodes_allocated);
-		if ((status == DSP_ESIZE) || (nodes_allocated > 0)) {
+		if ((status == EINVAL) || (nodes_allocated > 0)) {
 			pr_err("%s: Can't stop device, active nodes = %d \n",
 			       __func__, nodes_allocated);
 			return DSP_EWRONGSTATE;
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index c451aa8..2c0dbbd 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -121,7 +121,7 @@ dsp_status strm_allocate_buffer(struct strm_object *hStrm, u32 usize,
 		 * Allocate from segment specified at time of stream open.
 		 */
 		if (usize == 0)
-			status = DSP_ESIZE;
+			status = EINVAL;
 
 	} else {
 		status = EFAULT;
@@ -336,7 +336,7 @@ dsp_status strm_get_info(struct strm_object *hStrm,
 	} else {
 		if (stream_info_size < sizeof(struct stream_info)) {
 			/* size of users info */
-			status = DSP_ESIZE;
+			status = EINVAL;
 		}
 	}
 	if (DSP_FAILED(status))
diff --git a/drivers/dsp/bridge/services/cfg.c b/drivers/dsp/bridge/services/cfg.c
index 85b4b26..37d0310 100644
--- a/drivers/dsp/bridge/services/cfg.c
+++ b/drivers/dsp/bridge/services/cfg.c
@@ -162,7 +162,7 @@ dsp_status cfg_get_exec_file(struct cfg_devnode *dev_node_obj, u32 ul_buf_size,
 		if (DSP_FAILED(status))
 			status = CFG_E_RESOURCENOTAVAIL;
 		else if (exec_size > ul_buf_size)
-			status = DSP_ESIZE;
+			status = EINVAL;
 
 	}
 	if (DSP_FAILED(status))
-- 
1.6.0.4

