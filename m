From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 4/6] ARM: OMAP2+: twl-common: Allow boards to customize the twl4030 audio setup
Date: Mon, 31 Dec 2012 12:02:58 +0100
Message-ID: <1356951780-5412-5-git-send-email-peter.ujfalusi@ti.com>
References: <1356951780-5412-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55305 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261Ab2LaLDz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Dec 2012 06:03:55 -0500
In-Reply-To: <1356951780-5412-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, NeilBrown <neilb@suse.de>

Boards with special audio routing can pass a custom omap_tw4030_pdata to the
audio machine driver.

At the same time update the board files using the same audio driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/board-cm-t35.c      |  2 +-
 arch/arm/mach-omap2/board-devkit8000.c  |  2 +-
 arch/arm/mach-omap2/board-igep0020.c    |  2 +-
 arch/arm/mach-omap2/board-omap3beagle.c |  2 +-
 arch/arm/mach-omap2/board-omap3evm.c    |  2 +-
 arch/arm/mach-omap2/board-overo.c       |  2 +-
 arch/arm/mach-omap2/twl-common.c        | 22 +++++++++++-----------
 arch/arm/mach-omap2/twl-common.h        |  3 ++-
 8 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index b3102c2..eec635e 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -722,7 +722,7 @@ static void __init cm_t3x_common_init(void)
 	cm_t35_init_ethernet();
 	cm_t35_init_led();
 	cm_t35_init_display();
-	omap_twl4030_audio_init("cm-t3x");
+	omap_twl4030_audio_init("cm-t3x", NULL);
 
 	usb_musb_init(NULL);
 	cm_t35_init_usbh();
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 12865af..f0aa64b 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -627,7 +627,7 @@ static void __init devkit8000_init(void)
 	board_nand_init(devkit8000_nand_partitions,
 			ARRAY_SIZE(devkit8000_nand_partitions), NAND_CS,
 			NAND_BUSWIDTH_16, NULL);
-	omap_twl4030_audio_init("omap3beagle");
+	omap_twl4030_audio_init("omap3beagle", NULL);
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 0f24cb8..d1a7352 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -629,7 +629,7 @@ static void __init igep_init(void)
 
 	igep_flash_init();
 	igep_leds_init();
-	omap_twl4030_audio_init("igep2");
+	omap_twl4030_audio_init("igep2", NULL);
 
 	/*
 	 * WLAN-BT combo module from MuRata which has a Marvell WLAN
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 22c483d..909e7fa 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -524,7 +524,7 @@ static void __init omap3_beagle_init(void)
 	board_nand_init(omap3beagle_nand_partitions,
 			ARRAY_SIZE(omap3beagle_nand_partitions), NAND_CS,
 			NAND_BUSWIDTH_16, NULL);
-	omap_twl4030_audio_init("omap3beagle");
+	omap_twl4030_audio_init("omap3beagle", NULL);
 
 	/* Ensure msecure is mux'd to be able to set the RTC. */
 	omap_mux_init_signal("sys_drm_msecure", OMAP_PIN_OFF_OUTPUT_HIGH);
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 3985f35..8803b5c 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -744,7 +744,7 @@ static void __init omap3_evm_init(void)
 	omap3evm_init_smsc911x();
 	omap3_evm_display_init();
 	omap3_evm_wl12xx_init();
-	omap_twl4030_audio_init("omap3evm");
+	omap_twl4030_audio_init("omap3evm", NULL);
 }
 
 MACHINE_START(OMAP3EVM, "OMAP3 EVM")
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index c8fde3e..fe644eb 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -506,7 +506,7 @@ static void __init overo_init(void)
 	overo_display_init();
 	overo_init_led();
 	overo_init_keys();
-	omap_twl4030_audio_init("overo");
+	omap_twl4030_audio_init("overo", NULL);
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index cd1cba8..931495a 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -529,28 +529,28 @@ void __init omap4_pmic_get_config(struct twl4030_platform_data *pmic_data,
 #include <linux/platform_data/omap-twl4030.h>
 
 /* Commonly used configuration */
-static struct omap_tw4030_pdata omap_twl4030_audio_data = {
-	.has_hs		= OMAP_TWL4030_LEFT | OMAP_TWL4030_RIGHT,
-	.has_hf		= OMAP_TWL4030_LEFT | OMAP_TWL4030_RIGHT,
-	.has_linein	= OMAP_TWL4030_LEFT | OMAP_TWL4030_RIGHT,
-};
+static struct omap_tw4030_pdata omap_twl4030_audio_data;
 
 static struct platform_device audio_device = {
 	.name		= "omap-twl4030",
 	.id		= -1,
-	.dev = {
-		.platform_data = &omap_twl4030_audio_data,
-	},
 };
 
-void __init omap_twl4030_audio_init(char *card_name)
+void __init omap_twl4030_audio_init(char *card_name,
+				    struct omap_tw4030_pdata *pdata)
 {
-	omap_twl4030_audio_data.card_name = card_name;
+	if (!pdata)
+		pdata = &omap_twl4030_audio_data;
+
+	pdata->card_name = card_name;
+
+	audio_device.dev.platform_data = pdata;
 	platform_device_register(&audio_device);
 }
 
 #else /* SOC_OMAP_TWL4030 */
-void __init omap_twl4030_audio_init(char *card_name)
+void __init omap_twl4030_audio_init(char *card_name,
+				    struct omap_tw4030_pdata *pdata)
 {
 	return;
 }
diff --git a/arch/arm/mach-omap2/twl-common.h b/arch/arm/mach-omap2/twl-common.h
index dcfbad5..24b65d0 100644
--- a/arch/arm/mach-omap2/twl-common.h
+++ b/arch/arm/mach-omap2/twl-common.h
@@ -32,6 +32,7 @@
 
 struct twl4030_platform_data;
 struct twl6040_platform_data;
+struct omap_tw4030_pdata;
 struct i2c_board_info;
 
 void omap_pmic_init(int bus, u32 clkrate, const char *pmic_type, int pmic_irq,
@@ -60,6 +61,6 @@ void omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
 void omap4_pmic_get_config(struct twl4030_platform_data *pmic_data,
 			   u32 pdata_flags, u32 regulators_flags);
 
-void omap_twl4030_audio_init(char *card_name);
+void omap_twl4030_audio_init(char *card_name, struct omap_tw4030_pdata *pdata);
 
 #endif /* __OMAP_PMIC_COMMON__ */
-- 
1.8.0.2

