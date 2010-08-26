From: "K, Mythri P" <mythripk@ti.com>
Subject: [PATCH 2/2] OMAP:DSS: RFC Patch to add HDMI DSS driver support
Date: Thu, 26 Aug 2010 10:47:33 +0530
Message-ID: <FF55437E1F14DA4BAEB721A458B6701706BE2A6AB4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48402 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751826Ab0HZFRu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Aug 2010 01:17:50 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>

From: Mythri P K <mythripk@ti.com>

This is an RFC patch to add support for HDMI DSS driver in OMAP.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |  292 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 292 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/omap2/dss/hdmi.c

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
new file mode 100644
index 0000000..3d7acd2
--- /dev/null
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -0,0 +1,292 @@
+/*
+ * linux/drivers/video/omap2/dss/hdmi.c
+ *
+ * Copyright (C) 2009 Texas Instruments
+ * Author: Yong Zhi
+ *
+ * HDMI settings from TI's DSS driver
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ * History:
+ * Mythripk <mythripk@ti.com>	-Redesigned on the driver to adhere to DSS2 model.
+ *				-GPIO calls for HDMI.
+ *
+ *
+ */
+
+#define DSS_SUBSYS_NAME "HDMI"
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/mutex.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <plat/display.h>
+#include <plat/cpu.h>
+#include <plat/gpio.h>
+
+#include "dss.h"
+
+static struct {
+	struct mutex lock;
+} hdmi;
+
+#define FLD_GET(val, start, end) (((val) & FLD_MASK(start, end)) >> (end))
+#define FLD_MOD(orig, val, start, end) \
+	(((orig) & ~FLD_MASK(start, end)) | FLD_VAL(val, start, end))
+
+
+#define CPF			2
+
+int hdmi_init_display(struct omap_dss_device *dssdev)
+{
+	DSSDBG("init_display\n");
+
+	return 0;
+}
+
+void compute_hdmi_pll(int clkin, int phy,
+	int n, struct hdmi_pll_info *pi)
+{
+	int refclk;
+	u32 temp, mf;
+
+	if (clkin > 3200) /* 32 mHz */
+		refclk = clkin / (2 * (n + 1));
+	else
+		refclk = clkin / (n + 1);
+
+	temp = phy * 100/(CPF * refclk);
+
+	pi->regn = n;
+	pi->regm = temp/100;
+	pi->regm2 = 1;
+
+	mf = (phy - pi->regm * CPF * refclk) * 262144;
+	pi->regmf = mf/(CPF * refclk);
+
+	if (phy > 1000 * 100) {
+		pi->regm4 = phy / 10000;
+		pi->dcofreq = 1;
+		pi->regsd = ((pi->regm * 384)/((n + 1) * 250) + 5)/10;
+	} else {
+		pi->regm4 = 1;
+		pi->dcofreq = 0;
+		pi->regsd = 0;
+	}
+
+	DSSDBG("M = %d Mf = %d, m4= %d\n", pi->regm, pi->regmf, pi->regm4);
+	DSSDBG("range = %d sd = %d\n", pi->dcofreq, pi->regsd);
+}
+
+
+static void hdmi_enable_clocks(int enable)
+{
+	if (enable)
+		dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M |
+				DSS_CLK_96M);
+	else
+		dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M |
+				DSS_CLK_96M);
+}
+
+static irqreturn_t hdmi_irq_handler(int irq, void *arg)
+{
+	DSSDBG("Will be used in future to handle HPD");
+	return IRQ_HANDLED;
+}
+
+int hdmi_init(struct platform_device *pdev, int code, int mode)
+{
+	int r = 0;
+	DSSDBG("Enter hdmi_init()\n");
+
+	mutex_init(&hdmi.lock);
+
+	r = request_irq(OMAP44XX_IRQ_DSS_HDMI, hdmi_irq_handler,
+			0, "OMAP HDMI", (void *)0);
+
+	return 0;
+
+}
+
+void hdmi_exit(void)
+{
+	free_irq(OMAP44XX_IRQ_DSS_HDMI, NULL);
+
+}
+
+static int hdmi_power_on(struct omap_dss_device *dssdev)
+{
+	hdmi_enable_clocks(1);
+
+	dispc_enable_digit_out(0);
+
+	printk("poweron returns");
+
+	return 0;
+}
+
+int hdmi_dispc_setting(struct omap_dss_device *dssdev)
+{
+
+
+	/* these settings are independent of overlays */
+	dss_switch_tv_hdmi(1);
+
+	/* bypass TV gamma table*/
+	dispc_enable_gamma_table(0);
+
+	/* tv size */
+	dispc_set_digit_size(dssdev->panel.timings.x_res,
+			dssdev->panel.timings.y_res);
+
+
+	dispc_enable_digit_out(1);
+
+	return 0;
+}
+
+static void hdmi_power_off(struct omap_dss_device *dssdev)
+{
+
+	dispc_enable_digit_out(0);
+
+	if (dssdev->platform_disable)
+		dssdev->platform_disable(dssdev);
+
+
+	hdmi_enable_clocks(0);
+
+}
+
+int hdmi_enable_display(struct omap_dss_device *dssdev)
+{
+	int r = 0;
+	DSSDBG("ENTER hdmi_enable_display()\n");
+
+	mutex_lock(&hdmi.lock);
+
+	r = omap_dss_start_device(dssdev);
+	if (r) {
+		DSSDBG("failed to start device\n");
+		return r;
+	}
+
+	free_irq(OMAP44XX_IRQ_DSS_HDMI, NULL);
+
+	/* PAD0_HDMI_HPD_PAD1_HDMI_CEC */
+	omap_writel(0x01180118, 0x4A100098);
+	/* PAD0_HDMI_DDC_SCL_PAD1_HDMI_DDC_SDA */
+	omap_writel(0x01180118 , 0x4A10009C);
+	/* CONTROL_HDMI_TX_PHY */
+	omap_writel(0x10000000, 0x4A100610);
+
+	if (dssdev->platform_enable)
+		dssdev->platform_enable(dssdev);
+
+	r = hdmi_power_on(dssdev);
+	if (r) {
+		DSSERR("failed to power on device\n");
+		goto err;
+	}
+	r = request_irq(OMAP44XX_IRQ_DSS_HDMI, hdmi_irq_handler,
+			0, "OMAP HDMI", (void *)0);
+
+
+err:
+	mutex_unlock(&hdmi.lock);
+	printk("enable display returns");
+	return r;
+
+}
+
+void hdmi_disable_display(struct omap_dss_device *dssdev)
+{
+	DSSDBG("Enter hdmi_disable_display()\n");
+
+	mutex_lock(&hdmi.lock);
+
+	omap_dss_stop_device(dssdev);
+
+	hdmi_power_off(dssdev);
+
+end:
+	mutex_unlock(&hdmi.lock);
+}
+
+int hdmi_display_suspend(struct omap_dss_device *dssdev)
+{
+	int r = 0;
+
+	DSSDBG("hdmi_display_suspend\n");
+		mutex_lock(&hdmi.lock);
+
+	omap_dss_stop_device(dssdev);
+
+	hdmi_power_off(dssdev);
+end:
+	mutex_unlock(&hdmi.lock);
+	return r;
+}
+
+int hdmi_display_resume(struct omap_dss_device *dssdev)
+{
+	int r = 0;
+
+	DSSDBG("hdmi_display_resume\n");
+	mutex_lock(&hdmi.lock);
+
+	/* the tv overlay manager is shared*/
+	r = omap_dss_start_device(dssdev);
+	if (r) {
+		DSSERR("failed to start device\n");
+		goto err;
+	}
+
+	/* PAD0_HDMI_HPD_PAD1_HDMI_CEC */
+	omap_writel(0x01180118, 0x4A100098);
+	/* PAD0_HDMI_DDC_SCL_PAD1_HDMI_DDC_SDA */
+	omap_writel(0x01180118 , 0x4A10009C);
+	/* CONTROL_HDMI_TX_PHY */
+	omap_writel(0x10000000, 0x4A100610);
+
+	if (dssdev->platform_enable)
+		dssdev->platform_enable(dssdev);
+
+	r = hdmi_power_on(dssdev);
+	if (r) {
+		DSSERR("failed to power on device\n");
+		goto err;
+	}
+
+err:
+	mutex_unlock(&hdmi.lock);
+
+	return r;
+}
+
+void hdmi_dump_regs(struct seq_file *s)
+{
+	DSSDBG("0x4a100060 x%x\n", omap_readl(0x4A100060));
+	DSSDBG("0x4A100088 x%x\n", omap_readl(0x4A100088));
+	DSSDBG("0x48055134 x%x\n", omap_readl(0x48055134));
+	DSSDBG("0x48055194 x%x\n", omap_readl(0x48055194));
+}
-- 
1.5.6.3

