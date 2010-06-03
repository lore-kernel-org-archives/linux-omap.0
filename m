From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 07/40] DSPBRIDGE: err code replace CHNL_E_ISR with EIO
Date: Thu,  3 Jun 2010 00:47:20 -0500
Message-ID: <1275544073-20418-8-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37594 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753712Ab0FCF4Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jun 2010 01:56:16 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Replace CHNL_E_ISR with EIO

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/chnl.h    |    2 +-
 arch/arm/plat-omap/include/dspbridge/dspdefs.h |    2 +-
 arch/arm/plat-omap/include/dspbridge/io.h      |    2 +-
 drivers/dsp/bridge/core/io_sm.c                |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/chnl.h b/arch/arm/plat-omap/include/dspbridge/chnl.h
index 8761fcf..b97cced 100644
--- a/arch/arm/plat-omap/include/dspbridge/chnl.h
+++ b/arch/arm/plat-omap/include/dspbridge/chnl.h
@@ -63,7 +63,7 @@ extern dsp_status chnl_close(struct chnl_object *chnl_obj);
  *      -EFAULT:            hdev_obj is invalid.
  *      -EINVAL:        max_channels is 0.
  *      -ENOMEM:            Insufficient memory for requested resources.
- *      CHNL_E_ISR:             Unable to plug channel ISR for configured IRQ.
+ *      -EIO:             Unable to plug channel ISR for configured IRQ.
  *      CHNL_E_MAXCHANNELS:     This manager cannot handle this many channels.
  *      CHNL_E_INVALIDIRQ:      Invalid IRQ number. Must be 0 <= birq <= 15.
  *      CHNL_E_INVALIDWORDSIZE: Invalid DSP word size.  Must be > 0.
diff --git a/arch/arm/plat-omap/include/dspbridge/dspdefs.h b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
index ff352ce..f56fdca 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
@@ -309,7 +309,7 @@ typedef dsp_status(*fxn_brd_write) (struct bridge_dev_context *hDevContext,
  *  Returns:
  *      0:            Success;
  *      -ENOMEM:        Insufficient memory for requested resources.
- *      CHNL_E_ISR:         Unable to plug ISR for given IRQ.
+ *      -EIO:         Unable to plug ISR for given IRQ.
  *      CHNL_E_NOMEMMAP:    Couldn't map physical address to a virtual one.
  *  Requires:
  *      phChnlMgr != NULL.
diff --git a/arch/arm/plat-omap/include/dspbridge/io.h b/arch/arm/plat-omap/include/dspbridge/io.h
index 197628f..f880b80 100644
--- a/arch/arm/plat-omap/include/dspbridge/io.h
+++ b/arch/arm/plat-omap/include/dspbridge/io.h
@@ -40,7 +40,7 @@
  *  Returns:
  *      0:                Success;
  *      -ENOMEM:            Insufficient memory for requested resources.
- *      CHNL_E_ISR:             Unable to plug channel ISR for configured IRQ.
+ *      -EIO:             Unable to plug channel ISR for configured IRQ.
  *      CHNL_E_INVALIDIRQ:      Invalid IRQ number. Must be 0 <= birq <= 15.
  *      CHNL_E_INVALIDWORDSIZE: Invalid DSP word size.  Must be > 0.
  *      CHNL_E_INVALIDMEMBASE:  Invalid base address for DSP communications.
diff --git a/drivers/dsp/bridge/core/io_sm.c b/drivers/dsp/bridge/core/io_sm.c
index 7246c22..5902d8a 100644
--- a/drivers/dsp/bridge/core/io_sm.c
+++ b/drivers/dsp/bridge/core/io_sm.c
@@ -236,7 +236,7 @@ dsp_status bridge_io_create(OUT struct io_mgr **phIOMgr,
 		if (dsp_wdt_init())
 			status = -EPERM;
 	} else {
-		status = CHNL_E_ISR;
+		status = -EIO;
 	}
 func_end:
 	if (DSP_FAILED(status)) {
-- 
1.7.1

