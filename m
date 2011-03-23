From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 2/8] staging: tidspbridge: fix resume path from retention
Date: Wed, 23 Mar 2011 12:49:47 -0600
Message-ID: <1300906193-1732-3-git-send-email-omar.ramirez@ti.com>
References: <1300906193-1732-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60760 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932477Ab1CWTBK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Mar 2011 15:01:10 -0400
In-Reply-To: <1300906193-1732-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Armando Uribe <x0095078@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

If the target state is RET for suspend, the driver
disables wdt3; this is never enabled again on resume,
nor the state updated to running, fixing that.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/staging/tidspbridge/core/tiomap3430_pwr.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/tiomap3430_pwr.c b/drivers/staging/tidspbridge/core/tiomap3430_pwr.c
index d5245a3..69cc2c4 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430_pwr.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430_pwr.c
@@ -274,6 +274,10 @@ int wake_dsp(struct bridge_dev_context *dev_context, void *pargs)
 		/* Restart the peripheral clocks */
 		dsp_clock_enable_all(dev_context->dsp_per_clks);
 
+		dsp_wdt_enable(true);
+
+		dev_context->brd_state = BRD_RUNNING;
+
 		break;
 	case BRD_HIBERNATION:
 	case BRD_DSP_HIBERNATION:
-- 
1.7.1

