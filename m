From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 31/40] DSPBRIDGE: err code replace DSP_EDCDREADSECT with EACCES
Date: Thu,  3 Jun 2010 00:47:44 -0500
Message-ID: <1275544073-20418-32-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56436 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754120Ab0FCF4U (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jun 2010 01:56:20 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Replace DSP_EDCDREADSECT with EACCES

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dbdcd.h |   12 ++++++------
 drivers/dsp/bridge/rmgr/dbdcd.c              |    4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbdcd.h b/arch/arm/plat-omap/include/dspbridge/dbdcd.h
index 2a43d6e..a879d6b 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbdcd.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdcd.h
@@ -35,7 +35,7 @@
  *  Returns:
  *      0:                Success.
  *      -EACCES: Unable to find auto-registration section.
- *      DSP_EDCDREADSECT:       Unable to read object code section.
+ *      -EACCES:       Unable to read object code section.
  *      -EACCES:       Unable to load code base.
  *      -EFAULT:            Invalid DCD_HMANAGER handle..
  *  Requires:
@@ -61,7 +61,7 @@ extern dsp_status dcd_auto_register(IN struct dcd_manager *hdcd_mgr,
  *  Returns:
  *      0:                Success.
  *      -EACCES: Unable to find auto-registration section.
- *      DSP_EDCDREADSECT:       Unable to read object code section.
+ *      -EACCES:       Unable to read object code section.
  *      -EACCES:       Unable to load code base.
  *      -EFAULT:            Invalid DCD_HMANAGER handle..
  *  Requires:
@@ -164,7 +164,7 @@ extern void dcd_exit(void);
  *  Returns:
  *      0: Success.
  *      -ENOMEM: Memory allocation failure.
- *      DSP_EDCDREADSECT: Failure to read section containing library info.
+ *      -EACCES: Failure to read section containing library info.
  *      -EPERM: General failure.
  *  Requires:
  *      DCD initialized.
@@ -194,7 +194,7 @@ extern dsp_status dcd_get_dep_libs(IN struct dcd_manager *hdcd_mgr,
  *  Returns:
  *      0: Success.
  *      -ENOMEM: Memory allocation failure.
- *      DSP_EDCDREADSECT: Failure to read section containing library info.
+ *      -EACCES: Failure to read section containing library info.
  *      -EPERM: General failure.
  *  Requires:
  *      DCD initialized.
@@ -256,7 +256,7 @@ extern dsp_status dcd_get_library_name(IN struct dcd_manager *hdcd_mgr,
  *  Returns:
  *      0: Success.
  *      -EACCES:  Unable to parse content of object code section.
- *      DSP_EDCDREADSECT:   Unable to read object code section.
+ *      -EACCES:   Unable to read object code section.
  *      -EACCES:    Unable to access object code section.
  *      -EACCES:   Unable to load code base.
  *      -EPERM:          General failure.
@@ -290,7 +290,7 @@ extern dsp_status dcd_get_object_def(IN struct dcd_manager *hdcd_mgr,
  *  Returns:
  *      0:                Success.
  *      -EACCES: Unable to find .dcd_register section.
- *      DSP_EDCDREADSECT:       Unable to read object code section.
+ *      -EACCES:       Unable to read object code section.
  *      -EACCES:       Unable to load code base.
  *      -EFAULT:            Invalid DCD_HMANAGER handle..
  *  Requires:
diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index 5592033..c9dba67 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -518,7 +518,7 @@ dsp_status dcd_get_object_def(IN struct dcd_manager *hdcd_mgr,
 		if (DSP_FAILED(status))
 			status = -EACCES;
 	} else {
-		status = DSP_EDCDREADSECT;
+		status = -EACCES;
 	}
 
 	/* Free the previously allocated dynamic buffer. */
@@ -625,7 +625,7 @@ dsp_status dcd_get_objects(IN struct dcd_manager *hdcd_mgr,
 			}
 		}
 	} else {
-		status = DSP_EDCDREADSECT;
+		status = -EACCES;
 	}
 
 	/* Free the previously allocated dynamic buffer. */
-- 
1.7.1

