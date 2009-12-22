From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 2/2] DSPBRIDGE: remove useless return statement
Date: Tue, 22 Dec 2009 00:11:43 -0600
Message-ID: <1261462303-29437-3-git-send-email-omar.ramirez@ti.com>
References: <1261462303-29437-1-git-send-email-omar.ramirez@ti.com>
 <1261462303-29437-2-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59195 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751584AbZLVGEA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Dec 2009 01:04:00 -0500
In-Reply-To: <1261462303-29437-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Remove useless return in function to set an OPP constraint.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 68b6993..d7ed894 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -91,7 +91,6 @@ DSP_STATUS handle_constraints_set(struct WMD_DEV_CONTEXT *pDevContext,
 	/* Set the new opp value */
 	if (pdata->dsp_set_min_opp)
 		(*pdata->dsp_set_min_opp)((u32)*(pConstraintVal+1));
-	return DSP_SOK;
 #endif /* #ifdef CONFIG_BRIDGE_DVFS */
 	return DSP_SOK;
 }
-- 
1.6.2.4

