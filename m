From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] pinctrl: core: Warn about NULL gpio_chip in pinctrl_ready_for_gpio_range()
Date: Thu,  3 Sep 2015 10:34:30 -0700
Message-ID: <1441301670-6498-1-git-send-email-tony@atomide.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

If the gpio driver is confused about the numbers for gpio-ranges,
pinctrl_ready_for_gpio_range() may get called with invalid GPIO
causing a NULL pointer exception. Let's instead provide a warning
that allows fixing the problem and return with error.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/pinctrl/core.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -349,6 +349,9 @@ static bool pinctrl_ready_for_gpio_range(unsigned gpio)
 	struct pinctrl_gpio_range *range = NULL;
 	struct gpio_chip *chip = gpio_to_chip(gpio);
 
+	if (WARN(!chip, "no gpio_chip for gpio%i?", gpio))
+		return false;
+
 	mutex_lock(&pinctrldev_list_mutex);
 
 	/* Loop over the pin controllers */
-- 
2.1.4

