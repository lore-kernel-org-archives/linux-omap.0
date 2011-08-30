From: Hemanth V <hemanthv@ti.com>
Subject: [PATCH] mfd: Add PWM1 and PWM2 support to twl6030-pwm
Date: Tue, 30 Aug 2011 12:27:17 +0530
Message-ID: <51632.192.168.10.10.1314687437.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60881 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842Ab1H3G5T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Aug 2011 02:57:19 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, sameo@linux.intel.com

From: Hemanth V <hemanthv@ti.com>
Date: Fri, 26 Aug 2011 10:49:29 +0530
Subject: [PATCH] Add PWM1 and PWM2 support to twl6030-pwm driver

This patch adds support for PWM1/PWM2. TWL6030 PWM driver also
supports Indicator LED PWM. Function pointers are defined for
for init, enable, disable and configuration for both Indicator LED
PWM (led_pwm) and PWM1/PWM2 (std_pwm)

Tested-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Hemanth V <hemanthv@ti.com>
---
 drivers/mfd/twl6030-pwm.c |  324 ++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 309 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/twl6030-pwm.c b/drivers/mfd/twl6030-pwm.c
index e8fee14..8d9c3f5 100644
--- a/drivers/mfd/twl6030-pwm.c
+++ b/drivers/mfd/twl6030-pwm.c
@@ -5,6 +5,9 @@
  * Copyright (C) 2010 Texas Instruments
  * Author: Hemanth V <hemanthv@ti.com>
  *
+ * Added support for PWM1, PWM2
+ * Hemanth V <hemanthv@ti.com>
+ *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License version 2 as published by
  * the Free Software Foundation.
@@ -36,7 +39,9 @@
 #define PWM_CTRL2_CURR_02	(2 << 4)

 /* LED supply source */
+#define PWM_CTRL2_SRC_VBUS	(0 << 2)
 #define PWM_CTRL2_SRC_VAC	(1 << 2)
+#define PWM_CTRL2_SRC_EXT	(2 << 2)

 /* LED modes */
 #define PWM_CTRL2_MODE_HW	(0 << 0)
@@ -45,12 +50,53 @@

 #define PWM_CTRL2_MODE_MASK	0x3

+/* PWMs supported by driver */
+#define PWM_ID_LED		1
+#define PWM_ID_PWM1		2
+#define PWM_ID_PWM2		3
+
+#define LED_PWM1ON		0x00
+#define LED_PWM1OFF		0x01
+#define LED_PWM2ON		0x03
+#define LED_PWM2OFF		0x04
+#define TWL6030_TOGGLE3		0x92
+#define PWMSTATUS2		0x94
+
+/* Defines for TOGGLE3 register */
+#define PWM2EN			(1 << 5)
+#define PWM2S			(1 << 4)
+#define PWM2R			(1 << 3)
+#define PWM1EN			(1 << 2)
+#define PWM1S			(1 << 1)
+#define PWM1R			(1 << 0)
+
+/* Defines for PWMSTATUS2 register */
+#define PWM1_CLK_EN		(1 << 1)
+#define PWM2_CLK_EN		(1 << 3)
+#define	TRUE			1
+#define	FALSE			0
+
+static DEFINE_MUTEX(pwm_lock);
+static LIST_HEAD(pwm_list);
+
+struct pwm_device;
+
+struct pwm_ops {
+	int	(*config)(struct pwm_device *, int, int);
+	int	(*enable)(struct pwm_device *);
+	void	(*disable)(struct pwm_device *);
+	int	(*init)(struct pwm_device *);
+};
+
 struct pwm_device {
-	const char *label;
-	unsigned int pwm_id;
+	struct list_head	node;
+	const char		*label;
+	unsigned int		pwm_id;
+	unsigned int		use_count;
+	struct pwm_ops		*ops;
 };

-int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
+int led_pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 {
 	u8 duty_cycle;
 	int ret;
@@ -69,9 +115,8 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 	}
 	return 0;
 }
-EXPORT_SYMBOL(pwm_config);

-int pwm_enable(struct pwm_device *pwm)
+int led_pwm_enable(struct pwm_device *pwm)
 {
 	u8 val;
 	int ret;
@@ -95,9 +140,8 @@ int pwm_enable(struct pwm_device *pwm)
 	twl_i2c_read_u8(TWL6030_MODULE_ID1, &val, LED_PWM_CTRL2);
 	return 0;
 }
-EXPORT_SYMBOL(pwm_enable);

-void pwm_disable(struct pwm_device *pwm)
+void led_pwm_disable(struct pwm_device *pwm)
 {
 	u8 val;
 	int ret;
@@ -120,37 +164,284 @@ void pwm_disable(struct pwm_device *pwm)
 	}
 	return;
 }
-EXPORT_SYMBOL(pwm_disable);

-struct pwm_device *pwm_request(int pwm_id, const char *label)
+int led_pwm_init(struct pwm_device *pwm)
 {
 	u8 val;
 	int ret;
+
+	val = PWM_CTRL2_DIS_PD | PWM_CTRL2_CURR_02 | PWM_CTRL2_SRC_VBUS |
+		PWM_CTRL2_MODE_HW;
+
+	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, val, LED_PWM_CTRL2);
+
+	return ret;
+}
+
+static struct pwm_ops pwm_led = {
+	.config = led_pwm_config,
+	.enable = led_pwm_enable,
+	.disable = led_pwm_disable,
+	.init = led_pwm_init,
+};
+
+int std_pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
+{
+	int ret = 0, level, pwm_id, reg;
+
+	level = (duty_ns * PWM_CTRL1_MAX) / period_ns;
+	pwm_id = pwm->pwm_id;
+
+	if (pwm_id == PWM_ID_PWM1)
+		reg = LED_PWM1ON;
+	else
+		reg = LED_PWM2ON;
+
+	if (level > 1) {
+		if (level == 255)
+			level = 0x7F;
+		else
+			level = (~(level/2)) & 0x7F;
+
+		ret = twl_i2c_write_u8(TWL_MODULE_PWM, level, reg);
+	}
+
+	return ret;
+}
+
+void std_pwm_disable(struct pwm_device *pwm)
+{
+
+	int ret, pwm_id;
+	bool pwm1_enabled = FALSE;
+	bool pwm2_enabled = FALSE;
+	u8 reg_val, reset_val, dis_val = 0;
+
+	pwm_id = pwm->pwm_id;
+
+	ret = twl_i2c_read_u8(TWL6030_MODULE_ID1, &reg_val, PWMSTATUS2);
+	if (ret < 0)
+		goto out_err;
+
+	if (reg_val & PWM1_CLK_EN)
+		pwm1_enabled = TRUE;
+	if (reg_val & PWM2_CLK_EN)
+		pwm2_enabled = TRUE;
+
+	if (pwm_id == PWM_ID_PWM1) {
+		reset_val = PWM1EN | PWM1R;
+
+		/* Donot reset the state for PWM2 */
+		if (pwm2_enabled) {
+			dis_val |= PWM2EN | PWM2S;
+			reset_val |= PWM2EN | PWM2S;
+		}
+
+	} else if (pwm_id == PWM_ID_PWM2) {
+		reset_val = PWM2EN | PWM2R ;
+
+		/* Donot reset the state for PWM1 */
+		if (pwm1_enabled) {
+			dis_val |= PWM1EN | PWM1S;
+			reset_val |= PWM1EN | PWM1S;
+		}
+	} else {
+		ret = -EINVAL;
+		goto out_err;
+	}
+
+	/* Reset PWM to be disabled */
+	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, reset_val, TWL6030_TOGGLE3);
+	if (ret < 0)
+		goto out_err;
+
+	/* Disable PWM */
+	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, dis_val, TWL6030_TOGGLE3);
+	if (ret < 0)
+		goto out_err;
+
+	return;
+
+out_err:
+	pr_err("%s: Failed to Enable PWM, Error %d\n",
+		pwm->label, ret);
+	return;
+}
+
+int std_pwm_enable(struct pwm_device *pwm)
+{
+
+	int ret, pwm_id;
+	u8 en_val, reg_val;
+	bool pwm1_enabled = FALSE;
+	bool pwm2_enabled = FALSE;
+
+	pwm_id = pwm->pwm_id;
+
+	ret = twl_i2c_read_u8(TWL6030_MODULE_ID1, &reg_val, PWMSTATUS2);
+	if (ret < 0)
+		goto out_err;
+
+	if (reg_val & PWM1_CLK_EN)
+		pwm1_enabled = TRUE;
+	if (reg_val & PWM2_CLK_EN)
+		pwm2_enabled = TRUE;
+
+	if (pwm_id == PWM_ID_PWM1) {
+		en_val = PWM1EN | PWM1S;
+
+		/* Maintain PWM2 state as-is*/
+		if (pwm2_enabled)
+			en_val |= PWM2EN | PWM2S;
+
+	} else if (pwm_id == PWM_ID_PWM2) {
+		en_val = PWM2EN | PWM2S;
+
+		/* Maintain PWM1 state as-is*/
+		if (pwm1_enabled)
+			en_val |= PWM1EN | PWM1S;
+	} else {
+		ret = -EINVAL;
+		goto out_err;
+	}
+
+	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, en_val, TWL6030_TOGGLE3);
+	if (ret < 0)
+		goto out_err;
+
+	return ret;
+
+out_err:
+	pr_err("%s: Failed to Enable PWM, Error %d\n",
+		pwm->label, ret);
+	return ret;
+}
+
+int std_pwm_init(struct pwm_device *pwm)
+{
+	int ret, reg1, reg2, pwm_id;
+
+	pwm_id = pwm->pwm_id;
+
+	if (pwm_id == PWM_ID_PWM1) {
+		reg1 = LED_PWM1ON;
+		reg2 = LED_PWM1OFF;
+	} else if (pwm_id == PWM_ID_PWM2) {
+		reg1 = LED_PWM2ON;
+		reg2 = LED_PWM2OFF;
+	} else {
+		ret = -EINVAL;
+		goto out_err;
+	}
+
+	ret = twl_i2c_write_u8(TWL_MODULE_PWM, 0x7F, reg1);
+	if (ret < 0)
+		goto out_err;
+
+	twl_i2c_write_u8(TWL_MODULE_PWM, 0x7F, reg2);
+	if (ret < 0)
+		goto out_err;
+
+	twl_i2c_write_u8(TWL6030_MODULE_ID1, 0x0, TWL6030_TOGGLE3);
+	if (ret < 0)
+		goto out_err;
+
+	return ret;
+
+out_err:
+	pr_err("%s: PWM init failed, Error %d\n",
+		pwm->label, ret);
+
+	return ret;
+}
+static struct pwm_ops pwm_std = {
+	.config = std_pwm_config,
+	.enable = std_pwm_enable,
+	.disable = std_pwm_disable,
+	.init = std_pwm_init,
+};
+
+int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
+{
+	return pwm->ops->config(pwm, duty_ns, period_ns);
+}
+EXPORT_SYMBOL(pwm_config);
+
+int pwm_enable(struct pwm_device *pwm)
+{
+	return pwm->ops->enable(pwm);
+}
+EXPORT_SYMBOL(pwm_enable);
+
+void pwm_disable(struct pwm_device *pwm)
+{
+	pwm->ops->disable(pwm);
+}
+EXPORT_SYMBOL(pwm_disable);
+
+struct pwm_device *pwm_request(int pwm_id, const char *label)
+{
+	int ret, found = 0;
 	struct pwm_device *pwm;

+	mutex_lock(&pwm_lock);
+
+	list_for_each_entry(pwm, &pwm_list, node) {
+		if (pwm->pwm_id == pwm_id) {
+			found = 1;
+			break;
+		}
+	}
+
+	if (found) {
+		if (pwm->use_count == 0) {
+			pwm->use_count++;
+			pwm->label = label;
+		} else {
+			pwm = ERR_PTR(-EBUSY);
+		}
+
+		goto out;
+	}
+
+	mutex_unlock(&pwm_lock);
+
 	pwm = kzalloc(sizeof(struct pwm_device), GFP_KERNEL);
 	if (pwm == NULL) {
 		pr_err("%s: failed to allocate memory\n", label);
-		return NULL;
+		goto out;
 	}

 	pwm->label = label;
 	pwm->pwm_id = pwm_id;
+	pwm->use_count++;

-	/* Configure PWM */
-	val = PWM_CTRL2_DIS_PD | PWM_CTRL2_CURR_02 | PWM_CTRL2_SRC_VAC |
-		PWM_CTRL2_MODE_HW;
+	if (pwm_id == PWM_ID_LED) {
+		pwm->ops = &pwm_led;
+	} else if (pwm_id == PWM_ID_PWM1 || pwm_id == PWM_ID_PWM2) {
+		pwm->ops = &pwm_std;
+	} else {
+		kfree(pwm);
+		pwm = ERR_PTR(-EINVAL);
+		goto out;
+	}

-	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, val, LED_PWM_CTRL2);
+	ret = pwm->ops->init(pwm);

 	if (ret < 0) {
 		pr_err("%s: Failed to configure PWM, Error %d\n",
 			 pwm->label, ret);

 		kfree(pwm);
-		return NULL;
+		pwm = NULL;
+		goto out;
 	}

+	mutex_lock(&pwm_lock);
+	list_add_tail(&pwm->node, &pwm_list);
+	mutex_unlock(&pwm_lock);
+
+out:
 	return pwm;
 }
 EXPORT_SYMBOL(pwm_request);
@@ -158,6 +449,9 @@ EXPORT_SYMBOL(pwm_request);
 void pwm_free(struct pwm_device *pwm)
 {
 	pwm_disable(pwm);
+	mutex_lock(&pwm_lock);
+	list_del(&pwm->node);
+	mutex_unlock(&pwm_lock);
 	kfree(pwm);
 }
 EXPORT_SYMBOL(pwm_free);
-- 
1.7.1



