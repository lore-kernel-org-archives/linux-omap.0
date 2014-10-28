From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH V4 3/3] rtc: omap: Support regulator supply for RTC
Date: Tue, 28 Oct 2014 15:28:52 +0530
Message-ID: <1414490332-14856-4-git-send-email-lokeshvutla@ti.com>
References: <1414490332-14856-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36449 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752397AbaJ1KAs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Oct 2014 06:00:48 -0400
In-Reply-To: <1414490332-14856-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rtc-linux@googlegroups.com, linux-omap@vger.kernel.org
Cc: johan@kernel.org, tony@atomide.com, balbi@ti.com, akpm@linux-foundation.org, nsekhar@ti.com, t-kristo@ti.com, j-keerthy@ti.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, nm@ti.com, lokeshvutla@ti.com

Certain SoCs such as DRA7, RTC is an independent voltage domain of it's own
and on platforms such as DRA7-evm, this may be supplied by individual
regulator on it's own.
So make the OMAP RTC driver support a power regulator.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
- Dropped the Reviewed-by tags as this patch is changed from previous version.
 Documentation/devicetree/bindings/rtc/rtc-omap.txt |  6 ++++
 drivers/rtc/rtc-omap.c                             | 41 +++++++++++++++++++++-
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/rtc-omap.txt b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
index 750efd4..c1d84ac 100644
--- a/Documentation/devicetree/bindings/rtc/rtc-omap.txt
+++ b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
@@ -15,6 +15,9 @@ Required properties:
 Optional properties:
 - ti,system-power-controller: whether the rtc is controlling the system power
   through pmic_power_en
+- vrtc-supply: phandle to the regulator device tree node.
+- vrtc-minuV: Minimum required voltage in uV, If default voltage needs to be changed
+- vrtc-maxuV: Maximum acceptable voltage in uV, If default voltage needs to be changed
 
 Example:
 
@@ -25,4 +28,7 @@ rtc@1c23000 {
 		      19>;
 	interrupt-parent = <&intc>;
 	ti,system-power-controller;
+	vrtc-supply = <&ldo9_reg>;
+	vrtc-minuV = <1050000>;
+	vrtc-maxuV = <1050000>;
 };
diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index d9bb5e7..7f1358a 100644
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
@@ -484,7 +486,7 @@ static int omap_rtc_probe(struct platform_device *pdev)
 	u8 reg, mask, new_ctrl;
 	const struct platform_device_id *id_entry;
 	const struct of_device_id *of_id;
-	int ret;
+	int ret, vrtc_minuV = 0, vrtc_maxuV = 0;
 
 	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
 	if (!rtc)
@@ -514,6 +516,37 @@ static int omap_rtc_probe(struct platform_device *pdev)
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
+		of_property_read_u32(pdev->dev.of_node, "vrtc-minuV",
+				     &vrtc_minuV);
+		of_property_read_u32(pdev->dev.of_node, "vrtc-maxuV",
+				     &vrtc_maxuV);
+		if (vrtc_minuV && vrtc_maxuV) {
+			ret = regulator_set_voltage(rtc->supply,
+						    vrtc_minuV, vrtc_maxuV);
+			if (ret) {
+				dev_err(&pdev->dev, "failed to set volt %d\n",
+					ret);
+				return ret;
+			}
+		}
+
+		ret = regulator_enable(rtc->supply);
+		if (ret) {
+			dev_err(&pdev->dev, "regulator enable failed %d\n",
+				ret);
+			return ret;
+		}
+	}
+
 	platform_set_drvdata(pdev, rtc);
 
 	/* Enable the clock/module so that we can access the registers */
@@ -624,6 +657,9 @@ err:
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
+	if (rtc->supply)
+		regulator_disable(rtc->supply);
+
 	return ret;
 }
 
@@ -649,6 +685,9 @@ static int __exit omap_rtc_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
+	if (rtc->supply)
+		regulator_disable(rtc->supply);
+
 	return 0;
 }
 
-- 
1.9.1

