From: Abraham Arce <x0066660@ti.com>
Subject: [PATCH v6 7/8] OMAP4: Keyboard board support
Date: Thu, 30 Sep 2010 00:36:13 -0500
Message-ID: <1285824973-25550-1-git-send-email-x0066660@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Syed Rafiuddin <rafiuddin.syed@ti.com>, Abraham Arce <x0066660@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Syed Rafiuddin <rafiuddin.syed@ti.com>

Keyboard support for SDP OMAP4430

Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
Signed-off-by: Abraham Arce <x0066660@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   90 +++++++++++++++++++++++++++++++++++
 1 files changed, 90 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 1bed1e6..2991e56 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -33,6 +33,7 @@
 #include <plat/board.h>
 #include <plat/common.h>
 #include <plat/control.h>
+#include <plat/omap4-keypad.h>
 #include <plat/timer-gp.h>
 #include <plat/usb.h>
 #include <plat/mmc.h>
@@ -44,6 +45,91 @@
 #define OMAP4_SFH7741_SENSOR_OUTPUT_GPIO	184
 #define OMAP4_SFH7741_ENABLE_GPIO		188
 
+static int sdp4430_keymap[] = {
+	KEY(0, 0, KEY_E),
+	KEY(0, 1, KEY_R),
+	KEY(0, 2, KEY_T),
+	KEY(0, 3, KEY_HOME),
+	KEY(0, 4, KEY_F5),
+	KEY(0, 5, KEY_UNKNOWN),
+	KEY(0, 6, KEY_I),
+	KEY(0, 7, KEY_LEFTSHIFT),
+
+	KEY(1, 0, KEY_D),
+	KEY(1, 1, KEY_F),
+	KEY(1, 2, KEY_G),
+	KEY(1, 3, KEY_SEND),
+	KEY(1, 4, KEY_F6),
+	KEY(1, 5, KEY_UNKNOWN),
+	KEY(1, 6, KEY_K),
+	KEY(1, 7, KEY_ENTER),
+
+	KEY(2, 0, KEY_X),
+	KEY(2, 1, KEY_C),
+	KEY(2, 2, KEY_V),
+	KEY(2, 3, KEY_END),
+	KEY(2, 4, KEY_F7),
+	KEY(2, 5, KEY_UNKNOWN),
+	KEY(2, 6, KEY_DOT),
+	KEY(2, 7, KEY_CAPSLOCK),
+
+	KEY(3, 0, KEY_Z),
+	KEY(3, 1, KEY_KPPLUS),
+	KEY(3, 2, KEY_B),
+	KEY(3, 3, KEY_F1),
+	KEY(3, 4, KEY_F8),
+	KEY(3, 5, KEY_UNKNOWN),
+	KEY(3, 6, KEY_O),
+	KEY(3, 7, KEY_SPACE),
+
+	KEY(4, 0, KEY_W),
+	KEY(4, 1, KEY_Y),
+	KEY(4, 2, KEY_U),
+	KEY(4, 3, KEY_F2),
+	KEY(4, 4, KEY_VOLUMEUP),
+	KEY(4, 5, KEY_UNKNOWN),
+	KEY(4, 6, KEY_L),
+	KEY(4, 7, KEY_LEFT),
+
+	KEY(5, 0, KEY_S),
+	KEY(5, 1, KEY_H),
+	KEY(5, 2, KEY_J),
+	KEY(5, 3, KEY_F3),
+	KEY(5, 4, KEY_F9),
+	KEY(5, 5, KEY_VOLUMEDOWN),
+	KEY(5, 6, KEY_M),
+	KEY(5, 7, KEY_RIGHT),
+
+	KEY(6, 0, KEY_Q),
+	KEY(6, 1, KEY_A),
+	KEY(6, 2, KEY_N),
+	KEY(6, 3, KEY_BACK),
+	KEY(6, 4, KEY_BACKSPACE),
+	KEY(6, 5, KEY_UNKNOWN),
+	KEY(6, 6, KEY_P),
+	KEY(6, 7, KEY_UP),
+
+	KEY(7, 0, KEY_PROG1),
+	KEY(7, 1, KEY_PROG2),
+	KEY(7, 2, KEY_PROG3),
+	KEY(7, 3, KEY_PROG4),
+	KEY(7, 4, KEY_F4),
+	KEY(7, 5, KEY_UNKNOWN),
+	KEY(7, 6, KEY_OK),
+	KEY(7, 7, KEY_DOWN),
+};
+
+static struct matrix_keymap_data sdp4430_keymap_data = {
+	.keymap			= sdp4430_keymap,
+	.keymap_size		= ARRAY_SIZE(sdp4430_keymap),
+};
+
+static struct omap4_keypad_platform_data sdp4430_keypad_data = {
+	.keymap_data		= &sdp4430_keymap_data,
+	.rows			= 8,
+	.cols			= 8,
+};
+
 static struct gpio_led sdp4430_gpio_leds[] = {
 	{
 		.name	= "omap4:green:debug0",
@@ -507,6 +593,10 @@ static void __init omap_4430sdp_init(void)
 	if (!cpu_is_omap44xx())
 		usb_musb_init(&musb_board_data);
 
+	status = omap4_keyboard_init(&sdp4430_keypad_data);
+	if (status)
+		pr_err("Keypad initialization failed: %d\n", status);
+
 	status = omap_ethernet_init();
 	if (status) {
 		pr_err("Ethernet initialization failed: %d\n", status);
-- 
1.6.3.3

