From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 16/40] DSPBRIDGE: err code replace CHNL_E_MAXCHANNELS with ECHRNG
Date: Thu,  3 Jun 2010 00:47:29 -0500
Message-ID: <1275544073-20418-17-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56433 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753072Ab0FCF4T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jun 2010 01:56:19 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Replace CHNL_E_MAXCHANNELS with ECHRNG

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/chnl.h |    2 +-
 drivers/dsp/bridge/pmgr/chnl.c              |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/chnl.h b/arch/arm/plat-omap/include/dspbridge/chnl.h
index 7c06869..ff3ed51 100644
--- a/arch/arm/plat-omap/include/dspbridge/chnl.h
+++ b/arch/arm/plat-omap/include/dspbridge/chnl.h
@@ -64,7 +64,7 @@ extern dsp_status chnl_close(struct chnl_object *chnl_obj);
  *      -EINVAL:        max_channels is 0.
  *      -ENOMEM:            Insufficient memory for requested resources.
  *      -EIO:             Unable to plug channel ISR for configured IRQ.
- *      CHNL_E_MAXCHANNELS:     This manager cannot handle this many channels.
+ *      -ECHRNG:     This manager cannot handle this many channels.
  *      CHNL_E_INVALIDIRQ:      Invalid IRQ number. Must be 0 <= birq <= 15.
  *      -EINVAL: Invalid DSP word size.  Must be > 0.
  *      -EINVAL:  Invalid base address for DSP communications.
diff --git a/drivers/dsp/bridge/pmgr/chnl.c b/drivers/dsp/bridge/pmgr/chnl.c
index 50d49eb..22087f2 100644
--- a/drivers/dsp/bridge/pmgr/chnl.c
+++ b/drivers/dsp/bridge/pmgr/chnl.c
@@ -73,7 +73,7 @@ dsp_status chnl_create(OUT struct chnl_mgr **phChnlMgr,
 	else if (pMgrAttrs->max_channels == 0)
 		status = -EINVAL;
 	else
-		status = CHNL_E_MAXCHANNELS;
+		status = -ECHRNG;
 
 	if (pMgrAttrs->word_size == 0)
 		status = -EINVAL;
-- 
1.7.1

