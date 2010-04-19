From: "Uribe de Leon, Armando" <x0095078@ti.com>
Subject: [PATCH 2/5v2] DSPBRIDGE: Remove checkpatch warnings: 80 char lines
Date: Mon, 19 Apr 2010 17:26:43 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90EC26C7E43@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42582 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716Ab0DSW0u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Apr 2010 18:26:50 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "hiroshi.DOYU@nokia.com" <hiroshi.DOYU@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

>From ff68a8b932f4a542d0ec464a40d9abce93327291 Mon Sep 17 00:00:00 2001
From: Armando Uribe De Leon <x0095078@ti.com>
Date: Mon, 19 Apr 2010 16:51:00 -0500
Subject: [PATCH 2/5] DSPBRIDGE: Remove checkpatch warnings: 80 char lines

This patch removes checkpatch warning regarding with
lines exceeded 80 characters.

Signed-off-by: Armando Uribe De Leon <x0095078@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dev.h    |    2 +-
 arch/arm/plat-omap/include/dspbridge/wmdmsg.h |    3 +-
 drivers/dsp/bridge/pmgr/dev.c                 |    3 +-
 drivers/dsp/bridge/rmgr/node.c                |   67 ++++++++++--------------
 drivers/dsp/bridge/rmgr/pwr.c                 |    8 ++--
 drivers/dsp/bridge/wmd/chnl_sm.c              |    4 +-
 6 files changed, 39 insertions(+), 48 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dev.h b/arch/arm/plat-omap/include/dspbridge/dev.h
index 13b0cad..7224bc7 100644
--- a/arch/arm/plat-omap/include/dspbridge/dev.h
+++ b/arch/arm/plat-omap/include/dspbridge/dev.h
@@ -396,7 +396,7 @@ extern struct dev_object *dev_get_first(void);
  *      else:           *ppIntfFxns is NULL.
  */
 extern dsp_status dev_get_intf_fxns(struct dev_object *hdev_obj,
-				    OUT struct bridge_drv_interface **ppIntfFxns);
+				OUT struct bridge_drv_interface **ppIntfFxns);
 
 /*
  *  ======== dev_get_io_mgr ========
diff --git a/arch/arm/plat-omap/include/dspbridge/wmdmsg.h b/arch/arm/plat-omap/include/dspbridge/wmdmsg.h
index f8005ea..74d6cbb 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmdmsg.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmdmsg.h
@@ -50,6 +50,7 @@ extern dsp_status bridge_msg_register_notify(struct msg_queue *msg_queue_obj,
 					  struct dsp_notification
 					  *hnotification);
 
-extern void bridge_msg_set_queue_id(struct msg_queue *msg_queue_obj, u32 msgq_id);
+extern void bridge_msg_set_queue_id(struct msg_queue *msg_queue_obj,
+					u32 msgq_id);
 
 #endif /* WMDMSG_ */
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index 5bc16e9..0005c2b 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -68,7 +68,8 @@ struct dev_object {
 	u32 dw_signature;	/* Used for object validation. */
 	struct cfg_devnode *dev_node_obj;	/* Platform specific dev id */
 	struct wmd_dev_context *hwmd_context;	/* WMD Context Handle */
-	struct bridge_drv_interface wmd_interface;	/* Function interface to WMD. */
+	struct bridge_drv_interface wmd_interface;	/* Function interface to
+						         * WMD. */
 	struct brd_object *lock_owner;	/* Client with exclusive access. */
 	struct cod_manager *cod_mgr;	/* Code manager handle. */
 	struct chnl_mgr *hchnl_mgr;	/* Channel manager. */
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 32df890..0fe5f0c 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -2450,45 +2450,34 @@ dsp_status node_terminate(struct node_object *hnode, OUT dsp_status *pstatus)
 		status = (*intf_fxns->pfn_msg_put) (hnode->msg_queue_obj, &msg,
 						    hnode->utimeout);
 		/* FIXME */
-		if (DSP_SUCCEEDED(status)) {
-			/*  Wait on synchronization object that will be
-			 *  posted in the callback on receiving RMS_EXIT
-			 *  message, or by node_delete. Check for valid hnode,
-			 *  in case posted by node_delete(). */
-			status = sync_wait_on_event(hnode->sync_done,
-						    kill_time_out / 2);
-			if (DSP_FAILED(status)) {
-				if (status == DSP_ETIMEOUT) {
-					status = (*intf_fxns->pfn_msg_put)
-					    (hnode->msg_queue_obj, &killmsg,
-					     hnode->utimeout);
-					if (DSP_SUCCEEDED(status)) {
-						status = sync_wait_on_event
-						    (hnode->sync_done,
-						     kill_time_out / 2);
-						if (DSP_FAILED(status)) {
-							/* Here it goes the part
-							 * of the simulation of
-							 * the DSP exception */
-							dev_get_deh_mgr
-							   (hnode_mgr->hdev_obj,
-							    &hdeh_mgr);
-							if (hdeh_mgr) {
-								(*intf_fxns->
-								pfn_deh_notify)
-								 (hdeh_mgr,
-								  DSP_SYSERROR,
-								  DSP_EXCEPTIONABORT);
-								status =
-								    DSP_EFAIL;
-							}
-						} else
-							status = DSP_SOK;
-					}
-				} else
-					status = DSP_EFAIL;
-			} else	/* Convert SYNC status to DSP status */
-				status = DSP_SOK;
+		if (DSP_FAILED(status))
+			goto func_cont;
+		/*
+		 * Wait on synchronization object that will be posted in the
+		 * callback on receiving RMS_EXIT message, or by
+		 * node_delete. Check for valid hnode,  in case posted
+		 *  by node_delete().
+		 */
+		status = sync_wait_on_event(hnode->sync_done,
+						kill_time_out / 2);
+		if (status != DSP_ETIMEOUT)
+			goto func_cont;
+		status = (*intf_fxns->pfn_msg_put)(hnode->msg_queue_obj,
+						&killmsg, hnode->utimeout);
+		if (DSP_FAILED(status))
+			goto func_cont;
+		status = sync_wait_on_event(hnode->sync_done,
+						kill_time_out / 2);
+		if (DSP_FAILED(status)) {
+			/*
+			 * Here it goes the part of the simulation of
+			 * the DSP exception
+			 */
+			dev_get_deh_mgr(hnode_mgr->hdev_obj, &hdeh_mgr);
+			if (!hdeh_mgr)
+				goto func_cont;
+			(*intf_fxns->pfn_deh_notify)(hdeh_mgr, DSP_SYSERROR,
+							DSP_EXCEPTIONABORT);
 		}
 	}
 func_cont:
diff --git a/drivers/dsp/bridge/rmgr/pwr.c b/drivers/dsp/bridge/rmgr/pwr.c
index 51d8f44..daa7f3c 100644
--- a/drivers/dsp/bridge/rmgr/pwr.c
+++ b/drivers/dsp/bridge/rmgr/pwr.c
@@ -50,13 +50,13 @@ dsp_status pwr_sleep_dsp(IN CONST u32 sleepCode, IN CONST u32 timeout)
 	     hdev_obj =
 	     (struct dev_object *)drv_get_next_dev_object((u32) hdev_obj)) {
 		if (DSP_FAILED(dev_get_wmd_context(hdev_obj,
-						   (struct wmd_dev_context **)
-						   &dw_context))) {
+					(struct wmd_dev_context **)
+					&dw_context))) {
 			continue;
 		}
 		if (DSP_FAILED(dev_get_intf_fxns(hdev_obj,
-						 (struct bridge_drv_interface **)
-						 &intf_fxns))) {
+					(struct bridge_drv_interface **)
+					&intf_fxns))) {
 			continue;
 		}
 		if (sleepCode == PWR_DEEPSLEEP)
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index a2f98e9..71dc8a3 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -515,8 +515,8 @@ dsp_status bridge_chnl_flush_io(struct chnl_object *chnl_obj, u32 dwTimeOut)
 			 * timeout: */
 			while (!LST_IS_EMPTY(pchnl->pio_requests) &&
 			       DSP_SUCCEEDED(status)) {
-				status = bridge_chnl_get_ioc(chnl_obj, dwTimeOut,
-							  &chnl_ioc_obj);
+				status = bridge_chnl_get_ioc(chnl_obj,
+					dwTimeOut, &chnl_ioc_obj);
 				if (DSP_FAILED(status))
 					continue;
 
-- 
1.6.0.4

