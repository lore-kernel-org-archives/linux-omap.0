From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 21/22] OMAPDSS: HDMI: use common DSS PLL support
Date: Wed, 12 Nov 2014 13:52:23 +0200
Message-ID: <1415793144-11723-22-git-send-email-tomi.valkeinen@ti.com>
References: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41999 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648AbaKLLxQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2014 06:53:16 -0500
In-Reply-To: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Now that we have the common DSS PLL support, change HDMI to use it. This
results in quite a lot of changes, but almost all of them are trivial
name changes.

The function to program the PLL settings can be removed from hdmi_pll.c,
as the common PLL API contains the same functionality.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h     |  24 +---
 drivers/video/fbdev/omap2/dss/hdmi4.c    |  55 +++-----
 drivers/video/fbdev/omap2/dss/hdmi5.c    |  56 +++-----
 drivers/video/fbdev/omap2/dss/hdmi_pll.c | 225 ++++++++++++++-----------------
 4 files changed, 146 insertions(+), 214 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index 7595274a9bcf..3c42823e934b 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -184,18 +184,6 @@ struct hdmi_config {
 	enum hdmi_core_hdmi_dvi hdmi_dvi_mode;
 };
 
-/* HDMI PLL structure */
-struct hdmi_pll_info {
-	u16 regn;
-	u16 regm;
-	u32 regmf;
-	u16 regm2;
-	u16 regsd;
-
-	unsigned long clkdco;
-	unsigned long clkout;
-};
-
 struct hdmi_audio_format {
 	enum hdmi_stereo_channels		stereo_channels;
 	u8					active_chnnls_msk;
@@ -246,11 +234,11 @@ struct hdmi_wp_data {
 };
 
 struct hdmi_pll_data {
+	struct dss_pll pll;
+
 	void __iomem *base;
 
 	struct hdmi_wp_data *wp;
-
-	struct hdmi_pll_info info;
 };
 
 struct hdmi_phy_data {
@@ -314,14 +302,12 @@ void hdmi_wp_init_vid_fmt_timings(struct hdmi_video_format *video_fmt,
 int hdmi_wp_init(struct platform_device *pdev, struct hdmi_wp_data *wp);
 
 /* HDMI PLL funcs */
-int hdmi_pll_enable(struct hdmi_pll_data *pll);
-void hdmi_pll_disable(struct hdmi_pll_data *pll);
-int hdmi_pll_set_config(struct hdmi_pll_data *pll);
 void hdmi_pll_dump(struct hdmi_pll_data *pll, struct seq_file *s);
-void hdmi_pll_compute(struct hdmi_pll_data *pll, unsigned long clkin,
-	unsigned long target_tmds);
+void hdmi_pll_compute(struct hdmi_pll_data *pll,
+	unsigned long target_tmds, struct dss_pll_clock_info *pi);
 int hdmi_pll_init(struct platform_device *pdev, struct hdmi_pll_data *pll,
 	struct hdmi_wp_data *wp);
+void hdmi_pll_uninit(struct hdmi_pll_data *hpll);
 
 /* HDMI PHY funcs */
 int hdmi_phy_configure(struct hdmi_phy_data *phy, unsigned long hfbitclk,
diff --git a/drivers/video/fbdev/omap2/dss/hdmi4.c b/drivers/video/fbdev/omap2/dss/hdmi4.c
index 98aa910241b8..46dcc71ce058 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi4.c
@@ -49,7 +49,6 @@ static struct {
 
 	struct hdmi_config cfg;
 
-	struct clk *sys_clk;
 	struct regulator *vdda_hdmi_dac_reg;
 
 	bool core_enabled;
@@ -181,6 +180,7 @@ static int hdmi_power_on_full(struct omap_dss_device *dssdev)
 	struct omap_video_timings *p;
 	struct omap_overlay_manager *mgr = hdmi.output.manager;
 	struct hdmi_wp_data *wp = &hdmi.wp;
+	struct dss_pll_clock_info hdmi_cinfo = { 0 };
 
 	r = hdmi_power_on_core(dssdev);
 	if (r)
@@ -194,22 +194,22 @@ static int hdmi_power_on_full(struct omap_dss_device *dssdev)
 
 	DSSDBG("hdmi_power_on x_res= %d y_res = %d\n", p->x_res, p->y_res);
 
-	hdmi_pll_compute(&hdmi.pll, clk_get_rate(hdmi.sys_clk), p->pixelclock);
+	hdmi_pll_compute(&hdmi.pll, p->pixelclock, &hdmi_cinfo);
 
-	r = hdmi_pll_enable(&hdmi.pll);
+	r = dss_pll_enable(&hdmi.pll.pll);
 	if (r) {
 		DSSERR("Failed to enable PLL\n");
 		goto err_pll_enable;
 	}
 
-	r = hdmi_pll_set_config(&hdmi.pll);
+	r = dss_pll_set_config(&hdmi.pll.pll, &hdmi_cinfo);
 	if (r) {
 		DSSERR("Failed to configure PLL\n");
 		goto err_pll_cfg;
 	}
 
-	r = hdmi_phy_configure(&hdmi.phy, hdmi.pll.info.clkdco,
-		hdmi.pll.info.clkout);
+	r = hdmi_phy_configure(&hdmi.phy, hdmi_cinfo.clkdco,
+		hdmi_cinfo.clkout[0]);
 	if (r) {
 		DSSDBG("Failed to configure PHY\n");
 		goto err_phy_cfg;
@@ -247,7 +247,7 @@ err_phy_cfg:
 	hdmi_wp_set_phy_pwr(&hdmi.wp, HDMI_PHYPWRCMD_OFF);
 err_phy_pwr:
 err_pll_cfg:
-	hdmi_pll_disable(&hdmi.pll);
+	dss_pll_disable(&hdmi.pll.pll);
 err_pll_enable:
 	hdmi_power_off_core(dssdev);
 	return -EIO;
@@ -265,7 +265,7 @@ static void hdmi_power_off_full(struct omap_dss_device *dssdev)
 
 	hdmi_wp_set_phy_pwr(&hdmi.wp, HDMI_PHYPWRCMD_OFF);
 
-	hdmi_pll_disable(&hdmi.pll);
+	dss_pll_disable(&hdmi.pll.pll);
 
 	hdmi_power_off_core(dssdev);
 }
@@ -407,21 +407,6 @@ static void hdmi_core_disable(struct omap_dss_device *dssdev)
 	mutex_unlock(&hdmi.lock);
 }
 
-static int hdmi_get_clocks(struct platform_device *pdev)
-{
-	struct clk *clk;
-
-	clk = devm_clk_get(&pdev->dev, "sys_clk");
-	if (IS_ERR(clk)) {
-		DSSERR("can't get sys_clk\n");
-		return PTR_ERR(clk);
-	}
-
-	hdmi.sys_clk = clk;
-
-	return 0;
-}
-
 static int hdmi_connect(struct omap_dss_device *dssdev,
 		struct omap_dss_device *dst)
 {
@@ -700,22 +685,17 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 
 	r = hdmi_phy_init(pdev, &hdmi.phy);
 	if (r)
-		return r;
+		goto err;
 
 	r = hdmi4_core_init(pdev, &hdmi.core);
 	if (r)
-		return r;
-
-	r = hdmi_get_clocks(pdev);
-	if (r) {
-		DSSERR("can't get clocks\n");
-		return r;
-	}
+		goto err;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		DSSERR("platform_get_irq failed\n");
-		return -ENODEV;
+		r = -ENODEV;
+		goto err;
 	}
 
 	r = devm_request_threaded_irq(&pdev->dev, irq,
@@ -723,7 +703,7 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 			IRQF_ONESHOT, "OMAP HDMI", &hdmi.wp);
 	if (r) {
 		DSSERR("HDMI IRQ request failed\n");
-		return r;
+		goto err;
 	}
 
 	pm_runtime_enable(&pdev->dev);
@@ -733,12 +713,17 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 	dss_debugfs_create_file("hdmi", hdmi_dump_regs);
 
 	return 0;
+err:
+	hdmi_pll_uninit(&hdmi.pll);
+	return r;
 }
 
 static int __exit omapdss_hdmihw_remove(struct platform_device *pdev)
 {
 	hdmi_uninit_output(pdev);
 
+	hdmi_pll_uninit(&hdmi.pll);
+
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
@@ -746,8 +731,6 @@ static int __exit omapdss_hdmihw_remove(struct platform_device *pdev)
 
 static int hdmi_runtime_suspend(struct device *dev)
 {
-	clk_disable_unprepare(hdmi.sys_clk);
-
 	dispc_runtime_put();
 
 	return 0;
@@ -761,8 +744,6 @@ static int hdmi_runtime_resume(struct device *dev)
 	if (r < 0)
 		return r;
 
-	clk_prepare_enable(hdmi.sys_clk);
-
 	return 0;
 }
 
diff --git a/drivers/video/fbdev/omap2/dss/hdmi5.c b/drivers/video/fbdev/omap2/dss/hdmi5.c
index facc4e070520..67facf87b370 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5.c
@@ -54,8 +54,8 @@ static struct {
 
 	struct hdmi_config cfg;
 
-	struct clk *sys_clk;
 	struct regulator *vdda_reg;
+	struct clk *sys_clk;
 
 	bool core_enabled;
 
@@ -198,6 +198,7 @@ static int hdmi_power_on_full(struct omap_dss_device *dssdev)
 	int r;
 	struct omap_video_timings *p;
 	struct omap_overlay_manager *mgr = hdmi.output.manager;
+	struct dss_pll_clock_info hdmi_cinfo = { 0 };
 
 	r = hdmi_power_on_core(dssdev);
 	if (r)
@@ -207,27 +208,27 @@ static int hdmi_power_on_full(struct omap_dss_device *dssdev)
 
 	DSSDBG("hdmi_power_on x_res= %d y_res = %d\n", p->x_res, p->y_res);
 
-	hdmi_pll_compute(&hdmi.pll, clk_get_rate(hdmi.sys_clk), p->pixelclock);
+	hdmi_pll_compute(&hdmi.pll, p->pixelclock, &hdmi_cinfo);
 
 	/* disable and clear irqs */
 	hdmi_wp_clear_irqenable(&hdmi.wp, 0xffffffff);
 	hdmi_wp_set_irqstatus(&hdmi.wp,
 			hdmi_wp_get_irqstatus(&hdmi.wp));
 
-	r = hdmi_pll_enable(&hdmi.pll);
+	r = dss_pll_enable(&hdmi.pll.pll);
 	if (r) {
 		DSSERR("Failed to enable PLL\n");
 		goto err_pll_enable;
 	}
 
-	r = hdmi_pll_set_config(&hdmi.pll);
+	r = dss_pll_set_config(&hdmi.pll.pll, &hdmi_cinfo);
 	if (r) {
 		DSSERR("Failed to configure PLL\n");
 		goto err_pll_cfg;
 	}
 
-	r = hdmi_phy_configure(&hdmi.phy, hdmi.pll.info.clkdco,
-		hdmi.pll.info.clkout);
+	r = hdmi_phy_configure(&hdmi.phy, hdmi_cinfo.clkdco,
+		hdmi_cinfo.clkout[0]);
 	if (r) {
 		DSSDBG("Failed to start PHY\n");
 		goto err_phy_cfg;
@@ -265,7 +266,7 @@ err_vid_enable:
 err_phy_pwr:
 err_phy_cfg:
 err_pll_cfg:
-	hdmi_pll_disable(&hdmi.pll);
+	dss_pll_disable(&hdmi.pll.pll);
 err_pll_enable:
 	hdmi_power_off_core(dssdev);
 	return -EIO;
@@ -283,7 +284,7 @@ static void hdmi_power_off_full(struct omap_dss_device *dssdev)
 
 	hdmi_wp_set_phy_pwr(&hdmi.wp, HDMI_PHYPWRCMD_OFF);
 
-	hdmi_pll_disable(&hdmi.pll);
+	dss_pll_disable(&hdmi.pll.pll);
 
 	hdmi_power_off_core(dssdev);
 }
@@ -436,21 +437,6 @@ static void hdmi_core_disable(struct omap_dss_device *dssdev)
 	mutex_unlock(&hdmi.lock);
 }
 
-static int hdmi_get_clocks(struct platform_device *pdev)
-{
-	struct clk *clk;
-
-	clk = devm_clk_get(&pdev->dev, "sys_clk");
-	if (IS_ERR(clk)) {
-		DSSERR("can't get sys_clk\n");
-		return PTR_ERR(clk);
-	}
-
-	hdmi.sys_clk = clk;
-
-	return 0;
-}
-
 static int hdmi_connect(struct omap_dss_device *dssdev,
 		struct omap_dss_device *dst)
 {
@@ -729,22 +715,17 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 
 	r = hdmi_phy_init(pdev, &hdmi.phy);
 	if (r)
-		return r;
+		goto err;
 
 	r = hdmi5_core_init(pdev, &hdmi.core);
 	if (r)
-		return r;
-
-	r = hdmi_get_clocks(pdev);
-	if (r) {
-		DSSERR("can't get clocks\n");
-		return r;
-	}
+		goto err;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		DSSERR("platform_get_irq failed\n");
-		return -ENODEV;
+		r = -ENODEV;
+		goto err;
 	}
 
 	r = devm_request_threaded_irq(&pdev->dev, irq,
@@ -752,7 +733,7 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 			IRQF_ONESHOT, "OMAP HDMI", &hdmi.wp);
 	if (r) {
 		DSSERR("HDMI IRQ request failed\n");
-		return r;
+		goto err;
 	}
 
 	pm_runtime_enable(&pdev->dev);
@@ -762,12 +743,17 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 	dss_debugfs_create_file("hdmi", hdmi_dump_regs);
 
 	return 0;
+err:
+	hdmi_pll_uninit(&hdmi.pll);
+	return r;
 }
 
 static int __exit omapdss_hdmihw_remove(struct platform_device *pdev)
 {
 	hdmi_uninit_output(pdev);
 
+	hdmi_pll_uninit(&hdmi.pll);
+
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
@@ -775,8 +761,6 @@ static int __exit omapdss_hdmihw_remove(struct platform_device *pdev)
 
 static int hdmi_runtime_suspend(struct device *dev)
 {
-	clk_disable_unprepare(hdmi.sys_clk);
-
 	dispc_runtime_put();
 
 	return 0;
@@ -790,8 +774,6 @@ static int hdmi_runtime_resume(struct device *dev)
 	if (r < 0)
 		return r;
 
-	clk_prepare_enable(hdmi.sys_clk);
-
 	return 0;
 }
 
diff --git a/drivers/video/fbdev/omap2/dss/hdmi_pll.c b/drivers/video/fbdev/omap2/dss/hdmi_pll.c
index 92d22252f86a..87accdb59c81 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi_pll.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi_pll.c
@@ -15,22 +15,13 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/clk.h>
+
 #include <video/omapdss.h>
 
 #include "dss.h"
 #include "hdmi.h"
 
-struct hdmi_pll_features {
-	bool has_refsel;
-	bool sys_reset;
-	unsigned long fint_min, fint_max;
-	u16 regm_max;
-	unsigned long dcofreq_low_min, dcofreq_low_max;
-	unsigned long dcofreq_high_min, dcofreq_high_max;
-};
-
-static const struct hdmi_pll_features *pll_feat;
-
 void hdmi_pll_dump(struct hdmi_pll_data *pll, struct seq_file *s)
 {
 #define DUMPPLL(r) seq_printf(s, "%-35s %08x\n", #r,\
@@ -47,25 +38,28 @@ void hdmi_pll_dump(struct hdmi_pll_data *pll, struct seq_file *s)
 	DUMPPLL(PLLCTRL_CFG4);
 }
 
-void hdmi_pll_compute(struct hdmi_pll_data *pll, unsigned long clkin,
-	unsigned long target_tmds)
+void hdmi_pll_compute(struct hdmi_pll_data *pll,
+	unsigned long target_tmds, struct dss_pll_clock_info *pi)
 {
-	struct hdmi_pll_info *pi = &pll->info;
 	unsigned long fint, clkdco, clkout;
 	unsigned long target_bitclk, target_clkdco;
 	unsigned long min_dco;
 	unsigned n, m, mf, m2, sd;
+	unsigned long clkin;
+	const struct dss_pll_hw *hw = pll->pll.hw;
+
+	clkin = clk_get_rate(pll->pll.clkin);
 
 	DSSDBG("clkin %lu, target tmds %lu\n", clkin, target_tmds);
 
 	target_bitclk = target_tmds * 10;
 
 	/* Fint */
-	n = DIV_ROUND_UP(clkin, pll_feat->fint_max);
+	n = DIV_ROUND_UP(clkin, hw->fint_max);
 	fint = clkin / n;
 
 	/* adjust m2 so that the clkdco will be high enough */
-	min_dco = roundup(pll_feat->dcofreq_low_min, fint);
+	min_dco = roundup(hw->clkdco_min, fint);
 	m2 = DIV_ROUND_UP(min_dco, target_bitclk);
 	if (m2 == 0)
 		m2 = 1;
@@ -93,81 +87,20 @@ void hdmi_pll_compute(struct hdmi_pll_data *pll, unsigned long clkin,
 		n, m, mf, m2, sd);
 	DSSDBG("Fint %lu, clkdco %lu, clkout %lu\n", fint, clkdco, clkout);
 
-	pi->regn = n;
-	pi->regm = m;
-	pi->regmf = mf;
-	pi->regm2 = m2;
-	pi->regsd = sd;
+	pi->n = n;
+	pi->m = m;
+	pi->mf = mf;
+	pi->mX[0] = m2;
+	pi->sd = sd;
 
+	pi->fint = fint;
 	pi->clkdco = clkdco;
-	pi->clkout = clkout;
-}
-
-int hdmi_pll_set_config(struct hdmi_pll_data *pll)
-{
-	u32 r;
-	struct hdmi_pll_info *fmt = &pll->info;
-
-	/* PLL start always use manual mode */
-	REG_FLD_MOD(pll->base, PLLCTRL_PLL_CONTROL, 0x0, 0, 0);
-
-	r = hdmi_read_reg(pll->base, PLLCTRL_CFG1);
-	r = FLD_MOD(r, fmt->regm, 20, 9);	/* CFG1_PLL_REGM */
-	r = FLD_MOD(r, fmt->regn - 1, 8, 1);	/* CFG1_PLL_REGN */
-	hdmi_write_reg(pll->base, PLLCTRL_CFG1, r);
-
-	r = hdmi_read_reg(pll->base, PLLCTRL_CFG2);
-
-	r = FLD_MOD(r, 0x0, 12, 12);	/* PLL_HIGHFREQ divide by 2 */
-	r = FLD_MOD(r, 0x1, 13, 13);	/* PLL_REFEN */
-	r = FLD_MOD(r, 0x0, 14, 14);	/* PHY_CLKINEN de-assert during locking */
-	if (pll_feat->has_refsel)
-		r = FLD_MOD(r, 0x3, 22, 21);	/* REFSEL = SYSCLK */
-
-	if (fmt->clkdco > pll_feat->dcofreq_low_max)
-		r = FLD_MOD(r, 0x4, 3, 1);	/* 1000MHz and 2000MHz */
-	else
-		r = FLD_MOD(r, 0x2, 3, 1);	/* 500MHz and 1000MHz */
-
-	hdmi_write_reg(pll->base, PLLCTRL_CFG2, r);
-
-	REG_FLD_MOD(pll->base, PLLCTRL_CFG3, fmt->regsd, 17, 10);
-
-	r = hdmi_read_reg(pll->base, PLLCTRL_CFG4);
-	r = FLD_MOD(r, fmt->regm2, 24, 18);
-	r = FLD_MOD(r, fmt->regmf, 17, 0);
-	hdmi_write_reg(pll->base, PLLCTRL_CFG4, r);
-
-	/* go now */
-	REG_FLD_MOD(pll->base, PLLCTRL_PLL_GO, 0x1, 0, 0);
-
-	/* wait for bit change */
-	if (hdmi_wait_for_bit_change(pll->base, PLLCTRL_PLL_GO,
-			0, 0, 0) != 0) {
-		DSSERR("PLL GO bit not clearing\n");
-		return -ETIMEDOUT;
-	}
-
-	/* Wait till the lock bit is set in PLL status */
-	if (hdmi_wait_for_bit_change(pll->base,
-			PLLCTRL_PLL_STATUS, 1, 1, 1) != 1) {
-		DSSERR("cannot lock PLL\n");
-		DSSERR("CFG1 0x%x\n",
-			hdmi_read_reg(pll->base, PLLCTRL_CFG1));
-		DSSERR("CFG2 0x%x\n",
-			hdmi_read_reg(pll->base, PLLCTRL_CFG2));
-		DSSERR("CFG4 0x%x\n",
-			hdmi_read_reg(pll->base, PLLCTRL_CFG4));
-		return -ETIMEDOUT;
-	}
-
-	DSSDBG("PLL locked!\n");
-
-	return 0;
+	pi->clkout[0] = clkout;
 }
 
-int hdmi_pll_enable(struct hdmi_pll_data *pll)
+static int hdmi_pll_enable(struct dss_pll *dsspll)
 {
+	struct hdmi_pll_data *pll = container_of(dsspll, struct hdmi_pll_data, pll);
 	struct hdmi_wp_data *wp = pll->wp;
 	u16 r = 0;
 
@@ -178,64 +111,105 @@ int hdmi_pll_enable(struct hdmi_pll_data *pll)
 	return 0;
 }
 
-void hdmi_pll_disable(struct hdmi_pll_data *pll)
+static void hdmi_pll_disable(struct dss_pll *dsspll)
 {
+	struct hdmi_pll_data *pll = container_of(dsspll, struct hdmi_pll_data, pll);
 	struct hdmi_wp_data *wp = pll->wp;
 
 	hdmi_wp_set_pll_pwr(wp, HDMI_PLLPWRCMD_ALLOFF);
 }
 
-static const struct hdmi_pll_features omap44xx_pll_feats = {
-	.sys_reset		=	false,
-	.fint_min		=	500000,
-	.fint_max		=	2500000,
-	.regm_max		=	4095,
-	.dcofreq_low_min	=	500000000,
-	.dcofreq_low_max	=	1000000000,
-	.dcofreq_high_min	=	1000000000,
-	.dcofreq_high_max	=	2000000000,
+static const struct dss_pll_ops dsi_pll_ops = {
+	.enable = hdmi_pll_enable,
+	.disable = hdmi_pll_disable,
+	.set_config = dss_pll_write_config_type_b,
+};
+
+static const struct dss_pll_hw dss_omap4_hdmi_pll_hw = {
+	.n_max = 255,
+	.m_min = 20,
+	.m_max = 4095,
+	.mX_max = 127,
+	.fint_min = 500000,
+	.fint_max = 2500000,
+	.clkdco_max = 1800000000,
+
+	.clkdco_min = 500000000,
+	.clkdco_low = 1000000000,
+	.clkdco_max = 2000000000,
+
+	.n_msb = 8,
+	.n_lsb = 1,
+	.m_msb = 20,
+	.m_lsb = 9,
+
+	.mX_msb[0] = 24,
+	.mX_lsb[0] = 18,
+
+	.has_selfreqdco = true,
 };
 
-static const struct hdmi_pll_features omap54xx_pll_feats = {
-	.has_refsel		=	true,
-	.sys_reset		=	true,
-	.fint_min		=	620000,
-	.fint_max		=	2500000,
-	.regm_max		=	2046,
-	.dcofreq_low_min	=	750000000,
-	.dcofreq_low_max	=	1500000000,
-	.dcofreq_high_min	=	1250000000,
-	.dcofreq_high_max	=	2500000000UL,
+static const struct dss_pll_hw dss_omap5_hdmi_pll_hw = {
+	.n_max = 255,
+	.m_min = 20,
+	.m_max = 2045,
+	.mX_max = 127,
+	.fint_min = 620000,
+	.fint_max = 2500000,
+	.clkdco_max = 1800000000,
+
+	.clkdco_min = 750000000,
+	.clkdco_low = 1500000000,
+	.clkdco_max = 2500000000UL,
+
+	.n_msb = 8,
+	.n_lsb = 1,
+	.m_msb = 20,
+	.m_lsb = 9,
+
+	.mX_msb[0] = 24,
+	.mX_lsb[0] = 18,
+
+	.has_selfreqdco = true,
+	.has_refsel = true,
 };
 
-static int hdmi_pll_init_features(struct platform_device *pdev)
+static int dsi_init_pll_data(struct platform_device *pdev, struct hdmi_pll_data *hpll)
 {
-	struct hdmi_pll_features *dst;
-	const struct hdmi_pll_features *src;
+	struct dss_pll *pll = &hpll->pll;
+	struct clk *clk;
+	int r;
 
-	dst = devm_kzalloc(&pdev->dev, sizeof(*dst), GFP_KERNEL);
-	if (!dst) {
-		dev_err(&pdev->dev, "Failed to allocate HDMI PHY Features\n");
-		return -ENOMEM;
+	clk = devm_clk_get(&pdev->dev, "sys_clk");
+	if (IS_ERR(clk)) {
+		DSSERR("can't get sys_clk\n");
+		return PTR_ERR(clk);
 	}
 
+	pll->name = "hdmi";
+	pll->base = hpll->base;
+	pll->clkin = clk;
+
 	switch (omapdss_get_version()) {
 	case OMAPDSS_VER_OMAP4430_ES1:
 	case OMAPDSS_VER_OMAP4430_ES2:
 	case OMAPDSS_VER_OMAP4:
-		src = &omap44xx_pll_feats;
+		pll->hw = &dss_omap4_hdmi_pll_hw;
 		break;
 
 	case OMAPDSS_VER_OMAP5:
-		src = &omap54xx_pll_feats;
+		pll->hw = &dss_omap5_hdmi_pll_hw;
 		break;
 
 	default:
 		return -ENODEV;
 	}
 
-	memcpy(dst, src, sizeof(*dst));
-	pll_feat = dst;
+	pll->ops = &dsi_pll_ops;
+
+	r = dss_pll_register(pll);
+	if (r)
+		return r;
 
 	return 0;
 }
@@ -248,10 +222,6 @@ int hdmi_pll_init(struct platform_device *pdev, struct hdmi_pll_data *pll,
 
 	pll->wp = wp;
 
-	r = hdmi_pll_init_features(pdev);
-	if (r)
-		return r;
-
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pll");
 	if (!res) {
 		DSSERR("can't get PLL mem resource\n");
@@ -264,5 +234,18 @@ int hdmi_pll_init(struct platform_device *pdev, struct hdmi_pll_data *pll,
 		return PTR_ERR(pll->base);
 	}
 
+	r = dsi_init_pll_data(pdev, pll);
+	if (r) {
+		DSSERR("failed to init HDMI PLL\n");
+		return r;
+	}
+
 	return 0;
 }
+
+void hdmi_pll_uninit(struct hdmi_pll_data *hpll)
+{
+	struct dss_pll *pll = &hpll->pll;
+
+	dss_pll_unregister(pll);
+}
-- 
2.1.3

