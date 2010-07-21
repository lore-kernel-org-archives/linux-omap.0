From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Subject: [PATCH] OMAP2: OMAPFB: Fix invalid bpp for PAL and NTSC modes
Date: Thu, 22 Jul 2010 00:40:58 +0200
Message-ID: <4c477948.cf7d0e0a.2929.ffffaefe@mx.google.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59246 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758947Ab0GUWso (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Jul 2010 18:48:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com
Cc: ville.syrjala@nokia.com, tj@kernel.org

omapfb_mode_to_timings() sets the bpp to 0 when bootarg omapfb.mode is set to
either "pal" or "ntsc". This patch corrects this by setting the bpp to 24, as
would be done if omapdss_default_get_recommended_bpp() would be called

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 4b4506d..500458e 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1968,11 +1968,11 @@ static int omapfb_mode_to_timings(const char *mode_str,
 #ifdef CONFIG_OMAP2_DSS_VENC
 	if (strcmp(mode_str, "pal") == 0) {
 		*timings = omap_dss_pal_timings;
-		*bpp = 0;
+		*bpp = 24;
 		return 0;
 	} else if (strcmp(mode_str, "ntsc") == 0) {
 		*timings = omap_dss_ntsc_timings;
-		*bpp = 0;
+		*bpp = 24;
 		return 0;
 	}
 #endif
-- 
1.7.0.4

