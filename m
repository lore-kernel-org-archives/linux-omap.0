From: balajitk@ti.com
Subject: [PATCH] mfd: twl: fix twl4030 rename for remaining driver, board files
Date: Tue, 15 Dec 2009 18:25:23 +0530
Message-ID: <1260881723-17255-1-git-send-email-balajitk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40441 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752857AbZLOMzs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Dec 2009 07:55:48 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: lrg@slimlogic.co.uk, sameo@linux.intel.com, broonie@opensource.wolfsonmicro.com, tony@atomide.co, sfr@canb.auug.org.au, Balaji T K <balajitk@ti.com>

From: Balaji T K <balajitk@ti.com>

        This patch renames include twl4030.h to include twl.h
	and also renames twl4030_i2c_ routines

Signed-off-by: Balaji T K <balajitk@ti.com>
---
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
index 22c4529..f62d59e 100644
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
index fa62e80..2dd3cd8 100644
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
index 5efc2e9..50d89a2 100644
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
index 15ce651..afe51aa 100644
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
index f14baa3..13a4dd4 100755
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
index 6a260df..b4e464c 100644
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
@@ -58,7 +58,7 @@
 #define TWL4030_VPLL2_DEV_GRP           0x33
 #define TWL4030_VPLL2_DEDICATED         0x36
 
-#define t2_out(c, r, v) twl4030_i2c_write_u8(c, r, v)
+#define t2_out(c, r, v) twl_i2c_write_u8(c, r, v)
 
 
 static int ldp_panel_init(struct lcd_panel *panel,
diff --git a/drivers/video/omap/lcd_omap2evm.c b/drivers/video/omap/lcd_omap2evm.c
index e1a38ab..d6959a3 100644
--- a/drivers/video/omap/lcd_omap2evm.c
+++ b/drivers/video/omap/lcd_omap2evm.c
@@ -24,7 +24,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 
 #include <plat/mux.h>
 #include <plat/omapfb.h>
@@ -60,9 +60,9 @@ static int omap2evm_panel_init(struct lcd_panel *panel,
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
@@ -100,7 +100,7 @@ static int omap2evm_bklight_setlevel(struct lcd_panel *panel,
 	u8 c;
 	if ((level >= 0) && (level <= 100)) {
 		c = (125 * (100 - level)) / 100 + 2;
-		twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, c, TWL_PWMA_PWMAOFF);
+		twl_i2c_write_u8(TWL4030_MODULE_PWMA, c, TWL_PWMA_PWMAOFF);
 		bklight_level = level;
 	}
 	return 0;
diff --git a/drivers/video/omap/lcd_omap3beagle.c b/drivers/video/omap/lcd_omap3beagle.c
index ccec084..4644023 100644
--- a/drivers/video/omap/lcd_omap3beagle.c
+++ b/drivers/video/omap/lcd_omap3beagle.c
@@ -23,7 +23,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 
 #include <plat/mux.h>
 #include <plat/omapfb.h>
diff --git a/drivers/video/omap/lcd_omap3evm.c b/drivers/video/omap/lcd_omap3evm.c
index 556eb31..65dce0a 100644
--- a/drivers/video/omap/lcd_omap3evm.c
+++ b/drivers/video/omap/lcd_omap3evm.c
@@ -23,7 +23,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
-#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl.h>
 
 #include <plat/mux.h>
 #include <plat/omapfb.h>
@@ -62,9 +62,9 @@ static int omap3evm_panel_init(struct lcd_panel *panel,
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
@@ -101,7 +101,7 @@ static int omap3evm_bklight_setlevel(struct lcd_panel *panel,
 	u8 c;
 	if ((level >= 0) && (level <= 100)) {
 		c = (125 * (100 - level)) / 100 + 2;
-		twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, c, TWL_PWMA_PWMAOFF);
+		twl_i2c_write_u8(TWL4030_MODULE_PWMA, c, TWL_PWMA_PWMAOFF);
 		bklight_level = level;
 	}
 	return 0;
diff --git a/drivers/video/omap/lcd_overo.c b/drivers/video/omap/lcd_overo.c
index b0f86e5..1aab809 100644
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

