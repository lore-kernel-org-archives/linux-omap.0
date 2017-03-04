From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 05/12] gpio: ml-ioh: use resource management for irqs
Date: Sat,  4 Mar 2017 17:23:33 +0100
Message-ID: <1488644620-11488-6-git-send-email-bgolaszewski@baylibre.com>
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
 drivers/gpio/gpio-ml-ioh.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/gpio/gpio-ml-ioh.c b/drivers/gpio/gpio-ml-ioh.c
index 796a5a4..78896a8 100644
--- a/drivers/gpio/gpio-ml-ioh.c
+++ b/drivers/gpio/gpio-ml-ioh.c
@@ -459,41 +459,31 @@ static int ioh_gpio_probe(struct pci_dev *pdev,
 
 	chip = chip_save;
 	for (j = 0; j < 8; j++, chip++) {
-		irq_base = irq_alloc_descs(-1, IOH_IRQ_BASE, num_ports[j],
-					   NUMA_NO_NODE);
+		irq_base = devm_irq_alloc_descs(&pdev->dev, -1, IOH_IRQ_BASE,
+						num_ports[j], NUMA_NO_NODE);
 		if (irq_base < 0) {
 			dev_warn(&pdev->dev,
 				"ml_ioh_gpio: Failed to get IRQ base num\n");
-			chip->irq_base = -1;
 			ret = irq_base;
-			goto err_irq_alloc_descs;
+			goto err_gpiochip_add;
 		}
 		chip->irq_base = irq_base;
 		ioh_gpio_alloc_generic_chip(chip, irq_base, num_ports[j]);
 	}
 
 	chip = chip_save;
-	ret = request_irq(pdev->irq, ioh_gpio_handler,
-			     IRQF_SHARED, KBUILD_MODNAME, chip);
+	ret = devm_request_irq(&pdev->dev, pdev->irq, ioh_gpio_handler,
+			       IRQF_SHARED, KBUILD_MODNAME, chip);
 	if (ret != 0) {
 		dev_err(&pdev->dev,
 			"%s request_irq failed\n", __func__);
-		goto err_request_irq;
+		goto err_gpiochip_add;
 	}
 
 	pci_set_drvdata(pdev, chip);
 
 	return 0;
 
-err_request_irq:
-	chip = chip_save;
-err_irq_alloc_descs:
-	while (--j >= 0) {
-		chip--;
-		irq_free_descs(chip->irq_base, num_ports[j]);
-	}
-
-	chip = chip_save;
 err_gpiochip_add:
 	while (--i >= 0) {
 		chip--;
@@ -524,12 +514,8 @@ static void ioh_gpio_remove(struct pci_dev *pdev)
 
 	chip_save = chip;
 
-	free_irq(pdev->irq, chip);
-
-	for (i = 0; i < 8; i++, chip++) {
-		irq_free_descs(chip->irq_base, num_ports[i]);
+	for (i = 0; i < 8; i++, chip++)
 		gpiochip_remove(&chip->gpio);
-	}
 
 	chip = chip_save;
 	pci_iounmap(pdev, chip->base);
-- 
2.9.3
