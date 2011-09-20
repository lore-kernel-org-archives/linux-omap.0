From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 08/10] OMAP: 4430SDP: Remove unneeded lcd config
Date: Tue, 20 Sep 2011 11:18:24 +0300
Message-ID: <1316506706-18941-9-git-send-email-tomi.valkeinen@ti.com>
References: <1316506706-18941-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:37051 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754268Ab1ITITE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Sep 2011 04:19:04 -0400
Received: by bkbzu17 with SMTP id zu17so219707bkb.10
        for <linux-omap@vger.kernel.org>; Tue, 20 Sep 2011 01:19:02 -0700 (PDT)
In-Reply-To: <1316506706-18941-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

4430SDP board file contains some unused old LCD configurations. They are
not used and can be removed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   17 -----------------
 1 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 79c2827..62ec9f5 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -340,11 +340,6 @@ static int __init omap_ethernet_init(void)
 	return status;
 }
 
-static struct platform_device sdp4430_lcd_device = {
-	.name		= "sdp4430_lcd",
-	.id		= -1,
-};
-
 static struct regulator_consumer_supply sdp4430_vbat_supply[] = {
 	REGULATOR_SUPPLY("vddvibl", "twl6040-vibra"),
 	REGULATOR_SUPPLY("vddvibr", "twl6040-vibra"),
@@ -374,21 +369,12 @@ static struct platform_device sdp4430_vbat = {
 };
 
 static struct platform_device *sdp4430_devices[] __initdata = {
-	&sdp4430_lcd_device,
 	&sdp4430_gpio_keys_device,
 	&sdp4430_leds_gpio,
 	&sdp4430_leds_pwm,
 	&sdp4430_vbat,
 };
 
-static struct omap_lcd_config sdp4430_lcd_config __initdata = {
-	.ctrl_name	= "internal",
-};
-
-static struct omap_board_config_kernel sdp4430_config[] __initdata = {
-	{ OMAP_TAG_LCD,		&sdp4430_lcd_config },
-};
-
 static void __init omap_4430sdp_init_early(void)
 {
 	omap2_init_common_infrastructure();
@@ -793,9 +779,6 @@ static void __init omap_4430sdp_init(void)
 		package = OMAP_PACKAGE_CBL;
 	omap4_mux_init(board_mux, NULL, package);
 
-	omap_board_config = sdp4430_config;
-	omap_board_config_size = ARRAY_SIZE(sdp4430_config);
-
 	omap4_i2c_init();
 	omap_sfh7741prox_init();
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
-- 
1.7.4.1

