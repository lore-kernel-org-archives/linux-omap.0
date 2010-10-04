From: Max Thrun <bear24rw@gmail.com>
Subject: [PATCH] beagle xm: enable USB hub at startup
Date: Mon, 4 Oct 2010 18:37:16 -0400
Message-ID: <AANLkTikWiR_Z--Eec4sVkLbN-pqjch6hmK_x-V4drWu1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49055 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755246Ab0JDWhR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 18:37:17 -0400
Received: by ewy23 with SMTP id 23so2289904ewy.19
        for <linux-omap@vger.kernel.org>; Mon, 04 Oct 2010 15:37:16 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org

The beagleboard XM requires an active high signal to enable the USB
hub. Previous versions required an active low signal. This patch
checks which version of the board is being used and sets the enable
line accordingly.

Singed-off-by: Max Thrun <bear24rw@gmail.com>

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c
b/arch/arm/mach-omap2/board-omap3beagle.c
index 73689c0..5a649b7 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -297,9 +297,13 @@ static int beagle_twl_gpio_setup(struct device *dev,
        gpio_request(gpio + 1, "EHCI_nOC");
        gpio_direction_input(gpio + 1);

-       /* TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, active low) */
+       /* TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, XM
active high / others active low) */
        gpio_request(gpio + TWL4030_GPIO_MAX, "nEN_USB_PWR");
-       gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
+       if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
+               gpio_direction_output(gpio + TWL4030_GPIO_MAX, 1);
+       } else {
+               gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
+       }

        /* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
        gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
