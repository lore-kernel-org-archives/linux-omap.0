From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/4] ARM: OMAP3: Switch to use the unified audio driver (omap-twl4030) for selected boards
Date: Wed,  8 Aug 2012 12:54:09 +0300
Message-ID: <1344419650-5389-4-git-send-email-peter.ujfalusi@ti.com>
References: <1344419650-5389-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:41014 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030204Ab2HHJyi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 05:54:38 -0400
Received: by obbta17 with SMTP id ta17so1120858obb.8
        for <linux-omap@vger.kernel.org>; Wed, 08 Aug 2012 02:54:37 -0700 (PDT)
In-Reply-To: <1344419650-5389-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>, Anuj Aggarwal <anuj.aggarwal@ti.com>, devicetree-discuss@lists.ozlabs.org

These boards have similar audio setup and they can all use the same driver
for audio support if it is enabled in the kernel config.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/board-cm-t35.c      |    1 +
 arch/arm/mach-omap2/board-devkit8000.c  |    1 +
 arch/arm/mach-omap2/board-igep0020.c    |    1 +
 arch/arm/mach-omap2/board-omap3beagle.c |    1 +
 arch/arm/mach-omap2/board-omap3evm.c    |    1 +
 arch/arm/mach-omap2/board-overo.c       |    1 +
 6 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 97d7190..b73fa5c 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -731,6 +731,7 @@ static void __init cm_t3x_common_init(void)
 	cm_t35_init_ethernet();
 	cm_t35_init_led();
 	cm_t35_init_display();
+	omap_twl4030_audio_init("overo", 26000000);
 
 	usb_musb_init(NULL);
 	cm_t35_init_usbh();
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 6567c1c..f834b3e 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -630,6 +630,7 @@ static void __init devkit8000_init(void)
 	usbhs_init(&usbhs_bdata);
 	omap_nand_flash_init(NAND_BUSWIDTH_16, devkit8000_nand_partitions,
 			     ARRAY_SIZE(devkit8000_nand_partitions));
+	omap_twl4030_audio_init("omap3beagle", 26000000);
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 7491529..bc7c1ea 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -626,6 +626,7 @@ static void __init igep_init(void)
 
 	igep_flash_init();
 	igep_leds_init();
+	omap_twl4030_audio_init("igep2", 26000000);
 
 	/*
 	 * WLAN-BT combo module from MuRata which has a Marvell WLAN
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 6202fc7..dd6e4f0 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -519,6 +519,7 @@ static void __init omap3_beagle_init(void)
 	usbhs_init(&usbhs_bdata);
 	omap_nand_flash_init(NAND_BUSWIDTH_16, omap3beagle_nand_partitions,
 			     ARRAY_SIZE(omap3beagle_nand_partitions));
+	omap_twl4030_audio_init("omap3beagle", 26000000);
 
 	/* Ensure msecure is mux'd to be able to set the RTC. */
 	omap_mux_init_signal("sys_drm_msecure", OMAP_PIN_OFF_OUTPUT_HIGH);
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index ef230a0..1be8f6e 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -736,6 +736,7 @@ static void __init omap3_evm_init(void)
 	omap3evm_init_smsc911x();
 	omap3_evm_display_init();
 	omap3_evm_wl12xx_init();
+	omap_twl4030_audio_init("omap3evm", 26000000);
 }
 
 MACHINE_START(OMAP3EVM, "OMAP3 EVM")
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 779734d..7b7db3d 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -509,6 +509,7 @@ static void __init overo_init(void)
 	overo_display_init();
 	overo_init_led();
 	overo_init_keys();
+	omap_twl4030_audio_init("overo", 26000000);
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
-- 
1.7.8.6

