From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC][PATCH v1 17/19] DSPBRIDGE: Cleanup custom error code
 (CHNL_E_CHANBUSY -> -EALREADY)
Date: Sat, 27 Mar 2010 07:59:03 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DEBEE17@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52131 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752958Ab0C0C3I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Mar 2010 22:29:08 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2R2T5Oc011941
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 26 Mar 2010 21:29:08 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o2R2T5jO026695
	for <linux-omap@vger.kernel.org>; Sat, 27 Mar 2010 07:59:05 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 98871a2583479220d285a9115043debc4e4e8369 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Wed, 24 Mar 2010 13:00:15 -0600
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code (CHNL_E_CHANBUSY -> -EALREADY)

This patch replaces CHNL_E_CHANBUSY with -EALREADY.

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
index 339acfd..e368bbc 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmd.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmd.h
@@ -394,7 +394,7 @@ typedef void (*fxn_deh_notify) (struct deh_mgr *hdeh_mgr,
  *      -EINVAL:        Invalid number of IOReqs.
  *      CHNL_E_OUTOFSTREAMS:    No free channels available.
  *      CHNL_E_BADCHANID:       Channel ID is out of range.
- *      CHNL_E_CHANBUSY:        Channel is in use.
+ *      -EALREADY:        Channel is in use.
  *      CHNL_E_NOIORPS:         No free IO request packets available for
  *                              queuing.
  *  Requires:
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index b78360f..45a15b4 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -596,7 +596,7 @@ func_cont:
 				 */
 				DBC_ASSERT(status == CHNL_E_OUTOFSTREAMS ||
 					   status == CHNL_E_BADCHANID ||
-					   status == CHNL_E_CHANBUSY ||
+					   status == -EALREADY ||
 					   status == CHNL_E_NOIORPS);
 				status = DSP_EFAIL;
 			}
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index 63ffc34..d3e59d3 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -811,7 +811,7 @@ dsp_status bridge_chnl_open(OUT struct chnl_object **phChnl,
 					status = CHNL_E_BADCHANID;
 				else if (chnl_mgr_obj->ap_channel[uChnlId] !=
 					 NULL)
-					status = CHNL_E_CHANBUSY;
+					status = -EALREADY;
 			} else {
 				/* Check for free channel */
 				status =
-- 
1.6.0.4

