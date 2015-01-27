From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 10/14] OMAPDSS: Add Video PLLs for DRA7xx
Date: Tue, 27 Jan 2015 12:50:38 +0200
Message-ID: <1422355842-11234-11-git-send-email-tomi.valkeinen@ti.com>
References: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35774 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757736AbbA0KvJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Jan 2015 05:51:09 -0500
In-Reply-To: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

DRA7xx SoCs have one (DRA72x) or two (DRA74x) video PLLs. They are
basically the same as DSI PLLs on OMAPs, but without the rest of the DSI
hardware. The video PLLs also require some configuration via the CONTROL
module.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/Makefile    |   2 +-
 drivers/video/fbdev/omap2/dss/dss.c       |  58 +++++++-
 drivers/video/fbdev/omap2/dss/dss.h       |   8 ++
 drivers/video/fbdev/omap2/dss/video-pll.c | 211 ++++++++++++++++++++++++++++++
 4 files changed, 273 insertions(+), 6 deletions(-)
 create mode 100644 drivers/video/fbdev/omap2/dss/video-pll.c

diff --git a/drivers/video/fbdev/omap2/dss/Makefile b/drivers/video/fbdev/omap2/dss/Makefile
index 2ea9d382354c..b5136d3d4b77 100644
--- a/drivers/video/fbdev/omap2/dss/Makefile
+++ b/drivers/video/fbdev/omap2/dss/Makefile
@@ -2,7 +2,7 @@ obj-$(CONFIG_OMAP2_DSS_INIT) += omapdss-boot-init.o
 obj-$(CONFIG_OMAP2_DSS) += omapdss.o
 # Core DSS files
 omapdss-y := core.o dss.o dss_features.o dispc.o dispc_coefs.o display.o \
-	output.o dss-of.o pll.o
+	output.o dss-of.o pll.o video-pll.o
 # DSS compat layer files
 omapdss-y += manager.o manager-sysfs.o overlay.o overlay-sysfs.o apply.o \
 	dispc-compat.o display-sysfs.o
diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
index d75238f2c537..a6d10d4279f3 100644
--- a/drivers/video/fbdev/omap2/dss/dss.c
+++ b/drivers/video/fbdev/omap2/dss/dss.c
@@ -37,6 +37,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 #include <linux/of.h>
+#include <linux/regulator/consumer.h>
 
 #include <video/omapdss.h>
 
@@ -65,9 +66,6 @@ struct dss_reg {
 #define REG_FLD_MOD(idx, val, start, end) \
 	dss_write_reg(idx, FLD_MOD(dss_read_reg(idx), val, start, end))
 
-static int dss_runtime_get(void);
-static void dss_runtime_put(void);
-
 struct dss_features {
 	u8 fck_div_max;
 	u8 dss_fck_multiplier;
@@ -99,6 +97,9 @@ static struct {
 	u32		ctx[DSS_SZ_REGS / sizeof(u32)];
 
 	const struct dss_features *feat;
+
+	struct dss_pll	*video1_pll;
+	struct dss_pll	*video2_pll;
 } dss;
 
 static const char * const dss_generic_clk_source_names[] = {
@@ -760,7 +761,7 @@ static void dss_put_clocks(void)
 		clk_put(dss.parent_clk);
 }
 
-static int dss_runtime_get(void)
+int dss_runtime_get(void)
 {
 	int r;
 
@@ -771,7 +772,7 @@ static int dss_runtime_get(void)
 	return r < 0 ? r : 0;
 }
 
-static void dss_runtime_put(void)
+void dss_runtime_put(void)
 {
 	int r;
 
@@ -1023,6 +1024,7 @@ static int __init omap_dsshw_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	u32 rev;
 	int r;
+	struct regulator *pll_regulator;
 
 	dss.pdev = pdev;
 
@@ -1094,6 +1096,40 @@ static int __init omap_dsshw_probe(struct platform_device *pdev)
 		}
 	}
 
+	pll_regulator = devm_regulator_get(&pdev->dev, "vdda_video");
+	if (IS_ERR(pll_regulator)) {
+		r = PTR_ERR(pll_regulator);
+
+		switch (r) {
+		case -ENOENT:
+			pll_regulator = NULL;
+			break;
+
+		case -EPROBE_DEFER:
+			return -EPROBE_DEFER;
+
+		default:
+			DSSERR("can't get DPLL VDDA regulator\n");
+			return r;
+		}
+	}
+
+	if (of_property_match_string(np, "reg-names", "pll1") >= 0) {
+		dss.video1_pll = dss_video_pll_init(pdev, 0, pll_regulator);
+		if (IS_ERR(dss.video1_pll)) {
+			r = PTR_ERR(dss.video1_pll);
+			goto err_pll_init;
+		}
+	}
+
+	if (of_property_match_string(np, "reg-names", "pll2") >= 0) {
+		dss.video2_pll = dss_video_pll_init(pdev, 1, pll_regulator);
+		if (IS_ERR(dss.video2_pll)) {
+			r = PTR_ERR(dss.video2_pll);
+			goto err_pll_init;
+		}
+	}
+
 	rev = dss_read_reg(DSS_REVISION);
 	printk(KERN_INFO "OMAP DSS rev %d.%d\n",
 			FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
@@ -1104,6 +1140,12 @@ static int __init omap_dsshw_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_pll_init:
+	if (dss.video1_pll)
+		dss_video_pll_uninit(dss.video1_pll);
+
+	if (dss.video2_pll)
+		dss_video_pll_uninit(dss.video2_pll);
 err_runtime_get:
 	pm_runtime_disable(&pdev->dev);
 err_setup_clocks:
@@ -1113,6 +1155,12 @@ err_setup_clocks:
 
 static int __exit omap_dsshw_remove(struct platform_device *pdev)
 {
+	if (dss.video1_pll)
+		dss_video_pll_uninit(dss.video1_pll);
+
+	if (dss.video2_pll)
+		dss_video_pll_uninit(dss.video2_pll);
+
 	dss_uninit_ports(pdev);
 
 	pm_runtime_disable(&pdev->dev);
diff --git a/drivers/video/fbdev/omap2/dss/dss.h b/drivers/video/fbdev/omap2/dss/dss.h
index 76a6eb1da090..4812eee2622a 100644
--- a/drivers/video/fbdev/omap2/dss/dss.h
+++ b/drivers/video/fbdev/omap2/dss/dss.h
@@ -259,6 +259,9 @@ void dss_overlay_kobj_uninit(struct omap_overlay *ovl);
 int dss_init_platform_driver(void) __init;
 void dss_uninit_platform_driver(void);
 
+int dss_runtime_get(void);
+void dss_runtime_put(void);
+
 unsigned long dss_get_dispc_clk_rate(void);
 int dss_dpi_select_source(int port, enum omap_channel channel);
 void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select);
@@ -266,6 +269,11 @@ enum dss_hdmi_venc_clk_source_select dss_get_hdmi_venc_clk_source(void);
 const char *dss_get_generic_clk_source_name(enum omap_dss_clk_source clk_src);
 void dss_dump_clocks(struct seq_file *s);
 
+/* DSS VIDEO PLL */
+struct dss_pll *dss_video_pll_init(struct platform_device *pdev, int id,
+	struct regulator *regulator);
+void dss_video_pll_uninit(struct dss_pll *pll);
+
 /* dss-of */
 struct device_node *dss_of_port_get_parent_device(struct device_node *port);
 u32 dss_of_port_get_port_number(struct device_node *port);
diff --git a/drivers/video/fbdev/omap2/dss/video-pll.c b/drivers/video/fbdev/omap2/dss/video-pll.c
new file mode 100644
index 000000000000..b1ec59e42940
--- /dev/null
+++ b/drivers/video/fbdev/omap2/dss/video-pll.c
@@ -0,0 +1,211 @@
+/*
+* Copyright (C) 2014 Texas Instruments Ltd
+*
+* This program is free software; you can redistribute it and/or modify it
+* under the terms of the GNU General Public License version 2 as published by
+* the Free Software Foundation.
+*
+* You should have received a copy of the GNU General Public License along with
+* this program.  If not, see <http://www.gnu.org/licenses/>.
+*/
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/sched.h>
+
+#include <video/omapdss.h>
+
+#include "dss.h"
+#include "dss_features.h"
+
+struct dss_video_pll {
+	struct dss_pll pll;
+
+	struct device *dev;
+
+	void __iomem *clkctrl_base;
+};
+
+#define REG_MOD(reg, val, start, end) \
+	writel_relaxed(FLD_MOD(readl_relaxed(reg), val, start, end), reg)
+
+static void dss_dpll_enable_scp_clk(struct dss_video_pll *vpll)
+{
+	REG_MOD(vpll->clkctrl_base, 1, 14, 14); /* CIO_CLK_ICG */
+}
+
+static void dss_dpll_disable_scp_clk(struct dss_video_pll *vpll)
+{
+	REG_MOD(vpll->clkctrl_base, 0, 14, 14); /* CIO_CLK_ICG */
+}
+
+static void dss_dpll_power_enable(struct dss_video_pll *vpll)
+{
+	REG_MOD(vpll->clkctrl_base, 2, 31, 30); /* PLL_POWER_ON_ALL */
+
+	/*
+	 * DRA7x PLL CTRL's PLL_PWR_STATUS seems to always return 0,
+	 * so we have to use fixed delay here.
+	 */
+	msleep(1);
+}
+
+static void dss_dpll_power_disable(struct dss_video_pll *vpll)
+{
+	REG_MOD(vpll->clkctrl_base, 0, 31, 30);	/* PLL_POWER_OFF */
+}
+
+static int dss_video_pll_enable(struct dss_pll *pll)
+{
+	struct dss_video_pll *vpll = container_of(pll, struct dss_video_pll, pll);
+	int r;
+
+	r = dss_runtime_get();
+	if (r)
+		return r;
+
+	dss_ctrl_pll_enable(pll->id, true);
+
+	dss_dpll_enable_scp_clk(vpll);
+
+	r = dss_pll_wait_reset_done(pll);
+	if (r)
+		goto err_reset;
+
+	dss_dpll_power_enable(vpll);
+
+	return 0;
+
+err_reset:
+	dss_dpll_disable_scp_clk(vpll);
+	dss_ctrl_pll_enable(pll->id, false);
+	dss_runtime_put();
+
+	return r;
+}
+
+static void dss_video_pll_disable(struct dss_pll *pll)
+{
+	struct dss_video_pll *vpll = container_of(pll, struct dss_video_pll, pll);
+
+	dss_dpll_power_disable(vpll);
+
+	dss_dpll_disable_scp_clk(vpll);
+
+	dss_ctrl_pll_enable(pll->id, false);
+
+	dss_runtime_put();
+}
+
+static const struct dss_pll_ops dss_pll_ops = {
+	.enable = dss_video_pll_enable,
+	.disable = dss_video_pll_disable,
+	.set_config = dss_pll_write_config_type_a,
+};
+
+static const struct dss_pll_hw dss_dra7_video_pll_hw = {
+	.n_max = (1 << 8) - 1,
+	.m_max = (1 << 12) - 1,
+	.mX_max = (1 << 5) - 1,
+	.fint_min = 500000,
+	.fint_max = 2500000,
+	.clkdco_max = 1800000000,
+
+	.n_msb = 8,
+	.n_lsb = 1,
+	.m_msb = 20,
+	.m_lsb = 9,
+
+	.mX_msb[0] = 25,
+	.mX_lsb[0] = 21,
+	.mX_msb[1] = 30,
+	.mX_lsb[1] = 26,
+
+	.has_refsel = true,
+};
+
+struct dss_pll *dss_video_pll_init(struct platform_device *pdev, int id,
+	struct regulator *regulator)
+{
+	const char * const reg_name[] = { "pll1", "pll2" };
+	const char * const clkctrl_name[] = { "pll1_clkctrl", "pll2_clkctrl" };
+	const char * const clkin_name[] = { "video1_clk", "video2_clk" };
+
+	struct resource *res;
+	struct dss_video_pll *vpll;
+	void __iomem *pll_base, *clkctrl_base;
+	struct clk *clk;
+	struct dss_pll *pll;
+	int r;
+
+	/* PLL CONTROL */
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, reg_name[id]);
+	if (!res) {
+		dev_err(&pdev->dev,
+			"missing platform resource data for pll%d\n", id);
+		return ERR_PTR(-ENODEV);
+	}
+
+	pll_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pll_base)) {
+		dev_err(&pdev->dev, "failed to ioremap pll%d reg_name\n", id);
+		return ERR_CAST(pll_base);
+	}
+
+	/* CLOCK CONTROL */
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+		clkctrl_name[id]);
+	if (!res) {
+		dev_err(&pdev->dev,
+			"missing platform resource data for pll%d\n", id);
+		return ERR_PTR(-ENODEV);
+	}
+
+	clkctrl_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(clkctrl_base)) {
+		dev_err(&pdev->dev, "failed to ioremap pll%d clkctrl\n", id);
+		return ERR_CAST(clkctrl_base);
+	}
+
+	/* CLKIN */
+
+	clk = devm_clk_get(&pdev->dev, clkin_name[id]);
+	if (IS_ERR(clk)) {
+		DSSERR("can't get video pll clkin\n");
+		return ERR_CAST(clk);
+	}
+
+	vpll = devm_kzalloc(&pdev->dev, sizeof(*vpll), GFP_KERNEL);
+	if (!vpll)
+		return ERR_PTR(-ENOMEM);
+
+	vpll->dev = &pdev->dev;
+	vpll->clkctrl_base = clkctrl_base;
+
+	pll = &vpll->pll;
+
+	pll->name = id == 0 ? "video0" : "video1";
+	pll->id = id == 0 ? DSS_PLL_VIDEO1 : DSS_PLL_VIDEO2;
+	pll->clkin = clk;
+	pll->regulator = regulator;
+	pll->base = pll_base;
+	pll->hw = &dss_dra7_video_pll_hw;
+	pll->ops = &dss_pll_ops;
+
+	r = dss_pll_register(pll);
+	if (r)
+		return ERR_PTR(r);
+
+	return pll;
+}
+
+void dss_video_pll_uninit(struct dss_pll *pll)
+{
+	dss_pll_unregister(pll);
+}
-- 
2.2.2

