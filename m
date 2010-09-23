From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 2/2] omap: zoom: Move new code introduced by
	ASoC m-c to board-zoom-peripherals
Date: Thu, 23 Sep 2010 19:11:54 +0300
Message-ID: <1285258314-23721-2-git-send-email-jhnikula@gmail.com>
References: <1285258314-23721-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1285258314-23721-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vikram Pandita <vikram.pandita@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jorge Eduardo Candelaria <jorge.candelaria@ti.com>, "Lopez Cruz,
	Misael" <x0052729@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

ASoC Multi-Component Support moves some code from sound/soc/omap/zoom2.c into
arch/arm/mach-omap2/board-zoom2.c. However, that code should go to
board-zoom-peripherals.c instead as there is common code and registration
for zoom boards.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Vikram Pandita <vikram.pandita@ti.com>
Cc: Lopez Cruz, Misael <x0052729@ti.com>
Cc: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
I don't have this HW so not tested. This is omap architecture patch but I
think this should go together with ASoC Multi-Component.
---
 arch/arm/mach-omap2/board-zoom-peripherals.c |   12 +++++++
 arch/arm/mach-omap2/board-zoom2.c            |   44 --------------------------
 2 files changed, 12 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 6b39849..3c65304 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -24,6 +24,8 @@
 #include <plat/common.h>
 #include <plat/usb.h>
 
+#include <mach/board-zoom.h>
+
 #include "mux.h"
 #include "hsmmc.h"
 
@@ -188,6 +190,11 @@ static int zoom_twl_gpio_setup(struct device *dev,
 	return 0;
 }
 
+/* EXTMUTE callback function */
+void zoom2_set_hs_extmute(int mute)
+{
+	gpio_set_value(ZOOM2_HEADSET_EXTMUTE_GPIO, mute);
+}
 
 static int zoom_batt_table[] = {
 /* 0 C*/
@@ -257,6 +264,11 @@ static struct i2c_board_info __initdata zoom_i2c_boardinfo[] = {
 
 static int __init omap_i2c_init(void)
 {
+	if (machine_is_omap_zoom2()) {
+		zoom_audio_data.ramp_delay_value = 3;	/* 161 ms */
+		zoom_audio_data.hs_extmute = 1;
+		zoom_audio_data.set_hs_extmute = zoom2_set_hs_extmute;
+	}
 	omap_register_i2c_bus(1, 2400, zoom_i2c_boardinfo,
 			ARRAY_SIZE(zoom_i2c_boardinfo));
 	omap_register_i2c_bus(2, 400, NULL, 0);
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 86d4515..00c8f83 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -35,49 +35,6 @@ static void __init omap_zoom2_init_irq(void)
 	omap_gpio_init();
 }
 
-/* EXTMUTE callback function */
-void zoom2_set_hs_extmute(int mute)
-{
-	gpio_set_value(ZOOM2_HEADSET_EXTMUTE_GPIO, mute);
-}
-
-static struct twl4030_codec_audio_data zoom2_audio_data = {
-	.audio_mclk = 26000000,
-	.ramp_delay_value = 3,	/* 161 ms */
-	.hs_extmute = 1,
-	.set_hs_extmute = zoom2_set_hs_extmute,
-};
-
-static struct twl4030_codec_data zoom2_codec_data = {
-	.audio_mclk = 26000000,
-	.audio = &zoom2_audio_data,
-};
-
-static struct twl4030_platform_data zoom2_twldata = {
-	.irq_base	= TWL4030_IRQ_BASE,
-	.irq_end	= TWL4030_IRQ_END,
-
-	/* platform_data for children goes here */
-	.codec		= &zoom2_codec_data,
-};
-
-static struct i2c_board_info __initdata zoom2_i2c_boardinfo[] = {
-	{
-		I2C_BOARD_INFO("twl4030", 0x48),
-		.flags = I2C_CLIENT_WAKE,
-		.irq = INT_34XX_SYS_NIRQ,
-		.platform_data = &zoom2_twldata,
-	},
-};
-
-static int __init omap3_zoom2_i2c_init(void)
-{
-	omap_register_i2c_bus(1, 2600, zoom2_i2c_boardinfo,
-			ARRAY_SIZE(zoom2_i2c_boardinfo));
-	return 0;
-}
-
-
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
 	/* WLAN IRQ - GPIO 162 */
@@ -144,7 +101,6 @@ static void __init omap_zoom2_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	zoom_peripherals_init();
-	omap3_zoom2_i2c_init();
 	board_nand_init(zoom_nand_partitions,
 			ARRAY_SIZE(zoom_nand_partitions), ZOOM_NAND_CS);
 	zoom_debugboard_init();
-- 
1.7.1
