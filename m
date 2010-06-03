From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 28/40] DSPBRIDGE: err code replace DSP_EDCDLOADBASE with EACCES
Date: Thu,  3 Jun 2010 00:47:41 -0500
Message-ID: <1275544073-20418-29-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44886 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932541Ab0FCF4W (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jun 2010 01:56:22 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Replace DSP_EDCDLOADBASE with EACCES

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dbdcd.h |    8 ++++----
 drivers/dsp/bridge/rmgr/dbdcd.c              |    4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbdcd.h b/arch/arm/plat-omap/include/dspbridge/dbdcd.h
index 17fb57a..b8daea9 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbdcd.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdcd.h
@@ -36,7 +36,7 @@
  *      0:                Success.
  *      -EACCES: Unable to find auto-registration section.
  *      DSP_EDCDREADSECT:       Unable to read object code section.
- *      DSP_EDCDLOADBASE:       Unable to load code base.
+ *      -EACCES:       Unable to load code base.
  *      -EFAULT:            Invalid DCD_HMANAGER handle..
  *  Requires:
  *      DCD initialized.
@@ -62,7 +62,7 @@ extern dsp_status dcd_auto_register(IN struct dcd_manager *hdcd_mgr,
  *      0:                Success.
  *      -EACCES: Unable to find auto-registration section.
  *      DSP_EDCDREADSECT:       Unable to read object code section.
- *      DSP_EDCDLOADBASE:       Unable to load code base.
+ *      -EACCES:       Unable to load code base.
  *      -EFAULT:            Invalid DCD_HMANAGER handle..
  *  Requires:
  *      DCD initialized.
@@ -258,7 +258,7 @@ extern dsp_status dcd_get_library_name(IN struct dcd_manager *hdcd_mgr,
  *      DSP_EDCDPARSESECT:  Unable to parse content of object code section.
  *      DSP_EDCDREADSECT:   Unable to read object code section.
  *      DSP_EDCDGETSECT:    Unable to access object code section.
- *      DSP_EDCDLOADBASE:   Unable to load code base.
+ *      -EACCES:   Unable to load code base.
  *      -EPERM:          General failure.
  *      -EFAULT:        Invalid DCD_HMANAGER handle.
  *  Requires:
@@ -291,7 +291,7 @@ extern dsp_status dcd_get_object_def(IN struct dcd_manager *hdcd_mgr,
  *      0:                Success.
  *      -EACCES: Unable to find .dcd_register section.
  *      DSP_EDCDREADSECT:       Unable to read object code section.
- *      DSP_EDCDLOADBASE:       Unable to load code base.
+ *      -EACCES:       Unable to load code base.
  *      -EFAULT:            Invalid DCD_HMANAGER handle..
  *  Requires:
  *      DCD initialized.
diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index dcca612..a2cda6b 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -467,7 +467,7 @@ dsp_status dcd_get_object_def(IN struct dcd_manager *hdcd_mgr,
 	status = cod_open(dcd_mgr_obj->cod_mgr, dcd_key->path,
 							COD_NOLOAD, &lib);
 	if (DSP_FAILED(status)) {
-		status = DSP_EDCDLOADBASE;
+		status = -EACCES;
 		goto func_end;
 	}
 
@@ -560,7 +560,7 @@ dsp_status dcd_get_objects(IN struct dcd_manager *hdcd_mgr,
 	/* Open DSP coff file, don't load symbols. */
 	status = cod_open(dcd_mgr_obj->cod_mgr, pszCoffPath, COD_NOLOAD, &lib);
 	if (DSP_FAILED(status)) {
-		status = DSP_EDCDLOADBASE;
+		status = -EACCES;
 		goto func_cont;
 	}
 
-- 
1.7.1

