From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 23/65] OMAPDSS: APPLY: skip isr register and config for manual update displays
Date: Tue, 22 Nov 2011 11:21:22 +0200
Message-ID: <1321953724-6350-24-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:43150 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757636Ab1KVJX0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:23:26 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

The mechanism to cache manager and overlay settings and configure them
into the HW registers in VSYNC is meant only for auto-update displays,
as it doesn't make sense (and doesn't work) for manual-update displays.

This patchs adds a check so that we skip the above for manual update
displays.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   27 +++++++++++++++------------
 1 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 9af5809..04f3ff5 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -629,23 +629,26 @@ int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 	}
 
 	r = 0;
-	if (!dss_cache.irq_enabled) {
-		u32 mask;
+	if (!mgr_manual_update(mgr)) {
+		if (!dss_cache.irq_enabled) {
+			u32 mask;
 
-		mask = DISPC_IRQ_VSYNC	| DISPC_IRQ_EVSYNC_ODD |
-			DISPC_IRQ_EVSYNC_EVEN;
-		if (dss_has_feature(FEAT_MGR_LCD2))
-			mask |= DISPC_IRQ_VSYNC2;
+			mask = DISPC_IRQ_VSYNC	| DISPC_IRQ_EVSYNC_ODD |
+				DISPC_IRQ_EVSYNC_EVEN;
+			if (dss_has_feature(FEAT_MGR_LCD2))
+				mask |= DISPC_IRQ_VSYNC2;
 
-		r = omap_dispc_register_isr(dss_apply_irq_handler, NULL, mask);
+			r = omap_dispc_register_isr(dss_apply_irq_handler,
+					NULL, mask);
 
-		if (r)
-			DSSERR("failed to register apply isr\n");
+			if (r)
+				DSSERR("failed to register apply isr\n");
 
-		dss_cache.irq_enabled = true;
-	}
+			dss_cache.irq_enabled = true;
+		}
 
-	configure_dispc();
+		configure_dispc();
+	}
 
 	spin_unlock_irqrestore(&dss_cache.lock, flags);
 
-- 
1.7.4.1

