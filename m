From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/12] omap: Fix MMC gpio_wp for BeagleBoard C2 and above
Date: Thu, 24 Sep 2009 16:45:47 -0700
Message-ID: <20090924234547.6065.10188.stgit@localhost>
References: <20090924233027.6065.95725.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58019 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740AbZIXXpp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Sep 2009 19:45:45 -0400
In-Reply-To: <20090924233027.6065.95725.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org

From: Jarkko Nikula <jhnikula@gmail.com>

Earlier BeagleBoards were using pad AH8 muxed to GPIO29 for MMC write-protect.
However, this signal has been changed to pad AG9 in board revision C2.

Fix this by adding mux configuration for pad AG9, runtime check for board
revisions and set the gpio number and pad muxing accordingly.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    7 ++++++-
 arch/arm/mach-omap2/mux.c               |    2 ++
 arch/arm/plat-omap/include/mach/mux.h   |    1 +
 3 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 500c995..70df6b4 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -139,8 +139,13 @@ static struct gpio_led gpio_leds[];
 static int beagle_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
+	if (system_rev >= 0x20 && system_rev <= 0x34301000) {
+		omap_cfg_reg(AG9_34XX_GPIO23);
+		mmc[0].gpio_wp = 23;
+	} else {
+		omap_cfg_reg(AH8_34XX_GPIO29);
+	}
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
-	omap_cfg_reg(AH8_34XX_GPIO29);
 	mmc[0].gpio_cd = gpio + 0;
 	twl4030_mmc_init(mmc);
 
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 339ba80..b5fac32 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -460,6 +460,8 @@ MUX_CFG_34XX("AF26_34XX_GPIO0", 0x1e0,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
 MUX_CFG_34XX("AF22_34XX_GPIO9", 0xa18,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("AG9_34XX_GPIO23", 0x5ee,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
 MUX_CFG_34XX("AH8_34XX_GPIO29", 0x5fa,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
 MUX_CFG_34XX("U8_34XX_GPIO54_OUT", 0x0b4,
diff --git a/arch/arm/plat-omap/include/mach/mux.h b/arch/arm/plat-omap/include/mach/mux.h
index 4bcf8a5..0f49d2d 100644
--- a/arch/arm/plat-omap/include/mach/mux.h
+++ b/arch/arm/plat-omap/include/mach/mux.h
@@ -840,6 +840,7 @@ enum omap34xx_index {
 	 */
 	AF26_34XX_GPIO0,
 	AF22_34XX_GPIO9,
+	AG9_34XX_GPIO23,
 	AH8_34XX_GPIO29,
 	U8_34XX_GPIO54_OUT,
 	U8_34XX_GPIO54_DOWN,

