From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/3] OMAP1: Amstrad Delta: add camera controlled LEDS trigger
Date: Thu, 30 Sep 2010 11:46:31 -0700
Message-ID: <20100930184631.12052.91647.stgit@baageli.muru.com>
References: <20100930184459.12052.14542.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55280 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754892Ab0I3Sqa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Sep 2010 14:46:30 -0400
In-Reply-To: <20100930184459.12052.14542.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

This patch extends the Amstrad Delta camera support with LEDS trigger that can
be used for automatic control of the on-board camera LED. The led turns on
automatically on camera device open and turns off on camera device close.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-ams-delta.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 12f7f60..248e8bb 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
+#include <linux/leds.h>
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
 
@@ -222,11 +223,30 @@ static struct i2c_board_info ams_delta_camera_board_info[] = {
 	},
 };
 
+#ifdef CONFIG_LEDS_TRIGGERS
+DEFINE_LED_TRIGGER(ams_delta_camera_led_trigger);
+
+static int ams_delta_camera_power(struct device *dev, int power)
+{
+	/*
+	 * turn on camera LED
+	 */
+	if (power)
+		led_trigger_event(ams_delta_camera_led_trigger, LED_FULL);
+	else
+		led_trigger_event(ams_delta_camera_led_trigger, LED_OFF);
+	return 0;
+}
+#else
+#define ams_delta_camera_power	NULL
+#endif
+
 static struct soc_camera_link __initdata ams_delta_iclink = {
 	.bus_id         = 0,	/* OMAP1 SoC camera bus */
 	.i2c_adapter_id = 1,
 	.board_info     = &ams_delta_camera_board_info[0],
 	.module_name    = "ov6650",
+	.power		= ams_delta_camera_power,
 };
 
 static struct platform_device ams_delta_camera_device = {
@@ -281,6 +301,10 @@ static void __init ams_delta_init(void)
 
 	omap1_usb_init(&ams_delta_usb_config);
 	omap1_set_camera_info(&ams_delta_camera_platform_data);
+#ifdef CONFIG_LEDS_TRIGGERS
+	led_trigger_register_simple("ams_delta_camera",
+			&ams_delta_camera_led_trigger);
+#endif
 	platform_add_devices(ams_delta_devices, ARRAY_SIZE(ams_delta_devices));
 
 #ifdef CONFIG_AMS_DELTA_FIQ

