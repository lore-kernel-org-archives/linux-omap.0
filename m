From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 27/40] DSPBRIDGE: err code replace DSP_EDCDNOAUTOREGISTER with EACCES
Date: Thu,  3 Jun 2010 00:47:40 -0500
Message-ID: <1275544073-20418-28-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39722 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163Ab0FCF4U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 01:56:20 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Replace DSP_EDCDNOAUTOREGISTER with EACCES

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dbdcd.h |    6 +++---
 drivers/dsp/bridge/rmgr/dbdcd.c              |    2 +-
 drivers/dsp/bridge/rmgr/proc.c               |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbdcd.h b/arch/arm/plat-omap/include/dspbridge/dbdcd.h
index f7e4e79..17fb57a 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbdcd.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdcd.h
@@ -34,7 +34,7 @@
  *                              objects to be registered.
  *  Returns:
  *      0:                Success.
- *      DSP_EDCDNOAUTOREGISTER: Unable to find auto-registration section.
+ *      -EACCES: Unable to find auto-registration section.
  *      DSP_EDCDREADSECT:       Unable to read object code section.
  *      DSP_EDCDLOADBASE:       Unable to load code base.
  *      -EFAULT:            Invalid DCD_HMANAGER handle..
@@ -60,7 +60,7 @@ extern dsp_status dcd_auto_register(IN struct dcd_manager *hdcd_mgr,
  *                              DCD objects to be unregistered.
  *  Returns:
  *      0:                Success.
- *      DSP_EDCDNOAUTOREGISTER: Unable to find auto-registration section.
+ *      -EACCES: Unable to find auto-registration section.
  *      DSP_EDCDREADSECT:       Unable to read object code section.
  *      DSP_EDCDLOADBASE:       Unable to load code base.
  *      -EFAULT:            Invalid DCD_HMANAGER handle..
@@ -289,7 +289,7 @@ extern dsp_status dcd_get_object_def(IN struct dcd_manager *hdcd_mgr,
  *      handle:                 Handle to pass to callback.
  *  Returns:
  *      0:                Success.
- *      DSP_EDCDNOAUTOREGISTER: Unable to find .dcd_register section.
+ *      -EACCES: Unable to find .dcd_register section.
  *      DSP_EDCDREADSECT:       Unable to read object code section.
  *      DSP_EDCDLOADBASE:       Unable to load code base.
  *      -EFAULT:            Invalid DCD_HMANAGER handle..
diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index 1731334..dcca612 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -567,7 +567,7 @@ dsp_status dcd_get_objects(IN struct dcd_manager *hdcd_mgr,
 	/* Get DCD_RESIGER_SECTION section information. */
 	status = cod_get_section(lib, DCD_REGISTER_SECTION, &ul_addr, &ul_len);
 	if (DSP_FAILED(status) || !(ul_len > 0)) {
-		status = DSP_EDCDNOAUTOREGISTER;
+		status = -EACCES;
 		goto func_cont;
 	}
 
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 1f46f66..1afdff0 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -907,13 +907,13 @@ dsp_status proc_load(void *hprocessor, IN CONST s32 argc_index,
 		if (DSP_SUCCEEDED(status)) {
 			/*  Auto register nodes in specified COFF
 			 *  file.  If registration did not fail,
-			 *  (status = 0 or DSP_EDCDNOAUTOREGISTER)
+			 *  (status = 0 or -EACCES)
 			 *  save the name of the COFF file for
 			 *  de-registration in the future. */
 			status =
 			    dcd_auto_register(hdcd_handle,
 					      (char *)user_args[0]);
-			if (status == DSP_EDCDNOAUTOREGISTER)
+			if (status == -EACCES)
 				status = 0;
 
 			if (DSP_FAILED(status)) {
-- 
1.7.1

