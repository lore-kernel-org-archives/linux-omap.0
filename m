From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/8] OMAP3: Setup MUX settings for SDRC CKE signals
Date: Fri, 24 Jul 2009 20:11:26 -0600
Message-ID: <20090725021123.29059.43604.stgit@localhost.localdomain>
References: <20090725021102.29059.94214.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50648 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539AbZGYCND (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jul 2009 22:13:03 -0400
In-Reply-To: <20090725021102.29059.94214.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jean Pihet <jpihet@mvista.com>

From: Jean Pihet <jpihet@mvista.com>

This patches ensures the MUX settings are correct for the SDRC
CKE signals to SDRAM. This allows the self-refresh to work when
2 chip-selects are in use.

A warning is thrown away in case the initial muxing is incorrect,
in order to track faulty or old-dated bootloaders.
Note: The CONFIG_OMAP_MUX and CONFIG_OMAP_MUX_WARNINGS options
must be enabled for the mux code to have effect.

Signed-off-by: Jean Pihet <jpihet@mvista.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c  |    4 ++++
 arch/arm/mach-omap2/board-omap3pandora.c |    5 +++++
 arch/arm/mach-omap2/board-overo.c        |    5 +++++
 arch/arm/mach-omap2/board-rx51.c         |    4 ++++
 arch/arm/mach-omap2/mux.c                |    6 ++++++
 arch/arm/plat-omap/include/mach/mux.h    |    4 ++++
 6 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 4abefd9..e00ba12 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -409,6 +409,10 @@ static void __init omap3_beagle_init(void)
 
 	usb_musb_init();
 	omap3beagle_flash_init();
+
+	/* Ensure SDRC pins are mux'd for self-refresh */
+	omap_cfg_reg(H16_34XX_SDRC_CKE0);
+	omap_cfg_reg(H17_34XX_SDRC_CKE1);
 }
 
 static void __init omap3_beagle_map_io(void)
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 9b991ce..864ee3d 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -40,6 +40,7 @@
 #include <mach/mcspi.h>
 #include <mach/usb.h>
 #include <mach/keypad.h>
+#include <mach/mux.h>
 
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "mmc-twl4030.h"
@@ -398,6 +399,10 @@ static void __init omap3pandora_init(void)
 	omap3pandora_ads7846_init();
 	pandora_keys_gpio_init();
 	usb_musb_init();
+
+	/* Ensure SDRC pins are mux'd for self-refresh */
+	omap_cfg_reg(H16_34XX_SDRC_CKE0);
+	omap_cfg_reg(H17_34XX_SDRC_CKE1);
 }
 
 static void __init omap3pandora_map_io(void)
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 44bc1c5..6b171b3 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -44,6 +44,7 @@
 #include <mach/gpmc.h>
 #include <mach/hardware.h>
 #include <mach/nand.h>
+#include <mach/mux.h>
 #include <mach/usb.h>
 
 #include "sdram-micron-mt46h32m32lf-6.h"
@@ -396,6 +397,10 @@ static void __init overo_init(void)
 	overo_ads7846_init();
 	overo_init_smsc911x();
 
+	/* Ensure SDRC pins are mux'd for self-refresh */
+	omap_cfg_reg(H16_34XX_SDRC_CKE0);
+	omap_cfg_reg(H17_34XX_SDRC_CKE1);
+
 	if ((gpio_request(OVERO_GPIO_W2W_NRESET,
 			  "OVERO_GPIO_W2W_NRESET") == 0) &&
 	    (gpio_direction_output(OVERO_GPIO_W2W_NRESET, 1) == 0)) {
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 591ae8a..1c9e07f 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -75,6 +75,10 @@ static void __init rx51_init(void)
 	omap_serial_init();
 	usb_musb_init();
 	rx51_peripherals_init();
+
+	/* Ensure SDRC pins are mux'd for self-refresh */
+	omap_cfg_reg(H16_34XX_SDRC_CKE0);
+	omap_cfg_reg(H17_34XX_SDRC_CKE1);
 }
 
 static void __init rx51_map_io(void)
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 026c4fc..43d6b92 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -486,6 +486,12 @@ MUX_CFG_34XX("H19_34XX_GPIO164_OUT", 0x19c,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
 MUX_CFG_34XX("J25_34XX_GPIO170", 0x1c6,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+
+/* OMAP3 SDRC CKE signals to SDR/DDR ram chips */
+MUX_CFG_34XX("H16_34XX_SDRC_CKE0", 0x262,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("H17_34XX_SDRC_CKE1", 0x264,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_OUTPUT)
 };
 
 #define OMAP34XX_PINS_SZ	ARRAY_SIZE(omap34xx_pins)
diff --git a/arch/arm/plat-omap/include/mach/mux.h b/arch/arm/plat-omap/include/mach/mux.h
index 85a6217..80281c4 100644
--- a/arch/arm/plat-omap/include/mach/mux.h
+++ b/arch/arm/plat-omap/include/mach/mux.h
@@ -853,6 +853,10 @@ enum omap34xx_index {
 	AE5_34XX_GPIO143,
 	H19_34XX_GPIO164_OUT,
 	J25_34XX_GPIO170,
+
+	/* OMAP3 SDRC CKE signals to SDR/DDR ram chips */
+	H16_34XX_SDRC_CKE0,
+	H17_34XX_SDRC_CKE1,
 };
 
 struct omap_mux_cfg {


