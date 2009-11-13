From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/14] omap: Add platform init code for EHCI driver
Date: Thu, 12 Nov 2009 16:07:35 -0800
Message-ID: <20091113000735.9034.57379.stgit@localhost>
References: <20091113000444.9034.41293.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54766 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754581AbZKMAHk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 19:07:40 -0500
In-Reply-To: <20091113000444.9034.41293.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Anand Gadiyar <gadiyar@ti.com>, Koen Kooi <koen@beagleboard.org>, Ajay Kumar Gupta <ajay.gupta@ti.com>, Mike Rapoport <mike@compulab.co.il>, Olof Johansson <olof@lixom.net>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Add platform init code for EHCI driver.

Various fixes to the original patch by Ajay Kumar Gupta <ajay.gupta@ti.com>
and Anand Gadiyar <gadiyar@ti.com>.

Overo support added by Olof Johansson <olof@lixom.net>
Beagle support added by Koen Kooi <koen@beagleboard.org>
CM-T32 support added by Mike Rapoport <mike@compulab.co.il>

Signed-off-by: Signed-off-by: Olof Johansson <olof@lixom.net>
Acked-by: Steve Sakoman <steve@sakoman.com>
Signed-off-by: Koen Kooi <koen@beagleboard.org>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile               |    1 
 arch/arm/mach-omap2/board-3430sdp.c        |   13 ++
 arch/arm/mach-omap2/board-omap3beagle.c    |   13 ++
 arch/arm/mach-omap2/board-omap3evm.c       |   15 ++
 arch/arm/mach-omap2/board-omap3pandora.c   |   13 ++
 arch/arm/mach-omap2/board-overo.c          |   21 ++-
 arch/arm/mach-omap2/usb-ehci.c             |  192 ++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap34xx.h |    6 +
 8 files changed, 265 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/mach-omap2/usb-ehci.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 1d54ad3..5c32b65 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -80,6 +80,7 @@ obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o
 # Platform specific device init code
 obj-y					+= usb-musb.o
 obj-$(CONFIG_MACH_OMAP2_TUSB6010)	+= usb-tusb6010.o
+obj-y					+= usb-ehci.o
 
 onenand-$(CONFIG_MTD_ONENAND_OMAP2)	:= gpmc-onenand.o
 obj-y					+= $(onenand-m) $(onenand-y)
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index a2abac9..a3c1271 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -484,6 +484,18 @@ static void enable_board_wakeup_source(void)
 	omap_cfg_reg(AF26_34XX_SYS_NIRQ); /* T2 interrupt line (keypad) */
 }
 
+static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+
+	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+
+	.phy_reset  = true,
+	.reset_gpio_port[0]  = 57,
+	.reset_gpio_port[1]  = 61,
+	.reset_gpio_port[2]  = -EINVAL
+};
+
 static void __init omap_3430sdp_init(void)
 {
 	omap3430_i2c_init();
@@ -500,6 +512,7 @@ static void __init omap_3430sdp_init(void)
 	usb_musb_init();
 	board_smc91x_init();
 	enable_board_wakeup_source();
+	usb_ehci_init(&ehci_pdata);
 }
 
 static void __init omap_3430sdp_map_io(void)
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 71a3528..6cb99f6 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -400,6 +400,18 @@ static void __init omap3beagle_flash_init(void)
 	}
 }
 
+static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+
+	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+
+	.phy_reset  = true,
+	.reset_gpio_port[0]  = -EINVAL,
+	.reset_gpio_port[1]  = 147,
+	.reset_gpio_port[2]  = -EINVAL
+};
+
 static void __init omap3_beagle_init(void)
 {
 	omap3_beagle_i2c_init();
@@ -413,6 +425,7 @@ static void __init omap3_beagle_init(void)
 	gpio_direction_output(170, true);
 
 	usb_musb_init();
+	usb_ehci_init(&ehci_pdata);
 	omap3beagle_flash_init();
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 522ff62..30b25f7 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -297,6 +297,18 @@ static struct platform_device *omap3_evm_devices[] __initdata = {
 	&omap3evm_smc911x_device,
 };
 
+static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+
+	.port_mode[0] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+
+	.phy_reset  = true,
+	.reset_gpio_port[0]  = -EINVAL,
+	.reset_gpio_port[1]  = 135,
+	.reset_gpio_port[2]  = -EINVAL
+};
+
 static void __init omap3_evm_init(void)
 {
 	omap3_evm_i2c_init();
@@ -312,6 +324,9 @@ static void __init omap3_evm_init(void)
 	usb_nop_xceiv_register();
 #endif
 	usb_musb_init();
+	/* Setup EHCI phy reset padconfig */
+	omap_cfg_reg(AF4_34XX_GPIO135_OUT);
+	usb_ehci_init(&ehci_pdata);
 	ads7846_dev_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 5a38494..581a18d 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -387,6 +387,18 @@ static struct platform_device *omap3pandora_devices[] __initdata = {
 	&pandora_keys_gpio,
 };
 
+static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+
+	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[1] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+
+	.phy_reset  = true,
+	.reset_gpio_port[0]  = 16,
+	.reset_gpio_port[1]  = -EINVAL,
+	.reset_gpio_port[2]  = -EINVAL
+};
+
 static void __init omap3pandora_init(void)
 {
 	omap3pandora_i2c_init();
@@ -396,6 +408,7 @@ static void __init omap3pandora_init(void)
 	spi_register_board_info(omap3pandora_spi_board_info,
 			ARRAY_SIZE(omap3pandora_spi_board_info));
 	omap3pandora_ads7846_init();
+	usb_ehci_init(&ehci_pdata);
 	pandora_keys_gpio_init();
 	usb_musb_init();
 
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 461522c..92f3f3a 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -384,6 +384,18 @@ static struct platform_device *overo_devices[] __initdata = {
 	&overo_lcd_device,
 };
 
+static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+	.port_mode[0] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+
+	.phy_reset  = true,
+	.reset_gpio_port[0]  = -EINVAL,
+	.reset_gpio_port[1]  = OVERO_GPIO_USBH_NRESET,
+	.reset_gpio_port[2]  = -EINVAL
+};
+
+
 static void __init overo_init(void)
 {
 	overo_i2c_init();
@@ -391,6 +403,7 @@ static void __init overo_init(void)
 	omap_serial_init();
 	overo_flash_init();
 	usb_musb_init();
+	usb_ehci_init(&ehci_pdata);
 	overo_ads7846_init();
 	overo_init_smsc911x();
 
@@ -433,14 +446,6 @@ static void __init overo_init(void)
 	else
 		printk(KERN_ERR "could not obtain gpio for "
 					"OVERO_GPIO_USBH_CPEN\n");
-
-	if ((gpio_request(OVERO_GPIO_USBH_NRESET,
-			  "OVERO_GPIO_USBH_NRESET") == 0) &&
-	    (gpio_direction_output(OVERO_GPIO_USBH_NRESET, 1) == 0))
-		gpio_export(OVERO_GPIO_USBH_NRESET, 0);
-	else
-		printk(KERN_ERR "could not obtain gpio for "
-					"OVERO_GPIO_USBH_NRESET\n");
 }
 
 static void __init overo_map_io(void)
diff --git a/arch/arm/mach-omap2/usb-ehci.c b/arch/arm/mach-omap2/usb-ehci.c
new file mode 100644
index 0000000..e448abd
--- /dev/null
+++ b/arch/arm/mach-omap2/usb-ehci.c
@@ -0,0 +1,192 @@
+/*
+ * linux/arch/arm/mach-omap2/usb-ehci.c
+ *
+ * This file will contain the board specific details for the
+ * Synopsys EHCI host controller on OMAP3430
+ *
+ * Copyright (C) 2007 Texas Instruments
+ * Author: Vikram Pandita <vikram.pandita@ti.com>
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
+#include <plat/mux.h>
+
+#include <mach/hardware.h>
+#include <mach/irqs.h>
+#include <plat/usb.h>
+
+#if defined(CONFIG_USB_EHCI_HCD) || defined(CONFIG_USB_EHCI_HCD_MODULE)
+
+static struct resource ehci_resources[] = {
+	{
+		.start	= OMAP34XX_EHCI_BASE,
+		.end	= OMAP34XX_EHCI_BASE + SZ_1K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= OMAP34XX_UHH_CONFIG_BASE,
+		.end	= OMAP34XX_UHH_CONFIG_BASE + SZ_1K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= OMAP34XX_USBTLL_BASE,
+		.end	= OMAP34XX_USBTLL_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{         /* general IRQ */
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
+		.platform_data          = NULL,
+	},
+	.num_resources  = ARRAY_SIZE(ehci_resources),
+	.resource       = ehci_resources,
+};
+
+/* MUX settings for EHCI pins */
+/*
+ * setup_ehci_io_mux - initialize IO pad mux for USBHOST
+ */
+static void setup_ehci_io_mux(enum ehci_hcd_omap_mode *port_mode)
+{
+	switch (port_mode[0]) {
+	case EHCI_HCD_OMAP_MODE_PHY:
+		omap_cfg_reg(Y9_3430_USB1HS_PHY_STP);
+		omap_cfg_reg(Y8_3430_USB1HS_PHY_CLK);
+		omap_cfg_reg(AA14_3430_USB1HS_PHY_DIR);
+		omap_cfg_reg(AA11_3430_USB1HS_PHY_NXT);
+		omap_cfg_reg(W13_3430_USB1HS_PHY_DATA0);
+		omap_cfg_reg(W12_3430_USB1HS_PHY_DATA1);
+		omap_cfg_reg(W11_3430_USB1HS_PHY_DATA2);
+		omap_cfg_reg(Y11_3430_USB1HS_PHY_DATA3);
+		omap_cfg_reg(W9_3430_USB1HS_PHY_DATA4);
+		omap_cfg_reg(Y12_3430_USB1HS_PHY_DATA5);
+		omap_cfg_reg(W8_3430_USB1HS_PHY_DATA6);
+		omap_cfg_reg(Y13_3430_USB1HS_PHY_DATA7);
+		break;
+	case EHCI_HCD_OMAP_MODE_TLL:
+		omap_cfg_reg(Y9_3430_USB1HS_TLL_STP);
+		omap_cfg_reg(Y8_3430_USB1HS_TLL_CLK);
+		omap_cfg_reg(AA14_3430_USB1HS_TLL_DIR);
+		omap_cfg_reg(AA11_3430_USB1HS_TLL_NXT);
+		omap_cfg_reg(W13_3430_USB1HS_TLL_DATA0);
+		omap_cfg_reg(W12_3430_USB1HS_TLL_DATA1);
+		omap_cfg_reg(W11_3430_USB1HS_TLL_DATA2);
+		omap_cfg_reg(Y11_3430_USB1HS_TLL_DATA3);
+		omap_cfg_reg(W9_3430_USB1HS_TLL_DATA4);
+		omap_cfg_reg(Y12_3430_USB1HS_TLL_DATA5);
+		omap_cfg_reg(W8_3430_USB1HS_TLL_DATA6);
+		omap_cfg_reg(Y13_3430_USB1HS_TLL_DATA7);
+		break;
+	case EHCI_HCD_OMAP_MODE_UNKNOWN:
+		/* FALLTHROUGH */
+	default:
+		break;
+	}
+
+	switch (port_mode[1]) {
+	case EHCI_HCD_OMAP_MODE_PHY:
+		omap_cfg_reg(AA10_3430_USB2HS_PHY_STP);
+		omap_cfg_reg(AA8_3430_USB2HS_PHY_CLK);
+		omap_cfg_reg(AA9_3430_USB2HS_PHY_DIR);
+		omap_cfg_reg(AB11_3430_USB2HS_PHY_NXT);
+		omap_cfg_reg(AB10_3430_USB2HS_PHY_DATA0);
+		omap_cfg_reg(AB9_3430_USB2HS_PHY_DATA1);
+		omap_cfg_reg(W3_3430_USB2HS_PHY_DATA2);
+		omap_cfg_reg(T4_3430_USB2HS_PHY_DATA3);
+		omap_cfg_reg(T3_3430_USB2HS_PHY_DATA4);
+		omap_cfg_reg(R3_3430_USB2HS_PHY_DATA5);
+		omap_cfg_reg(R4_3430_USB2HS_PHY_DATA6);
+		omap_cfg_reg(T2_3430_USB2HS_PHY_DATA7);
+		break;
+	case EHCI_HCD_OMAP_MODE_TLL:
+		omap_cfg_reg(AA10_3430_USB2HS_TLL_STP);
+		omap_cfg_reg(AA8_3430_USB2HS_TLL_CLK);
+		omap_cfg_reg(AA9_3430_USB2HS_TLL_DIR);
+		omap_cfg_reg(AB11_3430_USB2HS_TLL_NXT);
+		omap_cfg_reg(AB10_3430_USB2HS_TLL_DATA0);
+		omap_cfg_reg(AB9_3430_USB2HS_TLL_DATA1);
+		omap_cfg_reg(W3_3430_USB2HS_TLL_DATA2);
+		omap_cfg_reg(T4_3430_USB2HS_TLL_DATA3);
+		omap_cfg_reg(T3_3430_USB2HS_TLL_DATA4);
+		omap_cfg_reg(R3_3430_USB2HS_TLL_DATA5);
+		omap_cfg_reg(R4_3430_USB2HS_TLL_DATA6);
+		omap_cfg_reg(T2_3430_USB2HS_TLL_DATA7);
+		break;
+	case EHCI_HCD_OMAP_MODE_UNKNOWN:
+		/* FALLTHROUGH */
+	default:
+		break;
+	}
+
+	switch (port_mode[2]) {
+	case EHCI_HCD_OMAP_MODE_PHY:
+		printk(KERN_WARNING "Port3 can't be used in PHY mode\n");
+		break;
+	case EHCI_HCD_OMAP_MODE_TLL:
+		omap_cfg_reg(AB3_3430_USB3HS_TLL_STP);
+		omap_cfg_reg(AA6_3430_USB3HS_TLL_CLK);
+		omap_cfg_reg(AA3_3430_USB3HS_TLL_DIR);
+		omap_cfg_reg(Y3_3430_USB3HS_TLL_NXT);
+		omap_cfg_reg(AA5_3430_USB3HS_TLL_DATA0);
+		omap_cfg_reg(Y4_3430_USB3HS_TLL_DATA1);
+		omap_cfg_reg(Y5_3430_USB3HS_TLL_DATA2);
+		omap_cfg_reg(W5_3430_USB3HS_TLL_DATA3);
+		omap_cfg_reg(AB12_3430_USB3HS_TLL_DATA4);
+		omap_cfg_reg(AB13_3430_USB3HS_TLL_DATA5);
+		omap_cfg_reg(AA13_3430_USB3HS_TLL_DATA6);
+		omap_cfg_reg(AA12_3430_USB3HS_TLL_DATA7);
+		break;
+	case EHCI_HCD_OMAP_MODE_UNKNOWN:
+		/* FALLTHROUGH */
+	default:
+		break;
+	}
+
+	return;
+}
+
+void __init usb_ehci_init(struct ehci_hcd_omap_platform_data *pdata)
+{
+	platform_device_add_data(&ehci_device, pdata, sizeof(*pdata));
+
+	/* Setup Pin IO MUX for EHCI */
+	if (cpu_is_omap34xx())
+		setup_ehci_io_mux(pdata->port_mode);
+
+	if (platform_device_register(&ehci_device) < 0) {
+		printk(KERN_ERR "Unable to register HS-USB (EHCI) device\n");
+		return;
+	}
+}
+
+#else
+
+void __init usb_ehci_init(struct ehci_hcd_omap_platform_data *pdata)
+
+{
+}
+
+#endif /* CONFIG_USB_EHCI_HCD */
+
diff --git a/arch/arm/plat-omap/include/plat/omap34xx.h b/arch/arm/plat-omap/include/plat/omap34xx.h
index f8d186a..4655707 100644
--- a/arch/arm/plat-omap/include/plat/omap34xx.h
+++ b/arch/arm/plat-omap/include/plat/omap34xx.h
@@ -74,8 +74,12 @@
 
 #define OMAP34XX_IVA_INTC_BASE	0x40000000
 #define OMAP34XX_HSUSB_OTG_BASE	(L4_34XX_BASE + 0xAB000)
-#define OMAP34XX_HSUSB_HOST_BASE	(L4_34XX_BASE + 0x64000)
 #define OMAP34XX_USBTLL_BASE	(L4_34XX_BASE + 0x62000)
+#define OMAP34XX_UHH_CONFIG_BASE	(L4_34XX_BASE + 0x64000)
+#define OMAP34XX_OHCI_BASE	(L4_34XX_BASE + 0x64400)
+#define OMAP34XX_EHCI_BASE	(L4_34XX_BASE + 0x64800)
+#define OMAP34XX_SR1_BASE	0x480C9000
+#define OMAP34XX_SR2_BASE	0x480CB000
 
 #define OMAP34XX_MAILBOX_BASE		(L4_34XX_BASE + 0x94000)
 

