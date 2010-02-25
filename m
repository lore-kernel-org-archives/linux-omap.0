From: Sriramakrishnan <srk@ti.com>
Subject: [PATCH 3/3] AM3517: Board hookup for TCA6416 keypad driver.
Date: Thu, 25 Feb 2010 18:45:01 +0530
Message-ID: <1267103701-23823-4-git-send-email-srk@ti.com>
References: <1267103701-23823-1-git-send-email-srk@ti.com>
 <1267103701-23823-2-git-send-email-srk@ti.com>
 <1267103701-23823-3-git-send-email-srk@ti.com>
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1267103701-23823-3-git-send-email-srk@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-input@vger.kernel.org
Cc: Sriramakrishnan <srk@ti.com>
List-Id: linux-omap@vger.kernel.org

Add board specific hookup for TCA6416 keypad driver.

Signed-off-by: Sriramakrishnan <srk@ti.com>
---
This patch depends on "AM3517EVM : correct typo - tca6416 mispelt as tca6516"
patch submitted earlier.
[1] http://marc.info/?l=linux-omap&m=126709475619102&w=2


 arch/arm/mach-omap2/board-am3517evm.c |   48 +++++++++++++++++++++++++++++---
 1 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index b336adc..a8228b7 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -20,7 +20,10 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
+#include <linux/i2c.h>
 #include <linux/i2c/pca953x.h>
+#include <linux/input.h>
+#include <linux/tca6416_keypad.h>
 
 #include <mach/hardware.h>
 #include <mach/am35xx.h>
@@ -88,16 +91,51 @@ static struct i2c_board_info __initdata am3517evm_tca6416_info_0[] = {
 };
 
 /* Mounted on UI Card */
-static struct pca953x_platform_data am3517evm_ui_gpio_expander_info_1 = {
+/* IO expander at address 0x20 on UI card will be managed by Keypad driver */
+
+static struct pca953x_platform_data am3517evm_ui_gpio_expander_info_2 = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES + 16,
 };
-static struct pca953x_platform_data am3517evm_ui_gpio_expander_info_2 = {
-	.gpio_base	= OMAP_MAX_GPIO_LINES + 32,
+
+/*Keypad Initialization */
+#define KEYPAD_PIN_MASK                0xFFC0
+
+#define KEYPAD_BUTTON(ev_type, ev_code, act_low, descr) \
+{                                                               \
+	.type           = ev_type,                              \
+	.code           = ev_code,                              \
+	.active_low     = act_low,                              \
+	.desc           = "btn " descr,                         \
+}
+
+#define KEYPAD_BUTTON_LOW(event_code, description)      \
+	KEYPAD_BUTTON(EV_KEY, event_code, 1, description)
+
+static struct gpio_keys_button am3517_gpio_keys[] = {
+	KEYPAD_BUTTON_LOW(KEY_DOWN, "down"),
+	KEYPAD_BUTTON_LOW(KEY_UP, "up"),
+	KEYPAD_BUTTON_LOW(KEY_MENU, "menu"),
+	KEYPAD_BUTTON_LOW(KEY_MODE, "mode"),
+	KEYPAD_BUTTON_LOW(KEY_LEFTSHIFT, "shift"),
+	KEYPAD_BUTTON_LOW(KEY_REWIND, "rewind"),
+	KEYPAD_BUTTON_LOW(KEY_FORWARD, "forward"),
+	KEYPAD_BUTTON_LOW(KEY_STOP, "stop"),
+	KEYPAD_BUTTON_LOW(KEY_PLAY, "play"),
+	KEYPAD_BUTTON_LOW(KEY_RECORD, "rec"),
 };
+
+static struct tca6416_keys_platform_data am3517evm_tca6416_keys_info = {
+	.buttons        = am3517_gpio_keys,
+	.nbuttons       = ARRAY_SIZE(am3517_gpio_keys),
+	.rep            = 0,
+	.use_polling    = 1,
+	.pinmask        = KEYPAD_PIN_MASK,
+};
+
 static struct i2c_board_info __initdata am3517evm_ui_tca6416_info[] = {
 	{
-		I2C_BOARD_INFO("tca6416", 0x20),
-		.platform_data = &am3517evm_ui_gpio_expander_info_1,
+		I2C_BOARD_INFO("tca6416-keys", 0x20),
+		.platform_data = &am3517evm_tca6416_keys_info,
 	},
 	{
 		I2C_BOARD_INFO("tca6416", 0x21),
-- 
1.6.2.4

