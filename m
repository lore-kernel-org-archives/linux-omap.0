From: Robert Nelson <robertcnelson@gmail.com>
Subject: [PATCH v6 3/3] ARM: OMAP: Beagle: no gpio_wp pin connection on xM
Date: Thu, 19 Aug 2010 21:38:46 -0500
Message-ID: <1282271926-2676-3-git-send-email-robertcnelson@gmail.com>
References: <1282271926-2676-1-git-send-email-robertcnelson@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:43344 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927Ab0HTCjE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 22:39:04 -0400
Received: by mail-gx0-f174.google.com with SMTP id 23so1041711gxk.19
        for <linux-omap@vger.kernel.org>; Thu, 19 Aug 2010 19:39:04 -0700 (PDT)
In-Reply-To: <1282271926-2676-1-git-send-email-robertcnelson@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>

The omap3630 based BeagleBoard xM uses a MicroSD card slot with
no write protection.

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index e9af4fd..1f455c3 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -274,7 +274,9 @@ static struct gpio_led gpio_leds[];
 static int beagle_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
-	if ((omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_C1_3) ||
+	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
+		mmc[0].gpio_wp = -EINVAL;
+	} else if ((omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_C1_3) ||
 		(omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_C4)) {
 		omap_mux_init_gpio(23, OMAP_PIN_INPUT);
 		mmc[0].gpio_wp = 23;
-- 
1.7.0.4

