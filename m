From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/4] omap: Move omap1 USB platform init code into
	mach-omap1/usb.c
Date: Tue, 29 Jun 2010 14:54:26 +0300
Message-ID: <20100629115426.17702.37783.stgit@baageli.muru.com>
References: <20100629115056.17702.56622.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54636 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755841Ab0F2LyP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jun 2010 07:54:15 -0400
In-Reply-To: <20100629115056.17702.56622.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Move omap1 FS USB platform init code into mach-omap1/usb.c

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/Makefile          |    3 
 arch/arm/mach-omap1/board-ams-delta.c |    2 
 arch/arm/mach-omap1/board-generic.c   |    4 
 arch/arm/mach-omap1/board-h2.c        |    2 
 arch/arm/mach-omap1/board-h3.c        |    2 
 arch/arm/mach-omap1/board-htcherald.c |    2 
 arch/arm/mach-omap1/board-innovator.c |    4 
 arch/arm/mach-omap1/board-nokia770.c  |    2 
 arch/arm/mach-omap1/board-osk.c       |    2 
 arch/arm/mach-omap1/board-palmte.c    |    2 
 arch/arm/mach-omap1/board-palmtt.c    |    2 
 arch/arm/mach-omap1/board-palmz71.c   |    2 
 arch/arm/mach-omap1/board-sx1.c       |    2 
 arch/arm/mach-omap1/board-voiceblue.c |    2 
 arch/arm/mach-omap1/usb.c             |  530 +++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/usb.h |   42 +++
 arch/arm/plat-omap/usb.c              |  535 ---------------------------------
 17 files changed, 589 insertions(+), 551 deletions(-)
 create mode 100644 arch/arm/mach-omap1/usb.c

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index ea231c7..facfaeb 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -23,6 +23,9 @@ obj-y					+= $(i2c-omap-m) $(i2c-omap-y)
 
 led-y := leds.o
 
+usb-fs-$(CONFIG_USB)			:= usb.o
+obj-y					+= $(usb-fs-m) $(usb-fs-y)
+
 # Specific board support
 obj-$(CONFIG_MACH_OMAP_H2)		+= board-h2.o board-h2-mmc.o
 obj-$(CONFIG_MACH_OMAP_INNOVATOR)	+= board-innovator.o
diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index fdd1dd5..c6a81ff 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -235,7 +235,7 @@ static void __init ams_delta_init(void)
 	/* Clear latch2 (NAND, LCD, modem enable) */
 	ams_delta_latch2_write(~0, 0);
 
-	omap_usb_init(&ams_delta_usb_config);
+	omap1_usb_init(&ams_delta_usb_config);
 	platform_add_devices(ams_delta_devices, ARRAY_SIZE(ams_delta_devices));
 
 #ifdef CONFIG_AMS_DELTA_FIQ
diff --git a/arch/arm/mach-omap1/board-generic.c b/arch/arm/mach-omap1/board-generic.c
index e1195a3..e9ed8bf 100644
--- a/arch/arm/mach-omap1/board-generic.c
+++ b/arch/arm/mach-omap1/board-generic.c
@@ -72,12 +72,12 @@ static void __init omap_generic_init(void)
 		omap_cfg_reg(UART3_TX);
 		omap_cfg_reg(UART3_RX);
 
-		omap_usb_init(&generic1510_usb_config);
+		omap1_usb_init(&generic1510_usb_config);
 	}
 #endif
 #if defined(CONFIG_ARCH_OMAP16XX)
 	if (!cpu_is_omap1510()) {
-		omap_usb_init(&generic1610_usb_config);
+		omap1_usb_init(&generic1610_usb_config);
 	}
 #endif
 
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index d1100e4..5f30188 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -452,7 +452,7 @@ static void __init h2_init(void)
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, h2_i2c_board_info,
 			      ARRAY_SIZE(h2_i2c_board_info));
-	omap_usb_init(&h2_usb_config);
+	omap1_usb_init(&h2_usb_config);
 	h2_mmc_init();
 }
 
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index a53ab82..0be1d3b 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -405,7 +405,7 @@ static void __init h3_init(void)
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, h3_i2c_board_info,
 			      ARRAY_SIZE(h3_i2c_board_info));
-	omap_usb_init(&h3_usb_config);
+	omap1_usb_init(&h3_usb_config);
 	h3_mmc_init();
 }
 
diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 8e313b4..736e4c2 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -287,7 +287,7 @@ static void __init htcherald_init(void)
 	htcherald_disable_watchdog();
 
 	htcherald_usb_enable();
-	omap_usb_init(&htcherald_usb_config);
+	omap1_usb_init(&htcherald_usb_config);
 }
 
 static void __init htcherald_init_irq(void)
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 5d12fd3..3c04e90 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -422,13 +422,13 @@ static void __init innovator_init(void)
 
 #ifdef CONFIG_ARCH_OMAP15XX
 	if (cpu_is_omap1510()) {
-		omap_usb_init(&innovator1510_usb_config);
+		omap1_usb_init(&innovator1510_usb_config);
 		innovator_config[1].data = &innovator1510_lcd_config;
 	}
 #endif
 #ifdef CONFIG_ARCH_OMAP16XX
 	if (cpu_is_omap1610()) {
-		omap_usb_init(&h2_usb_config);
+		omap1_usb_init(&h2_usb_config);
 		innovator_config[1].data = &innovator1610_lcd_config;
 	}
 #endif
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 71e1a3f..c9e9e37 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -386,7 +386,7 @@ static void __init omap_nokia770_init(void)
 	hwa742_dev_init();
 	ads7846_dev_init();
 	mipid_dev_init();
-	omap_usb_init(&nokia770_usb_config);
+	omap1_usb_init(&nokia770_usb_config);
 	nokia770_mmc_init();
 }
 
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 80d8620..b28c46a 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -560,7 +560,7 @@ static void __init osk_init(void)
 	l |= (3 << 1);
 	omap_writel(l, USB_TRANSCEIVER_CTRL);
 
-	omap_usb_init(&osk_usb_config);
+	omap1_usb_init(&osk_usb_config);
 
 	/* irq for tps65010 chip */
 	/* bootloader effectively does:  omap_cfg_reg(U19_1610_MPUIO1); */
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 569b4c9..51d5c4d 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -359,7 +359,7 @@ static void __init omap_palmte_init(void)
 	spi_register_board_info(palmte_spi_info, ARRAY_SIZE(palmte_spi_info));
 	palmte_misc_gpio_setup();
 	omap_serial_init();
-	omap_usb_init(&palmte_usb_config);
+	omap1_usb_init(&palmte_usb_config);
 	omap_register_i2c_bus(1, 100, NULL, 0);
 }
 
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index 6ad49a2..c0bcfc6 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -307,7 +307,7 @@ static void __init omap_palmtt_init(void)
 
 	spi_register_board_info(palmtt_boardinfo,ARRAY_SIZE(palmtt_boardinfo));
 	omap_serial_init();
-	omap_usb_init(&palmtt_usb_config);
+	omap1_usb_init(&palmtt_usb_config);
 	omap_register_i2c_bus(1, 100, NULL, 0);
 }
 
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index 6641de9..f431b44 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -325,7 +325,7 @@ omap_palmz71_init(void)
 
 	spi_register_board_info(palmz71_boardinfo,
 				ARRAY_SIZE(palmz71_boardinfo));
-	omap_usb_init(&palmz71_usb_config);
+	omap1_usb_init(&palmz71_usb_config);
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
 	palmz71_gpio_setup(0);
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 2fb1e5f..7b21190 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -392,7 +392,7 @@ static void __init omap_sx1_init(void)
 	omap_board_config_size = ARRAY_SIZE(sx1_config);
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
-	omap_usb_init(&sx1_usb_config);
+	omap1_usb_init(&sx1_usb_config);
 	sx1_mmc_init();
 
 	/* turn on USB power */
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 87b9436..7810754 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -198,7 +198,7 @@ static void __init voiceblue_init(void)
 	omap_board_config = voiceblue_config;
 	omap_board_config_size = ARRAY_SIZE(voiceblue_config);
 	omap_serial_init();
-	omap_usb_init(&voiceblue_usb_config);
+	omap1_usb_init(&voiceblue_usb_config);
 	omap_register_i2c_bus(1, 100, NULL, 0);
 
 	/* There is a good chance board is going up, so enable power LED
diff --git a/arch/arm/mach-omap1/usb.c b/arch/arm/mach-omap1/usb.c
new file mode 100644
index 0000000..19de03b
--- /dev/null
+++ b/arch/arm/mach-omap1/usb.c
@@ -0,0 +1,530 @@
+/*
+ * Platform level USB initialization for FS USB OTG controller on omap1 and 24xx
+ *
+ * Copyright (C) 2004 Texas Instruments, Inc.
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+
+#include <asm/irq.h>
+
+#include <plat/mux.h>
+#include <plat/usb.h>
+
+/* These routines should handle the standard chip-specific modes
+ * for usb0/1/2 ports, covering basic mux and transceiver setup.
+ *
+ * Some board-*.c files will need to set up additional mux options,
+ * like for suspend handling, vbus sensing, GPIOs, and the D+ pullup.
+ */
+
+/* TESTED ON:
+ *  - 1611B H2 (with usb1 mini-AB) using standard Mini-B or OTG cables
+ *  - 5912 OSK OHCI (with usb0 standard-A), standard A-to-B cables
+ *  - 5912 OSK UDC, with *nonstandard* A-to-A cable
+ *  - 1510 Innovator UDC with bundled usb0 cable
+ *  - 1510 Innovator OHCI with bundled usb1/usb2 cable
+ *  - 1510 Innovator OHCI with custom usb0 cable, feeding 5V VBUS
+ *  - 1710 custom development board using alternate pin group
+ *  - 1710 H3 (with usb1 mini-AB) using standard Mini-B or OTG cables
+ */
+
+#define INT_USB_IRQ_GEN		IH2_BASE + 20
+#define INT_USB_IRQ_NISO	IH2_BASE + 30
+#define INT_USB_IRQ_ISO		IH2_BASE + 29
+#define INT_USB_IRQ_HGEN	INT_USB_HHC_1
+#define INT_USB_IRQ_OTG		IH2_BASE + 8
+
+#ifdef	CONFIG_USB_GADGET_OMAP
+
+static struct resource udc_resources[] = {
+	/* order is significant! */
+	{		/* registers */
+		.start		= UDC_BASE,
+		.end		= UDC_BASE + 0xff,
+		.flags		= IORESOURCE_MEM,
+	}, {		/* general IRQ */
+		.start		= INT_USB_IRQ_GEN,
+		.flags		= IORESOURCE_IRQ,
+	}, {		/* PIO IRQ */
+		.start		= INT_USB_IRQ_NISO,
+		.flags		= IORESOURCE_IRQ,
+	}, {		/* SOF IRQ */
+		.start		= INT_USB_IRQ_ISO,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static u64 udc_dmamask = ~(u32)0;
+
+static struct platform_device udc_device = {
+	.name		= "omap_udc",
+	.id		= -1,
+	.dev = {
+		.dma_mask		= &udc_dmamask,
+		.coherent_dma_mask	= 0xffffffff,
+	},
+	.num_resources	= ARRAY_SIZE(udc_resources),
+	.resource	= udc_resources,
+};
+
+static inline void udc_device_init(struct omap_usb_config *pdata)
+{
+	/* IRQ numbers for omap7xx */
+	if(cpu_is_omap7xx()) {
+		udc_resources[1].start = INT_7XX_USB_GENI;
+		udc_resources[2].start = INT_7XX_USB_NON_ISO;
+		udc_resources[3].start = INT_7XX_USB_ISO;
+	}
+	pdata->udc_device = &udc_device;
+}
+
+#else
+
+static inline void udc_device_init(struct omap_usb_config *pdata)
+{
+}
+
+#endif
+
+#if	defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+
+/* The dmamask must be set for OHCI to work */
+static u64 ohci_dmamask = ~(u32)0;
+
+static struct resource ohci_resources[] = {
+	{
+		.start	= OMAP_OHCI_BASE,
+		.end	= OMAP_OHCI_BASE + 0xff,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_USB_IRQ_HGEN,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device ohci_device = {
+	.name			= "ohci",
+	.id			= -1,
+	.dev = {
+		.dma_mask		= &ohci_dmamask,
+		.coherent_dma_mask	= 0xffffffff,
+	},
+	.num_resources	= ARRAY_SIZE(ohci_resources),
+	.resource		= ohci_resources,
+};
+
+static inline void ohci_device_init(struct omap_usb_config *pdata)
+{
+	if (cpu_is_omap7xx())
+		ohci_resources[1].start = INT_7XX_USB_HHC_1;
+	pdata->ohci_device = &ohci_device;
+}
+
+#else
+
+static inline void ohci_device_init(struct omap_usb_config *pdata)
+{
+}
+
+#endif
+
+#if	defined(CONFIG_USB_OTG) && defined(CONFIG_ARCH_OMAP_OTG)
+
+static struct resource otg_resources[] = {
+	/* order is significant! */
+	{
+		.start		= OTG_BASE,
+		.end		= OTG_BASE + 0xff,
+		.flags		= IORESOURCE_MEM,
+	}, {
+		.start		= INT_USB_IRQ_OTG,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device otg_device = {
+	.name		= "omap_otg",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(otg_resources),
+	.resource	= otg_resources,
+};
+
+static inline void otg_device_init(struct omap_usb_config *pdata)
+{
+	if (cpu_is_omap7xx())
+		otg_resources[1].start = INT_7XX_USB_OTG;
+	pdata->otg_device = &otg_device;
+}
+
+#else
+
+static inline void otg_device_init(struct omap_usb_config *pdata)
+{
+}
+
+#endif
+
+u32 __init omap1_usb0_init(unsigned nwires, unsigned is_device)
+{
+	u32	syscon1 = 0;
+
+	if (nwires == 0) {
+		if (!cpu_is_omap15xx()) {
+			u32 l;
+
+			/* pulldown D+/D- */
+			l = omap_readl(USB_TRANSCEIVER_CTRL);
+			l &= ~(3 << 1);
+			omap_writel(l, USB_TRANSCEIVER_CTRL);
+		}
+		return 0;
+	}
+
+	if (is_device) {
+		if (cpu_is_omap7xx()) {
+			omap_cfg_reg(AA17_7XX_USB_DM);
+			omap_cfg_reg(W16_7XX_USB_PU_EN);
+			omap_cfg_reg(W17_7XX_USB_VBUSI);
+			omap_cfg_reg(W18_7XX_USB_DMCK_OUT);
+			omap_cfg_reg(W19_7XX_USB_DCRST);
+		} else
+			omap_cfg_reg(W4_USB_PUEN);
+	}
+
+	if (nwires == 2) {
+		u32 l;
+
+		// omap_cfg_reg(P9_USB_DP);
+		// omap_cfg_reg(R8_USB_DM);
+
+		if (cpu_is_omap15xx()) {
+			/* This works on 1510-Innovator */
+			return 0;
+		}
+
+		/* NOTES:
+		 *  - peripheral should configure VBUS detection!
+		 *  - only peripherals may use the internal D+/D- pulldowns
+		 *  - OTG support on this port not yet written
+		 */
+
+		/* Don't do this for omap7xx -- it causes USB to not work correctly */
+		if (!cpu_is_omap7xx()) {
+			l = omap_readl(USB_TRANSCEIVER_CTRL);
+			l &= ~(7 << 4);
+			if (!is_device)
+				l |= (3 << 1);
+			omap_writel(l, USB_TRANSCEIVER_CTRL);
+		}
+
+		return 3 << 16;
+	}
+
+	/* alternate pin config, external transceiver */
+	if (cpu_is_omap15xx()) {
+		printk(KERN_ERR "no usb0 alt pin config on 15xx\n");
+		return 0;
+	}
+
+	omap_cfg_reg(V6_USB0_TXD);
+	omap_cfg_reg(W9_USB0_TXEN);
+	omap_cfg_reg(W5_USB0_SE0);
+	if (nwires != 3)
+		omap_cfg_reg(Y5_USB0_RCV);
+
+	/* NOTE:  SPEED and SUSP aren't configured here.  OTG hosts
+	 * may be able to use I2C requests to set those bits along
+	 * with VBUS switching and overcurrent detection.
+	 */
+
+	if (nwires != 6) {
+		u32 l;
+
+		l = omap_readl(USB_TRANSCEIVER_CTRL);
+		l &= ~CONF_USB2_UNI_R;
+		omap_writel(l, USB_TRANSCEIVER_CTRL);
+	}
+
+	switch (nwires) {
+	case 3:
+		syscon1 = 2;
+		break;
+	case 4:
+		syscon1 = 1;
+		break;
+	case 6:
+		syscon1 = 3;
+		{
+			u32 l;
+
+			omap_cfg_reg(AA9_USB0_VP);
+			omap_cfg_reg(R9_USB0_VM);
+			l = omap_readl(USB_TRANSCEIVER_CTRL);
+			l |= CONF_USB2_UNI_R;
+			omap_writel(l, USB_TRANSCEIVER_CTRL);
+		}
+		break;
+	default:
+		printk(KERN_ERR "illegal usb%d %d-wire transceiver\n",
+			0, nwires);
+	}
+
+	return syscon1 << 16;
+}
+
+u32 __init omap1_usb1_init(unsigned nwires)
+{
+	u32	syscon1 = 0;
+
+	if (!cpu_is_omap15xx() && nwires != 6) {
+		u32 l;
+
+		l = omap_readl(USB_TRANSCEIVER_CTRL);
+		l &= ~CONF_USB1_UNI_R;
+		omap_writel(l, USB_TRANSCEIVER_CTRL);
+	}
+	if (nwires == 0)
+		return 0;
+
+	/* external transceiver */
+	omap_cfg_reg(USB1_TXD);
+	omap_cfg_reg(USB1_TXEN);
+	if (nwires != 3)
+		omap_cfg_reg(USB1_RCV);
+
+	if (cpu_is_omap15xx()) {
+		omap_cfg_reg(USB1_SEO);
+		omap_cfg_reg(USB1_SPEED);
+		// SUSP
+	} else if (cpu_is_omap1610() || cpu_is_omap5912()) {
+		omap_cfg_reg(W13_1610_USB1_SE0);
+		omap_cfg_reg(R13_1610_USB1_SPEED);
+		// SUSP
+	} else if (cpu_is_omap1710()) {
+		omap_cfg_reg(R13_1710_USB1_SE0);
+		// SUSP
+	} else {
+		pr_debug("usb%d cpu unrecognized\n", 1);
+		return 0;
+	}
+
+	switch (nwires) {
+	case 2:
+		goto bad;
+	case 3:
+		syscon1 = 2;
+		break;
+	case 4:
+		syscon1 = 1;
+		break;
+	case 6:
+		syscon1 = 3;
+		omap_cfg_reg(USB1_VP);
+		omap_cfg_reg(USB1_VM);
+		if (!cpu_is_omap15xx()) {
+			u32 l;
+
+			l = omap_readl(USB_TRANSCEIVER_CTRL);
+			l |= CONF_USB1_UNI_R;
+			omap_writel(l, USB_TRANSCEIVER_CTRL);
+		}
+		break;
+	default:
+bad:
+		printk(KERN_ERR "illegal usb%d %d-wire transceiver\n",
+			1, nwires);
+	}
+
+	return syscon1 << 20;
+}
+
+u32 __init omap1_usb2_init(unsigned nwires, unsigned alt_pingroup)
+{
+	u32	syscon1 = 0;
+
+	/* NOTE omap1 erratum: must leave USB2_UNI_R set if usb0 in use */
+	if (alt_pingroup || nwires == 0)
+		return 0;
+
+	if (!cpu_is_omap15xx() && nwires != 6) {
+		u32 l;
+
+		l = omap_readl(USB_TRANSCEIVER_CTRL);
+		l &= ~CONF_USB2_UNI_R;
+		omap_writel(l, USB_TRANSCEIVER_CTRL);
+	}
+
+	/* external transceiver */
+	if (cpu_is_omap15xx()) {
+		omap_cfg_reg(USB2_TXD);
+		omap_cfg_reg(USB2_TXEN);
+		omap_cfg_reg(USB2_SEO);
+		if (nwires != 3)
+			omap_cfg_reg(USB2_RCV);
+		/* there is no USB2_SPEED */
+	} else if (cpu_is_omap16xx()) {
+		omap_cfg_reg(V6_USB2_TXD);
+		omap_cfg_reg(W9_USB2_TXEN);
+		omap_cfg_reg(W5_USB2_SE0);
+		if (nwires != 3)
+			omap_cfg_reg(Y5_USB2_RCV);
+		// FIXME omap_cfg_reg(USB2_SPEED);
+	} else {
+		pr_debug("usb%d cpu unrecognized\n", 1);
+		return 0;
+	}
+
+	// omap_cfg_reg(USB2_SUSP);
+
+	switch (nwires) {
+	case 2:
+		goto bad;
+	case 3:
+		syscon1 = 2;
+		break;
+	case 4:
+		syscon1 = 1;
+		break;
+	case 5:
+		goto bad;
+	case 6:
+		syscon1 = 3;
+		if (cpu_is_omap15xx()) {
+			omap_cfg_reg(USB2_VP);
+			omap_cfg_reg(USB2_VM);
+		} else {
+			u32 l;
+
+			omap_cfg_reg(AA9_USB2_VP);
+			omap_cfg_reg(R9_USB2_VM);
+			l = omap_readl(USB_TRANSCEIVER_CTRL);
+			l |= CONF_USB2_UNI_R;
+			omap_writel(l, USB_TRANSCEIVER_CTRL);
+		}
+		break;
+	default:
+bad:
+		printk(KERN_ERR "illegal usb%d %d-wire transceiver\n",
+			2, nwires);
+	}
+
+	return syscon1 << 24;
+}
+
+#ifdef	CONFIG_ARCH_OMAP15XX
+
+/* ULPD_DPLL_CTRL */
+#define DPLL_IOB		(1 << 13)
+#define DPLL_PLL_ENABLE		(1 << 4)
+#define DPLL_LOCK		(1 << 0)
+
+/* ULPD_APLL_CTRL */
+#define APLL_NDPLL_SWITCH	(1 << 0)
+
+static void __init omap_1510_usb_init(struct omap_usb_config *config)
+{
+	unsigned int val;
+	u16 w;
+
+	config->usb0_init(config->pins[0], is_usb0_device(config));
+	config->usb1_init(config->pins[1]);
+	config->usb2_init(config->pins[2], 0);
+
+	val = omap_readl(MOD_CONF_CTRL_0) & ~(0x3f << 1);
+	val |= (config->hmc_mode << 1);
+	omap_writel(val, MOD_CONF_CTRL_0);
+
+	printk("USB: hmc %d", config->hmc_mode);
+	if (config->pins[0])
+		printk(", usb0 %d wires%s", config->pins[0],
+			is_usb0_device(config) ? " (dev)" : "");
+	if (config->pins[1])
+		printk(", usb1 %d wires", config->pins[1]);
+	if (config->pins[2])
+		printk(", usb2 %d wires", config->pins[2]);
+	printk("\n");
+
+	/* use DPLL for 48 MHz function clock */
+	pr_debug("APLL %04x DPLL %04x REQ %04x\n", omap_readw(ULPD_APLL_CTRL),
+			omap_readw(ULPD_DPLL_CTRL), omap_readw(ULPD_SOFT_REQ));
+
+	w = omap_readw(ULPD_APLL_CTRL);
+	w &= ~APLL_NDPLL_SWITCH;
+	omap_writew(w, ULPD_APLL_CTRL);
+
+	w = omap_readw(ULPD_DPLL_CTRL);
+	w |= DPLL_IOB | DPLL_PLL_ENABLE;
+	omap_writew(w, ULPD_DPLL_CTRL);
+
+	w = omap_readw(ULPD_SOFT_REQ);
+	w |= SOFT_UDC_REQ | SOFT_DPLL_REQ;
+	omap_writew(w, ULPD_SOFT_REQ);
+
+	while (!(omap_readw(ULPD_DPLL_CTRL) & DPLL_LOCK))
+		cpu_relax();
+
+#ifdef	CONFIG_USB_GADGET_OMAP
+	if (config->register_dev) {
+		int status;
+
+		udc_device.dev.platform_data = config;
+		status = platform_device_register(&udc_device);
+		if (status)
+			pr_debug("can't register UDC device, %d\n", status);
+		/* udc driver gates 48MHz by D+ pullup */
+	}
+#endif
+
+#if	defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+	if (config->register_host) {
+		int status;
+
+		ohci_device.dev.platform_data = config;
+		status = platform_device_register(&ohci_device);
+		if (status)
+			pr_debug("can't register OHCI device, %d\n", status);
+		/* hcd explicitly gates 48MHz */
+	}
+#endif
+}
+
+#else
+static inline void omap_1510_usb_init(struct omap_usb_config *config) {}
+#endif
+
+void __init omap1_usb_init(struct omap_usb_config *pdata)
+{
+	pdata->usb0_init = omap1_usb0_init;
+	pdata->usb1_init = omap1_usb1_init;
+	pdata->usb2_init = omap1_usb2_init;
+	udc_device_init(pdata);
+	ohci_device_init(pdata);
+	otg_device_init(pdata);
+
+	if (cpu_is_omap7xx() || cpu_is_omap16xx())
+		omap_otg_init(pdata);
+	else if (cpu_is_omap15xx())
+		omap_1510_usb_init(pdata);
+	else
+		printk(KERN_ERR "USB: No init for your chip yet\n");
+}
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index 9f79224..2a9427c 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -81,8 +81,28 @@ extern void usb_ohci_init(const struct ohci_hcd_omap_platform_data *pdata);
 
 #endif
 
+
+/*
+ * FIXME correct answer depends on hmc_mode,
+ * as does (on omap1) any nonzero value for config->otg port number
+ */
+#ifdef	CONFIG_USB_GADGET_OMAP
+#define	is_usb0_device(config)	1
+#else
+#define	is_usb0_device(config)	0
+#endif
+
 void omap_otg_init(struct omap_usb_config *config);
-void omap_usb_init(struct omap_usb_config *pdata);
+
+#if defined(CONFIG_USB) || defined(CONFIG_USB_MODULE)
+void omap1_usb_init(struct omap_usb_config *pdata);
+#else
+static inline void omap1_usb_init(struct omap_usb_config *pdata)
+{
+}
+#endif
+
+#if defined(CONFIG_ARCH_OMAP_OTG) || defined(CONFIG_ARCH_OMAP_OTG_MODULE)
 void omap2_usbfs_init(struct omap_usb_config *pdata);
 #else
 static inline omap2_usbfs_init(struct omap_usb_config *pdata)
@@ -199,4 +219,24 @@ static inline omap2_usbfs_init(struct omap_usb_config *pdata)
 #	define	USB0PUENACTLOI		(1 << 16)
 #	define	USBSTANDBYCTRL		(1 << 15)
 
+#if defined(CONFIG_ARCH_OMAP1) && defined(CONFIG_USB)
+u32 omap1_usb0_init(unsigned nwires, unsigned is_device);
+u32 omap1_usb1_init(unsigned nwires);
+u32 omap1_usb2_init(unsigned nwires, unsigned alt_pingroup);
+#else
+static inline u32 omap1_usb0_init(unsigned nwires, unsigned is_device)
+{
+	return 0;
+}
+static inline u32 omap1_usb1_init(unsigned nwires)
+{
+	return 0;
+
+}
+static inline u32 omap1_usb2_init(unsigned nwires, unsigned alt_pingroup)
+{
+	return 0;
+}
+#endif
+
 #endif	/* __ASM_ARCH_OMAP_USB_H */
diff --git a/arch/arm/plat-omap/usb.c b/arch/arm/plat-omap/usb.c
index 27b471c..f357088 100644
--- a/arch/arm/plat-omap/usb.c
+++ b/arch/arm/plat-omap/usb.c
@@ -22,434 +22,13 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/usb/otg.h>
 #include <linux/io.h>
 
-#include <asm/irq.h>
-#include <asm/system.h>
-#include <mach/hardware.h>
-
-#include <plat/control.h>
-#include <plat/mux.h>
 #include <plat/usb.h>
 #include <plat/board.h>
 
-#define INT_USB_IRQ_GEN		IH2_BASE + 20
-#define INT_USB_IRQ_NISO	IH2_BASE + 30
-#define INT_USB_IRQ_ISO		IH2_BASE + 29
-#define INT_USB_IRQ_HGEN	INT_USB_HHC_1
-#define INT_USB_IRQ_OTG		IH2_BASE + 8
-
-/* These routines should handle the standard chip-specific modes
- * for usb0/1/2 ports, covering basic mux and transceiver setup.
- *
- * Some board-*.c files will need to set up additional mux options,
- * like for suspend handling, vbus sensing, GPIOs, and the D+ pullup.
- */
-
-/* TESTED ON:
- *  - 1611B H2 (with usb1 mini-AB) using standard Mini-B or OTG cables
- *  - 5912 OSK OHCI (with usb0 standard-A), standard A-to-B cables
- *  - 5912 OSK UDC, with *nonstandard* A-to-A cable
- *  - 1510 Innovator UDC with bundled usb0 cable
- *  - 1510 Innovator OHCI with bundled usb1/usb2 cable
- *  - 1510 Innovator OHCI with custom usb0 cable, feeding 5V VBUS
- *  - 1710 custom development board using alternate pin group
- *  - 1710 H3 (with usb1 mini-AB) using standard Mini-B or OTG cables
- */
-
-/*-------------------------------------------------------------------------*/
-
-#if defined(CONFIG_ARCH_OMAP_OTG) || defined(CONFIG_ARCH_OMAP15XX)
-
-static u32 __init omap_usb0_init(unsigned nwires, unsigned is_device)
-{
-	u32	syscon1 = 0;
-
-	if (nwires == 0) {
-		if (!cpu_is_omap15xx()) {
-			u32 l;
-
-			/* pulldown D+/D- */
-			l = omap_readl(USB_TRANSCEIVER_CTRL);
-			l &= ~(3 << 1);
-			omap_writel(l, USB_TRANSCEIVER_CTRL);
-		}
-		return 0;
-	}
-
-	if (is_device) {
-		if (cpu_is_omap7xx()) {
-			omap_cfg_reg(AA17_7XX_USB_DM);
-			omap_cfg_reg(W16_7XX_USB_PU_EN);
-			omap_cfg_reg(W17_7XX_USB_VBUSI);
-			omap_cfg_reg(W18_7XX_USB_DMCK_OUT);
-			omap_cfg_reg(W19_7XX_USB_DCRST);
-		} else
-			omap_cfg_reg(W4_USB_PUEN);
-	}
-
-	if (nwires == 2) {
-		u32 l;
-
-		// omap_cfg_reg(P9_USB_DP);
-		// omap_cfg_reg(R8_USB_DM);
-
-		if (cpu_is_omap15xx()) {
-			/* This works on 1510-Innovator */
-			return 0;
-		}
-
-		/* NOTES:
-		 *  - peripheral should configure VBUS detection!
-		 *  - only peripherals may use the internal D+/D- pulldowns
-		 *  - OTG support on this port not yet written
-		 */
-
-		/* Don't do this for omap7xx -- it causes USB to not work correctly */
-		if (!cpu_is_omap7xx()) {
-			l = omap_readl(USB_TRANSCEIVER_CTRL);
-			l &= ~(7 << 4);
-			if (!is_device)
-				l |= (3 << 1);
-			omap_writel(l, USB_TRANSCEIVER_CTRL);
-		}
-
-		return 3 << 16;
-	}
-
-	/* alternate pin config, external transceiver */
-	if (cpu_is_omap15xx()) {
-		printk(KERN_ERR "no usb0 alt pin config on 15xx\n");
-		return 0;
-	}
-
-	omap_cfg_reg(V6_USB0_TXD);
-	omap_cfg_reg(W9_USB0_TXEN);
-	omap_cfg_reg(W5_USB0_SE0);
-	if (nwires != 3)
-		omap_cfg_reg(Y5_USB0_RCV);
-
-	/* NOTE:  SPEED and SUSP aren't configured here.  OTG hosts
-	 * may be able to use I2C requests to set those bits along
-	 * with VBUS switching and overcurrent detection.
-	 */
-
-	if (nwires != 6) {
-		u32 l;
-
-		l = omap_readl(USB_TRANSCEIVER_CTRL);
-		l &= ~CONF_USB2_UNI_R;
-		omap_writel(l, USB_TRANSCEIVER_CTRL);
-	}
-
-	switch (nwires) {
-	case 3:
-		syscon1 = 2;
-		break;
-	case 4:
-		syscon1 = 1;
-		break;
-	case 6:
-		syscon1 = 3;
-		{
-			u32 l;
-
-			omap_cfg_reg(AA9_USB0_VP);
-			omap_cfg_reg(R9_USB0_VM);
-			l = omap_readl(USB_TRANSCEIVER_CTRL);
-			l |= CONF_USB2_UNI_R;
-			omap_writel(l, USB_TRANSCEIVER_CTRL);
-		}
-		break;
-	default:
-		printk(KERN_ERR "illegal usb%d %d-wire transceiver\n",
-			0, nwires);
-	}
-	return syscon1 << 16;
-}
-
-static u32 __init omap_usb1_init(unsigned nwires)
-{
-	u32	syscon1 = 0;
-
-	if (!cpu_is_omap15xx() && nwires != 6) {
-		u32 l;
-
-		l = omap_readl(USB_TRANSCEIVER_CTRL);
-		l &= ~CONF_USB1_UNI_R;
-		omap_writel(l, USB_TRANSCEIVER_CTRL);
-	}
-	if (nwires == 0)
-		return 0;
-
-	/* external transceiver */
-	omap_cfg_reg(USB1_TXD);
-	omap_cfg_reg(USB1_TXEN);
-	if (nwires != 3)
-		omap_cfg_reg(USB1_RCV);
-
-	if (cpu_is_omap15xx()) {
-		omap_cfg_reg(USB1_SEO);
-		omap_cfg_reg(USB1_SPEED);
-		// SUSP
-	} else if (cpu_is_omap1610() || cpu_is_omap5912()) {
-		omap_cfg_reg(W13_1610_USB1_SE0);
-		omap_cfg_reg(R13_1610_USB1_SPEED);
-		// SUSP
-	} else if (cpu_is_omap1710()) {
-		omap_cfg_reg(R13_1710_USB1_SE0);
-		// SUSP
-	} else {
-		pr_debug("usb%d cpu unrecognized\n", 1);
-		return 0;
-	}
-
-	switch (nwires) {
-	case 2:
-		goto bad;
-	case 3:
-		syscon1 = 2;
-		break;
-	case 4:
-		syscon1 = 1;
-		break;
-	case 6:
-		syscon1 = 3;
-		omap_cfg_reg(USB1_VP);
-		omap_cfg_reg(USB1_VM);
-		if (!cpu_is_omap15xx()) {
-			u32 l;
-
-			l = omap_readl(USB_TRANSCEIVER_CTRL);
-			l |= CONF_USB1_UNI_R;
-			omap_writel(l, USB_TRANSCEIVER_CTRL);
-		}
-		break;
-	default:
-bad:
-		printk(KERN_ERR "illegal usb%d %d-wire transceiver\n",
-			1, nwires);
-	}
-	return syscon1 << 20;
-}
-
-static u32 __init omap_usb2_init(unsigned nwires, unsigned alt_pingroup)
-{
-	u32	syscon1 = 0;
-
-	/* NOTE omap1 erratum: must leave USB2_UNI_R set if usb0 in use */
-	if (alt_pingroup || nwires == 0)
-		return 0;
-
-	if (!cpu_is_omap15xx() && nwires != 6) {
-		u32 l;
-
-		l = omap_readl(USB_TRANSCEIVER_CTRL);
-		l &= ~CONF_USB2_UNI_R;
-		omap_writel(l, USB_TRANSCEIVER_CTRL);
-	}
-
-	/* external transceiver */
-	if (cpu_is_omap15xx()) {
-		omap_cfg_reg(USB2_TXD);
-		omap_cfg_reg(USB2_TXEN);
-		omap_cfg_reg(USB2_SEO);
-		if (nwires != 3)
-			omap_cfg_reg(USB2_RCV);
-		/* there is no USB2_SPEED */
-	} else if (cpu_is_omap16xx()) {
-		omap_cfg_reg(V6_USB2_TXD);
-		omap_cfg_reg(W9_USB2_TXEN);
-		omap_cfg_reg(W5_USB2_SE0);
-		if (nwires != 3)
-			omap_cfg_reg(Y5_USB2_RCV);
-		// FIXME omap_cfg_reg(USB2_SPEED);
-	} else {
-		pr_debug("usb%d cpu unrecognized\n", 1);
-		return 0;
-	}
-	// omap_cfg_reg(USB2_SUSP);
-
-	switch (nwires) {
-	case 2:
-		goto bad;
-	case 3:
-		syscon1 = 2;
-		break;
-	case 4:
-		syscon1 = 1;
-		break;
-	case 5:
-		goto bad;
-	case 6:
-		syscon1 = 3;
-		if (cpu_is_omap15xx()) {
-			omap_cfg_reg(USB2_VP);
-			omap_cfg_reg(USB2_VM);
-		} else {
-			u32 l;
-
-			omap_cfg_reg(AA9_USB2_VP);
-			omap_cfg_reg(R9_USB2_VM);
-			l = omap_readl(USB_TRANSCEIVER_CTRL);
-			l |= CONF_USB2_UNI_R;
-			omap_writel(l, USB_TRANSCEIVER_CTRL);
-		}
-		break;
-	default:
-bad:
-		printk(KERN_ERR "illegal usb%d %d-wire transceiver\n",
-			2, nwires);
-	}
-	return syscon1 << 24;
-}
-
-#else
-#define omap_usb0_init		NULL
-#define omap_usb1_init		NULL
-#define omap_usb2_init		NULL
-#endif
-
-/*-------------------------------------------------------------------------*/
-
-#ifdef	CONFIG_USB_GADGET_OMAP
-
-static struct resource udc_resources[] = {
-	/* order is significant! */
-	{		/* registers */
-		.start		= UDC_BASE,
-		.end		= UDC_BASE + 0xff,
-		.flags		= IORESOURCE_MEM,
-	}, {		/* general IRQ */
-		.start		= INT_USB_IRQ_GEN,
-		.flags		= IORESOURCE_IRQ,
-	}, {		/* PIO IRQ */
-		.start		= INT_USB_IRQ_NISO,
-		.flags		= IORESOURCE_IRQ,
-	}, {		/* SOF IRQ */
-		.start		= INT_USB_IRQ_ISO,
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-static u64 udc_dmamask = ~(u32)0;
-
-static struct platform_device udc_device = {
-	.name		= "omap_udc",
-	.id		= -1,
-	.dev = {
-		.dma_mask		= &udc_dmamask,
-		.coherent_dma_mask	= 0xffffffff,
-	},
-	.num_resources	= ARRAY_SIZE(udc_resources),
-	.resource	= udc_resources,
-};
-
-static inline void udc_device_init(struct omap_usb_config *pdata)
-{
-	pdata->udc_device = &udc_device;
-}
-
-#else
-
-static inline void udc_device_init(struct omap_usb_config *pdata)
-{
-}
-
-#endif
-
-#if	defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
-
-/* The dmamask must be set for OHCI to work */
-static u64 ohci_dmamask = ~(u32)0;
-
-static struct resource ohci_resources[] = {
-	{
-		.start	= OMAP_OHCI_BASE,
-		.end	= OMAP_OHCI_BASE + 0xff,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= INT_USB_IRQ_HGEN,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device ohci_device = {
-	.name			= "ohci",
-	.id			= -1,
-	.dev = {
-		.dma_mask		= &ohci_dmamask,
-		.coherent_dma_mask	= 0xffffffff,
-	},
-	.num_resources	= ARRAY_SIZE(ohci_resources),
-	.resource		= ohci_resources,
-};
-
-static inline void ohci_device_init(struct omap_usb_config *pdata)
-{
-	pdata->ohci_device = &ohci_device;
-}
-
-#else
-
-static inline void ohci_device_init(struct omap_usb_config *pdata)
-{
-}
-
-#endif
-
-#if	defined(CONFIG_USB_OTG) && defined(CONFIG_ARCH_OMAP_OTG)
-
-static struct resource otg_resources[] = {
-	/* order is significant! */
-	{
-		.start		= OTG_BASE,
-		.end		= OTG_BASE + 0xff,
-		.flags		= IORESOURCE_MEM,
-	}, {
-		.start		= INT_USB_IRQ_OTG,
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device otg_device = {
-	.name		= "omap_otg",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(otg_resources),
-	.resource	= otg_resources,
-};
-
-static inline void otg_device_init(struct omap_usb_config *pdata)
-{
-	pdata->otg_device = &otg_device;
-}
-
-#else
-
-static inline void otg_device_init(struct omap_usb_config *pdata)
-{
-}
-
-#endif
-
-/*-------------------------------------------------------------------------*/
-
-// FIXME correct answer depends on hmc_mode,
-// as does (on omap1) any nonzero value for config->otg port number
-#ifdef	CONFIG_USB_GADGET_OMAP
-#define	is_usb0_device(config)	1
-#else
-#define	is_usb0_device(config)	0
-#endif
-
-/*-------------------------------------------------------------------------*/
-
 #ifdef	CONFIG_ARCH_OMAP_OTG
 
 void __init
@@ -524,12 +103,6 @@ omap_otg_init(struct omap_usb_config *config)
 
 		syscon &= ~DEV_IDLE_EN;
 		udc_device->dev.platform_data = config;
-		/* IRQ numbers for omap7xx */
-		if(cpu_is_omap7xx()) {
-			udc_resources[1].start = INT_7XX_USB_GENI;
-			udc_resources[2].start = INT_7XX_USB_NON_ISO;
-			udc_resources[3].start = INT_7XX_USB_ISO;
-		}
 		status = platform_device_register(udc_device);
 		if (status)
 			pr_debug("can't register UDC device, %d\n", status);
@@ -542,8 +115,6 @@ omap_otg_init(struct omap_usb_config *config)
 
 		syscon &= ~HST_IDLE_EN;
 		ohci_device->dev.platform_data = config;
-		if (cpu_is_omap7xx())
-			ohci_resources[1].start = INT_7XX_USB_HHC_1;
 		status = platform_device_register(ohci_device);
 		if (status)
 			pr_debug("can't register OHCI device, %d\n", status);
@@ -556,8 +127,6 @@ omap_otg_init(struct omap_usb_config *config)
 
 		syscon &= ~OTG_IDLE_EN;
 		otg_device->dev.platform_data = config;
-		if (cpu_is_omap7xx())
-			otg_resources[1].start = INT_7XX_USB_OTG;
 		status = platform_device_register(otg_device);
 		if (status)
 			pr_debug("can't register OTG device, %d\n", status);
@@ -572,107 +141,3 @@ omap_otg_init(struct omap_usb_config *config)
 #else
 void omap_otg_init(struct omap_usb_config *config) {}
 #endif
-
-/*-------------------------------------------------------------------------*/
-
-#ifdef	CONFIG_ARCH_OMAP15XX
-
-/* ULPD_DPLL_CTRL */
-#define DPLL_IOB		(1 << 13)
-#define DPLL_PLL_ENABLE		(1 << 4)
-#define DPLL_LOCK		(1 << 0)
-
-/* ULPD_APLL_CTRL */
-#define APLL_NDPLL_SWITCH	(1 << 0)
-
-
-static void __init omap_1510_usb_init(struct omap_usb_config *config)
-{
-	unsigned int val;
-	u16 w;
-
-	config->usb0_init(config->pins[0], is_usb0_device(config));
-	config->usb1_init(config->pins[1]);
-	config->usb2_init(config->pins[2], 0);
-
-	val = omap_readl(MOD_CONF_CTRL_0) & ~(0x3f << 1);
-	val |= (config->hmc_mode << 1);
-	omap_writel(val, MOD_CONF_CTRL_0);
-
-	printk("USB: hmc %d", config->hmc_mode);
-	if (config->pins[0])
-		printk(", usb0 %d wires%s", config->pins[0],
-			is_usb0_device(config) ? " (dev)" : "");
-	if (config->pins[1])
-		printk(", usb1 %d wires", config->pins[1]);
-	if (config->pins[2])
-		printk(", usb2 %d wires", config->pins[2]);
-	printk("\n");
-
-	/* use DPLL for 48 MHz function clock */
-	pr_debug("APLL %04x DPLL %04x REQ %04x\n", omap_readw(ULPD_APLL_CTRL),
-			omap_readw(ULPD_DPLL_CTRL), omap_readw(ULPD_SOFT_REQ));
-
-	w = omap_readw(ULPD_APLL_CTRL);
-	w &= ~APLL_NDPLL_SWITCH;
-	omap_writew(w, ULPD_APLL_CTRL);
-
-	w = omap_readw(ULPD_DPLL_CTRL);
-	w |= DPLL_IOB | DPLL_PLL_ENABLE;
-	omap_writew(w, ULPD_DPLL_CTRL);
-
-	w = omap_readw(ULPD_SOFT_REQ);
-	w |= SOFT_UDC_REQ | SOFT_DPLL_REQ;
-	omap_writew(w, ULPD_SOFT_REQ);
-
-	while (!(omap_readw(ULPD_DPLL_CTRL) & DPLL_LOCK))
-		cpu_relax();
-
-#ifdef	CONFIG_USB_GADGET_OMAP
-	if (config->register_dev) {
-		int status;
-
-		udc_device.dev.platform_data = config;
-		status = platform_device_register(&udc_device);
-		if (status)
-			pr_debug("can't register UDC device, %d\n", status);
-		/* udc driver gates 48MHz by D+ pullup */
-	}
-#endif
-
-#if	defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
-	if (config->register_host) {
-		int status;
-
-		ohci_device.dev.platform_data = config;
-		status = platform_device_register(&ohci_device);
-		if (status)
-			pr_debug("can't register OHCI device, %d\n", status);
-		/* hcd explicitly gates 48MHz */
-	}
-#endif
-}
-
-#else
-static inline void omap_1510_usb_init(struct omap_usb_config *config) {}
-#endif
-
-/*-------------------------------------------------------------------------*/
-
-void __init omap_usb_init(struct omap_usb_config *pdata)
-{
-	pdata->usb0_init = omap_usb0_init;
-	pdata->usb1_init = omap_usb1_init;
-	pdata->usb2_init = omap_usb2_init;
-	udc_device_init(pdata);
-	ohci_device_init(pdata);
-	otg_device_init(pdata);
-
-	if (cpu_is_omap7xx() || cpu_is_omap16xx())
-		omap_otg_init(pdata);
-	else if (cpu_is_omap15xx())
-		omap_1510_usb_init(pdata);
-	else
-		printk(KERN_ERR "USB: No init for your chip yet\n");
-}
-

