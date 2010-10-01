From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH] omap: zoom2: fix build break due to ASoC changes
Date: Sat,  2 Oct 2010 02:00:11 +0530
Message-ID: <1285965011-17384-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43051 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752870Ab0JAUaa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Oct 2010 16:30:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Anand Gadiyar <gadiyar@ti.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>

Commit f0fba2ad1b6 (ASoC: multi-component - ASoC
Multi-Component Support) in linux-next as of 20101001
broke omap builds with the following errors.

  CC      arch/arm/mach-omap2/board-zoom2.o
arch/arm/mach-omap2/board-zoom2.c:65: error: 'zoom2_bci_data' undeclared here (not in a function)
arch/arm/mach-omap2/board-zoom2.c:67: error: 'zoom2_usb_data' undeclared here (not in a function)
arch/arm/mach-omap2/board-zoom2.c:68: error: 'zoom2_gpio_data' undeclared here (not in a function)
arch/arm/mach-omap2/board-zoom2.c:69: error: 'zoom2_kp_twl4030_data' undeclared here (not in a function)
arch/arm/mach-omap2/board-zoom2.c:71: error: 'zoom2_vmmc1' undeclared here (not in a function)
arch/arm/mach-omap2/board-zoom2.c:72: error: 'zoom2_vmmc2' undeclared here (not in a function)
arch/arm/mach-omap2/board-zoom2.c:73: error: 'zoom2_vsim' undeclared here (not in a function)
make[1]: *** [arch/arm/mach-omap2/board-zoom2.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

For zoom2/3, the i2c peripheral  initialization is already done in
board-zoom-peripherals.c and should not be done in board-zoom2.c.
Revert all of the changes made to board-zoom2.c to fix the build.

ASoC-related changes should be done separately if needed.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
Liam,

The only functional change I see here is the twl4030_codec_audio_data.
That should probably go into board-zoom-peripherals.c.

I'll take a deeper look in a while and fix properly there.

- Anand

 arch/arm/mach-omap2/board-zoom2.c |   28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

Index: linux-2.6/arch/arm/mach-omap2/board-zoom2.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/board-zoom2.c
+++ linux-2.6/arch/arm/mach-omap2/board-zoom2.c
@@ -14,7 +14,6 @@
 #include <linux/platform_device.h>
 #include <linux/input.h>
 #include <linux/gpio.h>
-#include <linux/i2c/twl.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -35,11 +34,8 @@ static void __init omap_zoom2_init_irq(v
 	omap_gpio_init();
 }
 
-/* EXTMUTE callback function */
-void zoom2_set_hs_extmute(int mute)
-{
-	gpio_set_value(ZOOM2_HEADSET_EXTMUTE_GPIO, mute);
-}
+/* REVISIT: These audio entries can be removed once MFD code is merged */
+#if 0
 
 static struct twl4030_madc_platform_data zoom2_madc_data = {
 	.irq_line	= 1,
@@ -47,9 +43,6 @@ static struct twl4030_madc_platform_data
 
 static struct twl4030_codec_audio_data zoom2_audio_data = {
 	.audio_mclk = 26000000,
-	.ramp_delay_value = 3,	/* 161 ms */
-	.hs_extmute = 1,
-	.set_hs_extmute = zoom2_set_hs_extmute,
 };
 
 static struct twl4030_codec_data zoom2_codec_data = {
@@ -71,24 +64,10 @@ static struct twl4030_platform_data zoom
 	.vmmc1          = &zoom2_vmmc1,
 	.vmmc2          = &zoom2_vmmc2,
 	.vsim           = &zoom2_vsim,
-};
 
-static struct i2c_board_info __initdata zoom2_i2c_boardinfo[] = {
-	{
-		I2C_BOARD_INFO("twl4030", 0x48),
-		.flags = I2C_CLIENT_WAKE,
-		.irq = INT_34XX_SYS_NIRQ,
-		.platform_data = &zoom2_twldata,
-	},
 };
 
-static int __init omap3_zoom2_i2c_init(void)
-{
-	omap_register_i2c_bus(1, 2600, zoom2_i2c_boardinfo,
-			ARRAY_SIZE(zoom2_i2c_boardinfo));
-	return 0;
-}
-
+#endif
 
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
@@ -156,7 +135,6 @@ static void __init omap_zoom2_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	zoom_peripherals_init();
-	omap3_zoom2_i2c_init();
 	board_nand_init(zoom_nand_partitions,
 			ARRAY_SIZE(zoom_nand_partitions), ZOOM_NAND_CS);
 	zoom_debugboard_init();
