From: Koen Kooi <koen@openembedded.org>
Subject: [PATCH v2] board-omap3beagle: set i2c-3 to 100kHz
Date: Sun, 25 Jan 2009 09:46:17 +0100
Message-ID: <1232873177-15531-1-git-send-email-koen@openembedded.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [80.81.242.146] ([80.81.242.146]:51007 "EHLO
	amethyst.openembedded.net" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751383AbZAYIo7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 25 Jan 2009 03:44:59 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Koen Kooi <koen@beagleboard.org>

From: Koen Kooi <koen@beagleboard.org>

Changing it do 100kHz is needed to make more devices works properly. Controlling the TI DLP Pico projector[1] doesn't work properly at 400kHz, 100kHz and lower work fine. EDID readout is unaffected by this change.

[1] http://focus.ti.com/dlpdmd/docs/dlpdiscovery.tsp?sectionId=60&tabId=2234

Signed-off-by: Koen Kooi <koen@beagleboard.org>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index fe97bab..f7a6f7d 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -227,7 +227,9 @@ static int __init omap3_beagle_i2c_init(void)
 #ifdef CONFIG_I2C2_OMAP_BEAGLE
 	omap_register_i2c_bus(2, 400, NULL, 0);
 #endif
-	omap_register_i2c_bus(3, 400, NULL, 0);
+	/* Bus 3 is attached to the DVI port where devices like the pico DLP 
+	 * projector don't work reliably with 400kHz */
+	omap_register_i2c_bus(3, 100, NULL, 0);
 	return 0;
 }
 
-- 
1.5.6.5

