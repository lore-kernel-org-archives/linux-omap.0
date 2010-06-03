From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 12/40] DSPBRIDGE: err code replace CHNL_E_EOS with EPIPE
Date: Thu,  3 Jun 2010 00:47:25 -0500
Message-ID: <1275544073-20418-13-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37597 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932501Ab0FCF4S (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jun 2010 01:56:18 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Replace CHNL_E_EOS with EPIPE

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dspdefs.h |    4 ++--
 drivers/dsp/bridge/core/chnl_sm.c              |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dspdefs.h b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
index 6a2bba5..58fcbcc 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
@@ -455,7 +455,7 @@ typedef dsp_status(*fxn_chnl_close) (struct chnl_object *chnl_obj);
  *      -EPERM:   User cannot mark EOS on an input channel.
  *      -ECANCELED: I/O has been cancelled on this channel.  No further
  *                      I/O is allowed.
- *      CHNL_E_EOS:     End of stream was already marked on a previous
+ *      -EPIPE:     End of stream was already marked on a previous
  *                      IORequest on this channel.  No further I/O is expected.
  *      -EINVAL: Buffer submitted to this output channel is larger than
  *                      the size of the physical shared memory output window.
@@ -466,7 +466,7 @@ typedef dsp_status(*fxn_chnl_close) (struct chnl_object *chnl_obj);
  *          ready.  In any case, notifications of I/O completion are
  *          asynchronous.
  *          If byte_size is 0 for an output channel, subsequent CHNL_AddIOReq's
- *          on this channel will fail with error code CHNL_E_EOS.  The
+ *          on this channel will fail with error code -EPIPE.  The
  *          corresponding IOC for this I/O request will have its status flag
  *          set to CHNL_IOCSTATEOS.
  */
diff --git a/drivers/dsp/bridge/core/chnl_sm.c b/drivers/dsp/bridge/core/chnl_sm.c
index 449b897..d162698 100644
--- a/drivers/dsp/bridge/core/chnl_sm.c
+++ b/drivers/dsp/bridge/core/chnl_sm.c
@@ -125,7 +125,7 @@ dsp_status bridge_chnl_add_io_req(struct chnl_object *chnl_obj, void *pHostBuf,
 				status = -ECANCELED;
 			else if ((dw_state & CHNL_STATEEOS) &&
 				 CHNL_IS_OUTPUT(pchnl->chnl_mode))
-				status = CHNL_E_EOS;
+				status = -EPIPE;
 			else
 				/* No other possible states left */
 				DBC_ASSERT(0);
-- 
1.7.1

