From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] mfd: twl: fix twl4030 rename for remaining driver,
 board files
Date: Tue, 15 Dec 2009 13:50:16 -0800
Message-ID: <20091215215016.GP4575@atomide.com>
References: <1260887942-32644-1-git-send-email-balajitk@ti.com>
 <19F8576C6E063C45BE387C64729E739404372AAFA4@dbde02.ent.ti.com>
 <20091215174318.GJ4575@atomide.com>
 <20091215182103.GK4575@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50540 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757936AbZLOVuY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 16:50:24 -0500
Content-Disposition: inline
In-Reply-To: <20091215182103.GK4575@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [091215 10:19]:
> * Tony Lindgren <tony@atomide.com> [091215 09:43]:
> > * Krishnamoorthy, Balaji T <balajitk@ti.com> [091215 08:09]:
> > > Hi Samuel,
> > > Could you please take this patch through the mfd tree.
> > 
> > NAK. Please redo the whole twl rename series so _every_ patch
> > in the series builds for _every_ omap and x86. Then let's have
> > it sit in for-next before merging it. Otherwise git bisect
> > breaks on x86 also.
> 
> Argh. Too late. This twl rename series already hit the mainline
> just now.
> 
> Has this patch been compile tested on all omaps and x86?

Looks like commit 8bea8672edfca7ec5f661cafb218f1205863b343 already
took care of the x86 compile issue.

I'll merge the refreshed version below via omap-fixes queue.

Regards,

Tony


--cNdxnHkX5QqsyA0e
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="twl-fix.patch"

>From 9008b8c9594df6e34992d766c04f0a0c60fa7d69 Mon Sep 17 00:00:00 2001
From: Balaji T K <balajitk@ti.com>
Date: Tue, 15 Dec 2009 20:09:02 +0530
Subject: [PATCH] mfd: twl: fix twl4030 rename for remaining driver, board files

Recent drivers/mfd/twl4030* renames to twl broke compile for
various boards as the series was missing a patch to change
the board-*.c files.

This patch renames include twl4030.h to include twl.h
and also renames twl4030_i2c_ routines.

Signed-off-by: Balaji T K <balajitk@ti.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Reviewed-by: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 1591aae..2626a9f 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -29,7 +29,7 @@
 #include <linux/gpio.h>
 
 #include <linux/i2c/at24.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 #include <linux/regulator/machine.h>
 
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 44239e3..117b8fd 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -19,7 +19,7 @@
 #include <linux/interrupt.h>
 
 #include <linux/regulator/machine.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 18913e9..34de178 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -26,7 +26,7 @@
 
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 #include <linux/usb/otg.h>
 #include <linux/smsc911x.h>
 
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index c9e5ebb..fe3d22c 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -34,7 +34,7 @@
 #include <linux/spi/ads7846.h>
 
 #include <linux/regulator/machine.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 17f3c91..acafdbc 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -16,7 +16,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/wl12xx.h>
 #include <linux/i2c.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/regulator/machine.h>
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 258794d..8dd277c 100755
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -14,7 +14,7 @@
 #include <linux/input.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/gpio.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 #include <linux/regulator/machine.h>
 
 #include <asm/mach-types.h>
diff --git a/drivers/video/omap/lcd_ldp.c b/drivers/video/omap/lcd_ldp.c
index 5bb7f6f..0f5952c 100644
--- a/drivers/video/omap/lcd_ldp.c
+++ b/drivers/video/omap/lcd_ldp.c
@@ -24,7 +24,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 
 #include <mach/gpio.h>
 #include <plat/mux.h>
@@ -59,7 +59,7 @@
 #define TWL4030_VPLL2_DEV_GRP           0x33
 #define TWL4030_VPLL2_DEDICATED         0x36
 
-#define t2_out(c, r, v) twl4030_i2c_write_u8(c, r, v)
+#define t2_out(c, r, v) twl_i2c_write_u8(c, r, v)
 
 
 static int ldp_panel_init(struct lcd_panel *panel,
diff --git a/drivers/video/omap/lcd_omap2evm.c b/drivers/video/omap/lcd_omap2evm.c
index 006c2fe..7e7a65c 100644
--- a/drivers/video/omap/lcd_omap2evm.c
+++ b/drivers/video/omap/lcd_omap2evm.c
@@ -24,7 +24,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 
 #include <plat/mux.h>
 #include <asm/mach-types.h>
@@ -61,9 +61,9 @@ static int omap2evm_panel_init(struct lcd_panel *panel,
 	gpio_direction_output(LCD_PANEL_LR, 1);
 	gpio_direction_output(LCD_PANEL_UD, 1);
 
-	twl4030_i2c_write_u8(TWL4030_MODULE_LED, 0x11, TWL_LED_LEDEN);
-	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x01, TWL_PWMA_PWMAON);
-	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x02, TWL_PWMA_PWMAOFF);
+	twl_i2c_write_u8(TWL4030_MODULE_LED, 0x11, TWL_LED_LEDEN);
+	twl_i2c_write_u8(TWL4030_MODULE_PWMA, 0x01, TWL_PWMA_PWMAON);
+	twl_i2c_write_u8(TWL4030_MODULE_PWMA, 0x02, TWL_PWMA_PWMAOFF);
 	bklight_level = 100;
 
 	return 0;
@@ -101,7 +101,7 @@ static int omap2evm_bklight_setlevel(struct lcd_panel *panel,
 	u8 c;
 	if ((level >= 0) && (level <= 100)) {
 		c = (125 * (100 - level)) / 100 + 2;
-		twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, c, TWL_PWMA_PWMAOFF);
+		twl_i2c_write_u8(TWL4030_MODULE_PWMA, c, TWL_PWMA_PWMAOFF);
 		bklight_level = level;
 	}
 	return 0;
diff --git a/drivers/video/omap/lcd_omap3beagle.c b/drivers/video/omap/lcd_omap3beagle.c
index fc503d8..ca75cc2 100644
--- a/drivers/video/omap/lcd_omap3beagle.c
+++ b/drivers/video/omap/lcd_omap3beagle.c
@@ -23,7 +23,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 
 #include <plat/mux.h>
 #include <plat/mux.h>
diff --git a/drivers/video/omap/lcd_omap3evm.c b/drivers/video/omap/lcd_omap3evm.c
index ae2edc4..06840da 100644
--- a/drivers/video/omap/lcd_omap3evm.c
+++ b/drivers/video/omap/lcd_omap3evm.c
@@ -23,7 +23,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 
 #include <plat/mux.h>
 #include <asm/mach-types.h>
@@ -63,9 +63,9 @@ static int omap3evm_panel_init(struct lcd_panel *panel,
 	gpio_direction_output(LCD_PANEL_LR, 1);
 	gpio_direction_output(LCD_PANEL_UD, 1);
 
-	twl4030_i2c_write_u8(TWL4030_MODULE_LED, 0x11, TWL_LED_LEDEN);
-	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x01, TWL_PWMA_PWMAON);
-	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x02, TWL_PWMA_PWMAOFF);
+	twl_i2c_write_u8(TWL4030_MODULE_LED, 0x11, TWL_LED_LEDEN);
+	twl_i2c_write_u8(TWL4030_MODULE_PWMA, 0x01, TWL_PWMA_PWMAON);
+	twl_i2c_write_u8(TWL4030_MODULE_PWMA, 0x02, TWL_PWMA_PWMAOFF);
 	bklight_level = 100;
 
 	return 0;
@@ -102,7 +102,7 @@ static int omap3evm_bklight_setlevel(struct lcd_panel *panel,
 	u8 c;
 	if ((level >= 0) && (level <= 100)) {
 		c = (125 * (100 - level)) / 100 + 2;
-		twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, c, TWL_PWMA_PWMAOFF);
+		twl_i2c_write_u8(TWL4030_MODULE_PWMA, c, TWL_PWMA_PWMAOFF);
 		bklight_level = level;
 	}
 	return 0;
diff --git a/drivers/video/omap/lcd_overo.c b/drivers/video/omap/lcd_overo.c
index 56ee192..564933f 100644
--- a/drivers/video/omap/lcd_overo.c
+++ b/drivers/video/omap/lcd_overo.c
@@ -21,7 +21,7 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 
 #include <mach/gpio.h>
 #include <plat/mux.h>
diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
index c071f96..3c85c0f 100644
--- a/sound/soc/omap/sdp3430.c
+++ b/sound/soc/omap/sdp3430.c
@@ -24,7 +24,7 @@
 
 #include <linux/clk.h>
 #include <linux/platform_device.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
@@ -321,11 +321,11 @@ static int __init sdp3430_soc_init(void)
 	*(unsigned int *)sdp3430_dai[1].cpu_dai->private_data = 2; /* McBSP3 */
 
 	/* Set TWL4030 GPIO6 as EXTMUTE signal */
-	twl4030_i2c_read_u8(TWL4030_MODULE_INTBR, &pin_mux,
+	twl_i2c_read_u8(TWL4030_MODULE_INTBR, &pin_mux,
 						TWL4030_INTBR_PMBR1);
 	pin_mux &= ~TWL4030_GPIO6_PWM0_MUTE(0x03);
 	pin_mux |= TWL4030_GPIO6_PWM0_MUTE(0x02);
-	twl4030_i2c_write_u8(TWL4030_MODULE_INTBR, pin_mux,
+	twl_i2c_write_u8(TWL4030_MODULE_INTBR, pin_mux,
 						TWL4030_INTBR_PMBR1);
 
 	ret = platform_device_add(sdp3430_snd_device);

--cNdxnHkX5QqsyA0e--
