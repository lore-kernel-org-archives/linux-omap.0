From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [RFC/RFT] OMAP: N770: remove custom implementation of
 ads7846_get_pendown_state
Date: Tue, 20 Nov 2012 00:30:53 -0800
Message-ID: <20121120083052.GA29020@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37316 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883Ab2KTIa5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Nov 2012 03:30:57 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so4111589pbc.19
        for <linux-omap@vger.kernel.org>; Tue, 20 Nov 2012 00:30:57 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org

The default implementation matches exactly our custom one so we can switch
to using the default one. As a bonus the driver will take care of setting
GPIO line for us.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

No hardware so not tested...

Thanks!

 arch/arm/mach-omap1/board-nokia770.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 7d5c06d..be6490b 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -112,17 +112,6 @@ static void __init mipid_dev_init(void)
 	omapfb_set_lcd_config(&nokia770_lcd_config);
 }
 
-static void __init ads7846_dev_init(void)
-{
-	if (gpio_request(ADS7846_PENDOWN_GPIO, "ADS7846 pendown") < 0)
-		printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
-}
-
-static int ads7846_get_pendown_state(void)
-{
-	return !gpio_get_value(ADS7846_PENDOWN_GPIO);
-}
-
 static struct ads7846_platform_data nokia770_ads7846_platform_data __initdata = {
 	.x_max		= 0x0fff,
 	.y_max		= 0x0fff,
@@ -131,7 +120,7 @@ static struct ads7846_platform_data nokia770_ads7846_platform_data __initdata =
 	.debounce_max	= 10,
 	.debounce_tol	= 3,
 	.debounce_rep	= 1,
-	.get_pendown_state	= ads7846_get_pendown_state,
+	.gpio_pendown	= ADS7846_PENDOWN_GPIO,
 };
 
 static struct spi_board_info nokia770_spi_board_info[] __initdata = {
@@ -241,7 +230,6 @@ static void __init omap_nokia770_init(void)
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
 	hwa742_dev_init();
-	ads7846_dev_init();
 	mipid_dev_init();
 	omap1_usb_init(&nokia770_usb_config);
 	nokia770_mmc_init();
-- 
1.7.11.7


-- 
Dmitry
