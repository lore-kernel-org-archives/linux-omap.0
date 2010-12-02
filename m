From: "Hemanth V" <hemanthv@ti.com>
Subject: [PATCH 3/3] omap4: Platform changes for CMA3000 Accelerometer
     driver
Date: Thu, 2 Dec 2010 13:00:25 +0530 (IST)
Message-ID: <54753.10.24.255.17.1291275025.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58324 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003Ab0LBHa0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 02:30:26 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id oB27UPdg025717
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 2 Dec 2010 01:30:25 -0600
Received: from dbdmail.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id oB27UNEg014697
	for <linux-omap@vger.kernel.org>; Thu, 2 Dec 2010 01:30:24 -0600 (CST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

>From 0ce7ea442ffbe89f563baa993669a4216b2ccffa Mon Sep 17 00:00:00 2001
From: Hemanth V <hemanthv@ti.com>
Date: Thu, 2 Dec 2010 12:44:19 +0530
Subject: [PATCH] omap4: Platform changes for CMA3000 Accelerometer driver

Update 4430SDP board file with platform data for accelerometer driver

Signed-off-by: Hemanth V <hemanthv@ti.com>
---
CMA3000 Driver is queued up for 2.6.38 merge window

 arch/arm/mach-omap2/board-4430sdp.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index ea56c30..c336673 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -24,6 +24,8 @@
 #include <linux/regulator/machine.h>
 #include <linux/leds.h>
 #include <linux/leds_pwm.h>
+#include <linux/input/cma3000.h>
+#include <linux/interrupt.h>

 #include <mach/hardware.h>
 #include <mach/omap4-common.h>
@@ -45,6 +47,7 @@
 #define ETH_KS8851_POWER_ON		48
 #define ETH_KS8851_QUART		138
 #define OMAP4_SFH7741_SENSOR_OUTPUT_GPIO	184
+#define OMAP4_CMA3000ACCL_GPIO			186
 #define OMAP4_SFH7741_ENABLE_GPIO		188

 static struct gpio_led sdp4430_gpio_leds[] = {
@@ -477,6 +480,27 @@ static struct twl4030_platform_data sdp4430_twldata = {
 	.vaux3		= &sdp4430_vaux3,
 };

+static struct cma3000_platform_data cma3000_platform_data = {
+	.fuzz_x		= 25,
+	.fuzz_y		= 25,
+	.fuzz_z		= 25,
+	.g_range	= CMARANGE_8G,
+	.mode		= CMAMODE_MOTDET,
+	.mdthr		= 0x8,
+	.mdfftmr	= 0x33,
+	.ffthr		= 0x8,
+	.irqflags	= IRQF_TRIGGER_HIGH,
+};
+
+static void omap_cma3000accl_init(void)
+{
+	if (gpio_request(OMAP4_CMA3000ACCL_GPIO, "Accelerometer") < 0) {
+		pr_err("Accelerometer GPIO request failed\n");
+		return;
+	}
+	gpio_direction_input(OMAP4_CMA3000ACCL_GPIO);
+}
+
 static struct i2c_board_info __initdata sdp4430_i2c_boardinfo[] = {
 	{
 		I2C_BOARD_INFO("twl6030", 0x48),
@@ -497,6 +521,11 @@ static struct i2c_board_info __initdata sdp4430_i2c_4_boardinfo[] = {
 	{
 		I2C_BOARD_INFO("hmc5843", 0x1e),
 	},
+	{
+		I2C_BOARD_INFO("cma3000_d01", 0x1c),
+		.platform_data = &cma3000_platform_data,
+		.irq = OMAP_GPIO_IRQ(OMAP4_CMA3000ACCL_GPIO),
+	},
 };
 static int __init omap4_i2c_init(void)
 {
@@ -531,6 +560,7 @@ static void __init omap_sfh7741prox_init(void)
 			 __func__, OMAP4_SFH7741_ENABLE_GPIO, error);
 		gpio_free(OMAP4_SFH7741_ENABLE_GPIO);
 	}
+	omap_cma3000accl_init();
 }

 #ifdef CONFIG_OMAP_MUX
-- 
1.5.4.3


