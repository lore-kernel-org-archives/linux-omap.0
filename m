From: Grygorii Strashko <grygorii.strashko@linaro.org>
Subject: [RFC/RFT PATCH 5/7] gpio: omap: rework omap_gpio_irq_startup to handle current pin state properly
Date: Fri, 22 May 2015 17:35:52 +0300
Message-ID: <1432305354-5968-6-git-send-email-grygorii.strashko@linaro.org>
References: <1432305354-5968-1-git-send-email-grygorii.strashko@linaro.org>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1432305354-5968-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, tony@atomide.com
Cc: Javier Martinez Canillas <javier@dowhile0.org>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, Grygorii Strashko <grygorii.strashko@linaro.org>
List-Id: linux-omap@vger.kernel.org

The omap_gpio_irq_startup() can be called at time when:
- corresponding GPIO has been requested already and in this case
it has to be configured as input already. If not - return with -EINVAL
and do not try to re-configure it as it could be unsafe.
- corresponding GPIO is free: reconfigure GPIO as input.

In addition, call omap_enable_gpio_module directly as all needed
checks are already present inside it.

Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
---
 drivers/gpio/gpio-omap.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 2fbd569..1c226f1 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -790,11 +790,23 @@ static unsigned int omap_gpio_irq_startup(struct irq_data *d)
 		pm_runtime_get_sync(bank->dev);
 
 	spin_lock_irqsave(&bank->lock, flags);
-	omap_gpio_init_irq(bank, offset);
+
+	if (!LINE_USED(bank->mod_usage, offset))
+		omap_set_gpio_direction(bank, offset, 1);
+	else if (!omap_gpio_is_input(bank, offset))
+		goto err;
+	omap_enable_gpio_module(bank, offset);
+	bank->irq_usage |= BIT(offset);
+
 	spin_unlock_irqrestore(&bank->lock, flags);
 	omap_gpio_unmask_irq(d);
 
 	return 0;
+err:
+	spin_unlock_irqrestore(&bank->lock, flags);
+	if (!BANK_USED(bank))
+		pm_runtime_put(bank->dev);
+	return -EINVAL;
 }
 
 static void omap_gpio_irq_shutdown(struct irq_data *d)
-- 
1.9.1

