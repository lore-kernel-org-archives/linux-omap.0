From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 05/10] OMAP4: 4430sdp: Register platform device for OMAP4 audio
Date: Wed, 14 Dec 2011 11:46:58 +0200
Message-ID: <1323856022-24053-6-git-send-email-peter.ujfalusi@ti.com>
References: <1323856022-24053-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:41700 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754583Ab1LNJtO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 04:49:14 -0500
Received: by mail-lpp01m010-f54.google.com with SMTP id l5so266100lah.41
        for <linux-omap@vger.kernel.org>; Wed, 14 Dec 2011 01:49:13 -0800 (PST)
In-Reply-To: <1323856022-24053-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

To avoid breakage in audio support with the coming change
in ASoC machine driver (conversion to platfrom device).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 271e50b..69708a4 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -25,6 +25,7 @@
 #include <linux/regulator/fixed.h>
 #include <linux/leds.h>
 #include <linux/leds_pwm.h>
+#include <linux/platform_data/omap-abe-twl6040.h>
 
 #include <mach/hardware.h>
 #include <mach/omap4-common.h>
@@ -377,12 +378,26 @@ static struct platform_device sdp4430_dmic_codec = {
 	.id	= -1,
 };
 
+static struct omap_abe_twl6040_data sdp4430_abe_audio_data = {
+	.card_name = "OMAP4-SDP4430",
+	.board = OMAP_ABE_TWL6040_SDP4430,
+};
+
+static struct platform_device sdp4430_abe_audio = {
+	.name		= "omap-abe-twl6040",
+	.id		= -1,
+	.dev = {
+		.platform_data = &sdp4430_abe_audio_data,
+	},
+};
+
 static struct platform_device *sdp4430_devices[] __initdata = {
 	&sdp4430_gpio_keys_device,
 	&sdp4430_leds_gpio,
 	&sdp4430_leds_pwm,
 	&sdp4430_vbat,
 	&sdp4430_dmic_codec,
+	&sdp4430_abe_audio,
 };
 
 static struct omap_musb_board_data musb_board_data = {
-- 
1.7.8

