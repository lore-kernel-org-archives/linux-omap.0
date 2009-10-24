From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] omap3: beagle: Fix USB host port power control
Date: Sat, 24 Oct 2009 10:59:54 +0300
Message-ID: <1256371194-22944-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f208.google.com ([209.85.219.208]:52920 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbZJXH7R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Oct 2009 03:59:17 -0400
Received: by ewy4 with SMTP id 4so2261471ewy.37
        for <linux-omap@vger.kernel.org>; Sat, 24 Oct 2009 00:59:21 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, Steve Sakoman <steve@sakoman.com>

The host port power is enabled by driving the nEN_USB_PWR low as stated in
the comment. This fix is originally from Steve Sakoman <steve@sakoman.com>.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Steve Sakoman <steve@sakoman.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 6cb99f6..7ad9846 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -162,7 +162,7 @@ static int beagle_twl_gpio_setup(struct device *dev,
 
 	/* TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, active low) */
 	gpio_request(gpio + TWL4030_GPIO_MAX, "nEN_USB_PWR");
-	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 1);
+	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
 
 	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
-- 
1.6.3.3

