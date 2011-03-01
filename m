From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [patch-v2.6.39 13/19] arm: omap: usb: create common enums and structures for ehci and ohci
Date: Tue,  1 Mar 2011 17:15:34 +0200
Message-ID: <1298992540-5984-14-git-send-email-balbi@ti.com>
References: <1298992540-5984-1-git-send-email-balbi@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1298992540-5984-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>

Create the ehci and ohci specific platform data structures.
The port enum values are made common for both ehci and ohci.

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/board-3430sdp.c        |   10 +++---
 arch/arm/mach-omap2/board-3630sdp.c        |   10 +++---
 arch/arm/mach-omap2/board-4430sdp.c        |   10 +++---
 arch/arm/mach-omap2/board-am3517crane.c    |   10 +++---
 arch/arm/mach-omap2/board-am3517evm.c      |   12 +++---
 arch/arm/mach-omap2/board-cm-t35.c         |   10 +++---
 arch/arm/mach-omap2/board-cm-t3517.c       |    8 ++--
 arch/arm/mach-omap2/board-devkit8000.c     |   10 +++---
 arch/arm/mach-omap2/board-igep0020.c       |   10 +++---
 arch/arm/mach-omap2/board-igep0030.c       |   10 +++---
 arch/arm/mach-omap2/board-omap3beagle.c    |   10 +++---
 arch/arm/mach-omap2/board-omap3evm.c       |   14 ++++----
 arch/arm/mach-omap2/board-omap3pandora.c   |   10 +++---
 arch/arm/mach-omap2/board-omap3stalker.c   |   10 +++---
 arch/arm/mach-omap2/board-omap3touchbook.c |   10 +++---
 arch/arm/mach-omap2/board-omap4panda.c     |   10 +++---
 arch/arm/mach-omap2/board-overo.c          |   10 +++---
 arch/arm/mach-omap2/board-zoom.c           |   10 +++---
 arch/arm/mach-omap2/usb-host.c             |   50 +++++++++++++-------------
 arch/arm/plat-omap/include/plat/usb.h      |   54 ++++++++++++++++++----------
 drivers/usb/host/ehci-omap.c               |   42 +++++++++++-----------
 drivers/usb/host/ohci-omap3.c              |   22 ++++++------
 22 files changed, 184 insertions(+), 168 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index d4e41ef..a991aeb 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -653,11 +653,11 @@ static void enable_board_wakeup_source(void)
 		OMAP_WAKEUP_EN | OMAP_PIN_INPUT_PULLUP);
 }
 
-static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
 
-	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
-	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
-	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
+	.port_mode[1] = OMAP_EHCI_PORT_MODE_PHY,
+	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
 
 	.phy_reset  = true,
 	.reset_gpio_port[0]  = 57,
@@ -816,7 +816,7 @@ static void __init omap_3430sdp_init(void)
 	board_flash_init(sdp_flash_partitions, chip_sel_3430);
 	sdp3430_display_init();
 	enable_board_wakeup_source();
-	usb_ehci_init(&ehci_pdata);
+	usb_ehci_init(&usbhs_bdata);
 }
 
 MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index 6264564..03fd8ac 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -54,11 +54,11 @@ static void enable_board_wakeup_source(void)
 		OMAP_WAKEUP_EN | OMAP_PIN_INPUT_PULLUP);
 }
 
-static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
 
-	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
-	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
-	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
+	.port_mode[1] = OMAP_EHCI_PORT_MODE_PHY,
+	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
 
 	.phy_reset  = true,
 	.reset_gpio_port[0]  = 126,
@@ -211,7 +211,7 @@ static void __init omap_sdp_init(void)
 	board_smc91x_init();
 	board_flash_init(sdp_flash_partitions, chip_sel_sdp);
 	enable_board_wakeup_source();
-	usb_ehci_init(&ehci_pdata);
+	usb_ehci_init(&usbhs_bdata);
 }
 
 MACHINE_START(OMAP_3630SDP, "OMAP 3630SDP board")
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 9cf8e33..0e1609d 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -251,10 +251,10 @@ static void __init omap_4430sdp_init_irq(void)
 	gic_init_irq();
 }
 
-static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
-	.port_mode[0]	= EHCI_HCD_OMAP_MODE_PHY,
-	.port_mode[1]	= EHCI_HCD_OMAP_MODE_UNKNOWN,
-	.port_mode[2]	= EHCI_HCD_OMAP_MODE_UNKNOWN,
+static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
+	.port_mode[0]	= OMAP_EHCI_PORT_MODE_PHY,
+	.port_mode[1]	= OMAP_USBHS_PORT_MODE_UNUSED,
+	.port_mode[2]	= OMAP_USBHS_PORT_MODE_UNUSED,
 	.phy_reset	= false,
 	.reset_gpio_port[0]  = -EINVAL,
 	.reset_gpio_port[1]  = -EINVAL,
@@ -584,7 +584,7 @@ static void __init omap_4430sdp_init(void)
 	else
 		gpio_direction_output(OMAP4SDP_MDM_PWR_EN_GPIO, 1);
 
-	usb_ehci_init(&ehci_pdata);
+	usb_ehci_init(&usbhs_bdata);
 	usb_musb_init(&musb_board_data);
 
 	status = omap_ethernet_init();
diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
index 71acb5a..1b825a0 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -59,10 +59,10 @@ static void __init am3517_crane_init_irq(void)
 	omap_init_irq();
 }
 
-static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
-	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
-	.port_mode[1] = EHCI_HCD_OMAP_MODE_UNKNOWN,
-	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+static struct usbhs_omap_board_data usbhs_bdata __initdata = {
+	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
+	.port_mode[1] = OMAP_USBHS_PORT_MODE_UNUSED,
+	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
 
 	.phy_reset  = true,
 	.reset_gpio_port[0]  = GPIO_USB_NRESET,
@@ -103,7 +103,7 @@ static void __init am3517_crane_init(void)
 		return;
 	}
 
-	usb_ehci_init(&ehci_pdata);
+	usb_ehci_init(&usbhs_bdata);
 }
 
 MACHINE_START(CRANEBOARD, "AM3517/05 CRANEBOARD")
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 10d60b7..f5bc1c6 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -430,15 +430,15 @@ static __init void am3517_evm_musb_init(void)
 	usb_musb_init(&musb_board_data);
 }
 
-static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
-	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
+static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
+	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
 #if defined(CONFIG_PANEL_SHARP_LQ043T1DG01) || \
 		defined(CONFIG_PANEL_SHARP_LQ043T1DG01_MODULE)
-	.port_mode[1] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.port_mode[1] = OMAP_USBHS_PORT_MODE_UNUSED,
 #else
-	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[1] = OMAP_EHCI_PORT_MODE_PHY,
 #endif
-	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
 
 	.phy_reset  = true,
 	.reset_gpio_port[0]  = 57,
@@ -502,7 +502,7 @@ static void __init am3517_evm_init(void)
 
 	/* Configure GPIO for EHCI port */
 	omap_mux_init_gpio(57, OMAP_PIN_OUTPUT);
-	usb_ehci_init(&ehci_pdata);
+	usb_ehci_init(&usbhs_bdata);
 	am3517_evm_hecc_init(&am3517_evm_hecc_pdata);
 	/* DSS */
 	am3517_evm_display_init();
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index dac1416..c79aa9b 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -605,10 +605,10 @@ static struct omap2_hsmmc_info mmc[] = {
 	{}	/* Terminator */
 };
 
-static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
-	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
-	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
-	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+static struct usbhs_omap_board_data usbhs_bdata __initdata = {
+	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
+	.port_mode[1] = OMAP_EHCI_PORT_MODE_PHY,
+	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
 
 	.phy_reset  = true,
 	.reset_gpio_port[0]  = OMAP_MAX_GPIO_LINES + 6,
@@ -810,7 +810,7 @@ static void __init cm_t35_init(void)
 	cm_t35_init_display();
 
 	usb_musb_init(&musb_board_data);
-	usb_ehci_init(&ehci_pdata);
+	usb_ehci_init(&usbhs_bdata);
 }
 
 MACHINE_START(CM_T35, "Compulab CM-T35")
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 8f9a64d..8288a0b 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -167,10 +167,10 @@ static inline void cm_t3517_init_rtc(void) {}
 #define HSUSB2_RESET_GPIO	(147)
 #define USB_HUB_RESET_GPIO	(152)
 
-static struct ehci_hcd_omap_platform_data cm_t3517_ehci_pdata __initdata = {
-	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
-	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
-	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+static struct usbhs_omap_board_data cm_t3517_ehci_pdata __initdata = {
+	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
+	.port_mode[1] = OMAP_EHCI_PORT_MODE_PHY,
+	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
 
 	.phy_reset  = true,
 	.reset_gpio_port[0]  = HSUSB1_RESET_GPIO,
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 9a2a31e..e0131dd 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -620,11 +620,11 @@ static struct omap_musb_board_data musb_board_data = {
 	.power			= 100,
 };
 
-static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
 
-	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
-	.port_mode[1] = EHCI_HCD_OMAP_MODE_UNKNOWN,
-	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
+	.port_mode[1] = OMAP_USBHS_PORT_MODE_UNUSED,
+	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
 
 	.phy_reset  = true,
 	.reset_gpio_port[0]  = -EINVAL,
@@ -803,7 +803,7 @@ static void __init devkit8000_init(void)
 	devkit8000_ads7846_init();
 
 	usb_musb_init(&musb_board_data);
-	usb_ehci_init(&ehci_pdata);
+	usb_ehci_init(&usbhs_bdata);
 	devkit8000_flash_init();
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 3be85a1..a9d7d1d 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -627,10 +627,10 @@ static struct omap_musb_board_data musb_board_data = {
 	.power			= 100,
 };
 
-static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
-	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
-	.port_mode[1] = EHCI_HCD_OMAP_MODE_UNKNOWN,
-	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
+	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
+	.port_mode[1] = OMAP_USBHS_PORT_MODE_UNUSED,
+	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
 
 	.phy_reset = true,
 	.reset_gpio_port[0] = IGEP2_GPIO_USBH_NRESET,
@@ -699,7 +699,7 @@ static void __init igep2_init(void)
 	platform_add_devices(igep2_devices, ARRAY_SIZE(igep2_devices));
 	omap_serial_init();
 	usb_musb_init(&musb_board_data);
-	usb_ehci_init(&ehci_pdata);
+	usb_ehci_init(&usbhs_bdata);
 
 	igep2_flash_init();
 	igep2_leds_init();
diff --git a/arch/arm/mach-omap2/board-igep0030.c b/arch/arm/mach-omap2/board-igep0030.c
index 4dc62a9..1b441ea 100644
--- a/arch/arm/mach-omap2/board-igep0030.c
+++ b/arch/arm/mach-omap2/board-igep0030.c
@@ -408,10 +408,10 @@ static void __init igep3_wifi_bt_init(void)
 void __init igep3_wifi_bt_init(void) {}
 #endif
 
-static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
-	.port_mode[0] = EHCI_HCD_OMAP_MODE_UNKNOWN,
-	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
-	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
+	.port_mode[0] = OMAP_USBHS_PORT_MODE_UNUSED,
+	.port_mode[1] = OMAP_EHCI_PORT_MODE_PHY,
+	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
 
 	.phy_reset = true,
 	.reset_gpio_port[0] = -EINVAL,
@@ -435,7 +435,7 @@ static void __init igep3_init(void)
 	platform_add_devices(igep3_devices, ARRAY_SIZE(igep3_devices));
 	omap_serial_init();
 	usb_musb_init(&musb_board_data);
-	usb_ehci_init(&ehci_pdata);
+	usb_ehci_init(&usbhs_bdata);
 
 	igep3_flash_init();
 	igep3_leds_init();
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 46d814a..b84a641 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -586,11 +586,11 @@ static void __init omap3beagle_flash_init(void)
 	}
 }
 
-static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
 
-	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
-	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
-	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
+	.port_mode[1] = OMAP_EHCI_PORT_MODE_PHY,
+	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
 
 	.phy_reset  = true,
 	.reset_gpio_port[0]  = -EINVAL,
@@ -625,7 +625,7 @@ static void __init omap3_beagle_init(void)
 	gpio_direction_output(170, true);
 
 	usb_musb_init(&musb_board_data);
-	usb_ehci_init(&ehci_pdata);
+	usb_ehci_init(&usbhs_bdata);
 	omap3beagle_flash_init();
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 323c380..ed5e411 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -638,11 +638,11 @@ static struct platform_device *omap3_evm_devices[] __initdata = {
 	&omap3_evm_dss_device,
 };
 
-static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
+static struct usbhs_omap_board_data usbhs_bdata __initdata = {
 
-	.port_mode[0] = EHCI_HCD_OMAP_MODE_UNKNOWN,
-	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
-	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.port_mode[0] = OMAP_USBHS_PORT_MODE_UNUSED,
+	.port_mode[1] = OMAP_EHCI_PORT_MODE_PHY,
+	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
 
 	.phy_reset  = true,
 	/* PHY reset GPIO will be runtime programmed based on EVM version */
@@ -700,7 +700,7 @@ static void __init omap3_evm_init(void)
 
 		/* setup EHCI phy reset config */
 		omap_mux_init_gpio(21, OMAP_PIN_INPUT_PULLUP);
-		ehci_pdata.reset_gpio_port[1] = 21;
+		usbhs_bdata.reset_gpio_port[1] = 21;
 
 		/* EVM REV >= E can supply 500mA with EXTVBUS programming */
 		musb_board_data.power = 500;
@@ -708,10 +708,10 @@ static void __init omap3_evm_init(void)
 	} else {
 		/* setup EHCI phy reset on MDC */
 		omap_mux_init_gpio(135, OMAP_PIN_OUTPUT);
-		ehci_pdata.reset_gpio_port[1] = 135;
+		usbhs_bdata.reset_gpio_port[1] = 135;
 	}
 	usb_musb_init(&musb_board_data);
-	usb_ehci_init(&ehci_pdata);
+	usb_ehci_init(&usbhs_bdata);
 	ads7846_dev_init();
 	omap3evm_init_smsc911x();
 	omap3_evm_display_init();
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 0b34bed..241e632 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -681,11 +681,11 @@ static struct platform_device *omap3pandora_devices[] __initdata = {
 	&pandora_vwlan_device,
 };
 
-static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
 
-	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
-	.port_mode[1] = EHCI_HCD_OMAP_MODE_UNKNOWN,
-	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
+	.port_mode[1] = OMAP_USBHS_PORT_MODE_UNUSED,
+	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
 
 	.phy_reset  = true,
 	.reset_gpio_port[0]  = 16,
@@ -716,7 +716,7 @@ static void __init omap3pandora_init(void)
 	spi_register_board_info(omap3pandora_spi_board_info,
 			ARRAY_SIZE(omap3pandora_spi_board_info));
 	omap3pandora_ads7846_init();
-	usb_ehci_init(&ehci_pdata);
+	usb_ehci_init(&usbhs_bdata);
 	usb_musb_init(&musb_board_data);
 	gpmc_nand_init(&pandora_nand_data);
 
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 2a2dad4..eaad924 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -608,10 +608,10 @@ static struct platform_device *omap3_stalker_devices[] __initdata = {
 	&keys_gpio,
 };
 
-static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
-	.port_mode[0] = EHCI_HCD_OMAP_MODE_UNKNOWN,
-	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
-	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+static struct usbhs_omap_board_data usbhs_bdata __initconst = {
+	.port_mode[0] = OMAP_USBHS_PORT_MODE_UNUSED,
+	.port_mode[1] = OMAP_EHCI_PORT_MODE_PHY,
+	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
 
 	.phy_reset = true,
 	.reset_gpio_port[0] = -EINVAL,
@@ -649,7 +649,7 @@ static void __init omap3_stalker_init(void)
 
 	omap_serial_init();
 	usb_musb_init(&musb_board_data);
-	usb_ehci_init(&ehci_pdata);
+	usb_ehci_init(&usbhs_bdata);
 	ads7846_dev_init();
 
 	omap_mux_init_gpio(21, OMAP_PIN_OUTPUT);
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index db1f74f..4e3a1ae 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -468,11 +468,11 @@ static void __init omap3touchbook_flash_init(void)
 	}
 }
 
-static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
 
-	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
-	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
-	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
+	.port_mode[1] = OMAP_EHCI_PORT_MODE_PHY,
+	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
 
 	.phy_reset  = true,
 	.reset_gpio_port[0]  = -EINVAL,
@@ -527,7 +527,7 @@ static void __init omap3_touchbook_init(void)
 				ARRAY_SIZE(omap3_ads7846_spi_board_info));
 	omap3_ads7846_init();
 	usb_musb_init(&musb_board_data);
-	usb_ehci_init(&ehci_pdata);
+	usb_ehci_init(&usbhs_bdata);
 	omap3touchbook_flash_init();
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 77748f8..b88c190 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -83,10 +83,10 @@ static void __init omap4_panda_init_irq(void)
 	gic_init_irq();
 }
 
-static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
-	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
-	.port_mode[1] = EHCI_HCD_OMAP_MODE_UNKNOWN,
-	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
+	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
+	.port_mode[1] = OMAP_USBHS_PORT_MODE_UNUSED,
+	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
 	.phy_reset  = false,
 	.reset_gpio_port[0]  = -EINVAL,
 	.reset_gpio_port[1]  = -EINVAL,
@@ -128,7 +128,7 @@ static void __init omap4_ehci_init(void)
 	gpio_set_value(GPIO_HUB_NRESET, 0);
 	gpio_set_value(GPIO_HUB_NRESET, 1);
 
-	usb_ehci_init(&ehci_pdata);
+	usb_ehci_init(&usbhs_bdata);
 
 	/* enable power to hub */
 	gpio_set_value(GPIO_HUB_POWER, 1);
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index cb26e5d..f78b74c 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -423,10 +423,10 @@ static struct platform_device *overo_devices[] __initdata = {
 	&overo_lcd_device,
 };
 
-static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
-	.port_mode[0] = EHCI_HCD_OMAP_MODE_UNKNOWN,
-	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
-	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
+	.port_mode[0] = OMAP_USBHS_PORT_MODE_UNUSED,
+	.port_mode[1] = OMAP_EHCI_PORT_MODE_PHY,
+	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
 
 	.phy_reset  = true,
 	.reset_gpio_port[0]  = -EINVAL,
@@ -454,7 +454,7 @@ static void __init overo_init(void)
 	omap_serial_init();
 	overo_flash_init();
 	usb_musb_init(&musb_board_data);
-	usb_ehci_init(&ehci_pdata);
+	usb_ehci_init(&usbhs_bdata);
 	overo_ads7846_init();
 	overo_init_smsc911x();
 
diff --git a/arch/arm/mach-omap2/board-zoom.c b/arch/arm/mach-omap2/board-zoom.c
index e26754c..19b9912 100644
--- a/arch/arm/mach-omap2/board-zoom.c
+++ b/arch/arm/mach-omap2/board-zoom.c
@@ -106,10 +106,10 @@ static struct mtd_partition zoom_nand_partitions[] = {
 	},
 };
 
-static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
-	.port_mode[0]		= EHCI_HCD_OMAP_MODE_UNKNOWN,
-	.port_mode[1]		= EHCI_HCD_OMAP_MODE_PHY,
-	.port_mode[2]		= EHCI_HCD_OMAP_MODE_UNKNOWN,
+static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
+	.port_mode[0]		= OMAP_USBHS_PORT_MODE_UNUSED,
+	.port_mode[1]		= OMAP_EHCI_PORT_MODE_PHY,
+	.port_mode[2]		= OMAP_USBHS_PORT_MODE_UNUSED,
 	.phy_reset		= true,
 	.reset_gpio_port[0]	= -EINVAL,
 	.reset_gpio_port[1]	= ZOOM3_EHCI_RESET_GPIO,
@@ -123,7 +123,7 @@ static void __init omap_zoom_init(void)
 	} else if (machine_is_omap_zoom3()) {
 		omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
 		omap_mux_init_gpio(ZOOM3_EHCI_RESET_GPIO, OMAP_PIN_OUTPUT);
-		usb_ehci_init(&ehci_pdata);
+		usb_ehci_init(&usbhs_bdata);
 	}
 
 	board_nand_init(zoom_nand_partitions,
diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
index 45f9b80..b04ce6f 100644
--- a/arch/arm/mach-omap2/usb-host.c
+++ b/arch/arm/mach-omap2/usb-host.c
@@ -64,10 +64,10 @@ static struct platform_device ehci_device = {
 /*
  * setup_ehci_io_mux - initialize IO pad mux for USBHOST
  */
-static void setup_ehci_io_mux(const enum ehci_hcd_omap_mode *port_mode)
+static void setup_ehci_io_mux(const enum usbhs_omap_port_mode *port_mode)
 {
 	switch (port_mode[0]) {
-	case EHCI_HCD_OMAP_MODE_PHY:
+	case OMAP_EHCI_PORT_MODE_PHY:
 		omap_mux_init_signal("hsusb1_stp", OMAP_PIN_OUTPUT);
 		omap_mux_init_signal("hsusb1_clk", OMAP_PIN_OUTPUT);
 		omap_mux_init_signal("hsusb1_dir", OMAP_PIN_INPUT_PULLDOWN);
@@ -81,7 +81,7 @@ static void setup_ehci_io_mux(const enum ehci_hcd_omap_mode *port_mode)
 		omap_mux_init_signal("hsusb1_data6", OMAP_PIN_INPUT_PULLDOWN);
 		omap_mux_init_signal("hsusb1_data7", OMAP_PIN_INPUT_PULLDOWN);
 		break;
-	case EHCI_HCD_OMAP_MODE_TLL:
+	case OMAP_EHCI_PORT_MODE_TLL:
 		omap_mux_init_signal("hsusb1_tll_stp",
 			OMAP_PIN_INPUT_PULLUP);
 		omap_mux_init_signal("hsusb1_tll_clk",
@@ -107,14 +107,14 @@ static void setup_ehci_io_mux(const enum ehci_hcd_omap_mode *port_mode)
 		omap_mux_init_signal("hsusb1_tll_data7",
 			OMAP_PIN_INPUT_PULLDOWN);
 		break;
-	case EHCI_HCD_OMAP_MODE_UNKNOWN:
+	case OMAP_USBHS_PORT_MODE_UNUSED:
 		/* FALLTHROUGH */
 	default:
 		break;
 	}
 
 	switch (port_mode[1]) {
-	case EHCI_HCD_OMAP_MODE_PHY:
+	case OMAP_EHCI_PORT_MODE_PHY:
 		omap_mux_init_signal("hsusb2_stp", OMAP_PIN_OUTPUT);
 		omap_mux_init_signal("hsusb2_clk", OMAP_PIN_OUTPUT);
 		omap_mux_init_signal("hsusb2_dir", OMAP_PIN_INPUT_PULLDOWN);
@@ -136,7 +136,7 @@ static void setup_ehci_io_mux(const enum ehci_hcd_omap_mode *port_mode)
 		omap_mux_init_signal("hsusb2_data7",
 			OMAP_PIN_INPUT_PULLDOWN);
 		break;
-	case EHCI_HCD_OMAP_MODE_TLL:
+	case OMAP_EHCI_PORT_MODE_TLL:
 		omap_mux_init_signal("hsusb2_tll_stp",
 			OMAP_PIN_INPUT_PULLUP);
 		omap_mux_init_signal("hsusb2_tll_clk",
@@ -162,17 +162,17 @@ static void setup_ehci_io_mux(const enum ehci_hcd_omap_mode *port_mode)
 		omap_mux_init_signal("hsusb2_tll_data7",
 			OMAP_PIN_INPUT_PULLDOWN);
 		break;
-	case EHCI_HCD_OMAP_MODE_UNKNOWN:
+	case OMAP_USBHS_PORT_MODE_UNUSED:
 		/* FALLTHROUGH */
 	default:
 		break;
 	}
 
 	switch (port_mode[2]) {
-	case EHCI_HCD_OMAP_MODE_PHY:
+	case OMAP_EHCI_PORT_MODE_PHY:
 		printk(KERN_WARNING "Port3 can't be used in PHY mode\n");
 		break;
-	case EHCI_HCD_OMAP_MODE_TLL:
+	case OMAP_EHCI_PORT_MODE_TLL:
 		omap_mux_init_signal("hsusb3_tll_stp",
 			OMAP_PIN_INPUT_PULLUP);
 		omap_mux_init_signal("hsusb3_tll_clk",
@@ -198,7 +198,7 @@ static void setup_ehci_io_mux(const enum ehci_hcd_omap_mode *port_mode)
 		omap_mux_init_signal("hsusb3_tll_data7",
 			OMAP_PIN_INPUT_PULLDOWN);
 		break;
-	case EHCI_HCD_OMAP_MODE_UNKNOWN:
+	case OMAP_USBHS_PORT_MODE_UNUSED:
 		/* FALLTHROUGH */
 	default:
 		break;
@@ -207,10 +207,10 @@ static void setup_ehci_io_mux(const enum ehci_hcd_omap_mode *port_mode)
 	return;
 }
 
-static void setup_4430ehci_io_mux(const enum ehci_hcd_omap_mode *port_mode)
+static void setup_4430ehci_io_mux(const enum usbhs_omap_port_mode *port_mode)
 {
 	switch (port_mode[0]) {
-	case EHCI_HCD_OMAP_MODE_PHY:
+	case OMAP_EHCI_PORT_MODE_PHY:
 		omap_mux_init_signal("usbb1_ulpiphy_stp",
 			OMAP_PIN_OUTPUT);
 		omap_mux_init_signal("usbb1_ulpiphy_clk",
@@ -236,7 +236,7 @@ static void setup_4430ehci_io_mux(const enum ehci_hcd_omap_mode *port_mode)
 		omap_mux_init_signal("usbb1_ulpiphy_dat7",
 			OMAP_PIN_INPUT_PULLDOWN);
 			break;
-	case EHCI_HCD_OMAP_MODE_TLL:
+	case OMAP_EHCI_PORT_MODE_TLL:
 		omap_mux_init_signal("usbb1_ulpitll_stp",
 			OMAP_PIN_INPUT_PULLUP);
 		omap_mux_init_signal("usbb1_ulpitll_clk",
@@ -262,12 +262,12 @@ static void setup_4430ehci_io_mux(const enum ehci_hcd_omap_mode *port_mode)
 		omap_mux_init_signal("usbb1_ulpitll_dat7",
 			OMAP_PIN_INPUT_PULLDOWN);
 			break;
-	case EHCI_HCD_OMAP_MODE_UNKNOWN:
+	case OMAP_USBHS_PORT_MODE_UNUSED:
 	default:
 			break;
 	}
 	switch (port_mode[1]) {
-	case EHCI_HCD_OMAP_MODE_PHY:
+	case OMAP_EHCI_PORT_MODE_PHY:
 		omap_mux_init_signal("usbb2_ulpiphy_stp",
 			OMAP_PIN_OUTPUT);
 		omap_mux_init_signal("usbb2_ulpiphy_clk",
@@ -293,7 +293,7 @@ static void setup_4430ehci_io_mux(const enum ehci_hcd_omap_mode *port_mode)
 		omap_mux_init_signal("usbb2_ulpiphy_dat7",
 			OMAP_PIN_INPUT_PULLDOWN);
 			break;
-	case EHCI_HCD_OMAP_MODE_TLL:
+	case OMAP_EHCI_PORT_MODE_TLL:
 		omap_mux_init_signal("usbb2_ulpitll_stp",
 			OMAP_PIN_INPUT_PULLUP);
 		omap_mux_init_signal("usbb2_ulpitll_clk",
@@ -319,13 +319,13 @@ static void setup_4430ehci_io_mux(const enum ehci_hcd_omap_mode *port_mode)
 		omap_mux_init_signal("usbb2_ulpitll_dat7",
 			OMAP_PIN_INPUT_PULLDOWN);
 			break;
-	case EHCI_HCD_OMAP_MODE_UNKNOWN:
+	case OMAP_USBHS_PORT_MODE_UNUSED:
 	default:
 			break;
 	}
 }
 
-void __init usb_ehci_init(const struct ehci_hcd_omap_platform_data *pdata)
+void __init usb_ehci_init(const struct usbhs_omap_board_data *pdata)
 {
 	platform_device_add_data(&ehci_device, pdata, sizeof(*pdata));
 
@@ -363,7 +363,7 @@ void __init usb_ehci_init(const struct ehci_hcd_omap_platform_data *pdata)
 
 #else
 
-void __init usb_ehci_init(const struct ehci_hcd_omap_platform_data *pdata)
+void __init usb_ehci_init(const struct usbhs_omap_board_data *pdata)
 
 {
 }
@@ -411,7 +411,7 @@ static struct platform_device ohci_device = {
 	.resource	= ohci_resources,
 };
 
-static void setup_ohci_io_mux(const enum ohci_omap3_port_mode *port_mode)
+static void setup_ohci_io_mux(const enum usbhs_omap_port_mode *port_mode)
 {
 	switch (port_mode[0]) {
 	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0:
@@ -439,7 +439,7 @@ static void setup_ohci_io_mux(const enum ohci_omap3_port_mode *port_mode)
 		omap_mux_init_signal("mm1_txdat",
 			OMAP_PIN_INPUT_PULLDOWN);
 		break;
-	case OMAP_OHCI_PORT_MODE_UNUSED:
+	case OMAP_USBHS_PORT_MODE_UNUSED:
 		/* FALLTHROUGH */
 	default:
 		break;
@@ -470,7 +470,7 @@ static void setup_ohci_io_mux(const enum ohci_omap3_port_mode *port_mode)
 		omap_mux_init_signal("mm2_txdat",
 			OMAP_PIN_INPUT_PULLDOWN);
 		break;
-	case OMAP_OHCI_PORT_MODE_UNUSED:
+	case OMAP_USBHS_PORT_MODE_UNUSED:
 		/* FALLTHROUGH */
 	default:
 		break;
@@ -501,14 +501,14 @@ static void setup_ohci_io_mux(const enum ohci_omap3_port_mode *port_mode)
 		omap_mux_init_signal("mm3_txdat",
 			OMAP_PIN_INPUT_PULLDOWN);
 		break;
-	case OMAP_OHCI_PORT_MODE_UNUSED:
+	case OMAP_USBHS_PORT_MODE_UNUSED:
 		/* FALLTHROUGH */
 	default:
 		break;
 	}
 }
 
-void __init usb_ohci_init(const struct ohci_hcd_omap_platform_data *pdata)
+void __init usb_ohci_init(const struct usbhs_omap_board_data *pdata)
 {
 	platform_device_add_data(&ohci_device, pdata, sizeof(*pdata));
 
@@ -524,7 +524,7 @@ void __init usb_ohci_init(const struct ohci_hcd_omap_platform_data *pdata)
 
 #else
 
-void __init usb_ohci_init(const struct ohci_hcd_omap_platform_data *pdata)
+void __init usb_ohci_init(const struct usbhs_omap_board_data *pdata)
 {
 }
 
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index f888e0e..32dfe08 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -7,15 +7,12 @@
 #include <plat/board.h>
 
 #define OMAP3_HS_USB_PORTS	3
-enum ehci_hcd_omap_mode {
-	EHCI_HCD_OMAP_MODE_UNKNOWN,
-	EHCI_HCD_OMAP_MODE_PHY,
-	EHCI_HCD_OMAP_MODE_TLL,
-	EHCI_HCD_OMAP_MODE_HSIC,
-};
 
-enum ohci_omap3_port_mode {
-	OMAP_OHCI_PORT_MODE_UNUSED,
+enum usbhs_omap_port_mode {
+	OMAP_USBHS_PORT_MODE_UNUSED,
+	OMAP_EHCI_PORT_MODE_PHY,
+	OMAP_EHCI_PORT_MODE_TLL,
+	OMAP_EHCI_PORT_MODE_HSIC,
 	OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0,
 	OMAP_OHCI_PORT_MODE_PHY_6PIN_DPDM,
 	OMAP_OHCI_PORT_MODE_PHY_3PIN_DATSE0,
@@ -25,24 +22,45 @@ enum ohci_omap3_port_mode {
 	OMAP_OHCI_PORT_MODE_TLL_3PIN_DATSE0,
 	OMAP_OHCI_PORT_MODE_TLL_4PIN_DPDM,
 	OMAP_OHCI_PORT_MODE_TLL_2PIN_DATSE0,
-	OMAP_OHCI_PORT_MODE_TLL_2PIN_DPDM,
+	OMAP_OHCI_PORT_MODE_TLL_2PIN_DPDM
 };
 
-struct ehci_hcd_omap_platform_data {
-	enum ehci_hcd_omap_mode		port_mode[OMAP3_HS_USB_PORTS];
-	unsigned			phy_reset:1;
+struct usbhs_omap_board_data {
+	enum usbhs_omap_port_mode	port_mode[OMAP3_HS_USB_PORTS];
 
 	/* have to be valid if phy_reset is true and portx is in phy mode */
 	int	reset_gpio_port[OMAP3_HS_USB_PORTS];
+
+	/* Set this to true for ES2.x silicon */
+	unsigned			es2_compatibility:1;
+
+	unsigned			phy_reset:1;
+
+	/*
+	 * Regulators for USB PHYs.
+	 * Each PHY can have a separate regulator.
+	 */
+	struct regulator		*regulator[OMAP3_HS_USB_PORTS];
 };
 
-struct ohci_hcd_omap_platform_data {
-	enum ohci_omap3_port_mode	port_mode[OMAP3_HS_USB_PORTS];
+struct ehci_hcd_omap_platform_data {
+	enum usbhs_omap_port_mode	port_mode[OMAP3_HS_USB_PORTS];
+	int				reset_gpio_port[OMAP3_HS_USB_PORTS];
+	struct regulator		*regulator[OMAP3_HS_USB_PORTS];
+	unsigned			phy_reset:1;
+};
 
-	/* Set this to true for ES2.x silicon */
+struct ohci_hcd_omap_platform_data {
+	enum usbhs_omap_port_mode	port_mode[OMAP3_HS_USB_PORTS];
 	unsigned			es2_compatibility:1;
 };
 
+struct usbhs_omap_platform_data {
+	enum usbhs_omap_port_mode		port_mode[OMAP3_HS_USB_PORTS];
+
+	struct ehci_hcd_omap_platform_data	*ehci_data;
+	struct ohci_hcd_omap_platform_data	*ohci_data;
+};
 /*-------------------------------------------------------------------------*/
 
 #define OMAP1_OTG_BASE			0xfffb0400
@@ -80,19 +98,17 @@ enum musb_interface    {MUSB_INTERFACE_ULPI, MUSB_INTERFACE_UTMI};
 
 extern void usb_musb_init(struct omap_musb_board_data *board_data);
 
-extern void usb_ehci_init(const struct ehci_hcd_omap_platform_data *pdata);
+extern void usb_ehci_init(const struct usbhs_omap_board_data *pdata);
 
-extern void usb_ohci_init(const struct ohci_hcd_omap_platform_data *pdata);
+extern void usb_ohci_init(const struct usbhs_omap_board_data *pdata);
 
 extern int omap4430_phy_power(struct device *dev, int ID, int on);
 extern int omap4430_phy_set_clk(struct device *dev, int on);
 extern int omap4430_phy_init(struct device *dev);
 extern int omap4430_phy_exit(struct device *dev);
 extern int omap4430_phy_suspend(struct device *dev, int suspend);
-
 #endif
 
-
 /*
  * FIXME correct answer depends on hmc_mode,
  * as does (on omap1) any nonzero value for config->otg port number
diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 1527721..18df6c6 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -155,9 +155,9 @@
 #define is_omap_ehci_rev1(x)	(x->omap_ehci_rev == OMAP_EHCI_REV1)
 #define is_omap_ehci_rev2(x)	(x->omap_ehci_rev == OMAP_EHCI_REV2)
 
-#define is_ehci_phy_mode(x)	(x == EHCI_HCD_OMAP_MODE_PHY)
-#define is_ehci_tll_mode(x)	(x == EHCI_HCD_OMAP_MODE_TLL)
-#define is_ehci_hsic_mode(x)	(x == EHCI_HCD_OMAP_MODE_HSIC)
+#define is_ehci_phy_mode(x)	(x == OMAP_EHCI_PORT_MODE_PHY)
+#define is_ehci_tll_mode(x)	(x == OMAP_EHCI_PORT_MODE_TLL)
+#define is_ehci_hsic_mode(x)	(x == OMAP_EHCI_PORT_MODE_HSIC)
 
 /*-------------------------------------------------------------------------*/
 
@@ -220,7 +220,7 @@ struct ehci_hcd_omap {
 	u32			omap_ehci_rev;
 
 	/* desired phy_mode: TLL, PHY */
-	enum ehci_hcd_omap_mode	port_mode[OMAP3_HS_USB_PORTS];
+	enum usbhs_omap_port_mode	port_mode[OMAP3_HS_USB_PORTS];
 
 	void __iomem		*uhh_base;
 	void __iomem		*tll_base;
@@ -389,7 +389,7 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 	 */
 	if (is_omap_ehci_rev2(omap)) {
 		switch (omap->port_mode[0]) {
-		case EHCI_HCD_OMAP_MODE_PHY:
+		case OMAP_EHCI_PORT_MODE_PHY:
 			omap->xclk60mhsp1_ck = clk_get(omap->dev,
 							"xclk60mhsp1_ck");
 			if (IS_ERR(omap->xclk60mhsp1_ck)) {
@@ -413,7 +413,7 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 					"Unable to set P1 f-clock\n");
 			}
 			break;
-		case EHCI_HCD_OMAP_MODE_TLL:
+		case OMAP_EHCI_PORT_MODE_TLL:
 			omap->xclk60mhsp1_ck = clk_get(omap->dev,
 							"init_60m_fclk");
 			if (IS_ERR(omap->xclk60mhsp1_ck)) {
@@ -463,7 +463,7 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 			break;
 		}
 		switch (omap->port_mode[1]) {
-		case EHCI_HCD_OMAP_MODE_PHY:
+		case OMAP_EHCI_PORT_MODE_PHY:
 			omap->xclk60mhsp2_ck = clk_get(omap->dev,
 							"xclk60mhsp2_ck");
 			if (IS_ERR(omap->xclk60mhsp2_ck)) {
@@ -487,7 +487,7 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 					"Unable to set P2 f-clock\n");
 			}
 			break;
-		case EHCI_HCD_OMAP_MODE_TLL:
+		case OMAP_EHCI_PORT_MODE_TLL:
 			omap->xclk60mhsp2_ck = clk_get(omap->dev,
 							"init_60m_fclk");
 			if (IS_ERR(omap->xclk60mhsp2_ck)) {
@@ -591,11 +591,11 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 	reg &= ~OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN;
 
 	if (is_omap_ehci_rev1(omap)) {
-		if (omap->port_mode[0] == EHCI_HCD_OMAP_MODE_UNKNOWN)
+		if (omap->port_mode[0] == OMAP_USBHS_PORT_MODE_UNUSED)
 			reg &= ~OMAP_UHH_HOSTCONFIG_P1_CONNECT_STATUS;
-		if (omap->port_mode[1] == EHCI_HCD_OMAP_MODE_UNKNOWN)
+		if (omap->port_mode[1] == OMAP_USBHS_PORT_MODE_UNUSED)
 			reg &= ~OMAP_UHH_HOSTCONFIG_P2_CONNECT_STATUS;
-		if (omap->port_mode[2] == EHCI_HCD_OMAP_MODE_UNKNOWN)
+		if (omap->port_mode[2] == OMAP_USBHS_PORT_MODE_UNUSED)
 			reg &= ~OMAP_UHH_HOSTCONFIG_P3_CONNECT_STATUS;
 
 		/* Bypass the TLL module for PHY mode operation */
@@ -656,15 +656,15 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 	ehci_omap_writel(omap->ehci_base, EHCI_INSNREG04,
 				EHCI_INSNREG04_DISABLE_UNSUSPEND);
 
-	if ((omap->port_mode[0] == EHCI_HCD_OMAP_MODE_TLL) ||
-		(omap->port_mode[1] == EHCI_HCD_OMAP_MODE_TLL) ||
-			(omap->port_mode[2] == EHCI_HCD_OMAP_MODE_TLL)) {
+	if ((omap->port_mode[0] == OMAP_EHCI_PORT_MODE_TLL) ||
+		(omap->port_mode[1] == OMAP_EHCI_PORT_MODE_TLL) ||
+			(omap->port_mode[2] == OMAP_EHCI_PORT_MODE_TLL)) {
 
-		if (omap->port_mode[0] == EHCI_HCD_OMAP_MODE_TLL)
+		if (omap->port_mode[0] == OMAP_EHCI_PORT_MODE_TLL)
 			tll_ch_mask |= OMAP_TLL_CHANNEL_1_EN_MASK;
-		if (omap->port_mode[1] == EHCI_HCD_OMAP_MODE_TLL)
+		if (omap->port_mode[1] == OMAP_EHCI_PORT_MODE_TLL)
 			tll_ch_mask |= OMAP_TLL_CHANNEL_2_EN_MASK;
-		if (omap->port_mode[2] == EHCI_HCD_OMAP_MODE_TLL)
+		if (omap->port_mode[2] == OMAP_EHCI_PORT_MODE_TLL)
 			tll_ch_mask |= OMAP_TLL_CHANNEL_3_EN_MASK;
 
 		/* Enable UTMI mode for required TLL channels */
@@ -686,9 +686,9 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 	}
 
 	/* Soft reset the PHY using PHY reset command over ULPI */
-	if (omap->port_mode[0] == EHCI_HCD_OMAP_MODE_PHY)
+	if (omap->port_mode[0] == OMAP_EHCI_PORT_MODE_PHY)
 		omap_ehci_soft_phy_reset(omap, 0);
-	if (omap->port_mode[1] == EHCI_HCD_OMAP_MODE_PHY)
+	if (omap->port_mode[1] == OMAP_EHCI_PORT_MODE_PHY)
 		omap_ehci_soft_phy_reset(omap, 1);
 
 	return 0;
@@ -903,7 +903,7 @@ static const struct hc_driver ehci_omap_hc_driver;
  */
 static int ehci_hcd_omap_probe(struct platform_device *pdev)
 {
-	struct ehci_hcd_omap_platform_data *pdata = pdev->dev.platform_data;
+	struct usbhs_omap_board_data *pdata = pdev->dev.platform_data;
 	struct ehci_hcd_omap *omap;
 	struct resource *res;
 	struct usb_hcd *hcd;
@@ -981,7 +981,7 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 
 	/* get ehci regulator and enable */
 	for (i = 0 ; i < OMAP3_HS_USB_PORTS ; i++) {
-		if (omap->port_mode[i] != EHCI_HCD_OMAP_MODE_PHY) {
+		if (omap->port_mode[i] != OMAP_EHCI_PORT_MODE_PHY) {
 			omap->regulator[i] = NULL;
 			continue;
 		}
diff --git a/drivers/usb/host/ohci-omap3.c b/drivers/usb/host/ohci-omap3.c
index 32f56bb..3f9db87 100644
--- a/drivers/usb/host/ohci-omap3.c
+++ b/drivers/usb/host/ohci-omap3.c
@@ -141,7 +141,7 @@ struct ohci_hcd_omap3 {
 	struct clk		*usbtll_ick;
 
 	/* port_mode: TLL/PHY, 2/3/4/6-PIN, DP-DM/DAT-SE0 */
-	enum ohci_omap3_port_mode	port_mode[OMAP3_HS_USB_PORTS];
+	enum usbhs_omap_port_mode	port_mode[OMAP3_HS_USB_PORTS];
 	void __iomem		*uhh_base;
 	void __iomem		*tll_base;
 	void __iomem		*ohci_base;
@@ -206,10 +206,10 @@ static int ohci_omap3_start(struct usb_hcd *hcd)
  * convert the port-mode enum to a value we can use in the FSLSMODE
  * field of USBTLL_CHANNEL_CONF
  */
-static unsigned ohci_omap3_fslsmode(enum ohci_omap3_port_mode mode)
+static unsigned ohci_omap3_fslsmode(enum usbhs_omap_port_mode mode)
 {
 	switch (mode) {
-	case OMAP_OHCI_PORT_MODE_UNUSED:
+	case OMAP_USBHS_PORT_MODE_UNUSED:
 	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0:
 		return 0x0;
 
@@ -266,7 +266,7 @@ static void ohci_omap3_tll_config(struct ohci_hcd_omap3 *omap)
 	for (i = 0; i < OMAP_TLL_CHANNEL_COUNT; i++) {
 
 		/* Enable only those channels that are actually used */
-		if (omap->port_mode[i] == OMAP_OHCI_PORT_MODE_UNUSED)
+		if (omap->port_mode[i] == OMAP_USBHS_PORT_MODE_UNUSED)
 			continue;
 
 		reg = ohci_omap_readl(omap->tll_base, OMAP_TLL_CHANNEL_CONF(i));
@@ -382,11 +382,11 @@ static int omap3_start_ohci(struct ohci_hcd_omap3 *omap, struct usb_hcd *hcd)
 	 *
 	 * For now, turn off all the Pi_CONNECT_STATUS bits
 	 *
-	if (omap->port_mode[0] == OMAP_OHCI_PORT_MODE_UNUSED)
+	if (omap->port_mode[0] == OMAP_USBHS_PORT_MODE_UNUSED)
 		reg &= ~OMAP_UHH_HOSTCONFIG_P1_CONNECT_STATUS;
-	if (omap->port_mode[1] == OMAP_OHCI_PORT_MODE_UNUSED)
+	if (omap->port_mode[1] == OMAP_USBHS_PORT_MODE_UNUSED)
 		reg &= ~OMAP_UHH_HOSTCONFIG_P2_CONNECT_STATUS;
-	if (omap->port_mode[2] == OMAP_OHCI_PORT_MODE_UNUSED)
+	if (omap->port_mode[2] == OMAP_USBHS_PORT_MODE_UNUSED)
 		reg &= ~OMAP_UHH_HOSTCONFIG_P3_CONNECT_STATUS;
 	 */
 	reg &= ~OMAP_UHH_HOSTCONFIG_P1_CONNECT_STATUS;
@@ -403,17 +403,17 @@ static int omap3_start_ohci(struct ohci_hcd_omap3 *omap, struct usb_hcd *hcd)
 		reg |= OMAP_UHH_HOSTCONFIG_ULPI_BYPASS;
 	} else {
 		dev_dbg(omap->dev, "OMAP3 ES version > ES2.1\n");
-		if (omap->port_mode[0] == OMAP_OHCI_PORT_MODE_UNUSED)
+		if (omap->port_mode[0] == OMAP_USBHS_PORT_MODE_UNUSED)
 			reg &= ~OMAP_UHH_HOSTCONFIG_ULPI_P1_BYPASS;
 		else
 			reg |= OMAP_UHH_HOSTCONFIG_ULPI_P1_BYPASS;
 
-		if (omap->port_mode[1] == OMAP_OHCI_PORT_MODE_UNUSED)
+		if (omap->port_mode[1] == OMAP_USBHS_PORT_MODE_UNUSED)
 			reg &= ~OMAP_UHH_HOSTCONFIG_ULPI_P2_BYPASS;
 		else
 			reg |= OMAP_UHH_HOSTCONFIG_ULPI_P2_BYPASS;
 
-		if (omap->port_mode[2] == OMAP_OHCI_PORT_MODE_UNUSED)
+		if (omap->port_mode[2] == OMAP_USBHS_PORT_MODE_UNUSED)
 			reg &= ~OMAP_UHH_HOSTCONFIG_ULPI_P3_BYPASS;
 		else
 			reg |= OMAP_UHH_HOSTCONFIG_ULPI_P3_BYPASS;
@@ -580,7 +580,7 @@ static const struct hc_driver ohci_omap3_hc_driver = {
  */
 static int __devinit ohci_hcd_omap3_probe(struct platform_device *pdev)
 {
-	struct ohci_hcd_omap_platform_data *pdata = pdev->dev.platform_data;
+	struct usbhs_omap_board_data *pdata = pdev->dev.platform_data;
 	struct ohci_hcd_omap3 *omap;
 	struct resource *res;
 	struct usb_hcd *hcd;
-- 
1.7.4.rc2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
