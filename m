From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 02/15] OMAPDSS: DISPC: reject interlace for lcd out
Date: Tue, 24 Jun 2014 13:03:47 +0300
Message-ID: <1403604240-16738-3-git-send-email-tomi.valkeinen@ti.com>
References: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46982 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751818AbaFXKEL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jun 2014 06:04:11 -0400
In-Reply-To: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

OMAP2/3 does not support interlace for LCD out. OMAP4+ does, but is not
supported by the driver at the moment.

The driver still accepts interlaced mode for LCD out, causing broken
display output.

This patch makes dispc reject interlace for LCD out.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index d1f0dbb486b8..37373b61784e 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -2886,6 +2886,9 @@ bool dispc_mgr_timings_ok(enum omap_channel channel,
 	timings_ok &= _dispc_mgr_pclk_ok(channel, timings->pixelclock);
 
 	if (dss_mgr_is_lcd(channel)) {
+		/* TODO: OMAP4+ supports interlace for LCD outputs */
+		timings_ok &= timings->interlace == false;
+
 		timings_ok &= _dispc_lcd_timings_ok(timings->hsw, timings->hfp,
 				timings->hbp, timings->vsw, timings->vfp,
 				timings->vbp);
-- 
1.9.1

