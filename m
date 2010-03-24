From: Thomas Weber <weber@corscience.de>
Subject: [PATCH 6/9] OMAP: Devkit8000: Remove unused pins
Date: Wed, 24 Mar 2010 13:52:15 +0100
Message-ID: <1269435138-27192-7-git-send-email-weber@corscience.de>
References: <1269435138-27192-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:58833 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755850Ab0CXMxB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 08:53:01 -0400
In-Reply-To: <1269435138-27192-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Thomas Weber <weber@corscience.de>

Old code from original patch contains beagle board pins that are
not available on the Devkit8000.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |   20 --------------------
 1 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index c3b5e02..f8583ce 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -268,20 +268,6 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
 	devkit8000_vmmc1_supply.dev = mmc[0].dev;
 	devkit8000_vsim_supply.dev = mmc[0].dev;
 
-	/* REVISIT: need ehci-omap hooks for external VBUS
-	 * power switch and overcurrent detect
-	 */
-
-	gpio_request(gpio + 1, "EHCI_nOC");
-	gpio_direction_input(gpio + 1);
-
-	/* TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, active low) */
-	gpio_request(gpio + TWL4030_GPIO_MAX, "nEN_USB_PWR");
-	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 1);
-
-	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
-	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
-
 	return 0;
 }
 
@@ -664,12 +650,6 @@ static void __init devkit8000_init(void)
 
 	devkit8000_ads7846_init();
 
-	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
-
-	gpio_request(170, "DVI_nPD");
-	/* REVISIT leave DVI powered down until it's needed ... */
-	gpio_direction_output(170, true);
-
 	usb_musb_init(&musb_board_data);
 	usb_ehci_init(&ehci_pdata);
 	devkit8000_flash_init();
-- 
1.6.4.4

