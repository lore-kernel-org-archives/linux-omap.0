From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 11/12] gpio: mxs: use devm_irq_alloc_descs()
Date: Sat,  4 Mar 2017 17:23:39 +0100
Message-ID: <1488644620-11488-12-git-send-email-bgolaszewski@baylibre.com>
References: <1488644620-11488-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1488644620-11488-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

This driver never frees the interrupt descriptors it allocates. Fix
it by using the resource managed version of irq_alloc_descs().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mxs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index 2292742..6ae583f 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -328,7 +328,7 @@ static int mxs_gpio_probe(struct platform_device *pdev)
 	/* clear address has to be used to clear IRQSTAT bits */
 	writel(~0U, port->base + PINCTRL_IRQSTAT(port) + MXS_CLR);
 
-	irq_base = irq_alloc_descs(-1, 0, 32, numa_node_id());
+	irq_base = devm_irq_alloc_descs(&pdev->dev, -1, 0, 32, numa_node_id());
 	if (irq_base < 0) {
 		err = irq_base;
 		goto out_iounmap;
@@ -338,7 +338,7 @@ static int mxs_gpio_probe(struct platform_device *pdev)
 					     &irq_domain_simple_ops, NULL);
 	if (!port->domain) {
 		err = -ENODEV;
-		goto out_irqdesc_free;
+		goto out_iounmap;
 	}
 
 	/* gpio-mxs can be a generic irq chip */
@@ -370,8 +370,6 @@ static int mxs_gpio_probe(struct platform_device *pdev)
 
 out_irqdomain_remove:
 	irq_domain_remove(port->domain);
-out_irqdesc_free:
-	irq_free_descs(irq_base, 32);
 out_iounmap:
 	iounmap(port->base);
 	return err;
-- 
2.9.3
