From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Subject: FW: [PATCH2/2] SFH7741 : Adding board support for proximity sensor
 SFH7741
Date: Mon, 3 May 2010 11:21:45 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003B3164B35@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Datta, Shubhrajyoti 
Sent: Monday, May 03, 2010 11:20 AM
Subject: [PATCH] SFH7741 : Adding board support

Adding board support for the proximity sensor SFH7741.

Signed-off-by: Shubhro <a0393217@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index c261558..72e7b14 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -21,6 +21,7 @@
 #include <linux/usb/otg.h>
 #include <linux/input.h>
 #include <linux/input/matrix_keypad.h>
+#include <linux/input/sfh7741.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -134,6 +135,17 @@ static struct platform_device sdp4430_keypad_device = {
 	},
 };
 
+static struct sfh7741_platform_data omap_sfh7741_data = {
+		.gpio_intr = 184,
+		.gpio_en = 188,
+};
+static struct platform_device sdp4430_proximity_device = {
+	.name		= "sfh7741",
+	.id		= 1,
+	.dev		= {
+		.platform_data = &omap_sfh7741_data,
+	},
+};
 /* Begin Synaptic Touchscreen TM-01217 */
 
 static char *tm12xx_idev_names[] = {
@@ -199,6 +211,7 @@ static struct platform_device sdp4430_lcd_device = {
 static struct platform_device *sdp4430_devices[] __initdata = {
 	&sdp4430_lcd_device,
 	&sdp4430_keypad_device,
+	&sdp4430_proximity_device,
 };
 
 static __attribute__ ((unused)) struct
-- 
1.5.4.7

