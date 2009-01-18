From: David Brownell <david-b@pacbell.net>
Subject: Re: Beagle defconfig broken in mainline
Date: Sun, 18 Jan 2009 03:57:19 -0800
Message-ID: <200901180357.19705.david-b@pacbell.net>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02E6815EF6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:47228 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755130AbZARL5V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 18 Jan 2009 06:57:21 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02E6815EF6@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: David Brownell <dbrownell@users.sourceforge.net>
Subject: arch/arm/mach-omap2/board-omap3beagle.c buildfix

  CC      arch/arm/mach-omap2/board-omap3beagle.o
arch/arm/mach-omap2/board-omap3beagle.c: In function 'beagle_twl_gpio_setup':
arch/arm/mach-omap2/board-omap3beagle.c:132: error: 'TWL4030_GPIO_MAX' undeclared (first use in this function)
... many errors ...
arch/arm/mach-omap2/board-omap3beagle.c:308: error: 'gpio' undeclared (first use in this function)
make[1]: *** [arch/arm/mach-omap2/board-omap3beagle.o] Error 1

Reported-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
Against MAINLINE 2.6.29-rc2

 arch/arm/mach-omap2/board-omap3beagle.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

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
@@ -120,6 +122,9 @@ static int beagle_twl_gpio_setup(struct 
 		unsigned gpio, unsigned ngpio)
 {
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
+	omap_cfg_reg(AH8_34XX_GPIO29);
+	mmc[0].gpio_cd = gpio + 0;
+	twl4030_mmc_init(mmc);
 
 	/* REVISIT: need ehci-omap hooks for external VBUS
 	 * power switch and overcurrent detect
@@ -304,10 +309,6 @@ static void __init omap3_beagle_init(voi
 	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
 	omap_serial_init();
 
-	omap_cfg_reg(AH8_34XX_GPIO29);
-	mmc[0].gpio_cd = gpio + 0;
-	twl4030_mmc_init(mmc);
-
 	omap_cfg_reg(J25_34XX_GPIO170);
 	gpio_request(170, "DVI_nPD");
 	/* REVISIT leave DVI powered down until it's needed ... */
