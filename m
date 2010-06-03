From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 02/40] DSPBRIDGE: change DSP_SENUMCOMPLETE for ENODATA
Date: Thu,  3 Jun 2010 00:47:15 -0500
Message-ID: <1275544073-20418-3-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37591 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753175Ab0FCF4Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jun 2010 01:56:16 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

This is not an error code, however the way it is coded
it doesn't expects a success (zero) either, return a positive
number on this case given that this is not an error code.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dbdcd.h |    2 +-
 drivers/dsp/bridge/rmgr/dbdcd.c              |    6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbdcd.h b/arch/arm/plat-omap/include/dspbridge/dbdcd.h
index 3bf3b4d..f7e4e79 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbdcd.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdcd.h
@@ -123,7 +123,7 @@ extern dsp_status dcd_destroy_manager(IN struct dcd_manager *hdcd_mgr);
  *  Returns:
  *      0:            Success.
  *      -EPERM:          Unable to enumerate through the DCD database.
- *      DSP_SENUMCOMPLETE:  Enumeration completed. This is not an error code.
+ *      ENODATA:  Enumeration completed. This is not an error code.
  *  Requires:
  *      DCD initialized.
  *      uuid_obj is a valid pointer.
diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index e0417a2..1731334 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -286,7 +286,11 @@ dsp_status dcd_enumerate_object(IN s32 cIndex, IN enum dsp_dcdobjtype obj_type,
 			/* At the end of enumeration. Reset enum_refs. */
 			enum_refs = 0;
 
-			status = DSP_SENUMCOMPLETE;
+			/*
+			 * TODO: Revisit, this is not an errror case but code
+			 * expects non-zero value.
+			 */
+			status = ENODATA;
 		} else {
 			status = -EPERM;
 		}
-- 
1.7.1

