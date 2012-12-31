From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/6] ARM: OMAP: zoom: Zoom2 does not have extmute functionality
Date: Mon, 31 Dec 2012 12:02:56 +0100
Message-ID: <1356951780-5412-3-git-send-email-peter.ujfalusi@ti.com>
References: <1356951780-5412-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56210 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116Ab2LaLDw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Dec 2012 06:03:52 -0500
In-Reply-To: <1356951780-5412-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, NeilBrown <neilb@suse.de>

The HS extmute is not used on Zoom2 boards. Furthermore the GPIO153 is used
as IRQ for the TSC2004 touchscreen controller - for which we do not have
driver upstream, yet.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/board-zoom-peripherals.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 26e07ad..03ec6b2 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -34,7 +34,7 @@
 #include "common-board-devices.h"
 
 #define OMAP_ZOOM_WLAN_PMENA_GPIO	(101)
-#define ZOOM2_HEADSET_EXTMUTE_GPIO	(153)
+#define OMAP_ZOOM_TSC2004_IRQ_GPIO	(153)
 #define OMAP_ZOOM_WLAN_IRQ_GPIO		(162)
 
 #define LCD_PANEL_ENABLE_GPIO		(7 + OMAP_MAX_GPIO_LINES)
@@ -264,14 +264,9 @@ static int __init omap_i2c_init(void)
 			TWL_COMMON_PDATA_MADC | TWL_COMMON_PDATA_AUDIO,
 			TWL_COMMON_REGULATOR_VDAC | TWL_COMMON_REGULATOR_VPLL2);
 
-	if (machine_is_omap_zoom2()) {
-		struct twl4030_codec_data *codec_data;
-		codec_data = zoom_twldata.audio->codec;
+	if (machine_is_omap_zoom2())
+		zoom_twldata.audio->codec->ramp_delay_value = 3; /* 161 ms */
 
-		codec_data->ramp_delay_value = 3;	/* 161 ms */
-		codec_data->hs_extmute = 1;
-		codec_data->hs_extmute_gpio = ZOOM2_HEADSET_EXTMUTE_GPIO;
-	}
 	omap_pmic_init(1, 2400, "twl5030", 7 + OMAP_INTC_START, &zoom_twldata);
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	omap_register_i2c_bus(3, 400, NULL, 0);
-- 
1.8.0.2

