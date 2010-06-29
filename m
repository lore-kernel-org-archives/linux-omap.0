From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/4] omap: Move omap2 FS USB platform init code into
	mach-omap2/usb-fs.c
Date: Tue, 29 Jun 2010 14:54:17 +0300
Message-ID: <20100629115417.17702.81009.stgit@baageli.muru.com>
References: <20100629115056.17702.56622.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54537 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755841Ab0F2LyI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jun 2010 07:54:08 -0400
In-Reply-To: <20100629115056.17702.56622.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org

Move omap2 FS USB platform init code into mach-omap2/usb-fs.c. This will
allow further work later on to use omap hwmod for initializing the
device.

Cc: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile            |    2 
 arch/arm/mach-omap2/board-2430sdp.c     |    2 
 arch/arm/mach-omap2/board-apollon.c     |    2 
 arch/arm/mach-omap2/board-h4.c          |    2 
 arch/arm/mach-omap2/usb-fs.c            |  345 +++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/board.h |    8 +
 arch/arm/plat-omap/include/plat/usb.h   |    7 +
 arch/arm/plat-omap/usb.c                |  267 ++++++------------------
 8 files changed, 429 insertions(+), 206 deletions(-)
 create mode 100644 arch/arm/mach-omap2/usb-fs.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index ea52b03..0416643 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -146,6 +146,8 @@ obj-$(CONFIG_MACH_OMAP3517EVM)		+= board-am3517evm.o
 obj-$(CONFIG_MACH_SBC3530)		+= board-omap3stalker.o \
 					   hsmmc.o
 # Platform specific device init code
+usbfs-$(CONFIG_ARCH_OMAP_OTG)		:= usb-fs.o
+obj-y					+= $(usbfs-m) $(usbfs-y)
 obj-y					+= usb-musb.o
 obj-$(CONFIG_MACH_OMAP2_TUSB6010)	+= usb-tusb6010.o
 obj-y					+= usb-ehci.o
diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index a11a575..ec920c9 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -226,7 +226,7 @@ static void __init omap_2430sdp_init(void)
 	platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
 	omap_serial_init();
 	omap2_hsmmc_init(mmc);
-	omap_usb_init(&sdp2430_usb_config);
+	omap2_usbfs_init(&sdp2430_usb_config);
 	usb_musb_init(&musb_board_data);
 	board_smc91x_init();
 
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index aa69fb9..987b24d 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -306,7 +306,7 @@ static void __init apollon_usb_init(void)
 	omap_cfg_reg(P21_242X_GPIO12);
 	gpio_request(12, "USB suspend");
 	gpio_direction_output(12, 0);
-	omap_usb_init(&apollon_usb_config);
+	omap2_usbfs_init(&apollon_usb_config);
 }
 
 static void __init omap_apollon_init(void)
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 0665f2c..54a231c 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -362,7 +362,7 @@ static void __init omap_h4_init(void)
 			ARRAY_SIZE(h4_i2c_board_info));
 
 	platform_add_devices(h4_devices, ARRAY_SIZE(h4_devices));
-	omap_usb_init(&h4_usb_config);
+	omap2_usbfs_init(&h4_usb_config);
 	omap_serial_init();
 }
 
diff --git a/arch/arm/mach-omap2/usb-fs.c b/arch/arm/mach-omap2/usb-fs.c
new file mode 100644
index 0000000..f63e576
--- /dev/null
+++ b/arch/arm/mach-omap2/usb-fs.c
@@ -0,0 +1,345 @@
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
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+
+#include <asm/irq.h>
+
+#include <plat/control.h>
+#include <plat/mux.h>
+#include <plat/usb.h>
+#include <plat/board.h>
+
+#define INT_USB_IRQ_GEN		INT_24XX_USB_IRQ_GEN
+#define INT_USB_IRQ_NISO	INT_24XX_USB_IRQ_NISO
+#define INT_USB_IRQ_ISO		INT_24XX_USB_IRQ_ISO
+#define INT_USB_IRQ_HGEN	INT_24XX_USB_IRQ_HGEN
+#define INT_USB_IRQ_OTG		INT_24XX_USB_IRQ_OTG
+
+#if defined(CONFIG_ARCH_OMAP2)
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
+static void omap2_usb_devconf_clear(u8 port, u32 mask)
+{
+	u32 r;
+
+	r = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
+	r &= ~USBTXWRMODEI(port, mask);
+	omap_ctrl_writel(r, OMAP2_CONTROL_DEVCONF0);
+}
+
+static void omap2_usb_devconf_set(u8 port, u32 mask)
+{
+	u32 r;
+
+	r = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
+	r |= USBTXWRMODEI(port, mask);
+	omap_ctrl_writel(r, OMAP2_CONTROL_DEVCONF0);
+}
+
+static void omap2_usb2_disable_5pinbitll(void)
+{
+	u32 r;
+
+	r = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
+	r &= ~(USBTXWRMODEI(2, USB_BIDIR_TLL) | USBT2TLL5PI);
+	omap_ctrl_writel(r, OMAP2_CONTROL_DEVCONF0);
+}
+
+static void omap2_usb2_enable_5pinunitll(void)
+{
+	u32 r;
+
+	r = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
+	r |= USBTXWRMODEI(2, USB_UNIDIR_TLL) | USBT2TLL5PI;
+	omap_ctrl_writel(r, OMAP2_CONTROL_DEVCONF0);
+}
+
+static u32 __init omap2_usb0_init(unsigned nwires, unsigned is_device)
+{
+	u32	syscon1 = 0;
+
+	omap2_usb_devconf_clear(0, USB_BIDIR_TLL);
+
+	if (nwires == 0)
+		return 0;
+
+	if (is_device)
+		omap_cfg_reg(J20_24XX_USB0_PUEN);
+
+	omap_cfg_reg(K18_24XX_USB0_DAT);
+	omap_cfg_reg(K19_24XX_USB0_TXEN);
+	omap_cfg_reg(J14_24XX_USB0_SE0);
+	if (nwires != 3)
+		omap_cfg_reg(J18_24XX_USB0_RCV);
+
+	switch (nwires) {
+	case 3:
+		syscon1 = 2;
+		omap2_usb_devconf_set(0, USB_BIDIR);
+		break;
+	case 4:
+		syscon1 = 1;
+		omap2_usb_devconf_set(0, USB_BIDIR);
+		break;
+	case 6:
+		syscon1 = 3;
+		omap_cfg_reg(J19_24XX_USB0_VP);
+		omap_cfg_reg(K20_24XX_USB0_VM);
+		omap2_usb_devconf_set(0, USB_UNIDIR);
+		break;
+	default:
+		printk(KERN_ERR "illegal usb%d %d-wire transceiver\n",
+			0, nwires);
+	}
+
+	return syscon1 << 16;
+}
+
+static u32 __init omap2_usb1_init(unsigned nwires)
+{
+	u32	syscon1 = 0;
+
+	omap2_usb_devconf_clear(1, USB_BIDIR_TLL);
+
+	if (nwires == 0)
+		return 0;
+
+	/* NOTE:  board-specific code must set up pin muxing for usb1,
+	 * since each signal could come out on either of two balls.
+	 */
+
+	switch (nwires) {
+	case 2:
+		/* NOTE: board-specific code must override this setting if
+		 * this TLL link is not using DP/DM
+		 */
+		syscon1 = 1;
+		omap2_usb_devconf_set(1, USB_BIDIR_TLL);
+		break;
+	case 3:
+		syscon1 = 2;
+		omap2_usb_devconf_set(1, USB_BIDIR);
+		break;
+	case 4:
+		syscon1 = 1;
+		omap2_usb_devconf_set(1, USB_BIDIR);
+		break;
+	case 6:
+	default:
+		printk(KERN_ERR "illegal usb%d %d-wire transceiver\n",
+			1, nwires);
+	}
+
+	return syscon1 << 20;
+}
+
+static u32 __init omap2_usb2_init(unsigned nwires, unsigned alt_pingroup)
+{
+	u32	syscon1 = 0;
+
+	omap2_usb2_disable_5pinbitll();
+	alt_pingroup = 0;
+
+	/* NOTE omap1 erratum: must leave USB2_UNI_R set if usb0 in use */
+	if (alt_pingroup || nwires == 0)
+		return 0;
+
+	omap_cfg_reg(Y11_24XX_USB2_DAT);
+	omap_cfg_reg(AA10_24XX_USB2_SE0);
+	if (nwires > 2)
+		omap_cfg_reg(AA12_24XX_USB2_TXEN);
+	if (nwires > 3)
+		omap_cfg_reg(AA6_24XX_USB2_RCV);
+
+	switch (nwires) {
+	case 2:
+		/* NOTE: board-specific code must override this setting if
+		 * this TLL link is not using DP/DM
+		 */
+		syscon1 = 1;
+		omap2_usb_devconf_set(2, USB_BIDIR_TLL);
+		break;
+	case 3:
+		syscon1 = 2;
+		omap2_usb_devconf_set(2, USB_BIDIR);
+		break;
+	case 4:
+		syscon1 = 1;
+		omap2_usb_devconf_set(2, USB_BIDIR);
+		break;
+	case 5:
+		omap_cfg_reg(AA4_24XX_USB2_TLLSE0);
+		/* NOTE: board-specific code must override this setting if
+		 * this TLL link is not using DP/DM.  Something must also
+		 * set up OTG_SYSCON2.HMC_TLL{ATTACH,SPEED}
+		 */
+		syscon1 = 3;
+		omap2_usb2_enable_5pinunitll();
+		break;
+	case 6:
+	default:
+		printk(KERN_ERR "illegal usb%d %d-wire transceiver\n",
+			2, nwires);
+	}
+
+	return syscon1 << 24;
+}
+
+void __init omap2_usbfs_init(struct omap_usb_config *pdata)
+{
+	if (!cpu_is_omap24xx())
+		return;
+
+	pdata->usb0_init = omap2_usb0_init;
+	pdata->usb1_init = omap2_usb1_init;
+	pdata->usb2_init = omap2_usb2_init;
+	udc_device_init(pdata);
+	ohci_device_init(pdata);
+	otg_device_init(pdata);
+	omap_otg_init(pdata);
+}
+
+#endif
diff --git a/arch/arm/plat-omap/include/plat/board.h b/arch/arm/plat-omap/include/plat/board.h
index 5cd6220..3cf4fa2 100644
--- a/arch/arm/plat-omap/include/plat/board.h
+++ b/arch/arm/plat-omap/include/plat/board.h
@@ -85,6 +85,14 @@ struct omap_usb_config {
 	 *  6 == 6 wire unidirectional (or TLL)
 	 */
 	u8		pins[3];
+
+	struct platform_device *udc_device;
+	struct platform_device *ohci_device;
+	struct platform_device *otg_device;
+
+	u32 (*usb0_init)(unsigned nwires, unsigned is_device);
+	u32 (*usb1_init)(unsigned nwires);
+	u32 (*usb2_init)(unsigned nwires, unsigned alt_pingroup);
 };
 
 struct omap_lcd_config {
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index 98eef53..9f79224 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -81,7 +81,14 @@ extern void usb_ohci_init(const struct ohci_hcd_omap_platform_data *pdata);
 
 #endif
 
+void omap_otg_init(struct omap_usb_config *config);
 void omap_usb_init(struct omap_usb_config *pdata);
+void omap2_usbfs_init(struct omap_usb_config *pdata);
+#else
+static inline omap2_usbfs_init(struct omap_usb_config *pdata)
+{
+}
+#endif
 
 /*-------------------------------------------------------------------------*/
 
diff --git a/arch/arm/plat-omap/usb.c b/arch/arm/plat-omap/usb.c
index 9c4929a..27b471c 100644
--- a/arch/arm/plat-omap/usb.c
+++ b/arch/arm/plat-omap/usb.c
@@ -38,25 +38,12 @@
 #include <plat/usb.h>
 #include <plat/board.h>
 
-#ifdef CONFIG_ARCH_OMAP1
-
 #define INT_USB_IRQ_GEN		IH2_BASE + 20
 #define INT_USB_IRQ_NISO	IH2_BASE + 30
 #define INT_USB_IRQ_ISO		IH2_BASE + 29
 #define INT_USB_IRQ_HGEN	INT_USB_HHC_1
 #define INT_USB_IRQ_OTG		IH2_BASE + 8
 
-#else
-
-#define INT_USB_IRQ_GEN		INT_24XX_USB_IRQ_GEN
-#define INT_USB_IRQ_NISO	INT_24XX_USB_IRQ_NISO
-#define INT_USB_IRQ_ISO		INT_24XX_USB_IRQ_ISO
-#define INT_USB_IRQ_HGEN	INT_24XX_USB_IRQ_HGEN
-#define INT_USB_IRQ_OTG		INT_24XX_USB_IRQ_OTG
-
-#endif
-
-
 /* These routines should handle the standard chip-specific modes
  * for usb0/1/2 ports, covering basic mux and transceiver setup.
  *
@@ -79,90 +66,10 @@
 
 #if defined(CONFIG_ARCH_OMAP_OTG) || defined(CONFIG_ARCH_OMAP15XX)
 
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
-		omap_cfg_reg(J20_24XX_USB0_PUEN);
-
-	omap_cfg_reg(K18_24XX_USB0_DAT);
-	omap_cfg_reg(K19_24XX_USB0_TXEN);
-	omap_cfg_reg(J14_24XX_USB0_SE0);
-	if (nwires != 3)
-		omap_cfg_reg(J18_24XX_USB0_RCV);
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
-		omap_cfg_reg(J19_24XX_USB0_VP);
-		omap_cfg_reg(K20_24XX_USB0_VM);
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
 static u32 __init omap_usb0_init(unsigned nwires, unsigned is_device)
 {
 	u32	syscon1 = 0;
 
-	if (cpu_is_omap24xx())
-		return omap2_usb0_init(nwires, is_device);
-
 	if (nwires == 0) {
 		if (!cpu_is_omap15xx()) {
 			u32 l;
@@ -266,51 +173,10 @@ static u32 __init omap_usb0_init(unsigned nwires, unsigned is_device)
 	return syscon1 << 16;
 }
 
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
 static u32 __init omap_usb1_init(unsigned nwires)
 {
 	u32	syscon1 = 0;
 
-	if (cpu_is_omap24xx())
-		return omap2_usb1_init(nwires);
-
 	if (!cpu_is_omap15xx() && nwires != 6) {
 		u32 l;
 
@@ -372,65 +238,10 @@ bad:
 	return syscon1 << 20;
 }
 
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
-	omap_cfg_reg(Y11_24XX_USB2_DAT);
-	omap_cfg_reg(AA10_24XX_USB2_SE0);
-	if (nwires > 2)
-		omap_cfg_reg(AA12_24XX_USB2_TXEN);
-	if (nwires > 3)
-		omap_cfg_reg(AA6_24XX_USB2_RCV);
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
-		omap_cfg_reg(AA4_24XX_USB2_TLLSE0);
-		/* NOTE: board-specific code must override this setting if
-		 * this TLL link is not using DP/DM.  Something must also
-		 * set up OTG_SYSCON2.HMC_TLL{ATTACH,SPEED}
-		 */
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
 static u32 __init omap_usb2_init(unsigned nwires, unsigned alt_pingroup)
 {
 	u32	syscon1 = 0;
 
-	if (cpu_is_omap24xx())
-		return omap2_usb2_init(nwires, alt_pingroup);
-
 	/* NOTE omap1 erratum: must leave USB2_UNI_R set if usb0 in use */
 	if (alt_pingroup || nwires == 0)
 		return 0;
@@ -498,6 +309,10 @@ bad:
 	return syscon1 << 24;
 }
 
+#else
+#define omap_usb0_init		NULL
+#define omap_usb1_init		NULL
+#define omap_usb2_init		NULL
 #endif
 
 /*-------------------------------------------------------------------------*/
@@ -535,6 +350,17 @@ static struct platform_device udc_device = {
 	.resource	= udc_resources,
 };
 
+static inline void udc_device_init(struct omap_usb_config *pdata)
+{
+	pdata->udc_device = &udc_device;
+}
+
+#else
+
+static inline void udc_device_init(struct omap_usb_config *pdata)
+{
+}
+
 #endif
 
 #if	defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
@@ -565,6 +391,17 @@ static struct platform_device ohci_device = {
 	.resource		= ohci_resources,
 };
 
+static inline void ohci_device_init(struct omap_usb_config *pdata)
+{
+	pdata->ohci_device = &ohci_device;
+}
+
+#else
+
+static inline void ohci_device_init(struct omap_usb_config *pdata)
+{
+}
+
 #endif
 
 #if	defined(CONFIG_USB_OTG) && defined(CONFIG_ARCH_OMAP_OTG)
@@ -588,6 +425,17 @@ static struct platform_device otg_device = {
 	.resource	= otg_resources,
 };
 
+static inline void otg_device_init(struct omap_usb_config *pdata)
+{
+	pdata->otg_device = &otg_device;
+}
+
+#else
+
+static inline void otg_device_init(struct omap_usb_config *pdata)
+{
+}
+
 #endif
 
 /*-------------------------------------------------------------------------*/
@@ -622,9 +470,9 @@ omap_otg_init(struct omap_usb_config *config)
 	/* pin muxing and transceiver pinouts */
 	if (config->pins[0] > 2)	/* alt pingroup 2 */
 		alt_pingroup = 1;
-	syscon |= omap_usb0_init(config->pins[0], is_usb0_device(config));
-	syscon |= omap_usb1_init(config->pins[1]);
-	syscon |= omap_usb2_init(config->pins[2], alt_pingroup);
+	syscon |= config->usb0_init(config->pins[0], is_usb0_device(config));
+	syscon |= config->usb1_init(config->pins[1]);
+	syscon |= config->usb2_init(config->pins[2], alt_pingroup);
 	pr_debug("OTG_SYSCON_1 = %08x\n", omap_readl(OTG_SYSCON_1));
 	omap_writel(syscon, OTG_SYSCON_1);
 
@@ -672,15 +520,17 @@ omap_otg_init(struct omap_usb_config *config)
 
 #ifdef	CONFIG_USB_GADGET_OMAP
 	if (config->otg || config->register_dev) {
+		struct platform_device *udc_device = config->udc_device;
+
 		syscon &= ~DEV_IDLE_EN;
-		udc_device.dev.platform_data = config;
+		udc_device->dev.platform_data = config;
 		/* IRQ numbers for omap7xx */
 		if(cpu_is_omap7xx()) {
 			udc_resources[1].start = INT_7XX_USB_GENI;
 			udc_resources[2].start = INT_7XX_USB_NON_ISO;
 			udc_resources[3].start = INT_7XX_USB_ISO;
 		}
-		status = platform_device_register(&udc_device);
+		status = platform_device_register(udc_device);
 		if (status)
 			pr_debug("can't register UDC device, %d\n", status);
 	}
@@ -688,11 +538,13 @@ omap_otg_init(struct omap_usb_config *config)
 
 #if	defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
 	if (config->otg || config->register_host) {
+		struct platform_device *ohci_device = config->ohci_device;
+
 		syscon &= ~HST_IDLE_EN;
-		ohci_device.dev.platform_data = config;
+		ohci_device->dev.platform_data = config;
 		if (cpu_is_omap7xx())
 			ohci_resources[1].start = INT_7XX_USB_HHC_1;
-		status = platform_device_register(&ohci_device);
+		status = platform_device_register(ohci_device);
 		if (status)
 			pr_debug("can't register OHCI device, %d\n", status);
 	}
@@ -700,11 +552,13 @@ omap_otg_init(struct omap_usb_config *config)
 
 #ifdef	CONFIG_USB_OTG
 	if (config->otg) {
+		struct platform_device *otg_device = config->otg_device;
+
 		syscon &= ~OTG_IDLE_EN;
-		otg_device.dev.platform_data = config;
+		otg_device->dev.platform_data = config;
 		if (cpu_is_omap7xx())
 			otg_resources[1].start = INT_7XX_USB_OTG;
-		status = platform_device_register(&otg_device);
+		status = platform_device_register(otg_device);
 		if (status)
 			pr_debug("can't register OTG device, %d\n", status);
 	}
@@ -716,7 +570,7 @@ omap_otg_init(struct omap_usb_config *config)
 }
 
 #else
-static inline void omap_otg_init(struct omap_usb_config *config) {}
+void omap_otg_init(struct omap_usb_config *config) {}
 #endif
 
 /*-------------------------------------------------------------------------*/
@@ -737,9 +591,9 @@ static void __init omap_1510_usb_init(struct omap_usb_config *config)
 	unsigned int val;
 	u16 w;
 
-	omap_usb0_init(config->pins[0], is_usb0_device(config));
-	omap_usb1_init(config->pins[1]);
-	omap_usb2_init(config->pins[2], 0);
+	config->usb0_init(config->pins[0], is_usb0_device(config));
+	config->usb1_init(config->pins[1]);
+	config->usb2_init(config->pins[2], 0);
 
 	val = omap_readl(MOD_CONF_CTRL_0) & ~(0x3f << 1);
 	val |= (config->hmc_mode << 1);
@@ -807,7 +661,14 @@ static inline void omap_1510_usb_init(struct omap_usb_config *config) {}
 
 void __init omap_usb_init(struct omap_usb_config *pdata)
 {
-	if (cpu_is_omap7xx() || cpu_is_omap16xx() || cpu_is_omap24xx())
+	pdata->usb0_init = omap_usb0_init;
+	pdata->usb1_init = omap_usb1_init;
+	pdata->usb2_init = omap_usb2_init;
+	udc_device_init(pdata);
+	ohci_device_init(pdata);
+	otg_device_init(pdata);
+
+	if (cpu_is_omap7xx() || cpu_is_omap16xx())
 		omap_otg_init(pdata);
 	else if (cpu_is_omap15xx())
 		omap_1510_usb_init(pdata);

