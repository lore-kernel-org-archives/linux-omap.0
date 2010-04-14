From: "Arce, Abraham" <x0066660@ti.com>
Subject: [RFC] [PATCH 2/3] OMAP4: Keyboard Board Support
Date: Tue, 13 Apr 2010 20:10:58 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043D9EE7F6@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36419 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753866Ab0DNBK7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Apr 2010 21:10:59 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Syed Rafiuddin <rafiuddin.syed@ti.com>

Keyboard support for SDP OMAP4430

Signed-off-by: Abraham Arce <x0066660@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   61 ++++++++++++++--------------------
 1 files changed, 25 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 9a35367..747a4d8 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -35,16 +35,13 @@
 #include <plat/timer-gp.h>
 #include <plat/usb.h>
 #include <plat/syntm12xx.h>
-#include <plat/keypad.h>
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <linux/i2c/twl.h>
 #include <linux/regulator/machine.h>
 #include "mmc-twl4030.h"
 
-#define OMAP4_KBDOCP_BASE               0x4A31C000
-
-static int omap_keymap[] = {
+static int sdp4430_keymap[] = {
 	KEY(0, 0, KEY_E),
 	KEY(0, 1, KEY_D),
 	KEY(0, 2, KEY_X),
@@ -52,7 +49,7 @@ static int omap_keymap[] = {
 	KEY(0, 4, KEY_W),
 	KEY(0, 5, KEY_S),
 	KEY(0, 6, KEY_Q),
-	KEY(0, 7, KEY_UNKNOWN),
+	KEY(0, 7, KEY_PROG1),
 
 	KEY(1, 0, KEY_R),
 	KEY(1, 1, KEY_F),
@@ -61,7 +58,7 @@ static int omap_keymap[] = {
 	KEY(1, 4, KEY_Y),
 	KEY(1, 5, KEY_H),
 	KEY(1, 6, KEY_A),
-	KEY(1, 7, KEY_UNKNOWN),
+	KEY(1, 7, KEY_PROG2),
 
 	KEY(2, 0, KEY_T),
 	KEY(2, 1, KEY_G),
@@ -70,23 +67,23 @@ static int omap_keymap[] = {
 	KEY(2, 4, KEY_U),
 	KEY(2, 5, KEY_J),
 	KEY(2, 6, KEY_N),
-	KEY(2, 7, KEY_UNKNOWN),
+	KEY(2, 7, KEY_PROG3),
 
 	KEY(3, 0, KEY_HOME),
 	KEY(3, 1, KEY_SEND),
 	KEY(3, 2, KEY_END),
 	KEY(3, 3, KEY_F1),
-	KEY(3, 4, KEY_LEFTSHIFT),
+	KEY(3, 4, KEY_F2),
 	KEY(3, 5, KEY_F3),
 	KEY(3, 6, KEY_BACK),
-	KEY(3, 7, KEY_UNKNOWN),
+	KEY(3, 7, KEY_PROG4),
 
-	KEY(4, 0, KEY_UNKNOWN),
-	KEY(4, 1, KEY_UNKNOWN),
-	KEY(4, 2, KEY_UNKNOWN),
-	KEY(4, 3, KEY_UNKNOWN),
+	KEY(4, 0, KEY_F5),
+	KEY(4, 1, KEY_F6),
+	KEY(4, 2, KEY_F7),
+	KEY(4, 3, KEY_F8),
 	KEY(4, 4, KEY_VOLUMEUP),
-	KEY(4, 5, KEY_UNKNOWN),
+	KEY(4, 5, KEY_F9),
 	KEY(4, 6, KEY_BACKSPACE),
 	KEY(4, 7, KEY_F4),
 
@@ -108,7 +105,7 @@ static int omap_keymap[] = {
 	KEY(6, 6, KEY_P),
 	KEY(6, 7, KEY_OK),
 
-	KEY(7, 0, KEY_UNKNOWN),
+	KEY(7, 0, KEY_LEFTSHIFT),
 	KEY(7, 1, KEY_ENTER),
 	KEY(7, 2, KEY_CAPSLOCK),
 	KEY(7, 3, KEY_SPACE),
@@ -119,31 +116,23 @@ static int omap_keymap[] = {
 	0,
 };
 
-static struct resource sdp4430_kp_resources[] = {
-	{
-		.start  = OMAP4_KBDOCP_BASE,
-		.end    = OMAP4_KBDOCP_BASE,
-		.flags  = IORESOURCE_MEM,
-	},
-};
+static struct matrix_keymap_data sdp4430_keymap_data = {
+	.keymap			= sdp4430_keymap,
+	.keymap_size		= ARRAY_SIZE(sdp4430_keymap),
+ };
 
-static struct omap_kp_platform_data omap_kp_data = {
-	.rows		= 8,
-	.cols		= 8,
-	.keymap		= omap_keymap,
-	.keymapsize	= ARRAY_SIZE(omap_keymap),
-	.delay		= 4,
-	.rep		= 1,
-};
+static struct matrix_keypad_platform_data sdp4430_keypad_data = {
+	.keymap_data		= &sdp4430_keymap_data,
+	.num_row_gpios		= 8,
+	.num_col_gpios		= 8,
+ };
 
-static struct platform_device omap_kp_device = {
-	.name		= "omap-keypad",
+static struct platform_device sdp4430_keypad_device = {
+	.name		= "omap4-keypad",
 	.id		= -1,
 	.dev		= {
-		.platform_data = &omap_kp_data,
+		.platform_data = &sdp4430_keypad_data,
 	},
-	.num_resources	= ARRAY_SIZE(sdp4430_kp_resources),
-	.resource	= sdp4430_kp_resources,
 };
 
 /* Begin Synaptic Touchscreen TM-01217 */
@@ -210,7 +199,7 @@ static struct platform_device sdp4430_lcd_device = {
 
 static struct platform_device *sdp4430_devices[] __initdata = {
 	&sdp4430_lcd_device,
-	&omap_kp_device,
+	&sdp4430_keypad_device,
 };
 
 static __attribute__ ((unused)) struct
-- 
1.5.4.3

