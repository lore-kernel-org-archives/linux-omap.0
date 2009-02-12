From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] musb_hdrc: Clean-up init code for mainline merge
Date: Thu, 12 Feb 2009 11:21:01 -0800
Message-ID: <20090212192059.GB7562@atomide.com>
References: <20090212191408.19766.62874.stgit@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63770 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757865AbZBLTVE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Feb 2009 14:21:04 -0500
Received: from c-69-181-40-92.hsd1.ca.comcast.net ([69.181.40.92] helo=localhost.localdomain)
	by mho-01-bos.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1LXh7P-000GfS-0y
	for linux-omap@vger.kernel.org; Thu, 12 Feb 2009 19:21:03 +0000
Content-Disposition: inline
In-Reply-To: <20090212191408.19766.62874.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [090212 11:16]:
> Hi Felipe & Dave,
> 
> While creating a patch for usb-musb.c init code for mainline
> kernel, I ended up cleaning up following stuff in the l-o tree.
> 
> Does it look OK to you?

And here's what the musb_init patch for the mainline. No boards are
calling musb_init() yet, but that's easy to append.

The clock function might cause some merge issues.. I guess eventually
the driver should just call clk_enable/disable once the omap2 clock
merge is done.

Regards,

Tony

--a8Wt8u1KmwUX3Y2C
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="musb-init.patch"

>From 545f2a61242ca4d27bb22d54a1f0b0bfcea86c5f Mon Sep 17 00:00:00 2001
From: Felipe Balbi <felipe.balbi@nokia.com>
Date: Wed, 11 Feb 2009 17:33:49 -0800
Subject: [PATCH] ARM: OMAP3: MUSB initialization for omap hw

Create a generic board-file for initializing usb
on omap2430 and omap3 boards.

Patch modified by Tony to build the module based on
CONFIG_USB_MUSB_SOC.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index b239c7d..dd63683 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -44,3 +44,5 @@ obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
 					   board-rx51-peripherals.o \
 					   mmc-twl4030.o
 
+# Platform specific device init code
+obj-$(CONFIG_USB_MUSB_SOC)		+= usb-musb.o
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
new file mode 100644
index 0000000..327af7d
--- /dev/null
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -0,0 +1,165 @@
+/*
+ * linux/arch/arm/mach-omap2/usb-musb.c
+ *
+ * This file will contain the board specific details for the
+ * MENTOR USB OTG controller on OMAP3430
+ *
+ * Copyright (C) 2007-2008 Texas Instruments
+ * Copyright (C) 2008 Nokia Corporation
+ * Author: Vikram Pandita
+ *
+ * Generalization by:
+ * Felipe Balbi <felipe.balbi@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/dma-mapping.h>
+
+#include <asm/io.h>
+
+#include <linux/usb/musb.h>
+
+#include <mach/hardware.h>
+#include <mach/irqs.h>
+#include <mach/pm.h>
+#include <mach/mux.h>
+#include <mach/usb.h>
+
+static struct resource musb_resources[] = {
+	[0] = { /* start and end set dynamically */
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {	/* general IRQ */
+		.start	= INT_243X_HS_USB_MC,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {	/* DMA IRQ */
+		.start	= INT_243X_HS_USB_DMA,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static int clk_on;
+
+static int musb_set_clock(struct clk *clk, int state)
+{
+	if (state) {
+		if (clk_on > 0)
+			return -ENODEV;
+
+		clk_enable(clk);
+		clk_on = 1;
+	} else {
+		if (clk_on == 0)
+			return -ENODEV;
+
+		clk_disable(clk);
+		clk_on = 0;
+	}
+
+	return 0;
+}
+
+static struct musb_hdrc_eps_bits musb_eps[] = {
+	{	"ep1_tx", 10,	},
+	{	"ep1_rx", 10,	},
+	{	"ep2_tx", 9,	},
+	{	"ep2_rx", 9,	},
+	{	"ep3_tx", 3,	},
+	{	"ep3_rx", 3,	},
+	{	"ep4_tx", 3,	},
+	{	"ep4_rx", 3,	},
+	{	"ep5_tx", 3,	},
+	{	"ep5_rx", 3,	},
+	{	"ep6_tx", 3,	},
+	{	"ep6_rx", 3,	},
+	{	"ep7_tx", 3,	},
+	{	"ep7_rx", 3,	},
+	{	"ep8_tx", 2,	},
+	{	"ep8_rx", 2,	},
+	{	"ep9_tx", 2,	},
+	{	"ep9_rx", 2,	},
+	{	"ep10_tx", 2,	},
+	{	"ep10_rx", 2,	},
+	{	"ep11_tx", 2,	},
+	{	"ep11_rx", 2,	},
+	{	"ep12_tx", 2,	},
+	{	"ep12_rx", 2,	},
+	{	"ep13_tx", 2,	},
+	{	"ep13_rx", 2,	},
+	{	"ep14_tx", 2,	},
+	{	"ep14_rx", 2,	},
+	{	"ep15_tx", 2,	},
+	{	"ep15_rx", 2,	},
+};
+
+static struct musb_hdrc_config musb_config = {
+	.multipoint	= 1,
+	.dyn_fifo	= 1,
+	.soft_con	= 1,
+	.dma		= 1,
+	.num_eps	= 16,
+	.dma_channels	= 7,
+	.dma_req_chan	= (1 << 0) | (1 << 1) | (1 << 2) | (1 << 3),
+	.ram_bits	= 12,
+	.eps_bits	= musb_eps,
+};
+
+static struct musb_hdrc_platform_data musb_plat = {
+#ifdef CONFIG_USB_MUSB_OTG
+	.mode		= MUSB_OTG,
+#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
+	.mode		= MUSB_HOST,
+#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
+	.mode		= MUSB_PERIPHERAL,
+#endif
+	/* .clock is set dynamically */
+	.set_clock	= musb_set_clock,
+	.config		= &musb_config,
+
+	/* REVISIT charge pump on TWL4030 can supply up to
+	 * 100 mA ... but this value is board-specific, like
+	 * "mode", and should be passed to usb_musb_init().
+	 */
+	.power		= 50,			/* up to 100 mA */
+};
+
+static u64 musb_dmamask = DMA_32BIT_MASK;
+
+static struct platform_device musb_device = {
+	.name		= "musb_hdrc",
+	.id		= -1,
+	.dev = {
+		.dma_mask		= &musb_dmamask,
+		.coherent_dma_mask	= DMA_32BIT_MASK,
+		.platform_data		= &musb_plat,
+	},
+	.num_resources	= ARRAY_SIZE(musb_resources),
+	.resource	= musb_resources,
+};
+
+void __init usb_musb_init(void)
+{
+	if (cpu_is_omap243x()) {
+		musb_resources[0].start = OMAP243X_HS_BASE;
+		musb_plat.clock = "usbhs_ick";
+	} else {
+		musb_resources[0].start = OMAP34XX_HSUSB_OTG_BASE;
+		musb_plat.clock = "hsotgusb_ick";
+	}
+
+	musb_resources[0].end = musb_resources[0].start + SZ_8K - 1;
+
+	if (platform_device_register(&musb_device) < 0) {
+		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
+		return;
+	}
+}
diff --git a/arch/arm/plat-omap/include/mach/usb.h b/arch/arm/plat-omap/include/mach/usb.h
index a56a610..ddc0522 100644
--- a/arch/arm/plat-omap/include/mach/usb.h
+++ b/arch/arm/plat-omap/include/mach/usb.h
@@ -27,6 +27,14 @@
 #define UDC_BASE			OMAP2_UDC_BASE
 #define OMAP_OHCI_BASE			OMAP2_OHCI_BASE
 
+#ifdef CONFIG_USB_MUSB_SOC
+extern void usb_musb_init(void);
+#else
+static inline void usb_musb_init(void)
+{
+}
+#endif
+
 #endif
 
 /*-------------------------------------------------------------------------*/

--a8Wt8u1KmwUX3Y2C--
