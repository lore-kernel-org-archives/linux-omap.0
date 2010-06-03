From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 06/40] DSPBRIDGE: err code replace CHNL_E_NOIORPS with EIO
Date: Thu,  3 Jun 2010 00:47:19 -0500
Message-ID: <1275544073-20418-7-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44859 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753034Ab0FCF4P (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jun 2010 01:56:15 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Replace CHNL_E_NOIORPS with EIO

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dspdefs.h |    2 +-
 drivers/dsp/bridge/core/chnl_sm.c              |    2 +-
 drivers/dsp/bridge/rmgr/strm.c                 |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dspdefs.h b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
index 3d53881..ff352ce 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
@@ -395,7 +395,7 @@ typedef void (*fxn_deh_notify) (struct deh_mgr *hdeh_mgr,
  *      CHNL_E_OUTOFSTREAMS:    No free channels available.
  *      CHNL_E_BADCHANID:       Channel ID is out of range.
  *      -EALREADY:        Channel is in use.
- *      CHNL_E_NOIORPS:         No free IO request packets available for
+ *      -EIO:         No free IO request packets available for
  *                              queuing.
  *  Requires:
  *      phChnl != NULL.
diff --git a/drivers/dsp/bridge/core/chnl_sm.c b/drivers/dsp/bridge/core/chnl_sm.c
index 3cebf94..449b897 100644
--- a/drivers/dsp/bridge/core/chnl_sm.c
+++ b/drivers/dsp/bridge/core/chnl_sm.c
@@ -185,7 +185,7 @@ func_cont:
 		chnl_packet_obj =
 		    (struct chnl_irp *)lst_get_head(pchnl->free_packets_list);
 		if (chnl_packet_obj == NULL)
-			status = CHNL_E_NOIORPS;
+			status = -EIO;
 
 	}
 	if (DSP_SUCCEEDED(status)) {
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index 7e2481f..accfb7b 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -448,7 +448,7 @@ dsp_status strm_issue(struct strm_object *hStrm, IN u8 *pbuf, u32 ul_bytes,
 			    (hStrm->chnl_obj, pbuf, ul_bytes, ul_buf_size,
 			     (u32) tmp_buf, dw_arg);
 		}
-		if (status == CHNL_E_NOIORPS)
+		if (status == -EIO)
 			status = -ENOSR;
 	}
 
@@ -587,7 +587,7 @@ func_cont:
 				DBC_ASSERT(status == CHNL_E_OUTOFSTREAMS ||
 					   status == CHNL_E_BADCHANID ||
 					   status == -EALREADY ||
-					   status == CHNL_E_NOIORPS);
+					   status == -EIO);
 				status = -EPERM;
 			}
 		}
-- 
1.7.1

