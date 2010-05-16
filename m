From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/4] dspbridge: dev: fix dev_create_device()
Date: Sun, 16 May 2010 18:45:00 +0300
Message-ID: <1274024702-20961-3-git-send-email-felipe.contreras@gmail.com>
References: <1274024702-20961-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:52300 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615Ab0EPPpM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 11:45:12 -0400
Received: by fg-out-1718.google.com with SMTP id d23so2359655fga.1
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 08:45:11 -0700 (PDT)
In-Reply-To: <1274024702-20961-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

... when resources are not available.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/dsp/bridge/pmgr/dev.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index c85a4fa..4ba8197 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -149,9 +149,11 @@ dsp_status dev_create_device(OUT struct dev_object **phDevObject,
 
 	status = drv_request_bridge_res_dsp((void *)&host_res);
 
-	if (DSP_FAILED(status))
+	if (DSP_FAILED(status)) {
 		dev_dbg(bridge, "%s: Failed to reserve bridge resources\n",
 			__func__);
+		goto leave;
+	}
 
 	/*  Get the WMD interface functions */
 	bridge_drv_entry(&drv_fxns, driver_file_name);
@@ -256,20 +258,20 @@ dsp_status dev_create_device(OUT struct dev_object **phDevObject,
 		else
 			INIT_LIST_HEAD(&dev_obj->proc_list->head);
 	}
+leave:
 	/*  If all went well, return a handle to the dev object;
 	 *  else, cleanup and return NULL in the OUT parameter. */
 	if (DSP_SUCCEEDED(status)) {
 		*phDevObject = dev_obj;
 	} else {
-		kfree(dev_obj->proc_list);
-
-		if (dev_obj && dev_obj->cod_mgr)
-			cod_delete(dev_obj->cod_mgr);
-
-		if (dev_obj && dev_obj->dmm_mgr)
-			dmm_destroy(dev_obj->dmm_mgr);
-
-		kfree(dev_obj);
+		if (dev_obj) {
+			kfree(dev_obj->proc_list);
+			if (dev_obj->cod_mgr)
+				cod_delete(dev_obj->cod_mgr);
+			if (dev_obj->dmm_mgr)
+				dmm_destroy(dev_obj->dmm_mgr);
+			kfree(dev_obj);
+		}
 
 		*phDevObject = NULL;
 	}
-- 
1.7.1

