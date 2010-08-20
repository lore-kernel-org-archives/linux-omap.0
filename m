From: Robert Nelson <robertcnelson@gmail.com>
Subject: [PATCH v6 2/3] ARM: OMAP: Beagle: only Cx boards use pin 23 for write protect
Date: Thu, 19 Aug 2010 21:38:45 -0500
Message-ID: <1282271926-2676-2-git-send-email-robertcnelson@gmail.com>
References: <1282271926-2676-1-git-send-email-robertcnelson@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:43344 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898Ab0HTCjA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 22:39:00 -0400
Received: by gxk23 with SMTP id 23so1041711gxk.19
        for <linux-omap@vger.kernel.org>; Thu, 19 Aug 2010 19:38:59 -0700 (PDT)
In-Reply-To: <1282271926-2676-1-git-send-email-robertcnelson@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>

system_rev comes from u-boot and is a constant 0x20, so 
Bx boards also fall in this 'if' and will get setup with the 
wrong gpio_wp pin. Switch to using the Beagle revision routine 
to correcly set pin 23 only for C1/2/3 and C4 Boards. Bx boards
will then use the correct default pin setting.

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 62d69a9..e9af4fd 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -274,7 +274,8 @@ static struct gpio_led gpio_leds[];
 static int beagle_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
-	if (system_rev >= 0x20 && system_rev <= 0x34301000) {
+	if ((omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_C1_3) ||
+		(omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_C4)) {
 		omap_mux_init_gpio(23, OMAP_PIN_INPUT);
 		mmc[0].gpio_wp = 23;
 	} else {
-- 
1.7.0.4

