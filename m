From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 15/23] OMAPDSS: DPI: fix LCD3 DSI source
Date: Thu, 24 Apr 2014 13:17:11 +0300
Message-ID: <1398334639-14172-16-git-send-email-tomi.valkeinen@ti.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60602 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755149AbaDXKTV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2014 06:19:21 -0400
In-Reply-To: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

At the moment the dpi driver does not handle LCD3 clock source at all.

LCD3 channel gets the DSI PLL clock from DSI2 instance. Add support for
LCD3's clock source in the dpi driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dpi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dpi.c b/drivers/video/fbdev/omap2/dss/dpi.c
index 157921db447a..8e097fb58a9c 100644
--- a/drivers/video/fbdev/omap2/dss/dpi.c
+++ b/drivers/video/fbdev/omap2/dss/dpi.c
@@ -103,6 +103,8 @@ static enum omap_dss_clk_source dpi_get_alt_clk_src(enum omap_channel channel)
 		return OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC;
 	case OMAP_DSS_CHANNEL_LCD2:
 		return OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC;
+	case OMAP_DSS_CHANNEL_LCD3:
+		return OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC;
 	default:
 		/* this shouldn't happen */
 		WARN_ON(1);
-- 
1.9.1

