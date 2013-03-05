From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] ARM: OMAP: RX-51: add missing USB phy binding
Date: Tue,  5 Mar 2013 13:09:40 +0200
Message-ID: <1362481780-11018-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:52100 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558Ab3CELJu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Mar 2013 06:09:50 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

Commit 51482be9 (ARM: OMAP: USB: Add phy binding information) forgot to
add phy binding for RX-51, and as a result USB does not work anymore on
3.9-rc1. Add the missing binding.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap2/board-rx51.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index f7c4616..d2ea68e 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
+#include <linux/usb/phy.h>
 #include <linux/usb/musb.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 
@@ -98,6 +99,7 @@ static void __init rx51_init(void)
 	sdrc_params = nokia_get_sdram_timings();
 	omap_sdrc_init(sdrc_params, sdrc_params);
 
+	usb_bind_phy("musb-hdrc.0.auto", 0, "twl4030_usb");
 	usb_musb_init(&musb_board_data);
 	rx51_peripherals_init();
 
-- 
1.7.10.4

