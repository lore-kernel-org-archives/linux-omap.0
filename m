From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 15/40] DSPBRIDGE: err code replace CHNL_E_OUTOFSTREAMS with ENOSR
Date: Thu,  3 Jun 2010 00:47:28 -0500
Message-ID: <1275544073-20418-16-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44874 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753046Ab0FCF4T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jun 2010 01:56:19 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Replace CHNL_E_OUTOFSTREAMS with ENOSR

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dspdefs.h |    2 +-
 drivers/dsp/bridge/core/chnl_sm.c              |    2 +-
 drivers/dsp/bridge/rmgr/strm.c                 |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dspdefs.h b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
index c4b0922..c3c2e4d 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
@@ -392,7 +392,7 @@ typedef void (*fxn_deh_notify) (struct deh_mgr *hdeh_mgr,
  *      -EFAULT:            hchnl_mgr is invalid.
  *      -ENOMEM:            Insufficient memory for requested resources.
  *      -EINVAL:        Invalid number of IOReqs.
- *      CHNL_E_OUTOFSTREAMS:    No free channels available.
+ *      -ENOSR:    No free channels available.
  *      -ECHRNG:       Channel ID is out of range.
  *      -EALREADY:        Channel is in use.
  *      -EIO:         No free IO request packets available for
diff --git a/drivers/dsp/bridge/core/chnl_sm.c b/drivers/dsp/bridge/core/chnl_sm.c
index db03db6..67132c2 100644
--- a/drivers/dsp/bridge/core/chnl_sm.c
+++ b/drivers/dsp/bridge/core/chnl_sm.c
@@ -1003,7 +1003,7 @@ static struct chnl_irp *make_new_chirp(void)
 static dsp_status search_free_channel(struct chnl_mgr *chnl_mgr_obj,
 				      OUT u32 *pdwChnl)
 {
-	dsp_status status = CHNL_E_OUTOFSTREAMS;
+	dsp_status status = -ENOSR;
 	u32 i;
 
 	DBC_REQUIRE(chnl_mgr_obj);
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index c31a5c1..d560503 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -584,7 +584,7 @@ func_cont:
 				 * strm_mgr_obj->hchnl_mgr better be valid or we
 				 * assert here), and then return -EPERM.
 				 */
-				DBC_ASSERT(status == CHNL_E_OUTOFSTREAMS ||
+				DBC_ASSERT(status == -ENOSR ||
 					   status == -ECHRNG ||
 					   status == -EALREADY ||
 					   status == -EIO);
-- 
1.7.1

