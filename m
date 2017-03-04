From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 01/12] gpio: mockup: use devm_irq_alloc_descs()
Date: Sat,  4 Mar 2017 17:23:29 +0100
Message-ID: <1488644620-11488-2-git-send-email-bgolaszewski@baylibre.com>
References: <1488644620-11488-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1488644620-11488-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

Use the resource managed variant of irq_alloc_descs(). This allows us
to remove gpio_mockup_remove().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 06dac72..37c2d69 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -169,7 +169,7 @@ static int gpio_mockup_irqchip_setup(struct device *dev,
 	struct gpio_chip *gc = &chip->gc;
 	int irq_base, i;
 
-	irq_base = irq_alloc_descs(-1, 0, gc->ngpio, 0);
+	irq_base = devm_irq_alloc_descs(dev, -1, 0, gc->ngpio, 0);
 	if (irq_base < 0)
 		return irq_base;
 
@@ -373,25 +373,11 @@ static int gpio_mockup_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int gpio_mockup_remove(struct platform_device *pdev)
-{
-	struct gpio_mockup_chip *chips;
-	int i;
-
-	chips = platform_get_drvdata(pdev);
-
-	for (i = 0; i < gpio_mockup_params_nr >> 1; i++)
-		irq_free_descs(chips[i].gc.irq_base, chips[i].gc.ngpio);
-
-	return 0;
-}
-
 static struct platform_driver gpio_mockup_driver = {
 	.driver = {
 		.name = GPIO_MOCKUP_NAME,
 	},
 	.probe = gpio_mockup_probe,
-	.remove = gpio_mockup_remove,
 };
 
 static struct platform_device *pdev;
-- 
2.9.3
