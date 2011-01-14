From: Daniel Morsing <daniel.morsing@gmail.com>
Subject: [PATCH 1/3] omap3: devkit8000: Fix indentation issue
Date: Fri, 14 Jan 2011 01:03:27 +0100
Message-ID: <1294963409-29891-2-git-send-email-daniel.morsing@gmail.com>
References: <1294963409-29891-1-git-send-email-daniel.morsing@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56038 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757361Ab1ANADZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Jan 2011 19:03:25 -0500
Received: by eye27 with SMTP id 27so1191172eye.19
        for <linux-omap@vger.kernel.org>; Thu, 13 Jan 2011 16:03:24 -0800 (PST)
In-Reply-To: <1294963409-29891-1-git-send-email-daniel.morsing@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Thomas Weber <weber@corscience.de>, Daniel Morsing <daniel.morsing@gmail.com>

Comment line uses 8 spaces as indentation. Replace with a hard tab

Signed-off-by: Daniel Morsing <daniel.morsing@gmail.com>
---
 arch/arm/mach-omap2/board-devkit8000.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 451e7ff..864a08f 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -245,7 +245,7 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
 	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
 
-        /* gpio + 1 is "LCD_PWREN" (out, active high) */
+	/* gpio + 1 is "LCD_PWREN" (out, active high) */
 	devkit8000_lcd_device.reset_gpio = gpio + 1;
 	gpio_request(devkit8000_lcd_device.reset_gpio, "LCD_PWREN");
 	/* Disable until needed */
-- 
1.7.3.4

