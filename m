From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC][PATCH 18/19] DSPBRIDGE: Cleanup custom error code
 (CHNL_E_CANCELLED -> ECANCELED)
Date: Fri, 26 Mar 2010 01:37:09 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DEBEB2E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42933 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754702Ab0CYUHS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 16:07:18 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>

>From ba0442c11ea834ad6b2323051c22c4964ad52a0b Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Wed, 24 Mar 2010 13:05:18 -0600
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code(CHNL_E_CANCELLED -> ECANCELED)

This patch replaces CHNL_E_CANCELLED with ECANCELED.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/errbase.h |    3 ---
 arch/arm/plat-omap/include/dspbridge/wmd.h     |    2 +-
 drivers/dsp/bridge/wmd/chnl_sm.c               |    2 +-
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index 51e9407..3524a33 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -300,9 +300,6 @@
  * queued. */
 #define CHNL_E_NOIOC                (CHNL_EBASE + 0x06)
 
-/* I/O has been cancelled on this channel. */
-#define CHNL_E_CANCELLED            (CHNL_EBASE + 0x07)
-
 /* End of stream was already requested on this output channel. */
 #define CHNL_E_EOS                  (CHNL_EBASE + 0x09)
 
diff --git a/arch/arm/plat-omap/include/dspbridge/wmd.h b/arch/arm/plat-omap/include/dspbridge/wmd.h
index d743063..7f339dd 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmd.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmd.h
@@ -453,7 +453,7 @@ typedef dsp_status(*fxn_chnl_close) (struct chnl_object *chnl_obj);
  *      EFAULT:    Invalid chnl_obj.
  *      EFAULT:   pHostBuf is invalid.
  *      CHNL_E_NOEOS:   User cannot mark EOS on an input channel.
- *      CHNL_E_CANCELLED: I/O has been cancelled on this channel.  No further
+ *      ECANCELED: I/O has been cancelled on this channel.  No further
  *                      I/O is allowed.
  *      CHNL_E_EOS:     End of stream was already marked on a previous
  *                      IORequest on this channel.  No further I/O is expected.
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index b926779..9c4dada 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -123,7 +123,7 @@ dsp_status bridge_chnl_add_io_req(struct chnl_object *chnl_obj, void *pHostBuf,
 		dw_state = pchnl->dw_state;
 		if (dw_state != CHNL_STATEREADY) {
 			if (dw_state & CHNL_STATECANCEL)
-				status = CHNL_E_CANCELLED;
+				status = ECANCELED;
 			else if ((dw_state & CHNL_STATEEOS) &&
 				 CHNL_IS_OUTPUT(pchnl->chnl_mode))
 				status = CHNL_E_EOS;
-- 
1.6.0.4

