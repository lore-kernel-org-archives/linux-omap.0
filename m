From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-rc3-omap1] omap3 beagle: led triggers
Date: Fri, 29 Aug 2008 10:03:16 -0700
Message-ID: <200808291003.16522.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:21105 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753412AbYH2RN2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Aug 2008 13:13:28 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Assign default roles to two of Beagle's programmable LEDs:

 - usr0 has a heartbeat to show basic activity
 - usr1 shows MMC activity

A third led is controlled by the TWL4030 LED_B signal, but the
TWL driver doesn't yet support leds...

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- beagle.orig/arch/arm/mach-omap2/board-omap3beagle.c	2008-08-27 21:14:27.000000000 -0700
+++ beagle/arch/arm/mach-omap2/board-omap3beagle.c	2008-08-27 21:19:00.000000000 -0700
@@ -139,15 +139,15 @@ static struct omap_lcd_config omap3_beag
 	.ctrl_name	= "internal",
 };
 
-struct gpio_led gpio_leds[] = {
+static struct gpio_led gpio_leds[] = {
 	{
 		.name			= "beagleboard::usr0",
-		.default_trigger	= "none",
+		.default_trigger	= "heartbeat",
 		.gpio			= 150,
 	},
 	{
 		.name			= "beagleboard::usr1",
-		.default_trigger	= "none",
+		.default_trigger	= "mmc0",
 		.gpio			= 149,
 	},
 };
