From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 04/10] soc: ti: omap-prm: add support for denying idle for
 reset clockdomain
Date: Fri, 30 Aug 2019 15:18:10 +0300
Message-ID: <20190830121816.30034-5-t-kristo@ti.com>
References: <20190830121816.30034-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190830121816.30034-1-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ssantosh@kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, s-anna@ti.com, p.zabel@pengutronix.de
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

TI SoCs hardware reset signals require the parent clockdomain to be
in force wakeup mode while de-asserting the reset, otherwise it may
never complete. To support this, add pdata hooks to control the
clockdomain directly.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/soc/ti/omap_prm.c            | 36 ++++++++++++++++++++++++++--
 include/linux/platform_data/ti-prm.h | 21 ++++++++++++++++
 2 files changed, 55 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/platform_data/ti-prm.h

diff --git a/drivers/soc/ti/omap_prm.c b/drivers/soc/ti/omap_prm.c
index d70f64e7a5c8..0b6a300f935b 100644
--- a/drivers/soc/ti/omap_prm.c
+++ b/drivers/soc/ti/omap_prm.c
@@ -16,6 +16,8 @@
 #include <linux/reset-controller.h>
 #include <linux/delay.h>
 
+#include <linux/platform_data/ti-prm.h>
+
 struct omap_rst_map {
 	s8 rst;
 	s8 st;
@@ -24,6 +26,7 @@ struct omap_rst_map {
 struct omap_prm_data {
 	u32 base;
 	const char *name;
+	const char *clkdm_name;
 	u16 rstctrl;
 	u16 rstst;
 	const struct omap_rst_map *rstmap;
@@ -40,6 +43,8 @@ struct omap_reset_data {
 	struct omap_prm *prm;
 	u32 mask;
 	spinlock_t lock;
+	struct clockdomain *clkdm;
+	struct device *dev;
 };
 
 #define to_omap_reset_data(p) container_of((p), struct omap_reset_data, rcdev)
@@ -49,6 +54,7 @@ struct omap_reset_data {
 
 #define OMAP_PRM_HAS_RSTCTRL	BIT(0)
 #define OMAP_PRM_HAS_RSTST	BIT(1)
+#define OMAP_PRM_HAS_NO_CLKDM	BIT(2)
 
 #define OMAP_PRM_HAS_RESETS	(OMAP_PRM_HAS_RSTCTRL | OMAP_PRM_HAS_RSTST)
 
@@ -133,6 +139,8 @@ static int omap_reset_deassert(struct reset_controller_dev *rcdev,
 	int st_bit;
 	bool has_rstst;
 	unsigned long flags;
+	struct ti_prm_platform_data *pdata = dev_get_platdata(reset->dev);
+	int ret = 0;
 
 	has_rstst = reset->prm->data->rstst ||
 		(reset->prm->data->flags & OMAP_PRM_HAS_RSTST);
@@ -146,6 +154,9 @@ static int omap_reset_deassert(struct reset_controller_dev *rcdev,
 		writel_relaxed(v, reset->prm->base + reset->prm->data->rstst);
 	}
 
+	if (reset->clkdm)
+		pdata->clkdm_deny_idle(reset->clkdm);
+
 	/* de-assert the reset control line */
 	spin_lock_irqsave(&reset->lock, flags);
 	v = readl_relaxed(reset->prm->base + reset->prm->data->rstctrl);
@@ -154,7 +165,7 @@ static int omap_reset_deassert(struct reset_controller_dev *rcdev,
 	spin_unlock_irqrestore(&reset->lock, flags);
 
 	if (!has_rstst)
-		return 0;
+		goto exit;
 
 	/* wait for the status to be set */
 	ret = readl_relaxed_poll_timeout(reset->prm->base +
@@ -165,7 +176,11 @@ static int omap_reset_deassert(struct reset_controller_dev *rcdev,
 		pr_err("%s: timedout waiting for %s:%lu\n", __func__,
 		       dev_name(rcdev->dev), id);
 
-	return 0;
+exit:
+	if (reset->clkdm)
+		pdata->clkdm_allow_idle(reset->clkdm);
+
+	return ret;
 }
 
 static const struct reset_control_ops omap_reset_ops = {
@@ -190,6 +205,8 @@ static int omap_prm_reset_init(struct platform_device *pdev,
 {
 	struct omap_reset_data *reset;
 	const struct omap_rst_map *map;
+	struct ti_prm_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	char buf[32];
 
 	/*
 	 * Check if we have controllable resets. If either rstctrl is non-zero
@@ -199,6 +216,11 @@ static int omap_prm_reset_init(struct platform_device *pdev,
 	if (!prm->data->rstctrl && !(prm->data->flags & OMAP_PRM_HAS_RSTCTRL))
 		return 0;
 
+	/* Check if we have the pdata callbacks in place */
+	if (!pdata || !pdata->clkdm_lookup || !pdata->clkdm_deny_idle ||
+	    !pdata->clkdm_allow_idle)
+		return -EINVAL;
+
 	map = prm->data->rstmap;
 	if (!map)
 		return -EINVAL;
@@ -213,10 +235,20 @@ static int omap_prm_reset_init(struct platform_device *pdev,
 	reset->rcdev.nr_resets = OMAP_MAX_RESETS;
 	reset->rcdev.of_xlate = omap_prm_reset_xlate;
 	reset->rcdev.of_reset_n_cells = 1;
+	reset->dev = &pdev->dev;
 	spin_lock_init(&reset->lock);
 
 	reset->prm = prm;
 
+	sprintf(buf, "%s_clkdm", prm->data->clkdm_name ? prm->data->clkdm_name :
+		prm->data->name);
+
+	if (!(prm->data->flags & OMAP_PRM_HAS_NO_CLKDM)) {
+		reset->clkdm = pdata->clkdm_lookup(buf);
+		if (!reset->clkdm)
+			return -EINVAL;
+	}
+
 	while (map->rst >= 0) {
 		reset->mask |= BIT(map->rst);
 		map++;
diff --git a/include/linux/platform_data/ti-prm.h b/include/linux/platform_data/ti-prm.h
new file mode 100644
index 000000000000..28154c3226c2
--- /dev/null
+++ b/include/linux/platform_data/ti-prm.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * TI PRM (Power & Reset Manager) platform data
+ *
+ * Copyright (C) 2019 Texas Instruments, Inc.
+ *
+ * Tero Kristo <t-kristo@ti.com>
+ */
+
+#ifndef _LINUX_PLATFORM_DATA_TI_PRM_H
+#define _LINUX_PLATFORM_DATA_TI_PRM_H
+
+struct clockdomain;
+
+struct ti_prm_platform_data {
+	void (*clkdm_deny_idle)(struct clockdomain *clkdm);
+	void (*clkdm_allow_idle)(struct clockdomain *clkdm);
+	struct clockdomain * (*clkdm_lookup)(const char *name);
+};
+
+#endif /* _LINUX_PLATFORM_DATA_TI_PRM_H */
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
