From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: [PATCH v4 3/4] USB: OMAP1: OTG controller driver
Date: Fri,  6 Dec 2013 16:13:06 +0200
Message-ID: <1386339187-28466-4-git-send-email-aaro.koskinen@iki.fi>
References: <1386339187-28466-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1386339187-28466-1-git-send-email-aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Transceivers need to manage OTG controller state on OMAP1 to enable
switching between peripheral and host modes. Provide a driver for that.

Signed-off-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
---
 drivers/usb/phy/Kconfig        |  10 +++
 drivers/usb/phy/Makefile       |   1 +
 drivers/usb/phy/phy-omap-otg.c | 169 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 180 insertions(+)
 create mode 100644 drivers/usb/phy/phy-omap-otg.c

diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index d5589f9c60a9..95d0acc117cc 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -154,6 +154,16 @@ config USB_GPIO_VBUS
 	  optionally control of a D+ pullup GPIO as well as a VBUS
 	  current limit regulator.
 
+config OMAP_OTG
+	tristate "OMAP USB OTG controller driver"
+	depends on ARCH_OMAP_OTG && EXTCON
+	help
+	  Enable this to support some transceivers on OMAP1 platforms. OTG
+	  controller is needed to switch between host and peripheral modes.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called omap-otg.
+
 config USB_ISP1301
 	tristate "NXP ISP1301 USB transceiver support"
 	depends on USB || USB_GADGET
diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
index 2135e85f46ed..ca5bcad49da2 100644
--- a/drivers/usb/phy/Makefile
+++ b/drivers/usb/phy/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_NOP_USB_XCEIV)		+= phy-generic.o
 obj-$(CONFIG_OMAP_CONTROL_USB)		+= phy-omap-control.o
 obj-$(CONFIG_AM335X_CONTROL_USB)	+= phy-am335x-control.o
 obj-$(CONFIG_AM335X_PHY_USB)		+= phy-am335x.o
+obj-$(CONFIG_OMAP_OTG)			+= phy-omap-otg.o
 obj-$(CONFIG_OMAP_USB2)			+= phy-omap-usb2.o
 obj-$(CONFIG_OMAP_USB3)			+= phy-omap-usb3.o
 obj-$(CONFIG_SAMSUNG_USBPHY)		+= phy-samsung-usb.o
diff --git a/drivers/usb/phy/phy-omap-otg.c b/drivers/usb/phy/phy-omap-otg.c
new file mode 100644
index 000000000000..11598cdb3189
--- /dev/null
+++ b/drivers/usb/phy/phy-omap-otg.c
@@ -0,0 +1,169 @@
+/*
+ * OMAP OTG controller driver
+ *
+ * Based on code from tahvo-usb.c and isp1301_omap.c drivers.
+ *
+ * Copyright (C) 2005-2006 Nokia Corporation
+ * Copyright (C) 2004 Texas Instruments
+ * Copyright (C) 2004 David Brownell
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License. See the file "COPYING" in the main directory of this
+ * archive for more details.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/extcon.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/usb-omap1.h>
+
+struct otg_device {
+	void __iomem			*base;
+	bool				id;
+	bool				vbus;
+	struct extcon_specific_cable_nb	vbus_dev;
+	struct extcon_specific_cable_nb	id_dev;
+	struct notifier_block		vbus_nb;
+	struct notifier_block		id_nb;
+};
+
+#define OMAP_OTG_CTRL		0x0c
+#define OMAP_OTG_ASESSVLD	(1 << 20)
+#define OMAP_OTG_BSESSEND	(1 << 19)
+#define OMAP_OTG_BSESSVLD	(1 << 18)
+#define OMAP_OTG_VBUSVLD	(1 << 17)
+#define OMAP_OTG_ID		(1 << 16)
+#define OMAP_OTG_XCEIV_OUTPUTS \
+	(OMAP_OTG_ASESSVLD | OMAP_OTG_BSESSEND | OMAP_OTG_BSESSVLD | \
+	 OMAP_OTG_VBUSVLD  | OMAP_OTG_ID)
+
+static void omap_otg_ctrl(struct otg_device *otg_dev, u32 outputs)
+{
+	u32 l;
+
+	l = readl(otg_dev->base + OMAP_OTG_CTRL);
+	l &= ~OMAP_OTG_XCEIV_OUTPUTS;
+	l |= outputs;
+	writel(l, otg_dev->base + OMAP_OTG_CTRL);
+}
+
+static void omap_otg_set_mode(struct otg_device *otg_dev)
+{
+	if (!otg_dev->id && otg_dev->vbus)
+		/* Set B-session valid. */
+		omap_otg_ctrl(otg_dev, OMAP_OTG_ID | OMAP_OTG_BSESSVLD);
+	else if (otg_dev->vbus)
+		/* Set A-session valid. */
+		omap_otg_ctrl(otg_dev, OMAP_OTG_ASESSVLD);
+	else if (!otg_dev->id)
+		/* Set B-session end to indicate no VBUS. */
+		omap_otg_ctrl(otg_dev, OMAP_OTG_ID | OMAP_OTG_BSESSEND);
+}
+
+static int omap_otg_id_notifier(struct notifier_block *nb,
+				unsigned long event, void *ptr)
+{
+	struct otg_device *otg_dev = container_of(nb, struct otg_device, id_nb);
+
+	otg_dev->id = event;
+	omap_otg_set_mode(otg_dev);
+
+	return NOTIFY_DONE;
+}
+
+static int omap_otg_vbus_notifier(struct notifier_block *nb,
+				  unsigned long event, void *ptr)
+{
+	struct otg_device *otg_dev = container_of(nb, struct otg_device,
+						  vbus_nb);
+
+	otg_dev->vbus = event;
+	omap_otg_set_mode(otg_dev);
+
+	return NOTIFY_DONE;
+}
+
+static int omap_otg_probe(struct platform_device *pdev)
+{
+	const struct omap_usb_config *config = pdev->dev.platform_data;
+	struct otg_device *otg_dev;
+	struct extcon_dev *extcon;
+	int ret;
+	u32 rev;
+
+	if (!config || !config->extcon)
+		return -ENODEV;
+
+	extcon = extcon_get_extcon_dev(config->extcon);
+	if (!extcon)
+		return -EPROBE_DEFER;
+
+	otg_dev = devm_kzalloc(&pdev->dev, sizeof(*otg_dev), GFP_KERNEL);
+	if (!otg_dev)
+		return -ENOMEM;
+
+	otg_dev->base = devm_ioremap_resource(&pdev->dev, &pdev->resource[0]);
+	if (IS_ERR(otg_dev->base))
+		return PTR_ERR(otg_dev->base);
+
+	otg_dev->id_nb.notifier_call = omap_otg_id_notifier;
+	otg_dev->vbus_nb.notifier_call = omap_otg_vbus_notifier;
+
+	ret = extcon_register_interest(&otg_dev->id_dev, config->extcon,
+				       "USB-HOST", &otg_dev->id_nb);
+	if (ret)
+		return ret;
+
+	ret = extcon_register_interest(&otg_dev->vbus_dev, config->extcon,
+				       "USB", &otg_dev->vbus_nb);
+	if (ret) {
+		extcon_unregister_interest(&otg_dev->id_dev);
+		return ret;
+	}
+
+	otg_dev->id = extcon_get_cable_state(extcon, "USB-HOST");
+	otg_dev->vbus = extcon_get_cable_state(extcon, "USB");
+	omap_otg_set_mode(otg_dev);
+
+	rev = readl(otg_dev->base);
+
+	dev_info(&pdev->dev,
+		 "OMAP USB OTG controller rev %d.%d (%s, id=%d, vbus=%d)\n",
+		 (rev >> 4) & 0xf, rev & 0xf, config->extcon, otg_dev->id,
+		 otg_dev->vbus);
+
+	return 0;
+}
+
+static int omap_otg_remove(struct platform_device *pdev)
+{
+	struct otg_device *otg_dev = platform_get_drvdata(pdev);
+
+	extcon_unregister_interest(&otg_dev->id_dev);
+	extcon_unregister_interest(&otg_dev->vbus_dev);
+
+	return 0;
+}
+
+static struct platform_driver omap_otg_driver = {
+	.probe		= omap_otg_probe,
+	.remove		= omap_otg_remove,
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= "omap_otg",
+	},
+};
+module_platform_driver(omap_otg_driver);
+
+MODULE_DESCRIPTION("OMAP USB OTG controller driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>");
-- 
1.8.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
