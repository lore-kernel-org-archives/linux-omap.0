From: Sriramakrishnan <srk@ti.com>
Subject: [PATCHv2 2/3] AM3517: Board hookup for TCA6416 keypad driver.
Date: Fri, 12 Mar 2010 14:48:18 +0530
Message-ID: <1268385499-7075-3-git-send-email-srk@ti.com>
References: <1268385499-7075-1-git-send-email-srk@ti.com>
 <1268385499-7075-2-git-send-email-srk@ti.com>
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1268385499-7075-2-git-send-email-srk@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-input@vger.kernel.org
Cc: Sriramakrishnan <srk@ti.com>
List-Id: linux-omap@vger.kernel.org

Add board specific hookup for TCA6416 keypad driver.

Signed-off-by: Sriramakrishnan <srk@ti.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |   47 +++++++++++++++++++++++++++++---
 1 files changed, 42 insertions(+), 5 deletions(-)
 mode change 100644 => 100755 arch/arm/mach-omap2/board-am3517evm.c

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
old mode 100644
new mode 100755
index 6ae8805..d50e505
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
@@ -88,16 +91,50 @@ static struct i2c_board_info __initdata am3517evm_tca6416_info_0[] = {
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
+#define KEYPAD_BUTTON(ev_type, ev_code, act_low) \
+{								\
+	.type		= ev_type,				\
+	.code		= ev_code,				\
+	.active_low	= act_low,				\
+}
+
+#define KEYPAD_BUTTON_LOW(event_code)		\
+	KEYPAD_BUTTON(EV_KEY, event_code, 1)
+
+static struct tca6416_button am3517_gpio_keys[] = {
+	KEYPAD_BUTTON_LOW(KEY_DOWN),
+	KEYPAD_BUTTON_LOW(KEY_UP),
+	KEYPAD_BUTTON_LOW(KEY_MENU),
+	KEYPAD_BUTTON_LOW(KEY_MODE),
+	KEYPAD_BUTTON_LOW(KEY_LEFTSHIFT),
+	KEYPAD_BUTTON_LOW(KEY_REWIND),
+	KEYPAD_BUTTON_LOW(KEY_FORWARD),
+	KEYPAD_BUTTON_LOW(KEY_STOP),
+	KEYPAD_BUTTON_LOW(KEY_PLAY),
+	KEYPAD_BUTTON_LOW(KEY_RECORD),
 };
+
+static struct tca6416_keys_platform_data am3517evm_tca6416_keys_info = {
+	.buttons	= am3517_gpio_keys,
+	.nbuttons	= ARRAY_SIZE(am3517_gpio_keys),
+	.rep		= 1,
+	.use_polling	= 1,
+	.pinmask	= KEYPAD_PIN_MASK,
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

