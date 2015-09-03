From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] gpio: omap: Fix GPIO numbering for deferred probe
Date: Thu,  3 Sep 2015 10:31:27 -0700
Message-ID: <1441301487-6238-1-git-send-email-tony@atomide.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grygorii Strashko <grygorii.strashko@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

If gpio-omap probe fails with -EPROBE_DEFER, the GPIO numbering
keeps increasing. Only increase the gpio count if gpiochip_add()
was successful as otherwise the numbers will increase for each
probe attempt.

Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/gpio/gpio-omap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1095,7 +1095,6 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
 	} else {
 		bank->chip.label = "gpio";
 		bank->chip.base = gpio;
-		gpio += bank->width;
 	}
 	bank->chip.ngpio = bank->width;
 
@@ -1105,6 +1104,9 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
 		return ret;
 	}
 
+	if (!bank->is_mpuio)
+		gpio += bank->width;
+
 #ifdef CONFIG_ARCH_OMAP1
 	/*
 	 * REVISIT: Once we have OMAP1 supporting SPARSE_IRQ, we can drop
-- 
2.1.4

