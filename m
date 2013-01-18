From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 2/8] ARM: OMAP: zoom: Zoom2 does not have extmute functionality
Date: Fri, 18 Jan 2013 15:31:50 +0100
Message-ID: <1358519516-13165-3-git-send-email-peter.ujfalusi@ti.com>
References: <1358519516-13165-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58624 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487Ab3AROcG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jan 2013 09:32:06 -0500
In-Reply-To: <1358519516-13165-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

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
1.8.1

