From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 06/12] gpio: xlp: use resource management for irqs
Date: Sat,  4 Mar 2017 17:23:34 +0100
Message-ID: <1488644620-11488-7-git-send-email-bgolaszewski@baylibre.com>
References: <1488644620-11488-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1488644620-11488-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

Use the resource managed variant of irq_alloc_descs() and remove the
code manually freeing allocated interrupt descriptors.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-xlp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-xlp.c b/drivers/gpio/gpio-xlp.c
index 4620d05..7cc82cf 100644
--- a/drivers/gpio/gpio-xlp.c
+++ b/drivers/gpio/gpio-xlp.c
@@ -404,7 +404,9 @@ static int xlp_gpio_probe(struct platform_device *pdev)
 
 	/* XLP(MIPS) has fixed range for GPIO IRQs, Vulcan(ARM64) does not */
 	if (soc_type != GPIO_VARIANT_VULCAN) {
-		irq_base = irq_alloc_descs(-1, XLP_GPIO_IRQ_BASE, gc->ngpio, 0);
+		irq_base = devm_irq_alloc_descs(&pdev->dev, -1,
+						XLP_GPIO_IRQ_BASE,
+						gc->ngpio, 0);
 		if (irq_base < 0) {
 			dev_err(&pdev->dev, "Failed to allocate IRQ numbers\n");
 			return irq_base;
@@ -415,7 +417,7 @@ static int xlp_gpio_probe(struct platform_device *pdev)
 
 	err = gpiochip_add_data(gc, priv);
 	if (err < 0)
-		goto out_free_desc;
+		return err;
 
 	err = gpiochip_irqchip_add(gc, &xlp_gpio_irq_chip, irq_base,
 				handle_level_irq, IRQ_TYPE_NONE);
@@ -433,8 +435,6 @@ static int xlp_gpio_probe(struct platform_device *pdev)
 
 out_gpio_remove:
 	gpiochip_remove(gc);
-out_free_desc:
-	irq_free_descs(irq_base, gc->ngpio);
 	return err;
 }
 
-- 
2.9.3

