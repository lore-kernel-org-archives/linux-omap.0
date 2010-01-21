From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/2] DSPBRIDGE: sanitize opp_idx before passing to PM
Date: Wed, 20 Jan 2010 23:45:10 -0600
Message-ID: <1264052710-30337-3-git-send-email-nm@ti.com>
References: <[PATCH 1/2] DSPBRIDGE: remove dependency of mpu freq>
 <1264052710-30337-1-git-send-email-nm@ti.com>
 <1264052710-30337-2-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46607 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752000Ab0AUFpW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jan 2010 00:45:22 -0500
In-Reply-To: <1264052710-30337-2-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Deepak Chitriki <deepak.chitriki@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

DSP is not supposed to return bad opp_indices which are not part of
the opp table we created for it. If it does, throw an error, and
refuse to switch the OPP.

Ref: discussion: http://marc.info/?t=126395196000002&r=1&w=2
Depends on: http://marc.info/?l=linux-omap&m=126402596424801&w=2

Cc: Ameya Palande <ameya.palande@nokia.com>
Cc: Deepak Chitriki <deepak.chitriki@ti.com>
Cc: Felipe Contreras <felipe.contreras@nokia.com>
Cc: Hiroshi Doyu <hiroshi.doyu@nokia.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 5dfbef8..a13e035 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -73,6 +73,12 @@ DSP_STATUS handle_constraints_set(struct WMD_DEV_CONTEXT *pDevContext,
 	/* pick up the opp index */
 	opp_idx = *(((u32 *)(pArgs)) + 1);
 
+	/* Sanity check to ensure things are fine */
+	if (!opp_idx || (opp_idx > pdata->dsp_num_speeds)) {
+		pr_err("%s: DSP requested for an invalid OPP %d Vs %d->%d!\n",
+			__func__, opp_idx, 1, pdata->dsp_num_speeds);
+		return DSP_EINVALIDARG;
+	}
 	/* Read the target value requested by DSP  */
 	DBG_Trace(DBG_LEVEL7, "handle_constraints_set:"
 		"opp requested = 0x%x\n", opp_idx);
-- 
1.6.3.3

