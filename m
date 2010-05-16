From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 09/14] dspbridge: deh: remove get_info
Date: Sun, 16 May 2010 18:46:00 +0300
Message-ID: <1274024765-21076-10-git-send-email-felipe.contreras@gmail.com>
References: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:5081 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444Ab0EPPq1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 11:46:27 -0400
Received: by fg-out-1718.google.com with SMTP id d23so2359940fga.1
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 08:46:26 -0700 (PDT)
In-Reply-To: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Nobody is using it.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/plat-omap/include/dspbridge/dspdefs.h |   19 -------------------
 arch/arm/plat-omap/include/dspbridge/dspdeh.h  |    3 ---
 drivers/dsp/bridge/core/tiomap3430.c           |    1 -
 drivers/dsp/bridge/core/ue_deh.c               |   15 ---------------
 drivers/dsp/bridge/pmgr/dev.c                  |    2 --
 drivers/dsp/bridge/rmgr/proc.c                 |    6 ------
 6 files changed, 0 insertions(+), 46 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dspdefs.h b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
index 3dfe406..a5d410f 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
@@ -782,24 +782,6 @@ typedef dsp_status(*fxn_deh_registernotify)
   u32 event_mask, u32 notify_type, struct dsp_notification *hnotification);
 
 /*
- *  ======== bridge_deh_get_info ========
- *  Purpose:
- *      Get DSP exception info.
- *  Parameters:
- *      phDehMgr:       Location to store DEH manager on output.
- *      pErrInfo:       Ptr to error info structure.
- *  Returns:
- *      DSP_SOK:        Success.
- *      -EPERM:      Creation failed.
- *  Requires:
- *      phDehMgr != NULL;
- *      pErrorInfo != NULL;
- *  Ensures:
- */
-typedef dsp_status(*fxn_deh_getinfo) (struct deh_mgr *phDehMgr,
-				      struct dsp_errorinfo *pErrInfo);
-
-/*
  *  ======== bridge_io_create ========
  *  Purpose:
  *      Create an object that manages I/O between CHNL and msg_ctrl.
@@ -1089,7 +1071,6 @@ struct bridge_drv_interface {
 	fxn_deh_notify pfn_deh_notify;	/* Notify of DSP error */
 	/* register for deh notif. */
 	fxn_deh_registernotify pfn_deh_register_notify;
-	fxn_deh_getinfo pfn_deh_get_info;	/* register for deh notif. */
 	fxn_io_create pfn_io_create;	/* Create IO manager */
 	fxn_io_destroy pfn_io_destroy;	/* Destroy IO manager */
 	fxn_io_onloaded pfn_io_on_loaded;	/* Notify of program loaded */
diff --git a/arch/arm/plat-omap/include/dspbridge/dspdeh.h b/arch/arm/plat-omap/include/dspbridge/dspdeh.h
index e263184..4c4d577 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspdeh.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspdeh.h
@@ -32,9 +32,6 @@ extern dsp_status bridge_deh_create(struct deh_mgr **ret_deh_mgr,
 
 extern dsp_status bridge_deh_destroy(struct deh_mgr *deh_mgr);
 
-extern dsp_status bridge_deh_get_info(struct deh_mgr *deh_mgr,
-		struct dsp_errorinfo *pErrInfo);
-
 extern dsp_status bridge_deh_register_notify(struct deh_mgr *deh_mgr,
 		u32 event_mask,
 		u32 notify_type,
diff --git a/drivers/dsp/bridge/core/tiomap3430.c b/drivers/dsp/bridge/core/tiomap3430.c
index d00eaaa..99bf966 100644
--- a/drivers/dsp/bridge/core/tiomap3430.c
+++ b/drivers/dsp/bridge/core/tiomap3430.c
@@ -197,7 +197,6 @@ static struct bridge_drv_interface drv_interface_fxns = {
 	bridge_deh_destroy,
 	bridge_deh_notify,
 	bridge_deh_register_notify,
-	bridge_deh_get_info,
 	/* The following IO functions are provided by chnl_io.lib: */
 	bridge_io_create,
 	bridge_io_destroy,
diff --git a/drivers/dsp/bridge/core/ue_deh.c b/drivers/dsp/bridge/core/ue_deh.c
index 1d1b87b..2388780 100644
--- a/drivers/dsp/bridge/core/ue_deh.c
+++ b/drivers/dsp/bridge/core/ue_deh.c
@@ -306,18 +306,3 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 	 */
 	dsp_wdt_enable(false);
 }
-
-dsp_status bridge_deh_get_info(struct deh_mgr *deh_mgr,
-		struct dsp_errorinfo *pErrInfo)
-{
-	if (!deh_mgr)
-		return -EFAULT;
-
-	/* Copy DEH error info structure to PROC error info structure. */
-	pErrInfo->dw_err_mask = deh_mgr->err_info.dw_err_mask;
-	pErrInfo->dw_val1 = deh_mgr->err_info.dw_val1;
-	pErrInfo->dw_val2 = deh_mgr->err_info.dw_val2;
-	pErrInfo->dw_val3 = deh_mgr->err_info.dw_val3;
-
-	return 0;
-}
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index c85a4fa..b1c8d8b 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -1121,7 +1121,6 @@ static void store_interface_fxns(struct bridge_drv_interface *drv_fxns,
 		STORE_FXN(fxn_deh_destroy, pfn_deh_destroy);
 		STORE_FXN(fxn_deh_notify, pfn_deh_notify);
 		STORE_FXN(fxn_deh_registernotify, pfn_deh_register_notify);
-		STORE_FXN(fxn_deh_getinfo, pfn_deh_get_info);
 		STORE_FXN(fxn_io_create, pfn_io_create);
 		STORE_FXN(fxn_io_destroy, pfn_io_destroy);
 		STORE_FXN(fxn_io_onloaded, pfn_io_on_loaded);
@@ -1162,7 +1161,6 @@ static void store_interface_fxns(struct bridge_drv_interface *drv_fxns,
 	DBC_ENSURE(intf_fxns->pfn_deh_destroy != NULL);
 	DBC_ENSURE(intf_fxns->pfn_deh_notify != NULL);
 	DBC_ENSURE(intf_fxns->pfn_deh_register_notify != NULL);
-	DBC_ENSURE(intf_fxns->pfn_deh_get_info != NULL);
 	DBC_ENSURE(intf_fxns->pfn_io_create != NULL);
 	DBC_ENSURE(intf_fxns->pfn_io_destroy != NULL);
 	DBC_ENSURE(intf_fxns->pfn_io_on_loaded != NULL);
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index f9efe6a..f86958a 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -706,7 +706,6 @@ dsp_status proc_get_state(void *hprocessor,
 	dsp_status status = DSP_SOK;
 	struct proc_object *p_proc_object = (struct proc_object *)hprocessor;
 	int brd_status;
-	struct deh_mgr *hdeh_mgr;
 
 	DBC_REQUIRE(refs > 0);
 	DBC_REQUIRE(proc_state_obj != NULL);
@@ -739,11 +738,6 @@ dsp_status proc_get_state(void *hprocessor,
 				break;
 			}
 		}
-		/* Next, retrieve error information, if any */
-		status = dev_get_deh_mgr(p_proc_object->hdev_obj, &hdeh_mgr);
-		if (DSP_SUCCEEDED(status) && hdeh_mgr)
-			status = (*p_proc_object->intf_fxns->pfn_deh_get_info)
-			    (hdeh_mgr, &(proc_state_obj->err_info));
 	} else {
 		status = -EFAULT;
 	}
-- 
1.7.1

