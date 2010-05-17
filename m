From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/3 v3] AM35x: Add musb support
Date: Mon, 17 May 2010 16:17:13 +0530
Message-ID: <1274093235-7616-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

AM35x has musb interface (version 1.8) and uses CPPI41 DMA engine.
It supports upto 500mA of power in host mode.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
Patch created against linus'tree + all musb patches in Greg's queue
and patches available in linux-omap/for-next branch.

 arch/arm/mach-omap2/board-am3517evm.c |   43 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/usb-musb.c        |    4 +++
 arch/arm/plat-omap/include/plat/usb.h |   21 ++++++++++++++++
 3 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index af383a8..313559c 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -35,6 +35,7 @@
 #include <plat/control.h>
 #include <plat/usb.h>
 #include <plat/display.h>
+#include <plat/control.h>
 
 #include "mux.h"
 
@@ -375,6 +376,43 @@ static void __init am3517_evm_init_irq(void)
 	omap_gpio_init();
 }
 
+static struct omap_musb_board_data musb_board_data = {
+	.interface_type         = MUSB_INTERFACE_ULPI,
+	.mode                   = MUSB_OTG,
+	.power                  = 500,
+};
+
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
 static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
 #if defined(CONFIG_PANEL_SHARP_LQ043T1DG01) || \
@@ -393,6 +431,8 @@ static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
+	/* USB OTG DRVVBUS offset = 0x212 */
+	OMAP3_MUX(SAD2D_MCAD23, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLDOWN),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 #else
@@ -459,6 +499,9 @@ static void __init am3517_evm_init(void)
 				ARRAY_SIZE(am3517evm_i2c1_boardinfo));
 	/*Ethernet*/
 	am3517_evm_ethernet_init(&am3517_evm_emac_pdata);
+
+	/* MUSB */
+	am3517_evm_musb_init();
 }
 
 static void __init am3517_evm_map_io(void)
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 3befddb..883795b 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -21,6 +21,7 @@
 #include <linux/usb/musb.h>
 
 #include <mach/irqs.h>
+#include <mach/am35xx.h>
 #include <plat/usb.h>
 
 #ifdef CONFIG_USB_MUSB_SOC
@@ -69,6 +70,9 @@ void __init usb_musb_init(struct omap_musb_board_data *board_data)
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
index 60c734f..c7a019c 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -168,5 +168,26 @@ void omap_usb_init(struct omap_usb_config *pdata);
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

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
