From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH 4/4] usb: phy: samsung: Enable runtime power management on
 samsung-usb3
Date: Mon, 28 Jan 2013 17:12:28 +0530
Message-ID: <1359373348-18320-5-git-send-email-gautam.vivek@samsung.com>
References: <1359373348-18320-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1359373348-18320-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, sarah.a.sharp@linux.intel.com, kgene.kim@samsung.com, dianders@chromium.org, sylvester.nawrocki@gmail.com, tomasz.figa@gmail.com
List-Id: linux-omap@vger.kernel.org

Enabling runtime power management support on samsung-usb3 phy
and further adding support to turn off the PHY ref_clk PLL.
It thereby requires PHY ref_clk to be switched between internal
core clock and external PLL clock.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/usb/phy/samsung-usb3.c   |  107 +++++++++++++++++++++++++++++++++++--
 drivers/usb/phy/samsung-usbphy.c |   26 +++++++++
 drivers/usb/phy/samsung-usbphy.h |    1 +
 3 files changed, 128 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/phy/samsung-usb3.c b/drivers/usb/phy/samsung-usb3.c
index 29e1321..4dbef15 100644
--- a/drivers/usb/phy/samsung-usb3.c
+++ b/drivers/usb/phy/samsung-usb3.c
@@ -22,8 +22,10 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/gpio.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/pm_runtime.h>
 #include <linux/usb/samsung_usb_phy.h>
 #include <linux/platform_data/samsung-usbphy.h>
 
@@ -32,7 +34,7 @@
 /*
  * Sets the phy clk as EXTREFCLK (XXTI) which is internal clock from clock core.
  */
-static u32 samsung_usb3_phy_set_refclk(struct samsung_usbphy *sphy)
+static u32 samsung_usb3_phy_set_refclk_int(struct samsung_usbphy *sphy)
 {
 	u32 reg;
 	u32 refclk;
@@ -65,7 +67,22 @@ static u32 samsung_usb3_phy_set_refclk(struct samsung_usbphy *sphy)
 	return reg;
 }
 
-static int samsung_exynos5_usb3_phy_enable(struct samsung_usbphy *sphy)
+/*
+ * Sets the phy clk as ref_pad_clk (XusbXTI) which is clock from external PLL.
+ */
+static u32 samsung_usb3_phy_set_refclk_ext(void)
+{
+	u32 reg;
+
+	reg = PHYCLKRST_REFCLKSEL_PAD_REFCLK |
+		PHYCLKRST_FSEL_PAD_100MHZ |
+		PHYCLKRST_MPLL_MULTIPLIER_100MHZ_REF;
+
+	return reg;
+}
+
+static int samsung_exynos5_usb3_phy_enable(struct samsung_usbphy *sphy,
+							bool use_ext_clk)
 {
 	void __iomem *regs = sphy->regs;
 	u32 phyparam0;
@@ -80,7 +97,11 @@ static int samsung_exynos5_usb3_phy_enable(struct samsung_usbphy *sphy)
 
 	phyparam0 = readl(regs + EXYNOS5_DRD_PHYPARAM0);
 	/* Select PHY CLK source */
-	phyparam0 &= ~PHYPARAM0_REF_USE_PAD;
+	if (use_ext_clk)
+		phyparam0 |= PHYPARAM0_REF_USE_PAD;
+	else
+		phyparam0 &= ~PHYPARAM0_REF_USE_PAD;
+
 	/* Set Loss-of-Signal Detector sensitivity */
 	phyparam0 &= ~PHYPARAM0_REF_LOSLEVEL_MASK;
 	phyparam0 |= PHYPARAM0_REF_LOSLEVEL;
@@ -115,7 +136,10 @@ static int samsung_exynos5_usb3_phy_enable(struct samsung_usbphy *sphy)
 	/* UTMI Power Control */
 	writel(PHYUTMI_OTGDISABLE, regs + EXYNOS5_DRD_PHYUTMI);
 
-	phyclkrst = samsung_usb3_phy_set_refclk(sphy);
+	if (use_ext_clk)
+		phyclkrst = samsung_usb3_phy_set_refclk_ext();
+	else
+		phyclkrst = samsung_usb3_phy_set_refclk_int(sphy);
 
 	phyclkrst |= PHYCLKRST_PORTRESET |
 			/* Digital power supply in normal operating mode */
@@ -163,7 +187,7 @@ static void samsung_exynos5_usb3_phy_disable(struct samsung_usbphy *sphy)
 	writel(phytest, regs + EXYNOS5_DRD_PHYTEST);
 }
 
-static int samsung_usb3_phy_init(struct usb_phy *phy)
+static int samsung_exynos5_usb3_phy_init(struct usb_phy *phy, bool use_ext_clk)
 {
 	struct samsung_usbphy *sphy;
 	unsigned long flags;
@@ -187,7 +211,7 @@ static int samsung_usb3_phy_init(struct usb_phy *phy)
 	samsung_usbphy_set_isolation(sphy, false);
 
 	/* Initialize usb phy registers */
-	samsung_exynos5_usb3_phy_enable(sphy);
+	samsung_exynos5_usb3_phy_enable(sphy, use_ext_clk);
 
 	spin_unlock_irqrestore(&sphy->lock, flags);
 
@@ -198,6 +222,34 @@ static int samsung_usb3_phy_init(struct usb_phy *phy)
 }
 
 /*
+ * Switch  between internal core clock and external oscillator clock
+ * for PHY reference clock
+ */
+static int samsung_exynos5_usb3phy_clk_switch(struct usb_phy *phy,
+						bool use_ext_clk)
+{
+	/*
+	 * This will switch PHY refclk from internal core clock
+	 * to external PLL clock when device is in use and vice versa
+	 * when device plunge into runtime suspend mode.
+	 */
+	return samsung_exynos5_usb3_phy_init(phy, use_ext_clk);
+}
+
+/*
+ * The function passed to the usb driver for phy initialization
+ */
+static int samsung_usb3_phy_init(struct usb_phy *phy)
+{
+	/*
+	 * We start with using PHY refclk from external PLL,
+	 * once runtime suspend for the device is called this
+	 * will change to internal core clock
+	 */
+	return  samsung_exynos5_usb3_phy_init(phy, true);
+}
+
+/*
  * The function passed to the usb driver for phy shutdown
  */
 static void samsung_usb3_phy_shutdown(struct usb_phy *phy)
@@ -287,6 +339,9 @@ static int samsung_usb3_phy_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sphy);
 
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	return usb_add_phy(&sphy->phy, USB_PHY_TYPE_USB3);
 }
 
@@ -296,6 +351,8 @@ static int samsung_usb3_phy_remove(struct platform_device *pdev)
 
 	usb_remove_phy(&sphy->phy);
 
+	pm_runtime_disable(&pdev->dev);
+
 	if (sphy->pmuregs)
 		iounmap(sphy->pmuregs);
 	if (sphy->sysreg)
@@ -304,6 +361,42 @@ static int samsung_usb3_phy_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int samsung_usb3_phy_runtime_suspend(struct device *dev)
+{
+	struct samsung_usbphy *sphy = dev_get_drvdata(dev);
+
+	samsung_exynos5_usb3phy_clk_switch(&sphy->phy, false);
+
+	if (gpio_is_valid(sphy->phyclk_gpio))
+		gpio_set_value(sphy->phyclk_gpio, 0);
+
+	return 0;
+}
+
+static int samsung_usb3_phy_runtime_resume(struct device *dev)
+{
+	struct samsung_usbphy *sphy = dev_get_drvdata(dev);
+
+	if (gpio_is_valid(sphy->phyclk_gpio)) {
+		gpio_set_value(sphy->phyclk_gpio, 1);
+		/*
+		 * PI6C557-03 clock generator needs 3ms typically to stabilise,
+		 * but the datasheet doesn't list max.  We'll sleep for 10ms
+		 * and cross our fingers that it's enough.
+		 */
+		usleep_range(10000, 20000);
+	}
+
+	samsung_exynos5_usb3phy_clk_switch(&sphy->phy, true);
+
+	return 0;
+}
+
+static const struct dev_pm_ops samsung_usb3_phy_pm_ops = {
+	SET_RUNTIME_PM_OPS(samsung_usb3_phy_runtime_suspend,
+				samsung_usb3_phy_runtime_resume, NULL)
+};
+
 static struct samsung_usbphy_drvdata usb3_phy_exynos5 = {
 	.cpu_type		= TYPE_EXYNOS5250,
 	.devphy_en_mask		= EXYNOS_USBPHY_ENABLE,
@@ -338,7 +431,9 @@ static struct platform_driver samsung_usb3_phy_driver = {
 		.name	= "samsung-usb3-phy",
 		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(samsung_usbphy_dt_match),
+		.pm	= &samsung_usb3_phy_pm_ops,
 	},
+
 };
 
 module_platform_driver(samsung_usb3_phy_driver);
diff --git a/drivers/usb/phy/samsung-usbphy.c b/drivers/usb/phy/samsung-usbphy.c
index 7782a43..fb17b84 100644
--- a/drivers/usb/phy/samsung-usbphy.c
+++ b/drivers/usb/phy/samsung-usbphy.c
@@ -26,6 +26,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_gpio.h>
 #include <linux/usb/samsung_usb_phy.h>
 
 #include "samsung-usbphy.h"
@@ -33,6 +34,7 @@
 int samsung_usbphy_parse_dt(struct samsung_usbphy *sphy)
 {
 	struct device_node *usbphy_sys;
+	int ret;
 
 	/* Getting node for system controller interface for usb-phy */
 	usbphy_sys = of_get_child_by_name(sphy->dev->of_node, "usbphy-sys");
@@ -57,6 +59,30 @@ int samsung_usbphy_parse_dt(struct samsung_usbphy *sphy)
 	if (sphy->sysreg == NULL)
 		dev_warn(sphy->dev, "Can't get usb-phy sysreg cfg register\n");
 
+	/* Getting PHY clk gpio here to enable/disable PHY clock PLL, if any */
+	sphy->phyclk_gpio = of_get_named_gpio(sphy->dev->of_node,
+						"samsung,phyclk-gpio", 0);
+	/*
+	 * We don't want to return error code here in case we don't get the
+	 * PHY clock gpio, some PHYs may not have it.
+	 */
+	if (gpio_is_valid(sphy->phyclk_gpio)) {
+		ret = gpio_request_one(sphy->phyclk_gpio, GPIOF_INIT_HIGH,
+						"samsung_usb_phy_clock_en");
+		if (ret) {
+			/*
+			 * We don't want to return error code here,
+			 * sometimes either of usb2 phy or usb3 phy may not
+			 * have the PHY clock gpio.
+			 */
+			dev_err(sphy->dev, "can't request phyclk gpio %d\n",
+						sphy->phyclk_gpio);
+			sphy->phyclk_gpio = -EINVAL;
+		}
+	} else {
+		dev_warn(sphy->dev, "Can't get usb-phy clock gpio\n");
+	}
+
 	of_node_put(usbphy_sys);
 
 	return 0;
diff --git a/drivers/usb/phy/samsung-usbphy.h b/drivers/usb/phy/samsung-usbphy.h
index f7e657d..1921ab0 100644
--- a/drivers/usb/phy/samsung-usbphy.h
+++ b/drivers/usb/phy/samsung-usbphy.h
@@ -300,6 +300,7 @@ struct samsung_usbphy {
 	enum samsung_usb_phy_type phy_type;
 	atomic_t	phy_usage;
 	spinlock_t	lock;
+	int		phyclk_gpio;
 };
 
 #define phy_to_sphy(x)		container_of((x), struct samsung_usbphy, phy)
-- 
1.7.6.5
