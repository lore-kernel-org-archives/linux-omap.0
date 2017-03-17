From: David Rivshin <drivshin@awxrd.com>
Subject: [PATCH 1/2] gpio: omap: return error if requested debounce time is not possible
Date: Thu, 16 Mar 2017 21:48:55 -0400
Message-ID: <20170317014856.31449-2-drivshin@awxrd.com>
References: <20170317014856.31449-1-drivshin@awxrd.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170317014856.31449-1-drivshin@awxrd.com>
Sender: stable-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-arm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: David Rivshin <DRivshin@allworx.com>

omap_gpio_debounce() does not validate that the requested debounce
is within a range it can handle. Instead it lets the register value
wrap silently, and always returns success.

This can lead to all sorts of unexpected behavior, such as gpio_keys
asking for a too-long debounce, but getting a very short debounce in
practice.

Fix this by returning -EINVAL if the requested value does not fit into
the register field. If there is no debounce clock available at all,
return -ENOTSUPP.

Fixes: e85ec6c3047b ("gpio: omap: fix omap2_set_gpio_debounce")
Cc: <stable@vger.kernel.org> # 4.3+
Signed-off-by: David Rivshin <drivshin@allworx.com>
---
 drivers/gpio/gpio-omap.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index efc85a2..c40dbdd 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -208,9 +208,11 @@ static inline void omap_gpio_dbck_disable(struct gpio_bank *bank)
  * OMAP's debounce time is in 31us steps
  *   <debounce time> = (GPIO_DEBOUNCINGTIME[7:0].DEBOUNCETIME + 1) x 31
  * so we need to convert and round up to the closest unit.
+ *
+ * Return: 0 on success, negative error otherwise.
  */
-static void omap2_set_gpio_debounce(struct gpio_bank *bank, unsigned offset,
-				    unsigned debounce)
+static int omap2_set_gpio_debounce(struct gpio_bank *bank, unsigned offset,
+				   unsigned debounce)
 {
 	void __iomem		*reg;
 	u32			val;
@@ -218,11 +220,12 @@ static void omap2_set_gpio_debounce(struct gpio_bank *bank, unsigned offset,
 	bool			enable = !!debounce;
 
 	if (!bank->dbck_flag)
-		return;
+		return -ENOTSUPP;
 
 	if (enable) {
 		debounce = DIV_ROUND_UP(debounce, 31) - 1;
-		debounce &= OMAP4_GPIO_DEBOUNCINGTIME_MASK;
+		if ((debounce & OMAP4_GPIO_DEBOUNCINGTIME_MASK) != debounce)
+			return -EINVAL;
 	}
 
 	l = BIT(offset);
@@ -255,6 +258,8 @@ static void omap2_set_gpio_debounce(struct gpio_bank *bank, unsigned offset,
 		bank->context.debounce = debounce;
 		bank->context.debounce_en = val;
 	}
+
+	return 0;
 }
 
 /**
@@ -964,14 +969,15 @@ static int omap_gpio_debounce(struct gpio_chip *chip, unsigned offset,
 {
 	struct gpio_bank *bank;
 	unsigned long flags;
+	int ret;
 
 	bank = gpiochip_get_data(chip);
 
 	raw_spin_lock_irqsave(&bank->lock, flags);
-	omap2_set_gpio_debounce(bank, offset, debounce);
+	ret = omap2_set_gpio_debounce(bank, offset, debounce);
 	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
-	return 0;
+	return ret;
 }
 
 static int omap_gpio_set_config(struct gpio_chip *chip, unsigned offset,
-- 
2.9.3
