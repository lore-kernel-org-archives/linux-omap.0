From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 08/13] staging: ti dspbridge: deh: remove get_info
Date: Sun,  4 Jul 2010 16:34:34 +0300
Message-ID: <1278250479-16982-9-git-send-email-felipe.contreras@gmail.com>
References: <1278250479-16982-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40955 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757756Ab0GDNfD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Jul 2010 09:35:03 -0400
Received: by mail-bw0-f46.google.com with SMTP id 1so2295322bwz.19
        for <linux-omap@vger.kernel.org>; Sun, 04 Jul 2010 06:34:58 -0700 (PDT)
In-Reply-To: <1278250479-16982-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Greg KH <greg@kroah.com>, Felipe Contreras <felipe.contreras@gmail.com>

Nobody is using it.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/staging/tidspbridge/core/tiomap3430.c      |    1 -
 drivers/staging/tidspbridge/core/ue_deh.c          |   15 ---------------
 .../tidspbridge/include/dspbridge/dspdefs.h        |   19 -------------------
 .../staging/tidspbridge/include/dspbridge/dspdeh.h |    3 ---
 drivers/staging/tidspbridge/pmgr/dev.c             |    2 --
 drivers/staging/tidspbridge/rmgr/proc.c            |    6 ------
 6 files changed, 0 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/tiomap3430.c b/drivers/staging/tidspbridge/core/tiomap3430.c
index 1000c04..ef4abb4 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430.c
@@ -199,7 +199,6 @@ static struct bridge_drv_interface drv_interface_fxns = {
 	bridge_deh_destroy,
 	bridge_deh_notify,
 	bridge_deh_register_notify,
-	bridge_deh_get_info,
 	/* The following IO functions are provided by chnl_io.lib: */
 	bridge_io_create,
 	bridge_io_destroy,
diff --git a/drivers/staging/tidspbridge/core/ue_deh.c b/drivers/staging/tidspbridge/core/ue_deh.c
index 1e506d7..a4940a8 100644
--- a/drivers/staging/tidspbridge/core/ue_deh.c
+++ b/drivers/staging/tidspbridge/core/ue_deh.c
@@ -262,18 +262,3 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 	 */
 	dsp_wdt_enable(false);
 }
-
-int bridge_deh_get_info(struct deh_mgr *deh_mgr,
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
diff --git a/drivers/staging/tidspbridge/include/dspbridge/dspdefs.h b/drivers/staging/tidspbridge/include/dspbridge/dspdefs.h
index 493f62e..49842a2 100644
--- a/drivers/staging/tidspbridge/include/dspbridge/dspdefs.h
+++ b/drivers/staging/tidspbridge/include/dspbridge/dspdefs.h
@@ -775,24 +775,6 @@ typedef int(*fxn_deh_registernotify)
   u32 event_mask, u32 notify_type, struct dsp_notification *hnotification);
 
 /*
- *  ======== bridge_deh_get_info ========
- *  Purpose:
- *      Get DSP exception info.
- *  Parameters:
- *      phDehMgr:       Location to store DEH manager on output.
- *      pErrInfo:       Ptr to error info structure.
- *  Returns:
- *      0:        Success.
- *      -EPERM:      Creation failed.
- *  Requires:
- *      phDehMgr != NULL;
- *      pErrorInfo != NULL;
- *  Ensures:
- */
-typedef int(*fxn_deh_getinfo) (struct deh_mgr *phDehMgr,
-				      struct dsp_errorinfo *pErrInfo);
-
-/*
  *  ======== bridge_io_create ========
  *  Purpose:
  *      Create an object that manages I/O between CHNL and msg_ctrl.
@@ -1082,7 +1064,6 @@ struct bridge_drv_interface {
 	fxn_deh_notify pfn_deh_notify;	/* Notify of DSP error */
 	/* register for deh notif. */
 	fxn_deh_registernotify pfn_deh_register_notify;
-	fxn_deh_getinfo pfn_deh_get_info;	/* register for deh notif. */
 	fxn_io_create pfn_io_create;	/* Create IO manager */
 	fxn_io_destroy pfn_io_destroy;	/* Destroy IO manager */
 	fxn_io_onloaded pfn_io_on_loaded;	/* Notify of program loaded */
diff --git a/drivers/staging/tidspbridge/include/dspbridge/dspdeh.h b/drivers/staging/tidspbridge/include/dspbridge/dspdeh.h
index af19926..f2bfd89 100644
--- a/drivers/staging/tidspbridge/include/dspbridge/dspdeh.h
+++ b/drivers/staging/tidspbridge/include/dspbridge/dspdeh.h
@@ -32,9 +32,6 @@ extern int bridge_deh_create(struct deh_mgr **ret_deh_mgr,
 
 extern int bridge_deh_destroy(struct deh_mgr *deh_mgr);
 
-extern int bridge_deh_get_info(struct deh_mgr *deh_mgr,
-		struct dsp_errorinfo *pErrInfo);
-
 extern int bridge_deh_register_notify(struct deh_mgr *deh_mgr,
 		u32 event_mask,
 		u32 notify_type,
diff --git a/drivers/staging/tidspbridge/pmgr/dev.c b/drivers/staging/tidspbridge/pmgr/dev.c
index 50a5d97..353b81a 100644
--- a/drivers/staging/tidspbridge/pmgr/dev.c
+++ b/drivers/staging/tidspbridge/pmgr/dev.c
@@ -1119,7 +1119,6 @@ static void store_interface_fxns(struct bridge_drv_interface *drv_fxns,
 		STORE_FXN(fxn_deh_destroy, pfn_deh_destroy);
 		STORE_FXN(fxn_deh_notify, pfn_deh_notify);
 		STORE_FXN(fxn_deh_registernotify, pfn_deh_register_notify);
-		STORE_FXN(fxn_deh_getinfo, pfn_deh_get_info);
 		STORE_FXN(fxn_io_create, pfn_io_create);
 		STORE_FXN(fxn_io_destroy, pfn_io_destroy);
 		STORE_FXN(fxn_io_onloaded, pfn_io_on_loaded);
@@ -1160,7 +1159,6 @@ static void store_interface_fxns(struct bridge_drv_interface *drv_fxns,
 	DBC_ENSURE(intf_fxns->pfn_deh_destroy != NULL);
 	DBC_ENSURE(intf_fxns->pfn_deh_notify != NULL);
 	DBC_ENSURE(intf_fxns->pfn_deh_register_notify != NULL);
-	DBC_ENSURE(intf_fxns->pfn_deh_get_info != NULL);
 	DBC_ENSURE(intf_fxns->pfn_io_create != NULL);
 	DBC_ENSURE(intf_fxns->pfn_io_destroy != NULL);
 	DBC_ENSURE(intf_fxns->pfn_io_on_loaded != NULL);
diff --git a/drivers/staging/tidspbridge/rmgr/proc.c b/drivers/staging/tidspbridge/rmgr/proc.c
index b1979ce..c31f8b8 100644
--- a/drivers/staging/tidspbridge/rmgr/proc.c
+++ b/drivers/staging/tidspbridge/rmgr/proc.c
@@ -970,7 +970,6 @@ int proc_get_state(void *hprocessor,
 	int status = 0;
 	struct proc_object *p_proc_object = (struct proc_object *)hprocessor;
 	int brd_status;
-	struct deh_mgr *hdeh_mgr;
 
 	DBC_REQUIRE(refs > 0);
 	DBC_REQUIRE(proc_state_obj != NULL);
@@ -1003,11 +1002,6 @@ int proc_get_state(void *hprocessor,
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

