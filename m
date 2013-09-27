From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v12 3/7] usb: phy: twl4030: use the new generic PHY framework
Date: Fri, 27 Sep 2013 11:53:27 +0530
Message-ID: <1380263012-9687-4-git-send-email-kishon@ti.com>
References: <1380263012-9687-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380263012-9687-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cesarb-PWySMVKUnqmsTnJN9+BGXg@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Used the generic PHY framework API to create the PHY. For powering on
and powering off the PHY, power_on and power_off ops are used. Once the
MUSB OMAP glue is adapted to the new framework, the suspend and resume
ops of usb phy library will be removed. Also twl4030-usb driver is moved
to drivers/phy/.

However using the old usb phy library cannot be completely removed
because otg is intertwined with phy and moving to the new
framework completely will break otg. Once we have a separate otg state machine,
we can get rid of the usb phy library.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Reviewed-by: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/phy/Kconfig                     |   11 ++++++
 drivers/phy/Makefile                    |    1 +
 drivers/{usb => }/phy/phy-twl4030-usb.c |   56 +++++++++++++++++++++++++++++--
 drivers/usb/phy/Kconfig                 |   10 ------
 drivers/usb/phy/Makefile                |    1 -
 include/linux/i2c/twl.h                 |    2 ++
 6 files changed, 67 insertions(+), 14 deletions(-)
 rename drivers/{usb => }/phy/phy-twl4030-usb.c (95%)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 38c3477..ac239ac 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -27,4 +27,15 @@ config OMAP_USB2
 	  The USB OTG controller communicates with the comparator using this
 	  driver.
 
+config TWL4030_USB
+	tristate "TWL4030 USB Transceiver Driver"
+	depends on TWL4030_CORE && REGULATOR_TWL4030 && USB_MUSB_OMAP2PLUS
+	select GENERIC_PHY
+	select USB_PHY
+	help
+	  Enable this to support the USB OTG transceiver on TWL4030
+	  family chips (including the TWL5030 and TPS659x0 devices).
+	  This transceiver supports high and full speed devices plus,
+	  in host mode, low speed.
+
 endmenu
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index ed5b088..0dd8a98 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -4,3 +4,4 @@
 
 obj-$(CONFIG_GENERIC_PHY)	+= phy-core.o
 obj-$(CONFIG_OMAP_USB2)		+= phy-omap-usb2.o
+obj-$(CONFIG_TWL4030_USB)	+= phy-twl4030-usb.o
diff --git a/drivers/usb/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-usb.c
similarity index 95%
rename from drivers/usb/phy/phy-twl4030-usb.c
rename to drivers/phy/phy-twl4030-usb.c
index 90730c8..d02913f 100644
--- a/drivers/usb/phy/phy-twl4030-usb.c
+++ b/drivers/phy/phy-twl4030-usb.c
@@ -33,6 +33,7 @@
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/usb/otg.h>
+#include <linux/phy/phy.h>
 #include <linux/usb/musb-omap.h>
 #include <linux/usb/ulpi.h>
 #include <linux/i2c/twl.h>
@@ -431,6 +432,14 @@ static void twl4030_phy_suspend(struct twl4030_usb *twl, int controller_off)
 	dev_dbg(twl->dev, "%s\n", __func__);
 }
 
+static int twl4030_phy_power_off(struct phy *phy)
+{
+	struct twl4030_usb *twl = phy_get_drvdata(phy);
+
+	twl4030_phy_suspend(twl, 0);
+	return 0;
+}
+
 static void __twl4030_phy_resume(struct twl4030_usb *twl)
 {
 	twl4030_phy_power(twl, 1);
@@ -459,6 +468,14 @@ static void twl4030_phy_resume(struct twl4030_usb *twl)
 	}
 }
 
+static int twl4030_phy_power_on(struct phy *phy)
+{
+	struct twl4030_usb *twl = phy_get_drvdata(phy);
+
+	twl4030_phy_resume(twl);
+	return 0;
+}
+
 static int twl4030_usb_ldo_init(struct twl4030_usb *twl)
 {
 	/* Enable writing to power configuration registers */
@@ -602,13 +619,22 @@ static int twl4030_usb_phy_init(struct usb_phy *phy)
 	status = twl4030_usb_linkstat(twl);
 	twl->linkstat = status;
 
-	if (status == OMAP_MUSB_ID_GROUND || status == OMAP_MUSB_VBUS_VALID)
+	if (status == OMAP_MUSB_ID_GROUND || status == OMAP_MUSB_VBUS_VALID) {
 		omap_musb_mailbox(twl->linkstat);
+		twl4030_phy_resume(twl);
+	}
 
 	sysfs_notify(&twl->dev->kobj, NULL, "vbus");
 	return 0;
 }
 
+static int twl4030_phy_init(struct phy *phy)
+{
+	struct twl4030_usb *twl = phy_get_drvdata(phy);
+
+	return twl4030_usb_phy_init(&twl->phy);
+}
+
 static int twl4030_set_suspend(struct usb_phy *x, int suspend)
 {
 	struct twl4030_usb *twl = phy_to_twl(x);
@@ -646,13 +672,23 @@ static int twl4030_set_host(struct usb_otg *otg, struct usb_bus *host)
 	return 0;
 }
 
+static const struct phy_ops ops = {
+	.init		= twl4030_phy_init,
+	.power_on	= twl4030_phy_power_on,
+	.power_off	= twl4030_phy_power_off,
+	.owner		= THIS_MODULE,
+};
+
 static int twl4030_usb_probe(struct platform_device *pdev)
 {
 	struct twl4030_usb_data *pdata = dev_get_platdata(&pdev->dev);
 	struct twl4030_usb	*twl;
+	struct phy		*phy;
 	int			status, err;
 	struct usb_otg		*otg;
 	struct device_node	*np = pdev->dev.of_node;
+	struct phy_provider	*phy_provider;
+	struct phy_init_data	*init_data = NULL;
 
 	twl = devm_kzalloc(&pdev->dev, sizeof *twl, GFP_KERNEL);
 	if (!twl)
@@ -661,9 +697,10 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 	if (np)
 		of_property_read_u32(np, "usb_mode",
 				(enum twl4030_usb_mode *)&twl->usb_mode);
-	else if (pdata)
+	else if (pdata) {
 		twl->usb_mode = pdata->usb_mode;
-	else {
+		init_data = pdata->init_data;
+	} else {
 		dev_err(&pdev->dev, "twl4030 initialized without pdata\n");
 		return -EINVAL;
 	}
@@ -689,6 +726,19 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 	otg->set_host		= twl4030_set_host;
 	otg->set_peripheral	= twl4030_set_peripheral;
 
+	phy_provider = devm_of_phy_provider_register(twl->dev,
+		of_phy_simple_xlate);
+	if (IS_ERR(phy_provider))
+		return PTR_ERR(phy_provider);
+
+	phy = devm_phy_create(twl->dev, &ops, init_data);
+	if (IS_ERR(phy)) {
+		dev_dbg(&pdev->dev, "Failed to create PHY\n");
+		return PTR_ERR(phy);
+	}
+
+	phy_set_drvdata(phy, twl);
+
 	/* init spinlock for workqueue */
 	spin_lock_init(&twl->lock);
 
diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 508e915..d69cdad 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -112,16 +112,6 @@ config SAMSUNG_USB3PHY
 	  Enable this to support Samsung USB 3.0 (Super Speed) phy controller
 	  for samsung SoCs.
 
-config TWL4030_USB
-	tristate "TWL4030 USB Transceiver Driver"
-	depends on TWL4030_CORE && REGULATOR_TWL4030 && USB_MUSB_OMAP2PLUS
-	select USB_PHY
-	help
-	  Enable this to support the USB OTG transceiver on TWL4030
-	  family chips (including the TWL5030 and TPS659x0 devices).
-	  This transceiver supports high and full speed devices plus,
-	  in host mode, low speed.
-
 config TWL6030_USB
 	tristate "TWL6030 USB Transceiver Driver"
 	depends on TWL4030_CORE && OMAP_USB2 && USB_MUSB_OMAP2PLUS
diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
index fa4db0e..9c37361 100644
--- a/drivers/usb/phy/Makefile
+++ b/drivers/usb/phy/Makefile
@@ -19,7 +19,6 @@ obj-$(CONFIG_OMAP_USB3)			+= phy-omap-usb3.o
 obj-$(CONFIG_SAMSUNG_USBPHY)		+= phy-samsung-usb.o
 obj-$(CONFIG_SAMSUNG_USB2PHY)		+= phy-samsung-usb2.o
 obj-$(CONFIG_SAMSUNG_USB3PHY)		+= phy-samsung-usb3.o
-obj-$(CONFIG_TWL4030_USB)		+= phy-twl4030-usb.o
 obj-$(CONFIG_TWL6030_USB)		+= phy-twl6030-usb.o
 obj-$(CONFIG_USB_EHCI_TEGRA)		+= phy-tegra-usb.o
 obj-$(CONFIG_USB_GPIO_VBUS)		+= phy-gpio-vbus-usb.o
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 81cbbdb..673a3ce 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -26,6 +26,7 @@
 #define __TWL_H_
 
 #include <linux/types.h>
+#include <linux/phy/phy.h>
 #include <linux/input/matrix_keypad.h>
 
 /*
@@ -615,6 +616,7 @@ enum twl4030_usb_mode {
 struct twl4030_usb_data {
 	enum twl4030_usb_mode	usb_mode;
 	unsigned long		features;
+	struct phy_init_data	*init_data;
 
 	int		(*phy_init)(struct device *dev);
 	int		(*phy_exit)(struct device *dev);
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
