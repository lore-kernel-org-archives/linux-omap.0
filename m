From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 04/40] DSPBRIDGE: err code replace CHNL_E_NOEOS with EPERM
Date: Thu,  3 Jun 2010 00:47:17 -0500
Message-ID: <1275544073-20418-5-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56428 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753465Ab0FCF4Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jun 2010 01:56:16 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Replace CHNL_E_NOEOS with EPERM

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dspdefs.h |    2 +-
 drivers/dsp/bridge/core/chnl_sm.c              |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dspdefs.h b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
index 7157029..6dcea60 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
@@ -452,7 +452,7 @@ typedef dsp_status(*fxn_chnl_close) (struct chnl_object *chnl_obj);
  *      0:        Success;
  *      -EFAULT:    Invalid chnl_obj.
  *      -EFAULT:   pHostBuf is invalid.
- *      CHNL_E_NOEOS:   User cannot mark EOS on an input channel.
+ *      -EPERM:   User cannot mark EOS on an input channel.
  *      -ECANCELED: I/O has been cancelled on this channel.  No further
  *                      I/O is allowed.
  *      CHNL_E_EOS:     End of stream was already marked on a previous
diff --git a/drivers/dsp/bridge/core/chnl_sm.c b/drivers/dsp/bridge/core/chnl_sm.c
index a4946c2..99a4a42 100644
--- a/drivers/dsp/bridge/core/chnl_sm.c
+++ b/drivers/dsp/bridge/core/chnl_sm.c
@@ -113,7 +113,7 @@ dsp_status bridge_chnl_add_io_req(struct chnl_object *chnl_obj, void *pHostBuf,
 	} else if (!pchnl) {
 		status = -EFAULT;
 	} else if (is_eos && CHNL_IS_INPUT(pchnl->chnl_mode)) {
-		status = CHNL_E_NOEOS;
+		status = -EPERM;
 	} else {
 		/*
 		 * Check the channel state: only queue chirp if channel state
-- 
1.7.1

