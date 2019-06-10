From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH-next 19/20] gpio: gpio-omap: irq_startup() must not return error codes
Date: Mon, 10 Jun 2019 20:11:02 +0300
Message-ID: <20190610171103.30903-20-grygorii.strashko@ti.com>
References: <20190610171103.30903-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610171103.30903-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

The irq_startup() method returns an unsigned int, but in __irq_startup()
it is assigned to an int.  However, nothing checks for errors, so any
error that is returned is ignored.

Remove the check for GPIO-input mode and the error return.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/gpio/gpio-omap.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 61e32c7e6670..94b10dfbff3f 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -635,8 +635,6 @@ static unsigned int omap_gpio_irq_startup(struct irq_data *d)
 
 	if (!LINE_USED(bank->mod_usage, offset))
 		omap_set_gpio_direction(bank, offset, 1);
-	else if (!omap_gpio_is_input(bank, offset))
-		goto err;
 	omap_enable_gpio_module(bank, offset);
 	bank->irq_usage |= BIT(offset);
 
@@ -644,9 +642,6 @@ static unsigned int omap_gpio_irq_startup(struct irq_data *d)
 	omap_gpio_unmask_irq(d);
 
 	return 0;
-err:
-	raw_spin_unlock_irqrestore(&bank->lock, flags);
-	return -EINVAL;
 }
 
 static void omap_gpio_irq_shutdown(struct irq_data *d)
-- 
2.17.1
