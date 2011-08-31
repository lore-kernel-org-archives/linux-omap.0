From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/8] OMAP: DSS2: HDMI: change regn definition
Date: Wed, 31 Aug 2011 16:21:43 +0300
Message-ID: <1314796908-17354-4-git-send-email-tomi.valkeinen@ti.com>
References: <1314796908-17354-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:44226 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755757Ab1HaNY0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 09:24:26 -0400
In-Reply-To: <1314796908-17354-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, mythripk@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

regn divider is currently programmed to the registers without change,
but when calculating clock frequencies it is used as regn+1.

To make this similar to how DSI handles the dividers this patch changes
the regn value to be used as such for calculations, but the value
programmed to registers is regn-1.

This simplifies the clock frequency calculations, makes it similar to
DSI, and also allows us to use regn value 0 as undefined.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |    8 ++++----
 include/video/omapdss.h        |    1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index a3b3899..504c507 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -43,7 +43,7 @@
 #include "hdmi.h"
 #include "dss_features.h"
 
-#define HDMI_DEFAULT_REGN 15
+#define HDMI_DEFAULT_REGN 16
 #define HDMI_DEFAULT_REGM2 1
 
 static struct {
@@ -208,7 +208,7 @@ static int hdmi_pll_init(enum hdmi_clk_refsel refsel, int dcofreq,
 
 	r = hdmi_read_reg(PLLCTRL_CFG1);
 	r = FLD_MOD(r, fmt->regm, 20, 9); /* CFG1_PLL_REGM */
-	r = FLD_MOD(r, fmt->regn, 8, 1);  /* CFG1_PLL_REGN */
+	r = FLD_MOD(r, fmt->regn - 1, 8, 1);  /* CFG1_PLL_REGN */
 
 	hdmi_write_reg(PLLCTRL_CFG1, r);
 
@@ -1084,7 +1084,7 @@ static void hdmi_compute_pll(struct omap_dss_device *dssdev, int phy,
 	else
 		pi->regn = dssdev->clocks.hdmi.regn;
 
-	refclk = clkin / (pi->regn + 1);
+	refclk = clkin / pi->regn;
 
 	/*
 	 * multiplier is pixel_clk/ref_clk
@@ -1110,7 +1110,7 @@ static void hdmi_compute_pll(struct omap_dss_device *dssdev, int phy,
 	 * is greater than 1000MHz
 	 */
 	pi->dcofreq = phy > 1000 * 100;
-	pi->regsd = ((pi->regm * clkin / 10) / ((pi->regn + 1) * 250) + 5) / 10;
+	pi->regsd = ((pi->regm * clkin / 10) / (pi->regn * 250) + 5) / 10;
 
 	DSSDBG("M = %d Mf = %d\n", pi->regm, pi->regmf);
 	DSSDBG("range = %d sd = %d\n", pi->dcofreq, pi->regsd);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 9398dd3..534e3d1 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -460,6 +460,7 @@ struct omap_dss_device {
 		} dsi;
 
 		struct {
+			/* regn is one greater than TRM's REGN value */
 			u16 regn;
 			u16 regm2;
 		} hdmi;
-- 
1.7.4.1

