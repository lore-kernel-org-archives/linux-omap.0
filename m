From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH V4 3/3] rtc: omap: Support regulator supply for RTC
Date: Fri, 24 Oct 2014 13:37:34 +0530
Message-ID: <1414138054-16411-1-git-send-email-lokeshvutla@ti.com>
References: <1414126425-13198-4-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47919 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751630AbaJXIJg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Oct 2014 04:09:36 -0400
In-Reply-To: <1414126425-13198-4-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rtc-linux@googlegroups.com, linux-omap@vger.kernel.org, a.zummo@towertech.it, johan@kernel.org
Cc: tony@atomide.com, bcousson@baylibre.com, balbi@ti.com, akpm@linux-foundation.org, linux@roeck-us.net, nsekhar@ti.com, t-kristo@ti.com, j-keerthy@ti.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, lokeshvutla@ti.com

On some Soc's RTC is powered by an external power regulator.
e.g. RTC on DRA7 SoC. Make the OMAP RTC driver support a
power regulator.

Reviewed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Changes since v3:
- Removed extra Optional properties header.
- Moved regulator get before platform_set_drvdatai() as suggested by Johan

 Documentation/devicetree/bindings/rtc/rtc-omap.txt |  2 ++
 drivers/rtc/rtc-omap.c                             | 24 ++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/rtc-omap.txt b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
index 750efd4..42ff41f 100644
--- a/Documentation/devicetree/bindings/rtc/rtc-omap.txt
+++ b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
@@ -15,6 +15,7 @@ Required properties:
 Optional properties:
 - ti,system-power-controller: whether the rtc is controlling the system power
   through pmic_power_en
+- vrtc-supply: phandle to the regulator device tree node if needed
 
 Example:
 
@@ -25,4 +26,5 @@ rtc@1c23000 {
 		      19>;
 	interrupt-parent = <&intc>;
 	ti,system-power-controller;
+	vrtc-supply = <&ldo9_reg>;
 };
diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index d9bb5e7..7f1b527 100644
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
@@ -514,6 +516,22 @@ static int omap_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(rtc->base))
 		return PTR_ERR(rtc->base);
 
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
 	platform_set_drvdata(pdev, rtc);
 
 	/* Enable the clock/module so that we can access the registers */
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

