From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC][PATCH 14/19] DSPBRIDGE: Cleanup custom error code (DSP_EVALUE
 -> EINVAL)
Date: Fri, 26 Mar 2010 01:36:53 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DEBEB2A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50143 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754731Ab0CYUHM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 16:07:12 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>, "Menon, Nishanth" <nm@ti.com>

>From 253e251c2e079bc183f74bede0357f2d8373b215 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Wed, 24 Mar 2010 12:40:50 -0600
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code (DSP_EVALUE -> EINVAL)

This patch replaces DSP_EVALUE with EINVAL.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/errbase.h  |    3 ---
 arch/arm/plat-omap/include/dspbridge/node.h     |    4 ++--
 arch/arm/plat-omap/include/dspbridge/nodepriv.h |    2 +-
 arch/arm/plat-omap/include/dspbridge/ntfy.h     |    2 +-
 arch/arm/plat-omap/include/dspbridge/proc.h     |    2 +-
 arch/arm/plat-omap/include/dspbridge/strm.h     |    4 ++--
 arch/arm/plat-omap/include/dspbridge/wmd.h      |    2 +-
 drivers/dsp/bridge/rmgr/node.c                  |   10 +++++-----
 drivers/dsp/bridge/rmgr/proc.c                  |    6 +++---
 drivers/dsp/bridge/rmgr/strm.c                  |    4 ++--
 drivers/dsp/bridge/services/ntfy.c              |    2 +-
 drivers/dsp/bridge/wmd/msg_sm.c                 |    2 +-
 12 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index 874054c..dedca5d 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -110,9 +110,6 @@
 
 #define DSP_ETRUNCATED              (DSP_EBASE + 0x18)
 
-/* A parameter is invalid. */
-#define DSP_EVALUE                  (DSP_EBASE + 0x1a)
-
 /* The state of the specified object is incorrect for the requested
  * operation. */
 #define DSP_EWRONGSTATE             (DSP_EBASE + 0x1b)
diff --git a/arch/arm/plat-omap/include/dspbridge/node.h b/arch/arm/plat-omap/include/dspbridge/node.h
index abd9f36..cc9a89c 100644
--- a/arch/arm/plat-omap/include/dspbridge/node.h
+++ b/arch/arm/plat-omap/include/dspbridge/node.h
@@ -167,7 +167,7 @@ extern dsp_status node_close_orphans(struct node_mgr *hnode_mgr,
  *      DSP_SOK:                Success.
  *      EFAULT:            Invalid hNode1 or hNode2.
  *      ENOMEM:            Insufficient host memory.
- *      DSP_EVALUE:             A stream index parameter is invalid.
+ *      EINVAL:             A stream index parameter is invalid.
  *      DSP_EALREADYCONNECTED:  A connection already exists for one of the
  *                              indices uStream1 or uStream2.
  *      DSP_EWRONGSTATE:        Either hNode1 or hNode2 is not in the
@@ -492,7 +492,7 @@ extern dsp_status node_put_message(struct node_object *hnode,
  *      DSP_SOK:        Success.
  *      EFAULT:    Invalid hnode.
  *      ENOMEM:    Insufficient memory on GPP.
- *      DSP_EVALUE:     event_mask is invalid.
+ *      EINVAL:     event_mask is invalid.
  *      ENOSYS:   Notification type specified by notify_type is not
  *                      supported.
  *  Requires:
diff --git a/arch/arm/plat-omap/include/dspbridge/nodepriv.h b/arch/arm/plat-omap/include/dspbridge/nodepriv.h
index efff651..7ca1428 100644
--- a/arch/arm/plat-omap/include/dspbridge/nodepriv.h
+++ b/arch/arm/plat-omap/include/dspbridge/nodepriv.h
@@ -93,7 +93,7 @@ struct node_createargs {
  *      DSP_SOK:        Success.
  *      EFAULT:    Invalid hnode.
  *      EPERM:  Not a task or DAIS socket node.
- *      DSP_EVALUE:     The node's stream corresponding to index and dir
+ *      EINVAL:     The node's stream corresponding to index and dir
  *                      is not a stream to or from the host.
  *  Requires:
  *      node_init(void) called.
diff --git a/arch/arm/plat-omap/include/dspbridge/ntfy.h b/arch/arm/plat-omap/include/dspbridge/ntfy.h
index e7d44eb..f17907f 100644
--- a/arch/arm/plat-omap/include/dspbridge/ntfy.h
+++ b/arch/arm/plat-omap/include/dspbridge/ntfy.h
@@ -107,7 +107,7 @@ extern void ntfy_notify(IN struct ntfy_object *ntfy_obj, IN u32 event_mask);
  *  Returns:
  *      DSP_SOK:            Success.
  *      ENOMEM:        Insufficient memory.
- *      DSP_EVALUE:         event_mask is 0 and hnotification was not
+ *      EINVAL:         event_mask is 0 and hnotification was not
  *                          previously registered.
  *      EFAULT:        NULL hnotification, hnotification event name
  *                          too long, or hnotification event name NULL.
diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/plat-omap/include/dspbridge/proc.h
index f77fa9a..572013b 100644
--- a/arch/arm/plat-omap/include/dspbridge/proc.h
+++ b/arch/arm/plat-omap/include/dspbridge/proc.h
@@ -353,7 +353,7 @@ extern dsp_status proc_load(void *hprocessor,
  *  Returns:
  *      DSP_SOK     :   Success.
  *      EFAULT :   Invalid processor handle or hnotification.
- *      DSP_EVALUE  :   Parameter event_mask is Invalid
+ *      EINVAL  :   Parameter event_mask is Invalid
  *      DSP_ENOTIMP :   The notification type specified in uNotifyMask
  *		      is not supported.
  *      DSP_EFAIL   :   Unable to register for notification.
diff --git a/arch/arm/plat-omap/include/dspbridge/strm.h b/arch/arm/plat-omap/include/dspbridge/strm.h
index 225f694..119981d 100644
--- a/arch/arm/plat-omap/include/dspbridge/strm.h
+++ b/arch/arm/plat-omap/include/dspbridge/strm.h
@@ -260,7 +260,7 @@ extern dsp_status strm_issue(struct strm_object *hStrm, IN u8 * pbuf,
  *      DSP_SOK:        Success.
  *      EFAULT:    Invalid hnode.
  *      DSP_EDIRECTION: Invalid dir.
- *      DSP_EVALUE:     Invalid index.
+ *      EINVAL:     Invalid index.
  *      EPERM:  hnode is not a task or DAIS socket node.
  *      DSP_EFAIL:      Unable to open stream.
  *  Requires:
@@ -339,7 +339,7 @@ extern dsp_status strm_reclaim(struct strm_object *hStrm,
  *      DSP_SOK:        Success.
  *      EFAULT:    Invalid hStrm.
  *      ENOMEM:    Insufficient memory on GPP.
- *      DSP_EVALUE:     event_mask is invalid.
+ *      EINVAL:     event_mask is invalid.
  *      ENOSYS:   Notification type specified by notify_type is not
  *                      supported.
  *  Requires:
diff --git a/arch/arm/plat-omap/include/dspbridge/wmd.h b/arch/arm/plat-omap/include/dspbridge/wmd.h
index 4f8b57f..0cee536 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmd.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmd.h
@@ -631,7 +631,7 @@ typedef dsp_status(*fxn_chnl_idle) (struct chnl_object *chnl_obj,
  *  Returns:
  *      DSP_SOK:        Success.
  *      ENOMEM:    Insufficient memory.
- *      DSP_EVALUE:     event_mask is 0 and hnotification was not
+ *      EINVAL:     event_mask is 0 and hnotification was not
  *                      previously registered.
  *      EFAULT:    NULL hnotification, hnotification event name
  *                      too long, or hnotification event name NULL.
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 5c866e8..7903342 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -879,7 +879,7 @@ dsp_status node_connect(struct node_object *hNode1, u32 uStream1,
 							  NODE_DEVICE
 							  && uStream2 >=
 							  MAX_INPUTS(hNode2)))
-			status = DSP_EVALUE;
+			status = EINVAL;
 	}
 	if (DSP_SUCCEEDED(status)) {
 		/*
@@ -1772,7 +1772,7 @@ dsp_status node_get_channel_id(struct node_object *hnode, u32 dir, u32 index,
 			       OUT u32 *pulId)
 {
 	enum node_type node_type;
-	dsp_status status = DSP_EVALUE;
+	dsp_status status = EINVAL;
 	DBC_REQUIRE(refs > 0);
 	DBC_REQUIRE(dir == DSP_TONODE || dir == DSP_FROMNODE);
 	DBC_REQUIRE(pulId != NULL);
@@ -2224,16 +2224,16 @@ dsp_status node_register_notify(struct node_object *hnode, u32 event_mask,
 	} else {
 		/* Check if event mask is a valid node related event */
 		if (event_mask & ~(DSP_NODESTATECHANGE | DSP_NODEMESSAGEREADY))
-			status = DSP_EVALUE;
+			status = EINVAL;
 
 		/* Check if notify type is valid */
 		if (notify_type != DSP_SIGNALEVENT)
-			status = DSP_EVALUE;
+			status = EINVAL;
 
 		/* Only one Notification can be registered at a
 		 * time - Limitation */
 		if (event_mask == (DSP_NODESTATECHANGE | DSP_NODEMESSAGEREADY))
-			status = DSP_EVALUE;
+			status = EINVAL;
 	}
 	if (DSP_SUCCEEDED(status)) {
 		if (event_mask == DSP_NODESTATECHANGE) {
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 493009a..5a35f3b 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -623,7 +623,7 @@ dsp_status proc_get_resource_info(void *hprocessor, u32 resource_type,
 					      (struct dsp_memstat *)
 					      &(resource_info->result.
 						mem_stat)))
-					status = DSP_EVALUE;
+					status = EINVAL;
 			}
 		}
 		break;
@@ -1150,11 +1150,11 @@ dsp_status proc_register_notify(void *hprocessor, u32 event_mask,
 	if (event_mask & ~(DSP_PROCESSORSTATECHANGE | DSP_PROCESSORATTACH |
 			   DSP_PROCESSORDETACH | DSP_PROCESSORRESTART |
 			   DSP_MMUFAULT | DSP_SYSERROR | DSP_PWRERROR))
-		status = DSP_EVALUE;
+		status = EINVAL;
 
 	/* Check if notify type is valid */
 	if (notify_type != DSP_SIGNALEVENT)
-		status = DSP_EVALUE;
+		status = EINVAL;
 
 	if (DSP_SUCCEEDED(status)) {
 		/* If event mask is not DSP_SYSERROR, DSP_MMUFAULT,
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index 0a34abb..274d387 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -614,7 +614,7 @@ func_cont:
 		    MEM_IS_VALID_HANDLE((*phStrm), STRM_SIGNATURE)) ||
 		   (*phStrm == NULL && (status == EFAULT ||
 					status == DSP_EDIRECTION
-					|| status == DSP_EVALUE
+					|| status == EINVAL
 					|| status == DSP_EFAIL)));
 
 	dev_dbg(bridge, "%s: hnode: %p dir: 0x%x index: 0x%x pattr: %p "
@@ -724,7 +724,7 @@ dsp_status strm_register_notify(struct strm_object *hStrm, u32 event_mask,
 		status = EFAULT;
 	} else if ((event_mask & ~((DSP_STREAMIOCOMPLETION) |
 				   DSP_STREAMDONE)) != 0) {
-		status = DSP_EVALUE;
+		status = EINVAL;
 	} else {
 		if (notify_type != DSP_SIGNALEVENT)
 			status = ENOSYS;
diff --git a/drivers/dsp/bridge/services/ntfy.c b/drivers/dsp/bridge/services/ntfy.c
index d5ca5e8..b1c5c9f 100644
--- a/drivers/dsp/bridge/services/ntfy.c
+++ b/drivers/dsp/bridge/services/ntfy.c
@@ -242,7 +242,7 @@ dsp_status ntfy_register(struct ntfy_object *ntfy_obj,
 	if (notifier_obj == NULL) {
 		/* Not registered */
 		if (event_mask == 0) {
-			status = DSP_EVALUE;
+			status = EINVAL;
 		} else {
 			/* Allocate notifier object, add to list */
 			notifier_obj = mem_calloc(sizeof(struct notifier),
diff --git a/drivers/dsp/bridge/wmd/msg_sm.c b/drivers/dsp/bridge/wmd/msg_sm.c
index 217631a..bd16d77 100644
--- a/drivers/dsp/bridge/wmd/msg_sm.c
+++ b/drivers/dsp/bridge/wmd/msg_sm.c
@@ -503,7 +503,7 @@ dsp_status bridge_msg_register_notify(struct msg_queue *msg_queue_obj,
 	    ntfy_register(msg_queue_obj->ntfy_obj, hnotification, event_mask,
 			  notify_type);
 
-	if (status == DSP_EVALUE) {
+	if (status == EINVAL) {
 		/*  Not registered. Ok, since we couldn't have known. Node
 		 *  notifications are split between node state change handled
 		 *  by NODE, and message ready handled by msg_ctrl. */
-- 
1.6.0.4

