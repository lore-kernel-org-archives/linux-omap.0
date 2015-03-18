From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH v2] phy: Add a driver for dm816x USB PHY
Date: Tue, 17 Mar 2015 17:12:34 -0700
Message-ID: <1426637554-27178-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nov-007-i574.relay.mailchannels.net ([46.232.183.128]:10045
	"EHLO relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752997AbbCRARx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Mar 2015 20:17:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Bin Liu <binmlist@gmail.com>, Brian Hutchinson <b.hutchman@gmail.com>, Felipe Balbi <balbi@ti.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Paul Bolle <pebolle@tiscali.nl>, Rusty Russell <rusty@rustcorp.com.au>

Add a minimal driver for dm816x USB. This makes USB work on dm816x
without any other changes needed as it can use the existing musb_dsps
glue layer for the USB controller.

Note that this phy is different from dm814x and am335x.

Cc: Bin Liu <binmlist@gmail.com>
Cc: Brian Hutchinson <b.hutchman@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Paul Bolle <pebolle@tiscali.nl>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 .../devicetree/bindings/phy/dm816x-phy.txt         |  24 ++
 drivers/phy/Kconfig                                |   7 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-dm816x-usb.c                       | 304 +++++++++++++++++++++
 4 files changed, 336 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/dm816x-phy.txt
 create mode 100644 drivers/phy/phy-dm816x-usb.c

diff --git a/Documentation/devicetree/bindings/phy/dm816x-phy.txt b/Documentation/devicetree/bindings/phy/dm816x-phy.txt
new file mode 100644
index 0000000..2fe3d11
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/dm816x-phy.txt
@@ -0,0 +1,24 @@
+Device tree binding documentation for am816x USB PHY
+=========================
+
+Required properties:
+- compatible : should be "ti,dm816x-usb-phy"
+- reg : offset and length of the PHY register set.
+- reg-names : name for the phy registers
+- clocks : phandle to the clock
+- clock-names : name of the clock
+- syscon: phandle for the syscon node to access misc registers
+- #phy-cells : from the generic PHY bindings, must be 1
+- syscon: phandle for the syscon node to access misc registers
+
+Example:
+
+usb_phy0: usb-phy@20 {
+	compatible = "ti,dm8168-usb-phy";
+	reg = <0x20 0x8>;
+	reg-names = "phy";
+	clocks = <&main_fapll 6>;
+	clock-names = "refclk";
+	#phy-cells = <0>;
+	syscon = <&scm_conf>;
+};
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 2962de2..c858c2b 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -35,6 +35,13 @@ config ARMADA375_USBCLUSTER_PHY
 	depends on OF
 	select GENERIC_PHY
 
+config PHY_DM816X_USB
+	tristate "TI dm816x USB PHY driver"
+	depends on ARCH_OMAP2PLUS
+	select GENERIC_PHY
+	help
+	  Enable this for dm81xx USB to work."
+
 config PHY_EXYNOS_MIPI_VIDEO
 	tristate "S5P/EXYNOS SoC series MIPI CSI-2/DSI PHY driver"
 	depends on HAS_IOMEM
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index f080e1b..dab6665 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -5,6 +5,7 @@
 obj-$(CONFIG_GENERIC_PHY)		+= phy-core.o
 obj-$(CONFIG_PHY_BERLIN_USB)		+= phy-berlin-usb.o
 obj-$(CONFIG_PHY_BERLIN_SATA)		+= phy-berlin-sata.o
+obj-$(CONFIG_PHY_DM816X_USB)		+= phy-dm816x-usb.o
 obj-$(CONFIG_ARMADA375_USBCLUSTER_PHY)	+= phy-armada375-usb2.o
 obj-$(CONFIG_BCM_KONA_USB2_PHY)		+= phy-bcm-kona-usb2.o
 obj-$(CONFIG_PHY_EXYNOS_DP_VIDEO)	+= phy-exynos-dp-video.o
diff --git a/drivers/phy/phy-dm816x-usb.c b/drivers/phy/phy-dm816x-usb.c
new file mode 100644
index 0000000..2fc276d
--- /dev/null
+++ b/drivers/phy/phy-dm816x-usb.c
@@ -0,0 +1,304 @@
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/io.h>
+#include <linux/usb/phy_companion.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/pm_runtime.h>
+#include <linux/delay.h>
+#include <linux/phy/phy.h>
+#include <linux/of_platform.h>
+
+#include <linux/mfd/syscon.h>
+
+/*
+ * TRM has two sets of USB_CTRL registers.. The correct register bits
+ * are in TRM section 24.9.8.2 USB_CTRL Register. The TRM documents the
+ * phy as being SR70LX Synopsys USB 2.0 OTG nanoPHY. It also seems at
+ * least dm816x rev c ignores writes to USB_CTRL register, but the TI
+ * kernel is writing to those so it's possible that later revisions
+ * have worknig USB_CTRL register.
+ *
+ * Also note that At least USB_CTRL register seems to be dm816x specific
+ * according to the TRM. It's possible that USBPHY_CTRL is more generic,
+ * but that would have to be checked against the SR70LX documentation
+ * which does not seem to be publicly available.
+ *
+ * Finally, the phy on dm814x and am335x is different from dm816x.
+ */
+#define DM816X_USB_CTRL_PHYCLKSRC	BIT(8)	/* 1 = PLL ref clock */
+#define DM816X_USB_CTRL_PHYSLEEP1	BIT(1)	/* Enable the first phy */
+#define DM816X_USB_CTRL_PHYSLEEP0	BIT(0)	/* Enable the second phy */
+
+#define DM816X_USBPHY_CTRL_TXRISETUNE	1
+#define DM816X_USBPHY_CTRL_TXVREFTUNE	0xc
+#define DM816X_USBPHY_CTRL_TXPREEMTUNE	0x2
+
+struct dm816x_usb_phy {
+	struct regmap *syscon;
+	struct device *dev;
+	unsigned int instance;
+	struct clk *refclk;
+	struct usb_phy phy;
+	unsigned int usb_ctrl;		/* Shared between phy0 and phy1 */
+	unsigned int usbphy_ctrl;
+};
+
+static int dm816x_usb_phy_set_host(struct usb_otg *otg, struct usb_bus *host)
+{
+	otg->host = host;
+	if (!host)
+		otg->state = OTG_STATE_UNDEFINED;
+
+	return 0;
+}
+
+static int dm816x_usb_phy_set_peripheral(struct usb_otg *otg,
+					 struct usb_gadget *gadget)
+{
+	otg->gadget = gadget;
+	if (!gadget)
+		otg->state = OTG_STATE_UNDEFINED;
+
+	return 0;
+}
+
+/*
+ * We have phy-core.c handle pm_runtime calls for us. We implement
+ * these functions for phy-core.c to keep track of power_count.
+ * Note that we may want to remove these eventually and rely only
+ * on the usecounting done by PM runtime.
+ */
+static int dm816x_usb_phy_power_off(struct phy *x)
+{
+	return 0;
+}
+
+static int dm816x_usb_phy_power_on(struct phy *x)
+{
+	return 0;
+}
+
+static int dm816x_usb_phy_init(struct phy *x)
+{
+	struct dm816x_usb_phy *phy = phy_get_drvdata(x);
+	unsigned int val;
+	int error;
+
+	if (clk_get_rate(phy->refclk) != 24000000)
+		dev_warn(phy->dev, "nonstandard phy refclk\n");
+
+	/* Set PLL ref clock and put phys to sleep */
+	error = regmap_update_bits(phy->syscon, phy->usb_ctrl,
+				   DM816X_USB_CTRL_PHYCLKSRC |
+				   DM816X_USB_CTRL_PHYSLEEP1 |
+				   DM816X_USB_CTRL_PHYSLEEP0,
+				   0);
+	regmap_read(phy->syscon, phy->usb_ctrl, &val);
+
+	/*
+	 * TI kernel sets these values for "symmetrical eye diagram and
+	 * better signal quality" so let's assume somebody checked the
+	 * values with a scope and set them here too.
+	 */
+	regmap_read(phy->syscon, phy->usbphy_ctrl, &val);
+	val |= DM816X_USBPHY_CTRL_TXRISETUNE |
+		DM816X_USBPHY_CTRL_TXVREFTUNE |
+		DM816X_USBPHY_CTRL_TXPREEMTUNE;
+	regmap_write(phy->syscon, phy->usbphy_ctrl, val);
+
+	return 0;
+}
+
+static struct phy_ops ops = {
+	.init		= dm816x_usb_phy_init,
+	.power_on	= dm816x_usb_phy_power_on,
+	.power_off	= dm816x_usb_phy_power_off,
+	.owner		= THIS_MODULE,
+};
+
+static int dm816x_usb_phy_runtime_suspend(struct device *dev)
+{
+	struct dm816x_usb_phy *phy = dev_get_drvdata(dev);
+	unsigned int mask, val;
+	int error = 0;
+
+	mask = BIT(phy->instance);
+	val = ~BIT(phy->instance);
+	error = regmap_update_bits(phy->syscon, phy->usb_ctrl,
+				   mask, val);
+	if (error)
+		dev_err(phy->dev, "phy%i failed to power off\n",
+			phy->instance);
+	clk_disable(phy->refclk);
+
+	return 0;
+}
+
+static int dm816x_usb_phy_runtime_resume(struct device *dev)
+{
+	struct dm816x_usb_phy *phy = dev_get_drvdata(dev);
+	unsigned int mask, val;
+	int error;
+
+	error = clk_enable(phy->refclk);
+	if (error)
+		return error;
+
+	/*
+	 * Note that at least dm816x rev c does not seem to do
+	 * anything with the USB_CTRL register. But let's follow
+	 * what the TI tree is doing in case later revisions use
+	 * USB_CTRL.
+	 */
+	mask = BIT(phy->instance);
+	val = BIT(phy->instance);
+	error = regmap_update_bits(phy->syscon, phy->usb_ctrl,
+				   mask, val);
+	if (error) {
+		dev_err(phy->dev, "phy%i failed to power on\n",
+			phy->instance);
+		clk_disable(phy->refclk);
+		return error;
+	}
+
+	return 0;
+}
+
+static UNIVERSAL_DEV_PM_OPS(dm816x_usb_phy_pm_ops,
+			    dm816x_usb_phy_runtime_suspend,
+			    dm816x_usb_phy_runtime_resume,
+			    NULL);
+
+#ifdef CONFIG_OF
+static const struct of_device_id dm816x_usb_phy_id_table[] = {
+	{
+		.compatible = "ti,dm8168-usb-phy",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, dm816x_usb_phy_id_table);
+#endif
+
+static int dm816x_usb_phy_probe(struct platform_device *pdev)
+{
+	struct dm816x_usb_phy *phy;
+	struct resource *res;
+	struct phy *generic_phy;
+	struct phy_provider *phy_provider;
+	struct usb_otg *otg;
+	const struct of_device_id *of_id;
+	const struct usb_phy_data *phy_data;
+	int error;
+
+	of_id = of_match_device(of_match_ptr(dm816x_usb_phy_id_table),
+				&pdev->dev);
+	if (!of_id)
+		return -EINVAL;
+
+	phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENOENT;
+
+	phy->syscon = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+						      "syscon");
+	if (IS_ERR(phy->syscon))
+		return PTR_ERR(phy->syscon);
+
+	/*
+	 * According to sprs614e.pdf, the first usb_ctrl is shared and
+	 * the second instance for usb_ctrl is reserved.. Also the
+	 * register bits are different from earlier TRMs.
+	 */
+	phy->usb_ctrl = 0x20;
+	phy->usbphy_ctrl = (res->start & 0xff) + 4;
+	if (phy->usbphy_ctrl == 0x2c)
+		phy->instance = 1;
+
+	phy_data = of_id->data;
+
+	otg = devm_kzalloc(&pdev->dev, sizeof(*otg), GFP_KERNEL);
+	if (!otg)
+		return -ENOMEM;
+
+	phy->dev = &pdev->dev;
+	phy->phy.dev = phy->dev;
+	phy->phy.label = "dm8168_usb_phy";
+	phy->phy.otg = otg;
+	phy->phy.type = USB_PHY_TYPE_USB2;
+	otg->set_host = dm816x_usb_phy_set_host;
+	otg->set_peripheral = dm816x_usb_phy_set_peripheral;
+	otg->usb_phy = &phy->phy;
+
+	platform_set_drvdata(pdev, phy);
+
+	phy->refclk = devm_clk_get(phy->dev, "refclk");
+	if (IS_ERR(phy->refclk))
+		return PTR_ERR(phy->refclk);
+	error = clk_prepare(phy->refclk);
+	if (error)
+		return error;
+
+	pm_runtime_enable(phy->dev);
+	generic_phy = devm_phy_create(phy->dev, NULL, &ops);
+	if (IS_ERR(generic_phy))
+		return PTR_ERR(generic_phy);
+
+	phy_set_drvdata(generic_phy, phy);
+
+	phy_provider = devm_of_phy_provider_register(phy->dev,
+						     of_phy_simple_xlate);
+	if (IS_ERR(phy_provider))
+		return PTR_ERR(phy_provider);
+
+	usb_add_phy_dev(&phy->phy);
+
+	return 0;
+}
+
+static int dm816x_usb_phy_remove(struct platform_device *pdev)
+{
+	struct dm816x_usb_phy *phy = platform_get_drvdata(pdev);
+
+	usb_remove_phy(&phy->phy);
+	pm_runtime_disable(phy->dev);
+	clk_unprepare(phy->refclk);
+
+	return 0;
+}
+
+static struct platform_driver dm816x_usb_phy_driver = {
+	.probe		= dm816x_usb_phy_probe,
+	.remove		= dm816x_usb_phy_remove,
+	.driver		= {
+		.name	= "dm816x-usb-phy",
+		.pm	= &dm816x_usb_phy_pm_ops,
+		.of_match_table = of_match_ptr(dm816x_usb_phy_id_table),
+	},
+};
+
+module_platform_driver(dm816x_usb_phy_driver);
+
+MODULE_ALIAS("platform: dm816x_usb");
+MODULE_AUTHOR("Tony Lindgren <tony@atomide.com>");
+MODULE_DESCRIPTION("dm816x usb phy driver");
+MODULE_LICENSE("GPL v2");
-- 
2.1.4

