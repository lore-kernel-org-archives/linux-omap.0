From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 03/40] DSPBRIDGE: err code replace CHNL_E_WAITTIMEOUT with ETIMEDOUT
Date: Thu,  3 Jun 2010 00:47:16 -0500
Message-ID: <1275544073-20418-4-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56422 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752806Ab0FCF4O (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jun 2010 01:56:14 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Replace CHNL_E_WAITTIMEOUT with ETIMEDOUT

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dspdefs.h |    2 +-
 drivers/dsp/bridge/core/chnl_sm.c              |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dspdefs.h b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
index 8ee21fd..7157029 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
@@ -610,7 +610,7 @@ typedef dsp_status(*fxn_chnl_getmgrinfo) (struct chnl_mgr
  *  Returns:
  *      0:            Success;
  *      -EFAULT:        Invalid chnl_obj.
- *      CHNL_E_WAITTIMEOUT: Timeout occured before channel could be idled.
+ *      -ETIMEDOUT: Timeout occured before channel could be idled.
  *  Requires:
  *  Ensures:
  */
diff --git a/drivers/dsp/bridge/core/chnl_sm.c b/drivers/dsp/bridge/core/chnl_sm.c
index 81106df..a4946c2 100644
--- a/drivers/dsp/bridge/core/chnl_sm.c
+++ b/drivers/dsp/bridge/core/chnl_sm.c
@@ -517,7 +517,7 @@ dsp_status bridge_chnl_flush_io(struct chnl_object *chnl_obj, u32 dwTimeOut)
 					continue;
 
 				if (chnl_ioc_obj.status & CHNL_IOCSTATTIMEOUT)
-					status = CHNL_E_WAITTIMEOUT;
+					status = -ETIMEDOUT;
 
 			}
 		} else {
-- 
1.7.1

