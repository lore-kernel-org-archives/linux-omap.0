From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/4] ARM: OMAP2: Remove legacy USB FS support
Date: Mon, 21 May 2012 12:01:06 -0700
Message-ID: <20120521190106.927.57764.stgit@muffinssi.local>
References: <20120521185323.927.88012.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:13225 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703Ab2EUTBI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 May 2012 15:01:08 -0400
In-Reply-To: <20120521185323.927.88012.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kyungmin Park <kyungmin.park@samsung.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>

The FS (Full Speed) USB controller is available on 2420 and 2430,
but not being used.

Out of the 2420 based boards only Nokia N8X0 are seeing active
development and they have external HS (High Speed) TUSB controller.
On omap 2430sdp there is MUSB HS controller, so there's no need
to use the legacy USB FS controller.

That leaves only H4 and Apollon boards that could use the FS USB
controller. As both H4 and Apollon boards are old proprietary
development boards, it's unlikely that we have any active
developers working on those boards using the USB.

So remove the FS USB support for omap2 machines. Patches are
welcome if somebody wants to instead fix it all up to the
current standards.

Cc: linux-usb@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig         |    2 
 arch/arm/mach-omap2/Makefile        |    3 
 arch/arm/mach-omap2/board-2430sdp.c |   11 -
 arch/arm/mach-omap2/board-apollon.c |   18 --
 arch/arm/mach-omap2/board-h4.c      |   13 -
 arch/arm/mach-omap2/usb-fs.c        |  359 -----------------------------------
 6 files changed, 406 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/usb-fs.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 0e4dd67..042f157 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -64,13 +64,11 @@ config SOC_OMAP2420
 	depends on ARCH_OMAP2
 	default y
 	select OMAP_DM_TIMER
-	select ARCH_OMAP_OTG
 
 config SOC_OMAP2430
 	bool "OMAP2430 support"
 	depends on ARCH_OMAP2
 	default y
-	select ARCH_OMAP_OTG
 
 config SOC_OMAP3430
 	bool "OMAP3430 support"
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index fa742f3..664224f 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -244,9 +244,6 @@ obj-y					+= $(omap-flash-y) $(omap-flash-m)
 omap-hsmmc-$(CONFIG_MMC_OMAP_HS)	:= hsmmc.o
 obj-y					+= $(omap-hsmmc-m) $(omap-hsmmc-y)
 
-
-usbfs-$(CONFIG_ARCH_OMAP_OTG)		:= usb-fs.o
-obj-y					+= $(usbfs-m) $(usbfs-y)
 obj-y					+= usb-musb.o
 obj-y					+= omap_phy_internal.o
 
diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 99ca6ba..6523aea 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -254,16 +254,6 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 	{}	/* Terminator */
 };
 
-static struct omap_usb_config sdp2430_usb_config __initdata = {
-	.otg		= 1,
-#ifdef  CONFIG_USB_GADGET_OMAP
-	.hmc_mode	= 0x0,
-#elif   defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
-	.hmc_mode	= 0x1,
-#endif
-	.pins[0]	= 3,
-};
-
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
@@ -280,7 +270,6 @@ static void __init omap_2430sdp_init(void)
 	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);
 	omap_hsmmc_init(mmc);
-	omap2_usbfs_init(&sdp2430_usb_config);
 
 	omap_mux_init_signal("usb0hs_stp", OMAP_PULL_ENA | OMAP_PULL_UP);
 	usb_musb_init(NULL);
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 502c31e..519bcd3 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -35,7 +35,6 @@
 #include <asm/mach/flash.h>
 
 #include <plat/led.h>
-#include <plat/usb.h>
 #include <plat/board.h>
 #include "common.h"
 #include <plat/gpmc.h>
@@ -253,13 +252,6 @@ out:
 	clk_put(gpmc_fck);
 }
 
-static struct omap_usb_config apollon_usb_config __initdata = {
-	.register_dev	= 1,
-	.hmc_mode	= 0x14,	/* 0:dev 1:host1 2:disable */
-
-	.pins[0]	= 6,
-};
-
 static struct panel_generic_dpi_data apollon_panel_data = {
 	.name			= "apollon",
 };
@@ -297,15 +289,6 @@ static void __init apollon_led_init(void)
 	gpio_request_array(apollon_gpio_leds, ARRAY_SIZE(apollon_gpio_leds));
 }
 
-static void __init apollon_usb_init(void)
-{
-	/* USB device */
-	/* DEVICE_SUSPEND */
-	omap_mux_init_signal("mcbsp2_clkx.gpio_12", 0);
-	gpio_request_one(12, GPIOF_OUT_INIT_LOW, "USB suspend");
-	omap2_usbfs_init(&apollon_usb_config);
-}
-
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
@@ -321,7 +304,6 @@ static void __init omap_apollon_init(void)
 	apollon_init_smc91x();
 	apollon_led_init();
 	apollon_flash_init();
-	apollon_usb_init();
 
 	/* REVISIT: where's the correct place */
 	omap_mux_init_signal("sys_nirq", OMAP_PULL_ENA | OMAP_PULL_UP);
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 876becf..ace2048 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -32,7 +32,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/usb.h>
 #include <plat/board.h>
 #include "common.h"
 #include <plat/menelaus.h>
@@ -329,17 +328,6 @@ static void __init h4_init_flash(void)
 	h4_flash_resource.end	= base + SZ_64M - 1;
 }
 
-static struct omap_usb_config h4_usb_config __initdata = {
-	/* S1.10 OFF -- usb "download port"
-	 * usb0 switched to Mini-B port and isp1105 transceiver;
-	 * S2.POS3 = ON, S2.POS4 = OFF ... to enable battery charging
-	 */
-	.register_dev	= 1,
-	.pins[0]	= 3,
-/*	.hmc_mode	= 0x14,*/	/* 0:dev 1:host 2:disable */
-	.hmc_mode	= 0x00,		/* 0:dev|otg 1:disable 2:disable */
-};
-
 static struct at24_platform_data m24c01 = {
 	.byte_len	= SZ_1K / 8,
 	.page_size	= 16,
@@ -381,7 +369,6 @@ static void __init omap_h4_init(void)
 			ARRAY_SIZE(h4_i2c_board_info));
 
 	platform_add_devices(h4_devices, ARRAY_SIZE(h4_devices));
-	omap2_usbfs_init(&h4_usb_config);
 	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);
 	h4_init_flash();
diff --git a/arch/arm/mach-omap2/usb-fs.c b/arch/arm/mach-omap2/usb-fs.c
deleted file mode 100644
index 1481078..0000000
--- a/arch/arm/mach-omap2/usb-fs.c
+++ /dev/null
@@ -1,359 +0,0 @@
-/*
- * Platform level USB initialization for FS USB OTG controller on omap1 and 24xx
- *
- * Copyright (C) 2004 Texas Instruments, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/clk.h>
-#include <linux/err.h>
-
-#include <asm/irq.h>
-
-#include <plat/usb.h>
-#include <plat/board.h>
-
-#include "control.h"
-#include "mux.h"
-
-#define INT_USB_IRQ_GEN		INT_24XX_USB_IRQ_GEN
-#define INT_USB_IRQ_NISO	INT_24XX_USB_IRQ_NISO
-#define INT_USB_IRQ_ISO		INT_24XX_USB_IRQ_ISO
-#define INT_USB_IRQ_HGEN	INT_24XX_USB_IRQ_HGEN
-#define INT_USB_IRQ_OTG		INT_24XX_USB_IRQ_OTG
-
-#if defined(CONFIG_ARCH_OMAP2)
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
-static void omap2_usb_devconf_clear(u8 port, u32 mask)
-{
-	u32 r;
-
-	r = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
-	r &= ~USBTXWRMODEI(port, mask);
-	omap_ctrl_writel(r, OMAP2_CONTROL_DEVCONF0);
-}
-
-static void omap2_usb_devconf_set(u8 port, u32 mask)
-{
-	u32 r;
-
-	r = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
-	r |= USBTXWRMODEI(port, mask);
-	omap_ctrl_writel(r, OMAP2_CONTROL_DEVCONF0);
-}
-
-static void omap2_usb2_disable_5pinbitll(void)
-{
-	u32 r;
-
-	r = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
-	r &= ~(USBTXWRMODEI(2, USB_BIDIR_TLL) | USBT2TLL5PI);
-	omap_ctrl_writel(r, OMAP2_CONTROL_DEVCONF0);
-}
-
-static void omap2_usb2_enable_5pinunitll(void)
-{
-	u32 r;
-
-	r = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
-	r |= USBTXWRMODEI(2, USB_UNIDIR_TLL) | USBT2TLL5PI;
-	omap_ctrl_writel(r, OMAP2_CONTROL_DEVCONF0);
-}
-
-static u32 __init omap2_usb0_init(unsigned nwires, unsigned is_device)
-{
-	u32	syscon1 = 0;
-
-	omap2_usb_devconf_clear(0, USB_BIDIR_TLL);
-
-	if (nwires == 0)
-		return 0;
-
-	if (is_device)
-		omap_mux_init_signal("usb0_puen", 0);
-
-	omap_mux_init_signal("usb0_dat", 0);
-	omap_mux_init_signal("usb0_txen", 0);
-	omap_mux_init_signal("usb0_se0", 0);
-	if (nwires != 3)
-		omap_mux_init_signal("usb0_rcv", 0);
-
-	switch (nwires) {
-	case 3:
-		syscon1 = 2;
-		omap2_usb_devconf_set(0, USB_BIDIR);
-		break;
-	case 4:
-		syscon1 = 1;
-		omap2_usb_devconf_set(0, USB_BIDIR);
-		break;
-	case 6:
-		syscon1 = 3;
-		omap_mux_init_signal("usb0_vp", 0);
-		omap_mux_init_signal("usb0_vm", 0);
-		omap2_usb_devconf_set(0, USB_UNIDIR);
-		break;
-	default:
-		printk(KERN_ERR "illegal usb%d %d-wire transceiver\n",
-			0, nwires);
-	}
-
-	return syscon1 << 16;
-}
-
-static u32 __init omap2_usb1_init(unsigned nwires)
-{
-	u32	syscon1 = 0;
-
-	omap2_usb_devconf_clear(1, USB_BIDIR_TLL);
-
-	if (nwires == 0)
-		return 0;
-
-	/* NOTE:  board-specific code must set up pin muxing for usb1,
-	 * since each signal could come out on either of two balls.
-	 */
-
-	switch (nwires) {
-	case 2:
-		/* NOTE: board-specific code must override this setting if
-		 * this TLL link is not using DP/DM
-		 */
-		syscon1 = 1;
-		omap2_usb_devconf_set(1, USB_BIDIR_TLL);
-		break;
-	case 3:
-		syscon1 = 2;
-		omap2_usb_devconf_set(1, USB_BIDIR);
-		break;
-	case 4:
-		syscon1 = 1;
-		omap2_usb_devconf_set(1, USB_BIDIR);
-		break;
-	case 6:
-	default:
-		printk(KERN_ERR "illegal usb%d %d-wire transceiver\n",
-			1, nwires);
-	}
-
-	return syscon1 << 20;
-}
-
-static u32 __init omap2_usb2_init(unsigned nwires, unsigned alt_pingroup)
-{
-	u32	syscon1 = 0;
-
-	omap2_usb2_disable_5pinbitll();
-	alt_pingroup = 0;
-
-	/* NOTE omap1 erratum: must leave USB2_UNI_R set if usb0 in use */
-	if (alt_pingroup || nwires == 0)
-		return 0;
-
-	omap_mux_init_signal("usb2_dat", 0);
-	omap_mux_init_signal("usb2_se0", 0);
-	if (nwires > 2)
-		omap_mux_init_signal("usb2_txen", 0);
-	if (nwires > 3)
-		omap_mux_init_signal("usb2_rcv", 0);
-
-	switch (nwires) {
-	case 2:
-		/* NOTE: board-specific code must override this setting if
-		 * this TLL link is not using DP/DM
-		 */
-		syscon1 = 1;
-		omap2_usb_devconf_set(2, USB_BIDIR_TLL);
-		break;
-	case 3:
-		syscon1 = 2;
-		omap2_usb_devconf_set(2, USB_BIDIR);
-		break;
-	case 4:
-		syscon1 = 1;
-		omap2_usb_devconf_set(2, USB_BIDIR);
-		break;
-	case 5:
-		/* NOTE: board-specific code must mux this setting depending
-		 * on TLL link using DP/DM.  Something must also
-		 * set up OTG_SYSCON2.HMC_TLL{ATTACH,SPEED}
-		 * 2420: hdq_sio.usb2_tllse0 or vlynq_rx0.usb2_tllse0
-		 * 2430: hdq_sio.usb2_tllse0 or sdmmc2_dat0.usb2_tllse0
-		 */
-
-		syscon1 = 3;
-		omap2_usb2_enable_5pinunitll();
-		break;
-	case 6:
-	default:
-		printk(KERN_ERR "illegal usb%d %d-wire transceiver\n",
-			2, nwires);
-	}
-
-	return syscon1 << 24;
-}
-
-void __init omap2_usbfs_init(struct omap_usb_config *pdata)
-{
-	struct clk *ick;
-
-	if (!cpu_is_omap24xx())
-		return;
-
-	ick = clk_get(NULL, "usb_l4_ick");
-	if (IS_ERR(ick))
-		return;
-
-	clk_enable(ick);
-	pdata->usb0_init = omap2_usb0_init;
-	pdata->usb1_init = omap2_usb1_init;
-	pdata->usb2_init = omap2_usb2_init;
-	udc_device_init(pdata);
-	ohci_device_init(pdata);
-	otg_device_init(pdata);
-	omap_otg_init(pdata);
-	clk_disable(ick);
-	clk_put(ick);
-}
-
-#endif

