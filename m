From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 12/22] OMAPDSS: Add common PLL code
Date: Wed, 12 Nov 2014 13:52:14 +0200
Message-ID: <1415793144-11723-13-git-send-email-tomi.valkeinen@ti.com>
References: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41990 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467AbaKLLxD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2014 06:53:03 -0500
In-Reply-To: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

OMAP DSS currently contains two different PLLs: DSI PLL (Type A PLL) and
HDMI PLL (Type B PLL). When DRA7 support is added, we will also support
Video PLLs (Type A).

The driver currently handles all PLLs totally separately. This patch
adds common DSS PLL code, which

a) lets us have common code for the PLLs
b) lets the users of the PLLs use a common API, instead of DSI API or
   HDMI API.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/Makefile |   2 +-
 drivers/video/fbdev/omap2/dss/dss.h    |  88 ++++++++
 drivers/video/fbdev/omap2/dss/pll.c    | 378 +++++++++++++++++++++++++++++++++
 3 files changed, 467 insertions(+), 1 deletion(-)
 create mode 100644 drivers/video/fbdev/omap2/dss/pll.c

diff --git a/drivers/video/fbdev/omap2/dss/Makefile b/drivers/video/fbdev/omap2/dss/Makefile
index 245f933060ee..2ea9d382354c 100644
--- a/drivers/video/fbdev/omap2/dss/Makefile
+++ b/drivers/video/fbdev/omap2/dss/Makefile
@@ -2,7 +2,7 @@ obj-$(CONFIG_OMAP2_DSS_INIT) += omapdss-boot-init.o
 obj-$(CONFIG_OMAP2_DSS) += omapdss.o
 # Core DSS files
 omapdss-y := core.o dss.o dss_features.o dispc.o dispc_coefs.o display.o \
-	output.o dss-of.o
+	output.o dss-of.o pll.o
 # DSS compat layer files
 omapdss-y += manager.o manager-sysfs.o overlay.o overlay-sysfs.o apply.o \
 	dispc-compat.o display-sysfs.o
diff --git a/drivers/video/fbdev/omap2/dss/dss.h b/drivers/video/fbdev/omap2/dss/dss.h
index 4c268985235c..8563e2bc702c 100644
--- a/drivers/video/fbdev/omap2/dss/dss.h
+++ b/drivers/video/fbdev/omap2/dss/dss.h
@@ -100,6 +100,69 @@ enum dss_writeback_channel {
 	DSS_WB_LCD3_MGR =	7,
 };
 
+struct dss_pll;
+
+#define DSS_PLL_MAX_HSDIVS 4
+
+/*
+ * Type-A PLLs: clkout[]/mX[] refer to hsdiv outputs m4, m5, m6, m7.
+ * Type-B PLLs: clkout[0] refers to m2.
+ */
+struct dss_pll_clock_info {
+	/* rates that we get with dividers below */
+	unsigned long fint;
+	unsigned long clkdco;
+	unsigned long clkout[DSS_PLL_MAX_HSDIVS];
+
+	/* dividers */
+	u16 n;
+	u16 m;
+	u32 mf;
+	u16 mX[DSS_PLL_MAX_HSDIVS];
+	u16 sd;
+};
+
+struct dss_pll_ops {
+	int (*enable)(struct dss_pll *pll);
+	void (*disable)(struct dss_pll *pll);
+	int (*set_config)(struct dss_pll *pll,
+		const struct dss_pll_clock_info *cinfo);
+};
+
+struct dss_pll_hw {
+	unsigned n_max;
+	unsigned m_min;
+	unsigned m_max;
+	unsigned mX_max;
+
+	unsigned long fint_min, fint_max;
+	unsigned long clkdco_min, clkdco_low, clkdco_max;
+
+	u8 n_msb, n_lsb;
+	u8 m_msb, m_lsb;
+	u8 mX_msb[DSS_PLL_MAX_HSDIVS], mX_lsb[DSS_PLL_MAX_HSDIVS];
+
+	bool has_stopmode;
+	bool has_freqsel;
+	bool has_selfreqdco;
+	bool has_refsel;
+};
+
+struct dss_pll {
+	const char *name;
+
+	struct clk *clkin;
+	struct regulator *regulator;
+
+	void __iomem *base;
+
+	const struct dss_pll_hw *hw;
+
+	const struct dss_pll_ops *ops;
+
+	struct dss_pll_clock_info cinfo;
+};
+
 struct dispc_clock_info {
 	/* rates that we get with dividers below */
 	unsigned long lck;
@@ -435,4 +498,29 @@ static inline void dss_collect_irq_stats(u32 irqstatus, unsigned *irq_arr)
 }
 #endif
 
+/* PLL */
+typedef bool (*dss_pll_calc_func)(int n, int m, unsigned long fint,
+		unsigned long clkdco, void *data);
+typedef bool (*dss_hsdiv_calc_func)(int m_dispc, unsigned long dispc,
+		void *data);
+
+int dss_pll_register(struct dss_pll *pll);
+void dss_pll_unregister(struct dss_pll *pll);
+struct dss_pll *dss_pll_find(const char *name);
+int dss_pll_enable(struct dss_pll *pll);
+void dss_pll_disable(struct dss_pll *pll);
+int dss_pll_set_config(struct dss_pll *pll,
+		const struct dss_pll_clock_info *cinfo);
+
+bool dss_pll_hsdiv_calc(const struct dss_pll *pll, unsigned long clkdco,
+		unsigned long out_min, unsigned long out_max,
+		dss_hsdiv_calc_func func, void *data);
+bool dss_pll_calc(const struct dss_pll *pll, unsigned long clkin,
+		unsigned long pll_min, unsigned long pll_max,
+		dss_pll_calc_func func, void *data);
+int dss_pll_write_config_type_a(struct dss_pll *pll,
+		const struct dss_pll_clock_info *cinfo);
+int dss_pll_write_config_type_b(struct dss_pll *pll,
+		const struct dss_pll_clock_info *cinfo);
+
 #endif
diff --git a/drivers/video/fbdev/omap2/dss/pll.c b/drivers/video/fbdev/omap2/dss/pll.c
new file mode 100644
index 000000000000..50bc62c5d367
--- /dev/null
+++ b/drivers/video/fbdev/omap2/dss/pll.c
@@ -0,0 +1,378 @@
+/*
+ * Copyright (C) 2014 Texas Instruments Incorporated
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
+ */
+
+#define DSS_SUBSYS_NAME "PLL"
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/regulator/consumer.h>
+#include <linux/sched.h>
+
+#include <video/omapdss.h>
+
+#include "dss.h"
+
+#define PLL_CONTROL			0x0000
+#define PLL_STATUS			0x0004
+#define PLL_GO				0x0008
+#define PLL_CONFIGURATION1		0x000C
+#define PLL_CONFIGURATION2		0x0010
+#define PLL_CONFIGURATION3		0x0014
+#define PLL_SSC_CONFIGURATION1		0x0018
+#define PLL_SSC_CONFIGURATION2		0x001C
+#define PLL_CONFIGURATION4		0x0020
+
+static struct dss_pll *dss_plls[4];
+
+int dss_pll_register(struct dss_pll *pll)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dss_plls); ++i) {
+		if (!dss_plls[i]) {
+			dss_plls[i] = pll;
+			return 0;
+		}
+	}
+
+	return -EBUSY;
+}
+
+void dss_pll_unregister(struct dss_pll *pll)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dss_plls); ++i) {
+		if (dss_plls[i] == pll) {
+			dss_plls[i] = NULL;
+			return;
+		}
+	}
+}
+
+struct dss_pll *dss_pll_find(const char *name)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dss_plls); ++i) {
+		if (dss_plls[i] && strcmp(dss_plls[i]->name, name) == 0)
+			return dss_plls[i];
+	}
+
+	return NULL;
+}
+
+int dss_pll_enable(struct dss_pll *pll)
+{
+	int r;
+
+	r = clk_prepare_enable(pll->clkin);
+	if (r)
+		return r;
+
+	if (pll->regulator) {
+		r = regulator_enable(pll->regulator);
+		if (r)
+			goto err_reg;
+	}
+
+	r = pll->ops->enable(pll);
+	if (r)
+		goto err_enable;
+
+	return 0;
+
+err_enable:
+	regulator_disable(pll->regulator);
+err_reg:
+	clk_disable_unprepare(pll->clkin);
+	return r;
+}
+
+void dss_pll_disable(struct dss_pll *pll)
+{
+	pll->ops->disable(pll);
+
+	if (pll->regulator)
+		regulator_disable(pll->regulator);
+
+	clk_disable_unprepare(pll->clkin);
+
+	memset(&pll->cinfo, 0, sizeof(pll->cinfo));
+}
+
+int dss_pll_set_config(struct dss_pll *pll, const struct dss_pll_clock_info *cinfo)
+{
+	int r;
+
+	r = pll->ops->set_config(pll, cinfo);
+	if (r)
+		return r;
+
+	pll->cinfo = *cinfo;
+
+	return 0;
+}
+
+bool dss_pll_hsdiv_calc(const struct dss_pll *pll, unsigned long clkdco,
+		unsigned long out_min, unsigned long out_max,
+		dss_hsdiv_calc_func func, void *data)
+{
+	const struct dss_pll_hw *hw = pll->hw;
+	int m, m_start, m_stop;
+	unsigned long out;
+
+	out_min = out_min ? out_min : 1;
+	out_max = out_max ? out_max : ULONG_MAX;
+
+	m_start = max(DIV_ROUND_UP(clkdco, out_max), 1ul);
+
+	m_stop = min((unsigned)(clkdco / out_min), hw->mX_max);
+
+	for (m = m_start; m <= m_stop; ++m) {
+		out = clkdco / m;
+
+		if (func(m, out, data))
+			return true;
+	}
+
+	return false;
+}
+
+bool dss_pll_calc(const struct dss_pll *pll, unsigned long clkin,
+		unsigned long pll_min, unsigned long pll_max,
+		dss_pll_calc_func func, void *data)
+{
+	const struct dss_pll_hw *hw = pll->hw;
+	int n, n_start, n_stop;
+	int m, m_start, m_stop;
+	unsigned long fint, clkdco;
+	unsigned long pll_hw_max;
+	unsigned long fint_hw_min, fint_hw_max;
+
+	pll_hw_max = hw->clkdco_max;
+
+	fint_hw_min = hw->fint_min;
+	fint_hw_max = hw->fint_max;
+
+	n_start = max(DIV_ROUND_UP(clkin, fint_hw_max), 1ul);
+	n_stop = min((unsigned)(clkin / fint_hw_min), hw->n_max);
+
+	pll_max = pll_max ? pll_max : ULONG_MAX;
+
+	for (n = n_start; n <= n_stop; ++n) {
+		fint = clkin / n;
+
+		m_start = max(DIV_ROUND_UP(DIV_ROUND_UP(pll_min, fint), 2),
+				1ul);
+		m_stop = min3((unsigned)(pll_max / fint / 2),
+				(unsigned)(pll_hw_max / fint / 2),
+				hw->m_max);
+
+		for (m = m_start; m <= m_stop; ++m) {
+			clkdco = 2 * m * fint;
+
+			if (func(n, m, fint, clkdco, data))
+				return true;
+		}
+	}
+
+	return false;
+}
+
+static int wait_for_bit_change(void __iomem *reg, int bitnum, int value)
+{
+	unsigned long timeout;
+	ktime_t wait;
+	int t;
+
+	/* first busyloop to see if the bit changes right away */
+	t = 100;
+	while (t-- > 0) {
+		if (FLD_GET(readl_relaxed(reg), bitnum, bitnum) == value)
+			return value;
+	}
+
+	/* then loop for 500ms, sleeping for 1ms in between */
+	timeout = jiffies + msecs_to_jiffies(500);
+	while (time_before(jiffies, timeout)) {
+		if (FLD_GET(readl_relaxed(reg), bitnum, bitnum) == value)
+			return value;
+
+		wait = ns_to_ktime(1000 * 1000);
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_hrtimeout(&wait, HRTIMER_MODE_REL);
+	}
+
+	return !value;
+}
+
+static int dss_wait_hsdiv_ack(struct dss_pll *pll, u32 hsdiv_ack_mask)
+{
+	int t = 100;
+
+	while (t-- > 0) {
+		u32 v = readl_relaxed(pll->base + PLL_STATUS);
+		v &= hsdiv_ack_mask;
+		if (v == hsdiv_ack_mask)
+			return 0;
+	}
+
+	return -ETIMEDOUT;
+}
+
+int dss_pll_write_config_type_a(struct dss_pll *pll,
+		const struct dss_pll_clock_info *cinfo)
+{
+	const struct dss_pll_hw *hw = pll->hw;
+	void __iomem *base = pll->base;
+	int r = 0;
+	u32 l;
+
+	l = 0;
+	if (hw->has_stopmode)
+		l = FLD_MOD(l, 1, 0, 0);		/* PLL_STOPMODE */
+	l = FLD_MOD(l, cinfo->n - 1, hw->n_msb, hw->n_lsb);	/* PLL_REGN */
+	l = FLD_MOD(l, cinfo->m, hw->m_msb, hw->m_lsb);		/* PLL_REGM */
+	/* M4 */
+	l = FLD_MOD(l, cinfo->mX[0] ? cinfo->mX[0] - 1 : 0,
+			hw->mX_msb[0], hw->mX_lsb[0]);
+	/* M5 */
+	l = FLD_MOD(l, cinfo->mX[1] ? cinfo->mX[1] - 1 : 0,
+			hw->mX_msb[1], hw->mX_lsb[1]);
+	writel_relaxed(l, base + PLL_CONFIGURATION1);
+
+	l = 0;
+	/* M6 */
+	l = FLD_MOD(l, cinfo->mX[2] ? cinfo->mX[2] - 1 : 0,
+			hw->mX_msb[2], hw->mX_lsb[2]);
+	/* M7 */
+	l = FLD_MOD(l, cinfo->mX[3] ? cinfo->mX[3] - 1 : 0,
+			hw->mX_msb[3], hw->mX_lsb[3]);
+	writel_relaxed(l, base + PLL_CONFIGURATION3);
+
+	l = readl_relaxed(base + PLL_CONFIGURATION2);
+	if (hw->has_freqsel) {
+		u32 f = cinfo->fint < 1000000 ? 0x3 :
+			cinfo->fint < 1250000 ? 0x4 :
+			cinfo->fint < 1500000 ? 0x5 :
+			cinfo->fint < 1750000 ? 0x6 :
+			0x7;
+
+		l = FLD_MOD(l, f, 4, 1);	/* PLL_FREQSEL */
+	} else if (hw->has_selfreqdco) {
+		u32 f = cinfo->clkdco < hw->clkdco_low ? 0x2 : 0x4;
+
+		l = FLD_MOD(l, f, 3, 1);	/* PLL_SELFREQDCO */
+	}
+	l = FLD_MOD(l, 1, 13, 13);		/* PLL_REFEN */
+	l = FLD_MOD(l, 0, 14, 14);		/* PHY_CLKINEN */
+	l = FLD_MOD(l, 0, 16, 16);		/* M4_CLOCK_EN */
+	l = FLD_MOD(l, 0, 18, 18);		/* M5_CLOCK_EN */
+	l = FLD_MOD(l, 1, 20, 20);		/* HSDIVBYPASS */
+	if (hw->has_refsel)
+		l = FLD_MOD(l, 3, 22, 21);	/* REFSEL = sysclk */
+	l = FLD_MOD(l, 0, 23, 23);		/* M6_CLOCK_EN */
+	l = FLD_MOD(l, 0, 25, 25);		/* M7_CLOCK_EN */
+	writel_relaxed(l, base + PLL_CONFIGURATION2);
+
+	writel_relaxed(1, base + PLL_GO);	/* PLL_GO */
+
+	if (wait_for_bit_change(base + PLL_GO, 0, 0) != 0) {
+		DSSERR("DSS DPLL GO bit not going down.\n");
+		r = -EIO;
+		goto err;
+	}
+
+	if (wait_for_bit_change(base + PLL_STATUS, 1, 1) != 1) {
+		DSSERR("cannot lock DSS DPLL\n");
+		r = -EIO;
+		goto err;
+	}
+
+	l = readl_relaxed(base + PLL_CONFIGURATION2);
+	l = FLD_MOD(l, 1, 14, 14);			/* PHY_CLKINEN */
+	l = FLD_MOD(l, cinfo->mX[0] ? 1 : 0, 16, 16);	/* M4_CLOCK_EN */
+	l = FLD_MOD(l, cinfo->mX[1] ? 1 : 0, 18, 18);	/* M5_CLOCK_EN */
+	l = FLD_MOD(l, 0, 20, 20);			/* HSDIVBYPASS */
+	l = FLD_MOD(l, cinfo->mX[2] ? 1 : 0, 23, 23);	/* M6_CLOCK_EN */
+	l = FLD_MOD(l, cinfo->mX[3] ? 1 : 0, 25, 25);	/* M7_CLOCK_EN */
+	writel_relaxed(l, base + PLL_CONFIGURATION2);
+
+	r = dss_wait_hsdiv_ack(pll,
+		(cinfo->mX[0] ? BIT(7) : 0) |
+		(cinfo->mX[1] ? BIT(8) : 0) |
+		(cinfo->mX[2] ? BIT(10) : 0) |
+		(cinfo->mX[3] ? BIT(11) : 0));
+	if (r) {
+		DSSERR("failed to enable HSDIV clocks\n");
+		goto err;
+	}
+
+err:
+	return r;
+}
+
+int dss_pll_write_config_type_b(struct dss_pll *pll,
+		const struct dss_pll_clock_info *cinfo)
+{
+	const struct dss_pll_hw *hw = pll->hw;
+	void __iomem *base = pll->base;
+	u32 l;
+
+	l = 0;
+	l = FLD_MOD(l, cinfo->m, 20, 9);	/* PLL_REGM */
+	l = FLD_MOD(l, cinfo->n - 1, 8, 1);	/* PLL_REGN */
+	writel_relaxed(l, base + PLL_CONFIGURATION1);
+
+	l = readl_relaxed(base + PLL_CONFIGURATION2);
+	l = FLD_MOD(l, 0x0, 12, 12);	/* PLL_HIGHFREQ divide by 2 */
+	l = FLD_MOD(l, 0x1, 13, 13);	/* PLL_REFEN */
+	l = FLD_MOD(l, 0x0, 14, 14);	/* PHY_CLKINEN */
+	if (hw->has_refsel)
+		l = FLD_MOD(l, 0x3, 22, 21);	/* REFSEL = SYSCLK */
+
+	/* PLL_SELFREQDCO */
+	if (cinfo->clkdco > hw->clkdco_low)
+		l = FLD_MOD(l, 0x4, 3, 1);
+	else
+		l = FLD_MOD(l, 0x2, 3, 1);
+	writel_relaxed(l, base + PLL_CONFIGURATION2);
+
+	l = readl_relaxed(base + PLL_CONFIGURATION3);
+	l = FLD_MOD(l, cinfo->sd, 17, 10);	/* PLL_REGSD */
+	writel_relaxed(l, base + PLL_CONFIGURATION3);
+
+	l = readl_relaxed(base + PLL_CONFIGURATION4);
+	l = FLD_MOD(l, cinfo->mX[0], 24, 18);	/* PLL_REGM2 */
+	l = FLD_MOD(l, cinfo->mf, 17, 0);	/* PLL_REGM_F */
+	writel_relaxed(l, base + PLL_CONFIGURATION4);
+
+	writel_relaxed(1, base + PLL_GO);	/* PLL_GO */
+
+	if (wait_for_bit_change(base + PLL_GO, 0, 0) != 0) {
+		DSSERR("DSS DPLL GO bit not going down.\n");
+		return -EIO;
+	}
+
+	if (wait_for_bit_change(base + PLL_STATUS, 1, 1) != 1) {
+		DSSERR("cannot lock DSS DPLL\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
-- 
2.1.3

