From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 13/40] DSPBRIDGE: err code replace CHNL_E_NOIOC with EREMOTEIO
Date: Thu,  3 Jun 2010 00:47:26 -0500
Message-ID: <1275544073-20418-14-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37592 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753501Ab0FCF4Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jun 2010 01:56:16 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Replace CHNL_E_NOIOC with EREMOTEIO

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dspdefs.h |    2 +-
 drivers/dsp/bridge/core/chnl_sm.c              |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dspdefs.h b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
index 58fcbcc..b268c5e 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
@@ -493,7 +493,7 @@ typedef dsp_status(*fxn_chnl_addioreq) (struct chnl_object
  *      0:        Success.
  *      -EFAULT:    Invalid chnl_obj.
  *      -EFAULT:   pIOC is invalid.
- *      CHNL_E_NOIOC:   CHNL_IOCNOWAIT was specified as the dwTimeOut parameter
+ *      -EREMOTEIO:   CHNL_IOCNOWAIT was specified as the dwTimeOut parameter
  *                      yet no I/O completions were queued.
  *  Requires:
  *      dwTimeOut == CHNL_IOCNOWAIT.
diff --git a/drivers/dsp/bridge/core/chnl_sm.c b/drivers/dsp/bridge/core/chnl_sm.c
index d162698..806f0c9 100644
--- a/drivers/dsp/bridge/core/chnl_sm.c
+++ b/drivers/dsp/bridge/core/chnl_sm.c
@@ -589,7 +589,7 @@ dsp_status bridge_chnl_get_ioc(struct chnl_object *chnl_obj, u32 dwTimeOut,
 		status = -EFAULT;
 	} else if (dwTimeOut == CHNL_IOCNOWAIT) {
 		if (LST_IS_EMPTY(pchnl->pio_completions))
-			status = CHNL_E_NOIOC;
+			status = -EREMOTEIO;
 
 	}
 
-- 
1.7.1

