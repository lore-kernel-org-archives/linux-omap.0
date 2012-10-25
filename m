From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v3] gpio/omap: fix off-mode bug: clear debounce clock
 enable mask on free/reset
Date: Thu, 25 Oct 2012 17:52:38 -0500
Message-ID: <5089C2B6.5020606@ti.com>
References: <1351182858-14045-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40439 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab2JYWwq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 18:52:46 -0400
In-Reply-To: <1351182858-14045-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>, Grazvydas Ignotas <notasas@gmail.com>

Hi Kevin,

On 10/25/2012 11:34 AM, Kevin Hilman wrote:
> From: Kevin Hilman <khilman@ti.com>
> 
> When a GPIO is freed or shutdown, ensure that the proper bit in
> dbck_enable_mask is cleared also.  Otherwise, context restore on
> subsequent off-mode transition will restore previous debounce values
> from the shadow copies (bank->context.debounce*) leading to mismatch
> state between driver state and hardware state.
> 
> This was discovered when board code was doing
> 
>   gpio_request_one()
>   gpio_set_debounce()
>   gpio_free()
> 
> which was leaving the GPIO debounce settings in a confused state.  If
> that GPIO bank is subsequently used with off-mode enabled, bogus state
> would be restored, leaving GPIO debounce enabled which then prevented
> the CORE powerdomain from transitioning.
> 
> To fix, ensure that right bit in bank->dbck_enable_mask is cleared
> when a GPIO is freed/shutdown so debounce state doesn't persist after
> free/reset.  If this GPIO is the last debounce-enabled GPIO in the
> bank, the debounce will also be cut.
> 
> Special thanks to Grazvydas Ignotas for pointing out a bug in the
> first version that would've disabled debounce on any runtime PM
> transition.
> 
> And, special thanks to Jon Hunter for pointing out a bug in the second
> version which was mistakenly clearing all debounce bits on reset
> instead of individual GPIOs, as well as suggesting cutting the
> debounce clock after all debounce bits are cleared.

... and for introducing yet another bug :-(
 
> Tesed on 37xx/EVM board which configures GPIO debounce for the ads7846
> touchscreen in its board file using the above sequence, and so was
> failing off-mode tests in dynamic idle.  Verified that off-mode tests
> are passing with this patch.
> 
> Reported-by: Paul Walmsley <paul@pwsan.com>
> Cc: Igor Grinberg <grinberg@compulab.co.il>
> Cc: Grazvydas Ignotas <notasas@gmail.com>
> Cc: Jon Hunter <jon-hunter@ti.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
>  drivers/gpio/gpio-omap.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 94cbc84..ce1da19 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -539,6 +539,8 @@ static void _reset_gpio(struct gpio_bank *bank, int gpio)
>  	_set_gpio_irqenable(bank, gpio, 0);
>  	_clear_gpio_irqstatus(bank, gpio);
>  	_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
> +	bank->dbck_enable_mask &= ~(GPIO_BIT(bank, gpio));
> +	_gpio_dbck_disable(bank);

We can't use _gpio_dbck_disable() here. This has been specifically implemented
for the suspend path and is designed to disable the debounce clock while
debounce is enabled (which makes sense). Yes this needs to be cleaned up.

I have implemented the following and unit tested. Care to test on your 37xx
board? Sorry I would do it myself I had one. 

Also not sure if you just wish to squash your patch and mine together.
This is based on top of yours.

Cheers
Jon

>From 33812f3bd4f7aab1154e7194b7f11fba700a5086 Mon Sep 17 00:00:00 2001
From: Jon Hunter <jon-hunter@ti.com>
Date: Thu, 25 Oct 2012 16:00:51 -0500
Subject: [PATCH] gpio/omap: fix clearing of debounce settings on gpio
 free/reset

When a GPIO is freed or shutdown, we need to ensure that any debounce settings
are cleared and if the GPIO is the only GPIO in the bank that is currently
using debounce, then disable the debounce clock as well to save power.

Therefore, introduce a new function called _clear_gpio_debounce() to clear
any debounce settings when the GPIO is freed or shutdown.

Please note that we cannot use _gpio_dbck_disable() to disable the debounce
clock because this has been specifically created for the gpio suspend path
and is intended to shutdown the debounce clock while debounce is enabled.

This has been unit tested on an OMAP3430 Beagle board, by requesting a gpio,
enabling debounce and then freeing the gpio and checking the register contents,
the saved register context and the debounce clock state.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 drivers/gpio/gpio-omap.c |   37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index ce1da19..d335af1 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -251,6 +251,40 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 	}
 }
 
+/**
+ * _clear_gpio_debounce - clear debounce settings for a gpio
+ * @bank: the gpio bank we're acting upon
+ * @gpio: the gpio number on this @gpio
+ *
+ * If a gpio is using debounce, then clear the debounce enable bit and if
+ * this is the only gpio in this bank using debounce, then clear the debounce
+ * time too. The debounce clock will also be disabled when calling this function
+ * if this is the only gpio in the bank using debounce.
+ */
+static void _clear_gpio_debounce(struct gpio_bank *bank, unsigned gpio)
+{
+	u32 gpio_bit = GPIO_BIT(bank, gpio);
+
+	if (!bank->dbck_flag)
+		return;
+
+	if (!(bank->dbck_enable_mask & gpio_bit))
+		return;
+
+	bank->dbck_enable_mask &= ~gpio_bit;
+	bank->context.debounce_en &= ~gpio_bit;
+	__raw_writel(bank->context.debounce_en,
+		     bank->base + bank->regs->debounce_en);
+
+	if (!bank->dbck_enable_mask) {
+		bank->context.debounce = 0;
+		__raw_writel(bank->context.debounce, bank->base +
+			     bank->regs->debounce);
+		clk_disable(bank->dbck);
+		bank->dbck_enabled = false;
+	}
+}
+
 static inline void set_gpio_trigger(struct gpio_bank *bank, int gpio,
 						unsigned trigger)
 {
@@ -539,8 +573,7 @@ static void _reset_gpio(struct gpio_bank *bank, int gpio)
 	_set_gpio_irqenable(bank, gpio, 0);
 	_clear_gpio_irqstatus(bank, gpio);
 	_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
-	bank->dbck_enable_mask &= ~(GPIO_BIT(bank, gpio));
-	_gpio_dbck_disable(bank);
+	_clear_gpio_debounce(bank, gpio);
 }
 
 /* Use disable_irq_wake() and enable_irq_wake() functions from drivers */
-- 
1.7.9.5

