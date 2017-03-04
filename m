From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 04/12] gpio: pch: use resource management for irqs
Date: Sat,  4 Mar 2017 17:23:32 +0100
Message-ID: <1488644620-11488-5-git-send-email-bgolaszewski@baylibre.com>
References: <1488644620-11488-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1488644620-11488-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

Use device resource managed variants of irq_alloc_descs() and
request_irq() and remove the code manually freeing irq resources.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-pch.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-pch.c b/drivers/gpio/gpio-pch.c
index 7c7135d..71bc6da 100644
--- a/drivers/gpio/gpio-pch.c
+++ b/drivers/gpio/gpio-pch.c
@@ -403,7 +403,8 @@ static int pch_gpio_probe(struct pci_dev *pdev,
 		goto err_gpiochip_add;
 	}
 
-	irq_base = irq_alloc_descs(-1, 0, gpio_pins[chip->ioh], NUMA_NO_NODE);
+	irq_base = devm_irq_alloc_descs(&pdev->dev, -1, 0,
+					gpio_pins[chip->ioh], NUMA_NO_NODE);
 	if (irq_base < 0) {
 		dev_warn(&pdev->dev, "PCH gpio: Failed to get IRQ base num\n");
 		chip->irq_base = -1;
@@ -416,8 +417,8 @@ static int pch_gpio_probe(struct pci_dev *pdev,
 	iowrite32(msk, &chip->reg->imask);
 	iowrite32(msk, &chip->reg->ien);
 
-	ret = request_irq(pdev->irq, pch_gpio_handler,
-			  IRQF_SHARED, KBUILD_MODNAME, chip);
+	ret = devm_request_irq(&pdev->dev, pdev->irq, pch_gpio_handler,
+			       IRQF_SHARED, KBUILD_MODNAME, chip);
 	if (ret != 0) {
 		dev_err(&pdev->dev,
 			"%s request_irq failed\n", __func__);
@@ -430,7 +431,6 @@ static int pch_gpio_probe(struct pci_dev *pdev,
 	return 0;
 
 err_request_irq:
-	irq_free_descs(irq_base, gpio_pins[chip->ioh]);
 	gpiochip_remove(&chip->gpio);
 
 err_gpiochip_add:
@@ -452,12 +452,6 @@ static void pch_gpio_remove(struct pci_dev *pdev)
 {
 	struct pch_gpio *chip = pci_get_drvdata(pdev);
 
-	if (chip->irq_base != -1) {
-		free_irq(pdev->irq, chip);
-
-		irq_free_descs(chip->irq_base, gpio_pins[chip->ioh]);
-	}
-
 	gpiochip_remove(&chip->gpio);
 	pci_iounmap(pdev, chip->base);
 	pci_release_regions(pdev);
-- 
2.9.3

