From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 14/40] DSPBRIDGE: err code replace CHNL_E_BADCHANID with ECHRNG
Date: Thu,  3 Jun 2010 00:47:27 -0500
Message-ID: <1275544073-20418-15-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37595 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753034Ab0FCF4R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jun 2010 01:56:17 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Replace CHNL_E_BADCHANID with ECHRNG

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dspdefs.h |    4 ++--
 drivers/dsp/bridge/core/chnl_sm.c              |    4 ++--
 drivers/dsp/bridge/rmgr/strm.c                 |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dspdefs.h b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
index b268c5e..c4b0922 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
@@ -393,7 +393,7 @@ typedef void (*fxn_deh_notify) (struct deh_mgr *hdeh_mgr,
  *      -ENOMEM:            Insufficient memory for requested resources.
  *      -EINVAL:        Invalid number of IOReqs.
  *      CHNL_E_OUTOFSTREAMS:    No free channels available.
- *      CHNL_E_BADCHANID:       Channel ID is out of range.
+ *      -ECHRNG:       Channel ID is out of range.
  *      -EALREADY:        Channel is in use.
  *      -EIO:         No free IO request packets available for
  *                              queuing.
@@ -577,7 +577,7 @@ typedef dsp_status(*fxn_chnl_getinfo) (struct chnl_object *chnl_obj,
  *      0:            Success;
  *      -EFAULT:        Invalid hchnl_mgr.
  *      -EFAULT:       pMgrInfo == NULL.
- *      CHNL_E_BADCHANID:   Invalid channel ID.
+ *      -ECHRNG:   Invalid channel ID.
  *  Requires:
  *  Ensures:
  *      0:            pMgrInfo points to a filled in chnl_mgrinfo
diff --git a/drivers/dsp/bridge/core/chnl_sm.c b/drivers/dsp/bridge/core/chnl_sm.c
index 806f0c9..db03db6 100644
--- a/drivers/dsp/bridge/core/chnl_sm.c
+++ b/drivers/dsp/bridge/core/chnl_sm.c
@@ -736,7 +736,7 @@ dsp_status bridge_chnl_get_mgr_info(struct chnl_mgr *hchnl_mgr, u32 uChnlID,
 				status = -EFAULT;
 			}
 		} else {
-			status = CHNL_E_BADCHANID;
+			status = -ECHRNG;
 		}
 	} else {
 		status = -EFAULT;
@@ -801,7 +801,7 @@ dsp_status bridge_chnl_open(OUT struct chnl_object **phChnl,
 		} else {
 			if (uChnlId != CHNL_PICKFREE) {
 				if (uChnlId >= chnl_mgr_obj->max_channels)
-					status = CHNL_E_BADCHANID;
+					status = -ECHRNG;
 				else if (chnl_mgr_obj->ap_channel[uChnlId] !=
 					 NULL)
 					status = -EALREADY;
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index accfb7b..c31a5c1 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -585,7 +585,7 @@ func_cont:
 				 * assert here), and then return -EPERM.
 				 */
 				DBC_ASSERT(status == CHNL_E_OUTOFSTREAMS ||
-					   status == CHNL_E_BADCHANID ||
+					   status == -ECHRNG ||
 					   status == -EALREADY ||
 					   status == -EIO);
 				status = -EPERM;
-- 
1.7.1

