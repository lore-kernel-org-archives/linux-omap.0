From: "Hemanth V" <hemanthv@ti.com>
Subject: [PATCH 2/2] OMAP4: Add support for PWM LED
Date: Wed, 30 Jun 2010 19:34:43 +0530 (IST)
Message-ID: <17175.10.24.255.18.1277906683.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56880 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817Ab0F3OEo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jun 2010 10:04:44 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o5UE4hKS012888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 30 Jun 2010 09:04:43 -0500
Received: from dbdmail.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id o5UE4fuM020035
	for <linux-omap@vger.kernel.org>; Wed, 30 Jun 2010 09:04:42 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

>From 713727188b99465341767eedaa42004862261211 Mon Sep 17 00:00:00 2001
From: Hemanth V <hemanthv@ti.com>
Date: Wed, 30 Jun 2010 18:16:33 +0530
Subject: [PATCH] OMAP4: Add support for PWM LED

TWL6030 supports PWM (Pulse Width Modulator) which is used
to control charging LED. This allows for controlling brightness
This patch implements the APIs needed by leds-pwm driver.

Signed-off-by: Hemanth V <hemanthv@ti.com>
---
 arch/arm/mach-omap2/Kconfig         |    1 +
 arch/arm/mach-omap2/Makefile        |    2 +
 arch/arm/mach-omap2/board-4430sdp.c |   25 +++++
 arch/arm/mach-omap2/twl6030_pwm.c   |  168 +++++++++++++++++++++++++++++++++++
 4 files changed, 196 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/twl6030_pwm.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index b31b6f1..da10997 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -156,6 +156,7 @@ config MACH_OMAP_3630SDP
 config MACH_OMAP_4430SDP
 	bool "OMAP 4430 SDP board"
 	depends on ARCH_OMAP4
+	select HAVE_PWM

 config OMAP3_EMU
 	bool "OMAP3 debugging peripherals"
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 6c6d7c6..778affc 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -161,3 +161,5 @@ obj-y					+= $(nand-m) $(nand-y)

 smc91x-$(CONFIG_SMC91X)			:= gpmc-smc91x.o
 obj-y					+= $(smc91x-m) $(smc91x-y)
+
+obj-$(CONFIG_LEDS_PWM)			+= twl6030_pwm.o
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index b213032..b901b9d 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -22,6 +22,7 @@
 #include <linux/i2c/twl.h>
 #include <linux/regulator/machine.h>
 #include <linux/leds.h>
+#include <linux/leds_pwm.h>

 #include <mach/hardware.h>
 #include <mach/omap4-common.h>
@@ -89,6 +90,29 @@ static struct platform_device sdp4430_leds_gpio = {
 		.platform_data = &sdp4430_led_data,
 	},
 };
+
+static struct led_pwm sdp4430_pwm_leds[] = {
+	{
+	.name = "omap4:green:chrg",
+	.pwm_id = 1,
+	.max_brightness = 255,
+	.pwm_period_ns = 7812500,
+	},
+};
+
+static struct led_pwm_platform_data sdp4430_pwm_data = {
+	.num_leds = 1,
+	.leds = sdp4430_pwm_leds,
+};
+
+static struct platform_device sdp4430_leds_pwm = {
+	.name	= "leds_pwm",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &sdp4430_pwm_data,
+	},
+};
+
 static struct spi_board_info sdp4430_spi_board_info[] __initdata = {
 	{
 		.modalias               = "ks8851",
@@ -162,6 +186,7 @@ static struct platform_device sdp4430_lcd_device = {
 static struct platform_device *sdp4430_devices[] __initdata = {
 	&sdp4430_lcd_device,
 	&sdp4430_leds_gpio,
+	&sdp4430_leds_pwm,
 };

 static struct omap_lcd_config sdp4430_lcd_config __initdata = {
diff --git a/arch/arm/mach-omap2/twl6030_pwm.c b/arch/arm/mach-omap2/twl6030_pwm.c
new file mode 100644
index 0000000..5140a92
--- /dev/null
+++ b/arch/arm/mach-omap2/twl6030_pwm.c
@@ -0,0 +1,168 @@
+/*
+ * twl6030_pwm.c
+ * Driver for PHOENIX (TWL6030) Pulse Width Modulator
+ *
+ * Copyright (C) 2010 Texas Instruments
+ * Author: Hemanth V <hemanthv@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/i2c/twl.h>
+#include <linux/slab.h>
+
+#define LED_PWM_CTRL1	0xF4
+#define LED_PWM_CTRL2	0xF5
+
+/* Max value for CTRL1 register */
+#define PWM_CTRL1_MAX	255
+
+/* Pull down disable */
+#define PWM_CTRL2_DIS_PD	(1 << 6)
+
+/* Current control 0, 1, 2.5, 5 mA */
+#define PWM_CTRL2_CURR_00	(0 << 4)
+#define PWM_CTRL2_CURR_01	(1 << 4)
+#define PWM_CTRL2_CURR_02	(2 << 4)
+#define PWM_CTRL2_CURR_05	(3 << 4)
+
+/* LED supply source */
+#define PWM_CTRL2_SRC_VBUS	(0 << 2)
+#define PWM_CTRL2_SRC_VAC	(1 << 2)
+#define PWM_CTRL2_SRC_EXT	(2 << 2)
+
+/* LED modes */
+#define PWM_CTRL2_MODE_HW	(0 << 0)
+#define PWM_CTRL2_MODE_SW	(1 << 0)
+#define PWM_CTRL2_MODE_DIS	(2 << 0)
+
+#define PWM_CTRL2_MODE_MASK	0x3
+
+struct pwm_device {
+	const char *label;
+	unsigned int pwm_id;
+};
+
+int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
+{
+	u8 duty_cycle;
+	int ret;
+
+	if (pwm == NULL || period_ns == 0 || duty_ns > period_ns)
+		return -EINVAL;
+
+	duty_cycle = (duty_ns * PWM_CTRL1_MAX) / period_ns;
+
+	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, duty_cycle, LED_PWM_CTRL1);
+
+	if (ret < 0) {
+		pr_err("%s: Failed to configure PWM, Error %d\n",
+			pwm->label, ret);
+		return ret;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(pwm_config);
+
+int pwm_enable(struct pwm_device *pwm)
+{
+	u8 val;
+	int ret;
+
+	ret = twl_i2c_read_u8(TWL6030_MODULE_ID1, &val, LED_PWM_CTRL2);
+	if (ret < 0) {
+		pr_err("%s: Failed to enable PWM, Error %d\n", pwm->label, ret);
+		return ret;
+	}
+
+	/* Change mode to software control */
+	val &= ~PWM_CTRL2_MODE_MASK;
+	val |= PWM_CTRL2_MODE_SW;
+
+	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, val, LED_PWM_CTRL2);
+	if (ret < 0) {
+		pr_err("%s: Failed to enable PWM, Error %d\n", pwm->label, ret);
+		return ret;
+	}
+
+	twl_i2c_read_u8(TWL6030_MODULE_ID1, &val, LED_PWM_CTRL2);
+	return 0;
+}
+EXPORT_SYMBOL(pwm_enable);
+
+void pwm_disable(struct pwm_device *pwm)
+{
+	u8 val;
+	int ret;
+
+	ret = twl_i2c_read_u8(TWL6030_MODULE_ID1, &val, LED_PWM_CTRL2);
+	if (ret < 0) {
+		pr_err("%s: Failed to disable PWM, Error %d\n",
+			pwm->label, ret);
+		return;
+	}
+
+	val &= ~PWM_CTRL2_MODE_MASK;
+	val |= PWM_CTRL2_MODE_HW;
+
+	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, val, LED_PWM_CTRL2);
+	if (ret < 0) {
+		pr_err("%s: Failed to disable PWM, Error %d\n",
+			pwm->label, ret);
+		return;
+	}
+	return;
+}
+EXPORT_SYMBOL(pwm_disable);
+
+struct pwm_device *pwm_request(int pwm_id, const char *label)
+{
+	u8 val;
+	int ret;
+	struct pwm_device *pwm;
+
+	pwm = kzalloc(sizeof(struct pwm_device), GFP_KERNEL);
+	if (pwm == NULL) {
+		pr_err("%s: failed to allocate memory\n", label);
+		return NULL;
+	}
+
+	pwm->label = label;
+	pwm->pwm_id = pwm_id;
+
+	/* Configure PWM */
+	val = PWM_CTRL2_DIS_PD | PWM_CTRL2_CURR_02 | PWM_CTRL2_SRC_VAC |
+		PWM_CTRL2_MODE_HW;
+
+	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, val, LED_PWM_CTRL2);
+
+	if (ret < 0) {
+		pr_err("%s: Failed to configure PWM, Error %d\n",
+			 pwm->label, ret);
+
+		kfree(pwm);
+		return NULL;
+	}
+
+	return pwm;
+}
+EXPORT_SYMBOL(pwm_request);
+
+void pwm_free(struct pwm_device *pwm)
+{
+	pwm_disable(pwm);
+	kfree(pwm);
+}
+EXPORT_SYMBOL(pwm_free);
-- 
1.5.6.3



