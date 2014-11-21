From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH 06/11] phy: exynos5-usbdrd: Add facility for VBUS-BOOST-5V
 supply
Date: Fri, 21 Nov 2014 19:05:49 +0530
Message-ID: <1416576954-11997-7-git-send-email-gautam.vivek@samsung.com>
References: <1416576954-11997-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1416576954-11997-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, balbi@ti.com, kishon@ti.com
Cc: linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, tomasz.figa@gmail.com, s.nawrocki@samsung.com, robh+dt@kernel.org, stern@rowland.harvard.edu, kgene.kim@samsung.com, Vivek Gautam <gautam.vivek@samsung.com>
List-Id: linux-omap@vger.kernel.org

Some Exynos boards have a separate regulator controlling a
Boost 5V supply which goes as input for VBUS regulator.
So adding a control for the same in driver, to enable
vbus supply on the port.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/phy/phy-exynos5-usbdrd.c |   32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-exynos5-usbdrd.c b/drivers/phy/phy-exynos5-usbdrd.c
index 3654712..1f54639 100644
--- a/drivers/phy/phy-exynos5-usbdrd.c
+++ b/drivers/phy/phy-exynos5-usbdrd.c
@@ -159,6 +159,8 @@ struct exynos5_usbdrd_phy_drvdata {
  *	       reference clocks' for SS and HS operations
  * @ref_clk: reference clock to PHY block from which PHY's
  *	     operational clocks are derived
+ * vbus: VBUS regulator for phy
+ * vbus_boost: Boost regulator for VBUS present on few Exynos boards
  */
 struct exynos5_usbdrd_phy {
 	struct device *dev;
@@ -178,6 +180,7 @@ struct exynos5_usbdrd_phy {
 	u32 extrefclk;
 	struct clk *ref_clk;
 	struct regulator *vbus;
+	struct regulator *vbus_boost;
 };
 
 static inline
@@ -460,11 +463,20 @@ static int exynos5_usbdrd_phy_power_on(struct phy *phy)
 	}
 
 	/* Enable VBUS supply */
+	if (phy_drd->vbus_boost) {
+		ret = regulator_enable(phy_drd->vbus_boost);
+		if (ret) {
+			dev_err(phy_drd->dev,
+				"Failed to enable VBUS boost supply\n");
+			goto fail_vbus;
+		}
+	}
+
 	if (phy_drd->vbus) {
 		ret = regulator_enable(phy_drd->vbus);
 		if (ret) {
 			dev_err(phy_drd->dev, "Failed to enable VBUS supply\n");
-			goto fail_vbus;
+			goto fail_vbus_boost;
 		}
 	}
 
@@ -473,6 +485,10 @@ static int exynos5_usbdrd_phy_power_on(struct phy *phy)
 
 	return 0;
 
+fail_vbus_boost:
+	if (phy_drd->vbus_boost)
+		regulator_disable(phy_drd->vbus_boost);
+
 fail_vbus:
 	clk_disable_unprepare(phy_drd->ref_clk);
 	if (!phy_drd->drv_data->has_common_clk_gate) {
@@ -497,6 +513,8 @@ static int exynos5_usbdrd_phy_power_off(struct phy *phy)
 	/* Disable VBUS supply */
 	if (phy_drd->vbus)
 		regulator_disable(phy_drd->vbus);
+	if (phy_drd->vbus_boost)
+		regulator_disable(phy_drd->vbus_boost);
 
 	clk_disable_unprepare(phy_drd->ref_clk);
 	if (!phy_drd->drv_data->has_common_clk_gate) {
@@ -690,7 +708,7 @@ static int exynos5_usbdrd_phy_probe(struct platform_device *pdev)
 		break;
 	}
 
-	/* Get Vbus regulator */
+	/* Get Vbus regulators */
 	phy_drd->vbus = devm_regulator_get(dev, "vbus");
 	if (IS_ERR(phy_drd->vbus)) {
 		ret = PTR_ERR(phy_drd->vbus);
@@ -701,6 +719,16 @@ static int exynos5_usbdrd_phy_probe(struct platform_device *pdev)
 		phy_drd->vbus = NULL;
 	}
 
+	phy_drd->vbus_boost = devm_regulator_get(dev, "vbus-boost");
+	if (IS_ERR(phy_drd->vbus_boost)) {
+		ret = PTR_ERR(phy_drd->vbus_boost);
+		if (ret == -EPROBE_DEFER)
+			return ret;
+
+		dev_warn(dev, "Failed to get VBUS boost supply regulator\n");
+		phy_drd->vbus_boost = NULL;
+	}
+
 	dev_vdbg(dev, "Creating usbdrd_phy phy\n");
 
 	for (i = 0; i < EXYNOS5_DRDPHYS_NUM; i++) {
-- 
1.7.10.4
