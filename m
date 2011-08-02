From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/4] Fixes for "input: Add initial support for TWL6040 vibrator"
Date: Tue, 2 Aug 2011 14:28:42 +0300
Message-ID: <1312284526-1656-2-git-send-email-peter.ujfalusi@ti.com>
References: <1312284526-1656-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53079 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753754Ab1HBL27 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Aug 2011 07:28:59 -0400
In-Reply-To: <1312284526-1656-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>, Benoit Cousson <b-cousson@ti.com>, Sebastien Guiriec <s-guiriec@ti.com>

From: Misael Lopez Cruz <misael.lopez@ti.com>

---
 drivers/input/misc/twl6040-vibra.c |   57 ++++++++++++++++-------------------
 1 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
index fb46bf4..2612019 100644
--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -52,23 +52,18 @@ static irqreturn_t twl6040_vib_irq_handler(int irq, void *data)
 {
 	struct vibra_info *info = data;
 	struct twl6040 *twl6040 = info->twl6040;
-	u8 intid = 0, status = 0;
-
-	intid = twl6040_reg_read(twl6040, TWL6040_REG_INTID);
-	if (intid & TWL6040_VIBINT) {
-		status = twl6040_reg_read(twl6040, TWL6040_REG_STATUS);
-		if (status & TWL6040_VIBLOCDET) {
-			dev_warn(info->dev,
-				 "Vibra left overcurrent detected\n");
-			twl6040_clear_bits(twl6040, TWL6040_REG_VIBCTLL,
-					   TWL6040_VIBENAL);
-		}
-		if (status & TWL6040_VIBROCDET) {
-			dev_warn(info->dev,
-				 "Vibra right overcurrent detected\n");
-			twl6040_clear_bits(twl6040, TWL6040_REG_VIBCTLR,
-					   TWL6040_VIBENAR);
-		}
+	u8 status;
+
+	status = twl6040_reg_read(twl6040, TWL6040_REG_STATUS);
+	if (status & TWL6040_VIBLOCDET) {
+		dev_warn(info->dev, "Vibra left overcurrent detected\n");
+		twl6040_clear_bits(twl6040, TWL6040_REG_VIBCTLL,
+				   TWL6040_VIBENAL);
+	}
+	if (status & TWL6040_VIBROCDET) {
+		dev_warn(info->dev, "Vibra right overcurrent detected\n");
+		twl6040_clear_bits(twl6040, TWL6040_REG_VIBCTLR,
+				   TWL6040_VIBENAR);
 	}
 
 	return IRQ_HANDLED;
@@ -78,16 +73,19 @@ static void twl6040_vibra_enable(struct vibra_info *info)
 {
 	struct twl6040 *twl6040 = info->twl6040;
 
-	/*
-	 * ERRATA: Disable overcurrent protection for at least
-	 * 2.5ms when enabling vibrator drivers to avoid false
-	 * overcurrent detection
-	 */
-	twl6040_reg_write(twl6040, TWL6040_REG_VIBCTLL,
-			  TWL6040_VIBENAL | TWL6040_VIBCTRLL);
-	twl6040_reg_write(twl6040, TWL6040_REG_VIBCTLR,
-			  TWL6040_VIBENAR | TWL6040_VIBCTRLR);
-	mdelay(3);
+	if (twl6040_get_rev(twl6040) <= TWL6040_REV_ES1_1) {
+		/*
+		 * ERRATA: Disable overcurrent protection for at least
+		 * 2.5ms when enabling vibrator drivers to avoid false
+		 * overcurrent detection
+		 */
+		twl6040_reg_write(twl6040, TWL6040_REG_VIBCTLL,
+				  TWL6040_VIBENAL | TWL6040_VIBCTRLL);
+		twl6040_reg_write(twl6040, TWL6040_REG_VIBCTLR,
+				  TWL6040_VIBENAR | TWL6040_VIBCTRLR);
+		mdelay(3);
+	}
+
 	twl6040_reg_write(twl6040, TWL6040_REG_VIBCTLL,
 			  TWL6040_VIBENAL);
 	twl6040_reg_write(twl6040, TWL6040_REG_VIBCTLR,
@@ -145,7 +143,7 @@ static int vibra_play(struct input_dev *input, void *data,
 
 	ret = queue_work(info->workqueue, &info->play_work);
 	if (!ret) {
-		dev_err(&input->dev, "work is already on queue\n");
+		dev_info(&input->dev, "work is already on queue\n");
 		return ret;
 	}
 
@@ -266,12 +264,10 @@ static int __devinit twl6040_vibra_probe(struct platform_device *pdev)
 		goto err_irq;
 	}
 
-	printk(KERN_ERR "%s:powering twl6040\n", __func__);
 	ret = twl6040_power(info->twl6040, 1);
 	if (ret < 0)
 		goto err_pwr;
 
-	printk(KERN_ERR "%s:powered\n", __func__);
 	return 0;
 
 err_pwr:
@@ -297,7 +293,6 @@ static int __devexit twl6040_vibra_remove(struct platform_device *pdev)
 	twl6040_free_irq(info->twl6040, TWL6040_IRQ_VIB, info);
 	input_unregister_device(info->input_dev);
 	kfree(info);
-	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
-- 
1.7.5.rc3

