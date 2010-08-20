From: Mathieu Poirier <mathieu.poirier@canonical.com>
Subject: [PATCH] Adding i2c eeprom driver to read EDID
Date: Fri, 20 Aug 2010 14:56:19 -0600
Message-ID: <1282337779.5433.14.camel@black>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:41481 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468Ab0HTU40 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Aug 2010 16:56:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

>From f0b677144c1b674f21c1f423781c49d8173914c8 Mon Sep 17 00:00:00 2001
From: Mathieu J. Poirier <mathieu.poirier@canonical.com>
Date: Fri, 20 Aug 2010 14:25:53 -0600
Subject: [PATCH] Adding i2c eeprom driver to read EDID

Adding i2c eeprom driver to access monitor EDID binary information
from user space, something that is required by 'decode-edid' and
'parse-edid'.

BugLink: https://bugs.launchpad.net/bugs/608279

Signed-off-by: Mathieu Poirier <mathieu.poirier@canonical.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 7a1b351..fb6cbb9 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -355,13 +355,19 @@ static struct i2c_board_info __initdata beagle_i2c_boardinfo[] = {
 	},
 };
 
+static struct i2c_board_info __initdata beagle_i2c_eeprom[] = {
+       {
+               I2C_BOARD_INFO("eeprom", 0x50),
+       },
+};
+
 static int __init omap3_beagle_i2c_init(void)
 {
 	omap_register_i2c_bus(1, 2600, beagle_i2c_boardinfo,
 			ARRAY_SIZE(beagle_i2c_boardinfo));
 	/* Bus 3 is attached to the DVI port where devices like the pico DLP
 	 * projector don't work reliably with 400kHz */
-	omap_register_i2c_bus(3, 100, NULL, 0);
+	omap_register_i2c_bus(3, 100, beagle_i2c_eeprom, ARRAY_SIZE(beagle_i2c_eeprom));
 	return 0;
 }
 
-- 
1.7.0.4



