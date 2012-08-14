From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 3/4] ARM: OMAP3: Switch to use the unified audio driver (omap-twl4030) for selected boards
Date: Tue, 14 Aug 2012 12:07:58 +0300
Message-ID: <1344935279-32364-4-git-send-email-peter.ujfalusi@ti.com>
References: <1344935279-32364-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:47178 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755456Ab2HNJH6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Aug 2012 05:07:58 -0400
Received: by obbwc18 with SMTP id wc18so275713obb.29
        for <linux-omap@vger.kernel.org>; Tue, 14 Aug 2012 02:07:57 -0700 (PDT)
In-Reply-To: <1344935279-32364-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Steve Sakoman <steve@sakoman.com>, Anuj Aggarwal <anuj.aggarwal@ti.com>, Benoit Cousson <b-cousson@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Igor Grinberg <grinberg@compulab.co.il>

These boards have similar audio setup and they can all use the same driver
for audio support if it is enabled in the kernel config.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-cm-t35.c      |    1 +
 arch/arm/mach-omap2/board-devkit8000.c  |    1 +
 arch/arm/mach-omap2/board-igep0020.c    |    1 +
 arch/arm/mach-omap2/board-omap3beagle.c |    1 +
 arch/arm/mach-omap2/board-omap3evm.c    |    1 +
 arch/arm/mach-omap2/board-overo.c       |    1 +
 6 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 97d7190..188cc4e 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -731,6 +731,7 @@ static void __init cm_t3x_common_init(void)
 	cm_t35_init_ethernet();
 	cm_t35_init_led();
 	cm_t35_init_display();
+	omap_twl4030_audio_init("cm-t3x");
 
 	usb_musb_init(NULL);
 	cm_t35_init_usbh();
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 6567c1c..4cd804f 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -630,6 +630,7 @@ static void __init devkit8000_init(void)
 	usbhs_init(&usbhs_bdata);
 	omap_nand_flash_init(NAND_BUSWIDTH_16, devkit8000_nand_partitions,
 			     ARRAY_SIZE(devkit8000_nand_partitions));
+	omap_twl4030_audio_init("omap3beagle");
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 7491529..293fc9c 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -626,6 +626,7 @@ static void __init igep_init(void)
 
 	igep_flash_init();
 	igep_leds_init();
+	omap_twl4030_audio_init("igep2");
 
 	/*
 	 * WLAN-BT combo module from MuRata which has a Marvell WLAN
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 6202fc7..3ccfa5b 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -519,6 +519,7 @@ static void __init omap3_beagle_init(void)
 	usbhs_init(&usbhs_bdata);
 	omap_nand_flash_init(NAND_BUSWIDTH_16, omap3beagle_nand_partitions,
 			     ARRAY_SIZE(omap3beagle_nand_partitions));
+	omap_twl4030_audio_init("omap3beagle");
 
 	/* Ensure msecure is mux'd to be able to set the RTC. */
 	omap_mux_init_signal("sys_drm_msecure", OMAP_PIN_OFF_OUTPUT_HIGH);
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index ef230a0..46e6eca 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -736,6 +736,7 @@ static void __init omap3_evm_init(void)
 	omap3evm_init_smsc911x();
 	omap3_evm_display_init();
 	omap3_evm_wl12xx_init();
+	omap_twl4030_audio_init("omap3evm");
 }
 
 MACHINE_START(OMAP3EVM, "OMAP3 EVM")
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 779734d..fe674d0 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -509,6 +509,7 @@ static void __init overo_init(void)
 	overo_display_init();
 	overo_init_led();
 	overo_init_keys();
+	omap_twl4030_audio_init("overo");
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
-- 
1.7.8.6

