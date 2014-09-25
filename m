From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 4/4] rtc: omap: Support regulator supply for RTC
Date: Thu, 25 Sep 2014 15:02:09 +0530
Message-ID: <1411637529-18289-5-git-send-email-lokeshvutla@ti.com>
References: <1411637529-18289-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43691 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751985AbaIYJeI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Sep 2014 05:34:08 -0400
In-Reply-To: <1411637529-18289-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rtc-linux@googlegroups.com, a.zummo@towertech.it
Cc: nsekhar@ti.com, t-kristo@ti.com, j-keerthy@ti.com, balbi@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, lokeshvutla@ti.com

On some Soc's RTC is powered by an external power regulator.
e.g. RTC on DRA7 SoC. Make the OMAP RTC driver support a
power regulator.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Changes since v1:
	- Separated probe deferral supporting into a new patch.
 Documentation/devicetree/bindings/rtc/rtc-omap.txt |  3 +++
 drivers/rtc/rtc-omap.c                             | 24 ++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/rtc-omap.txt b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
index 5a0f02d..c67a775 100644
--- a/Documentation/devicetree/bindings/rtc/rtc-omap.txt
+++ b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
@@ -10,6 +10,9 @@ Required properties:
 - interrupts: rtc timer, alarm interrupts in order
 - interrupt-parent: phandle for the interrupt controller
 
+Optional Properties:
+- rtc-supply : phandle to the regulator device tree node if needed
+
 Example:
 
 rtc@1c23000 {
diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index f28f1fd..8a8df2b 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -24,6 +24,7 @@
 #include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/io.h>
+#include <linux/regulator/consumer.h>
 
 /* The OMAP RTC is a year/month/day/hours/minutes/seconds BCD clock
  * with century-range alarm matching, driven by the 32kHz clock.
@@ -124,6 +125,7 @@
  * @device:		Device Pointer.
  * pdata :		Copy of saved platform data.
  * rtc_base :		Base address of memory-mapped IO registers.
+ * rtc_reg :		Pointer to RTC power regulator.
  * rtc_alarm :		RTC alarm interrupt number.
  * rtc_timer :		RTC timer interrupt number.
  * irq_stat :		Copy of Interrupt status register.
@@ -133,6 +135,7 @@ struct rtc_omap_dev {
 	struct device		*dev;
 	unsigned long		pdata;
 	void __iomem		*rtc_base;
+	struct regulator	*rtc_reg;
 	u32			rtc_alarm;
 	u32			rtc_timer;
 	u8			irqstat;
@@ -402,6 +405,7 @@ static int omap_rtc_probe(struct platform_device *pdev)
 	struct resource		*res;
 	struct rtc_omap_dev	*rtc_omap;
 	u8			reg, new_ctrl;
+	int			ret;
 	const struct platform_device_id *id_entry;
 	const struct of_device_id *of_id;
 
@@ -440,6 +444,23 @@ static int omap_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(rtc_omap->rtc_base))
 		return PTR_ERR(rtc_omap->rtc_base);
 
+	rtc_omap->rtc_reg =  devm_regulator_get_optional(&pdev->dev, "rtc");
+	if (IS_ERR(rtc_omap->rtc_reg)) {
+		if (PTR_ERR(rtc_omap->rtc_reg) == -EPROBE_DEFER) {
+			dev_err(&pdev->dev, "regulator not ready, retry\n");
+			return -EPROBE_DEFER;
+		}
+		rtc_omap->rtc_reg = NULL;
+	}
+
+	if (rtc_omap->rtc_reg) {
+		ret = regulator_enable(rtc_omap->rtc_reg);
+		if (ret) {
+			dev_dbg(&pdev->dev, "regulator enable failed\n");
+			return ret;
+		}
+	}
+
 	/* Enable the clock/module so that we can access the registers */
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
@@ -549,6 +570,9 @@ static int __exit omap_rtc_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
+	if (rtc_omap->rtc_reg)
+		regulator_disable(rtc_omap->rtc_reg);
+
 	return 0;
 }
 
-- 
1.9.1

