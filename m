From: "Arce, Abraham" <x0066660@ti.com>
Subject: [RFC] [PATCH v2 3/4] OMAP4: Keyboard board support
Date: Thu, 13 May 2010 15:50:46 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043E113BFB@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Keyboard support for SDP OMAP4430

Signed-off-by: Abraham Arce <x0066660@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |  157 +++++++++++++++++++++++++++++++++++
 1 files changed, 157 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 6cce6f2..19742c5 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -19,6 +19,8 @@
 #include <linux/gpio.h>
 #include <linux/usb/otg.h>
 #include <linux/spi/spi.h>
+#include <linux/input.h>
+#include <linux/input/matrix_keypad.h>
 
 #include <mach/hardware.h>
 #include <mach/omap4-common.h>
@@ -31,11 +33,161 @@
 #include <plat/control.h>
 #include <plat/timer-gp.h>
 #include <plat/usb.h>
+#include <plat/omap_device.h>
+#include <plat/omap_hwmod.h>
 
 #define ETH_KS8851_IRQ			34
 #define ETH_KS8851_POWER_ON		48
 #define ETH_KS8851_QUART		138
 
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
+static struct matrix_keypad_platform_data sdp4430_keypad_data = {
+	.keymap_data		= &sdp4430_keymap_data,
+	.num_row_gpios		= 8,
+	.num_col_gpios		= 8,
+	.device_enable		= omap_device_enable,
+	.device_shutdown	= omap_device_shutdown,
+	.device_idle		= omap_device_idle,
+};
+
+static struct platform_device sdp4430_keypad_device = {
+	.name		= "omap4-keypad",
+	.id		= -1,
+	.dev		= {
+		.platform_data = &sdp4430_keypad_data,
+	},
+};
+
+struct omap_device_pm_latency omap_keyboard_latency[] = {
+	{
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func   = omap_device_enable_hwmods,
+		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
+struct omap_device *od;
+
+static int __init sdp4430_keypad_init(void)
+{
+	struct omap_hwmod *oh;
+	struct matrix_keypad_platform_data *pdata;
+
+	unsigned int length = 0, id = 0;
+	int hw_mod_name_len = 16;
+	char oh_name[hw_mod_name_len];
+	char *name = "omap4-keypad";
+
+	length = snprintf(oh_name, hw_mod_name_len, "keyboard");
+
+	oh = omap_hwmod_lookup(oh_name);
+	if (!oh) {
+		pr_err("Could not look up %s\n", oh_name);
+		return -EIO;
+	}
+
+	pdata = kzalloc(sizeof(struct matrix_keypad_platform_data), GFP_KERNEL);
+	if (!pdata) {
+		WARN(1, "Keyboard pdata memory allocation failed\n");
+		return -ENOMEM;
+	}
+
+	pdata = &sdp4430_keypad_data;
+
+	pdata->base = oh->_rt_va;
+	pdata->irq = oh->mpu_irqs[0].irq;
+	pdata->device_enable = omap_device_enable;
+	pdata->device_idle = omap_device_idle;
+	pdata->device_shutdown = omap_device_shutdown;
+
+	od = omap_device_build(name, id, oh, pdata,
+			sizeof(struct matrix_keypad_platform_data),
+			omap_keyboard_latency,
+			ARRAY_SIZE(omap_keyboard_latency), 1);
+	WARN(IS_ERR(od), "Could not build omap_device for %s %s\n",
+		name, oh_name);
+
+	return 0;
+}
+
 static struct spi_board_info sdp4430_spi_board_info[] __initdata = {
 	{
 		.modalias               = "ks8851",
@@ -108,6 +260,7 @@ static struct platform_device sdp4430_lcd_device = {
 
 static struct platform_device *sdp4430_devices[] __initdata = {
 	&sdp4430_lcd_device,
+	&sdp4430_keypad_device,
 };
 
 static struct omap_lcd_config sdp4430_lcd_config __initdata = {
@@ -140,6 +293,10 @@ static void __init omap_4430sdp_init(void)
 {
 	int status;
 
+	status = sdp4430_keypad_init();
+	if (status)
+		pr_err("Keypad initialization failed: %d\n", status);
+
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
 	omap_serial_init();
 	/* OMAP4 SDP uses internal transceiver so register nop transceiver */
-- 
1.5.4.3

