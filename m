From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH v2 4/4] omap: musb: introduce default board config
Date: Wed, 27 Apr 2011 11:56:12 +0300
Message-ID: <1303894572-7375-1-git-send-email-mike@compulab.co.il>
References: <c18b58e93a67116f06e8ffbf097c2bd8e4f642a5.1303682352.git.mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:49744
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754521Ab1D0ItG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Apr 2011 04:49:06 -0400
In-Reply-To: <c18b58e93a67116f06e8ffbf097c2bd8e4f642a5.1303682352.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Rapoport <mike@compulab.co.il>

Most boards use exactly the same configuration for musb initialization.
Create a default that can be shared amount different boards.

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
Fixed spelling in $SUBJ, thanks to Felipe Contreras

 arch/arm/mach-omap2/board-2430sdp.c          |    7 +------
 arch/arm/mach-omap2/board-3430sdp.c          |    8 +-------
 arch/arm/mach-omap2/board-cm-t35.c           |    8 +-------
 arch/arm/mach-omap2/board-devkit8000.c       |    8 +-------
 arch/arm/mach-omap2/board-igep0020.c         |    8 +-------
 arch/arm/mach-omap2/board-igep0030.c         |    8 +-------
 arch/arm/mach-omap2/board-ldp.c              |    8 +-------
 arch/arm/mach-omap2/board-omap3beagle.c      |    8 +-------
 arch/arm/mach-omap2/board-omap3pandora.c     |    8 +-------
 arch/arm/mach-omap2/board-omap3stalker.c     |    8 +-------
 arch/arm/mach-omap2/board-omap3touchbook.c   |    8 +-------
 arch/arm/mach-omap2/board-overo.c            |    8 +-------
 arch/arm/mach-omap2/board-rm680.c            |    8 +-------
 arch/arm/mach-omap2/board-zoom-peripherals.c |    8 +-------
 arch/arm/mach-omap2/usb-musb.c               |   14 +++++++++++++-
 15 files changed, 27 insertions(+), 98 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 99b3f2d..a8810f8 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -208,11 +208,6 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 	{}	/* Terminator */
 };
 
-static struct omap_musb_board_data musb_board_data = {
-	.interface_type		= MUSB_INTERFACE_ULPI,
-	.mode			= MUSB_OTG,
-	.power			= 100,
-};
 static struct omap_usb_config sdp2430_usb_config __initdata = {
 	.otg		= 1,
 #ifdef  CONFIG_USB_GADGET_OMAP
@@ -246,7 +241,7 @@ static void __init omap_2430sdp_init(void)
 	omap2_usbfs_init(&sdp2430_usb_config);
 
 	omap_mux_init_signal("usb0hs_stp", OMAP_PULL_ENA | OMAP_PULL_UP);
-	usb_musb_init(&musb_board_data);
+	usb_musb_init(NULL);
 
 	board_smc91x_init();
 
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index b12400e..951e585 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -810,12 +810,6 @@ static struct flash_partitions sdp_flash_partitions[] = {
 	},
 };
 
-static struct omap_musb_board_data musb_board_data = {
-	.interface_type		= MUSB_INTERFACE_ULPI,
-	.mode			= MUSB_OTG,
-	.power			= 100,
-};
-
 static void __init omap_3430sdp_init(void)
 {
 	int gpio_pendown;
@@ -832,7 +826,7 @@ static void __init omap_3430sdp_init(void)
 		gpio_pendown = SDP3430_TS_GPIO_IRQ_SDPV1;
 	omap_ads7846_init(1, gpio_pendown, 310, NULL);
 	board_serial_init();
-	usb_musb_init(&musb_board_data);
+	usb_musb_init(NULL);
 	board_smc91x_init();
 	board_flash_init(sdp_flash_partitions, chip_sel_3430, 0);
 	sdp3430_display_init();
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 1a9e6be..286da17 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -651,12 +651,6 @@ static struct omap_board_mux board_mux[] __initdata = {
 };
 #endif
 
-static struct omap_musb_board_data musb_board_data = {
-	.interface_type		= MUSB_INTERFACE_ULPI,
-	.mode			= MUSB_OTG,
-	.power			= 100,
-};
-
 static struct omap_board_config_kernel cm_t35_config[] __initdata = {
 };
 
@@ -673,7 +667,7 @@ static void __init cm_t35_init(void)
 	cm_t35_init_led();
 	cm_t35_init_display();
 
-	usb_musb_init(&musb_board_data);
+	usb_musb_init(NULL);
 	usbhs_init(&usbhs_bdata);
 }
 
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index e7dc057..405542a 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -509,12 +509,6 @@ static struct platform_device *devkit8000_devices[] __initdata = {
 	&omap_dm9000_dev,
 };
 
-static struct omap_musb_board_data musb_board_data = {
-	.interface_type		= MUSB_INTERFACE_ULPI,
-	.mode			= MUSB_OTG,
-	.power			= 100,
-};
-
 static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
 
 	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
@@ -698,7 +692,7 @@ static void __init devkit8000_init(void)
 
 	omap_ads7846_init(2, OMAP3_DEVKIT_TS_GPIO, 0, NULL);
 
-	usb_musb_init(&musb_board_data);
+	usb_musb_init(NULL);
 	usbhs_init(&usbhs_bdata);
 	omap_nand_flash_init(NAND_BUSWIDTH_16, devkit8000_nand_partitions,
 			     ARRAY_SIZE(devkit8000_nand_partitions));
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index a0fd10e..2c9a919 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -559,12 +559,6 @@ static void __init igep2_i2c_init(void)
 		pr_warning("IGEP2: Could not register I2C3 bus (%d)\n", ret);
 }
 
-static struct omap_musb_board_data musb_board_data = {
-	.interface_type		= MUSB_INTERFACE_ULPI,
-	.mode			= MUSB_OTG,
-	.power			= 100,
-};
-
 static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
 	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
 	.port_mode[1] = OMAP_USBHS_PORT_MODE_UNUSED,
@@ -637,7 +631,7 @@ static void __init igep2_init(void)
 	platform_add_devices(igep2_devices, ARRAY_SIZE(igep2_devices));
 	omap_display_init(&igep2_dss_data);
 	omap_serial_init();
-	usb_musb_init(&musb_board_data);
+	usb_musb_init(NULL);
 	usbhs_init(&usbhs_bdata);
 
 	igep2_flash_init();
diff --git a/arch/arm/mach-omap2/board-igep0030.c b/arch/arm/mach-omap2/board-igep0030.c
index a831e85..512a7eb 100644
--- a/arch/arm/mach-omap2/board-igep0030.c
+++ b/arch/arm/mach-omap2/board-igep0030.c
@@ -357,12 +357,6 @@ static int __init igep3_i2c_init(void)
 	return 0;
 }
 
-static struct omap_musb_board_data musb_board_data = {
-	.interface_type	= MUSB_INTERFACE_ULPI,
-	.mode		= MUSB_OTG,
-	.power		= 100,
-};
-
 #if defined(CONFIG_LIBERTAS_SDIO) || defined(CONFIG_LIBERTAS_SDIO_MODULE)
 
 static void __init igep3_wifi_bt_init(void)
@@ -424,7 +418,7 @@ static void __init igep3_init(void)
 	igep3_i2c_init();
 	platform_add_devices(igep3_devices, ARRAY_SIZE(igep3_devices));
 	omap_serial_init();
-	usb_musb_init(&musb_board_data);
+	usb_musb_init(NULL);
 	usbhs_init(&usbhs_bdata);
 
 	igep3_flash_init();
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 7482c75..f7d6038 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -294,12 +294,6 @@ static struct omap_board_mux board_mux[] __initdata = {
 };
 #endif
 
-static struct omap_musb_board_data musb_board_data = {
-	.interface_type		= MUSB_INTERFACE_ULPI,
-	.mode			= MUSB_OTG,
-	.power			= 100,
-};
-
 static struct mtd_partition ldp_nand_partitions[] = {
 	/* All the partition sizes are listed in terms of NAND block size */
 	{
@@ -342,7 +336,7 @@ static void __init omap_ldp_init(void)
 	platform_add_devices(ldp_devices, ARRAY_SIZE(ldp_devices));
 	omap_ads7846_init(1, 54, 310, NULL);
 	omap_serial_init();
-	usb_musb_init(&musb_board_data);
+	usb_musb_init(NULL);
 	board_nand_init(ldp_nand_partitions,
 		ARRAY_SIZE(ldp_nand_partitions), ZOOM_NAND_CS, 0);
 
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index ce3bc2d..bc30ab0 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -551,12 +551,6 @@ static struct omap_board_mux board_mux[] __initdata = {
 };
 #endif
 
-static struct omap_musb_board_data musb_board_data = {
-	.interface_type		= MUSB_INTERFACE_ULPI,
-	.mode			= MUSB_OTG,
-	.power			= 100,
-};
-
 static void __init beagle_opp_init(void)
 {
 	int r = 0;
@@ -618,7 +612,7 @@ static void __init omap3_beagle_init(void)
 	/* REVISIT leave DVI powered down until it's needed ... */
 	gpio_direction_output(170, true);
 
-	usb_musb_init(&musb_board_data);
+	usb_musb_init(NULL);
 	usbhs_init(&usbhs_bdata);
 	omap_nand_flash_init(NAND_BUSWIDTH_16, omap3beagle_nand_partitions,
 			     ARRAY_SIZE(omap3beagle_nand_partitions));
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index b99cc64..6c22d3f 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -633,12 +633,6 @@ static struct omap_board_mux board_mux[] __initdata = {
 };
 #endif
 
-static struct omap_musb_board_data musb_board_data = {
-	.interface_type		= MUSB_INTERFACE_ULPI,
-	.mode			= MUSB_OTG,
-	.power			= 100,
-};
-
 static void __init omap3pandora_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
@@ -652,7 +646,7 @@ static void __init omap3pandora_init(void)
 			ARRAY_SIZE(omap3pandora_spi_board_info));
 	omap_ads7846_init(1, OMAP3_PANDORA_TS_GPIO, 0, NULL);
 	usbhs_init(&usbhs_bdata);
-	usb_musb_init(&musb_board_data);
+	usb_musb_init(NULL);
 	gpmc_nand_init(&pandora_nand_data);
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index a1d550f..9981d06 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -526,12 +526,6 @@ static struct omap_board_mux board_mux[] __initdata = {
 };
 #endif
 
-static struct omap_musb_board_data musb_board_data = {
-	.interface_type	= MUSB_INTERFACE_ULPI,
-	.mode		= MUSB_OTG,
-	.power		= 100,
-};
-
 static void __init omap3_stalker_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CUS);
@@ -546,7 +540,7 @@ static void __init omap3_stalker_init(void)
 	omap_display_init(&omap3_stalker_dss_data);
 
 	omap_serial_init();
-	usb_musb_init(&musb_board_data);
+	usb_musb_init(NULL);
 	usbhs_init(&usbhs_bdata);
 	omap_ads7846_init(1, OMAP3_STALKER_TS_GPIO, 310, NULL);
 
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index d770802..392278d 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -421,12 +421,6 @@ static int __init early_touchbook_revision(char *p)
 }
 early_param("tbr", early_touchbook_revision);
 
-static struct omap_musb_board_data musb_board_data = {
-	.interface_type		= MUSB_INTERFACE_ULPI,
-	.mode			= MUSB_OTG,
-	.power			= 100,
-};
-
 static void __init omap3_touchbook_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
@@ -447,7 +441,7 @@ static void __init omap3_touchbook_init(void)
 
 	/* Touchscreen and accelerometer */
 	omap_ads7846_init(4, OMAP3_TS_GPIO, 310, &ads7846_pdata);
-	usb_musb_init(&musb_board_data);
+	usb_musb_init(NULL);
 	usbhs_init(&usbhs_bdata);
 	omap_nand_flash_init(NAND_BUSWIDTH_16, omap3touchbook_nand_partitions,
 			     ARRAY_SIZE(omap3touchbook_nand_partitions));
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 9212442..c7ec7fa 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -551,12 +551,6 @@ static struct omap_board_mux board_mux[] __initdata = {
 };
 #endif
 
-static struct omap_musb_board_data musb_board_data = {
-	.interface_type		= MUSB_INTERFACE_ULPI,
-	.mode			= MUSB_OTG,
-	.power			= 100,
-};
-
 static void __init overo_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
@@ -565,7 +559,7 @@ static void __init overo_init(void)
 	omap_serial_init();
 	omap_nand_flash_init(0, overo_nand_partitions,
 			     ARRAY_SIZE(overo_nand_partitions));
-	usb_musb_init(&musb_board_data);
+	usb_musb_init(NULL);
 	usbhs_init(&usbhs_bdata);
 	overo_spi_init();
 	overo_ads7846_init();
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index 8e710ff..42d10b1 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -144,17 +144,11 @@ static struct omap_board_mux board_mux[] __initdata = {
 };
 #endif
 
-static struct omap_musb_board_data rm680_musb_data = {
-	.interface_type	= MUSB_INTERFACE_ULPI,
-	.mode		= MUSB_PERIPHERAL,
-	.power		= 100,
-};
-
 static void __init rm680_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap_serial_init();
-	usb_musb_init(&rm680_musb_data);
+	usb_musb_init(NULL);
 	rm680_peripherals_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index e4870c2..489294a 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -363,12 +363,6 @@ static int __init omap_i2c_init(void)
 	return 0;
 }
 
-static struct omap_musb_board_data musb_board_data = {
-	.interface_type		= MUSB_INTERFACE_ULPI,
-	.mode			= MUSB_OTG,
-	.power			= 100,
-};
-
 static void enable_board_wakeup_source(void)
 {
 	/* T2 interrupt line (keypad) */
@@ -383,7 +377,7 @@ void __init zoom_peripherals_init(void)
 
 	omap_i2c_init();
 	platform_device_register(&omap_vwlan_device);
-	usb_musb_init(&musb_board_data);
+	usb_musb_init(NULL);
 	enable_board_wakeup_source();
 	omap_serial_init();
 }
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 35559f7..dfa5a3c 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -108,7 +108,13 @@ static void usb_musb_mux_init(struct omap_musb_board_data *board_data)
 	}
 }
 
-void __init usb_musb_init(struct omap_musb_board_data *board_data)
+static struct omap_musb_board_data musb_default_board_data = {
+	.interface_type		= MUSB_INTERFACE_ULPI,
+	.mode			= MUSB_OTG,
+	.power			= 100,
+};
+
+void __init usb_musb_init(struct omap_musb_board_data *musb_board_data)
 {
 	struct omap_hwmod		*oh;
 	struct omap_device		*od;
@@ -116,6 +122,12 @@ void __init usb_musb_init(struct omap_musb_board_data *board_data)
 	struct device			*dev;
 	int				bus_id = -1;
 	const char			*oh_name, *name;
+	struct omap_musb_board_data	*board_data;
+
+	if (musb_board_data)
+		board_data = musb_board_data;
+	else
+		board_data = &musb_default_board_data;
 
 	if (cpu_is_omap3517() || cpu_is_omap3505()) {
 	} else if (cpu_is_omap44xx()) {
-- 
1.7.3.1

