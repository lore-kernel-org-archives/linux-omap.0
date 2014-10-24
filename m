From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH V3 3/3] rtc: omap: Support regulator supply for RTC
Date: Fri, 24 Oct 2014 10:23:45 +0530
Message-ID: <1414126425-13198-4-git-send-email-lokeshvutla@ti.com>
References: <1414126425-13198-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35950 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755270AbaJXE4B (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Oct 2014 00:56:01 -0400
In-Reply-To: <1414126425-13198-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rtc-linux@googlegroups.com, linux-omap@vger.kernel.org, a.zummo@towertech.it, johan@kernel.org
Cc: tony@atomide.com, bcousson@baylibre.com, balbi@ti.com, akpm@linux-foundation.org, linux@roeck-us.net, nsekhar@ti.com, t-kristo@ti.com, j-keerthy@ti.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, lokeshvutla@ti.com

On some Soc's RTC is powered by an external power regulator.
e.g. RTC on DRA7 SoC. Make the OMAP RTC driver support a
power regulator.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 Documentation/devicetree/bindings/rtc/rtc-omap.txt |  3 +++
 drivers/rtc/rtc-omap.c                             | 24 ++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/rtc-omap.txt b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
index 750efd4..e7ad12b 100644
--- a/Documentation/devicetree/bindings/rtc/rtc-omap.txt
+++ b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
@@ -15,6 +15,8 @@ Required properties:
 Optional properties:
 - ti,system-power-controller: whether the rtc is controlling the system power
   through pmic_power_en
+Optional Properties:
+- vrtc-supply: phandle to the regulator device tree node if needed
 
 Example:
 
@@ -25,4 +27,5 @@ rtc@1c23000 {
 		      19>;
 	interrupt-parent = <&intc>;
 	ti,system-power-controller;
+	vrtc-supply = <&ldo9_reg>;
 };
diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index d9bb5e7..61fe630 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -25,6 +25,7 @@
 #include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/io.h>
+#include <linux/regulator/consumer.h>
 
 /*
  * The OMAP RTC is a year/month/day/hours/minutes/seconds BCD clock
@@ -134,6 +135,7 @@ struct omap_rtc {
 	u8 interrupts_reg;
 	bool is_pmic_controller;
 	const struct omap_rtc_device_type *type;
+	struct regulator *supply;
 };
 
 static inline u8 rtc_read(struct omap_rtc *rtc, unsigned int reg)
@@ -516,6 +518,22 @@ static int omap_rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, rtc);
 
+	rtc->supply = devm_regulator_get_optional(&pdev->dev, "vrtc");
+	if (IS_ERR(rtc->supply)) {
+		if (PTR_ERR(rtc->supply) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		rtc->supply = NULL;
+	}
+
+	if (rtc->supply) {
+		ret = regulator_enable(rtc->supply);
+		if (ret) {
+			dev_err(&pdev->dev, "regulator enable failed\n");
+			return ret;
+		}
+	}
+
 	/* Enable the clock/module so that we can access the registers */
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
@@ -624,6 +642,9 @@ err:
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
+	if (rtc->supply)
+		regulator_disable(rtc->supply);
+
 	return ret;
 }
 
@@ -649,6 +670,9 @@ static int __exit omap_rtc_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
+	if (rtc->supply)
+		regulator_disable(rtc->supply);
+
 	return 0;
 }
 
-- 
1.9.1

