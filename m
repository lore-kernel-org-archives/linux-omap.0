From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: [PATCH 07/10 v1] arm: omap: usb: Invoke usbhs core device initialization
Date: Mon, 28 Feb 2011 22:01:49 +0530
Message-ID: <1298910712-2051-8-git-send-email-keshava_mgowda@ti.com>
References: <1298910712-2051-1-git-send-email-keshava_mgowda@ti.com>
 <1298910712-2051-2-git-send-email-keshava_mgowda@ti.com>
 <1298910712-2051-3-git-send-email-keshava_mgowda@ti.com>
 <1298910712-2051-4-git-send-email-keshava_mgowda@ti.com>
 <1298910712-2051-5-git-send-email-keshava_mgowda@ti.com>
 <1298910712-2051-6-git-send-email-keshava_mgowda@ti.com>
 <1298910712-2051-7-git-send-email-keshava_mgowda@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56897 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754335Ab1B1QcW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 11:32:22 -0500
In-Reply-To: <1298910712-2051-7-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, balbi@ti.com, gadiyar@ti.com, p-basak2@ti.com

The usbhs intialization is invoked by all omap3 and omap4
variant board files.

Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c        |    2 +-
 arch/arm/mach-omap2/board-3630sdp.c        |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c        |    2 +-
 arch/arm/mach-omap2/board-am3517crane.c    |    2 +-
 arch/arm/mach-omap2/board-am3517evm.c      |    2 +-
 arch/arm/mach-omap2/board-cm-t35.c         |    2 +-
 arch/arm/mach-omap2/board-cm-t3517.c       |    2 +-
 arch/arm/mach-omap2/board-devkit8000.c     |    2 +-
 arch/arm/mach-omap2/board-igep0020.c       |    2 +-
 arch/arm/mach-omap2/board-igep0030.c       |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c    |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c       |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c   |    2 +-
 arch/arm/mach-omap2/board-omap3stalker.c   |    2 +-
 arch/arm/mach-omap2/board-omap3touchbook.c |    2 +-
 arch/arm/mach-omap2/board-omap4panda.c     |    2 +-
 arch/arm/mach-omap2/board-overo.c          |    2 +-
 arch/arm/mach-omap2/board-zoom.c           |    2 +-
 18 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index a991aeb..7542ba5 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -816,7 +816,7 @@ static void __init omap_3430sdp_init(void)
 	board_flash_init(sdp_flash_partitions, chip_sel_3430);
 	sdp3430_display_init();
 	enable_board_wakeup_source();
-	usb_ehci_init(&usbhs_bdata);
+	usbhs_init(&usbhs_bdata);
 }
 
 MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index 03fd8ac..deed2db 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -211,7 +211,7 @@ static void __init omap_sdp_init(void)
 	board_smc91x_init();
 	board_flash_init(sdp_flash_partitions, chip_sel_sdp);
 	enable_board_wakeup_source();
-	usb_ehci_init(&usbhs_bdata);
+	usbhs_init(&usbhs_bdata);
 }
 
 MACHINE_START(OMAP_3630SDP, "OMAP 3630SDP board")
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 1f59e8d..13cb1cf 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -583,7 +583,7 @@ static void __init omap_4430sdp_init(void)
 	else
 		gpio_direction_output(OMAP4SDP_MDM_PWR_EN_GPIO, 1);
 
-	usb_ehci_init(&usbhs_bdata);
+	usbhs_init(&usbhs_bdata);
 	usb_musb_init(&musb_board_data);
 
 	status = omap_ethernet_init();
diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
index 1b825a0..e3a194f 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -103,7 +103,7 @@ static void __init am3517_crane_init(void)
 		return;
 	}
 
-	usb_ehci_init(&usbhs_bdata);
+	usbhs_init(&usbhs_bdata);
 }
 
 MACHINE_START(CRANEBOARD, "AM3517/05 CRANEBOARD")
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index f5bc1c6..913538a 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -502,7 +502,7 @@ static void __init am3517_evm_init(void)
 
 	/* Configure GPIO for EHCI port */
 	omap_mux_init_gpio(57, OMAP_PIN_OUTPUT);
-	usb_ehci_init(&usbhs_bdata);
+	usbhs_init(&usbhs_bdata);
 	am3517_evm_hecc_init(&am3517_evm_hecc_pdata);
 	/* DSS */
 	am3517_evm_display_init();
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index c79aa9b..9be7289 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -810,7 +810,7 @@ static void __init cm_t35_init(void)
 	cm_t35_init_display();
 
 	usb_musb_init(&musb_board_data);
-	usb_ehci_init(&usbhs_bdata);
+	usbhs_init(&usbhs_bdata);
 }
 
 MACHINE_START(CM_T35, "Compulab CM-T35")
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 8288a0b..8e18dc7 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -192,7 +192,7 @@ static int cm_t3517_init_usbh(void)
 		msleep(1);
 	}
 
-	usb_ehci_init(&cm_t3517_ehci_pdata);
+	usbhs_init(&cm_t3517_ehci_pdata);
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index e0131dd..bc0141b 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -803,7 +803,7 @@ static void __init devkit8000_init(void)
 	devkit8000_ads7846_init();
 
 	usb_musb_init(&musb_board_data);
-	usb_ehci_init(&usbhs_bdata);
+	usbhs_init(&usbhs_bdata);
 	devkit8000_flash_init();
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index a9d7d1d..f9f5344 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -699,7 +699,7 @@ static void __init igep2_init(void)
 	platform_add_devices(igep2_devices, ARRAY_SIZE(igep2_devices));
 	omap_serial_init();
 	usb_musb_init(&musb_board_data);
-	usb_ehci_init(&usbhs_bdata);
+	usbhs_init(&usbhs_bdata);
 
 	igep2_flash_init();
 	igep2_leds_init();
diff --git a/arch/arm/mach-omap2/board-igep0030.c b/arch/arm/mach-omap2/board-igep0030.c
index 1b441ea..579fc2d 100644
--- a/arch/arm/mach-omap2/board-igep0030.c
+++ b/arch/arm/mach-omap2/board-igep0030.c
@@ -435,7 +435,7 @@ static void __init igep3_init(void)
 	platform_add_devices(igep3_devices, ARRAY_SIZE(igep3_devices));
 	omap_serial_init();
 	usb_musb_init(&musb_board_data);
-	usb_ehci_init(&usbhs_bdata);
+	usbhs_init(&usbhs_bdata);
 
 	igep3_flash_init();
 	igep3_leds_init();
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index b84a641..f0963b6 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -625,7 +625,7 @@ static void __init omap3_beagle_init(void)
 	gpio_direction_output(170, true);
 
 	usb_musb_init(&musb_board_data);
-	usb_ehci_init(&usbhs_bdata);
+	usbhs_init(&usbhs_bdata);
 	omap3beagle_flash_init();
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index ed5e411..38a2d91 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -711,7 +711,7 @@ static void __init omap3_evm_init(void)
 		usbhs_bdata.reset_gpio_port[1] = 135;
 	}
 	usb_musb_init(&musb_board_data);
-	usb_ehci_init(&usbhs_bdata);
+	usbhs_init(&usbhs_bdata);
 	ads7846_dev_init();
 	omap3evm_init_smsc911x();
 	omap3_evm_display_init();
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 241e632..aa05f2e 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -716,7 +716,7 @@ static void __init omap3pandora_init(void)
 	spi_register_board_info(omap3pandora_spi_board_info,
 			ARRAY_SIZE(omap3pandora_spi_board_info));
 	omap3pandora_ads7846_init();
-	usb_ehci_init(&usbhs_bdata);
+	usbhs_init(&usbhs_bdata);
 	usb_musb_init(&musb_board_data);
 	gpmc_nand_init(&pandora_nand_data);
 
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index eaad924..f6c8778 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -649,7 +649,7 @@ static void __init omap3_stalker_init(void)
 
 	omap_serial_init();
 	usb_musb_init(&musb_board_data);
-	usb_ehci_init(&usbhs_bdata);
+	usbhs_init(&usbhs_bdata);
 	ads7846_dev_init();
 
 	omap_mux_init_gpio(21, OMAP_PIN_OUTPUT);
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 4e3a1ae..84cfddb 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -527,7 +527,7 @@ static void __init omap3_touchbook_init(void)
 				ARRAY_SIZE(omap3_ads7846_spi_board_info));
 	omap3_ads7846_init();
 	usb_musb_init(&musb_board_data);
-	usb_ehci_init(&usbhs_bdata);
+	usbhs_init(&usbhs_bdata);
 	omap3touchbook_flash_init();
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 7a570d8..b2f2595 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -128,7 +128,7 @@ static void __init omap4_ehci_init(void)
 	gpio_set_value(GPIO_HUB_NRESET, 0);
 	gpio_set_value(GPIO_HUB_NRESET, 1);
 
-	usb_ehci_init(&usbhs_bdata);
+	usbhs_init(&usbhs_bdata);
 
 	/* enable power to hub */
 	gpio_set_value(GPIO_HUB_POWER, 1);
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index f78b74c..08770cc 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -454,7 +454,7 @@ static void __init overo_init(void)
 	omap_serial_init();
 	overo_flash_init();
 	usb_musb_init(&musb_board_data);
-	usb_ehci_init(&usbhs_bdata);
+	usbhs_init(&usbhs_bdata);
 	overo_ads7846_init();
 	overo_init_smsc911x();
 
diff --git a/arch/arm/mach-omap2/board-zoom.c b/arch/arm/mach-omap2/board-zoom.c
index 19b9912..1dd195a 100644
--- a/arch/arm/mach-omap2/board-zoom.c
+++ b/arch/arm/mach-omap2/board-zoom.c
@@ -123,7 +123,7 @@ static void __init omap_zoom_init(void)
 	} else if (machine_is_omap_zoom3()) {
 		omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
 		omap_mux_init_gpio(ZOOM3_EHCI_RESET_GPIO, OMAP_PIN_OUTPUT);
-		usb_ehci_init(&usbhs_bdata);
+		usbhs_init(&usbhs_bdata);
 	}
 
 	board_nand_init(zoom_nand_partitions,
-- 
1.6.0.4

