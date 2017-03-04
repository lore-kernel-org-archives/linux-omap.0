From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 02/12] gpio: twl4030: use devm_irq_alloc_descs()
Date: Sat,  4 Mar 2017 17:23:30 +0100
Message-ID: <1488644620-11488-3-git-send-email-bgolaszewski@baylibre.com>
References: <1488644620-11488-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1488644620-11488-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

This driver never frees the irq descriptors it allocates. Fix it by
using a resource managed variant of irq_alloc_descs().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-twl4030.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.c
index dfcfbba..24f388e 100644
--- a/drivers/gpio/gpio-twl4030.c
+++ b/drivers/gpio/gpio-twl4030.c
@@ -485,7 +485,8 @@ static int gpio_twl4030_probe(struct platform_device *pdev)
 		goto no_irqs;
 	}
 
-	irq_base = irq_alloc_descs(-1, 0, TWL4030_GPIO_MAX, 0);
+	irq_base = devm_irq_alloc_descs(&pdev->dev, -1,
+					0, TWL4030_GPIO_MAX, 0);
 	if (irq_base < 0) {
 		dev_err(&pdev->dev, "Failed to alloc irq_descs\n");
 		return irq_base;
-- 
2.9.3
