From: "Uribe de Leon, Armando" <x0095078@ti.com>
Subject: [PATCH 2/5] DSPBRIDGE: Remove checkpatch errors: 80 char lines
Date: Sat, 17 Apr 2010 13:44:41 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90EC26227EE@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33550 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751946Ab0DQSor convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Apr 2010 14:44:47 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "hiroshi.DOYU@nokia.com" <hiroshi.DOYU@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

>From 27145cb2f0aa004a9c4159ad094c0ae60f75a3b3 Mon Sep 17 00:00:00 2001
From: Armando Uribe De Leon <x0095078@ti.com>
Date: Thu, 8 Apr 2010 15:20:09 -0500
Subject: [PATCH 2/5] DSPBRIDGE: Remove checkpatch errors: 80 char lines

This patch removes checkptach errors regarding with lines exceeded 80 chatacters.

Signed-off-by: Armando Uribe De Leon <x0095078@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dev.h    |    2 +-
 arch/arm/plat-omap/include/dspbridge/wmdmsg.h |    3 +-
 drivers/dsp/bridge/pmgr/dev.c                 |    3 +-
 drivers/dsp/bridge/rmgr/node.c                |   59 +++++++++++-------------
 drivers/dsp/bridge/rmgr/pwr.c                 |    8 ++--
 drivers/dsp/bridge/wmd/chnl_sm.c              |    5 +-
 6 files changed, 39 insertions(+), 41 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dev.h b/arch/arm/plat-omap/include/dspbridge/dev.h
index 13b0cad..d930dc1 100644
--- a/arch/arm/plat-omap/include/dspbridge/dev.h
+++ b/arch/arm/plat-omap/include/dspbridge/dev.h
@@ -396,7 +396,7 @@ extern struct dev_object *dev_get_first(void);
  *      else:           *ppIntfFxns is NULL.
  */
 extern dsp_status dev_get_intf_fxns(struct dev_object *hdev_obj,
-				    OUT struct bridge_drv_interface **ppIntfFxns);
+			OUT struct bridge_drv_interface **ppIntfFxns);
 
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
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c index 5bc16e9..18b84b0 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -68,7 +68,8 @@ struct dev_object {
 	u32 dw_signature;	/* Used for object validation. */
 	struct cfg_devnode *dev_node_obj;	/* Platform specific dev id */
 	struct wmd_dev_context *hwmd_context;	/* WMD Context Handle */
-	struct bridge_drv_interface wmd_interface;	/* Function interface to WMD. */
+	struct bridge_drv_interface wmd_interface;	/* Function interface to
+						  * WMD. */
 	struct brd_object *lock_owner;	/* Client with exclusive access. */
 	struct cod_manager *cod_mgr;	/* Code manager handle. */
 	struct chnl_mgr *hchnl_mgr;	/* Channel manager. */
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c index 32df890..be68fa7 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -2457,38 +2457,33 @@ dsp_status node_terminate(struct node_object *hnode, OUT dsp_status *pstatus)
 			 *  in case posted by node_delete(). */
 			status = sync_wait_on_event(hnode->sync_done,
 						    kill_time_out / 2);
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
+			if (status == DSP_ETIMEOUT) {
+				status = (*intf_fxns->pfn_msg_put)
+				     (hnode->msg_queue_obj, &killmsg,
+				      hnode->utimeout);
+				if (DSP_SUCCEEDED(status)) {
+					status = sync_wait_on_event
+					     (hnode->sync_done,
+					       kill_time_out / 2);
+					if (DSP_FAILED(status)) {
+						/* Here it goes the part
+						 * of the simulation of
+						 * the DSP exception */
+						dev_get_deh_mgr
+						   (hnode_mgr->hdev_obj,
+						    &hdeh_mgr);
+						if (hdeh_mgr) {
+							(*intf_fxns->
+							pfn_deh_notify)
+							 (hdeh_mgr,
+							  DSP_SYSERROR,
+							  DSP_EXCEPTIONABORT);
+							status = DSP_EFAIL;
+						}
+					} else
+						status = DSP_SOK;
+				}
+			}
 		}
 	}
 func_cont:
diff --git a/drivers/dsp/bridge/rmgr/pwr.c b/drivers/dsp/bridge/rmgr/pwr.c index 51d8f44..c12b82f 100644
--- a/drivers/dsp/bridge/rmgr/pwr.c
+++ b/drivers/dsp/bridge/rmgr/pwr.c
@@ -50,13 +50,13 @@ dsp_status pwr_sleep_dsp(IN CONST u32 sleepCode, IN CONST u32 timeout)
 	     hdev_obj =
 	     (struct dev_object *)drv_get_next_dev_object((u32) hdev_obj)) {
 		if (DSP_FAILED(dev_get_wmd_context(hdev_obj,
-						   (struct wmd_dev_context **)
-						   &dw_context))) {
+				(struct wmd_dev_context **)
+				&dw_context))) {
 			continue;
 		}
 		if (DSP_FAILED(dev_get_intf_fxns(hdev_obj,
-						 (struct bridge_drv_interface **)
-						 &intf_fxns))) {
+				(struct bridge_drv_interface **)
+				&intf_fxns))) {
 			continue;
 		}
 		if (sleepCode == PWR_DEEPSLEEP)
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index a2f98e9..8c585ff 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -515,8 +515,9 @@ dsp_status bridge_chnl_flush_io(struct chnl_object *chnl_obj, u32 dwTimeOut)
 			 * timeout: */
 			while (!LST_IS_EMPTY(pchnl->pio_requests) &&
 			       DSP_SUCCEEDED(status)) {
-				status = bridge_chnl_get_ioc(chnl_obj, dwTimeOut,
-							  &chnl_ioc_obj);
+				status = bridge_chnl_get_ioc(chnl_obj,
+					dwTimeOut,
+					&chnl_ioc_obj);
 				if (DSP_FAILED(status))
 					continue;
 
--
1.6.0.4

