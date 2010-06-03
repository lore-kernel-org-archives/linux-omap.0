From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 33/40] DSPBRIDGE: err code replace DSP_EWRONGSTATE with EBADR
Date: Thu,  3 Jun 2010 00:47:46 -0500
Message-ID: <1275544073-20418-34-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56442 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932573Ab0FCF4X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jun 2010 01:56:23 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Replace DSP_EWRONGSTATE with EBADR

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/node.h |   12 ++++++------
 arch/arm/plat-omap/include/dspbridge/proc.h |    6 +++---
 drivers/dsp/bridge/core/msg_sm.c            |    2 +-
 drivers/dsp/bridge/rmgr/node.c              |   18 +++++++++---------
 drivers/dsp/bridge/rmgr/proc.c              |    4 ++--
 5 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/node.h b/arch/arm/plat-omap/include/dspbridge/node.h
index 2f76c04..ed83faf 100644
--- a/arch/arm/plat-omap/include/dspbridge/node.h
+++ b/arch/arm/plat-omap/include/dspbridge/node.h
@@ -45,7 +45,7 @@
  *      -EDOM:         attr_in != NULL and attr_in->prio out of
  *                          range.
  *      -EPERM:          A failure occured, unable to allocate node.
- *      DSP_EWRONGSTATE:    Proccessor is not in the running state.
+ *      -EBADR:    Proccessor is not in the running state.
  *  Requires:
  *      node_init(void) called.
  *      hprocessor != NULL.
@@ -101,7 +101,7 @@ extern dsp_status node_alloc_msg_buf(struct node_object *hnode,
  *      -EFAULT:        Invalid hnode.
  *      -EDOM:         prio is out of range.
  *      -EPERM:      The specified node is not a task node.
- *      DSP_EWRONGSTATE:    Node is not in the NODE_ALLOCATED, NODE_PAUSED,
+ *      -EBADR:    Node is not in the NODE_ALLOCATED, NODE_PAUSED,
  *                          or NODE_RUNNING state.
  *      -ETIME:       A timeout occurred before the DSP responded.
  *      DSP_ERESTART:       A critical error has occurred and the DSP is
@@ -170,7 +170,7 @@ extern dsp_status node_close_orphans(struct node_mgr *hnode_mgr,
  *      -EINVAL:             A stream index parameter is invalid.
  *      -EISCONN:  A connection already exists for one of the
  *                              indices uStream1 or uStream2.
- *      DSP_EWRONGSTATE:        Either hNode1 or hNode2 is not in the
+ *      -EBADR:        Either hNode1 or hNode2 is not in the
  *                              NODE_ALLOCATED state.
  *      -ECONNREFUSED: No more connections available.
  *      -EPERM:              Attempt to make an illegal connection (eg,
@@ -200,7 +200,7 @@ extern dsp_status node_connect(struct node_object *hNode1,
  *      0:            Success.
  *      -EFAULT:        Invalid hnode.
  *      -ESPIPE:        Create function not found in the COFF file.
- *      DSP_EWRONGSTATE:    Node is not in the NODE_ALLOCATED state.
+ *      -EBADR:    Node is not in the NODE_ALLOCATED state.
  *      -ENOMEM:        Memory allocation failure on the DSP.
  *      DSP_ETASK:          Unable to create node's task or process on the DSP.
  *      DSP_ESTREAM:        Stream creation failure on the DSP.
@@ -469,7 +469,7 @@ extern dsp_status node_pause(struct node_object *hnode);
  *      -EFAULT:        Invalid hnode.
  *      -EPERM:      Messages can't be sent to this type of node.
  *      -ETIME:       Timeout occurred before message could be set.
- *      DSP_EWRONGSTATE:    Node is in invalid state for sending messages.
+ *      -EBADR:    Node is in invalid state for sending messages.
  *      -EPERM:          Unable to send message.
  *  Requires:
  *      node_init(void) called.
@@ -544,7 +544,7 @@ extern dsp_status node_run(struct node_object *hnode);
  *      -EFAULT:        Invalid hnode.
  *      -ETIME:       A timeout occurred before the DSP responded.
  *      -EPERM:      Type of node specified cannot be terminated.
- *      DSP_EWRONGSTATE:    Operation not valid for the current node state.
+ *      -EBADR:    Operation not valid for the current node state.
  *      -EPERM:          Unable to terminate the node.
  *  Requires:
  *      node_init(void) called.
diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/plat-omap/include/dspbridge/proc.h
index 9311f72..561842e 100644
--- a/arch/arm/plat-omap/include/dspbridge/proc.h
+++ b/arch/arm/plat-omap/include/dspbridge/proc.h
@@ -172,7 +172,7 @@ extern dsp_status proc_enum_nodes(void *hprocessor,
  *  Returns:
  *      0     :       Success.
  *      -EFAULT :       Invalid processor handle.
- *      DSP_EWRONGSTATE:    The processor is not in the PROC_RUNNING state.
+ *      -EBADR:    The processor is not in the PROC_RUNNING state.
  *      -ETIME:       A timeout occured before the DSP responded to the
  *			  querry.
  *      DSP_ERESTART:       A Critical error has occured and the DSP is being
@@ -423,7 +423,7 @@ extern dsp_status proc_notify_all_clients(void *hProc, u32 uEvents);
  *  Returns:
  *      0     :       Success.
  *      -EFAULT :       Invalid processor handle.
- *      DSP_EWRONGSTATE:    Processor is not in PROC_LOADED state.
+ *      -EBADR:    Processor is not in PROC_LOADED state.
  *      -EPERM   :       Unable to start the processor.
  *  Requires:
  *      PROC Initialized.
@@ -445,7 +445,7 @@ extern dsp_status proc_start(void *hprocessor);
  *  Returns:
  *      0     :       Success.
  *      -EFAULT :       Invalid processor handle.
- *      DSP_EWRONGSTATE:    Processor is not in PROC_LOADED state.
+ *      -EBADR:    Processor is not in PROC_LOADED state.
  *      -EPERM   :       Unable to start the processor.
  *  Requires:
  *      PROC Initialized.
diff --git a/drivers/dsp/bridge/core/msg_sm.c b/drivers/dsp/bridge/core/msg_sm.c
index 152e110..7ac56b1 100644
--- a/drivers/dsp/bridge/core/msg_sm.c
+++ b/drivers/dsp/bridge/core/msg_sm.c
@@ -511,7 +511,7 @@ dsp_status bridge_msg_register_notify(struct msg_queue *msg_queue_obj,
 	}
 
 	if (notify_type != DSP_SIGNALEVENT) {
-		status = DSP_EWRONGSTATE;
+		status = -EBADR;
 		goto func_end;
 	}
 
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index bb021dd..4d27445 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -801,7 +801,7 @@ dsp_status node_change_priority(struct node_object *hnode, s32 prio)
 		NODE_SET_PRIORITY(hnode, prio);
 	} else {
 		if (state != NODE_RUNNING) {
-			status = DSP_EWRONGSTATE;
+			status = -EBADR;
 			goto func_cont;
 		}
 		status = proc_get_processor_id(pnode->hprocessor, &proc_id);
@@ -917,10 +917,10 @@ dsp_status node_connect(struct node_object *hNode1, u32 uStream1,
 
 	/* Nodes must be in the allocated state */
 	if (node1_type != NODE_GPP && node_get_state(hNode1) != NODE_ALLOCATED)
-		status = DSP_EWRONGSTATE;
+		status = -EBADR;
 
 	if (node2_type != NODE_GPP && node_get_state(hNode2) != NODE_ALLOCATED)
-		status = DSP_EWRONGSTATE;
+		status = -EBADR;
 
 	if (DSP_SUCCEEDED(status)) {
 		/*  Check that stream indices for task and dais socket nodes
@@ -1183,7 +1183,7 @@ dsp_status node_create(struct node_object *hnode)
 
 	/* Check node state */
 	if (node_get_state(hnode) != NODE_ALLOCATED)
-		status = DSP_EWRONGSTATE;
+		status = -EBADR;
 
 	if (DSP_SUCCEEDED(status))
 		status = proc_get_processor_id(pnode->hprocessor, &proc_id);
@@ -1275,7 +1275,7 @@ func_cont2:
 		hnode_mgr->num_created++;
 		goto func_cont;
 	}
-	if (status != DSP_EWRONGSTATE) {
+	if (status != -EBADR) {
 		/* Put back in NODE_ALLOCATED state if error occurred */
 		NODE_SET_STATE(hnode, NODE_ALLOCATED);
 	}
@@ -2045,7 +2045,7 @@ dsp_status node_pause(struct node_object *hnode)
 		state = node_get_state(hnode);
 		/* Check node state */
 		if (state != NODE_RUNNING)
-			status = DSP_EWRONGSTATE;
+			status = -EBADR;
 
 		if (DSP_FAILED(status))
 			goto func_cont;
@@ -2139,7 +2139,7 @@ dsp_status node_put_message(struct node_object *hnode,
 		mutex_lock(&hnode_mgr->node_mgr_lock);
 		state = node_get_state(hnode);
 		if (state == NODE_TERMINATING || state == NODE_DONE)
-			status = DSP_EWRONGSTATE;
+			status = -EBADR;
 
 		/* end of sync_enter_cs */
 		mutex_unlock(&hnode_mgr->node_mgr_lock);
@@ -2290,7 +2290,7 @@ dsp_status node_run(struct node_object *hnode)
 
 	state = node_get_state(hnode);
 	if (state != NODE_CREATED && state != NODE_PAUSED)
-		status = DSP_EWRONGSTATE;
+		status = -EBADR;
 
 	if (DSP_SUCCEEDED(status))
 		status = proc_get_processor_id(pnode->hprocessor, &proc_id);
@@ -2400,7 +2400,7 @@ dsp_status node_terminate(struct node_object *hnode, OUT dsp_status *pstatus)
 		mutex_lock(&hnode_mgr->node_mgr_lock);
 		state = node_get_state(hnode);
 		if (state != NODE_RUNNING) {
-			status = DSP_EWRONGSTATE;
+			status = -EBADR;
 			/* Set the exit status if node terminated on
 			 * its own. */
 			if (state == NODE_DONE)
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 1afdff0..78f06ad 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -1288,7 +1288,7 @@ dsp_status proc_start(void *hprocessor)
 	}
 	/* Call the bridge_brd_start */
 	if (p_proc_object->proc_state != PROC_LOADED) {
-		status = DSP_EWRONGSTATE;
+		status = -EBADR;
 		goto func_end;
 	}
 	status = dev_get_cod_mgr(p_proc_object->hdev_obj, &cod_mgr);
@@ -1375,7 +1375,7 @@ dsp_status proc_stop(void *hprocessor)
 		if ((status == -EINVAL) || (nodes_allocated > 0)) {
 			pr_err("%s: Can't stop device, active nodes = %d \n",
 			       __func__, nodes_allocated);
-			return DSP_EWRONGSTATE;
+			return -EBADR;
 		}
 	}
 	/* Call the bridge_brd_stop */
-- 
1.7.1

