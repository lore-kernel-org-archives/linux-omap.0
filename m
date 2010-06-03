From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 30/40] DSPBRIDGE: err code replace DSP_EDCDPARSESECT with EACCES
Date: Thu,  3 Jun 2010 00:47:43 -0500
Message-ID: <1275544073-20418-31-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37603 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754135Ab0FCF4U (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jun 2010 01:56:20 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Replace DSP_EDCDPARSESECT with EACCES

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dbdcd.h |    2 +-
 drivers/dsp/bridge/rmgr/dbdcd.c              |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbdcd.h b/arch/arm/plat-omap/include/dspbridge/dbdcd.h
index e615c8a..2a43d6e 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbdcd.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdcd.h
@@ -255,7 +255,7 @@ extern dsp_status dcd_get_library_name(IN struct dcd_manager *hdcd_mgr,
  *                          union of various possible DCD object types.
  *  Returns:
  *      0: Success.
- *      DSP_EDCDPARSESECT:  Unable to parse content of object code section.
+ *      -EACCES:  Unable to parse content of object code section.
  *      DSP_EDCDREADSECT:   Unable to read object code section.
  *      -EACCES:    Unable to access object code section.
  *      -EACCES:   Unable to load code base.
diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index a3d79ba..5592033 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -516,7 +516,7 @@ dsp_status dcd_get_object_def(IN struct dcd_manager *hdcd_mgr,
 		status =
 		    get_attrs_from_buf(psz_coff_buf, ul_len, obj_type, pObjDef);
 		if (DSP_FAILED(status))
-			status = DSP_EDCDPARSESECT;
+			status = -EACCES;
 	} else {
 		status = DSP_EDCDREADSECT;
 	}
-- 
1.7.1

