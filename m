From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4/5] OMAPFB: fix overlay disable when freeing resources.
Date: Thu, 16 Oct 2014 12:39:46 +0300
Message-ID: <1413452387-25452-4-git-send-email-tomi.valkeinen@ti.com>
References: <1413452387-25452-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45705 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751923AbaJPJj6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Oct 2014 05:39:58 -0400
In-Reply-To: <1413452387-25452-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

When omapfb is shutting down, it will disable all the overlays. However,
instead of actually disabling all the overlays, it disables only all the
overlays that are currently attached to framebuffers.

On OMAP4+, this leaves the fourth overlay left enabled.

Fix the loop so that we actually go through all the overlays.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
index 9cbf1ced51c2..36ffb525be73 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
@@ -1833,14 +1833,10 @@ static void omapfb_free_resources(struct omapfb2_device *fbdev)
 	if (fbdev == NULL)
 		return;
 
-	for (i = 0; i < fbdev->num_fbs; i++) {
-		struct omapfb_info *ofbi = FB2OFB(fbdev->fbs[i]);
-		int j;
+	for (i = 0; i < fbdev->num_overlays; i++) {
+		struct omap_overlay *ovl = fbdev->overlays[i];
 
-		for (j = 0; j < ofbi->num_overlays; j++) {
-			struct omap_overlay *ovl = ofbi->overlays[j];
-			ovl->disable(ovl);
-		}
+		ovl->disable(ovl);
 	}
 
 	for (i = 0; i < fbdev->num_fbs; i++)
-- 
2.1.1

