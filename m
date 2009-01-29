From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] usb: musb: adding nop usb transceiver
Date: Thu, 29 Jan 2009 15:04:55 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403FA790059@dbde02.ent.ti.com>
References: <1231411988-7330-1-git-send-email-ajay.gupta@ti.com>
 <200901222329.07689.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200901222329.07689.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> We'll need something like this, yes.
> This one looks to need a bit of tweaking yet though ...
> probably that could be done after merge.  

> The state can need changing after one of the drivers is unregistered;

I didn't get this comment.

> using __exit not __devexit is likely wrong (especially
> given your MUSB patchlet); 

Changed to __devexit/__devinit.

> xceiv_to_nop() should be an inline function;
> check otg_set_transceiver() value;
> don't bother with dev_info();

Done.

> and I'm not quite sure of the methods.
> Plus I think it's probably best to include a utility
> that board init code can call to register the NOP
> transceiver device ... instead of cloning that bit of
> code (in your second patch) into every board-*.c file
> that needs it.

done. Added this nop_xceiv_register() which can be called from
board-init files to register NOP.

Please review the modified patch version below.

Thanks,
Ajay

=========== cut here ============================================
Subject: [PATCH v2] usb: musb: adding nop usb transceiver

NOP transceiver is used by all the usb transceiver which are mostly
autonomous and doesn't require any programming or which are built
into the usb ip itself.NOP transceiver only allocates the memory
for struct xceiv and calls otg_set_transceiver() so function call
to otg_get_transceiver() will return a valid transceiver.

NOP transceiver device should be registered by calling
nop_xceiv_register() from platform files.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
This version takes cares of David's comments and adds
platform_device_register() utility implemented in nop_xceiv_register()
method within same new file.

 drivers/usb/otg/Kconfig         |    8 ++
 drivers/usb/otg/Makefile        |    1 +
 drivers/usb/otg/nop-usb-xceiv.c |  180 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 189 insertions(+), 0 deletions(-)
 create mode 100644 drivers/usb/otg/nop-usb-xceiv.c

diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
index 8e8dbdb..8376b36 100644
--- a/drivers/usb/otg/Kconfig
+++ b/drivers/usb/otg/Kconfig
@@ -51,4 +51,12 @@ config TWL4030_USB
 	  This transceiver supports high and full speed devices plus,
 	  in host mode, low speed.
 
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
index 0000000..836f4e6
--- /dev/null
+++ b/drivers/usb/otg/nop-usb-xceiv.c
@@ -0,0 +1,180 @@
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
+#include <linux/dma-mapping.h>
+#include <linux/usb/otg.h>
+
+struct nop_usb_xceiv {
+	struct otg_transceiver	otg;
+	struct device		*dev;
+};
+
+static u64 nop_xceiv_dmamask = DMA_32BIT_MASK;
+
+static struct platform_device nop_xceiv_device = {
+	.name           = "nop_usb_xceiv",
+	.id             = -1,
+	.dev = {
+		.dma_mask               = &nop_xceiv_dmamask,
+		.coherent_dma_mask      = DMA_32BIT_MASK,
+		.platform_data          = NULL,
+	},
+};
+
+void nop_xceiv_register(void)
+{
+	if (platform_device_register(&nop_xceiv_device) < 0) {
+		printk(KERN_ERR "Unable to register NOP-XCEIV device\n");
+		return;
+	}
+}
+
+void nop_xceiv_unregister(void)
+{
+	platform_device_unregister(&nop_xceiv_device);
+}
+
+static inline struct nop_usb_xceiv *xceiv_to_nop(struct otg_transceiver *x)
+{
+	return container_of(x, struct nop_usb_xceiv, otg);
+}
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
+static int __devinit nop_usb_xceiv_probe(struct platform_device *pdev)
+{
+	struct nop_usb_xceiv	*nop;
+	int err;
+
+	nop = kzalloc(sizeof *nop, GFP_KERNEL);
+	if (!nop)
+		return -ENOMEM;
+
+	nop->dev		= &pdev->dev;
+	nop->otg.dev		= nop->dev;
+	nop->otg.label		= "nop-xceiv";
+	nop->otg.state		= OTG_STATE_UNDEFINED;
+	nop->otg.set_host	= nop_set_host;
+	nop->otg.set_peripheral	= nop_set_peripheral;
+	nop->otg.set_suspend	= nop_set_suspend;
+
+	err = otg_set_transceiver(&nop->otg);
+	if (err) {
+		dev_err(&pdev->dev, "can't register transceiver, err: %d\n",
+			err);
+		goto exit;
+	}
+
+	platform_set_drvdata(pdev, nop);
+
+	return 0;
+exit:
+	kfree(nop);
+	return err;
+}
+
+static int __devexit nop_usb_xceiv_remove(struct platform_device *pdev)
+{
+	struct nop_usb_xceiv *nop = platform_get_drvdata(pdev);
+
+	otg_set_transceiver(NULL);
+
+	platform_set_drvdata(pdev, NULL);
+	kfree(nop);
+
+	return 0;
+}
+
+static struct platform_driver nop_usb_xceiv_driver = {
+	.probe		= nop_usb_xceiv_probe,
+	.remove		= __devexit_p(nop_usb_xceiv_remove),
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
=================== nop device register support for musb ========

Subject: [PATCH v2] usb: musb: adding support for registering nop xceiv

Adding support for registering nop usb transceiver for musb in OMAP
platforms. Tested with OMAP35xx EVM having OTG phy ISP1504 which is
autonomous and doesn't require any phy programming.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
As per David's comment now the platform_device_register() utility is
added in the nop transceiver file itself to avoid it's duplication
across paltforms.This patch callst nop_xceiv_register() to add
nop transceiver for musb in OMAP platforms.

 arch/arm/mach-omap2/usb-musb.c |    3 +++
 include/linux/usb/musb.h       |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 5d79f89..d8317c4 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -160,6 +160,9 @@ static struct platform_device musb_device = {
 void __init usb_musb_init(void)
 {
 #ifdef CONFIG_USB_MUSB_SOC
+#ifdef CONFIG_NOP_USB_XCEIV
+	nop_xceiv_register();
+#endif
 	if (platform_device_register(&musb_device) < 0) {
 		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
 		return;
diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
index d6aad0e..46bfd91 100644
--- a/include/linux/usb/musb.h
+++ b/include/linux/usb/musb.h
@@ -83,6 +83,9 @@ struct musb_hdrc_platform_data {
 	struct musb_hdrc_config	*config;
 };
 
+#ifdef CONFIG_NOP_USB_XCEIV
+extern void nop_xceiv_register(void);
+#endif
 
 /* TUSB 6010 support */
 
-- 
1.5.6
=================================================================
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
