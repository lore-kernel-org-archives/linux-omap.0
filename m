From: <grygorii.strashko@linaro.org>
Subject: [PATCH 3/8] gpio: omap: convert debounce functions switch to use gpio offset
Date: Thu, 19 Mar 2015 19:25:39 +0200
Message-ID: <1426785944-17255-4-git-send-email-grygorii.strashko@linaro.org>
References: <1426785944-17255-1-git-send-email-grygorii.strashko@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:33074 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755106AbbCSR0A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2015 13:26:00 -0400
Received: by lbnq5 with SMTP id q5so29904417lbn.0
        for <linux-omap@vger.kernel.org>; Thu, 19 Mar 2015 10:25:58 -0700 (PDT)
In-Reply-To: <1426785944-17255-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@linaro.org>

From: Grygorii Strashko <grygorii.strashko@linaro.org>

Convert debounce functions to use GPIO offset instead of system
GPIO numbers. This allows to drop unneeded conversations between
system GPIO <-> GPIO offset which are done in many places and
many times.
It is safe to do now because:
- gpiolib always passes GPIO offset to GPIO controller
- OMAP GPIO driver converted to use IRQ domain

This is preparation step before removing:
 #define GPIO_INDEX(bank, gpio)
 #define GPIO_BIT(bank, gpio)
 int omap_irq_to_gpio()

Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
---
 drivers/gpio/gpio-omap.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 7aeee7b..2df693b 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -208,13 +208,13 @@ static inline void omap_gpio_dbck_disable(struct gpio_bank *bank)
 /**
  * omap2_set_gpio_debounce - low level gpio debounce time
  * @bank: the gpio bank we're acting upon
- * @gpio: the gpio number on this @gpio
+ * @offset: the gpio number on this @bank
  * @debounce: debounce time to use
  *
  * OMAP's debounce time is in 31us steps so we need
  * to convert and round up to the closest unit.
  */
-static void omap2_set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
+static void omap2_set_gpio_debounce(struct gpio_bank *bank, unsigned offset,
 				    unsigned debounce)
 {
 	void __iomem		*reg;
@@ -231,7 +231,7 @@ static void omap2_set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 	else
 		debounce = (debounce / 0x1f) - 1;
 
-	l = GPIO_BIT(bank, gpio);
+	l = BIT(offset);
 
 	clk_prepare_enable(bank->dbck);
 	reg = bank->base + bank->regs->debounce;
@@ -266,16 +266,16 @@ static void omap2_set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 /**
  * omap_clear_gpio_debounce - clear debounce settings for a gpio
  * @bank: the gpio bank we're acting upon
- * @gpio: the gpio number on this @gpio
+ * @offset: the gpio number on this @bank
  *
  * If a gpio is using debounce, then clear the debounce enable bit and if
  * this is the only gpio in this bank using debounce, then clear the debounce
  * time too. The debounce clock will also be disabled when calling this function
  * if this is the only gpio in the bank using debounce.
  */
-static void omap_clear_gpio_debounce(struct gpio_bank *bank, unsigned gpio)
+static void omap_clear_gpio_debounce(struct gpio_bank *bank, unsigned offset)
 {
-	u32 gpio_bit = GPIO_BIT(bank, gpio);
+	u32 gpio_bit = BIT(offset);
 
 	if (!bank->dbck_flag)
 		return;
@@ -659,7 +659,7 @@ static void omap_reset_gpio(struct gpio_bank *bank, int gpio)
 	omap_set_gpio_irqenable(bank, gpio, 0);
 	omap_clear_gpio_irqstatus(bank, gpio);
 	omap_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
-	omap_clear_gpio_debounce(bank, gpio);
+	omap_clear_gpio_debounce(bank, GPIO_INDEX(bank, gpio));
 }
 
 /* Use disable_irq_wake() and enable_irq_wake() functions from drivers */
-- 
1.9.1

