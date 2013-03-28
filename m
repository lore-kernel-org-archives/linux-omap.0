From: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Subject: [PATCH 5/6] ARM: OMAP3+: ABB: introduce ABB driver
Date: Thu, 28 Mar 2013 19:16:07 +0200
Message-ID: <1364490968-13613-5-git-send-email-andrii.tseglytskyi@ti.com>
References: <1364490968-13613-1-git-send-email-andrii.tseglytskyi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45458 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756794Ab3C1RQk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Mar 2013 13:16:40 -0400
In-Reply-To: <1364490968-13613-1-git-send-email-andrii.tseglytskyi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-patch-review@list.ti.com
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>, Mike Turquette <mturquette@linaro.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, linux-omap@vger.kernel.org

=46rom: "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>

This patch introduces the Adaptive Body-Bias LDO driver,
which handles LDOs voltage during OPP change routine.
It follows general principles of ABB implementation
in kernel 3.4.

Some new features are added:

1) ABB driver uses clock notifier framework to scale LDO.
To make this working it handles it's own OPP table.
OPP table has the following format in device tree:

operating-points =3D <
	       /* kHz   ABB (0 - Bypass, 1 - FBB, 2 - RBB) */
	       499200		0
	       1099800		1
	       1500000		1
	       1699200		1
>;

Generic API is used for OPP table parsing - of_init_opp_table()

2) ABB driver doesn't have any public interfaces. It follows
Voltage/Frequency changes, using only notification mechanism.

3) ABB driver uses PRM_IRQSTATUS register to check tranxdone status.
This register is shared with VP.

Cc: Mike Turquette <mturquette@linaro.org>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: "Beno=C3=AEt Cousson" <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org

Signed-off-by: Andrii.Tseglytskyi <andrii.tseglytskyi@ti.com>
Signed-off-by: Mike Turquette <mturquette@linaro.org>
---
 drivers/power/avs/Makefile |    2 +-
 drivers/power/avs/abb.c    |  570 ++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 571 insertions(+), 1 deletion(-)
 create mode 100644 drivers/power/avs/abb.c

diff --git a/drivers/power/avs/Makefile b/drivers/power/avs/Makefile
index 0843386..d5fc9c4 100644
--- a/drivers/power/avs/Makefile
+++ b/drivers/power/avs/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_POWER_AVS_OMAP)		+=3D smartreflex.o
+obj-$(CONFIG_POWER_AVS_OMAP)		+=3D smartreflex.o abb.o
diff --git a/drivers/power/avs/abb.c b/drivers/power/avs/abb.c
new file mode 100644
index 0000000..f5bbb8d
--- /dev/null
+++ b/drivers/power/avs/abb.c
@@ -0,0 +1,570 @@
+/*
+ * OMAP Adaptive Body-Bias core
+ *
+ * Copyright (C) 2011 Texas Instruments, Inc.
+ * Mike Turquette <mturquette@ti.com>
+ *
+ * Copyright (C) 2013 Texas Instruments, Inc.
+ * Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of_device.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/opp.h>
+
+/* NOMINAL_OPP bypasses the ABB ldo, FAST_OPP sets it to Forward Body-=
Bias */
+#define OMAP_ABB_NOMINAL_OPP	0
+#define OMAP_ABB_FAST_OPP	1
+#define OMAP_ABB_SLOW_OPP	3
+#define OMAP_ABB_NO_LDO		(~0)
+
+/* Time for the ABB ldo to settle after transition (in micro-seconds) =
*/
+#define ABB_TRANXDONE_TIMEOUT	50
+
+/*
+ * struct omap_abb_data - common data for each instance of ABB ldo
+ *
+ * @opp_sel_mask:	selects Fast/Nominal/Slow OPP for ABB
+ * @opp_change_mask:	selects OPP_CHANGE bit value
+ * @sr2_wtcnt_value_mask:	LDO settling time for active-mode OPP change
+ * @sr2en_mask:			enables/disables ABB
+ * @fbb_sel_mask:		selects FBB mode
+ * @rbb_sel_mask:		selects RBB mode
+ * @settling_time:	IRQ handle used to resolve IRQSTATUS offset & masks
+ * @clock_cycles:	value needed for LDO setting time calculation
+ * @setup_offs:		PRM_LDO_ABB_XXX_SETUP register offset
+ * @control_offs:	PRM_LDO_ABB_IVA_CTRL register offset
+ */
+struct omap_abb_data {
+	u32 opp_sel_mask;
+	u32 opp_change_mask;
+	u32 sr2_wtcnt_value_mask;
+	u32 sr2en_mask;
+	u32 fbb_sel_mask;
+	u32 rbb_sel_mask;
+	unsigned long settling_time;
+	unsigned long clock_cycles;
+	u8 setup_offs;
+	u8 control_offs;
+};
+
+/*
+ * struct omap_abb - ABB ldo instance
+ *
+ * @control:	memory mapped ABB registers
+ * @txdone:	memory mapped IRQSTATUS register
+ * @dev:	device, for which ABB is created
+ * @txdone_mask:	ABB mode change done bit
+ * @opp_sel:		current ABB status - Fast/Nominal/Slow
+ * @notify_clk:		clock, which rate changes are handled by ABB
+ * @data:		common data
+ * @abb_clk_nb:		clock rate change notifier block
+ */
+struct omap_abb {
+	void __iomem	*control;
+	void __iomem	*txdone;
+	struct device	*dev;
+	u32		txdone_mask;
+	u32		opp_sel;
+	struct clk	*notify_clk;
+	struct omap_abb_data	data;
+	struct notifier_block abb_clk_nb;
+};
+
+static const struct omap_abb_data __initdata omap36xx_abb_data =3D {
+	.opp_sel_mask		=3D (3 << 0), /* OMAP3630_OPP_SEL_MASK */
+	.opp_change_mask	=3D (1 << 2), /* OMAP3630_OPP_CHANGE_MASK */
+	.sr2en_mask		=3D (1 << 0), /* OMAP3630_SR2EN_MASK */
+	.fbb_sel_mask		=3D (1 << 2), /* OMAP3630_ACTIVE_FBB_SEL_MASK */
+	.sr2_wtcnt_value_mask =3D (0xff << 8), /* OMAP3630_SR2_WTCNT_VALUE_MA=
SK */
+	.setup_offs		=3D 0,
+	.control_offs		=3D 0x4,
+	.settling_time		=3D 30,
+	.clock_cycles		=3D 8,
+};
+
+static const struct omap_abb_data __initdata omap4_abb_data =3D {
+	.opp_sel_mask		=3D (0x3 << 0), /* OMAP4430_OPP_SEL_MASK */
+	.opp_change_mask	=3D (1 << 2), /* OMAP4430_OPP_CHANGE_MASK */
+	.sr2en_mask		=3D (1 << 0), /* OMAP4430_SR2EN_MASK */
+	.fbb_sel_mask		=3D (1 << 2), /* OMAP4430_ACTIVE_FBB_SEL_MASK */
+	.rbb_sel_mask		=3D (1 << 1), /* OMAP4430_ACTIVE_RBB_SEL_MASK */
+	.sr2_wtcnt_value_mask =3D (0xff << 8), /* OMAP4430_SR2_WTCNT_VALUE_MA=
SK */
+	.setup_offs		=3D 0,
+	.control_offs		=3D 0x4,
+	.settling_time		=3D 50,
+	.clock_cycles		=3D 16,
+};
+
+static const struct omap_abb_data __initdata omap5_abb_data =3D {
+	.opp_sel_mask		=3D (0x3 << 0), /* OMAP54XX_OPP_SEL_MASK */
+	.opp_change_mask	=3D (1 << 2), /* OMAP54XX_OPP_CHANGE_MASK */
+	.sr2en_mask		=3D (1 << 0), /* OMAP54XX_SR2EN_MASK */
+	.fbb_sel_mask		=3D (1 << 2), /* OMAP54XX_ACTIVE_FBB_SEL_MASK */
+	.rbb_sel_mask		=3D (1 << 1), /* OMAP54XX_ACTIVE_RBB_SEL_MASK */
+	.sr2_wtcnt_value_mask =3D (0xff << 8), /* OMAP54XX_SR2_WTCNT_VALUE_MA=
SK */
+	.setup_offs		=3D 0,
+	.control_offs		=3D 0x4,
+	.settling_time		=3D 50,
+	.clock_cycles		=3D 16,
+};
+
+/**
+ * omap_abb_readl() - reads ABB control memory
+ * @abb:	pointer to the abb instance
+ * @offs:	offset to read
+ *
+ * Returns @offs value
+ */
+static u32 omap_abb_readl(struct omap_abb *abb, u32 offs)
+{
+	return __raw_readl(abb->control + offs);
+}
+
+/**
+ * omap_abb_rmw() - modifies ABB control memory
+ * @abb:	pointer to the abb instance
+ * @mask:	mask to modify
+ * @bits:	bits to store
+ * @offs:	offset to modify
+ */
+static void omap_abb_rmw(struct omap_abb *abb, u32 mask, u32 bits, u32=
 offs)
+{
+	u32 val;
+
+	val =3D __raw_readl(abb->control + offs);
+	val &=3D ~mask;
+	val |=3D bits;
+	__raw_writel(val, abb->control + offs);
+}
+
+/**
+ * omap_abb_check_txdone() - checks ABB tranxdone status
+ * @abb:	pointer to the abb instance
+ *
+ * Returns true or false
+ */
+static bool omap_abb_check_txdone(struct omap_abb *abb)
+{
+	return !!(__raw_readl(abb->txdone) & abb->txdone_mask);
+}
+
+/**
+ * omap_abb_clear_txdone() - clears ABB tranxdone status
+ * @abb:	pointer to the abb instance
+ */
+static void omap_abb_clear_txdone(struct omap_abb *abb)
+{
+	__raw_writel(abb->txdone_mask, abb->txdone);
+};
+
+/**
+ * omap_abb_wait_tranx() - waits for ABB tranxdone event
+ * @abb:	pointer to the abb instance
+ *
+ * Returns -ETIMEDOUT if the event is not set on time.
+ */
+static int omap_abb_wait_tranx(struct omap_abb *abb)
+{
+	int timeout;
+	bool status;
+
+	timeout =3D 0;
+	while (timeout++ < ABB_TRANXDONE_TIMEOUT) {
+		status =3D omap_abb_check_txdone(abb);
+		if (status)
+			break;
+
+		udelay(1);
+	}
+
+	if (timeout >=3D ABB_TRANXDONE_TIMEOUT) {
+		dev_warn(abb->dev, "%s: ABB TRANXDONE timeout=3D(%d)\n",
+			 __func__, timeout);
+		return -ETIMEDOUT;
+	}
+	return 0;
+}
+
+/**
+ * omap_abb_clear_tranx() - clears ABB tranxdone event
+ * @abb:	pointer to the abb instance
+ *
+ * Returns -ETIMEDOUT if the event is not cleared on time.
+ */
+static int omap_abb_clear_tranx(struct omap_abb *abb)
+{
+	int timeout;
+	bool status;
+
+	/* clear interrupt status */
+	timeout =3D 0;
+	while (timeout++ < ABB_TRANXDONE_TIMEOUT) {
+		omap_abb_clear_txdone(abb);
+
+		status =3D omap_abb_check_txdone(abb);
+		if (!status)
+			break;
+
+		udelay(1);
+	}
+
+	if (timeout >=3D ABB_TRANXDONE_TIMEOUT) {
+		dev_warn(abb->dev, "%s: ABB TRANXDONE timeout=3D(%d)\n",
+			 __func__, timeout);
+		return -ETIMEDOUT;
+	}
+	return 0;
+}
+
+/**
+ * omap_abb_set_opp() - program ABB ldo based on new voltage
+ * @abb:	pointer to the abb instance
+ * @opp_sel:	target ABB ldo operating mode
+ *
+ * Program the ABB ldo to the new state (if necessary), clearing the
+ * PRM_IRQSTATUS bit before and after the transition.  Returns 0 on
+ * success, -ETIMEDOUT otherwise.
+ */
+static int omap_abb_set_opp(struct omap_abb *abb, u8 opp_sel)
+{
+	int ret =3D 0;
+	const struct omap_abb_data *data =3D &abb->data;
+
+	/* bail early if no transition is necessary */
+	if (opp_sel =3D=3D abb->opp_sel)
+		return ret;
+
+	/* clear interrupt status */
+	ret =3D omap_abb_clear_tranx(abb);
+	if (ret)
+		goto out;
+
+	/* program the setup register */
+	switch (opp_sel) {
+	case OMAP_ABB_NOMINAL_OPP:
+		omap_abb_rmw(abb,
+			     data->fbb_sel_mask | data->rbb_sel_mask,
+			     0x0,
+			     data->setup_offs);
+		break;
+	case OMAP_ABB_SLOW_OPP:
+		omap_abb_rmw(abb,
+			     data->fbb_sel_mask | data->rbb_sel_mask,
+			     data->rbb_sel_mask,
+			     data->setup_offs);
+		break;
+	case OMAP_ABB_FAST_OPP:
+		omap_abb_rmw(abb,
+			     data->fbb_sel_mask | data->rbb_sel_mask,
+			     data->fbb_sel_mask,
+			     data->setup_offs);
+		break;
+	default:
+		/* Should have never been here! */
+		WARN_ONCE(1, "%s: opp_sel %d!!!\n",
+			  __func__, opp_sel);
+		return -EINVAL;
+	}
+
+	/* program next state of ABB ldo */
+	omap_abb_rmw(abb, data->opp_sel_mask,
+		     opp_sel << __ffs(data->opp_sel_mask),
+		     data->control_offs);
+
+	/* initiate ABB ldo change */
+	omap_abb_rmw(abb, data->opp_change_mask,
+		     data->opp_change_mask,
+		     data->control_offs);
+
+	/* Wait for conversion completion */
+	ret =3D omap_abb_wait_tranx(abb);
+	WARN_ONCE(ret, "%s: ABB TRANXDONE was not set on time:%d\n",
+		  __func__, ret);
+
+	/* clear interrupt status */
+	ret |=3D omap_abb_clear_tranx(abb);
+
+out:
+	if (ret) {
+		dev_warn(abb->dev, "%s: failed to scale: opp_sel=3D%d (%d)\n",
+			 __func__, opp_sel, ret);
+	} else {
+		/* track internal state */
+		abb->opp_sel =3D opp_sel;
+		dev_dbg(abb->dev, "%s: scaled - opp_sel=3D%d\n",
+			__func__, opp_sel);
+	}
+	return ret;
+}
+
+/**
+ * omap_abb_pre_scale() - ABB transition pre-frequency scale callback
+ * @abb:	pointer to the ABB instance
+ * @old_rate:	old notifier clock rate
+ * @new_rate:	new notifier clock rate
+ *
+ * Changes the ABB ldo mode prior to scaling the frequency.
+ * Returns 0 on success, otherwise an error code.
+ */
+static int omap_abb_pre_scale(struct omap_abb *abb,
+			      unsigned long old_rate,
+			      unsigned long new_rate)
+{
+	struct opp *opp;
+
+	/* bail if the sequence is wrong */
+	if (new_rate >=3D old_rate)
+		return 0;
+
+	rcu_read_lock();
+	opp =3D opp_find_freq_exact(abb->dev, new_rate, true);
+	rcu_read_unlock();
+
+	if (IS_ERR(opp)) {
+		dev_err(abb->dev, "%s: can't find OPP for Freq (%lu)",
+			__func__, new_rate);
+		return -EINVAL;
+	}
+
+	return omap_abb_set_opp(abb, opp_get_voltage(opp));
+}
+
+/**
+ * omap_abb_post_scale() - ABB transition post-frequency scale callbac=
k
+ * @abb:	pointer to the ABB instance
+ * @old_rate:	old notifier clock rate
+ * @new_rate:	new notifier clock rate
+ *
+ * Changes the ABB ldo mode prior to scaling the frequency.
+ * Returns 0 on success, otherwise an error code.
+ */
+static int omap_abb_post_scale(struct omap_abb *abb,
+			       unsigned long old_rate,
+			       unsigned long new_rate)
+{
+	struct opp *opp;
+
+	/* bail if the sequence is wrong */
+	if (new_rate <=3D old_rate)
+		return 0;
+
+	rcu_read_lock();
+	opp =3D opp_find_freq_exact(abb->dev, new_rate, true);
+	rcu_read_unlock();
+
+	if (IS_ERR(opp)) {
+		dev_err(abb->dev, "%s: can't find OPP for Freq (%lu)",
+			__func__, new_rate);
+		return -EINVAL;
+	}
+
+	return omap_abb_set_opp(abb, opp_get_voltage(opp));
+}
+
+/**
+ * omap_abb_clock_rate_change() - ABB clock notifier callback
+ * @nb:		notifier block
+ * @flags:	notifier event type
+ * @data:	notifier data, contains clock rates
+ *
+ * Returns NOTIFY_OK
+ */
+static int omap_abb_clock_rate_change(struct notifier_block *nb,
+				      unsigned long flags, void *data)
+{
+	struct clk_notifier_data *cnd =3D data;
+	struct omap_abb *abb =3D container_of(nb, struct omap_abb, abb_clk_nb=
);
+
+	switch (flags) {
+	case PRE_RATE_CHANGE:
+		omap_abb_pre_scale(abb, cnd->old_rate, cnd->new_rate);
+		break;
+	case POST_RATE_CHANGE:
+		omap_abb_post_scale(abb, cnd->old_rate, cnd->new_rate);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block abb_clk_nb =3D {
+	.notifier_call =3D omap_abb_clock_rate_change,
+};
+
+#if defined(CONFIG_OF)
+static const struct of_device_id __initdata omap_abb_of_match[] =3D {
+	{ .compatible =3D "ti,omap36xx-abb", .data =3D &omap36xx_abb_data},
+	{ .compatible =3D "ti,omap4-abb", .data =3D &omap4_abb_data},
+	{ .compatible =3D "ti,omap5-abb", .data =3D &omap5_abb_data},
+	{},
+};
+MODULE_DEVICE_TABLE(of, omap_abb_of_match);
+#endif
+
+/*
+ * omap_abb_probe() - Initialize an ABB ldo instance
+ * @pdev: ABB platform device
+ *
+ * Initializes an individual ABB ldo for Forward Body-Bias.  FBB is us=
ed to
+ * insure stability at higher voltages.  Note that some older OMAP chi=
ps have a
+ * Reverse Body-Bias mode meant to save power at low voltage, but that=
 mode is
+ * unsupported and phased out on newer chips.
+ */
+static int __init omap_abb_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *match =3D NULL;
+	struct omap_abb *abb =3D NULL;
+	struct resource *mem =3D NULL;
+	struct clk *sys_clk =3D NULL;
+	u32 sys_clk_rate, sr2_wt_cnt_val, clock_cycles, abb_sel;
+	int ret =3D 0;
+
+	match =3D of_match_device(omap_abb_of_match, &pdev->dev);
+	if (!match) {
+		ret =3D -ENODEV;
+		goto err;
+	}
+
+	abb =3D devm_kzalloc(&pdev->dev,
+			   sizeof(struct omap_abb),
+			   GFP_KERNEL);
+	if (!abb) {
+		ret =3D -ENOMEM;
+		goto err;
+	}
+
+	abb->data =3D *((struct omap_abb_data *)match->data);
+	abb->dev =3D &pdev->dev;
+
+	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		ret =3D -ENODEV;
+		goto err;
+	}
+
+	abb->control =3D devm_request_and_ioremap(&pdev->dev, mem);
+	if (!abb->control) {
+		ret =3D -ENOMEM;
+		goto err;
+	}
+
+	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!mem) {
+		ret =3D -ENODEV;
+		goto err;
+	}
+
+	abb->txdone =3D devm_ioremap_nocache(&pdev->dev, mem->start,
+					   resource_size(mem));
+	if (!abb->txdone) {
+		ret =3D -ENOMEM;
+		goto err;
+	}
+
+	/*
+	 * SR2_WTCNT_VALUE is the settling time for the ABB ldo after a
+	 * transition and must be programmed with the correct time at boot.
+	 * The value programmed into the register is the number of SYS_CLK
+	 * clock cycles that match a given wall time profiled for the ldo.
+	 * This value depends on:
+	 * settling time of ldo in micro-seconds (varies per OMAP family)
+	 * # of clock cycles per SYS_CLK period (varies per OMAP family)
+	 * the SYS_CLK frequency in MHz (varies per board)
+	 * The formula is:
+	 *
+	 *                      ldo settling time (in micro-seconds)
+	 * SR2_WTCNT_VALUE =3D ------------------------------------------
+	 *                   (# system clock cycles) * (sys_clk period)
+	 *
+	 * Put another way:
+	 *
+	 * SR2_WTCNT_VALUE =3D settling time / (# SYS_CLK cycles / SYS_CLK ra=
te))
+	 *
+	 * To avoid dividing by zero multiply both "# clock cycles" and
+	 * "settling time" by 10 such that the final result is the one we wan=
t.
+	 */
+	ret =3D of_property_read_u32(pdev->dev.of_node,
+				   "ti,tranxdone_status_mask",
+				   &abb->txdone_mask);
+	if (ret)
+		goto err;
+
+	ret =3D of_init_opp_table(&pdev->dev);
+	if (ret)
+		goto err;
+
+	abb->notify_clk =3D clk_get(&pdev->dev, "abb_notify_ck");
+	if (IS_ERR_OR_NULL(abb->notify_clk)) {
+		ret =3D -ENODEV;
+		goto err;
+	}
+
+	sys_clk =3D clk_get(&pdev->dev, "abb_sys_ck");
+	if (IS_ERR_OR_NULL(sys_clk)) {
+		ret =3D -ENODEV;
+		goto err_sys_ck;
+	}
+
+	/* convert SYS_CLK rate to MHz & prevent divide by zero */
+	sys_clk_rate =3D DIV_ROUND_CLOSEST(clk_get_rate(sys_clk), 1000000);
+
+	/* calculate cycle rate */
+	clock_cycles =3D DIV_ROUND_CLOSEST((abb->data.clock_cycles * 10),
+					 sys_clk_rate);
+
+	/* calulate SR2_WTCNT_VALUE */
+	sr2_wt_cnt_val =3D DIV_ROUND_CLOSEST((abb->data.settling_time * 10),
+					   clock_cycles);
+
+	omap_abb_rmw(abb, abb->data.sr2_wtcnt_value_mask,
+		     (sr2_wt_cnt_val << __ffs(abb->data.sr2_wtcnt_value_mask)),
+		     abb->data.setup_offs);
+
+	abb->abb_clk_nb =3D abb_clk_nb;
+	clk_notifier_register(abb->notify_clk, &abb->abb_clk_nb);
+
+	/* did bootloader set OPP_SEL? */
+	abb_sel =3D omap_abb_readl(abb, abb->data.control_offs);
+	abb_sel &=3D abb->data.opp_sel_mask;
+	abb->opp_sel =3D abb_sel >> __ffs(abb->data.opp_sel_mask);
+
+	/* enable the ldo if not done by bootloader */
+	abb_sel =3D omap_abb_readl(abb, abb->data.setup_offs);
+	abb_sel &=3D abb->data.sr2en_mask;
+	if (!abb_sel)
+		omap_abb_rmw(abb, abb->data.sr2en_mask,
+			     abb->data.sr2en_mask, abb->data.setup_offs);
+
+	clk_put(sys_clk);
+	return 0;
+
+err_sys_ck:
+	clk_put(abb->notify_clk);
+err:
+	dev_err(&pdev->dev, "%s: error on init (%d)\n",
+		__func__, ret);
+
+	return ret;
+}
+
+static struct platform_driver omap_abb_driver =3D {
+	.driver		=3D {
+		.name	=3D "omap_abb",
+		.of_match_table =3D of_match_ptr(omap_abb_of_match),
+	},
+};
+
+static int __init omap_abb_driver_init(void)
+{
+	return platform_driver_probe(&omap_abb_driver, omap_abb_probe);
+}
+subsys_initcall(omap_abb_driver_init);
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
