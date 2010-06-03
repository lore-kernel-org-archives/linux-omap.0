From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 11/40] DSPBRIDGE: err code replace CHNL_E_INVALIDWORDSIZE with EINVAL
Date: Thu,  3 Jun 2010 00:47:24 -0500
Message-ID: <1275544073-20418-12-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44863 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753187Ab0FCF4Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jun 2010 01:56:16 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Replace CHNL_E_INVALIDWORDSIZE with EINVAL

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/chnl.h |    2 +-
 arch/arm/plat-omap/include/dspbridge/io.h   |    2 +-
 drivers/dsp/bridge/pmgr/chnl.c              |    2 +-
 drivers/dsp/bridge/pmgr/io.c                |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/chnl.h b/arch/arm/plat-omap/include/dspbridge/chnl.h
index 98336a0..7c06869 100644
--- a/arch/arm/plat-omap/include/dspbridge/chnl.h
+++ b/arch/arm/plat-omap/include/dspbridge/chnl.h
@@ -66,7 +66,7 @@ extern dsp_status chnl_close(struct chnl_object *chnl_obj);
  *      -EIO:             Unable to plug channel ISR for configured IRQ.
  *      CHNL_E_MAXCHANNELS:     This manager cannot handle this many channels.
  *      CHNL_E_INVALIDIRQ:      Invalid IRQ number. Must be 0 <= birq <= 15.
- *      CHNL_E_INVALIDWORDSIZE: Invalid DSP word size.  Must be > 0.
+ *      -EINVAL: Invalid DSP word size.  Must be > 0.
  *      -EINVAL:  Invalid base address for DSP communications.
  *      -EEXIST:       Channel manager already exists for this device.
  *  Requires:
diff --git a/arch/arm/plat-omap/include/dspbridge/io.h b/arch/arm/plat-omap/include/dspbridge/io.h
index e491a50..752786f 100644
--- a/arch/arm/plat-omap/include/dspbridge/io.h
+++ b/arch/arm/plat-omap/include/dspbridge/io.h
@@ -42,7 +42,7 @@
  *      -ENOMEM:            Insufficient memory for requested resources.
  *      -EIO:             Unable to plug channel ISR for configured IRQ.
  *      CHNL_E_INVALIDIRQ:      Invalid IRQ number. Must be 0 <= birq <= 15.
- *      CHNL_E_INVALIDWORDSIZE: Invalid DSP word size.  Must be > 0.
+ *      -EINVAL: Invalid DSP word size.  Must be > 0.
  *      -EINVAL:  Invalid base address for DSP communications.
  *  Requires:
  *      io_init(void) called.
diff --git a/drivers/dsp/bridge/pmgr/chnl.c b/drivers/dsp/bridge/pmgr/chnl.c
index 5bf1c66..50d49eb 100644
--- a/drivers/dsp/bridge/pmgr/chnl.c
+++ b/drivers/dsp/bridge/pmgr/chnl.c
@@ -76,7 +76,7 @@ dsp_status chnl_create(OUT struct chnl_mgr **phChnlMgr,
 		status = CHNL_E_MAXCHANNELS;
 
 	if (pMgrAttrs->word_size == 0)
-		status = CHNL_E_INVALIDWORDSIZE;
+		status = -EINVAL;
 
 	if (DSP_SUCCEEDED(status)) {
 		status = dev_get_chnl_mgr(hdev_obj, &hchnl_mgr);
diff --git a/drivers/dsp/bridge/pmgr/io.c b/drivers/dsp/bridge/pmgr/io.c
index e544dee..de46cde 100644
--- a/drivers/dsp/bridge/pmgr/io.c
+++ b/drivers/dsp/bridge/pmgr/io.c
@@ -66,7 +66,7 @@ dsp_status io_create(OUT struct io_mgr **phIOMgr, struct dev_object *hdev_obj,
 		status = -EINVAL;
 
 	if (pMgrAttrs->word_size == 0)
-		status = CHNL_E_INVALIDWORDSIZE;
+		status = -EINVAL;
 
 	if (DSP_SUCCEEDED(status)) {
 		dev_get_intf_fxns(hdev_obj, &intf_fxns);
-- 
1.7.1

