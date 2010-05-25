From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/3 v3] AM35x: Add musb support
Date: Tue, 25 May 2010 12:08:40 +0530
Message-ID: <1274769522-28212-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

AM35x has musb interface (version 1.8) and uses CPPI41 DMA engine.
It has USB phy built inside the IP itself.

Also added ARCH_AM35x which is required to differentiate musb ips
between OMAP3x and AM35x. This config would be used to for below
purposes,
	- Select am3517.c instead of omap2430.c for compilation
	  at drivers/usb/musb directory. Please note there are
	  significant differneces in these two files as musb ip
	  in quite different on AM35x.
	- Select workaround codes applicable for AM35x musb issues.
	  one such workaround is for bytewise read issue on AM35x.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
Changes from v2:
	- Added CONFIG_ARCH_AMx

 arch/arm/mach-omap2/Kconfig           |    1 +
 arch/arm/mach-omap2/board-am3517evm.c |   43 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/usb-musb.c        |    4 +++
 arch/arm/plat-omap/Kconfig            |    8 ++++++
 arch/arm/plat-omap/include/plat/usb.h |   21 ++++++++++++++++
 5 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index b31b6f1..52a6752 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -84,6 +84,7 @@ config MACH_OMAP3517EVM
 	bool "OMAP3517/ AM3517 EVM board"
 	depends on ARCH_OMAP3
 	select OMAP_PACKAGE_CBB
+	select ARCH_AM35x
 
 config MACH_OMAP3_PANDORA
 	bool "OMAP3 Pandora"
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
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 78b49a6..3f33d75 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -5,6 +5,14 @@ menu "TI OMAP Implementations"
 config ARCH_OMAP_OTG
 	bool
 
+config ARCH_AM35x
+	bool
+	help
+	  Select this option if your platform is based on AM35x. As
+	  AM35x has an updated MUSB with CPPI4.1 DMA so this config
+	  is introduced to differentiate musb ip between OMAP3x and
+	  AM35x platforms.
+
 choice
 	prompt "OMAP System Type"
 	default ARCH_OMAP2PLUS
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index 98eef53..a32d3af 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -191,5 +191,26 @@ void omap_usb_init(struct omap_usb_config *pdata);
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
