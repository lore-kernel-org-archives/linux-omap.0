From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 3/8] OMAP: DSS2: HDMI: change regn definition
Date: Mon, 12 Sep 2011 12:12:48 +0300
Message-ID: <1315818773-18660-4-git-send-email-tomi.valkeinen@ti.com>
References: <1315818773-18660-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:41321 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752082Ab1ILJNP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 05:13:15 -0400
In-Reply-To: <1315818773-18660-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Mythri P K <mythripk@ti.com>

regn divider is currently programmed to the registers without change,
but when calculating clock frequencies it is used as regn+1.

To make this similar to how DSI handles the dividers this patch changes
the regn value to be used as such for calculations, but the value
programmed to registers is regn-1.

This simplifies the clock frequency calculations, makes it similar to
DSI, and also allows us to use regn value 0 as undefined.

Cc: Mythri P K <mythripk@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/hdmi.c            |    6 +++---
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |    2 +-
 include/video/omapdss.h                   |    1 +
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 52731b5..4752137 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -60,7 +60,7 @@
 
 #define OMAP_HDMI_TIMINGS_NB			34
 
-#define HDMI_DEFAULT_REGN 15
+#define HDMI_DEFAULT_REGN 16
 #define HDMI_DEFAULT_REGM2 1
 
 static struct {
@@ -426,7 +426,7 @@ static void hdmi_compute_pll(struct omap_dss_device *dssdev, int phy,
 	else
 		pi->regn = dssdev->clocks.hdmi.regn;
 
-	refclk = clkin / (pi->regn + 1);
+	refclk = clkin / pi->regn;
 
 	/*
 	 * multiplier is pixel_clk/ref_clk
@@ -452,7 +452,7 @@ static void hdmi_compute_pll(struct omap_dss_device *dssdev, int phy,
 	 * is greater than 1000MHz
 	 */
 	pi->dcofreq = phy > 1000 * 100;
-	pi->regsd = ((pi->regm * clkin / 10) / ((pi->regn + 1) * 250) + 5) / 10;
+	pi->regsd = ((pi->regm * clkin / 10) / (pi->regn * 250) + 5) / 10;
 
 	/* Set the reference clock to sysclk reference */
 	pi->refsel = HDMI_REFSEL_SYSCLK;
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index cb3a2d6..403c662 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -92,7 +92,7 @@ static int hdmi_pll_init(struct hdmi_ip_data *ip_data)
 
 	r = hdmi_read_reg(pll_base, PLLCTRL_CFG1);
 	r = FLD_MOD(r, fmt->regm, 20, 9); /* CFG1_PLL_REGM */
-	r = FLD_MOD(r, fmt->regn, 8, 1);  /* CFG1_PLL_REGN */
+	r = FLD_MOD(r, fmt->regn - 1, 8, 1);  /* CFG1_PLL_REGN */
 
 	hdmi_write_reg(pll_base, PLLCTRL_CFG1, r);
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index c462ed0..528cf79 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -513,6 +513,7 @@ struct omap_dss_device {
 		} dsi;
 
 		struct {
+			/* regn is one greater than TRM's REGN value */
 			u16 regn;
 			u16 regm2;
 		} hdmi;
-- 
1.7.4.1

