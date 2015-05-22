From: Grygorii Strashko <grygorii.strashko@linaro.org>
Subject: [PATCH 1/7] gpio: omap: fix omap_gpio_free to not clean up irq configuration
Date: Fri, 22 May 2015 17:35:48 +0300
Message-ID: <1432305354-5968-2-git-send-email-grygorii.strashko@linaro.org>
References: <1432305354-5968-1-git-send-email-grygorii.strashko@linaro.org>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1432305354-5968-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, tony@atomide.com
Cc: Javier Martinez Canillas <javier@dowhile0.org>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, Grygorii Strashko <grygorii.strashko@linaro.org>
List-Id: linux-omap@vger.kernel.org

This patch fixes following issue:
- GPIOn is used as IRQ by some dev, for example PCF8575.INT ->  gpio6.11
- PCFx driver knows nothing about type of IRQ line (GPIO or not)
  so it doesn't request gpio and just do request_irq()
- If gpio6.11 will be exported through the sysfs and then un-xeported
then IRQs from PCFx will not be received any more, because
IRQ configuration for gpio6.11 will be cleaned up unconditionally
in omap_gpio_free.

Fix this by removing all GPIO IRQ specific code from omap_gpio_free()
and also do GPIO clean up (change direction to 'in' and disable debounce)
only if corresponding GPIO is not used as IRQ too.
GPIO IRQ will be properly cleaned up by GPIO irqchip code.

Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
---
 drivers/gpio/gpio-omap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index b232397..bb60cbc 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -690,8 +690,11 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 
 	spin_lock_irqsave(&bank->lock, flags);
 	bank->mod_usage &= ~(BIT(offset));
+	if (!LINE_USED(bank->irq_usage, offset)) {
+		omap_set_gpio_direction(bank, offset, 1);
+		omap_clear_gpio_debounce(bank, offset);
+	}
 	omap_disable_gpio_module(bank, offset);
-	omap_reset_gpio(bank, offset);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	/*
-- 
1.9.1

