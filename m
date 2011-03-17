From: Javier Martin <javier.martin@vista-silicon.com>
Subject: [PATCH] omap3: beaglexm: fix user button.
Date: Thu, 17 Mar 2011 13:44:50 +0100
Message-ID: <1300365890-28544-1-git-send-email-javier.martin@vista-silicon.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61962 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749Ab1CQMpE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Mar 2011 08:45:04 -0400
Received: by wya21 with SMTP id 21so2719651wya.19
        for <linux-omap@vger.kernel.org>; Thu, 17 Mar 2011 05:45:03 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, Javier Martin <javier.martin@vista-silicon.com>

User push button in Beagleboard xM is 4 instead of 7.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 46d814a..abf87d1 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -615,6 +615,10 @@ static void __init omap3_beagle_init(void)
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap3_beagle_init_rev();
 	omap3_beagle_i2c_init();
+	/* xM version uses pin 4 instead of 7 for user button */
+	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
+		gpio_buttons[0].gpio = 4;
+	}
 	platform_add_devices(omap3_beagle_devices,
 			ARRAY_SIZE(omap3_beagle_devices));
 	omap_serial_init();
-- 
1.7.0.4

