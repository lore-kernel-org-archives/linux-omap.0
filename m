From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 4/4] OMAP4: SDP4430: Add vibrator platform data
Date: Tue, 2 Aug 2011 14:28:46 +0300
Message-ID: <1312284526-1656-6-git-send-email-peter.ujfalusi@ti.com>
References: <1312284526-1656-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53095 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753955Ab1HBL3L (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Aug 2011 07:29:11 -0400
In-Reply-To: <1312284526-1656-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>, Benoit Cousson <b-cousson@ti.com>, Sebastien Guiriec <s-guiriec@ti.com>

From: Misael Lopez Cruz <misael.lopez@ti.com>

Blaze/SDP4430 contains two 10-Ohms vibrator motors, both supplied
by VBAT_PROC (3.75V).

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   37 ++++++++++++++++++++++++++++++++++-
 1 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 95396ce..1060d48 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -22,6 +22,7 @@
 #include <linux/i2c/twl.h>
 #include <linux/gpio_keys.h>
 #include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 #include <linux/leds.h>
 #include <linux/leds_pwm.h>
 
@@ -311,11 +312,40 @@ static struct platform_device sdp4430_lcd_device = {
 	.id		= -1,
 };
 
+static struct regulator_consumer_supply sdp4430_vbat_supply[] = {
+	REGULATOR_SUPPLY("vddvibl", "twl6040-vibra"),
+	REGULATOR_SUPPLY("vddvibr", "twl6040-vibra"),
+};
+
+static struct regulator_init_data sdp4430_vbat_data = {
+	.constraints = {
+		.always_on	= 1,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(sdp4430_vbat_supply),
+	.consumer_supplies	= sdp4430_vbat_supply,
+};
+
+static struct fixed_voltage_config sdp4430_vbat_pdata = {
+	.supply_name	= "VBAT",
+	.microvolts	= 3750000,
+	.init_data	= &sdp4430_vbat_data,
+	.gpio		= -EINVAL,
+};
+
+static struct platform_device sdp4430_vbat = {
+	.name		= "reg-fixed-voltage",
+	.id		= -1,
+	.dev = {
+		.platform_data = &sdp4430_vbat_pdata,
+	},
+};
+
 static struct platform_device *sdp4430_devices[] __initdata = {
 	&sdp4430_lcd_device,
 	&sdp4430_gpio_keys_device,
 	&sdp4430_leds_gpio,
 	&sdp4430_leds_pwm,
+	&sdp4430_vbat,
 };
 
 static struct omap_lcd_config sdp4430_lcd_config __initdata = {
@@ -572,7 +602,12 @@ static struct twl4030_codec_audio_data twl6040_audio = {
 };
 
 static struct twl4030_codec_vibra_data twl6040_vibra = {
-	/* Add vibra only data */
+	.vibldrv_res = 8,
+	.vibrdrv_res = 3,
+	.viblmotor_res = 10,
+	.vibrmotor_res = 10,
+	.vddvibl_uV = 0,	/* fixed volt supply - VBAT */
+	.vddvibr_uV = 0,	/* fixed volt supply - VBAT */
 };
 
 static struct twl4030_codec_data twl6040_codec = {
-- 
1.7.5.rc3

