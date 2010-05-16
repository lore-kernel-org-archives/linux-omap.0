From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 11/14] dspbridge: access deh directly
Date: Sun, 16 May 2010 18:46:02 +0300
Message-ID: <1274024765-21076-12-git-send-email-felipe.contreras@gmail.com>
References: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:5081 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628Ab0EPPqb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 11:46:31 -0400
Received: by fg-out-1718.google.com with SMTP id d23so2359940fga.1
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 08:46:31 -0700 (PDT)
In-Reply-To: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/plat-omap/include/dspbridge/dspdefs.h |   56 ------------------------
 drivers/dsp/bridge/core/tiomap3430.c           |    5 --
 drivers/dsp/bridge/pmgr/dev.c                  |   15 +-----
 drivers/dsp/bridge/rmgr/node.c                 |    5 +-
 drivers/dsp/bridge/rmgr/proc.c                 |   18 +++----
 5 files changed, 14 insertions(+), 85 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dspdefs.h b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
index a5d410f..268c217 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
@@ -731,57 +731,6 @@ typedef dsp_status(*fxn_dev_ctrl) (struct bridge_dev_context *hDevContext,
 typedef dsp_status(*fxn_dev_destroy) (struct bridge_dev_context *hDevContext);
 
 /*
- *  ======== bridge_deh_create ========
- *  Purpose:
- *      Create an object that manages DSP exceptions from the GPP.
- *  Parameters:
- *      phDehMgr:       Location to store DEH manager on output.
- *      hdev_obj:     Handle to DEV object.
- *  Returns:
- *      DSP_SOK:        Success.
- *      -ENOMEM:    Memory allocation failure.
- *      -EPERM:      Creation failed.
- *  Requires:
- *      hdev_obj != NULL;
- *      phDehMgr != NULL;
- *  Ensures:
- */
-typedef dsp_status(*fxn_deh_create) (OUT struct deh_mgr
-				     **phDehMgr, struct dev_object *hdev_obj);
-
-/*
- *  ======== bridge_deh_destroy ========
- *  Purpose:
- *      Destroy the DEH object.
- *  Parameters:
- *      hdeh_mgr:        Handle to DEH manager object.
- *  Returns:
- *      DSP_SOK:        Success.
- *      -EPERM:      Destroy failed.
- *  Requires:
- *      hdeh_mgr != NULL;
- *  Ensures:
- */
-typedef dsp_status(*fxn_deh_destroy) (struct deh_mgr *hdeh_mgr);
-
-/*
- *  ======== bridge_deh_register_notify ========
- *  Purpose:
- *      Register for DEH event notification.
- *  Parameters:
- *      hdeh_mgr:        Handle to DEH manager object.
- *  Returns:
- *      DSP_SOK:        Success.
- *      -EPERM:      Destroy failed.
- *  Requires:
- *      hdeh_mgr != NULL;
- *  Ensures:
- */
-typedef dsp_status(*fxn_deh_registernotify)
- (struct deh_mgr *hdeh_mgr,
-  u32 event_mask, u32 notify_type, struct dsp_notification *hnotification);
-
-/*
  *  ======== bridge_io_create ========
  *  Purpose:
  *      Create an object that manages I/O between CHNL and msg_ctrl.
@@ -1066,11 +1015,6 @@ struct bridge_drv_interface {
 	fxn_chnl_idle pfn_chnl_idle;	/* Idle the channel */
 	/* Register for notif. */
 	fxn_chnl_registernotify pfn_chnl_register_notify;
-	fxn_deh_create pfn_deh_create;	/* Create DEH manager */
-	fxn_deh_destroy pfn_deh_destroy;	/* Destroy DEH manager */
-	fxn_deh_notify pfn_deh_notify;	/* Notify of DSP error */
-	/* register for deh notif. */
-	fxn_deh_registernotify pfn_deh_register_notify;
 	fxn_io_create pfn_io_create;	/* Create IO manager */
 	fxn_io_destroy pfn_io_destroy;	/* Destroy IO manager */
 	fxn_io_onloaded pfn_io_on_loaded;	/* Notify of program loaded */
diff --git a/drivers/dsp/bridge/core/tiomap3430.c b/drivers/dsp/bridge/core/tiomap3430.c
index 99bf966..f6b421e 100644
--- a/drivers/dsp/bridge/core/tiomap3430.c
+++ b/drivers/dsp/bridge/core/tiomap3430.c
@@ -192,11 +192,6 @@ static struct bridge_drv_interface drv_interface_fxns = {
 	bridge_chnl_get_mgr_info,
 	bridge_chnl_idle,
 	bridge_chnl_register_notify,
-	/* The following DEH functions are provided by tihelen_ue_deh.c */
-	bridge_deh_create,
-	bridge_deh_destroy,
-	bridge_deh_notify,
-	bridge_deh_register_notify,
 	/* The following IO functions are provided by chnl_io.lib: */
 	bridge_io_create,
 	bridge_io_destroy,
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index b1c8d8b..3f7eb47 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -49,6 +49,7 @@
 #include <dspbridge/io.h>
 #include <dspbridge/msg.h>
 #include <dspbridge/cmm.h>
+#include <dspbridge/dspdeh.h>
 
 /*  ----------------------------------- This */
 #include <dspbridge/dev.h>
@@ -235,8 +236,7 @@ dsp_status dev_create_device(OUT struct dev_object **phDevObject,
 		/* Only create DEH manager if we have an IO manager */
 		if (DSP_SUCCEEDED(status)) {
 			/* Instantiate the DEH module */
-			status = (*dev_obj->bridge_interface.pfn_deh_create)
-			    (&dev_obj->hdeh_mgr, dev_obj);
+			status = bridge_deh_create(&dev_obj->hdeh_mgr, dev_obj);
 		}
 		/* Create DMM mgr . */
 		status = dmm_create(&dev_obj->dmm_mgr,
@@ -371,8 +371,7 @@ dsp_status dev_destroy_device(struct dev_object *hdev_obj)
 
 		if (dev_obj->hdeh_mgr) {
 			/* Uninitialize DEH module. */
-			(*dev_obj->bridge_interface.pfn_deh_destroy)
-			    (dev_obj->hdeh_mgr);
+			bridge_deh_destroy(dev_obj->hdeh_mgr);
 			dev_obj->hdeh_mgr = NULL;
 		}
 		if (dev_obj->hcmm_mgr) {
@@ -1117,10 +1116,6 @@ static void store_interface_fxns(struct bridge_drv_interface *drv_fxns,
 		STORE_FXN(fxn_chnl_getmgrinfo, pfn_chnl_get_mgr_info);
 		STORE_FXN(fxn_chnl_idle, pfn_chnl_idle);
 		STORE_FXN(fxn_chnl_registernotify, pfn_chnl_register_notify);
-		STORE_FXN(fxn_deh_create, pfn_deh_create);
-		STORE_FXN(fxn_deh_destroy, pfn_deh_destroy);
-		STORE_FXN(fxn_deh_notify, pfn_deh_notify);
-		STORE_FXN(fxn_deh_registernotify, pfn_deh_register_notify);
 		STORE_FXN(fxn_io_create, pfn_io_create);
 		STORE_FXN(fxn_io_destroy, pfn_io_destroy);
 		STORE_FXN(fxn_io_onloaded, pfn_io_on_loaded);
@@ -1157,10 +1152,6 @@ static void store_interface_fxns(struct bridge_drv_interface *drv_fxns,
 	DBC_ENSURE(intf_fxns->pfn_chnl_get_mgr_info != NULL);
 	DBC_ENSURE(intf_fxns->pfn_chnl_idle != NULL);
 	DBC_ENSURE(intf_fxns->pfn_chnl_register_notify != NULL);
-	DBC_ENSURE(intf_fxns->pfn_deh_create != NULL);
-	DBC_ENSURE(intf_fxns->pfn_deh_destroy != NULL);
-	DBC_ENSURE(intf_fxns->pfn_deh_notify != NULL);
-	DBC_ENSURE(intf_fxns->pfn_deh_register_notify != NULL);
 	DBC_ENSURE(intf_fxns->pfn_io_create != NULL);
 	DBC_ENSURE(intf_fxns->pfn_io_destroy != NULL);
 	DBC_ENSURE(intf_fxns->pfn_io_on_loaded != NULL);
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index cdd60e6..23aed68 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -69,6 +69,8 @@
 #include <dspbridge/resourcecleanup.h>
 #include <_tiomap.h>
 
+#include <dspbridge/dspdeh.h>
+
 #define HOSTPREFIX	  "/host"
 #define PIPEPREFIX	  "/dbpipe"
 
@@ -2470,8 +2472,7 @@ dsp_status node_terminate(struct node_object *hnode, OUT dsp_status *pstatus)
 			if (!hdeh_mgr)
 				goto func_cont;
 
-			(*intf_fxns->pfn_deh_notify)(hdeh_mgr, DSP_SYSERROR,
-							DSP_EXCEPTIONABORT);
+			bridge_deh_notify(hdeh_mgr, DSP_SYSERROR, DSP_EXCEPTIONABORT);
 		}
 	}
 func_cont:
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index f86958a..1cccc89 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -1192,22 +1192,20 @@ dsp_status proc_register_notify(void *hprocessor, u32 event_mask,
 				status =
 				    dev_get_deh_mgr(p_proc_object->hdev_obj,
 						    &hdeh_mgr);
-				DBC_ASSERT(p_proc_object->
-					   intf_fxns->pfn_deh_register_notify);
 				status =
-				    (*p_proc_object->
-				     intf_fxns->pfn_deh_register_notify)
-				    (hdeh_mgr, event_mask, notify_type,
-				     hnotification);
+					bridge_deh_register_notify(hdeh_mgr,
+							event_mask,
+							notify_type,
+							hnotification);
 			}
 		} else {
 			status = dev_get_deh_mgr(p_proc_object->hdev_obj,
 						 &hdeh_mgr);
-			DBC_ASSERT(p_proc_object->
-				   intf_fxns->pfn_deh_register_notify);
 			status =
-			    (*p_proc_object->intf_fxns->pfn_deh_register_notify)
-			    (hdeh_mgr, event_mask, notify_type, hnotification);
+			    bridge_deh_register_notify(hdeh_mgr,
+					    event_mask,
+					    notify_type,
+					    hnotification);
 
 		}
 	}
-- 
1.7.1

