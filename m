From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 03/15] OMAPDSS: DISPC: clean up dispc_mgr_timings_ok
Date: Tue, 24 Jun 2014 13:03:48 +0300
Message-ID: <1403604240-16738-4-git-send-email-tomi.valkeinen@ti.com>
References: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57827 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753074AbaFXKEN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jun 2014 06:04:13 -0400
In-Reply-To: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

dispc_mgr_timings_ok() is a bit confusing how it handles the return
value.

Change the function to just return immediately when a timing is deemed
not valid, making the code much easier to follow.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index 37373b61784e..be053aa80880 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -2879,22 +2879,24 @@ static bool _dispc_mgr_pclk_ok(enum omap_channel channel,
 bool dispc_mgr_timings_ok(enum omap_channel channel,
 		const struct omap_video_timings *timings)
 {
-	bool timings_ok;
-
-	timings_ok = _dispc_mgr_size_ok(timings->x_res, timings->y_res);
+	if (!_dispc_mgr_size_ok(timings->x_res, timings->y_res))
+		return false;
 
-	timings_ok &= _dispc_mgr_pclk_ok(channel, timings->pixelclock);
+	if (!_dispc_mgr_pclk_ok(channel, timings->pixelclock))
+		return false;
 
 	if (dss_mgr_is_lcd(channel)) {
 		/* TODO: OMAP4+ supports interlace for LCD outputs */
-		timings_ok &= timings->interlace == false;
+		if (timings->interlace)
+			return false;
 
-		timings_ok &= _dispc_lcd_timings_ok(timings->hsw, timings->hfp,
+		if (!_dispc_lcd_timings_ok(timings->hsw, timings->hfp,
 				timings->hbp, timings->vsw, timings->vfp,
-				timings->vbp);
+				timings->vbp))
+			return false;
 	}
 
-	return timings_ok;
+	return true;
 }
 
 static void _dispc_mgr_set_lcd_timings(enum omap_channel channel, int hsw,
-- 
1.9.1

