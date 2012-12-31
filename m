From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 6/6] ARM: OMAP: sdp3430: Audio support via the common omap-twl4030 machine driver
Date: Mon, 31 Dec 2012 12:03:00 +0100
Message-ID: <1356951780-5412-7-git-send-email-peter.ujfalusi@ti.com>
References: <1356951780-5412-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56215 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287Ab2LaLD5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Dec 2012 06:03:57 -0500
In-Reply-To: <1356951780-5412-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, NeilBrown <neilb@suse.de>

Use the common omap-twl4030 ASoC machine driver for audio.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 40c22a7..e7ef311 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -25,6 +25,7 @@
 #include <linux/gpio.h>
 #include <linux/mmc/host.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
+#include <linux/platform_data/omap-twl4030.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -209,6 +210,19 @@ static struct omap2_hsmmc_info mmc[] = {
 	{}	/* Terminator */
 };
 
+static struct omap_tw4030_pdata omap_twl4030_audio_data = {
+	.voice_connected = true,
+	.custom_routing	= true,
+
+	.has_hs		= OMAP_TWL4030_LEFT | OMAP_TWL4030_RIGHT,
+	.has_hf		= OMAP_TWL4030_LEFT | OMAP_TWL4030_RIGHT,
+
+	.has_mainmic	= true,
+	.has_submic	= true,
+	.has_hsmic	= true,
+	.has_linein	= OMAP_TWL4030_LEFT | OMAP_TWL4030_RIGHT,
+};
+
 static int sdp3430_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
@@ -225,6 +239,9 @@ static int sdp3430_twl_gpio_setup(struct device *dev,
 	/* gpio + 15 is "sub_lcd_nRST" (output) */
 	gpio_request_one(gpio + 15, GPIOF_OUT_INIT_LOW, "sub_lcd_nRST");
 
+	omap_twl4030_audio_data.jack_detect = gpio + 2;
+	omap_twl4030_audio_init("SDP3430", &omap_twl4030_audio_data);
+
 	return 0;
 }
 
-- 
1.8.0.2

