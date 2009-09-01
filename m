From: Steve Sakoman <sakoman@gmail.com>
Subject: ARM: OMAP3: Beagleboard: Fix EHCI initialization
Date: Tue, 1 Sep 2009 14:55:34 -0700
Message-ID: <5e088bd90909011455y48ce86c4t532ed5a66bac01fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:1056 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294AbZIAVzc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Sep 2009 17:55:32 -0400
Received: by qw-out-2122.google.com with SMTP id 8so178414qwh.37
        for <linux-omap@vger.kernel.org>; Tue, 01 Sep 2009 14:55:34 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Enable USB power, use correct gpio for usb_ehci_init

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c
b/arch/arm/mach-omap2/board-omap3beagle.c
index 07aee90..65934ea 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -161,7 +161,7 @@ static int beagle_twl_gpio_setup(struct device *dev,

 	/* TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, active low) */
 	gpio_request(gpio + TWL4030_GPIO_MAX, "nEN_USB_PWR");
-	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 1);
+	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);

 	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
@@ -412,7 +412,8 @@ static void __init omap3_beagle_init(void)
 	gpio_direction_output(170, true);

 	usb_musb_init();
-	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, true, true, 57, 61);
+	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, false, true,
+			-EINVAL, 147);
 	omap3beagle_flash_init();

 	/* Ensure SDRC pins are mux'd for self-refresh */
-- 
1.6.0.4
