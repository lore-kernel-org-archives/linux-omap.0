From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH 1/2] OMAP: DSS2: enable generic panel configuration modification
Date: Mon, 26 Jul 2010 13:34:27 +0300
Message-ID: <1280140468-8183-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:46245 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753678Ab0GZKeq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Jul 2010 06:34:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Igor Grinberg <grinberg@compulab.co.il>, Mike Rapoport <mike@compulab.co.il>

This patch enables platforms to modify the dss device configuration
of the generic panel.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 drivers/video/omap2/displays/panel-generic.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-generic.c b/drivers/video/omap2/displays/panel-generic.c
index 300eff5..ad80dd0 100644
--- a/drivers/video/omap2/displays/panel-generic.c
+++ b/drivers/video/omap2/displays/panel-generic.c
@@ -66,7 +66,7 @@ static void generic_panel_power_off(struct omap_dss_device *dssdev)
 
 static int generic_panel_probe(struct omap_dss_device *dssdev)
 {
-	dssdev->panel.config = OMAP_DSS_LCD_TFT;
+	dssdev->panel.config |= OMAP_DSS_LCD_TFT;
 	dssdev->panel.timings = generic_panel_timings;
 
 	return 0;
-- 
1.7.1

