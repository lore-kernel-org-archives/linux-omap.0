From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 8/9] OMAP4: omap4panda: Enable audio support
Date: Thu, 22 Dec 2011 21:34:33 +0200
Message-ID: <1324582474-18181-9-git-send-email-peter.ujfalusi@ti.com>
References: <1324582474-18181-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:56578 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755705Ab1LVTfy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Dec 2011 14:35:54 -0500
Received: by mail-lpp01m010-f50.google.com with SMTP id u2so3476326lag.9
        for <linux-omap@vger.kernel.org>; Thu, 22 Dec 2011 11:35:53 -0800 (PST)
In-Reply-To: <1324582474-18181-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, David Anders <x0132446@ti.com>

PandaBoard has twl6040 codec for audio.
Register the omap4-abe-twl6040 platform device.
Add platform data to enable the twl6040 codec.
Since there is a difference in audio between  PandaBoard 4430
and PandaBoard ES (4460):
Use different name for the sound card:
"OMAP4-Panda" for PandaBoard 4430
"OMAP4-PandaES" for PandaBoard ES

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
CC: David Anders <x0132446@ti.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |   57 +++++++++++++++++++++++++++++++-
 1 files changed, 56 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index b6f1144..8963dfe 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -28,6 +28,7 @@
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
 #include <linux/wl12xx.h>
+#include <linux/platform_data/omap-abe-twl6040.h>
 
 #include <mach/hardware.h>
 #include <asm/hardware/gic.h>
@@ -90,9 +91,31 @@ static struct platform_device leds_gpio = {
 	},
 };
 
+static struct omap_abe_twl6040_data panda_abe_audio_data = {
+	/* Audio out */
+	.has_hs		= ABE_TWL6040_LEFT | ABE_TWL6040_RIGHT,
+	/* HandsFree through expasion connector */
+	.has_hf		= ABE_TWL6040_LEFT | ABE_TWL6040_RIGHT,
+	/* PandaBoard: FM TX, PandaBoardES: can be connected to audio out */
+	.has_aux	= ABE_TWL6040_LEFT | ABE_TWL6040_RIGHT,
+	/* PandaBoard: FM RX, PandaBoardES: audio in */
+	.has_afm	= ABE_TWL6040_LEFT | ABE_TWL6040_RIGHT,
+	/* No jack detection. */
+	.jack_detection	= 0,
+};
+
+static struct platform_device panda_abe_audio = {
+	.name		= "omap-abe-twl6040",
+	.id		= -1,
+	.dev = {
+		.platform_data = &panda_abe_audio_data,
+	},
+};
+
 static struct platform_device *panda_devices[] __initdata = {
 	&leds_gpio,
 	&wl1271_device,
+	&panda_abe_audio,
 };
 
 static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
@@ -251,8 +274,25 @@ static int __init omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers)
 	return 0;
 }
 
+static struct twl4030_codec_data twl6040_codec = {
+	/* single-step ramp for headset and handsfree */
+	.hs_left_step	= 0x0f,
+	.hs_right_step	= 0x0f,
+	.hf_left_step	= 0x1d,
+	.hf_right_step	= 0x1d,
+};
+
+static struct twl4030_audio_data twl6040_audio = {
+	.codec		= &twl6040_codec,
+	.audpwron_gpio	= 127,
+	.naudint_irq	= OMAP44XX_IRQ_SYS_2N,
+	.irq_base	= TWL6040_CODEC_IRQ_BASE,
+};
+
 /* Panda board uses the common PMIC configuration */
-static struct twl4030_platform_data omap4_panda_twldata;
+static struct twl4030_platform_data omap4_panda_twldata = {
+	.audio		= &twl6040_audio,
+};
 
 /*
  * Display monitor features are burnt in their EEPROM as EDID data. The EEPROM
@@ -548,6 +588,20 @@ void omap4_panda_display_init(void)
 	omap_display_init(&omap4_panda_dss_data);
 }
 
+static void omap4_panda_init_rev(void)
+{
+	if (cpu_is_omap4430()) {
+		/* PandaBoard 4430 */
+		/* ASoC audio configuration */
+		panda_abe_audio_data.card_name = "PandaBoard";
+		panda_abe_audio_data.has_hsmic = 1;
+	} else {
+		/* PandaBoard ES */
+		/* ASoC audio configuration */
+		panda_abe_audio_data.card_name = "PandaBoardES";
+	}
+}
+
 static void __init omap4_panda_init(void)
 {
 	int package = OMAP_PACKAGE_CBS;
@@ -559,6 +613,7 @@ static void __init omap4_panda_init(void)
 	if (wl12xx_set_platform_data(&omap_panda_wlan_data))
 		pr_err("error setting wl12xx data\n");
 
+	omap4_panda_init_rev();
 	omap4_panda_i2c_init();
 	platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
 	platform_device_register(&omap_vwlan_device);
-- 
1.7.8.1

