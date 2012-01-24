From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 10/16] OMAPFB: remove unused fb_format_to_dss_mode()
Date: Tue, 24 Jan 2012 12:00:25 +0200
Message-ID: <1327399231-20826-11-git-send-email-tomi.valkeinen@ti.com>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:59426 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755933Ab2AXKBE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 05:01:04 -0500
In-Reply-To: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, tony@atomide.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

fb_format_to_dss_mode() function is no longer used, so remove it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |   54 ------------------------------
 1 files changed, 0 insertions(+), 54 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 4c28d57..b00db40 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1487,60 +1487,6 @@ static int omapfb_alloc_fbmem_display(struct fb_info *fbi, unsigned long size,
 	return omapfb_alloc_fbmem(fbi, size, paddr);
 }
 
-static enum omap_color_mode fb_format_to_dss_mode(enum omapfb_color_format fmt)
-{
-	enum omap_color_mode mode;
-
-	switch (fmt) {
-	case OMAPFB_COLOR_RGB565:
-		mode = OMAP_DSS_COLOR_RGB16;
-		break;
-	case OMAPFB_COLOR_YUV422:
-		mode = OMAP_DSS_COLOR_YUV2;
-		break;
-	case OMAPFB_COLOR_CLUT_8BPP:
-		mode = OMAP_DSS_COLOR_CLUT8;
-		break;
-	case OMAPFB_COLOR_CLUT_4BPP:
-		mode = OMAP_DSS_COLOR_CLUT4;
-		break;
-	case OMAPFB_COLOR_CLUT_2BPP:
-		mode = OMAP_DSS_COLOR_CLUT2;
-		break;
-	case OMAPFB_COLOR_CLUT_1BPP:
-		mode = OMAP_DSS_COLOR_CLUT1;
-		break;
-	case OMAPFB_COLOR_RGB444:
-		mode = OMAP_DSS_COLOR_RGB12U;
-		break;
-	case OMAPFB_COLOR_YUY422:
-		mode = OMAP_DSS_COLOR_UYVY;
-		break;
-	case OMAPFB_COLOR_ARGB16:
-		mode = OMAP_DSS_COLOR_ARGB16;
-		break;
-	case OMAPFB_COLOR_RGB24U:
-		mode = OMAP_DSS_COLOR_RGB24U;
-		break;
-	case OMAPFB_COLOR_RGB24P:
-		mode = OMAP_DSS_COLOR_RGB24P;
-		break;
-	case OMAPFB_COLOR_ARGB32:
-		mode = OMAP_DSS_COLOR_ARGB32;
-		break;
-	case OMAPFB_COLOR_RGBA32:
-		mode = OMAP_DSS_COLOR_RGBA32;
-		break;
-	case OMAPFB_COLOR_RGBX32:
-		mode = OMAP_DSS_COLOR_RGBX32;
-		break;
-	default:
-		mode = -EINVAL;
-	}
-
-	return mode;
-}
-
 static int omapfb_parse_vram_param(const char *param, int max_entries,
 		unsigned long *sizes, unsigned long *paddrs)
 {
-- 
1.7.4.1

