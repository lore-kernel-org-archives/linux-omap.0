From: Maulik Mankad <x0082077@ti.com>
Subject: [PATCH v4 3/4] ARM : OMAP : MUSB : Pass board specific data using a structure
Date: Tue,  2 Feb 2010 17:10:58 +0530
Message-ID: <1265110858-27131-1-git-send-email-x0082077@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44304 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755820Ab0BBLlM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Feb 2010 06:41:12 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org, Maulik Mankad <x0082077@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>, David Brownell <david-b@pacbell.net>, Greg Kroah-Hartman <gregkh@suse.de>, Gupta Ajay Kumar <ajay.gupta@ti.com>

ARM : OMAP: MUSB :Pass board specific data from board file

Pass board specific data for MUSB (like interface_type,
mode etc) from board file by defining board 
specific structure.

Each board file can define this structure based on
its requirement and pass this information to the
driver.

Signed-off-by: Maulik Mankad <x0082077@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: David Brownell <david-b@pacbell.net>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Gupta Ajay Kumar <ajay.gupta@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp.c          |    8 +++++++-
 arch/arm/mach-omap2/board-3430sdp.c          |    8 +++++++-
 arch/arm/mach-omap2/board-cm-t35.c           |    8 +++++++-
 arch/arm/mach-omap2/board-igep0020.c         |    8 +++++++-
 arch/arm/mach-omap2/board-ldp.c              |    8 +++++++-
 arch/arm/mach-omap2/board-omap3beagle.c      |    8 +++++++-
 arch/arm/mach-omap2/board-omap3evm.c         |    8 +++++++-
 arch/arm/mach-omap2/board-omap3pandora.c     |    8 +++++++-
 arch/arm/mach-omap2/board-omap3touchbook.c   |    8 +++++++-
 arch/arm/mach-omap2/board-overo.c            |    8 +++++++-
 arch/arm/mach-omap2/board-rx51.c             |    8 +++++++-
 arch/arm/mach-omap2/board-zoom-peripherals.c |    8 +++++++-
 arch/arm/mach-omap2/usb-musb.c               |    7 +++++--
 arch/arm/plat-omap/include/plat/usb.h        |   10 +++++++++-
 include/linux/usb/musb.h                     |    3 +++
 15 files changed, 101 insertions(+), 15 deletions(-)

Index: linux-2.6/arch/arm/mach-omap2/board-2430sdp.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/board-2430sdp.c
+++ linux-2.6/arch/arm/mach-omap2/board-2430sdp.c
@@ -194,6 +194,12 @@ static struct twl4030_hsmmc_info mmc[] _
 	{}	/* Terminator */
 };
 
+static struct omap_musb_board_data musb_board_data = {
+	.interface_type		= MUSB_INTERFACE_ULPI,
+	.mode			= MUSB_OTG,
+	.power			= 100,
+}
+
 static void __init omap_2430sdp_init(void)
 {
 	int ret;
@@ -203,7 +209,7 @@ static void __init omap_2430sdp_init(voi
 	platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
 	omap_serial_init();
 	twl4030_mmc_init(mmc);
-	usb_musb_init();
+	usb_musb_init(&musb_board_data);
 	board_smc91x_init();
 
 	/* Turn off secondary LCD backlight */
Index: linux-2.6/arch/arm/mach-omap2/board-3430sdp.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/board-3430sdp.c
+++ linux-2.6/arch/arm/mach-omap2/board-3430sdp.c
@@ -650,6 +650,12 @@ static struct omap_board_mux board_mux[]
 #define board_mux	NULL
 #endif
 
+static struct omap_musb_board_data musb_board_data = {
+	.interface_type		= MUSB_INTERFACE_ULPI,
+	.mode			= MUSB_OTG,
+	.power			= 100,
+};
+
 static void __init omap_3430sdp_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
@@ -664,7 +670,7 @@ static void __init omap_3430sdp_init(voi
 				ARRAY_SIZE(sdp3430_spi_board_info));
 	ads7846_dev_init();
 	omap_serial_init();
-	usb_musb_init();
+	usb_musb_init(&musb_board_data);
 	board_smc91x_init();
 	sdp3430_display_init();
 	enable_board_wakeup_source();
Index: linux-2.6/arch/arm/mach-omap2/board-cm-t35.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/board-cm-t35.c
+++ linux-2.6/arch/arm/mach-omap2/board-cm-t35.c
@@ -575,6 +575,12 @@ static struct omap_board_mux board_mux[]
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 
+static struct omap_musb_board_data musb_board_data = {
+	.interface_type		= MUSB_INTERFACE_ULPI,
+	.mode			= MUSB_OTG,
+	.power			= 100,
+};
+
 static void __init cm_t35_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CUS);
@@ -585,7 +591,7 @@ static void __init cm_t35_init(void)
 	cm_t35_init_ethernet();
 	cm_t35_init_led();
 
-	usb_musb_init();
+	usb_musb_init(&musb_board_data);
 }
 
 MACHINE_START(CM_T35, "Compulab CM-T35")
Index: linux-2.6/arch/arm/mach-omap2/board-igep0020.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/board-igep0020.c
+++ linux-2.6/arch/arm/mach-omap2/board-igep0020.c
@@ -211,12 +211,18 @@ static struct omap_board_mux board_mux[]
 #define board_mux	NULL
 #endif
 
+static struct omap_musb_board_data musb_board_data  = {
+	.interface_type		= MUSB_INTERFACE_ULPI,
+	.mode			= MUSB_OTG,
+	.power			= 100,
+};
+
 static void __init igep2_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	igep2_i2c_init();
 	omap_serial_init();
-	usb_musb_init();
+	usb_musb_init(&musb_board_data);
 
 	igep2_init_smsc911x();
 
Index: linux-2.6/arch/arm/mach-omap2/board-ldp.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/board-ldp.c
+++ linux-2.6/arch/arm/mach-omap2/board-ldp.c
@@ -383,6 +383,12 @@ static struct omap_board_mux board_mux[]
 #define board_mux	NULL
 #endif
 
+static struct omap_musb_board_data musb_board_data = {
+	.interface_type		= MUSB_INTERFACE_ULPI,
+	.mode			= MUSB_OTG,
+	.power			= 100,
+};
+
 static void __init omap_ldp_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
@@ -394,7 +400,7 @@ static void __init omap_ldp_init(void)
 				ARRAY_SIZE(ldp_spi_board_info));
 	ads7846_dev_init();
 	omap_serial_init();
-	usb_musb_init();
+	usb_musb_init(&musb_board_data);
 
 	twl4030_mmc_init(mmc);
 	/* link regulators to MMC adapters */
Index: linux-2.6/arch/arm/mach-omap2/board-omap3beagle.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/board-omap3beagle.c
+++ linux-2.6/arch/arm/mach-omap2/board-omap3beagle.c
@@ -430,6 +430,12 @@ static struct omap_board_mux board_mux[]
 #define board_mux	NULL
 #endif
 
+static struct omap_musb_board_data musb_board_data = {
+	.interface_type		= MUSB_INTERFACE_ULPI,
+	.mode			= MUSB_OTG,
+	.power			= 100,
+};
+
 static void __init omap3_beagle_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
@@ -443,7 +449,7 @@ static void __init omap3_beagle_init(voi
 	/* REVISIT leave DVI powered down until it's needed ... */
 	gpio_direction_output(170, true);
 
-	usb_musb_init();
+	usb_musb_init(&musb_board_data);
 	usb_ehci_init(&ehci_pdata);
 	omap3beagle_flash_init();
 
Index: linux-2.6/arch/arm/mach-omap2/board-omap3evm.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/board-omap3evm.c
+++ linux-2.6/arch/arm/mach-omap2/board-omap3evm.c
@@ -430,6 +430,12 @@ static struct omap_board_mux board_mux[]
 #define board_mux	NULL
 #endif
 
+static struct omap_musb_board_data musb_board_data = {
+	.interface_type		= MUSB_INTERFACE_ULPI,
+	.mode			= MUSB_OTG,
+	.power			= 100,
+};
+
 static void __init omap3_evm_init(void)
 {
 	omap3_evm_get_revision();
@@ -469,7 +475,7 @@ static void __init omap3_evm_init(void)
 		omap_mux_init_gpio(135, OMAP_PIN_OUTPUT);
 		ehci_pdata.reset_gpio_port[1] = 135;
 	}
-	usb_musb_init();
+	usb_musb_init(&musb_board_data);
 	usb_ehci_init(&ehci_pdata);
 	ads7846_dev_init();
 	omap3evm_init_smsc911x();
Index: linux-2.6/arch/arm/mach-omap2/board-omap3pandora.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/board-omap3pandora.c
+++ linux-2.6/arch/arm/mach-omap2/board-omap3pandora.c
@@ -401,6 +401,12 @@ static struct omap_board_mux board_mux[]
 #define board_mux	NULL
 #endif
 
+static struct omap_musb_board_data musb_board_data = {
+	.interface_type		= MUSB_INTERFACE_ULPI,
+	.mode			= MUSB_OTG,
+	.power			= 100,
+};
+
 static void __init omap3pandora_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
@@ -413,7 +419,7 @@ static void __init omap3pandora_init(voi
 	omap3pandora_ads7846_init();
 	usb_ehci_init(&ehci_pdata);
 	pandora_keys_gpio_init();
-	usb_musb_init();
+	usb_musb_init(&musb_board_data);
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
Index: linux-2.6/arch/arm/mach-omap2/board-omap3touchbook.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/board-omap3touchbook.c
+++ linux-2.6/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -527,6 +527,12 @@ static void __init early_touchbook_revis
 }
 __early_param("tbr=", early_touchbook_revision);
 
+static struct omap_musb_board_data musb_board_data = {
+	.interface_type		= MUSB_INTERFACE_ULPI,
+	.mode			= MUSB_OTG,
+	.power			= 100,
+};
+
 static void __init omap3_touchbook_init(void)
 {
 	pm_power_off = omap3_touchbook_poweroff;
@@ -545,7 +551,7 @@ static void __init omap3_touchbook_init(
 	spi_register_board_info(omap3_ads7846_spi_board_info,
 				ARRAY_SIZE(omap3_ads7846_spi_board_info));
 	omap3_ads7846_init();
-	usb_musb_init();
+	usb_musb_init(&musb_board_data);
 	usb_ehci_init(&ehci_pdata);
 	omap3touchbook_flash_init();
 
Index: linux-2.6/arch/arm/mach-omap2/board-overo.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/board-overo.c
+++ linux-2.6/arch/arm/mach-omap2/board-overo.c
@@ -413,6 +413,12 @@ static struct omap_board_mux board_mux[]
 #define board_mux	NULL
 #endif
 
+static struct omap_musb_board_data musb_board_data = {
+	.interface_type		= MUSB_INTERFACE_ULPI,
+	.mode			= MUSB_OTG,
+	.power			= 100,
+};
+
 static void __init overo_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
@@ -420,7 +426,7 @@ static void __init overo_init(void)
 	platform_add_devices(overo_devices, ARRAY_SIZE(overo_devices));
 	omap_serial_init();
 	overo_flash_init();
-	usb_musb_init();
+	usb_musb_init(&musb_board_data);
 	usb_ehci_init(&ehci_pdata);
 	overo_ads7846_init();
 	overo_init_smsc911x();
Index: linux-2.6/arch/arm/mach-omap2/board-rx51.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/board-rx51.c
+++ linux-2.6/arch/arm/mach-omap2/board-rx51.c
@@ -78,11 +78,17 @@ static struct omap_board_mux board_mux[]
 #define board_mux	NULL
 #endif
 
+static struct omap_musb_board_data musb_board_data = {
+	.interface_type		= MUSB_INTERFACE_ULPI,
+	.mode			= MUSB_PERIPHERAL,
+	.power			= 0,
+};
+
 static void __init rx51_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap_serial_init();
-	usb_musb_init();
+	usb_musb_init(&musb_board_data);
 	rx51_peripherals_init();
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
Index: linux-2.6/arch/arm/mach-omap2/board-zoom-peripherals.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ linux-2.6/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -263,9 +263,15 @@ static int __init omap_i2c_init(void)
 	return 0;
 }
 
+static struct omap_musb_board_data musb_board_data = {
+	.interface_type		= MUSB_INTERFACE_ULPI,
+	.mode			= MUSB_OTG,
+	.power			= 100,
+};
+
 void __init zoom_peripherals_init(void)
 {
 	omap_i2c_init();
 	omap_serial_init();
-	usb_musb_init();
+	usb_musb_init(&musb_board_data);
 }
Index: linux-2.6/arch/arm/mach-omap2/usb-musb.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/usb-musb.c
+++ linux-2.6/arch/arm/mach-omap2/usb-musb.c
@@ -146,7 +146,7 @@ static struct platform_device musb_devic
 	.resource	= musb_resources,
 };
 
-void __init usb_musb_init(void)
+void __init usb_musb_init(struct omap_musb_board_data *board_data)
 {
 	if (cpu_is_omap243x())
 		musb_resources[0].start = OMAP243X_HS_BASE;
@@ -159,6 +159,9 @@ void __init usb_musb_init(void)
 	 * musb_core.c have been converted to use use clkdev.
 	 */
 	musb_plat.clock = "ick";
+	musb_plat.board_data = board_data;
+	musb_plat.power = board_data->power >> 1;
+	musb_plat.mode = board_data->mode;
 
 	if (platform_device_register(&musb_device) < 0) {
 		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
@@ -167,7 +170,7 @@ void __init usb_musb_init(void)
 }
 
 #else
-void __init usb_musb_init(void)
+void __init usb_musb_init(struct omap_musb_board_data *board_data)
 {
 }
 #endif /* CONFIG_USB_MUSB_SOC */
Index: linux-2.6/arch/arm/plat-omap/include/plat/usb.h
===================================================================
--- linux-2.6.orig/arch/arm/plat-omap/include/plat/usb.h
+++ linux-2.6/arch/arm/plat-omap/include/plat/usb.h
@@ -3,6 +3,7 @@
 #ifndef	__ASM_ARCH_OMAP_USB_H
 #define	__ASM_ARCH_OMAP_USB_H
 
+#include <linux/usb/musb.h>
 #include <plat/board.h>
 
 #define OMAP3_HS_USB_PORTS	3
@@ -42,7 +43,15 @@ struct ehci_hcd_omap_platform_data {
 #define UDC_BASE			OMAP2_UDC_BASE
 #define OMAP_OHCI_BASE			OMAP2_OHCI_BASE
 
-extern void usb_musb_init(void);
+struct omap_musb_board_data {
+	u8	interface_type;
+	u8	mode;
+	u8	power;
+};
+
+enum musb_interface    {MUSB_INTERFACE_ULPI, MUSB_INTERFACE_UTMI};
+
+extern void usb_musb_init(struct omap_musb_board_data *board_data);
 
 extern void usb_ehci_init(struct ehci_hcd_omap_platform_data *pdata);
 
Index: linux-2.6/include/linux/usb/musb.h
===================================================================
--- linux-2.6.orig/include/linux/usb/musb.h
+++ linux-2.6/include/linux/usb/musb.h
@@ -84,6 +84,9 @@ struct musb_hdrc_platform_data {
 
 	/* MUSB configuration-specific details */
 	struct musb_hdrc_config	*config;
+
+	/* Architecture specific board data	*/
+	void		*board_data;
 };
 
 
