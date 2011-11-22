From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 24/65] OMAPDSS: APPLY: skip isr register and config for disabled displays
Date: Tue, 22 Nov 2011 11:21:23 +0200
Message-ID: <1321953724-6350-25-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:39693 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757502Ab1KVJX2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:23:28 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

There's no need to register the vsync ISR and configure the hardware if
the overlay manager is disabled, so this patch adds a check for disabled
managers to the omap_dss_mgr_apply() function.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 04f3ff5..cf68c9e 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -629,7 +629,7 @@ int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 	}
 
 	r = 0;
-	if (!mgr_manual_update(mgr)) {
+	if (mgr->enabled && !mgr_manual_update(mgr)) {
 		if (!dss_cache.irq_enabled) {
 			u32 mask;
 
-- 
1.7.4.1

