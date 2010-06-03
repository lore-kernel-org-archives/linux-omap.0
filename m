From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 29/40] DSPBRIDGE: err code replace DSP_EDCDGETSECT with EACCES
Date: Thu,  3 Jun 2010 00:47:42 -0500
Message-ID: <1275544073-20418-30-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44885 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932538Ab0FCF4W (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jun 2010 01:56:22 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Replace DSP_EDCDGETSECT with EACCES

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dbdcd.h |    2 +-
 drivers/dsp/bridge/rmgr/dbdcd.c              |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbdcd.h b/arch/arm/plat-omap/include/dspbridge/dbdcd.h
index b8daea9..e615c8a 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbdcd.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdcd.h
@@ -257,7 +257,7 @@ extern dsp_status dcd_get_library_name(IN struct dcd_manager *hdcd_mgr,
  *      0: Success.
  *      DSP_EDCDPARSESECT:  Unable to parse content of object code section.
  *      DSP_EDCDREADSECT:   Unable to read object code section.
- *      DSP_EDCDGETSECT:    Unable to access object code section.
+ *      -EACCES:    Unable to access object code section.
  *      -EACCES:   Unable to load code base.
  *      -EPERM:          General failure.
  *      -EFAULT:        Invalid DCD_HMANAGER handle.
diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index a2cda6b..a3d79ba 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -483,7 +483,7 @@ dsp_status dcd_get_object_def(IN struct dcd_manager *hdcd_mgr,
 	/* Get section information. */
 	status = cod_get_section(lib, sz_sect_name, &ul_addr, &ul_len);
 	if (DSP_FAILED(status)) {
-		status = DSP_EDCDGETSECT;
+		status = -EACCES;
 		goto func_end;
 	}
 
-- 
1.7.1

