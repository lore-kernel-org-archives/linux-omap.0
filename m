From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 5/8] staging: tidspbridge: send wake message even if dsp is running
Date: Wed, 23 Mar 2011 12:49:50 -0600
Message-ID: <1300906193-1732-6-git-send-email-omar.ramirez@ti.com>
References: <1300906193-1732-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44787 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932641Ab1CWTBO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Mar 2011 15:01:14 -0400
In-Reply-To: <1300906193-1732-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Armando Uribe <x0095078@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Even if the board state is 'running', send a wake up message,
which should refresh self hibernation timeout (on dsp side) and
prevent it from going into sleep by itself.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/staging/tidspbridge/core/tiomap3430_pwr.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/tiomap3430_pwr.c b/drivers/staging/tidspbridge/core/tiomap3430_pwr.c
index dd035af..93c441c 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430_pwr.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430_pwr.c
@@ -270,8 +270,9 @@ int wake_dsp(struct bridge_dev_context *dev_context, void *pargs)
 
 	switch (dev_context->brd_state) {
 	case BRD_STOPPED:
-	case BRD_RUNNING:
 		return 0;
+	case BRD_RUNNING:
+		break;
 	case BRD_RETENTION:
 		/* Restart the peripheral clocks */
 		dsp_clock_enable_all(dev_context->dsp_per_clks);
-- 
1.7.1

