From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] USB: Generalize usb initialization for omap hw
Date: Thu, 24 Apr 2008 21:51:52 +0300
Message-ID: <1209063112-30352-2-git-send-email-felipe.balbi@nokia.com>
References: <200804241129.28213.david-b@pacbell.net>
 <1209063112-30352-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:52792 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763684AbYDXSxV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2008 14:53:21 -0400
In-Reply-To: <1209063112-30352-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: david-b@pacbell.net, Felipe Balbi <felipe.balbi@nokia.com>

Create a generic board-file for initializing usb
on omap2430 and omap3 boards.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/Makefile            |    6 +-
 arch/arm/mach-omap2/board-2430sdp-usb.c |   96 ------------
 arch/arm/mach-omap2/board-2430sdp.c     |    5 +-
 arch/arm/mach-omap2/board-3430sdp-usb.c |  241 -------------------------------
 arch/arm/mach-omap2/board-3430sdp.c     |    5 +-
 arch/arm/mach-omap2/usb-ehci.c          |  162 +++++++++++++++++++++
 arch/arm/mach-omap2/usb-musb.c          |  116 +++++++++++++++
 include/asm-arm/arch-omap/usb-ehci.h    |   35 +++++
 include/asm-arm/arch-omap/usb-musb.h    |   35 +++++
 9 files changed, 360 insertions(+), 341 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/board-2430sdp-usb.c
 delete mode 100644 arch/arm/mach-omap2/board-3430sdp-usb.c
 create mode 100644 arch/arm/mach-omap2/usb-ehci.c
 create mode 100644 arch/arm/mach-omap2/usb-musb.c
 create mode 100644 include/asm-arm/arch-omap/usb-ehci.h
 create mode 100644 include/asm-arm/arch-omap/usb-musb.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index c37df1a..9b6f60e 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -29,11 +29,13 @@ obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o board-h4-mmc.o
 obj-$(CONFIG_MACH_OMAP_2430SDP)		+= board-2430sdp.o \
 					   board-2430sdp-flash.o \
 					   board-sdp-hsmmc.o \
-					   board-2430sdp-usb.o
+					   usb-musb.o \
+					   usb-ehci.o
 obj-$(CONFIG_MACH_OMAP_2430OSK)		+= board-2430osk.o
 obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
 					   board-sdp-hsmmc.o \
-					   board-3430sdp-usb.o \
+					   usb-musb.o \
+					   usb-ehci.o \
 					   board-3430sdp-flash.o
 obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o
 obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
diff --git a/arch/arm/mach-omap2/board-2430sdp-usb.c b/arch/arm/mach-omap2/board-2430sdp-usb.c
deleted file mode 100644
index cfbf73e..0000000
--- a/arch/arm/mach-omap2/board-2430sdp-usb.c
+++ /dev/null
@@ -1,96 +0,0 @@
-/*
- * linux/arch/arm/mach-omap2/board-2430sdp-usb.c
- *
- * Copyright (C) 2007 MontaVista Software, Inc. <source@mvista.com>
- * Author: Kevin Hilman
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/delay.h>
-#include <linux/platform_device.h>
-#include <linux/clk.h>
-#include <linux/usb/musb.h>
-
-#include <asm/arch/hardware.h>
-#include <asm/arch/pm.h>
-#include <asm/arch/usb.h>
-
-static struct resource musb_resources[] = {
-	[0] = {
-		.start	= OMAP243X_HS_BASE,
-		.end	= OMAP243X_HS_BASE + SZ_8K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {	/* general IRQ */
-		.start	= INT_243X_HS_USB_MC,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {	/* DMA IRQ */
-		.start	= INT_243X_HS_USB_DMA,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static int usbhs_ick_on;
-
-static int musb_set_clock(struct clk *clk, int state)
-{
-       if (state) {
-               if (usbhs_ick_on > 0)
-                       return -ENODEV;
-
-               omap2_block_sleep();
-               clk_enable(clk);
-               usbhs_ick_on = 1;
-       } else {
-               if (usbhs_ick_on == 0)
-                       return -ENODEV;
-
-               clk_disable(clk);
-               usbhs_ick_on = 0;
-               omap2_allow_sleep();
-       }
-
-       return 0;
-}
-
-static struct musb_hdrc_platform_data musb_plat = {
-#ifdef CONFIG_USB_MUSB_OTG
-	.mode		= MUSB_OTG,
-#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
-	.mode		= MUSB_HOST,
-#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
-	.mode		= MUSB_PERIPHERAL,
-#endif
-	.multipoint	= 1,
-	.clock		= "usbhs_ick",
-	.set_clock	= musb_set_clock,
-};
-
-static u64 musb_dmamask = ~(u32)0;
-
-static struct platform_device musb_device = {
-	.name		= "musb_hdrc",
-	.id		= 0,
-	.dev = {
-		.dma_mask		= &musb_dmamask,
-		.coherent_dma_mask	= 0xffffffff,
-		.platform_data		= &musb_plat,
-	},
-	.num_resources	= ARRAY_SIZE(musb_resources),
-	.resource	= musb_resources,
-};
-
-void __init sdp2430_usb_init(void)
-{
-	if (platform_device_register(&musb_device) < 0) {
-		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
-		return;
-	}
-}
-
diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 76bbe06..2018b5d 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -35,6 +35,8 @@
 #include <asm/arch/gpio.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/board.h>
+#include <asm/arch/usb-musb.h>
+#include <asm/arch/usb-ehci.h>
 #include <asm/arch/common.h>
 #include <asm/arch/keypad.h>
 #include <asm/arch/gpmc.h>
@@ -390,7 +392,8 @@ static void __init omap_2430sdp_init(void)
 	omap_serial_init();
 
 	sdp2430_flash_init();
-	sdp2430_usb_init();
+	usb_musb_init();
+	usb_ehci_init();
 
 	spi_register_board_info(sdp2430_spi_board_info,
 				ARRAY_SIZE(sdp2430_spi_board_info));
diff --git a/arch/arm/mach-omap2/board-3430sdp-usb.c b/arch/arm/mach-omap2/board-3430sdp-usb.c
deleted file mode 100644
index 048f017..0000000
--- a/arch/arm/mach-omap2/board-3430sdp-usb.c
+++ /dev/null
@@ -1,241 +0,0 @@
-/*
- * linux/arch/arm/mach-omap2/board-3430sdp-usb.c
- *
- * This file will contain the board specific details for the
- * MENTOR USB OTG and Synopsys EHCI host controllers on OMAP3430
- *
- * Copyright (C) 2007 Texas Instruments
- * Author: Vikram Pandita
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/delay.h>
-#include <linux/platform_device.h>
-#include <linux/clk.h>
-#include <asm/io.h>
-#include <asm/arch/mux.h>
-#include <linux/usb/musb.h>
-
-#include <asm/arch/hardware.h>
-#include <asm/arch/pm.h>
-#include <asm/arch/usb.h>
-
-#ifdef CONFIG_USB_MUSB_SOC
-static struct resource musb_resources[] = {
-	[0] = {
-		.start	= OMAP34XX_HSUSB_OTG_BASE,
-		.end	= OMAP34XX_HSUSB_OTG_BASE + SZ_8K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {	/* general IRQ */
-		.start	= INT_243X_HS_USB_MC,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {	/* DMA IRQ */
-		.start	= INT_243X_HS_USB_DMA,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static int hsotgusb_ick_on;
-
-static int musb_set_clock(struct clk *clk, int state)
-{
-	if (state) {
-		if (hsotgusb_ick_on > 0)
-			return -ENODEV;
-
-		omap2_block_sleep();
-		clk_enable(clk);
-		hsotgusb_ick_on = 1;
-	} else {
-		if (hsotgusb_ick_on == 0)
-			return -ENODEV;
-
-		clk_disable(clk);
-		hsotgusb_ick_on = 0;
-		omap2_allow_sleep();
-	}
-
-	return 0;
-}
-
-static struct musb_hdrc_platform_data musb_plat = {
-#ifdef CONFIG_USB_MUSB_OTG
-	.mode		= MUSB_OTG,
-#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
-	.mode		= MUSB_HOST,
-#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
-	.mode		= MUSB_PERIPHERAL,
-#endif
-	.multipoint	= 1,
-	.clock		= "hsotgusb_ick",
-	.set_clock	= musb_set_clock,
-};
-
-static u64 musb_dmamask = ~(u32)0;
-
-static struct platform_device musb_device = {
-	.name		= "musb_hdrc",
-	.id		= 0,
-	.dev = {
-		.dma_mask		= &musb_dmamask,
-		.coherent_dma_mask	= 0xffffffff,
-		.platform_data		= &musb_plat,
-	},
-	.num_resources	= ARRAY_SIZE(musb_resources),
-	.resource	= musb_resources,
-};
-#endif
-
-
-/* EHCI platform specific data */
-
-#if	defined(CONFIG_USB_EHCI_HCD) || defined(CONFIG_USB_EHCI_HCD_MODULE)
-static struct resource ehci_resources[] = {
-	[0] = {
-		.start   = OMAP34XX_HSUSB_HOST_BASE + 0x800,
-		.end     = OMAP34XX_HSUSB_HOST_BASE + 0x800 + SZ_1K - 1,
-		.flags   = IORESOURCE_MEM,
-	},
-	[1] = {         /* general IRQ */
-		.start   = INT_34XX_EHCI_IRQ,
-		.flags   = IORESOURCE_IRQ,
-	}
-};
-
-static u64 ehci_dmamask = ~(u32)0;
-static struct platform_device ehci_device = {
-	.name           = "ehci-omap",
-	.id             = 0,
-	.dev = {
-		.dma_mask               = &ehci_dmamask,
-		.coherent_dma_mask      = 0xffffffff,
-		.platform_data          = 0x0,
-	},
-	.num_resources  = ARRAY_SIZE(ehci_resources),
-	.resource       = ehci_resources,
-};
-
-
-/* MUX settings for EHCI pins */
-/*
- * setup_ehci_io_mux - initialize IO pad mux for USBHOST
- */
-static void setup_ehci_io_mux(void)
-{
-#ifdef CONFIG_OMAP_EHCI_PHY_MODE
-	/* PHY mode of operation for board: 750-2083-001
-	 * ISP1504 connected to Port1 and Port2
-	 * Do Func Mux setting for 12-pin ULPI PHY mode
-	 */
-
-	/* Port1 */
-	omap_cfg_reg(Y9_3430_USB1HS_PHY_STP);
-	omap_cfg_reg(Y8_3430_USB1HS_PHY_CLK);
-	omap_cfg_reg(AA14_3430_USB1HS_PHY_DIR);
-	omap_cfg_reg(AA11_3430_USB1HS_PHY_NXT);
-	omap_cfg_reg(W13_3430_USB1HS_PHY_DATA0);
-	omap_cfg_reg(W12_3430_USB1HS_PHY_DATA1);
-	omap_cfg_reg(W11_3430_USB1HS_PHY_DATA2);
-	omap_cfg_reg(Y11_3430_USB1HS_PHY_DATA3);
-	omap_cfg_reg(W9_3430_USB1HS_PHY_DATA4);
-	omap_cfg_reg(Y12_3430_USB1HS_PHY_DATA5);
-	omap_cfg_reg(W8_3430_USB1HS_PHY_DATA6);
-	omap_cfg_reg(Y13_3430_USB1HS_PHY_DATA7);
-
-	/* Port2 */
-	omap_cfg_reg(AA10_3430_USB2HS_PHY_STP);
-	omap_cfg_reg(AA8_3430_USB2HS_PHY_CLK);
-	omap_cfg_reg(AA9_3430_USB2HS_PHY_DIR);
-	omap_cfg_reg(AB11_3430_USB2HS_PHY_NXT);
-	omap_cfg_reg(AB10_3430_USB2HS_PHY_DATA0);
-	omap_cfg_reg(AB9_3430_USB2HS_PHY_DATA1);
-	omap_cfg_reg(W3_3430_USB2HS_PHY_DATA2);
-	omap_cfg_reg(T4_3430_USB2HS_PHY_DATA3);
-	omap_cfg_reg(T3_3430_USB2HS_PHY_DATA4);
-	omap_cfg_reg(R3_3430_USB2HS_PHY_DATA5);
-	omap_cfg_reg(R4_3430_USB2HS_PHY_DATA6);
-	omap_cfg_reg(T2_3430_USB2HS_PHY_DATA7);
-
-#else
-	/* Set Func mux for :
-	 * TLL mode of operation
-	 * 12-pin ULPI SDR TLL mode for Port1/2/3
-	 */
-
-	/* Port1 */
-	omap_cfg_reg(Y9_3430_USB1HS_TLL_STP);
-	omap_cfg_reg(Y8_3430_USB1HS_TLL_CLK);
-	omap_cfg_reg(AA14_3430_USB1HS_TLL_DIR);
-	omap_cfg_reg(AA11_3430_USB1HS_TLL_NXT);
-	omap_cfg_reg(W13_3430_USB1HS_TLL_DATA0);
-	omap_cfg_reg(W12_3430_USB1HS_TLL_DATA1);
-	omap_cfg_reg(W11_3430_USB1HS_TLL_DATA2);
-	omap_cfg_reg(Y11_3430_USB1HS_TLL_DATA3);
-	omap_cfg_reg(W9_3430_USB1HS_TLL_DATA4);
-	omap_cfg_reg(Y12_3430_USB1HS_TLL_DATA5);
-	omap_cfg_reg(W8_3430_USB1HS_TLL_DATA6);
-	omap_cfg_reg(Y13_3430_USB1HS_TLL_DATA7);
-
-	/* Port2 */
-	omap_cfg_reg(AA10_3430_USB2HS_TLL_STP);
-	omap_cfg_reg(AA8_3430_USB2HS_TLL_CLK);
-	omap_cfg_reg(AA9_3430_USB2HS_TLL_DIR);
-	omap_cfg_reg(AB11_3430_USB2HS_TLL_NXT);
-	omap_cfg_reg(AB10_3430_USB2HS_TLL_DATA0);
-	omap_cfg_reg(AB9_3430_USB2HS_TLL_DATA1);
-	omap_cfg_reg(W3_3430_USB2HS_TLL_DATA2);
-	omap_cfg_reg(T4_3430_USB2HS_TLL_DATA3);
-	omap_cfg_reg(T3_3430_USB2HS_TLL_DATA4);
-	omap_cfg_reg(R3_3430_USB2HS_TLL_DATA5);
-	omap_cfg_reg(R4_3430_USB2HS_TLL_DATA6);
-	omap_cfg_reg(T2_3430_USB2HS_TLL_DATA7);
-
-	/* Port3 */
-	omap_cfg_reg(AB3_3430_USB3HS_TLL_STP);
-	omap_cfg_reg(AA6_3430_USB3HS_TLL_CLK);
-	omap_cfg_reg(AA3_3430_USB3HS_TLL_DIR);
-	omap_cfg_reg(Y3_3430_USB3HS_TLL_NXT);
-	omap_cfg_reg(AA5_3430_USB3HS_TLL_DATA0);
-	omap_cfg_reg(Y4_3430_USB3HS_TLL_DATA1);
-	omap_cfg_reg(Y5_3430_USB3HS_TLL_DATA2);
-	omap_cfg_reg(W5_3430_USB3HS_TLL_DATA3);
-	omap_cfg_reg(AB12_3430_USB3HS_TLL_DATA4);
-	omap_cfg_reg(AB13_3430_USB3HS_TLL_DATA5);
-	omap_cfg_reg(AA13_3430_USB3HS_TLL_DATA6);
-	omap_cfg_reg(AA12_3430_USB3HS_TLL_DATA7);
-#endif /* CONFIG_OMAP_EHCI_PHY_MODE */
-
-	return;
-}
-
-#endif /* EHCI specific data */
-
-void __init sdp3430_usb_init(void)
-{
-#ifdef CONFIG_USB_MUSB_SOC
-	if (platform_device_register(&musb_device) < 0) {
-		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
-		return;
-	}
-#endif
-
-#if     defined(CONFIG_USB_EHCI_HCD) || defined(CONFIG_USB_EHCI_HCD_MODULE)
-
-	/* Setup Pin IO MUX for EHCI */
-	setup_ehci_io_mux();
-
-	if (platform_device_register(&ehci_device) < 0) {
-		printk(KERN_ERR "Unable to register HS-USB (EHCI) device\n");
-		return;
-	}
-#endif
-
-}
-
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 1eb84a6..060c976 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -33,6 +33,8 @@
 #include <asm/arch/gpio.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/board.h>
+#include <asm/arch/usb-musb.h>
+#include <asm/arch/usb-ehci.h>
 #include <asm/arch/common.h>
 #include <asm/arch/keypad.h>
 #include <asm/arch/dma.h>
@@ -297,7 +299,8 @@ static void __init omap_3430sdp_init(void)
 	ads7846_dev_init();
 	sdp3430_flash_init();
 	omap_serial_init();
-	sdp3430_usb_init();
+	usb_musb_init();
+	usb_ehci_init();
 	sdp_mmc_init();
 }
 
diff --git a/arch/arm/mach-omap2/usb-ehci.c b/arch/arm/mach-omap2/usb-ehci.c
new file mode 100644
index 0000000..ffd1108
--- /dev/null
+++ b/arch/arm/mach-omap2/usb-ehci.c
@@ -0,0 +1,162 @@
+/*
+ * linux/arch/arm/mach-omap2/usb-ehci.c
+ *
+ * This file will contain the board specific details for the
+ * Synopsys EHCI host controller on OMAP3430
+ *
+ * Copyright (C) 2008 Nokia Corporation
+ * Author: Felipe Balbi <felipe.balbi@nokia.com>
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
+#include <asm/io.h>
+#include <asm/arch/mux.h>
+#include <linux/usb/musb.h>
+
+#include <asm/arch/hardware.h>
+#include <asm/arch/pm.h>
+#include <asm/arch/usb.h>
+
+#if	defined(CONFIG_USB_EHCI_HCD) || defined(CONFIG_USB_EHCI_HCD_MODULE)
+static struct resource ehci_resources[] = {
+	[0] = {
+		.start   = OMAP34XX_HSUSB_HOST_BASE + 0x800,
+		.end     = OMAP34XX_HSUSB_HOST_BASE + 0x800 + SZ_1K - 1,
+		.flags   = IORESOURCE_MEM,
+	},
+	[1] = {         /* general IRQ */
+		.start   = INT_34XX_EHCI_IRQ,
+		.flags   = IORESOURCE_IRQ,
+	}
+};
+
+static u64 ehci_dmamask = ~(u32)0;
+static struct platform_device ehci_device = {
+	.name           = "ehci-omap",
+	.id             = 0,
+	.dev = {
+		.dma_mask               = &ehci_dmamask,
+		.coherent_dma_mask      = 0xffffffff,
+		.platform_data          = 0x0,
+	},
+	.num_resources  = ARRAY_SIZE(ehci_resources),
+	.resource       = ehci_resources,
+};
+
+
+/* MUX settings for EHCI pins */
+/*
+ * setup_ehci_io_mux - initialize IO pad mux for USBHOST
+ */
+static void setup_ehci_io_mux(void)
+{
+#ifdef CONFIG_OMAP_EHCI_PHY_MODE
+	/* PHY mode of operation for board: 750-2083-001
+	 * ISP1504 connected to Port1 and Port2
+	 * Do Func Mux setting for 12-pin ULPI PHY mode
+	 */
+
+	/* Port1 */
+	omap_cfg_reg(Y9_3430_USB1HS_PHY_STP);
+	omap_cfg_reg(Y8_3430_USB1HS_PHY_CLK);
+	omap_cfg_reg(AA14_3430_USB1HS_PHY_DIR);
+	omap_cfg_reg(AA11_3430_USB1HS_PHY_NXT);
+	omap_cfg_reg(W13_3430_USB1HS_PHY_DATA0);
+	omap_cfg_reg(W12_3430_USB1HS_PHY_DATA1);
+	omap_cfg_reg(W11_3430_USB1HS_PHY_DATA2);
+	omap_cfg_reg(Y11_3430_USB1HS_PHY_DATA3);
+	omap_cfg_reg(W9_3430_USB1HS_PHY_DATA4);
+	omap_cfg_reg(Y12_3430_USB1HS_PHY_DATA5);
+	omap_cfg_reg(W8_3430_USB1HS_PHY_DATA6);
+	omap_cfg_reg(Y13_3430_USB1HS_PHY_DATA7);
+
+	/* Port2 */
+	omap_cfg_reg(AA10_3430_USB2HS_PHY_STP);
+	omap_cfg_reg(AA8_3430_USB2HS_PHY_CLK);
+	omap_cfg_reg(AA9_3430_USB2HS_PHY_DIR);
+	omap_cfg_reg(AB11_3430_USB2HS_PHY_NXT);
+	omap_cfg_reg(AB10_3430_USB2HS_PHY_DATA0);
+	omap_cfg_reg(AB9_3430_USB2HS_PHY_DATA1);
+	omap_cfg_reg(W3_3430_USB2HS_PHY_DATA2);
+	omap_cfg_reg(T4_3430_USB2HS_PHY_DATA3);
+	omap_cfg_reg(T3_3430_USB2HS_PHY_DATA4);
+	omap_cfg_reg(R3_3430_USB2HS_PHY_DATA5);
+	omap_cfg_reg(R4_3430_USB2HS_PHY_DATA6);
+	omap_cfg_reg(T2_3430_USB2HS_PHY_DATA7);
+
+#else
+	/* Set Func mux for :
+	 * TLL mode of operation
+	 * 12-pin ULPI SDR TLL mode for Port1/2/3
+	 */
+
+	/* Port1 */
+	omap_cfg_reg(Y9_3430_USB1HS_TLL_STP);
+	omap_cfg_reg(Y8_3430_USB1HS_TLL_CLK);
+	omap_cfg_reg(AA14_3430_USB1HS_TLL_DIR);
+	omap_cfg_reg(AA11_3430_USB1HS_TLL_NXT);
+	omap_cfg_reg(W13_3430_USB1HS_TLL_DATA0);
+	omap_cfg_reg(W12_3430_USB1HS_TLL_DATA1);
+	omap_cfg_reg(W11_3430_USB1HS_TLL_DATA2);
+	omap_cfg_reg(Y11_3430_USB1HS_TLL_DATA3);
+	omap_cfg_reg(W9_3430_USB1HS_TLL_DATA4);
+	omap_cfg_reg(Y12_3430_USB1HS_TLL_DATA5);
+	omap_cfg_reg(W8_3430_USB1HS_TLL_DATA6);
+	omap_cfg_reg(Y13_3430_USB1HS_TLL_DATA7);
+
+	/* Port2 */
+	omap_cfg_reg(AA10_3430_USB2HS_TLL_STP);
+	omap_cfg_reg(AA8_3430_USB2HS_TLL_CLK);
+	omap_cfg_reg(AA9_3430_USB2HS_TLL_DIR);
+	omap_cfg_reg(AB11_3430_USB2HS_TLL_NXT);
+	omap_cfg_reg(AB10_3430_USB2HS_TLL_DATA0);
+	omap_cfg_reg(AB9_3430_USB2HS_TLL_DATA1);
+	omap_cfg_reg(W3_3430_USB2HS_TLL_DATA2);
+	omap_cfg_reg(T4_3430_USB2HS_TLL_DATA3);
+	omap_cfg_reg(T3_3430_USB2HS_TLL_DATA4);
+	omap_cfg_reg(R3_3430_USB2HS_TLL_DATA5);
+	omap_cfg_reg(R4_3430_USB2HS_TLL_DATA6);
+	omap_cfg_reg(T2_3430_USB2HS_TLL_DATA7);
+
+	/* Port3 */
+	omap_cfg_reg(AB3_3430_USB3HS_TLL_STP);
+	omap_cfg_reg(AA6_3430_USB3HS_TLL_CLK);
+	omap_cfg_reg(AA3_3430_USB3HS_TLL_DIR);
+	omap_cfg_reg(Y3_3430_USB3HS_TLL_NXT);
+	omap_cfg_reg(AA5_3430_USB3HS_TLL_DATA0);
+	omap_cfg_reg(Y4_3430_USB3HS_TLL_DATA1);
+	omap_cfg_reg(Y5_3430_USB3HS_TLL_DATA2);
+	omap_cfg_reg(W5_3430_USB3HS_TLL_DATA3);
+	omap_cfg_reg(AB12_3430_USB3HS_TLL_DATA4);
+	omap_cfg_reg(AB13_3430_USB3HS_TLL_DATA5);
+	omap_cfg_reg(AA13_3430_USB3HS_TLL_DATA6);
+	omap_cfg_reg(AA12_3430_USB3HS_TLL_DATA7);
+#endif /* CONFIG_OMAP_EHCI_PHY_MODE */
+
+	return;
+}
+
+#endif /* EHCI specific data */
+
+void __init usb_ehci_init(void)
+{
+#if     defined(CONFIG_USB_EHCI_HCD) || defined(CONFIG_USB_EHCI_HCD_MODULE)
+	/* Setup Pin IO MUX for EHCI */
+	if (cpu_is_omap34xx())
+		setup_ehci_io_mux();
+
+	if (platform_device_register(&ehci_device) < 0) {
+		printk(KERN_ERR "Unable to register HS-USB (EHCI) device\n");
+		return;
+	}
+#endif
+}
+
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
new file mode 100644
index 0000000..cbd59f8
--- /dev/null
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -0,0 +1,116 @@
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
+#include <asm/io.h>
+#include <asm/arch/mux.h>
+#include <linux/usb/musb.h>
+
+#include <asm/arch/hardware.h>
+#include <asm/arch/pm.h>
+#include <asm/arch/usb.h>
+
+#ifdef CONFIG_USB_MUSB_SOC
+static struct resource musb_resources[] = {
+	[0] = {
+		.start	= cpu_is_omap34xx()
+			? OMAP34XX_HSUSB_OTG_BASE
+			: OMAP243X_HS_BASE,
+		.end	= cpu_is_omap34xx()
+			? OMAP34XX_HSUSB_OTG_BASE + SZ_8K - 1
+			: OMAP243X_HS_BASE + SZ_8K -1,
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
+		omap2_block_sleep();
+		clk_enable(clk);
+		clk_on = 1;
+	} else {
+		if (clk_on == 0)
+			return -ENODEV;
+
+		clk_disable(clk);
+		clk_on = 0;
+		omap2_allow_sleep();
+	}
+
+	return 0;
+}
+
+static struct musb_hdrc_platform_data musb_plat = {
+#ifdef CONFIG_USB_MUSB_OTG
+	.mode		= MUSB_OTG,
+#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
+	.mode		= MUSB_HOST,
+#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
+	.mode		= MUSB_PERIPHERAL,
+#endif
+	.multipoint	= 1,
+	.clock		= cpu_is_omap34xx()
+			? "hsotgusb_ick"
+			: "usbhs_ick",
+	.set_clock	= musb_set_clock,
+};
+
+static u64 musb_dmamask = ~(u32)0;
+
+static struct platform_device musb_device = {
+	.name		= "musb_hdrc",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &musb_dmamask,
+		.coherent_dma_mask	= 0xffffffff,
+		.platform_data		= &musb_plat,
+	},
+	.num_resources	= ARRAY_SIZE(musb_resources),
+	.resource	= musb_resources,
+};
+#endif
+
+
+void __init usb_musb_init(void)
+{
+#ifdef CONFIG_USB_MUSB_SOC
+	if (platform_device_register(&musb_device) < 0) {
+		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
+		return;
+	}
+#endif
+}
+
diff --git a/include/asm-arm/arch-omap/usb-ehci.h b/include/asm-arm/arch-omap/usb-ehci.h
new file mode 100644
index 0000000..2ae3eea
--- /dev/null
+++ b/include/asm-arm/arch-omap/usb-ehci.h
@@ -0,0 +1,35 @@
+/*
+ * linux/include/asm-arm/arch-omap/usb-ehci.h
+ *
+ * Hardware definitions for Synopsys EHCI host controller.
+ *
+ * Initial creation by Felipe Balbi.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __ASM_ARCH_OMAP_USB_EHCI_H
+#define __ASM_ARCH_OMAP_USB_EHCI_H
+
+extern void usb_ehci_init(void);
+
+#endif /* __ASM_ARCH_OMAP_USB_EHCI_H */
+
diff --git a/include/asm-arm/arch-omap/usb-musb.h b/include/asm-arm/arch-omap/usb-musb.h
new file mode 100644
index 0000000..4f0c830
--- /dev/null
+++ b/include/asm-arm/arch-omap/usb-musb.h
@@ -0,0 +1,35 @@
+/*
+ * linux/include/asm-arm/arch-omap/usb-musb.h
+ *
+ * Hardware definitions for Mentor Graphics MUSBMHDRC.
+ *
+ * Initial creation by Felipe Balbi.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __ASM_ARCH_OMAP_USB_MUSB_H
+#define __ASM_ARCH_OMAP_USB_MUSB_H
+
+extern void usb_musb_init(void);
+
+#endif /* __ASM_ARCH_OMAP_USB_MUSB_H */
+
-- 
1.5.5.1.57.g5909c

