From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 14/14] OMAPDSS: DPI: DRA7xx support
Date: Tue, 27 Jan 2015 12:50:42 +0200
Message-ID: <1422355842-11234-15-git-send-email-tomi.valkeinen@ti.com>
References: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35776 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755987AbbA0KvO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Jan 2015 05:51:14 -0500
In-Reply-To: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add support for DRA7xx DPI output.

DRA7xx has three DPI outputs, each of which gets its input from a DISPC
channel. However, DRA72x has only one video PLL, and DRA74x has two
video PLLs. In both cases the video PLLs need to be shared between
multiple outputs. The driver doesn't handle this at the moment.

Also, DRA7xx requires configuring CONTROL module bits to route the clock
from the PLL to the used DISPC channel.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dpi.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dpi.c b/drivers/video/fbdev/omap2/dss/dpi.c
index 9a2f8c3b102d..f83e7b030249 100644
--- a/drivers/video/fbdev/omap2/dss/dpi.c
+++ b/drivers/video/fbdev/omap2/dss/dpi.c
@@ -106,6 +106,17 @@ static struct dss_pll *dpi_get_pll(enum omap_channel channel)
 			return NULL;
 		}
 
+	case OMAPDSS_VER_DRA7xx:
+		switch (channel) {
+		case OMAP_DSS_CHANNEL_LCD:
+		case OMAP_DSS_CHANNEL_LCD2:
+			return dss_pll_find("video0");
+		case OMAP_DSS_CHANNEL_LCD3:
+			return dss_pll_find("video1");
+		default:
+			return NULL;
+		}
+
 	default:
 		return NULL;
 	}
@@ -590,6 +601,10 @@ static void dpi_init_pll(struct dpi_data *dpi)
 	if (!pll)
 		return;
 
+	/* On DRA7 we need to set a mux to use the PLL */
+	if (omapdss_get_version() == OMAPDSS_VER_DRA7xx)
+		dss_ctrl_pll_set_control_mux(pll->id, dpi->output.dispc_channel);
+
 	if (dpi_verify_dsi_pll(pll)) {
 		DSSWARN("DSI PLL not operational\n");
 		return;
@@ -615,6 +630,17 @@ static enum omap_channel dpi_get_channel(int port_num)
 	case OMAPDSS_VER_AM43xx:
 		return OMAP_DSS_CHANNEL_LCD;
 
+	case OMAPDSS_VER_DRA7xx:
+		switch (port_num) {
+		case 2:
+			return OMAP_DSS_CHANNEL_LCD3;
+		case 1:
+			return OMAP_DSS_CHANNEL_LCD2;
+		case 0:
+		default:
+			return OMAP_DSS_CHANNEL_LCD;
+		}
+
 	case OMAPDSS_VER_OMAP4430_ES1:
 	case OMAPDSS_VER_OMAP4430_ES2:
 	case OMAPDSS_VER_OMAP4:
-- 
2.2.2

