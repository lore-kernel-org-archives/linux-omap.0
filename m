From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 08/15] OMAPDSS: DISPC: change sync_pclk_edge default value
Date: Thu, 26 Feb 2015 14:49:02 +0200
Message-ID: <1424954949-12801-8-git-send-email-tomi.valkeinen@ti.com>
References: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37397 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753303AbbBZMtn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2015 07:49:43 -0500
In-Reply-To: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The common 'struct videomode' does not have a flag to select when the
sync signals should be driven.

The default behavior of DISPC HW is to drive the sync signal on the
opposite pixel clock edge from data signal, which is also what the
videomode_to_omap_video_timings() uses.

However, it looks like what panels usually expect is that the data and
sync signals are driven on the same edge, so let's change
videomode_to_omap_video_timings() to set the sync_pclk_edge accordingly.

Note that this only affect panels drivers that use
videomode_to_omap_video_timings(), probably when getting the video
timings directly from DT data. The drivers can still configure the
sync_pclk_edge independently if they so wish.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/display.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/display.c b/drivers/video/fbdev/omap2/dss/display.c
index a6fd2d35ad60..ef5b9027985d 100644
--- a/drivers/video/fbdev/omap2/dss/display.c
+++ b/drivers/video/fbdev/omap2/dss/display.c
@@ -295,9 +295,7 @@ void videomode_to_omap_video_timings(const struct videomode *vm,
 		OMAPDSS_DRIVE_SIG_RISING_EDGE :
 		OMAPDSS_DRIVE_SIG_FALLING_EDGE;
 
-	ovt->sync_pclk_edge = vm->flags & DISPLAY_FLAGS_PIXDATA_POSEDGE ?
-		OMAPDSS_DRIVE_SIG_FALLING_EDGE :
-		OMAPDSS_DRIVE_SIG_RISING_EDGE;
+	ovt->sync_pclk_edge = ovt->data_pclk_edge;
 }
 EXPORT_SYMBOL(videomode_to_omap_video_timings);
 
-- 
2.3.0

