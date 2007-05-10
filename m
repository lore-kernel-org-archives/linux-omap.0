From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH 2/2] ARM: OMAP: Support for HS-USB on 2430SDP
Date: Thu, 10 May 2007 11:34:07 -0700
Message-ID: <20070510183421.813124932@mvista.com>
References: <20070510183405.565400315@mvista.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline; filename=musb-fixups.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Currently only working in gadget mode.

Signed-off-by: Kevin Hilman <khilman@mvista.com>

---
 arch/arm/mach-omap2/Makefile            |    3 
 arch/arm/mach-omap2/board-2430sdp-usb.c |   69 ++++++++++++
 arch/arm/mach-omap2/board-2430sdp.c     |    2 
 drivers/usb/musb/omap2430.c             |    9 +
 drivers/usb/musb/omap2430.h             |    3 
 drivers/usb/musb/plat_uds.c             |    1 
 include/asm-arm/arch-omap/hdrc_cnf.h    |  177 ++++++++++++++++++++++++++++++++
 include/asm-arm/arch-omap/irqs.h        |    4 
 include/asm-arm/arch-omap/omap24xx.h    |    1 
 9 files changed, 267 insertions(+), 2 deletions(-)

Index: dev/arch/arm/mach-omap2/Makefile
===================================================================
--- dev.orig/arch/arm/mach-omap2/Makefile
+++ dev/arch/arm/mach-omap2/Makefile
@@ -21,7 +21,8 @@ mmu_mach-objs			:= mmu.o
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
 obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o
 obj-$(CONFIG_MACH_OMAP_2430SDP)		+= board-2430sdp.o \
-					   board-2430sdp-flash.o
+					   board-2430sdp-flash.o \
+					   board-2430sdp-usb.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o \
 					   board-apollon-keys.o
 obj-$(CONFIG_MACH_NOKIA_N800)		+= board-n800.o board-n800-flash.o \
Index: dev/arch/arm/mach-omap2/board-2430sdp-usb.c
===================================================================
--- /dev/null
+++ dev/arch/arm/mach-omap2/board-2430sdp-usb.c
@@ -0,0 +1,69 @@
+/*
+ * linux/arch/arm/mach-omap2/board-2430sdp-usb.c
+ *
+ * Copyright (C) 2007 MontaVista Software, Inc. <source@mvista.com>
+ * Author: Kevin Hilman
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
+#include <linux/usb/musb.h>
+
+#include <asm/arch/hardware.h>
+#include <asm/arch/usb.h>
+
+static struct resource musb_resources[] = {
+	[0] = {
+		.start	= OMAP243X_HS_BASE,
+		.end	= OMAP243X_HS_BASE + SZ_8K,
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
+static struct musb_hdrc_platform_data musb_plat = {
+#ifdef CONFIG_USB_MUSB_OTG
+	.mode		= MUSB_OTG,
+#elif CONFIG_USB_MUSB_HDRC_HCD
+	.mode		= MUSB_HOST,
+#elif CONFIG_USB_GADGET_MUSB_HDRC
+	.mode		= MUSB_PERIPHERAL,
+#endif
+	.multipoint	= 1,
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
+
+void __init sdp2430_usb_init(void)
+{
+	if (platform_device_register(&musb_device) < 0) {
+		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
+		return;
+	}
+}
+
Index: dev/arch/arm/mach-omap2/board-2430sdp.c
===================================================================
--- dev.orig/arch/arm/mach-omap2/board-2430sdp.c
+++ dev/arch/arm/mach-omap2/board-2430sdp.c
@@ -296,6 +296,7 @@ static int __init omap2430_i2c_init(void
 }
 
 extern void __init sdp2430_flash_init(void);
+extern void __init sdp2430_usb_init(void);
 
 static void __init omap_2430sdp_init(void)
 {
@@ -305,6 +306,7 @@ static void __init omap_2430sdp_init(voi
 	omap_serial_init();
 
 	sdp2430_flash_init();
+	sdp2430_usb_init();
 
 	spi_register_board_info(sdp2430_spi_board_info,
 				ARRAY_SIZE(sdp2430_spi_board_info));
Index: dev/drivers/usb/musb/omap2430.c
===================================================================
--- dev.orig/drivers/usb/musb/omap2430.c
+++ dev/drivers/usb/musb/omap2430.c
@@ -61,6 +61,12 @@ static void omap_vbus_power(struct musb 
 {
 }
 
+static void omap_set_vbus(struct musb *musb, int is_on)
+{
+	WARN_ON(is_on && is_peripheral_active(musb));
+	return omap_vbus_power(musb, is_on, 0);
+}
+
 int __init musb_platform_init(struct musb *musb)
 {
 	/* Erratum - reset value of STP has pull-down.
@@ -82,12 +88,13 @@ int __init musb_platform_init(struct mus
 			omap_readl(OTG_SYSSTATUS), omap_readl(OTG_INTERFSEL),
 			omap_readl(OTG_SIMENABLE));
 
+	musb->board_set_vbus = omap_set_vbus;
 	omap_vbus_power(musb, musb->board_mode == MUSB_HOST, 1);
 
 	return 0;
 }
 
-int __exit musb_platform_exit(struct musb *musb)
+int musb_platform_exit(struct musb *musb)
 {
 	omap_vbus_power(musb, 0 /*off*/, 1);
 	clk_disable(musb->clock);
Index: dev/drivers/usb/musb/omap2430.h
===================================================================
--- dev.orig/drivers/usb/musb/omap2430.h
+++ dev/drivers/usb/musb/omap2430.h
@@ -11,6 +11,9 @@
 #define __MUSB_OMAP243X_H__
 
 #ifdef CONFIG_ARCH_OMAP2430
+
+#include <asm/arch/usb.h>
+
 /*
  * OMAP2430-specific definitions
  */
Index: dev/drivers/usb/musb/plat_uds.c
===================================================================
--- dev.orig/drivers/usb/musb/plat_uds.c
+++ dev/drivers/usb/musb/plat_uds.c
@@ -1997,6 +1997,7 @@ static struct platform_driver musb_drive
 		.bus		= &platform_bus_type,
 		.owner		= THIS_MODULE,
 	},
+	.probe		= musb_probe,
 	.remove		= __devexit_p(musb_remove),
 	.shutdown	= musb_shutdown,
 	.suspend	= musb_suspend,
Index: dev/include/asm-arm/arch-omap/hdrc_cnf.h
===================================================================
--- /dev/null
+++ dev/include/asm-arm/arch-omap/hdrc_cnf.h
@@ -0,0 +1,177 @@
+/*
+ * Copyright 2005 Mentor Graphics Corporation
+ * USB High-Speed Multi-Point Dual-Role Controller Configuration
+ *
+ * Copyright Mentor Graphics Corporation and Licensors 2004
+ * Copyright (C) 2005 by Texas Instruments
+ *
+ * This file contains configuration constants for the (m)hdrc
+ * silicon as integrated into DaVinci CPUs.
+ */
+
+#ifndef	__ARCH_MUSB_HDRC_CNF
+#define	__ARCH_MUSB_HDRC_CNF
+
+/* ** Number of Tx endpoints ** */
+/* Legal values are 1 - 16 (this value includes EP0) */
+#define MUSB_C_NUM_EPT 8
+
+/* ** Number of Rx endpoints ** */
+/* Legal values are 1 - 16 (this value includes EP0) */
+#define MUSB_C_NUM_EPR 8
+
+/* ** Endpoint 1 to 15 direction types ** */
+/* C_EP1_DEF is defined if either Tx endpoint 1 or Rx endpoint 1 are used */
+#define MUSB_C_EP1_DEF
+
+/* C_EP1_TX_DEF is defined if Tx endpoint 1 is used */
+#define MUSB_C_EP1_TX_DEF
+
+/* C_EP1_RX_DEF is defined if Rx endpoint 1 is used */
+#define MUSB_C_EP1_RX_DEF
+
+/* C_EP1_TOR_DEF is defined if Tx endpoint 1 and Rx endpoint 1 share a FIFO */
+/*`define C_EP1_TOR_DEF */
+
+/* C_EP1_TAR_DEF is defined if both Tx endpoint 1 and Rx endpoint 1 are used */
+/* and do not share a FIFO */
+#define MUSB_C_EP1_TAR_DEF
+
+/* Similarly for all other used endpoints */
+#define MUSB_C_EP2_DEF
+#define MUSB_C_EP2_TX_DEF
+#define MUSB_C_EP2_RX_DEF
+#define MUSB_C_EP2_TAR_DEF
+#define MUSB_C_EP3_DEF
+#define MUSB_C_EP3_TX_DEF
+#define MUSB_C_EP3_RX_DEF
+#define MUSB_C_EP3_TAR_DEF
+#define MUSB_C_EP4_DEF
+#define MUSB_C_EP4_TX_DEF
+#define MUSB_C_EP4_RX_DEF
+#define MUSB_C_EP4_TAR_DEF
+#define MUSB_C_EP5_DEF
+#define MUSB_C_EP5_TX_DEF
+#define MUSB_C_EP5_RX_DEF
+#define MUSB_C_EP5_TAR_DEF
+#define MUSB_C_EP6_DEF
+#define MUSB_C_EP6_TX_DEF
+#define MUSB_C_EP6_RX_DEF
+#define MUSB_C_EP6_TAR_DEF
+#define MUSB_C_EP7_DEF
+#define MUSB_C_EP7_TX_DEF
+#define MUSB_C_EP7_RX_DEF
+#define MUSB_C_EP7_TAR_DEF
+
+/* ** Endpoint 1 to 15 FIFO address bits ** */
+/* Legal values are 3 to 13 - corresponding to FIFO sizes of 8 to 8192 bytes. */
+/* If an Tx endpoint shares a FIFO with an Rx endpoint then the Rx FIFO size */
+/* must be the same as the Tx FIFO size. */
+/* All endpoints 1 to 15 must be defined, unused endpoints should be set to 2. */
+#define MUSB_C_EP1T_BITS 10
+#define MUSB_C_EP1R_BITS 10
+#define MUSB_C_EP2T_BITS 9
+#define MUSB_C_EP2R_BITS 9
+#define MUSB_C_EP3T_BITS 3
+#define MUSB_C_EP3R_BITS 3
+#define MUSB_C_EP4T_BITS 3
+#define MUSB_C_EP4R_BITS 3
+#define MUSB_C_EP5T_BITS 3
+#define MUSB_C_EP5R_BITS 3
+#define MUSB_C_EP6T_BITS 3
+#define MUSB_C_EP6R_BITS 3
+#define MUSB_C_EP7T_BITS 3
+#define MUSB_C_EP7R_BITS 3
+#define MUSB_C_EP8T_BITS 2
+#define MUSB_C_EP8R_BITS 2
+#define MUSB_C_EP9T_BITS 2
+#define MUSB_C_EP9R_BITS 2
+#define MUSB_C_EP10T_BITS 2
+#define MUSB_C_EP10R_BITS 2
+#define MUSB_C_EP11T_BITS 2
+#define MUSB_C_EP11R_BITS 2
+#define MUSB_C_EP12T_BITS 2
+#define MUSB_C_EP12R_BITS 2
+#define MUSB_C_EP13T_BITS 2
+#define MUSB_C_EP13R_BITS 2
+#define MUSB_C_EP14T_BITS 2
+#define MUSB_C_EP14R_BITS 2
+#define MUSB_C_EP15T_BITS 2
+#define MUSB_C_EP15R_BITS 2
+
+/* Define the following constant if the USB2.0 Transceiver Macrocell data width is 16-bits. */
+/* `define C_UTM_16 */
+
+/* Define this constant if the CPU uses big-endian byte ordering. */
+/*`define C_BIGEND */
+
+/* Define the following constant if any Tx endpoint is required to support multiple bulk packets. */
+/* `define C_MP_TX */
+
+/* Define the following constant if any Rx endpoint is required to support multiple bulk packets. */
+/* `define C_MP_RX */
+
+/* Define the following constant if any Tx endpoint is required to support high bandwidth ISO. */
+/* `define C_HB_TX */
+
+/* Define the following constant if any Rx endpoint is required to support high bandwidth ISO. */
+/* `define C_HB_RX */
+
+/* Define the following constant if software connect/disconnect control is required. */
+#define MUSB_C_SOFT_CON
+
+/* Define the following constant if Vendor Control Registers are required. */
+/* `define C_VEND_REG */
+
+/* Vendor control register widths. */
+#define MUSB_C_VCTL_BITS 4
+#define MUSB_C_VSTAT_BITS 8
+
+
+/* Define the following constant to include a DMA controller. */
+#define MUSB_C_DMA
+
+/* Define the following constant if 2 or more DMA channels are required. */
+#define MUSB_C_DMA2
+
+/* Define the following constant if 3 or more DMA channels are required. */
+#define MUSB_C_DMA3
+
+/* Define the following constant if 4 or more DMA channels are required. */
+#define MUSB_C_DMA4
+
+/* Define the following constant if 5 or more DMA channels are required. */
+/*`define C_DMA5 */
+
+/* Define the following constant if 6 or more DMA channels are required. */
+/*`define C_DMA6 */
+
+/* Define the following constant if 7 or more DMA channels are required. */
+/*`define C_DMA7 */
+
+/* Define the following constant if 8 or more DMA channels are required. */
+/*`define C_DMA8 */
+
+
+/* ** Enable Dynamic FIFO Sizing ** */
+#define MUSB_C_DYNFIFO_DEF
+
+/* ** Derived constants ** */
+/* The following constants are derived from the previous configuration constants */
+
+/* Total number of endpoints
+ * Legal values are 2 - 16
+ * This must be equal to the larger of C_NUM_EPT, C_NUM_EPR
+ */
+#define MUSB_C_NUM_EPS 8
+
+/* C_EPMAX_BITS is equal to the largest endpoint FIFO word address bits */
+#define MUSB_C_EPMAX_BITS 12
+
+/* C_RAM_BITS is the number of address bits required to address the RAM (32-bit
+ * addresses).  It is defined as log2 of the sum of 2** of all the endpoint FIFO
+ * dword address bits (rounded up).
+ */
+#define MUSB_C_RAM_BITS 12
+
+#endif	/* __ARCH_MUSB_HDRC_CNF */
Index: dev/include/asm-arm/arch-omap/irqs.h
===================================================================
--- dev.orig/include/asm-arm/arch-omap/irqs.h
+++ dev/include/asm-arm/arch-omap/irqs.h
@@ -279,6 +279,10 @@
 #define INT_24XX_USB_IRQ_OTG	80
 #define INT_24XX_MMC_IRQ	83
 
+#define	INT_243X_HS_USB_MC	92
+#define	INT_243X_HS_USB_DMA	93
+#define	INT_243X_CARKIT		94
+
 /* Max. 128 level 2 IRQs (OMAP1610), 192 GPIOs (OMAP730) and
  * 16 MPUIO lines */
 #define OMAP_MAX_GPIO_LINES	192
Index: dev/include/asm-arm/arch-omap/omap24xx.h
===================================================================
--- dev.orig/include/asm-arm/arch-omap/omap24xx.h
+++ dev/include/asm-arm/arch-omap/omap24xx.h
@@ -34,6 +34,7 @@
 #define OMAP243X_GPMC_BASE	0x6E000000
 #define OMAP243X_SCM_BASE	(L4_WK_243X_BASE + 0x2000)
 #define OMAP24XX_CTRL_BASE	OMAP243X_SCM_BASE
+#define OMAP243X_HS_BASE	(L4_24XX_BASE + 0x000ac000)
 #endif
 
 /* DSP SS */

--
