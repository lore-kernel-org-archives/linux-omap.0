From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] usb: musb: adding nop usb transceiver
Date: Thu,  8 Jan 2009 16:23:08 +0530
Message-ID: <1231411988-7330-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

NOP transceiver is used by all the usb transceiver which are mostly
autonomous and doesn't require any programming or which are built
into the usb ip itself.NOP transceiver only allocates the memory
for struct xceiv and calls otg_set_transceiver() so function call
to otg_get_transceiver() will return a valid ransceiver.

NOP transceiver device is required to be registered using
platform_device_register() in platform files.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/otg/Kconfig         |    8 ++
 drivers/usb/otg/Makefile        |    1 +
 drivers/usb/otg/nop-usb-xceiv.c |  139 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 148 insertions(+), 0 deletions(-)
 create mode 100644 drivers/usb/otg/nop-usb-xceiv.c

diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
index b1cf38b..7f14d8e 100644
--- a/drivers/usb/otg/Kconfig
+++ b/drivers/usb/otg/Kconfig
@@ -51,4 +51,12 @@ config TWL4030_USB
 	  This is transceiver supports high and full speed devices
 	  plus, in host mode, low speed.
 
+config NOP_USB_XCEIV
+	tristate "NOP USB Transceiver Driver"
+	select USB_OTG_UTILS
+	help
+	 this driver is to be used by all the usb transceiver which are either
+	 built-in with usb ip or which are autonomous and doesn't require any
+	 phy programming such as ISP1x04 etc.
+
 endif # USB || OTG
diff --git a/drivers/usb/otg/Makefile b/drivers/usb/otg/Makefile
index d73c7cf..2081678 100644
--- a/drivers/usb/otg/Makefile
+++ b/drivers/usb/otg/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_USB_OTG_UTILS)	+= otg.o
 obj-$(CONFIG_USB_GPIO_VBUS)	+= gpio_vbus.o
 obj-$(CONFIG_ISP1301_OMAP)	+= isp1301_omap.o
 obj-$(CONFIG_TWL4030_USB)	+= twl4030-usb.o
+obj-$(CONFIG_NOP_USB_XCEIV)	+= nop-usb-xceiv.o
 
 ccflags-$(CONFIG_USB_DEBUG)	+= -DDEBUG
 ccflags-$(CONFIG_USB_GADGET_DEBUG) += -DDEBUG
diff --git a/drivers/usb/otg/nop-usb-xceiv.c b/drivers/usb/otg/nop-usb-xceiv.c
new file mode 100644
index 0000000..2dcf873
--- /dev/null
+++ b/drivers/usb/otg/nop-usb-xceiv.c
@@ -0,0 +1,139 @@
+/*
+ * drivers/usb/otg/nop-usb-xceiv.c
+ *
+ * NOP USB transceiver for all USB transceiver which are either built-in
+ * into USB IP or which are mostly autonomous.
+ *
+ * Copyright (C) 2009 Texas Instruments Inc
+ * Author: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
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
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Current status:
+ * 	this is to add "nop" transceiver for all those phy which is
+ * 	autonomous such as isp1504 etc.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/usb/otg.h>
+
+struct nop_usb_xceiv {
+	struct otg_transceiver	otg;
+	struct device		*dev;
+};
+
+/* internal define on top of container_of */
+#define xceiv_to_nop(x)		container_of((x), struct nop_usb_xceiv, otg);
+
+static int nop_set_suspend(struct otg_transceiver *x, int suspend)
+{
+	return 0;
+}
+
+static int nop_set_peripheral(struct otg_transceiver *x,
+		struct usb_gadget *gadget)
+{
+	struct nop_usb_xceiv *nop;
+
+	if (!x)
+		return -ENODEV;
+
+	nop = xceiv_to_nop(x);
+
+	if (!gadget) {
+		nop->otg.gadget = NULL;
+		return -ENODEV;
+	}
+
+	nop->otg.gadget = gadget;
+	nop->otg.state = OTG_STATE_B_IDLE;
+	return 0;
+}
+
+static int nop_set_host(struct otg_transceiver *x, struct usb_bus *host)
+{
+	struct nop_usb_xceiv *nop;
+
+	if (!x)
+		return -ENODEV;
+
+	nop = xceiv_to_nop(x);
+
+	if (!host) {
+		nop->otg.host = NULL;
+		return -ENODEV;
+	}
+
+	nop->otg.host = host;
+	return 0;
+}
+
+static int __init nop_usb_xceiv_probe(struct platform_device *pdev)
+{
+	struct nop_usb_xceiv	*nop;
+
+	nop = kzalloc(sizeof *nop, GFP_KERNEL);
+	if (!nop)
+		return -ENOMEM;
+
+	nop->dev		= &pdev->dev;
+	nop->otg.dev		= nop->dev;
+	nop->otg.label		= "nop-xceiv";
+	nop->otg.set_host	= nop_set_host;
+	nop->otg.set_peripheral	= nop_set_peripheral;
+	nop->otg.set_suspend	= nop_set_suspend;
+
+	otg_set_transceiver(&nop->otg);
+
+	platform_set_drvdata(pdev, nop);
+
+	dev_info(&pdev->dev, "Initialized NOP USB Transceiver\n");
+	return 0;
+}
+
+static int __exit nop_usb_xceiv_remove(struct platform_device *pdev)
+{
+	struct nop_usb_xceiv *nop = platform_get_drvdata(pdev);
+
+	kfree(nop);
+	return 0;
+}
+
+static struct platform_driver nop_usb_xceiv_driver = {
+	.probe		= nop_usb_xceiv_probe,
+	.remove		= __exit_p(nop_usb_xceiv_remove),
+	.driver		= {
+		.name	= "nop_usb_xceiv",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init nop_usb_xceiv_init(void)
+{
+	return platform_driver_register(&nop_usb_xceiv_driver);
+}
+subsys_initcall(nop_usb_xceiv_init);
+
+static void __exit nop_usb_xceiv_exit(void)
+{
+	platform_driver_unregister(&nop_usb_xceiv_driver);
+}
+module_exit(nop_usb_xceiv_exit);
+
+MODULE_ALIAS("platform:nop_usb_xceiv");
+MODULE_AUTHOR("Texas Instruments Inc");
+MODULE_DESCRIPTION("NOP USB Transceiver driver");
+MODULE_LICENSE("GPL");
-- 
1.5.6

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
