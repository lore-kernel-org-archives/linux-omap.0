From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v2 2/2] ARM OMAP3: RX-51 board: add initialization of gpio keys
Date: Wed,  4 Nov 2009 17:13:58 +0200
Message-ID: <369a0c7adf29df9ed677aa545f053ec8e4d5b186.1257345114.git.ext-jani.1.nikula@nokia.com>
References: <cover.1256907278.git.ext-jani.1.nikula@nokia.com>
 <cover.1257345114.git.ext-jani.1.nikula@nokia.com>
 <b85619d1e1ada6e4defc722479e57d809fd3614e.1257345114.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <b85619d1e1ada6e4defc722479e57d809fd3614e.1257345114.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1257345114.git.ext-jani.1.nikula@nokia.com>
References: <cover.1257345114.git.ext-jani.1.nikula@nokia.com>
Sender: linux-input-owner@vger.kernel.org
To: tony@atomide.com, dmitry.torokhov@gmail.com
Cc: james@mastros.biz, linux-omap@vger.kernel.org, linux-input@vger.kernel.org, ext-jani.1.nikula@nokia.com
List-Id: linux-omap@vger.kernel.org

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Initialize some of the RX-51 input GPIO lines as gpio keys. Enable gpio
keys as a module in rx51_defconfig.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 arch/arm/configs/rx51_defconfig              |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c |   82 ++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/rx51_defconfig b/arch/arm/configs/rx51_defconfig
index e7e3133..1559734 100644
--- a/arch/arm/configs/rx51_defconfig
+++ b/arch/arm/configs/rx51_defconfig
@@ -784,7 +784,7 @@ CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_XTKBD is not set
 # CONFIG_KEYBOARD_NEWTON is not set
 # CONFIG_KEYBOARD_STOWAWAY is not set
-# CONFIG_KEYBOARD_GPIO is not set
+CONFIG_KEYBOARD_GPIO=m
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
 # CONFIG_INPUT_TABLET is not set
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index cf4583a..fb5988c 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/regulator/machine.h>
 #include <linux/gpio.h>
+#include <linux/gpio_keys.h>
 #include <linux/mmc/host.h>
 
 #include <plat/mcspi.h>
@@ -36,6 +37,86 @@
 #define SYSTEM_REV_B_USES_VAUX3	0x1699
 #define SYSTEM_REV_S_USES_VAUX3 0x8
 
+#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
+
+#define RX51_GPIO_CAMERA_LENS_COVER	110
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
+		.desc			= "Camera Lens Cover",
+		.type			= EV_SW,
+		.code			= SW_CAMERA_LENS_COVER,
+		.gpio			= RX51_GPIO_CAMERA_LENS_COVER,
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
+#endif /* CONFIG_KEYBOARD_GPIO || CONFIG_KEYBOARD_GPIO_MODULE */
+
 static int board_keymap[] = {
 	KEY(0, 0, KEY_Q),
 	KEY(0, 1, KEY_O),
@@ -541,5 +622,6 @@ void __init rx51_peripherals_init(void)
 	rx51_i2c_init();
 	board_onenand_init();
 	board_smc91x_init();
+	rx51_add_gpio_keys();
 }
 
-- 
1.6.5.2

