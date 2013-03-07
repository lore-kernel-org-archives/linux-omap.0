From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: [RFC PATCH 3/4] USB: OMAP: move omap-otg out from isp1301_omap
Date: Thu,  7 Mar 2013 16:40:20 +0200
Message-ID: <1362667221-30659-4-git-send-email-aaro.koskinen@iki.fi>
References: <1362667221-30659-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1362667221-30659-1-git-send-email-aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

omap-otg platform device will be needed also by other transceivers.
It's not possible to have multiple instances of the driver, so it needs
to be moved into a separate file so that other drivers can hook into it.

Start this change with a very simplest implementation, much of the
OMAP OTG code in isp1301 is tightly coupled with isp1301 and cannot be
trivially moved out, but still this provides a way for other drivers to
register to OTG interrupt.

Signed-off-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
---
 drivers/usb/otg/Kconfig        |    5 ++
 drivers/usb/otg/Makefile       |    1 +
 drivers/usb/otg/isp1301_omap.c |   78 ++-----------------------------
 drivers/usb/otg/omap-otg.c     |   99 ++++++++++++++++++++++++++++++++++++++++
 include/linux/usb/omap-otg.h   |   30 ++++++++++++
 5 files changed, 138 insertions(+), 75 deletions(-)
 create mode 100644 drivers/usb/otg/omap-otg.c
 create mode 100644 include/linux/usb/omap-otg.h

diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
index 37962c9..12af870 100644
--- a/drivers/usb/otg/Kconfig
+++ b/drivers/usb/otg/Kconfig
@@ -27,9 +27,14 @@ config USB_GPIO_VBUS
 	  optionally control of a D+ pullup GPIO as well as a VBUS
 	  current limit regulator.
 
+config OMAP_OTG
+	tristate
+	depends on ARCH_OMAP_OTG
+
 config ISP1301_OMAP
 	tristate "Philips ISP1301 with OMAP OTG"
 	depends on I2C && ARCH_OMAP_OTG
+	select OMAP_OTG if USB_OTG
 	select USB_OTG_UTILS
 	help
 	  If you say yes here you get support for the Philips ISP1301
diff --git a/drivers/usb/otg/Makefile b/drivers/usb/otg/Makefile
index a844b8d..4e05c6a 100644
--- a/drivers/usb/otg/Makefile
+++ b/drivers/usb/otg/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_USB_OTG_UTILS)	+= otg.o
 
 # transceiver drivers
 obj-$(CONFIG_USB_GPIO_VBUS)	+= gpio_vbus.o
+obj-$(CONFIG_OMAP_OTG)		+= omap-otg.o
 obj-$(CONFIG_ISP1301_OMAP)	+= isp1301_omap.o
 obj-$(CONFIG_TWL4030_USB)	+= twl4030-usb.o
 obj-$(CONFIG_TWL6030_USB)	+= twl6030-usb.o
diff --git a/drivers/usb/otg/isp1301_omap.c b/drivers/usb/otg/isp1301_omap.c
index af9cb11..5217b7e 100644
--- a/drivers/usb/otg/isp1301_omap.c
+++ b/drivers/usb/otg/isp1301_omap.c
@@ -28,6 +28,7 @@
 #include <linux/gpio.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
+#include <linux/usb/omap-otg.h>
 #include <linux/usb.h>
 #include <linux/usb/otg.h>
 #include <linux/i2c.h>
@@ -74,22 +75,6 @@ struct isp1301 {
 #		define WORK_STOP	7	/* don't resubmit */
 };
 
-
-/* bits in OTG_CTRL */
-
-#define	OTG_XCEIV_OUTPUTS \
-	(OTG_ASESSVLD|OTG_BSESSEND|OTG_BSESSVLD|OTG_VBUSVLD|OTG_ID)
-#define	OTG_XCEIV_INPUTS \
-	(OTG_PULLDOWN|OTG_PULLUP|OTG_DRV_VBUS|OTG_PD_VBUS|OTG_PU_VBUS|OTG_PU_ID)
-#define	OTG_CTRL_BITS \
-	(OTG_A_BUSREQ|OTG_A_SETB_HNPEN|OTG_B_BUSREQ|OTG_B_HNPEN|OTG_BUSDROP)
-	/* and OTG_PULLUP is sometimes written */
-
-#define	OTG_CTRL_MASK	(OTG_DRIVER_SEL| \
-	OTG_XCEIV_OUTPUTS|OTG_XCEIV_INPUTS| \
-	OTG_CTRL_BITS)
-
-
 /*-------------------------------------------------------------------------*/
 
 /* board-specific PM hooks */
@@ -822,15 +807,10 @@ static irqreturn_t omap_otg_irq(int irq, void *_isp)
 	return ret;
 }
 
-static struct platform_device *otg_dev;
-
 static int isp1301_otg_init(struct isp1301 *isp)
 {
 	u32 l;
 
-	if (!otg_dev)
-		return -ENODEV;
-
 	dump_regs(isp, __func__);
 	/* some of these values are board-specific... */
 	l = omap_readl(OTG_SYSCON_2);
@@ -864,58 +844,6 @@ static int isp1301_otg_init(struct isp1301 *isp)
 	return 0;
 }
 
-static int otg_probe(struct platform_device *dev)
-{
-	// struct omap_usb_config *config = dev->platform_data;
-
-	otg_dev = dev;
-	return 0;
-}
-
-static int otg_remove(struct platform_device *dev)
-{
-	otg_dev = NULL;
-	return 0;
-}
-
-static struct platform_driver omap_otg_driver = {
-	.probe		= otg_probe,
-	.remove		= otg_remove,
-	.driver		= {
-		.owner	= THIS_MODULE,
-		.name	= "omap_otg",
-	},
-};
-
-static int otg_bind(struct isp1301 *isp)
-{
-	int	status;
-
-	if (otg_dev)
-		return -EBUSY;
-
-	status = platform_driver_register(&omap_otg_driver);
-	if (status < 0)
-		return status;
-
-	if (otg_dev)
-		status = request_irq(otg_dev->resource[1].start, omap_otg_irq,
-				0, DRIVER_NAME, isp);
-	else
-		status = -ENODEV;
-
-	if (status < 0)
-		platform_driver_unregister(&omap_otg_driver);
-	return status;
-}
-
-static void otg_unbind(struct isp1301 *isp)
-{
-	if (!otg_dev)
-		return;
-	free_irq(otg_dev->resource[1].start, isp);
-}
-
 #else
 
 /* OTG controller isn't clocked */
@@ -1222,7 +1150,7 @@ static int __exit isp1301_remove(struct i2c_client *i2c)
 	isp1301_clear_bits(isp, ISP1301_INTERRUPT_RISING, ~0);
 	free_irq(i2c->irq, isp);
 #ifdef	CONFIG_USB_OTG
-	otg_unbind(isp);
+	omap_otg_unbind(isp);
 #endif
 	if (machine_is_omap_h2())
 		gpio_free(2);
@@ -1555,7 +1483,7 @@ isp1301_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 	isp1301_clear_bits(isp, ISP1301_INTERRUPT_RISING, ~0);
 
 #ifdef	CONFIG_USB_OTG
-	status = otg_bind(isp);
+	status = omap_otg_bind(isp, omap_otg_irq);
 	if (status < 0) {
 		dev_dbg(&i2c->dev, "can't bind OTG\n");
 		goto fail;
diff --git a/drivers/usb/otg/omap-otg.c b/drivers/usb/otg/omap-otg.c
new file mode 100644
index 0000000..12e8f13
--- /dev/null
+++ b/drivers/usb/otg/omap-otg.c
@@ -0,0 +1,99 @@
+/*
+ * OMAP OTG driver
+ *
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
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/usb/omap-otg.h>
+#include <linux/platform_device.h>
+
+static void *omap_otg_user;
+static DEFINE_MUTEX(omap_otg_lock);
+static struct platform_device *omap_otg_dev;
+
+static int omap_otg_probe(struct platform_device *dev)
+{
+	int ret;
+
+	mutex_lock(&omap_otg_lock);
+	if (omap_otg_dev) {
+		ret = -EBUSY;
+	} else {
+		omap_otg_dev = dev;
+		ret = 0;
+	}
+	mutex_unlock(&omap_otg_lock);
+
+	return ret;
+}
+
+static int omap_otg_remove(struct platform_device *dev)
+{
+	int ret;
+
+	mutex_lock(&omap_otg_lock);
+	if (omap_otg_user) {
+		ret = -EBUSY;
+	} else {
+		omap_otg_dev = NULL;
+		ret = 0;
+	}
+	mutex_unlock(&omap_otg_lock);
+
+	return ret;
+}
+
+int omap_otg_bind(void *transceiver, irq_handler_t irq_handler)
+{
+	int ret;
+
+	mutex_lock(&omap_otg_lock);
+	if (!omap_otg_dev) {
+		ret = -EPROBE_DEFER;
+	} else if (omap_otg_user) {
+		ret = -EBUSY;
+	} else {
+		ret = request_irq(omap_otg_dev->resource[1].start, irq_handler,
+				  0, "OMAP OTG", transceiver);
+		if (!ret)
+			omap_otg_user = transceiver;
+	}
+	mutex_unlock(&omap_otg_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(omap_otg_bind);
+
+void omap_otg_unbind(void *transceiver)
+{
+	mutex_lock(&omap_otg_lock);
+	BUG_ON(!omap_otg_dev || !omap_otg_user || omap_otg_user != transceiver);
+	free_irq(omap_otg_dev->resource[1].start, transceiver);
+	omap_otg_user = NULL;
+	mutex_unlock(&omap_otg_lock);
+}
+EXPORT_SYMBOL_GPL(omap_otg_unbind);
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
diff --git a/include/linux/usb/omap-otg.h b/include/linux/usb/omap-otg.h
new file mode 100644
index 0000000..efc1cb3
--- /dev/null
+++ b/include/linux/usb/omap-otg.h
@@ -0,0 +1,30 @@
+/*
+ * OMAP OTG driver
+ *
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
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/* bits in OTG_CTRL */
+#define OTG_XCEIV_OUTPUTS \
+	(OTG_ASESSVLD|OTG_BSESSEND|OTG_BSESSVLD|OTG_VBUSVLD|OTG_ID)
+#define OTG_XCEIV_INPUTS \
+	(OTG_PULLDOWN|OTG_PULLUP|OTG_DRV_VBUS|OTG_PD_VBUS|OTG_PU_VBUS|OTG_PU_ID)
+#define OTG_CTRL_BITS \
+	(OTG_A_BUSREQ|OTG_A_SETB_HNPEN|OTG_B_BUSREQ|OTG_B_HNPEN|OTG_BUSDROP)
+	/* and OTG_PULLUP is sometimes written */
+#define OTG_CTRL_MASK \
+	(OTG_DRIVER_SEL|OTG_XCEIV_OUTPUTS|OTG_XCEIV_INPUTS|OTG_CTRL_BITS)
+
+int omap_otg_bind(void *, irq_handler_t);
+void omap_otg_unbind(void *);
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
