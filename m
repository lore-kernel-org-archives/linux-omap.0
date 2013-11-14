From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/8] gpio: twl4030: Fix regression for twl gpio output
Date: Wed, 13 Nov 2013 18:35:34 -0800
Message-ID: <1384396537-3486-6-git-send-email-tony@atomide.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:46423 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752005Ab3KNCfs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Nov 2013 21:35:48 -0500
In-Reply-To: <1384396537-3486-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-gpio@vger.kernel.org

Commit c111feabe2e2 (gpio: twl4030: Cache the direction and output
states in private data) improved things in general, but caused a
regression for setting the GPIO output direction.

The change reorganized twl_direction_out() and twl_set() and swapped
the function names around in the process. While doing that, a bug got
introduced that's not obvious while reading the patch as it appears
as no change to the code.

The bug is we now call function twl4030_set_gpio_dataout() twice in
both twl_direction_out() and twl_set(). Instead, we should first
call twl_direction_out() in twl_direction_out() followed by
twl4030_set_gpio_dataout() in twl_set().

This regression probably has gone unnoticed for a long time as the
bootloader may have set the GPIO direction properly in many cases.
This fixes at least the LCD panel not turning on omap3 LDP for
example.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-gpio@vger.kernel.org
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

If this looks OK, I'd like to merge this as a fix via arm-soc tree
along with the other patches in this series as my later patches
depend on patches in this series.

---
 drivers/gpio/gpio-twl4030.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.c
index 0c7e891..5738d5a 100644
--- a/drivers/gpio/gpio-twl4030.c
+++ b/drivers/gpio/gpio-twl4030.c
@@ -354,17 +354,18 @@ static void twl_set(struct gpio_chip *chip, unsigned offset, int value)
 static int twl_direction_out(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct gpio_twl4030_priv *priv = to_gpio_twl4030(chip);
+	int ret = -EINVAL;
 
 	mutex_lock(&priv->mutex);
 	if (offset < TWL4030_GPIO_MAX)
-		twl4030_set_gpio_dataout(offset, value);
+		ret = twl4030_set_gpio_direction(offset, 0);
 
 	priv->direction |= BIT(offset);
 	mutex_unlock(&priv->mutex);
 
 	twl_set(chip, offset, value);
 
-	return 0;
+	return ret;
 }
 
 static int twl_to_irq(struct gpio_chip *chip, unsigned offset)
-- 
1.8.1.1

