From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/7] Adding i2c eeprom driver to read EDID
Date: Fri, 24 Sep 2010 17:27:15 -0700
Message-ID: <20100925002715.24551.94749.stgit@baageli.muru.com>
References: <20100925002608.24551.67183.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61212 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518Ab0IYA1M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 20:27:12 -0400
In-Reply-To: <20100925002608.24551.67183.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Mathieu Poirier <mathieu.poirier@canonical.com>, linux-omap@vger.kernel.org

From: Mathieu J. Poirier <mathieu.poirier@canonical.com>

Adding i2c eeprom driver to access monitor EDID binary information
from user space, something that is required by 'decode-edid' and
'parse-edid'.

BugLink: https://bugs.launchpad.net/bugs/608279

Signed-off-by: Mathieu Poirier <mathieu.poirier@canonical.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 5534841..e27f3bf 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -412,13 +412,19 @@ static struct i2c_board_info __initdata beagle_i2c_boardinfo[] = {
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
 

