From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 10/40] DSPBRIDGE: err code replace CHNL_E_INVALIDMEMBASE with EINVAL
Date: Thu,  3 Jun 2010 00:47:23 -0500
Message-ID: <1275544073-20418-11-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39714 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072Ab0FCF4Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 01:56:16 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Replace CHNL_E_INVALIDMEMBASE with EINVAL

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/chnl.h |    2 +-
 arch/arm/plat-omap/include/dspbridge/io.h   |    2 +-
 drivers/dsp/bridge/core/io_sm.c             |    4 ++--
 drivers/dsp/bridge/pmgr/io.c                |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/chnl.h b/arch/arm/plat-omap/include/dspbridge/chnl.h
index 04856c2..98336a0 100644
--- a/arch/arm/plat-omap/include/dspbridge/chnl.h
+++ b/arch/arm/plat-omap/include/dspbridge/chnl.h
@@ -67,7 +67,7 @@ extern dsp_status chnl_close(struct chnl_object *chnl_obj);
  *      CHNL_E_MAXCHANNELS:     This manager cannot handle this many channels.
  *      CHNL_E_INVALIDIRQ:      Invalid IRQ number. Must be 0 <= birq <= 15.
  *      CHNL_E_INVALIDWORDSIZE: Invalid DSP word size.  Must be > 0.
- *      CHNL_E_INVALIDMEMBASE:  Invalid base address for DSP communications.
+ *      -EINVAL:  Invalid base address for DSP communications.
  *      -EEXIST:       Channel manager already exists for this device.
  *  Requires:
  *      chnl_init(void) called.
diff --git a/arch/arm/plat-omap/include/dspbridge/io.h b/arch/arm/plat-omap/include/dspbridge/io.h
index f880b80..e491a50 100644
--- a/arch/arm/plat-omap/include/dspbridge/io.h
+++ b/arch/arm/plat-omap/include/dspbridge/io.h
@@ -43,7 +43,7 @@
  *      -EIO:             Unable to plug channel ISR for configured IRQ.
  *      CHNL_E_INVALIDIRQ:      Invalid IRQ number. Must be 0 <= birq <= 15.
  *      CHNL_E_INVALIDWORDSIZE: Invalid DSP word size.  Must be > 0.
- *      CHNL_E_INVALIDMEMBASE:  Invalid base address for DSP communications.
+ *      -EINVAL:  Invalid base address for DSP communications.
  *  Requires:
  *      io_init(void) called.
  *      phIOMgr != NULL.
diff --git a/drivers/dsp/bridge/core/io_sm.c b/drivers/dsp/bridge/core/io_sm.c
index 79baa2c..72245d8 100644
--- a/drivers/dsp/bridge/core/io_sm.c
+++ b/drivers/dsp/bridge/core/io_sm.c
@@ -363,7 +363,7 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
 		goto func_end;
 	}
 	if (ul_shm_limit <= ul_shm_base) {
-		status = CHNL_E_INVALIDMEMBASE;
+		status = -EINVAL;
 		goto func_end;
 	}
 	/* Get total length in bytes */
@@ -382,7 +382,7 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
 					   &ul_msg_limit);
 		if (DSP_SUCCEEDED(status)) {
 			if (ul_msg_limit <= ul_msg_base) {
-				status = CHNL_E_INVALIDMEMBASE;
+				status = -EINVAL;
 			} else {
 				/*
 				 * Length (bytes) of messaging part of shared
diff --git a/drivers/dsp/bridge/pmgr/io.c b/drivers/dsp/bridge/pmgr/io.c
index c0897c6..e544dee 100644
--- a/drivers/dsp/bridge/pmgr/io.c
+++ b/drivers/dsp/bridge/pmgr/io.c
@@ -63,7 +63,7 @@ dsp_status io_create(OUT struct io_mgr **phIOMgr, struct dev_object *hdev_obj,
 
 	/* A memory base of 0 implies no memory base: */
 	if ((pMgrAttrs->shm_base != 0) && (pMgrAttrs->usm_length == 0))
-		status = CHNL_E_INVALIDMEMBASE;
+		status = -EINVAL;
 
 	if (pMgrAttrs->word_size == 0)
 		status = CHNL_E_INVALIDWORDSIZE;
-- 
1.7.1

