From: Koen Kooi <koen@openembedded.net>
Subject: [PATCH] ARM: OMAP: board-omap3beagle: set i2c-3 to 100kHz
Date: Thu, 15 Jan 2009 20:30:37 +0100
Message-ID: <1232047837-23052-1-git-send-email-koen@openembedded.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [80.81.242.146] ([80.81.242.146]:34998 "EHLO
	amethyst.openembedded.net" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754108AbZAOTwi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Jan 2009 14:52:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: beagleboard@googlegroups.com, Koen Kooi <koen@beagleboard.org>

From: Koen Kooi <koen@beagleboard.org>

Changing it to 100kHz is needed to make more devices works properly. Controlling the TI DLP Pico projector[1] doesn't work properly at 400kHz, 100kHz and lower work fine. EDID readout is unaffected by this change.

[1] http://focus.ti.com/dlpdmd/docs/dlpdiscovery.tsp?sectionId=60&tabId=2234

Signed-off-by: Koen Kooi <koen@beagleboard.org>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index fe97bab..f279404 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -227,7 +227,7 @@ static int __init omap3_beagle_i2c_init(void)
 #ifdef CONFIG_I2C2_OMAP_BEAGLE
 	omap_register_i2c_bus(2, 400, NULL, 0);
 #endif
-	omap_register_i2c_bus(3, 400, NULL, 0);
+	omap_register_i2c_bus(3, 100, NULL, 0);
 	return 0;
 }
 
-- 
1.5.6.3

