From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/4] Calculate max VIBDAT code based on VDDVIB, motor and driver resistances
Date: Tue, 2 Aug 2011 14:28:45 +0300
Message-ID: <1312284526-1656-5-git-send-email-peter.ujfalusi@ti.com>
References: <1312284526-1656-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36559 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753955Ab1HBL3I (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Aug 2011 07:29:08 -0400
In-Reply-To: <1312284526-1656-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>, Benoit Cousson <b-cousson@ti.com>, Sebastien Guiriec <s-guiriec@ti.com>

From: Misael Lopez Cruz <misael.lopez@ti.com>

Squash with "input: Add initial support for TWL6040 vibrator".
---
 drivers/input/misc/twl6040-vibra.c |  165 ++++++++++++++++++++++++++++++++----
 include/linux/i2c/twl.h            |    7 ++
 2 files changed, 154 insertions(+), 18 deletions(-)

diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
index 2612019..2f77913 100644
--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -32,20 +32,33 @@
 #include <linux/mfd/twl6040-codec.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/regulator/consumer.h>
 
 #define EFFECT_DIR_180_DEG	0x8000
 
+/* Recommended modulation index 85% */
+#define TWL6040_VIBRA_MOD	85
+
 struct vibra_info {
 	struct device *dev;
 	struct input_dev *input_dev;
 	struct workqueue_struct *workqueue;
 	struct work_struct play_work;
+	struct mutex mutex;
 
 	bool enabled;
-	int speed;
+	int weak_speed;
+	int strong_speed;
 	int direction;
 
+	unsigned int vibldrv_res;
+	unsigned int vibrdrv_res;
+	unsigned int viblmotor_res;
+	unsigned int vibrmotor_res;
+
 	struct twl6040 *twl6040;
+	struct regulator *vddvibl_reg;
+	struct regulator *vddvibr_reg;
 };
 
 static irqreturn_t twl6040_vib_irq_handler(int irq, void *data)
@@ -72,6 +85,21 @@ static irqreturn_t twl6040_vib_irq_handler(int irq, void *data)
 static void twl6040_vibra_enable(struct vibra_info *info)
 {
 	struct twl6040 *twl6040 = info->twl6040;
+	int ret = 0;
+
+	ret = regulator_enable(info->vddvibl_reg);
+	if (ret) {
+		dev_err(info->dev, "failed to enable VDDVIBL %d\n",
+			ret);
+		return;
+	}
+
+	ret = regulator_enable(info->vddvibr_reg);
+	if (ret) {
+		dev_err(info->dev, "failed to enable VDDVIBR %d\n",
+			ret);
+		goto err;
+	}
 
 	if (twl6040_get_rev(twl6040) <= TWL6040_REV_ES1_1) {
 		/*
@@ -92,6 +120,10 @@ static void twl6040_vibra_enable(struct vibra_info *info)
 			  TWL6040_VIBENAR);
 
 	info->enabled = true;
+	return;
+
+err:
+	regulator_disable(info->vddvibl_reg);
 }
 
 static void twl6040_vibra_disable(struct vibra_info *info)
@@ -101,19 +133,56 @@ static void twl6040_vibra_disable(struct vibra_info *info)
 	twl6040_reg_write(twl6040, TWL6040_REG_VIBCTLL, 0x00);
 	twl6040_reg_write(twl6040, TWL6040_REG_VIBCTLR, 0x00);
 
+	regulator_disable(info->vddvibl_reg);
+	regulator_disable(info->vddvibr_reg);
+
 	info->enabled = false;
 }
 
-static void twl6040_vibra_set_effect(struct vibra_info *info)
+static u8 twl6040_vibra_code(int vddvib, int vibdrv_res, int motor_res,
+			     int speed, int direction)
 {
-	struct twl6040 *twl6040 = info->twl6040;
-	u8 vibdat = (u8)(info->speed);
+	int vpk, max_code;
+	u8 vibdat;
+
+	/* output swing */
+	vpk = (vddvib * motor_res * TWL6040_VIBRA_MOD) /
+		(100 * (vibdrv_res + motor_res));
+
+	/* 50mV per VIBDAT code step */
+	max_code = vpk / 50;
+	if (max_code > TWL6040_VIBDAT_MAX)
+		max_code = TWL6040_VIBDAT_MAX;
+
+	/* scale speed to max allowed code */
+	vibdat = (u8)((speed * max_code) / USHRT_MAX);
 
 	/* 2's complement for direction > 180 degrees */
-	vibdat *= info->direction;
+	vibdat *= direction;
 
-	twl6040_reg_write(twl6040, TWL6040_REG_VIBDATL, vibdat);
-	twl6040_reg_write(twl6040, TWL6040_REG_VIBDATR, vibdat);
+	return vibdat;
+}
+
+static void twl6040_vibra_set_effect(struct vibra_info *info)
+{
+	struct twl6040 *twl6040 = info->twl6040;
+	u8 vibdatl, vibdatr;
+	int volt;
+
+	/* weak motor */
+	volt = regulator_get_voltage(info->vddvibl_reg) / 1000;
+	vibdatl = twl6040_vibra_code(volt, info->vibldrv_res,
+				     info->viblmotor_res,
+				     info->weak_speed, info->direction);
+
+	/* strong motor */
+	volt = regulator_get_voltage(info->vddvibr_reg) / 1000;
+	vibdatr = twl6040_vibra_code(volt, info->vibrdrv_res,
+				     info->vibrmotor_res,
+				     info->strong_speed, info->direction);
+
+	twl6040_reg_write(twl6040, TWL6040_REG_VIBDATL, vibdatl);
+	twl6040_reg_write(twl6040, TWL6040_REG_VIBDATR, vibdatr);
 }
 
 static void vibra_play_work(struct work_struct *work)
@@ -121,10 +190,14 @@ static void vibra_play_work(struct work_struct *work)
 	struct vibra_info *info = container_of(work,
 				struct vibra_info, play_work);
 
+	mutex_lock(&info->mutex);
+
 	if (!info->enabled)
 		twl6040_vibra_enable(info);
 
 	twl6040_vibra_set_effect(info);
+
+	mutex_unlock(&info->mutex);
 }
 
 static int vibra_play(struct input_dev *input, void *data,
@@ -133,12 +206,8 @@ static int vibra_play(struct input_dev *input, void *data,
 	struct vibra_info *info = input_get_drvdata(input);
 	int ret;
 
-	info->speed = effect->u.rumble.strong_magnitude;
-	if (!info->speed)
-		info->speed = effect->u.rumble.weak_magnitude >> 1;
-
-	/* scale to VIBDAT allowed limits */
-	info->speed = (info->speed * TWL6040_VIBDAT_MAX) / USHRT_MAX;
+	info->weak_speed = effect->u.rumble.weak_magnitude;
+	info->strong_speed = effect->u.rumble.strong_magnitude;
 	info->direction = effect->direction < EFFECT_DIR_180_DEG ? 1 : -1;
 
 	ret = queue_work(info->workqueue, &info->play_work);
@@ -173,11 +242,17 @@ static void twl6040_vibra_close(struct input_dev *input)
 	info->workqueue = NULL;
 
 	info->direction = 0;
-	info->speed = 0;
+	info->weak_speed = 0;
+	info->strong_speed = 0;
+
+	mutex_lock(&info->mutex);
+
 	twl6040_vibra_set_effect(info);
 
 	if (info->enabled)
 		twl6040_vibra_disable(info);
+
+	mutex_unlock(&info->mutex);
 }
 
 #if CONFIG_PM
@@ -224,11 +299,23 @@ static int __devinit twl6040_vibra_probe(struct platform_device *pdev)
 
 	info->dev = &pdev->dev;
 	info->twl6040 = dev_get_drvdata(pdev->dev.parent);
+	info->vibldrv_res = pdata->vibldrv_res;
+	info->vibrdrv_res = pdata->vibrdrv_res;
+	info->viblmotor_res = pdata->viblmotor_res;
+	info->vibrmotor_res = pdata->vibrmotor_res;
+	if ((!info->vibldrv_res && !info->viblmotor_res) ||
+	    (!info->vibrdrv_res && !info->vibrmotor_res)) {
+		dev_err(info->dev, "invalid vibra driver/motor resistance\n");
+		ret = -EINVAL;
+		goto err_kzalloc;
+	}
+
+	mutex_init(&info->mutex);
 	INIT_WORK(&info->play_work, vibra_play_work);
 
 	info->input_dev = input_allocate_device();
 	if (info->input_dev == NULL) {
-		dev_err(&pdev->dev, "couldn't allocate input device\n");
+		dev_err(info->dev, "couldn't allocate input device\n");
 		ret = -ENOMEM;
 		goto err_kzalloc;
 	}
@@ -244,13 +331,13 @@ static int __devinit twl6040_vibra_probe(struct platform_device *pdev)
 
 	ret = input_ff_create_memless(info->input_dev, NULL, vibra_play);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "couldn't register vibrator to FF\n");
+		dev_err(info->dev, "couldn't register vibrator to FF\n");
 		goto err_ialloc;
 	}
 
 	ret = input_register_device(info->input_dev);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "couldn't register input device\n");
+		dev_err(info->dev, "couldn't register input device\n");
 		goto err_iff;
 	}
 
@@ -260,10 +347,46 @@ static int __devinit twl6040_vibra_probe(struct platform_device *pdev)
 				  twl6040_vib_irq_handler, 0,
 				  "twl6040_irq_vib", info);
 	if (ret) {
-		dev_err(&pdev->dev, "VIB IRQ request failed: %d\n", ret);
+		dev_err(info->dev, "VIB IRQ request failed: %d\n", ret);
 		goto err_irq;
 	}
 
+	info->vddvibl_reg = regulator_get(info->dev, "vddvibl");
+	if (IS_ERR(info->vddvibl_reg)) {
+		ret = PTR_ERR(info->vddvibl_reg);
+		dev_err(info->dev, "couldn't get VDDVIBL regulator %d\n", ret);
+		goto err_vddvibl;
+	}
+
+	if (pdata->vddvibl_uV) {
+		ret = regulator_set_voltage(info->vddvibl_reg,
+					    pdata->vddvibl_uV,
+					    pdata->vddvibl_uV);
+		if (ret) {
+			dev_err(info->dev, "failed to set VDDVIBL volt %d\n",
+				ret);
+			goto err_vddvibr;
+		}
+	}
+
+	info->vddvibr_reg = regulator_get(info->dev, "vddvibr");
+	if (IS_ERR(info->vddvibr_reg)) {
+		ret = PTR_ERR(info->vddvibr_reg);
+		dev_err(info->dev, "couldn't get VDDVIBR regulator %d\n", ret);
+		goto err_vddvibr;
+	}
+
+	if (pdata->vddvibr_uV) {
+		ret = regulator_set_voltage(info->vddvibr_reg,
+					    pdata->vddvibr_uV,
+					    pdata->vddvibr_uV);
+		if (ret) {
+			dev_err(info->dev, "failed to set VDDVIBR volt %d\n",
+				ret);
+			goto err_pwr;
+		}
+	}
+
 	ret = twl6040_power(info->twl6040, 1);
 	if (ret < 0)
 		goto err_pwr;
@@ -271,6 +394,10 @@ static int __devinit twl6040_vibra_probe(struct platform_device *pdev)
 	return 0;
 
 err_pwr:
+	regulator_put(info->vddvibr_reg);
+err_vddvibr:
+	regulator_put(info->vddvibl_reg);
+err_vddvibl:
 	twl6040_free_irq(info->twl6040, TWL6040_IRQ_VIB, info);
 err_irq:
 	input_unregister_device(info->input_dev);
@@ -290,6 +417,8 @@ static int __devexit twl6040_vibra_remove(struct platform_device *pdev)
 	struct vibra_info *info = platform_get_drvdata(pdev);
 
 	twl6040_power(info->twl6040, 0);
+	regulator_put(info->vddvibl_reg);
+	regulator_put(info->vddvibr_reg);
 	twl6040_free_irq(info->twl6040, TWL6040_IRQ_VIB, info);
 	input_unregister_device(info->input_dev);
 	kfree(info);
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 9d70719..5b4e732 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -669,6 +669,13 @@ struct twl4030_codec_audio_data {
 
 struct twl4030_codec_vibra_data {
 	unsigned int	coexist;
+
+	unsigned int vibldrv_res;	/* left driver resistance */
+	unsigned int vibrdrv_res;	/* right driver resistance */
+	unsigned int viblmotor_res;	/* left motor resistance */
+	unsigned int vibrmotor_res;	/* right motor resistance */
+	int vddvibl_uV;			/* VDDVIBL volt, set 0 for fixed reg */
+	int vddvibr_uV;			/* VDDVIBR volt, set 0 for fixed reg */
 };
 
 struct twl4030_codec_data {
-- 
1.7.5.rc3

