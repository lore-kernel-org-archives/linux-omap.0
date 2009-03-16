From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 12/12] ARM: OMAP3: MUSB initialization for omap hw, v2
Date: Mon, 16 Mar 2009 15:37:38 -0700
Message-ID: <20090316223737.GN19229@atomide.com>
References: <20090310205824.16425.97745.stgit@localhost> <20090310211628.16425.55120.stgit@localhost> <20090315161446.GG10786@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PtLnLSExlPr13a2X"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63725 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520AbZCPWhq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2009 18:37:46 -0400
Content-Disposition: inline
In-Reply-To: <20090315161446.GG10786@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Ajay Kumar Gupta <ajay.gupta@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org


--PtLnLSExlPr13a2X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090315 09:14]:
> On Tue, Mar 10, 2009 at 02:16:28PM -0700, Tony Lindgren wrote:
> > Patch modified by Tony to build the module based on
> > CONFIG_USB_MUSB_SOC.
> 
> I don't see this.
> 
> > +# Platform specific device init code
> > +obj-$(CONFIG_USB_MUSB_SOC)		+= usb-musb.o
> 
> So, if this can be a module, the file itself doesn't export any symbols
> and doesn't have any module_init or module_exit functions.  So, if this
> gets built as a module, it isn't useful.

Good point. I've updated the Makefile, it's not intended to be compiled
as a module as it's initialized from the low-level board init code only
for the systems that have the musb wired up.

> > +void __init usb_musb_init(void)
> > +{
> > +	if (cpu_is_omap243x()) {
> > +		musb_resources[0].start = OMAP243X_HS_BASE;
> > +		musb_plat.clock = "usbhs_ick";
> 
> kill kill kill.
> 
> > +	} else {
> > +		musb_resources[0].start = OMAP34XX_HSUSB_OTG_BASE;
> > +		musb_plat.clock = "hsotgusb_ick";
> 
> kill kill kill.

Heh!
 
> clkdev removes the need for this sort of crap.

Here's the future proof version. Will post another patch against your
omap-clks3 branch to set the names for musb clocks in clock[23]4xx.c.

Tony

--PtLnLSExlPr13a2X
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="musb-init-v2.patch"

>From 18936e335f62f252fa584ee9a22f99ebc34cd4c5 Mon Sep 17 00:00:00 2001
From: Felipe Balbi <felipe.balbi@nokia.com>
Date: Mon, 16 Mar 2009 11:01:50 -0700
Subject: [PATCH] ARM: OMAP3: MUSB initialization for omap hw, v2

Create a generic board-file for initializing usb
on omap2430 and omap3 boards.

Patch modified by Tony to build the module based on
CONFIG_USB_MUSB_SOC. Also merged in a patch adding
the nop xceiv from Ajay Kumar Gupta <ajay.gupta@ti.com>.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index bbd12bc..29f6ca9 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -39,3 +39,7 @@ obj-$(CONFIG_MACH_OVERO)		+= board-overo.o \
 obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o \
 					   mmc-twl4030.o
 
+# Platform specific device init code
+ifeq ($(CONFIG_USB_MUSB_SOC),y)
+obj-y					+= usb-musb.o
+endif
diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 83fa372..9619e25 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -35,6 +35,7 @@
 #include <mach/board.h>
 #include <mach/common.h>
 #include <mach/gpmc.h>
+#include <mach/usb.h>
 
 #include "mmc-twl4030.h"
 
@@ -251,6 +252,7 @@ static void __init omap_2430sdp_init(void)
 	omap_board_config_size = ARRAY_SIZE(sdp2430_config);
 	omap_serial_init();
 	twl4030_mmc_init(mmc);
+	usb_musb_init();
 }
 
 static void __init omap_2430sdp_map_io(void)
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 6031e17..1b54c20 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -38,6 +38,7 @@
 #include <asm/io.h>
 #include <asm/delay.h>
 #include <mach/control.h>
+#include <mach/usb.h>
 
 #include "mmc-twl4030.h"
 
@@ -162,6 +163,7 @@ static void __init omap_ldp_init(void)
 	omap_board_config_size = ARRAY_SIZE(ldp_config);
 	omap_serial_init();
 	twl4030_mmc_init(mmc);
+	usb_musb_init();
 }
 
 static void __init omap_ldp_map_io(void)
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index e3c8628..2f3d821 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -41,6 +41,7 @@
 #include <mach/gpmc.h>
 #include <mach/nand.h>
 #include <mach/mux.h>
+#include <mach/usb.h>
 
 #include "mmc-twl4030.h"
 
@@ -313,6 +314,7 @@ static void __init omap3_beagle_init(void)
 	/* REVISIT leave DVI powered down until it's needed ... */
 	gpio_direction_output(170, true);
 
+	usb_musb_init();
 	omap3beagle_flash_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 6e17180..16e2128 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -34,6 +34,7 @@
 #include <mach/gpio.h>
 #include <mach/hardware.h>
 #include <mach/mcspi.h>
+#include <mach/usb.h>
 
 #include "mmc-twl4030.h"
 
@@ -200,6 +201,7 @@ static void __init omap3pandora_init(void)
 	spi_register_board_info(omap3pandora_spi_board_info,
 			ARRAY_SIZE(omap3pandora_spi_board_info));
 	omap3pandora_ads7846_init();
+	usb_musb_init();
 }
 
 static void __init omap3pandora_map_io(void)
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 61f8e23..d785aa8 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -44,6 +44,7 @@
 #include <mach/gpmc.h>
 #include <mach/hardware.h>
 #include <mach/nand.h>
+#include <mach/usb.h>
 
 #include "mmc-twl4030.h"
 
@@ -223,6 +224,7 @@ static void __init overo_init(void)
 	omap_serial_init();
 	twl4030_mmc_init(mmc);
 	overo_flash_init();
+	usb_musb_init();
 
 	if ((gpio_request(OVERO_GPIO_W2W_NRESET,
 			  "OVERO_GPIO_W2W_NRESET") == 0) &&
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
new file mode 100644
index 0000000..fc74e91
--- /dev/null
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -0,0 +1,187 @@
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
+#include <linux/io.h>
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
+#ifdef CONFIG_NOP_USB_XCEIV
+static u64 nop_xceiv_dmamask = DMA_32BIT_MASK;
+
+static struct platform_device nop_xceiv_device = {
+	.name		= "nop_usb_xceiv",
+	.id		= -1,
+	.dev = {
+		.dma_mask		= &nop_xceiv_dmamask,
+		.coherent_dma_mask	= DMA_32BIT_MASK,
+		.platform_data		= NULL,
+	},
+};
+#endif
+
+void __init usb_musb_init(void)
+{
+	if (cpu_is_omap243x())
+		musb_resources[0].start = OMAP243X_HS_BASE;
+	else
+		musb_resources[0].start = OMAP34XX_HSUSB_OTG_BASE;
+	musb_resources[0].end = musb_resources[0].start + SZ_8K - 1;
+
+	/*
+	 * REVISIT: This line can be removed once all the platforms using
+	 * musb_core.c have been converted to use use clkdev.
+	 */
+	musb_plat.clock = "ick";
+
+#ifdef CONFIG_NOP_USB_XCEIV
+	if (platform_device_register(&nop_xceiv_device) < 0) {
+		printk(KERN_ERR "Unable to register NOP-XCEIV device\n");
+		return;
+	}
+#endif
+
+	if (platform_device_register(&musb_device) < 0) {
+		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
+		return;
+	}
+}
diff --git a/arch/arm/plat-omap/include/mach/usb.h b/arch/arm/plat-omap/include/mach/usb.h
index e033e51..69f0cee 100644
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
 
 void omap_usb_init(struct omap_usb_config *pdata);

--PtLnLSExlPr13a2X--
