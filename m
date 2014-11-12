From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 16/22] OMAPDSS: HDMI: rewrite HDMI PLL calculation code
Date: Wed, 12 Nov 2014 13:52:18 +0200
Message-ID: <1415793144-11723-17-git-send-email-tomi.valkeinen@ti.com>
References: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53626 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547AbaKLLxJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2014 06:53:09 -0500
In-Reply-To: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The code calculating HDMI PLL parameters has always been very confusing.
Now that we are implementing a common PLL library for the DSS, it's
important that the PLL code is understandable.

This patch rewrites the calculation code, and removes a few hacks that
were used there.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h     | 10 +++-
 drivers/video/fbdev/omap2/dss/hdmi4.c    |  9 +--
 drivers/video/fbdev/omap2/dss/hdmi5.c    |  9 +--
 drivers/video/fbdev/omap2/dss/hdmi_phy.c | 31 ++++-------
 drivers/video/fbdev/omap2/dss/hdmi_pll.c | 95 ++++++++++++++++----------------
 5 files changed, 71 insertions(+), 83 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index 4bbc9d206f4a..4b9bf0804a48 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -191,7 +191,9 @@ struct hdmi_pll_info {
 	u32 regmf;
 	u16 regm2;
 	u16 regsd;
-	u16 dcofreq;
+
+	unsigned long clkdco;
+	unsigned long clkout;
 };
 
 struct hdmi_audio_format {
@@ -313,11 +315,13 @@ int hdmi_wp_init(struct platform_device *pdev, struct hdmi_wp_data *wp);
 int hdmi_pll_enable(struct hdmi_pll_data *pll, struct hdmi_wp_data *wp);
 void hdmi_pll_disable(struct hdmi_pll_data *pll, struct hdmi_wp_data *wp);
 void hdmi_pll_dump(struct hdmi_pll_data *pll, struct seq_file *s);
-void hdmi_pll_compute(struct hdmi_pll_data *pll, unsigned long clkin, int phy);
+void hdmi_pll_compute(struct hdmi_pll_data *pll, unsigned long clkin,
+	unsigned long target_tmds);
 int hdmi_pll_init(struct platform_device *pdev, struct hdmi_pll_data *pll);
 
 /* HDMI PHY funcs */
-int hdmi_phy_configure(struct hdmi_phy_data *phy, struct hdmi_config *cfg);
+int hdmi_phy_configure(struct hdmi_phy_data *phy, unsigned long hfbitclk,
+	unsigned long lfbitclk);
 void hdmi_phy_dump(struct hdmi_phy_data *phy, struct seq_file *s);
 int hdmi_phy_init(struct platform_device *pdev, struct hdmi_phy_data *phy);
 int hdmi_phy_parse_lanes(struct hdmi_phy_data *phy, const u32 *lanes);
diff --git a/drivers/video/fbdev/omap2/dss/hdmi4.c b/drivers/video/fbdev/omap2/dss/hdmi4.c
index 9a8713ca090c..1f2fbccaff1f 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi4.c
@@ -180,7 +180,6 @@ static int hdmi_power_on_full(struct omap_dss_device *dssdev)
 	int r;
 	struct omap_video_timings *p;
 	struct omap_overlay_manager *mgr = hdmi.output.manager;
-	unsigned long phy;
 	struct hdmi_wp_data *wp = &hdmi.wp;
 
 	r = hdmi_power_on_core(dssdev);
@@ -195,10 +194,7 @@ static int hdmi_power_on_full(struct omap_dss_device *dssdev)
 
 	DSSDBG("hdmi_power_on x_res= %d y_res = %d\n", p->x_res, p->y_res);
 
-	/* the functions below use kHz pixel clock. TODO: change to Hz */
-	phy = p->pixelclock / 1000;
-
-	hdmi_pll_compute(&hdmi.pll, clk_get_rate(hdmi.sys_clk), phy);
+	hdmi_pll_compute(&hdmi.pll, clk_get_rate(hdmi.sys_clk), p->pixelclock);
 
 	/* config the PLL and PHY hdmi_set_pll_pwrfirst */
 	r = hdmi_pll_enable(&hdmi.pll, &hdmi.wp);
@@ -207,7 +203,8 @@ static int hdmi_power_on_full(struct omap_dss_device *dssdev)
 		goto err_pll_enable;
 	}
 
-	r = hdmi_phy_configure(&hdmi.phy, &hdmi.cfg);
+	r = hdmi_phy_configure(&hdmi.phy, hdmi.pll.info.clkdco,
+		hdmi.pll.info.clkout);
 	if (r) {
 		DSSDBG("Failed to configure PHY\n");
 		goto err_phy_cfg;
diff --git a/drivers/video/fbdev/omap2/dss/hdmi5.c b/drivers/video/fbdev/omap2/dss/hdmi5.c
index c053d692ec16..e8ca9106c8af 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5.c
@@ -198,7 +198,6 @@ static int hdmi_power_on_full(struct omap_dss_device *dssdev)
 	int r;
 	struct omap_video_timings *p;
 	struct omap_overlay_manager *mgr = hdmi.output.manager;
-	unsigned long phy;
 
 	r = hdmi_power_on_core(dssdev);
 	if (r)
@@ -208,10 +207,7 @@ static int hdmi_power_on_full(struct omap_dss_device *dssdev)
 
 	DSSDBG("hdmi_power_on x_res= %d y_res = %d\n", p->x_res, p->y_res);
 
-	/* the functions below use kHz pixel clock. TODO: change to Hz */
-	phy = p->pixelclock / 1000;
-
-	hdmi_pll_compute(&hdmi.pll, clk_get_rate(hdmi.sys_clk), phy);
+	hdmi_pll_compute(&hdmi.pll, clk_get_rate(hdmi.sys_clk), p->pixelclock);
 
 	/* disable and clear irqs */
 	hdmi_wp_clear_irqenable(&hdmi.wp, 0xffffffff);
@@ -225,7 +221,8 @@ static int hdmi_power_on_full(struct omap_dss_device *dssdev)
 		goto err_pll_enable;
 	}
 
-	r = hdmi_phy_configure(&hdmi.phy, &hdmi.cfg);
+	r = hdmi_phy_configure(&hdmi.phy, hdmi.pll.info.clkdco,
+		hdmi.pll.info.clkout);
 	if (r) {
 		DSSDBG("Failed to start PHY\n");
 		goto err_phy_cfg;
diff --git a/drivers/video/fbdev/omap2/dss/hdmi_phy.c b/drivers/video/fbdev/omap2/dss/hdmi_phy.c
index e007ac892d79..bc9e07d2afbe 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi_phy.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi_phy.c
@@ -20,9 +20,7 @@
 
 struct hdmi_phy_features {
 	bool bist_ctrl;
-	bool calc_freqout;
 	bool ldo_voltage;
-	unsigned long dcofreq_min;
 	unsigned long max_phy;
 };
 
@@ -132,7 +130,8 @@ static void hdmi_phy_configure_lanes(struct hdmi_phy_data *phy)
 	REG_FLD_MOD(phy->base, HDMI_TXPHY_PAD_CFG_CTRL, pol_val, 30, 27);
 }
 
-int hdmi_phy_configure(struct hdmi_phy_data *phy, struct hdmi_config *cfg)
+int hdmi_phy_configure(struct hdmi_phy_data *phy, unsigned long hfbitclk,
+	unsigned long lfbitclk)
 {
 	u8 freqout;
 
@@ -149,20 +148,16 @@ int hdmi_phy_configure(struct hdmi_phy_data *phy, struct hdmi_config *cfg)
 	if (phy_feat->bist_ctrl)
 		REG_FLD_MOD(phy->base, HDMI_TXPHY_BIST_CONTROL, 1, 11, 11);
 
-	if (phy_feat->calc_freqout) {
-		/* DCOCLK/10 is pixel clock, compare pclk with DCOCLK_MIN/10 */
-		u32 dco_min = phy_feat->dcofreq_min / 10;
-		u32 pclk = cfg->timings.pixelclock;
-
-		if (pclk < dco_min)
-			freqout = 0;
-		else if ((pclk >= dco_min) && (pclk < phy_feat->max_phy))
-			freqout = 1;
-		else
-			freqout = 2;
-	} else {
+	/*
+	 * If the hfbitclk != lfbitclk, it means the lfbitclk was configured
+	 * to be used for TMDS.
+	 */
+	if (hfbitclk != lfbitclk)
+		freqout = 0;
+	else if (hfbitclk / 10 < phy_feat->max_phy)
 		freqout = 1;
-	}
+	else
+		freqout = 2;
 
 	/*
 	 * Write to phy address 0 to configure the clock
@@ -184,17 +179,13 @@ int hdmi_phy_configure(struct hdmi_phy_data *phy, struct hdmi_config *cfg)
 
 static const struct hdmi_phy_features omap44xx_phy_feats = {
 	.bist_ctrl	=	false,
-	.calc_freqout	=	false,
 	.ldo_voltage	=	true,
-	.dcofreq_min	=	500000000,
 	.max_phy	=	185675000,
 };
 
 static const struct hdmi_phy_features omap54xx_phy_feats = {
 	.bist_ctrl	=	true,
-	.calc_freqout	=	true,
 	.ldo_voltage	=	false,
-	.dcofreq_min	=	750000000,
 	.max_phy	=	186000000,
 };
 
diff --git a/drivers/video/fbdev/omap2/dss/hdmi_pll.c b/drivers/video/fbdev/omap2/dss/hdmi_pll.c
index b28d41a08a8f..f04d435c4c0f 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi_pll.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi_pll.c
@@ -20,14 +20,9 @@
 #include "dss.h"
 #include "hdmi.h"
 
-#define HDMI_DEFAULT_REGN 16
-#define HDMI_DEFAULT_REGM2 1
-
 struct hdmi_pll_features {
 	bool has_refsel;
 	bool sys_reset;
-	/* this is a hack, need to replace it with a better computation of M2 */
-	bool bound_dcofreq;
 	unsigned long fint_min, fint_max;
 	u16 regm_max;
 	unsigned long dcofreq_low_min, dcofreq_low_max;
@@ -52,55 +47,61 @@ void hdmi_pll_dump(struct hdmi_pll_data *pll, struct seq_file *s)
 	DUMPPLL(PLLCTRL_CFG4);
 }
 
-void hdmi_pll_compute(struct hdmi_pll_data *pll, unsigned long clkin, int phy)
+void hdmi_pll_compute(struct hdmi_pll_data *pll, unsigned long clkin,
+	unsigned long target_tmds)
 {
 	struct hdmi_pll_info *pi = &pll->info;
-	unsigned long refclk;
-	u32 mf;
+	unsigned long fint, clkdco, clkout;
+	unsigned long target_bitclk, target_clkdco;
+	unsigned long min_dco;
+	unsigned n, m, mf, m2, sd;
+
+	DSSDBG("clkin %lu, target tmds %lu\n", clkin, target_tmds);
+
+	target_bitclk = target_tmds * 10;
 
-	/* use our funky units */
-	clkin /= 10000;
+	/* Fint */
+	n = DIV_ROUND_UP(clkin, pll_feat->fint_max);
+	fint = clkin / n;
 
-	/*
-	 * Input clock is predivided by N + 1
-	 * out put of which is reference clk
-	 */
+	/* adjust m2 so that the clkdco will be high enough */
+	min_dco = roundup(pll_feat->dcofreq_low_min, fint);
+	m2 = DIV_ROUND_UP(min_dco, target_bitclk);
+	if (m2 == 0)
+		m2 = 1;
 
-	pi->regn = HDMI_DEFAULT_REGN;
+	target_clkdco = target_bitclk * m2;
+	m = target_clkdco / fint;
 
-	refclk = clkin / pi->regn;
+	clkdco = fint * m;
 
-	/* temorary hack to make sure DCO freq isn't calculated too low */
-	if (pll_feat->bound_dcofreq && phy <= 65000)
-		pi->regm2 = 3;
+	/* adjust clkdco with fractional mf */
+	if (WARN_ON(target_clkdco - clkdco > fint))
+		mf = 0;
 	else
-		pi->regm2 = HDMI_DEFAULT_REGM2;
-
-	/*
-	 * multiplier is pixel_clk/ref_clk
-	 * Multiplying by 100 to avoid fractional part removal
-	 */
-	pi->regm = phy * pi->regm2 / refclk;
-
-	/*
-	 * fractional multiplier is remainder of the difference between
-	 * multiplier and actual phy(required pixel clock thus should be
-	 * multiplied by 2^18(262144) divided by the reference clock
-	 */
-	mf = (phy - pi->regm / pi->regm2 * refclk) * 262144;
-	pi->regmf = pi->regm2 * mf / refclk;
-
-	/*
-	 * Dcofreq should be set to 1 if required pixel clock
-	 * is greater than 1000MHz
-	 */
-	pi->dcofreq = phy > 1000 * 100;
-	pi->regsd = ((pi->regm * clkin / 10) / (pi->regn * 250) + 5) / 10;
-
-	DSSDBG("M = %d Mf = %d\n", pi->regm, pi->regmf);
-	DSSDBG("range = %d sd = %d\n", pi->dcofreq, pi->regsd);
-}
+		mf = (u32)div_u64(262144ull * (target_clkdco - clkdco), fint);
+
+	if (mf > 0)
+		clkdco += (u32)div_u64((u64)mf * fint, 262144);
 
+	clkout = clkdco / m2;
+
+	/* sigma-delta */
+	sd = DIV_ROUND_UP(fint * m, 250000000);
+
+	DSSDBG("N = %u, M = %u, M.f = %u, M2 = %u, SD = %u\n",
+		n, m, mf, m2, sd);
+	DSSDBG("Fint %lu, clkdco %lu, clkout %lu\n", fint, clkdco, clkout);
+
+	pi->regn = n;
+	pi->regm = m;
+	pi->regmf = mf;
+	pi->regm2 = m2;
+	pi->regsd = sd;
+
+	pi->clkdco = clkdco;
+	pi->clkout = clkout;
+}
 
 static int hdmi_pll_config(struct hdmi_pll_data *pll)
 {
@@ -123,7 +124,7 @@ static int hdmi_pll_config(struct hdmi_pll_data *pll)
 	if (pll_feat->has_refsel)
 		r = FLD_MOD(r, 0x3, 22, 21);	/* REFSEL = SYSCLK */
 
-	if (fmt->dcofreq)
+	if (fmt->clkdco > pll_feat->dcofreq_low_max)
 		r = FLD_MOD(r, 0x4, 3, 1);	/* 1000MHz and 2000MHz */
 	else
 		r = FLD_MOD(r, 0x2, 3, 1);	/* 500MHz and 1000MHz */
@@ -210,7 +211,6 @@ void hdmi_pll_disable(struct hdmi_pll_data *pll, struct hdmi_wp_data *wp)
 
 static const struct hdmi_pll_features omap44xx_pll_feats = {
 	.sys_reset		=	false,
-	.bound_dcofreq		=	false,
 	.fint_min		=	500000,
 	.fint_max		=	2500000,
 	.regm_max		=	4095,
@@ -223,7 +223,6 @@ static const struct hdmi_pll_features omap44xx_pll_feats = {
 static const struct hdmi_pll_features omap54xx_pll_feats = {
 	.has_refsel		=	true,
 	.sys_reset		=	true,
-	.bound_dcofreq		=	true,
 	.fint_min		=	620000,
 	.fint_max		=	2500000,
 	.regm_max		=	2046,
-- 
2.1.3

