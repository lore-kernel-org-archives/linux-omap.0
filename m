From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH 2/3] ARM OMAP3: RX-51 board: add initialization of gpio keys
Date: Fri, 30 Oct 2009 15:38:27 +0200
Message-ID: <859ce18ccdcfac80d2fafa73b6aef2fa5fd6feb6.1256907278.git.ext-jani.1.nikula@nokia.com>
References: <20091027162040.GB22541@core.coreip.homeip.net>
 <cover.1256907278.git.ext-jani.1.nikula@nokia.com>
 <48e6c73d2c8e67e1d2eec68556e7885f6d10c203.1256907278.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:40781 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757234AbZJ3Niv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Oct 2009 09:38:51 -0400
In-Reply-To: <48e6c73d2c8e67e1d2eec68556e7885f6d10c203.1256907278.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1256907278.git.ext-jani.1.nikula@nokia.com>
References: <cover.1256907278.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, dmitry.torokhov@gmail.com
Cc: linux-omap@vger.kernel.org, linux-input@vger.kernel.org, ext-jani.1.nikula@nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Initialize some of the RX-51 input GPIO lines as gpio keys.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 arch/arm/mach-omap2/board-rx51.c |   84 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 84 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index f1e7e5b..fe47790 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -16,6 +16,8 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/input.h>
+#include <linux/gpio_keys.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -30,6 +32,86 @@
 #include <plat/gpmc.h>
 #include <plat/usb.h>
 
+#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
+
+#define RX51_GPIO_CAMERA_LENSE_COVER	110
+#define RX51_GPIO_CAMERA_FOCUS		68
+#define RX51_GPIO_CAMERA_CAPTURE	69
+#define RX51_GPIO_KEYPAD_SLIDE		71
+#define RX51_GPIO_LOCK_BUTTON		113
+#define RX51_GPIO_PROXIMITY		89
+
+#define RX51_GPIO_DEBOUNCE_TIMEOUT	10
+
+static struct gpio_keys_button rx51_gpio_keys[] = {
+	{
+		.desc			= "Camera Lense Cover",
+		.type			= EV_SW,
+		.code			= SW_CAMERA_LENSE_COVER,
+		.gpio			= RX51_GPIO_CAMERA_LENSE_COVER,
+		.active_low		= 1,
+		.debounce_interval	= RX51_GPIO_DEBOUNCE_TIMEOUT,
+	}, {
+		.desc			= "Camera Focus",
+		.type			= EV_KEY,
+		.code			= KEY_CAMERA_FOCUS,
+		.gpio			= RX51_GPIO_CAMERA_FOCUS,
+		.active_low		= 1,
+		.debounce_interval	= RX51_GPIO_DEBOUNCE_TIMEOUT,
+	}, {
+		.desc			= "Camera Capture",
+		.type			= EV_KEY,
+		.code			= KEY_CAMERA,
+		.gpio			= RX51_GPIO_CAMERA_CAPTURE,
+		.active_low		= 1,
+		.debounce_interval	= RX51_GPIO_DEBOUNCE_TIMEOUT,
+	}, {
+		.desc			= "Lock Button",
+		.type			= EV_KEY,
+		.code			= KEY_SCREENLOCK,
+		.gpio			= RX51_GPIO_LOCK_BUTTON,
+		.active_low		= 1,
+		.debounce_interval	= RX51_GPIO_DEBOUNCE_TIMEOUT,
+	}, {
+		.desc			= "Keypad Slide",
+		.type			= EV_SW,
+		.code			= SW_KEYPAD_SLIDE,
+		.gpio			= RX51_GPIO_KEYPAD_SLIDE,
+		.active_low		= 1,
+		.debounce_interval	= RX51_GPIO_DEBOUNCE_TIMEOUT,
+	}, {
+		.desc			= "Proximity Sensor",
+		.type			= EV_SW,
+		.code			= SW_FRONT_PROXIMITY,
+		.gpio			= RX51_GPIO_PROXIMITY,
+		.active_low		= 0,
+		.debounce_interval	= RX51_GPIO_DEBOUNCE_TIMEOUT,
+	}
+};
+
+static struct gpio_keys_platform_data rx51_gpio_keys_data = {
+	.buttons	= rx51_gpio_keys,
+	.nbuttons	= ARRAY_SIZE(rx51_gpio_keys),
+};
+
+static struct platform_device rx51_gpio_keys_device = {
+	.name	= "gpio-keys",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &rx51_gpio_keys_data,
+	},
+};
+
+static void __init rx51_add_gpio_keys(void)
+{
+	platform_device_register(&rx51_gpio_keys_device);
+}
+#else
+static void __init rx51_add_gpio_keys(void)
+{
+}
+#endif
+
 static struct omap_lcd_config rx51_lcd_config = {
 	.ctrl_name	= "internal",
 };
@@ -73,6 +155,8 @@ static void __init rx51_init(void)
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_cfg_reg(H16_34XX_SDRC_CKE0);
 	omap_cfg_reg(H17_34XX_SDRC_CKE1);
+
+	rx51_add_gpio_keys();
 }
 
 static void __init rx51_map_io(void)
-- 
1.6.5.2

