From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 09/12] gpio: sodaville: use resource management for irqs
Date: Sat,  4 Mar 2017 17:23:37 +0100
Message-ID: <1488644620-11488-10-git-send-email-bgolaszewski@baylibre.com>
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
 drivers/gpio/gpio-sodaville.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpio-sodaville.c b/drivers/gpio/gpio-sodaville.c
index 7da9e6c..f60da83 100644
--- a/drivers/gpio/gpio-sodaville.c
+++ b/drivers/gpio/gpio-sodaville.c
@@ -135,7 +135,8 @@ static int sdv_register_irqsupport(struct sdv_gpio_chip_data *sd,
 	struct irq_chip_type *ct;
 	int ret;
 
-	sd->irq_base = irq_alloc_descs(-1, 0, SDV_NUM_PUB_GPIOS, -1);
+	sd->irq_base = devm_irq_alloc_descs(&pdev->dev, -1, 0,
+					    SDV_NUM_PUB_GPIOS, -1);
 	if (sd->irq_base < 0)
 		return sd->irq_base;
 
@@ -143,10 +144,11 @@ static int sdv_register_irqsupport(struct sdv_gpio_chip_data *sd,
 	writel(0, sd->gpio_pub_base + GPIO_INT);
 	writel((1 << 11) - 1, sd->gpio_pub_base + GPSTR);
 
-	ret = request_irq(pdev->irq, sdv_gpio_pub_irq_handler, IRQF_SHARED,
-			"sdv_gpio", sd);
+	ret = devm_request_irq(&pdev->dev, pdev->irq,
+			       sdv_gpio_pub_irq_handler, IRQF_SHARED,
+			       "sdv_gpio", sd);
 	if (ret)
-		goto out_free_desc;
+		return ret;
 
 	/*
 	 * This gpio irq controller latches level irqs. Testing shows that if
@@ -155,10 +157,8 @@ static int sdv_register_irqsupport(struct sdv_gpio_chip_data *sd,
 	 */
 	sd->gc = irq_alloc_generic_chip("sdv-gpio", 1, sd->irq_base,
 			sd->gpio_pub_base, handle_fasteoi_irq);
-	if (!sd->gc) {
-		ret = -ENOMEM;
-		goto out_free_irq;
-	}
+	if (!sd->gc)
+		return -ENOMEM;
 
 	sd->gc->private = sd;
 	ct = sd->gc->chip_types;
@@ -176,16 +176,10 @@ static int sdv_register_irqsupport(struct sdv_gpio_chip_data *sd,
 
 	sd->id = irq_domain_add_legacy(pdev->dev.of_node, SDV_NUM_PUB_GPIOS,
 				sd->irq_base, 0, &irq_domain_sdv_ops, sd);
-	if (!sd->id) {
-		ret = -ENODEV;
-		goto out_free_irq;
-	}
+	if (!sd->id)
+		return -ENODEV;
+
 	return 0;
-out_free_irq:
-	free_irq(pdev->irq, sd);
-out_free_desc:
-	irq_free_descs(sd->irq_base, SDV_NUM_PUB_GPIOS);
-	return ret;
 }
 
 static int sdv_gpio_probe(struct pci_dev *pdev,
-- 
2.9.3
