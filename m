From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC][PATCH 17/19] DSPBRIDGE: Cleanup custom error code
 (CHNL_E_CHANBUSY -> EALREADY)
Date: Fri, 26 Mar 2010 01:37:06 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DEBEB2D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37045 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754702Ab0CYUHY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 16:07:24 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>, "Menon, Nishanth" <nm@ti.com>

>From c1e9ac00a68f40da3712b3a907a3b46e23df923e Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Wed, 24 Mar 2010 13:00:15 -0600
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code (CHNL_E_CHANBUSY -> EALREADY).

This patch replaces CHNL_E_CHANBUSY with EALREADY.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/errbase.h |    3 ---
 arch/arm/plat-omap/include/dspbridge/wmd.h     |    2 +-
 drivers/dsp/bridge/rmgr/strm.c                 |    2 +-
 drivers/dsp/bridge/wmd/chnl_sm.c               |    2 +-
 4 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index e564284..51e9407 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -293,9 +293,6 @@
 /* Channel ID is out of range. */
 #define CHNL_E_BADCHANID            (CHNL_EBASE + 0x03)
 
-/* Channel is already in use. */
-#define CHNL_E_CHANBUSY             (CHNL_EBASE + 0x04)
-
 /* Invalid channel mode argument. */
 #define CHNL_E_BADMODE              (CHNL_EBASE + 0x05)
 
diff --git a/arch/arm/plat-omap/include/dspbridge/wmd.h b/arch/arm/plat-omap/include/dspbridge/wmd.h
index 0cee536..d743063 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmd.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmd.h
@@ -394,7 +394,7 @@ typedef void (*fxn_deh_notify) (struct deh_mgr *hdeh_mgr,
  *      EINVAL:        Invalid number of IOReqs.
  *      CHNL_E_OUTOFSTREAMS:    No free channels available.
  *      CHNL_E_BADCHANID:       Channel ID is out of range.
- *      CHNL_E_CHANBUSY:        Channel is in use.
+ *      EALREADY:        Channel is in use.
  *      CHNL_E_NOIORPS:         No free IO request packets available for
  *                              queuing.
  *  Requires:
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index 274d387..003df3d 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -596,7 +596,7 @@ func_cont:
 				 */
 				DBC_ASSERT(status == CHNL_E_OUTOFSTREAMS ||
 					   status == CHNL_E_BADCHANID ||
-					   status == CHNL_E_CHANBUSY ||
+					   status == EALREADY ||
 					   status == CHNL_E_NOIORPS);
 				status = DSP_EFAIL;
 			}
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index 7bcaaac..b926779 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -811,7 +811,7 @@ dsp_status bridge_chnl_open(OUT struct chnl_object **phChnl,
 					status = CHNL_E_BADCHANID;
 				else if (chnl_mgr_obj->ap_channel[uChnlId] !=
 					 NULL)
-					status = CHNL_E_CHANBUSY;
+					status = EALREADY;
 			} else {
 				/* Check for free channel */
 				status =
-- 
1.6.0.4

