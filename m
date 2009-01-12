From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/10] ARM: OMAP: Fix compile for beagle
Date: Mon, 12 Jan 2009 16:42:18 +0200
Message-ID: <20090112144218.24205.15215.stgit@localhost>
References: <20090112143405.24205.52151.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61046 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbZALOmW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 09:42:22 -0500
In-Reply-To: <20090112143405.24205.52151.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Move twl4030 gpio init code to where it should be.
Also include twl4030.h.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 9e5ada0..38c88fb 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -28,6 +28,8 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand.h>
 
+#include <linux/i2c/twl4030.h>
+
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -120,6 +122,9 @@ static int beagle_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
+	omap_cfg_reg(AH8_34XX_GPIO29);
+	mmc[0].gpio_cd = gpio + 0;
+	twl4030_mmc_init(mmc);
 
 	/* REVISIT: need ehci-omap hooks for external VBUS
 	 * power switch and overcurrent detect
@@ -304,10 +309,6 @@ static void __init omap3_beagle_init(void)
 	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
 	omap_serial_init();
 
-	omap_cfg_reg(AH8_34XX_GPIO29);
-	mmc[0].gpio_cd = gpio + 0;
-	twl4030_mmc_init(mmc);
-
 	omap_cfg_reg(J25_34XX_GPIO170);
 	gpio_request(170, "DVI_nPD");
 	/* REVISIT leave DVI powered down until it's needed ... */

