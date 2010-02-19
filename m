From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/11] omap: musb: Pass board specific data from board file
Date: Fri, 19 Feb 2010 15:30:21 -0800
Message-ID: <20100219233021.10559.60621.stgit@baageli.muru.com>
References: <20100219232648.10559.380.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52149 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756274Ab0BSX3c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Feb 2010 18:29:32 -0500
In-Reply-To: <20100219232648.10559.380.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Maulik Mankad <x0082077@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, David Brownell <david-b@pacbell.net>, Gupta Ajay Kumar <ajay.gupta@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

From: Maulik Mankad <x0082077@ti.com>

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
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-2430sdp.c          |    8 +++++++-
 arch/arm/mach-omap2/board-3430sdp.c          |    8 +++++++-
 arch/arm/mach-omap2/board-cm-t35.c           |    8 +++++++-
 arch/arm/mach-omap2/board-devkit8000.c       |    8 +++++++-
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
 arch/arm/plat-omap/include/plat/usb.h        |   11 ++++++++++-
 include/linux/usb/musb.h                     |    3 +++
 16 files changed, 109 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index d6f55ef..01d113f 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -193,6 +193,12 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 	{}	/* Terminator */
 };
 
+static struct omap_musb_board_data musb_board_data = {
+	.interface_type		= MUSB_INTERFACE_ULPI,
+	.mode			= MUSB_OTG,
+	.power			= 100,
+};
+
 static void __init omap_2430sdp_init(void)
 {
 	int ret;
@@ -202,7 +208,7 @@ static void __init omap_2430sdp_init(void)
 	platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
 	omap_serial_init();
 	omap2_hsmmc_init(mmc);
-	usb_musb_init();
+	usb_musb_init(&musb_board_data);
 	board_smc91x_init();
 
 	/* Turn off secondary LCD backlight */
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 5adef51..a10e96f 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -760,6 +760,12 @@ static struct flash_partitions sdp_flash_partitions[] = {
 	},
 };
 
+static struct omap_musb_board_data musb_board_data = {
+	.interface_type		= MUSB_INTERFACE_ULPI,
+	.mode			= MUSB_OTG,
+	.power			= 100,
+};
+
 static void __init omap_3430sdp_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
@@ -774,7 +780,7 @@ static void __init omap_3430sdp_init(void)
 				ARRAY_SIZE(sdp3430_spi_board_info));
 	ads7846_dev_init();
 	omap_serial_init();
-	usb_musb_init();
+	usb_musb_init(&musb_board_data);
 	board_smc91x_init();
 	sdp_flash_init(sdp_flash_partitions);
 	sdp3430_display_init();
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 8659c3e..afa77ca 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -811,6 +811,12 @@ static struct omap_board_mux board_mux[] __initdata = {
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
@@ -822,7 +828,7 @@ static void __init cm_t35_init(void)
 	cm_t35_init_led();
 	cm_t35_init_display();
 
-	usb_musb_init();
+	usb_musb_init(&musb_board_data);
 }
 
 MACHINE_START(CM_T35, "Compulab CM-T35")
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 89a55f1..3710190 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -630,6 +630,12 @@ static void __init devkit8000_flash_init(void)
 	}
 }
 
+static struct omap_musb_board_data musb_board_data = {
+	.interface_type		= MUSB_INTERFACE_ULPI,
+	.mode			= MUSB_OTG,
+	.power			= 100,
+};
+
 static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
@@ -665,7 +671,7 @@ static void __init devkit8000_init(void)
 	/* REVISIT leave DVI powered down until it's needed ... */
 	gpio_direction_output(170, true);
 
-	usb_musb_init();
+	usb_musb_init(&musb_board_data);
 	usb_ehci_init(&ehci_pdata);
 	devkit8000_flash_init();
 
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 748f418..9958987 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -436,6 +436,12 @@ static int __init igep2_i2c_init(void)
 	return 0;
 }
 
+static struct omap_musb_board_data musb_board_data = {
+	.interface_type		= MUSB_INTERFACE_ULPI,
+	.mode			= MUSB_OTG,
+	.power			= 100,
+};
+
 static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_UNKNOWN,
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
@@ -461,7 +467,7 @@ static void __init igep2_init(void)
 	igep2_i2c_init();
 	platform_add_devices(igep2_devices, ARRAY_SIZE(igep2_devices));
 	omap_serial_init();
-	usb_musb_init();
+	usb_musb_init(&musb_board_data);
 	usb_ehci_init(&ehci_pdata);
 
 	igep2_flash_init();
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 095adcb..5fcb52e 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -383,6 +383,12 @@ static struct omap_board_mux board_mux[] __initdata = {
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
 
 	omap2_hsmmc_init(mmc);
 	/* link regulators to MMC adapters */
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 1bae699..6eb77e1 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -430,6 +430,12 @@ static struct omap_board_mux board_mux[] __initdata = {
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
@@ -443,7 +449,7 @@ static void __init omap3_beagle_init(void)
 	/* REVISIT leave DVI powered down until it's needed ... */
 	gpio_direction_output(170, true);
 
-	usb_musb_init();
+	usb_musb_init(&musb_board_data);
 	usb_ehci_init(&ehci_pdata);
 	omap3beagle_flash_init();
 
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 57506da..d6bc88c 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -662,6 +662,12 @@ static struct omap_board_mux board_mux[] __initdata = {
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
@@ -701,7 +707,7 @@ static void __init omap3_evm_init(void)
 		omap_mux_init_gpio(135, OMAP_PIN_OUTPUT);
 		ehci_pdata.reset_gpio_port[1] = 135;
 	}
-	usb_musb_init();
+	usb_musb_init(&musb_board_data);
 	usb_ehci_init(&ehci_pdata);
 	ads7846_dev_init();
 	omap3evm_init_smsc911x();
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index a0acf8d..4827f46 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -557,6 +557,12 @@ static struct omap_board_mux board_mux[] __initdata = {
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
@@ -569,7 +575,7 @@ static void __init omap3pandora_init(void)
 	omap3pandora_ads7846_init();
 	usb_ehci_init(&ehci_pdata);
 	pandora_keys_gpio_init();
-	usb_musb_init();
+	usb_musb_init(&musb_board_data);
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 8252ba4..3943d0f 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -527,6 +527,12 @@ static void __init early_touchbook_revision(char **p)
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
@@ -545,7 +551,7 @@ static void __init omap3_touchbook_init(void)
 	spi_register_board_info(omap3_ads7846_spi_board_info,
 				ARRAY_SIZE(omap3_ads7846_spi_board_info));
 	omap3_ads7846_init();
-	usb_musb_init();
+	usb_musb_init(&musb_board_data);
 	usb_ehci_init(&ehci_pdata);
 	omap3touchbook_flash_init();
 
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 7e6aa82..50872a4 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -413,6 +413,12 @@ static struct omap_board_mux board_mux[] __initdata = {
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
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 6a49f91..0ccb8b4 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -78,11 +78,17 @@ static struct omap_board_mux board_mux[] __initdata = {
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
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 9a0821f..ca95d8d 100755
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -264,6 +264,12 @@ static int __init omap_i2c_init(void)
 	return 0;
 }
 
+static struct omap_musb_board_data musb_board_data = {
+	.interface_type		= MUSB_INTERFACE_ULPI,
+	.mode			= MUSB_OTG,
+	.power			= 100,
+};
+
 static void enable_board_wakeup_source(void)
 {
 	/* T2 interrupt line (keypad) */
@@ -275,6 +281,6 @@ void __init zoom_peripherals_init(void)
 {
 	omap_i2c_init();
 	omap_serial_init();
-	usb_musb_init();
+	usb_musb_init(&musb_board_data);
 	enable_board_wakeup_source();
 }
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index ba71f76..2ddc316 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -146,7 +146,7 @@ static struct platform_device musb_device = {
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
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index 33a500e..288e29e 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
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
 
diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
index d437556..5dc2f22 100644
--- a/include/linux/usb/musb.h
+++ b/include/linux/usb/musb.h
@@ -84,6 +84,9 @@ struct musb_hdrc_platform_data {
 
 	/* MUSB configuration-specific details */
 	struct musb_hdrc_config	*config;
+
+	/* Architecture specific board data	*/
+	void		*board_data;
 };
 
 

