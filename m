From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 3/3] RTC: omap-rtc: add DT bindings
Date: Thu, 18 Oct 2012 17:53:51 +0200
Message-ID: <1350575631-15523-3-git-send-email-zonque@gmail.com>
References: <1350575631-15523-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:32989 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756285Ab2JRPyG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Oct 2012 11:54:06 -0400
In-Reply-To: <1350575631-15523-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rtc-linux@googlegroups.com
Cc: a.zummo@towertech.it, david-b@pacbell.net, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, koen@dominion.thruhere.net, Daniel Mack <zonque@gmail.com>

This adds bindings for the OMAP RTC driver.

There are currently two compatible string it matches, "ti,omap-rtc" and
"ti,am33xx-rtc". This is done because the AM33xx needs extra registers
to be written in order to unlock the register set.

Also, the OMAP_RTC_OSC_REG can be set up via DT, in particular two bits:

	32KCLK_EN  - Selects external clock source, namely
		     rtc_32k_clk_rtc_32k_clk that is from the
		     32-kHz oscillator

	32KCLK_SEL - 32-kHz clock enable post clock mux of
		     rtc_32k_clk_rtc_32k_aux_clk and
		     rtc_32k_clk_rtc_32k_clk

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 Documentation/devicetree/bindings/rtc/omap-rtc.txt | 25 +++++++
 drivers/rtc/rtc-omap.c                             | 78 ++++++++++++++++++++++
 2 files changed, 103 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/omap-rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/omap-rtc.txt b/Documentation/devicetree/bindings/rtc/omap-rtc.txt
new file mode 100644
index 0000000..a2abc9c
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/omap-rtc.txt
@@ -0,0 +1,25 @@
+* OMAP RTC
+
+Required properties:
+- compatible : Should be "ti,omap-rtc" or "ti,am33xx-rtc"
+
+
+Optional properties for AM33xx
+- ti,rtc-external-osc - Selects external clock source, namely
+			rtc_32k_clk_rtc_32k_clk that is from the
+			32-kHz oscillator
+
+- ti,rtc-32clk-enable - 32-kHz clock enable post clock mux of
+			rtc_32k_clk_rtc_32k_aux_clk and
+			rtc_32k_clk_rtc_32k_clk
+
+Example for AM33xx:
+
+rtc@44e3e000 {
+	compatible = "marvell,am33xx-rtc";
+	reg = <0x44e3e000 0x1000>;
+	interrupts = <75 76>;
+	ti,hwmods = "rtc";
+	ti,rtc-32clk-enable;
+	ti,rtc-external-osc;
+};
diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index baa876e..5529719 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -21,6 +21,8 @@
 #include <linux/rtc.h>
 #include <linux/bcd.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <asm/io.h>
 
@@ -65,6 +67,9 @@
 #define OMAP_RTC_COMP_MSB_REG		0x50
 #define OMAP_RTC_OSC_REG		0x54
 
+#define AM33XX_RTC_KICK0R_REG		0x6c
+#define AM33XX_RTC_KICK1R_REG		0x70
+
 /* OMAP_RTC_CTRL_REG bit fields: */
 #define OMAP_RTC_CTRL_SPLIT		(1<<7)
 #define OMAP_RTC_CTRL_DISABLE		(1<<6)
@@ -286,6 +291,76 @@ static struct rtc_class_ops omap_rtc_ops = {
 static int omap_rtc_alarm;
 static int omap_rtc_timer;
 
+enum {
+	OMAP_RTC_HW_OMAP = 0,
+	OMAP_RTC_HW_AM33XX,
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id of_omap_rtc_match[] = {
+	{
+		.compatible	= "ti,omap-rtc",
+		.data		= (void *) OMAP_RTC_HW_OMAP,
+	},
+	{
+		.compatible	= "ti,am33xx-rtc",
+		.data		= (void *) OMAP_RTC_HW_AM33XX,
+	},
+	{ }
+};
+
+static int omap_rtc_probe_dt(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	const struct of_device_id *match;
+	int hw_type;
+	u32 val;
+
+	match = of_match_device(of_omap_rtc_match, &pdev->dev);
+
+	if (!match)
+		return 0;
+
+	hw_type = (int) match->data;
+
+	if (hw_type == OMAP_RTC_HW_AM33XX) {
+		/*
+		 * From the datasheet:
+		 *
+		 * The kick registers (KICKnR) are used to enable and disable
+		 * write protection on the RTC registers. Out of reset, the RTC
+		 * registers are write-protected. To disable write protection,
+		 * correct keys must be written to the KICKnR registers. The
+		 * Kick0 register allows writing to unlock the kick0 data.
+		 */
+		__raw_writel(0x83e70b13, rtc_base + AM33XX_RTC_KICK0R_REG);
+		__raw_writel(0x95a4f1e0, rtc_base + AM33XX_RTC_KICK1R_REG);
+
+		/* Set RTC_OSC_REG */
+		val = __raw_readl(rtc_base + OMAP_RTC_OSC_REG);
+		if (of_get_property(np, "ti,rtc-32clk-enable", NULL))
+			val |= (1 << 6);
+		else
+			val &= ~(1 << 6);
+
+		if (of_get_property(np, "ti,rtc-external-osc", NULL))
+			val |= (1 << 3);
+		else
+			val &= ~(1 << 3);
+
+		__raw_writel(val, rtc_base + OMAP_RTC_OSC_REG);
+	}
+
+	return 0;
+}
+
+#else
+static int omap_rtc_probe_dt(struct platform_device *pdev)
+{
+	return 0;
+}
+#endif
+
 static int __init omap_rtc_probe(struct platform_device *pdev)
 {
 	struct resource		*res, *mem;
@@ -326,6 +401,8 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
+	omap_rtc_probe_dt(pdev);
+
 	rtc = rtc_device_register(pdev->name, &pdev->dev,
 			&omap_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc)) {
@@ -483,6 +560,7 @@ static struct platform_driver omap_rtc_driver = {
 	.driver		= {
 		.name	= "omap_rtc",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(of_omap_rtc_match),
 	},
 };
 
-- 
1.7.11.7

