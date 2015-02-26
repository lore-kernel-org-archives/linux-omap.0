From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 06/15] OMAPDSS: DISPC: explicit handling for sync and de levels
Date: Thu, 26 Feb 2015 14:49:00 +0200
Message-ID: <1424954949-12801-6-git-send-email-tomi.valkeinen@ti.com>
References: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33810 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932194AbbBZMtk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2015 07:49:40 -0500
In-Reply-To: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

When configuring the lcd timings, instead of writing enum values
directly to the HW, use switch-case to get the value to be programmed.

This is safer and also allows us to change the enum values.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 41 +++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index 11bd780fcdfa..8805266a52f4 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -2915,7 +2915,7 @@ static void _dispc_mgr_set_lcd_timings(enum omap_channel channel, int hsw,
 
 {
 	u32 timing_h, timing_v, l;
-	bool onoff, rf, ipc;
+	bool onoff, rf, ipc, vs, hs, de;
 
 	timing_h = FLD_VAL(hsw-1, dispc.feat->sw_start, 0) |
 			FLD_VAL(hfp-1, dispc.feat->fp_start, 8) |
@@ -2927,6 +2927,39 @@ static void _dispc_mgr_set_lcd_timings(enum omap_channel channel, int hsw,
 	dispc_write_reg(DISPC_TIMING_H(channel), timing_h);
 	dispc_write_reg(DISPC_TIMING_V(channel), timing_v);
 
+	switch (vsync_level) {
+	case OMAPDSS_SIG_ACTIVE_LOW:
+		vs = true;
+		break;
+	case OMAPDSS_SIG_ACTIVE_HIGH:
+		vs = false;
+		break;
+	default:
+		BUG();
+	}
+
+	switch (hsync_level) {
+	case OMAPDSS_SIG_ACTIVE_LOW:
+		hs = true;
+		break;
+	case OMAPDSS_SIG_ACTIVE_HIGH:
+		hs = false;
+		break;
+	default:
+		BUG();
+	}
+
+	switch (de_level) {
+	case OMAPDSS_SIG_ACTIVE_LOW:
+		de = true;
+		break;
+	case OMAPDSS_SIG_ACTIVE_HIGH:
+		de = false;
+		break;
+	default:
+		BUG();
+	}
+
 	switch (data_pclk_edge) {
 	case OMAPDSS_DRIVE_SIG_RISING_EDGE:
 		ipc = false;
@@ -2954,10 +2987,10 @@ static void _dispc_mgr_set_lcd_timings(enum omap_channel channel, int hsw,
 
 	l = FLD_VAL(onoff, 17, 17) |
 		FLD_VAL(rf, 16, 16) |
-		FLD_VAL(de_level, 15, 15) |
+		FLD_VAL(de, 15, 15) |
 		FLD_VAL(ipc, 14, 14) |
-		FLD_VAL(hsync_level, 13, 13) |
-		FLD_VAL(vsync_level, 12, 12);
+		FLD_VAL(hs, 13, 13) |
+		FLD_VAL(vs, 12, 12);
 
 	dispc_write_reg(DISPC_POL_FREQ(channel), l);
 
-- 
2.3.0

