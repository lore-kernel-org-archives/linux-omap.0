From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC][PATCH 7/19] DSPBRIDGE: Cleanup custom error code
 (DSP_ENODETYPE -> EPERM)
Date: Fri, 26 Mar 2010 01:36:32 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DEBEB23@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50129 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754702Ab0CYUGz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 16:06:55 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>, "Menon, Nishanth" <nm@ti.com>

>From 6bb5942655ec4fd4a3f389da358b5a7096fba630 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Tue, 23 Mar 2010 12:02:46 -0600
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code (DSP_ENODETYPE -> EPERM).

This patch replaces DSP_ENODETYPE with EPERM

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/errbase.h  |    3 ---
 arch/arm/plat-omap/include/dspbridge/node.h     |   12 ++++++------
 arch/arm/plat-omap/include/dspbridge/nodepriv.h |    2 +-
 arch/arm/plat-omap/include/dspbridge/strm.h     |    2 +-
 drivers/dsp/bridge/rmgr/node.c                  |   16 ++++++++--------
 drivers/dsp/bridge/wmd/msg_sm.c                 |    2 +-
 6 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index 2ba76d4..5b8d9e5 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -90,9 +90,6 @@
 /* A general failure occurred */
 #define DSP_EFAIL                   (DSP_EBASE + 8)
 
-/* The requested operation is invalid for this node type. */
-#define DSP_ENODETYPE               (DSP_EBASE + 0xd)
-
 /* No error text was found for the specified error code. */
 #define DSP_ENOERRTEXT              (DSP_EBASE + 0xe)
 
diff --git a/arch/arm/plat-omap/include/dspbridge/node.h b/arch/arm/plat-omap/include/dspbridge/node.h
index 4f5f356..6bde825 100644
--- a/arch/arm/plat-omap/include/dspbridge/node.h
+++ b/arch/arm/plat-omap/include/dspbridge/node.h
@@ -100,7 +100,7 @@ extern dsp_status node_alloc_msg_buf(struct node_object *hnode,
  *      DSP_SOK:            Success.
  *      EFAULT:        Invalid hnode.
  *      DSP_ERANGE:         prio is out of range.
- *      DSP_ENODETYPE:      The specified node is not a task node.
+ *      EPERM:      The specified node is not a task node.
  *      DSP_EWRONGSTATE:    Node is not in the NODE_ALLOCATED, NODE_PAUSED,
  *                          or NODE_RUNNING state.
  *      DSP_ETIMEOUT:       A timeout occurred before the DSP responded.
@@ -382,7 +382,7 @@ extern dsp_status node_get_attr(struct node_object *hnode,
  *  Returns:
  *      DSP_SOK:        Success.
  *      EFAULT:    Invalid hnode.
- *      DSP_ENODETYPE:  Cannot retrieve messages from this type of node.
+ *      EPERM:  Cannot retrieve messages from this type of node.
  *      DSP_ETIMEOUT:   Timeout occurred and no message is available.
  *      DSP_EFAIL:      Error occurred while trying to retrieve a message.
  *  Requires:
@@ -443,7 +443,7 @@ void node_on_exit(struct node_object *hnode, s32 nStatus);
  *  Returns:
  *      DSP_SOK:            Success.
  *      EFAULT:        Invalid hnode.
- *      DSP_ENODETYPE:      Node is not a task or socket node.
+ *      EPERM:      Node is not a task or socket node.
  *      DSP_ETIMEOUT:       A timeout occurred before the DSP responded.
  *      DSP_EWRONGSTSATE:   Node is not in NODE_RUNNING state.
  *      DSP_EFAIL:          Failed to pause node.
@@ -467,7 +467,7 @@ extern dsp_status node_pause(struct node_object *hnode);
  *  Returns:
  *      DSP_SOK:            Success.
  *      EFAULT:        Invalid hnode.
- *      DSP_ENODETYPE:      Messages can't be sent to this type of node.
+ *      EPERM:      Messages can't be sent to this type of node.
  *      DSP_ETIMEOUT:       Timeout occurred before message could be set.
  *      DSP_EWRONGSTATE:    Node is in invalid state for sending messages.
  *      DSP_EFAIL:          Unable to send message.
@@ -517,7 +517,7 @@ extern dsp_status node_register_notify(struct node_object *hnode,
  *  Returns:
  *      DSP_SOK:            Success.
  *      EFAULT:        Invalid hnode.
- *      DSP_ENODETYPE:      hnode doesn't represent a message, task or dais
+ *      EPERM:      hnode doesn't represent a message, task or dais
  *                          socket node.
  *      DSP_ETIMEOUT:       A timeout occurred before the DSP responded.
  *      DSP_EWRONGSTSATE:   Node is not in NODE_PAUSED or NODE_CREATED state.
@@ -543,7 +543,7 @@ extern dsp_status node_run(struct node_object *hnode);
  *      DSP_SOK:            Success.
  *      EFAULT:        Invalid hnode.
  *      DSP_ETIMEOUT:       A timeout occurred before the DSP responded.
- *      DSP_ENODETYPE:      Type of node specified cannot be terminated.
+ *      EPERM:      Type of node specified cannot be terminated.
  *      DSP_EWRONGSTATE:    Operation not valid for the current node state.
  *      DSP_EFAIL:          Unable to terminate the node.
  *  Requires:
diff --git a/arch/arm/plat-omap/include/dspbridge/nodepriv.h b/arch/arm/plat-omap/include/dspbridge/nodepriv.h
index a0108e9..efff651 100644
--- a/arch/arm/plat-omap/include/dspbridge/nodepriv.h
+++ b/arch/arm/plat-omap/include/dspbridge/nodepriv.h
@@ -92,7 +92,7 @@ struct node_createargs {
  *  Returns:
  *      DSP_SOK:        Success.
  *      EFAULT:    Invalid hnode.
- *      DSP_ENODETYPE:  Not a task or DAIS socket node.
+ *      EPERM:  Not a task or DAIS socket node.
  *      DSP_EVALUE:     The node's stream corresponding to index and dir
  *                      is not a stream to or from the host.
  *  Requires:
diff --git a/arch/arm/plat-omap/include/dspbridge/strm.h b/arch/arm/plat-omap/include/dspbridge/strm.h
index 4b1ce21..c36a9ef 100644
--- a/arch/arm/plat-omap/include/dspbridge/strm.h
+++ b/arch/arm/plat-omap/include/dspbridge/strm.h
@@ -261,7 +261,7 @@ extern dsp_status strm_issue(struct strm_object *hStrm, IN u8 * pbuf,
  *      EFAULT:    Invalid hnode.
  *      DSP_EDIRECTION: Invalid dir.
  *      DSP_EVALUE:     Invalid index.
- *      DSP_ENODETYPE:  hnode is not a task or DAIS socket node.
+ *      EPERM:  hnode is not a task or DAIS socket node.
  *      DSP_EFAIL:      Unable to open stream.
  *  Requires:
  *      strm_init(void) called.
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index ed26dff..4ac6f68 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -697,7 +697,7 @@ DBAPI node_alloc_msg_buf(struct node_object *hnode, u32 usize,
 	if (!MEM_IS_VALID_HANDLE(pnode, NODE_SIGNATURE))
 		status = EFAULT;
 	else if (node_get_type(pnode) == NODE_DEVICE)
-		status = DSP_ENODETYPE;
+		status = EPERM;
 
 	if (DSP_FAILED(status))
 		goto func_end;
@@ -783,7 +783,7 @@ dsp_status node_change_priority(struct node_object *hnode, s32 prio)
 		hnode_mgr = hnode->hnode_mgr;
 		node_type = node_get_type(hnode);
 		if (node_type != NODE_TASK && node_type != NODE_DAISSOCKET)
-			status = DSP_ENODETYPE;
+			status = EPERM;
 		else if (prio < hnode_mgr->min_pri || prio > hnode_mgr->max_pri)
 			status = DSP_ERANGE;
 	}
@@ -1783,7 +1783,7 @@ dsp_status node_get_channel_id(struct node_object *hnode, u32 dir, u32 index,
 	}
 	node_type = node_get_type(hnode);
 	if (node_type != NODE_TASK && node_type != NODE_DAISSOCKET) {
-		status = DSP_ENODETYPE;
+		status = EPERM;
 		return status;
 	}
 	if (dir == DSP_TONODE) {
@@ -1843,7 +1843,7 @@ dsp_status node_get_message(struct node_object *hnode,
 	node_type = node_get_type(hnode);
 	if (node_type != NODE_MESSAGE && node_type != NODE_TASK &&
 	    node_type != NODE_DAISSOCKET) {
-		status = DSP_ENODETYPE;
+		status = EPERM;
 		goto func_end;
 	}
 	/*  This function will block unless a message is available. Since
@@ -2038,7 +2038,7 @@ dsp_status node_pause(struct node_object *hnode)
 	} else {
 		node_type = node_get_type(hnode);
 		if (node_type != NODE_TASK && node_type != NODE_DAISSOCKET)
-			status = DSP_ENODETYPE;
+			status = EPERM;
 	}
 	if (DSP_FAILED(status))
 		goto func_end;
@@ -2144,7 +2144,7 @@ dsp_status node_put_message(struct node_object *hnode,
 	node_type = node_get_type(hnode);
 	if (node_type != NODE_MESSAGE && node_type != NODE_TASK &&
 	    node_type != NODE_DAISSOCKET)
-		status = DSP_ENODETYPE;
+		status = EPERM;
 
 	if (DSP_SUCCEEDED(status)) {
 		/*  Check node state. Can't send messages to a node after
@@ -2295,7 +2295,7 @@ dsp_status node_run(struct node_object *hnode)
 	}
 	node_type = node_get_type(hnode);
 	if (node_type == NODE_DEVICE)
-		status = DSP_ENODETYPE;
+		status = EPERM;
 	if (DSP_FAILED(status))
 		goto func_end;
 
@@ -2416,7 +2416,7 @@ dsp_status node_terminate(struct node_object *hnode, OUT dsp_status *pstatus)
 		hnode_mgr = hnode->hnode_mgr;
 		node_type = node_get_type(hnode);
 		if (node_type != NODE_TASK && node_type != NODE_DAISSOCKET)
-			status = DSP_ENODETYPE;
+			status = EPERM;
 	}
 	if (DSP_SUCCEEDED(status)) {
 		/* Check node state */
diff --git a/drivers/dsp/bridge/wmd/msg_sm.c b/drivers/dsp/bridge/wmd/msg_sm.c
index 1863c28..89c13e3 100644
--- a/drivers/dsp/bridge/wmd/msg_sm.c
+++ b/drivers/dsp/bridge/wmd/msg_sm.c
@@ -490,7 +490,7 @@ dsp_status bridge_msg_register_notify(struct msg_queue *msg_queue_obj,
 	}
 
 	if (!(event_mask == DSP_NODEMESSAGEREADY || event_mask == 0)) {
-		status = DSP_ENODETYPE;
+		status = EPERM;
 		goto func_end;
 	}
 
-- 
1.6.0.4

