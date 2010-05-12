From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Subject: [RFC] [PATCHv2 2/2] SFH7741: Proximity sensor board support.
Date: Wed, 12 May 2010 14:22:16 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003B3209EF5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
List-Id: linux-omap@vger.kernel.org


Adding board support for the proximity sensor.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   71 +++++++++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index b88f28c..beb3059 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -18,6 +18,7 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/usb/otg.h>
+#include <linux/input/sfh7741.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -31,7 +32,25 @@
 #include <plat/usb.h>
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
+#define OMAP4_SFH7741_SENSOR_OUTPUT_GPIO	184
+#define OMAP4_SFH7741_ENABLE_GPIO		188
+static void omap_prox_activate(int state);
+static int omap_prox_read(void);
+
+static struct sfh7741_platform_data omap_sfh7741_data = {
+		.irq = OMAP_GPIO_IRQ(OMAP4_SFH7741_SENSOR_OUTPUT_GPIO),
+		.prox_enable = 1,
+		.activate_func = omap_prox_activate,
+		.read_prox = omap_prox_read,
+};
 
+static struct platform_device sdp4430_proximity_device = {
+	.name		= "sfh7741",
+	.id		= 1,
+	.dev		= {
+		.platform_data = &omap_sfh7741_data,
+	},
+};
 static struct platform_device sdp4430_lcd_device = {
 	.name		= "sdp4430_lcd",
 	.id		= -1,
@@ -39,6 +58,7 @@ static struct platform_device sdp4430_lcd_device = {
 
 static struct platform_device *sdp4430_devices[] __initdata = {
 	&sdp4430_lcd_device,
+	&sdp4430_proximity_device,
 };
 
 static struct omap_lcd_config sdp4430_lcd_config __initdata = {
@@ -111,6 +131,56 @@ static struct omap_musb_board_data musb_board_data = {
 	.power			= 100,
 };
 
+static void omap_prox_activate(int state)
+{
+	gpio_set_value(OMAP4_SFH7741_ENABLE_GPIO , state);
+}
+
+static int omap_prox_read(void)
+{
+	int proximity;
+	proximity = gpio_get_value(OMAP4_SFH7741_SENSOR_OUTPUT_GPIO);
+	return proximity;
+}
+
+static void omap_sfh7741prox_init(void)
+{
+	char *desc = "sfh7741";
+	int  error;
+
+	error = gpio_request(OMAP4_SFH7741_SENSOR_OUTPUT_GPIO, "sfh7741");
+	if (error < 0) {
+		pr_err("%s: GPIO configuration failed: GPIO %d, error %d\n"
+			, __func__, OMAP4_SFH7741_SENSOR_OUTPUT_GPIO, error);
+		return ;
+	}
+
+	error = gpio_direction_input(OMAP4_SFH7741_SENSOR_OUTPUT_GPIO);
+	if (error < 0) {
+		pr_err("Proximity GPIO input configuration failed\n");
+		goto fail1;
+	}
+
+	error = gpio_request(OMAP4_SFH7741_ENABLE_GPIO, "sfh7741");
+	if (error < 0) {
+		pr_err("failed to request GPIO %d, error %d\n",
+			OMAP4_SFH7741_ENABLE_GPIO, error);
+		goto fail1;
+	}
+
+	error = gpio_direction_output(OMAP4_SFH7741_ENABLE_GPIO , 1);
+	if (error < 0) {
+		pr_err("%s: GPIO configuration failed: GPIO %d,\
+			error %d\n",__func__, OMAP4_SFH7741_ENABLE_GPIO, error);
+		goto fail3;
+	}
+	return;
+
+fail3:
+	gpio_free(OMAP4_SFH7741_ENABLE_GPIO);
+fail1:
+	gpio_free(OMAP4_SFH7741_SENSOR_OUTPUT_GPIO);
+}
 static void __init omap_4430sdp_init(void)
 {
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
@@ -120,6 +190,7 @@ static void __init omap_4430sdp_init(void)
 	/* FIXME: allow multi-omap to boot until musb is updated for omap4 */
 	if (!cpu_is_omap44xx())
 		usb_musb_init(&musb_board_data);
+	omap_sfh7741prox_init();
 }
 
 static void __init omap_4430sdp_map_io(void)
-- 
1.5.4.7

