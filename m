From: balajitk@ti.com
Subject: [PATCH v2] mfd: twl: fix twl4030 rename for remaining driver, board files
Date: Tue, 15 Dec 2009 20:09:02 +0530
Message-ID: <1260887942-32644-1-git-send-email-balajitk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46973 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752530AbZLOOja (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Dec 2009 09:39:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, sameo@linux.intel.com
Cc: broonie@opensource.wolfsonmicro.com, tony@atomide.com, sfr@canb.auug.org.au, felipe.balbi@nokia.com, lrg@slimlogic.co.uk, Balaji T K <balajitk@ti.com>

From: Balaji T K <balajitk@ti.com>

	This patch renames include twl4030.h to include twl.h
	and also renames twl4030_i2c_ routines

Signed-off-by: Balaji T K <balajitk@ti.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Reviewed-by: Felipe Balbi <felipe.balbi@nokia.com>
---
	rebased the patch on latest mainline 
	commit 3ea6b3d0e6d0ffd91c0f8cadeb69b7133c038b32

 arch/arm/mach-omap2/board-cm-t35.c           |    2 +-
 arch/arm/mach-omap2/board-igep0020.c         |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c         |    2 +-
 arch/arm/mach-omap2/board-omap3touchbook.c   |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c |    2 +-
 drivers/mfd/twl4030-codec.c                  |   10 +++++-----
 drivers/video/omap/lcd_ldp.c                 |    4 ++--
 drivers/video/omap/lcd_omap2evm.c            |   10 +++++-----
 drivers/video/omap/lcd_omap3beagle.c         |    2 +-
 drivers/video/omap/lcd_omap3evm.c            |   10 +++++-----
 drivers/video/omap/lcd_overo.c               |    2 +-
 sound/soc/omap/sdp3430.c                     |    6 +++---
 13 files changed, 28 insertions(+), 28 deletions(-)

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
diff --git a/drivers/mfd/twl4030-codec.c b/drivers/mfd/twl4030-codec.c
index 77b9149..700b149 100644
--- a/drivers/mfd/twl4030-codec.c
+++ b/drivers/mfd/twl4030-codec.c
@@ -26,7 +26,7 @@
 #include <linux/kernel.h>
 #include <linux/fs.h>
 #include <linux/platform_device.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/twl4030-codec.h>
 
@@ -56,7 +56,7 @@ static int twl4030_codec_set_resource(enum twl4030_codec_res id, int enable)
 	struct twl4030_codec *codec = platform_get_drvdata(twl4030_codec_dev);
 	u8 val;
 
-	twl4030_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &val,
+	twl_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &val,
 			codec->resource[id].reg);
 
 	if (enable)
@@ -64,7 +64,7 @@ static int twl4030_codec_set_resource(enum twl4030_codec_res id, int enable)
 	else
 		val &= ~codec->resource[id].mask;
 
-	twl4030_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
+	twl_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
 					val, codec->resource[id].reg);
 
 	return val;
@@ -75,7 +75,7 @@ static inline int twl4030_codec_get_resource(enum twl4030_codec_res id)
 	struct twl4030_codec *codec = platform_get_drvdata(twl4030_codec_dev);
 	u8 val;
 
-	twl4030_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &val,
+	twl_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &val,
 			codec->resource[id].reg);
 
 	return val;
@@ -183,7 +183,7 @@ static int __devinit twl4030_codec_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Invalid audio_mclk\n");
 		return -EINVAL;
 	}
-	twl4030_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
+	twl_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
 					val, TWL4030_REG_APLL_CTL);
 
 	codec = kzalloc(sizeof(struct twl4030_codec), GFP_KERNEL);
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
-- 
1.5.4.7

