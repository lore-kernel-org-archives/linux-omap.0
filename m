From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 4/4] OMAP: DSS2: OMAPFB: fix cleanup on dssdev enable error
Date: Wed, 17 Feb 2010 13:57:19 +0200
Message-ID: <1266407839-14713-4-git-send-email-tomi.valkeinen@nokia.com>
References: <1266407839-14713-1-git-send-email-tomi.valkeinen@nokia.com>
 <1266407839-14713-2-git-send-email-tomi.valkeinen@nokia.com>
 <1266407839-14713-3-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:65138 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756248Ab0BQLyp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 06:54:45 -0500
In-Reply-To: <1266407839-14713-3-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

If enabling a dss device failed, omapfb didn't exit, leading to crash.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 973bf79..6a383ab 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2176,9 +2176,11 @@ static int omapfb_probe(struct platform_device *pdev)
 		u16 w, h;
 #endif
 		r = def_display->enable(def_display);
-		if (r)
+		if (r) {
 			dev_warn(fbdev->dev, "Failed to enable display '%s'\n",
 					def_display->name);
+			goto cleanup;
+		}
 
 		/* set the update mode */
 		if (def_display->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE) {
-- 
1.6.5

