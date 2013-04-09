From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: [RFC PATCH v2 3/4] USB: OMAP: add omap-otg
Date: Tue,  9 Apr 2013 22:51:27 +0300
Message-ID: <1365537088-23199-4-git-send-email-aaro.koskinen@iki.fi>
References: <1365537088-23199-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1365537088-23199-1-git-send-email-aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Transceivers need to manage OTG controller state on OMAP1 to enable
switching between peripheral and host modes. Provide a driver for that.

Signed-off-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
---
 drivers/usb/phy/Kconfig        |   10 ++++
 drivers/usb/phy/Makefile       |    1 +
 drivers/usb/phy/phy-omap-otg.c |  126 ++++++++++++++++++++++++++++++++++++++++
 include/linux/usb/omap-otg.h   |   19 ++++++
 4 files changed, 156 insertions(+)
 create mode 100644 drivers/usb/phy/phy-omap-otg.c
 create mode 100644 include/linux/usb/omap-otg.h

diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 372db48..8c051c2 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -135,6 +135,16 @@ config USB_GPIO_VBUS
 	  optionally control of a D+ pullup GPIO as well as a VBUS
 	  current limit regulator.
 
+config OMAP_OTG
+	tristate "OMAP USB OTG controller driver"
+	depends on ARCH_OMAP_OTG
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
index 33863c0..7e67e96 100644
--- a/drivers/usb/phy/Makefile
+++ b/drivers/usb/phy/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_ISP1301_OMAP)		+= phy-isp1301.omap.o
 obj-$(CONFIG_MV_U3D_PHY)		+= phy-mv-u3d-usb.o
 obj-$(CONFIG_NOP_USB_XCEIV)		+= phy-nop.o
 obj-$(CONFIG_OMAP_CONTROL_USB)		+= phy-omap-control.o
+obj-$(CONFIG_OMAP_OTG)			+= phy-omap-otg.o
 obj-$(CONFIG_OMAP_USB2)			+= phy-omap-usb2.o
 obj-$(CONFIG_OMAP_USB3)			+= phy-omap-usb3.o
 obj-$(CONFIG_SAMSUNG_USBPHY)		+= phy-samsung-usb.o
diff --git a/drivers/usb/phy/phy-omap-otg.c b/drivers/usb/phy/phy-omap-otg.c
new file mode 100644
index 0000000..cb00ffe
--- /dev/null
+++ b/drivers/usb/phy/phy-omap-otg.c
@@ -0,0 +1,126 @@
+/*
+ * OMAP OTG controller driver
+ *
+ * Based on code from tahvo-usb.c and isp1301_omap.c drivers.
+ *
+ * Copyright (C) 2005-2006 Nokia Corporation
+ * Copyright (C) 2004 Texas Instruments
+ * Copyright (C) 2004 David Brownell
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/usb/omap-otg.h>
+#include <linux/platform_device.h>
+
+struct otg_device {
+	void __iomem	*base;
+	struct mutex	serialize;
+};
+static struct otg_device *otg_dev;
+
+#define OMAP_OTG_CTRL		(otg_dev->base + 0x0c)
+#define OMAP_OTG_ASESSVLD	(1 << 20)
+#define OMAP_OTG_BSESSEND	(1 << 19)
+#define OMAP_OTG_BSESSVLD	(1 << 18)
+#define OMAP_OTG_VBUSVLD	(1 << 17)
+#define OMAP_OTG_ID		(1 << 16)
+#define OMAP_OTG_XCEIV_OUTPUTS \
+	(OMAP_OTG_ASESSVLD | OMAP_OTG_BSESSEND | OMAP_OTG_BSESSVLD | \
+	 OMAP_OTG_VBUSVLD  | OMAP_OTG_ID)
+
+static void omap_otg_ctrl(u32 outputs)
+{
+	u32 l;
+
+	l = readl(OMAP_OTG_CTRL);
+	l &= ~OMAP_OTG_XCEIV_OUTPUTS;
+	l |= outputs;
+	writel(l, OMAP_OTG_CTRL);
+}
+
+void omap_otg_set_mode(enum omap_otg_mode mode)
+{
+	if (!otg_dev) {
+		WARN(1, "%s: controller not present\n", __func__);
+		return;
+	}
+	mutex_lock(&otg_dev->serialize);
+	switch (mode) {
+	case OMAP_OTG_MODE_DEVICE:
+		/*
+		 * Set B-session valid.
+		 */
+		omap_otg_ctrl(OMAP_OTG_ID | OMAP_OTG_BSESSVLD);
+		break;
+	case OMAP_OTG_MODE_HOST:
+		/*
+		 * Set A-session valid.
+		 */
+		omap_otg_ctrl(OMAP_OTG_ASESSVLD);
+		break;
+	case OMAP_OTG_MODE_DISCONNECT:
+		/*
+		 * Set B-session end to indicate no VBUS.
+		 */
+		omap_otg_ctrl(OMAP_OTG_ID | OMAP_OTG_BSESSEND);
+		break;
+	default:
+		WARN(1, "%s: unknown mode: %d\n", __func__, mode);
+	}
+	mutex_unlock(&otg_dev->serialize);
+}
+EXPORT_SYMBOL_GPL(omap_otg_set_mode);
+
+static int omap_otg_probe(struct platform_device *dev)
+{
+	struct otg_device *odev;
+	u32 rev;
+
+	if (otg_dev)
+		return -EBUSY;
+
+	odev = devm_kzalloc(&dev->dev, sizeof(*odev), GFP_KERNEL);
+	if (!odev)
+		return -ENOMEM;
+
+	odev->base = devm_ioremap_resource(&dev->dev, &dev->resource[0]);
+	if (IS_ERR(odev->base))
+		return PTR_ERR(odev->base);
+
+	rev = readl(odev->base);
+	dev_info(&dev->dev, "OMAP USB OTG controller rev %d.%d\n",
+		 (rev >> 4) & 0xf, rev & 0xf);
+
+	mutex_init(&odev->serialize);
+
+	otg_dev = odev;
+
+	return 0;
+}
+
+static struct platform_driver omap_otg_driver = {
+	.probe		= omap_otg_probe,
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
diff --git a/include/linux/usb/omap-otg.h b/include/linux/usb/omap-otg.h
new file mode 100644
index 0000000..fb3d7ab
--- /dev/null
+++ b/include/linux/usb/omap-otg.h
@@ -0,0 +1,19 @@
+/*
+ * OMAP OTG driver
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive for
+ * more details.
+ */
+#ifndef __LINUX_OMAP_OTG_H
+#define __LINUX_OMAP_OTG_H
+
+enum omap_otg_mode {
+	OMAP_OTG_MODE_DEVICE,
+	OMAP_OTG_MODE_HOST,
+	OMAP_OTG_MODE_DISCONNECT,
+};
+
+void omap_otg_set_mode(enum omap_otg_mode mode);
+
+#endif /* __LINUX_OMAP_OTG_H */
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
