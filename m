From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 08/40] DSPBRIDGE: err code replace CHNL_E_MGREXISTS with EEXIST
Date: Thu,  3 Jun 2010 00:47:21 -0500
Message-ID: <1275544073-20418-9-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39715 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932299Ab0FCF4R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 01:56:17 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Replace CHNL_E_MGREXISTS with EEXIST

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/chnl.h |    2 +-
 drivers/dsp/bridge/pmgr/chnl.c              |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/chnl.h b/arch/arm/plat-omap/include/dspbridge/chnl.h
index b97cced..04856c2 100644
--- a/arch/arm/plat-omap/include/dspbridge/chnl.h
+++ b/arch/arm/plat-omap/include/dspbridge/chnl.h
@@ -68,7 +68,7 @@ extern dsp_status chnl_close(struct chnl_object *chnl_obj);
  *      CHNL_E_INVALIDIRQ:      Invalid IRQ number. Must be 0 <= birq <= 15.
  *      CHNL_E_INVALIDWORDSIZE: Invalid DSP word size.  Must be > 0.
  *      CHNL_E_INVALIDMEMBASE:  Invalid base address for DSP communications.
- *      CHNL_E_MGREXISTS:       Channel manager already exists for this device.
+ *      -EEXIST:       Channel manager already exists for this device.
  *  Requires:
  *      chnl_init(void) called.
  *      phChnlMgr != NULL.
diff --git a/drivers/dsp/bridge/pmgr/chnl.c b/drivers/dsp/bridge/pmgr/chnl.c
index 1c9cc5e..5bf1c66 100644
--- a/drivers/dsp/bridge/pmgr/chnl.c
+++ b/drivers/dsp/bridge/pmgr/chnl.c
@@ -81,7 +81,7 @@ dsp_status chnl_create(OUT struct chnl_mgr **phChnlMgr,
 	if (DSP_SUCCEEDED(status)) {
 		status = dev_get_chnl_mgr(hdev_obj, &hchnl_mgr);
 		if (DSP_SUCCEEDED(status) && hchnl_mgr != NULL)
-			status = CHNL_E_MGREXISTS;
+			status = -EEXIST;
 
 	}
 
-- 
1.7.1

