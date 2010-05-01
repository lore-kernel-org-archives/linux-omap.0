From: Ivan Gomez Castellanos <ivan.gomez@ti.com>
Subject: [PATCH 11/11] DSPBRIDGE: Rename header file guard macros that cointain WMD or WCD
Date: Fri, 30 Apr 2010 19:45:51 -0500
Message-ID: <1272674751-21557-12-git-send-email-ivan.gomez@ti.com>
References: <1272674751-21557-1-git-send-email-ivan.gomez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35608 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757980Ab0EAAwz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Apr 2010 20:52:55 -0400
In-Reply-To: <1272674751-21557-1-git-send-email-ivan.gomez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi.DOYU@nokia.com, ameya.palande@nokia.com, felipe.contreras@nokia.com, Ivan Gomez Castellanos <ivan.gomez@ti.com>

The patch "DSPBRIDGE: Rename files that refer to Windows OS", renamed
header files, and this patch renames its include guard macros by the
corresponding new header names.

Signed-off-by: Ivan Gomez Castellanos <ivan.gomez@ti.com>
---
 .../arm/plat-omap/include/dspbridge/dspapi-ioctl.h |    6 +++---
 arch/arm/plat-omap/include/dspbridge/dspchnl.h     |    6 +++---
 arch/arm/plat-omap/include/dspbridge/dspdefs.h     |    6 +++---
 arch/arm/plat-omap/include/dspbridge/dspdeh.h      |    6 +++---
 arch/arm/plat-omap/include/dspbridge/dspio.h       |    6 +++---
 arch/arm/plat-omap/include/dspbridge/dspioctl.h    |    6 +++---
 arch/arm/plat-omap/include/dspbridge/dspmsg.h      |    6 +++---
 7 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dspapi-ioctl.h b/arch/arm/plat-omap/include/dspbridge/dspapi-ioctl.h
index c214ea6..f6a146e 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspapi-ioctl.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspapi-ioctl.h
@@ -17,8 +17,8 @@
  * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
  */
 
-#ifndef WCDIOCTL_
-#define WCDIOCTL_
+#ifndef DSPAPIIOCTL_
+#define DSPAPIIOCTL_
 
 #include <dspbridge/cmm.h>
 #include <dspbridge/strmdefs.h>
@@ -463,4 +463,4 @@ union Trapped_Args {
 #define CMM_GETHANDLE		_IOR(DB, DB_IOC(DB_CMM, 2), unsigned long)
 #define CMM_GETINFO		_IOR(DB, DB_IOC(DB_CMM, 3), unsigned long)
 
-#endif /* WCDIOCTL_ */
+#endif /* DSPAPIIOCTL_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/dspchnl.h b/arch/arm/plat-omap/include/dspbridge/dspchnl.h
index 3c6f29d..acb0691 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspchnl.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspchnl.h
@@ -21,8 +21,8 @@
  * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
  */
 
-#ifndef WMDCHNL_
-#define WMDCHNL_
+#ifndef DSPCHNL_
+#define DSPCHNL_
 
 extern dsp_status bridge_chnl_create(OUT struct chnl_mgr **phChnlMgr,
 				     struct dev_object *hdev_obj,
@@ -69,4 +69,4 @@ extern dsp_status bridge_chnl_register_notify(struct chnl_object *chnl_obj,
 					   struct dsp_notification
 					   *hnotification);
 
-#endif /* WMDCHNL_ */
+#endif /* DSPCHNL_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/dspdefs.h b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
index 26a9988..b25f4b2 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
@@ -26,8 +26,8 @@
  * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
  */
 
-#ifndef WMD_
-#define WMD_
+#ifndef DSPDEFS_
+#define DSPDEFS_
 
 #include <dspbridge/brddefs.h>
 #include <dspbridge/cfgdefs.h>
@@ -1132,4 +1132,4 @@ struct bridge_drv_interface {
 void bridge_drv_entry(OUT struct bridge_drv_interface **ppDrvInterface,
 		   IN CONST char *driver_file_name);
 
-#endif /* WMD_ */
+#endif /* DSPDEFS_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/dspdeh.h b/arch/arm/plat-omap/include/dspbridge/dspdeh.h
index f6a747f..81d3459 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspdeh.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspdeh.h
@@ -20,8 +20,8 @@
  * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
  */
 
-#ifndef WMDDEH_
-#define WMDDEH_
+#ifndef DSPDEH_
+#define DSPDEH_
 
 #include <dspbridge/devdefs.h>
 
@@ -45,4 +45,4 @@ extern void bridge_deh_notify(struct deh_mgr *hdeh_mgr,
 			      u32 ulEventMask, u32 dwErrInfo);
 
 extern void bridge_deh_release_dummy_mem(void);
-#endif /* WMDDEH_ */
+#endif /* DSPDEH_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/dspio.h b/arch/arm/plat-omap/include/dspbridge/dspio.h
index b010d2a..a826d9d 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspio.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspio.h
@@ -20,8 +20,8 @@
  * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
  */
 
-#ifndef WMDIO_
-#define WMDIO_
+#ifndef DSPIO_
+#define DSPIO_
 
 #include <dspbridge/devdefs.h>
 #include <dspbridge/iodefs.h>
@@ -38,4 +38,4 @@ extern dsp_status iva_io_on_loaded(struct io_mgr *hio_mgr);
 extern dsp_status bridge_io_get_proc_load(IN struct io_mgr *hio_mgr,
 				       OUT struct dsp_procloadstat *pProcStat);
 
-#endif /* WMDIO_ */
+#endif /* DSPIO_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/dspioctl.h b/arch/arm/plat-omap/include/dspbridge/dspioctl.h
index 3f7a787..380fff5 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspioctl.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspioctl.h
@@ -16,8 +16,8 @@
  * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
  */
 
-#ifndef WMDIOCTL_
-#define WMDIOCTL_
+#ifndef DSPIOCTL_
+#define DSPIOCTL_
 
 /* ------------------------------------ Hardware Abstraction Layer */
 #include <hw_defs.h>
@@ -70,4 +70,4 @@ struct bridge_ioctl_extproc {
 	enum hw_element_size_t elem_size;
 };
 
-#endif /* WMDIOCTL_ */
+#endif /* DSPIOCTL_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/dspmsg.h b/arch/arm/plat-omap/include/dspbridge/dspmsg.h
index 86db728..e1acf90 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspmsg.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspmsg.h
@@ -21,8 +21,8 @@
  * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
  */
 
-#ifndef WMDMSG_
-#define WMDMSG_
+#ifndef DSPMSG_
+#define DSPMSG_
 
 #include <dspbridge/msgdefs.h>
 
@@ -52,4 +52,4 @@ extern dsp_status bridge_msg_register_notify(struct msg_queue *msg_queue_obj,
 
 extern void bridge_msg_set_queue_id(struct msg_queue *msg_queue_obj, u32 msgq_id);
 
-#endif /* WMDMSG_ */
+#endif /* DSPMSG_ */
-- 
1.7.0.3

