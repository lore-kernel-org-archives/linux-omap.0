From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] OMAP3: RX51: support sleep indicator LEDs
Date: Fri,  2 Oct 2009 08:35:55 -0700
Message-ID: <1254497755-1822-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:38883 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756549AbZJBPfw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Oct 2009 11:35:52 -0400
Received: by pxi9 with SMTP id 9so1214073pxi.4
        for <linux-omap@vger.kernel.org>; Fri, 02 Oct 2009 08:35:56 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The sleep indicator LEDs can be enabled/disabled by toggling GPIO162.
Request this GPIO in RX51 board init, disable by default and expose
GPIO162 to userspace so LEDs can be toggled from userspace:

To enable:

  # echo 1 > /sys/class/gpio/gpio162/value

To disable:

  # echo 0 > /sys/class/gpio/gpio162/value

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/board-rx51.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index f9196c3..6ad44d8 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -31,6 +31,8 @@
 #include <mach/gpmc.h>
 #include <mach/usb.h>
 
+#define RX51_GPIO_SLEEP_IND 162
+
 static struct omap_lcd_config rx51_lcd_config = {
 	.ctrl_name	= "internal",
 };
@@ -74,6 +76,11 @@ static void __init rx51_init(void)
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_cfg_reg(H16_34XX_SDRC_CKE0);
 	omap_cfg_reg(H17_34XX_SDRC_CKE1);
+
+	if (!(gpio_request(RX51_GPIO_SLEEP_IND, "SLEEP_IND"))) {
+		gpio_direction_output(RX51_GPIO_SLEEP_IND, 0);
+		gpio_export(RX51_GPIO_SLEEP_IND, 1);
+	}
 }
 
 static void __init rx51_map_io(void)
-- 
1.6.4.3

