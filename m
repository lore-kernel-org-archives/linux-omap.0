From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 12/12] gpio: sta2x11: use resource management for irqs
Date: Sat,  4 Mar 2017 17:23:40 +0100
Message-ID: <1488644620-11488-13-git-send-email-bgolaszewski@baylibre.com>
References: <1488644620-11488-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1488644620-11488-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

Use device resource managed variants of irq_alloc_descs() and
request_irq() and remove the code manually freeing irq resources.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-sta2x11.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-sta2x11.c b/drivers/gpio/gpio-sta2x11.c
index 853ca23..39df062 100644
--- a/drivers/gpio/gpio-sta2x11.c
+++ b/drivers/gpio/gpio-sta2x11.c
@@ -392,7 +392,8 @@ static int gsta_probe(struct platform_device *dev)
 			gsta_set_config(chip, i, gpio_pdata->pinconfig[i]);
 
 	/* 384 was used in previous code: be compatible for other drivers */
-	err = irq_alloc_descs(-1, 384, GSTA_NR_GPIO, NUMA_NO_NODE);
+	err = devm_irq_alloc_descs(&dev->dev, -1, 384,
+				   GSTA_NR_GPIO, NUMA_NO_NODE);
 	if (err < 0) {
 		dev_warn(&dev->dev, "sta2x11 gpio: Can't get irq base (%i)\n",
 			 -err);
@@ -401,29 +402,23 @@ static int gsta_probe(struct platform_device *dev)
 	chip->irq_base = err;
 	gsta_alloc_irq_chip(chip);
 
-	err = request_irq(pdev->irq, gsta_gpio_handler,
-			     IRQF_SHARED, KBUILD_MODNAME, chip);
+	err = devm_request_irq(&dev->dev, pdev->irq, gsta_gpio_handler,
+			       IRQF_SHARED, KBUILD_MODNAME, chip);
 	if (err < 0) {
 		dev_err(&dev->dev, "sta2x11 gpio: Can't request irq (%i)\n",
 			-err);
-		goto err_free_descs;
+		return err;
 	}
 
 	err = devm_gpiochip_add_data(&dev->dev, &chip->gpio, chip);
 	if (err < 0) {
 		dev_err(&dev->dev, "sta2x11 gpio: Can't register (%i)\n",
 			-err);
-		goto err_free_irq;
+		return err;
 	}
 
 	platform_set_drvdata(dev, chip);
 	return 0;
-
-err_free_irq:
-	free_irq(pdev->irq, chip);
-err_free_descs:
-	irq_free_descs(chip->irq_base, GSTA_NR_GPIO);
-	return err;
 }
 
 static struct platform_driver sta2x11_gpio_platform_driver = {
-- 
2.9.3
