From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 1/3 v2] AM35x: Add musb support
Date: Fri, 14 May 2010 17:35:35 +0530
Message-ID: <1273838737-6995-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46844 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754303Ab0ENMFm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 May 2010 08:05:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Ajay Kumar Gupta <ajay.gupta@ti.com>

AM35x has musb interface (version 1.8) and uses CPPI41 DMA engine.
It supports upto 500mA of power in host mode.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
Changes from v1:
	- Added PHY clock and OTGMODE settings in board files
 arch/arm/mach-omap2/board-am3517evm.c |   42 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/usb-musb.c        |    4 +++
 arch/arm/plat-omap/include/plat/usb.h |   21 ++++++++++++++++
 3 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 837f294..c66ac72 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -32,6 +32,7 @@
 #include <plat/common.h>
 #include <plat/usb.h>
 #include <plat/display.h>
+#include <plat/control.h>
 
 #include "mux.h"
 
@@ -278,6 +279,12 @@ static void __init am3517_evm_init_irq(void)
 	omap_gpio_init();
 }
 
+static struct omap_musb_board_data musb_board_data = {
+	.interface_type         = MUSB_INTERFACE_ULPI,
+	.mode                   = MUSB_OTG,
+	.power                  = 500,
+};
+
 static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
 #if defined(CONFIG_PANEL_SHARP_LQ043T1DG01) || \
@@ -296,12 +303,45 @@ static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
+	/* USB OTG DRVVBUS offset = 0x212 */
+	OMAP3_MUX(SAD2D_MCAD23, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLDOWN),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 #else
 #define board_mux	NULL
 #endif
 
+static __init void am3517_evm_musb_init(void)
+{
+	u32 devconf2;
+
+	/*
+	 * Set up USB clock/mode in the DEVCONF2 register.
+	 */
+	devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
+
+	/* USB2.0 PHY reference clock is 13 MHz */
+	devconf2 &= ~CONF2_REFFREQ;
+	devconf2 |=  CONF2_REFFREQ_13MHZ;
+
+	/*
+	 * We have to override VBUS/ID signals when MUSB is configured into the
+	 * host-only mode -- ID pin will float if no cable is connected, so the
+	 * controller won't be able to drive VBUS thinking that it's a B-device.
+	 * Otherwise, we want to use the OTG mode and enable VBUS comparators.
+	 */
+	devconf2 &= ~CONF2_OTGMODE;
+#ifdef	CONFIG_USB_MUSB_HOST
+	devconf2 |=  CONF2_FORCE_HOST;
+#else
+	devconf2 |=  CONF2_SESENDEN | CONF2_VBDTCTEN;
+#endif
+
+	omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
+
+	usb_musb_init(&musb_board_data);
+}
+
 static void __init am3517_evm_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
@@ -323,6 +363,8 @@ static void __init am3517_evm_init(void)
 
 	i2c_register_board_info(1, am3517evm_i2c_boardinfo,
 				ARRAY_SIZE(am3517evm_i2c_boardinfo));
+	/* MUSB */
+	am3517_evm_musb_init();
 }
 
 static void __init am3517_evm_map_io(void)
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 6d41fa7..710020d 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -28,6 +28,7 @@
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
+#include <mach/am35xx.h>
 #include <plat/mux.h>
 #include <plat/usb.h>
 
@@ -90,6 +91,9 @@ void __init usb_musb_init(struct omap_musb_board_data *board_data)
 {
 	if (cpu_is_omap243x()) {
 		musb_resources[0].start = OMAP243X_HS_BASE;
+	} else if (cpu_is_omap3517()) {
+		musb_resources[0].start = AM35XX_IPSS_USBOTGSS_BASE;
+		musb_resources[1].start = INT_35XX_USBOTG_IRQ;
 	} else if (cpu_is_omap34xx()) {
 		musb_resources[0].start = OMAP34XX_HSUSB_OTG_BASE;
 	} else if (cpu_is_omap44xx()) {
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index 876ca8d..c0e416c 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -167,5 +167,26 @@ void omap_usb_init(struct omap_usb_config *pdata);
 #	define	USBT2TLL5PI		(1 << 17)
 #	define	USB0PUENACTLOI		(1 << 16)
 #	define	USBSTANDBYCTRL		(1 << 15)
+/* AM3517 */
+/* USB 2.0 PHY Control */
+#define CONF2_PHY_GPIOMODE	(1 << 23)
+#define CONF2_OTGMODE		(3 << 14)
+#define CONF2_NO_OVERRIDE	(0 << 14)
+#define CONF2_FORCE_HOST	(1 << 14)
+#define CONF2_FORCE_DEVICE	(2 << 14)
+#define CONF2_FORCE_HOST_VBUS_LOW (3 << 14)
+#define CONF2_SESENDEN		(1 << 13)
+#define CONF2_VBDTCTEN		(1 << 12)
+#define CONF2_REFFREQ_24MHZ	(2 << 8)
+#define CONF2_REFFREQ_26MHZ	(7 << 8)
+#define CONF2_REFFREQ_13MHZ	(6 << 8)
+#define CONF2_REFFREQ		(0xf << 8)
+#define CONF2_PHYCLKGD		(1 << 7)
+#define CONF2_VBUSSENSE		(1 << 6)
+#define CONF2_PHY_PLLON		(1 << 5)
+#define CONF2_RESET		(1 << 4)
+#define CONF2_PHYPWRDN		(1 << 3)
+#define CONF2_OTGPWRDN		(1 << 2)
+#define CONF2_DATPOL		(1 << 1)
 
 #endif	/* __ASM_ARCH_OMAP_USB_H */
-- 
1.6.2.4

