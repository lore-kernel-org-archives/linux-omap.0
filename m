From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 - resend 05/13] OMAP4: 4430sdp: Register platform device for OMAP4 audio
Date: Tue, 24 Jan 2012 13:52:22 +0200
Message-ID: <1327405950-6676-6-git-send-email-peter.ujfalusi@ti.com>
References: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:59181 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756403Ab2AXLw4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 06:52:56 -0500
Received: by lahl5 with SMTP id l5so453910lah.17
        for <linux-omap@vger.kernel.org>; Tue, 24 Jan 2012 03:52:54 -0800 (PST)
In-Reply-To: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

To avoid breakage in audio support with the coming change
in ASoC machine driver (conversion to platfrom device).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 39fba9d..7eaeb08 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -41,6 +41,7 @@
 #include <video/omap-panel-nokia-dsi.h>
 #include <video/omap-panel-picodlp.h>
 #include <linux/wl12xx.h>
+#include <linux/platform_data/omap-abe-twl6040.h>
 
 #include "mux.h"
 #include "hsmmc.h"
@@ -377,12 +378,40 @@ static struct platform_device sdp4430_dmic_codec = {
 	.id	= -1,
 };
 
+static struct omap_abe_twl6040_data sdp4430_abe_audio_data = {
+	.card_name = "SDP4430",
+	.has_hs		= ABE_TWL6040_LEFT | ABE_TWL6040_RIGHT,
+	.has_hf		= ABE_TWL6040_LEFT | ABE_TWL6040_RIGHT,
+	.has_ep		= 1,
+	.has_aux	= ABE_TWL6040_LEFT | ABE_TWL6040_RIGHT,
+	.has_vibra	= ABE_TWL6040_LEFT | ABE_TWL6040_RIGHT,
+
+	.has_dmic	= 1,
+	.has_hsmic	= 1,
+	.has_mainmic	= 1,
+	.has_submic	= 1,
+	.has_afm	= ABE_TWL6040_LEFT | ABE_TWL6040_RIGHT,
+
+	.jack_detection = 1,
+	/* MCLK input is 38.4MHz */
+	.mclk_freq	= 38400000,
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
1.7.8.3

