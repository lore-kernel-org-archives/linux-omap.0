From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] omap: pandora: add support for wl1251 wifi chip
Date: Thu, 27 May 2010 12:42:43 +0300
Message-ID: <1274953363-1985-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:40916 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755408Ab0E0Jmu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 May 2010 05:42:50 -0400
Received: by wwb34 with SMTP id 34so65539wwb.19
        for <linux-omap@vger.kernel.org>; Thu, 27 May 2010 02:42:48 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Grazvydas Ignotas <notasas@gmail.com>

Define platform data and setup GPIOs so that TI wl1251 wifi chip
and it's driver can function.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
I could have sent this earlier but it depended on the wifi tree,
hope this can still go in for -rc2, it's just platform data anyway.

 arch/arm/mach-omap2/board-omap3pandora.c |   83 ++++++++++++++++++++++++++++++
 1 files changed, 83 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 395d049..8e164f1 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -29,6 +29,7 @@
 #include <linux/input.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/gpio_keys.h>
+#include <linux/spi/wl12xx.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -46,6 +47,8 @@
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "hsmmc.h"
 
+#define PANDORA_WIFI_IRQ_GPIO		21
+#define PANDORA_WIFI_NRESET_GPIO	23
 #define OMAP3_PANDORA_TS_GPIO		94
 
 /* hardware debounce: (value + 1) * 31us */
@@ -248,6 +251,7 @@ static struct omap2_hsmmc_info omap3pandora_mmc[] = {
 		.wires		= 4,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
+		.ocr_mask	= 0x80,	/* MMC_VDD_165_195 */
 	},
 	{}	/* Terminator */
 };
@@ -255,12 +259,33 @@ static struct omap2_hsmmc_info omap3pandora_mmc[] = {
 static int omap3pandora_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
+	int ret, gpio_32khz;
+
 	/* gpio + {0,1} is "mmc{0,1}_cd" (input/IRQ) */
 	omap3pandora_mmc[0].gpio_cd = gpio + 0;
 	omap3pandora_mmc[1].gpio_cd = gpio + 1;
 	omap2_hsmmc_init(omap3pandora_mmc);
 
+	/* gpio + 13 drives 32kHz buffer for wifi module */
+	gpio_32khz = gpio + 13;
+	ret = gpio_request(gpio_32khz, "wifi 32kHz");
+	if (ret < 0) {
+		pr_err("Cannot get GPIO line %d, ret=%d\n", gpio_32khz, ret);
+		goto fail;
+	}
+
+	ret = gpio_direction_output(gpio_32khz, 1);
+	if (ret < 0) {
+		pr_err("Cannot set GPIO line %d, ret=%d\n", gpio_32khz, ret);
+		goto fail_direction;
+	}
+
 	return 0;
+
+fail_direction:
+	gpio_free(gpio_32khz);
+fail:
+	return -ENODEV;
 }
 
 static struct twl4030_gpio_platform_data omap3pandora_gpio_data = {
@@ -539,10 +564,67 @@ static void __init omap3pandora_init_irq(void)
 	omap_gpio_init();
 }
 
+static void pandora_wl1251_set_power(bool enable)
+{
+	/*
+	 * Keep power always on until wl1251_sdio driver learns to re-init
+	 * the chip after powering it down and back up.
+	 */
+}
+
+static struct wl12xx_platform_data pandora_wl1251_pdata = {
+	.set_power	= pandora_wl1251_set_power,
+	.use_eeprom	= true,
+};
+
+static struct platform_device pandora_wl1251_data = {
+	.name           = "wl1251_data",
+	.id             = -1,
+	.dev		= {
+		.platform_data	= &pandora_wl1251_pdata,
+	},
+};
+
+static void pandora_wl1251_init(void)
+{
+	int ret;
+
+	ret = gpio_request(PANDORA_WIFI_IRQ_GPIO, "wl1251 irq");
+	if (ret < 0)
+		goto fail;
+
+	ret = gpio_direction_input(PANDORA_WIFI_IRQ_GPIO);
+	if (ret < 0)
+		goto fail_irq;
+
+	pandora_wl1251_pdata.irq = gpio_to_irq(PANDORA_WIFI_IRQ_GPIO);
+	if (pandora_wl1251_pdata.irq < 0)
+		goto fail_irq;
+
+	ret = gpio_request(PANDORA_WIFI_NRESET_GPIO, "wl1251 nreset");
+	if (ret < 0)
+		goto fail_irq;
+
+	/* start powered so that it probes with MMC subsystem */
+	ret = gpio_direction_output(PANDORA_WIFI_NRESET_GPIO, 1);
+	if (ret < 0)
+		goto fail_nreset;
+
+	return;
+
+fail_nreset:
+	gpio_free(PANDORA_WIFI_NRESET_GPIO);
+fail_irq:
+	gpio_free(PANDORA_WIFI_IRQ_GPIO);
+fail:
+	printk(KERN_ERR "wl1251 board initialisation failed\n");
+}
+
 static struct platform_device *omap3pandora_devices[] __initdata = {
 	&pandora_leds_gpio,
 	&pandora_keys_gpio,
 	&pandora_dss_device,
+	&pandora_wl1251_data,
 };
 
 static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
@@ -575,6 +657,7 @@ static void __init omap3pandora_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap3pandora_i2c_init();
+	pandora_wl1251_init();
 	platform_add_devices(omap3pandora_devices,
 			ARRAY_SIZE(omap3pandora_devices));
 	omap_serial_init();
-- 
1.6.3.3

