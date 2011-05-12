From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 1/8] OMAP: DSS2: Add missing dummy functions
Date: Thu, 12 May 2011 14:40:06 +0300
Message-ID: <1305200413-23697-2-git-send-email-tomi.valkeinen@ti.com>
References: <1305200413-23697-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:40400 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755433Ab1ELLk1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 May 2011 07:40:27 -0400
In-Reply-To: <1305200413-23697-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

dpi.c does not compile if DSI is not compiled in. Add the missing dummy
functions so that dpi.c compiles.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.h |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index eea5c7d..f659cfb 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -313,6 +313,27 @@ static inline unsigned long dsi_get_pll_hsdiv_dispc_rate(void)
 	WARN("%s: DSI not compiled in, returning rate as 0\n", __func__);
 	return 0;
 }
+static inline int dsi_pll_set_clock_div(struct dsi_clock_info *cinfo)
+{
+	WARN("%s: DSI not compiled in\n", __func__);
+	return -ENODEV;
+}
+static inline int dsi_pll_calc_clock_div_pck(bool is_tft, unsigned long req_pck,
+		struct dsi_clock_info *cinfo,
+		struct dispc_clock_info *dispc_cinfo)
+{
+	WARN("%s: DSI not compiled in\n", __func__);
+	return -ENODEV;
+}
+static inline int dsi_pll_init(struct omap_dss_device *dssdev,
+		bool enable_hsclk, bool enable_hsdiv)
+{
+	WARN("%s: DSI not compiled in\n", __func__);
+	return -ENODEV;
+}
+static inline void dsi_pll_uninit(bool disconnect_lanes)
+{
+}
 static inline void dsi_wait_pll_hsdiv_dispc_active(void)
 {
 }
-- 
1.7.4.1

