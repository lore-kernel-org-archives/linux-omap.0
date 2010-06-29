From: Sergio Aguirre <saaguirre@ti.com>
Subject: [RFC][PATCH] board-omap3beagle: Remove duplicate DVI reset gpio handling
Date: Tue, 29 Jun 2010 15:32:40 -0500
Message-ID: <1277843560-25630-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57932 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359Ab0F2UeP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Jun 2010 16:34:15 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Sergio Aguirre <saaguirre@ti.com>, Koen Kooi <koen.kooi@gmail.com>

Following commit missed to remove this:

  commit 044d32ffbcb4a1d400088e3575508f46c0a9face
  Author: Koen Kooi <koen.kooi@gmail.com>
  Date:   Thu Apr 22 10:23:42 2010 +0200

      board-omap3-beagle: add DSS2 support

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
Cc: Koen Kooi <koen.kooi@gmail.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 7b95cc1..867a4ad 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -169,6 +169,8 @@ static void __init beagle_display_init(void)
 {
 	int r;
 
+	omap_mux_init_gpio(beagle_dvi_device.reset_gpio, OMAP_PIN_INPUT);
+
 	r = gpio_request(beagle_dvi_device.reset_gpio, "DVI reset");
 	if (r < 0) {
 		printk(KERN_ERR "Unable to get DVI reset GPIO\n");
@@ -491,11 +493,6 @@ static void __init omap3_beagle_init(void)
 			ARRAY_SIZE(omap3_beagle_devices));
 	omap_serial_init();
 
-	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
-	gpio_request(170, "DVI_nPD");
-	/* REVISIT leave DVI powered down until it's needed ... */
-	gpio_direction_output(170, true);
-
 	usb_musb_init(&musb_board_data);
 	usb_ehci_init(&ehci_pdata);
 	omap3beagle_flash_init();
-- 
1.6.3.3

