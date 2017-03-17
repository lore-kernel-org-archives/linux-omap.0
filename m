From: David Rivshin <drivshin@awxrd.com>
Subject: [PATCH 2/2] gpio: omap: compute debounce-time from actual debounce-clock rate
Date: Thu, 16 Mar 2017 21:48:56 -0400
Message-ID: <20170317014856.31449-3-drivshin@awxrd.com>
References: <20170317014856.31449-1-drivshin@awxrd.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170317014856.31449-1-drivshin@awxrd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-arm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: David Rivshin <DRivshin@allworx.com>

omap2_set_gpio_debounce() assumes the debounce clock runs at 32768Hz,
leading to 31us granularity. In reality the debounce clock (which
is provided by other modules) could be at different rate, leading to
an incorrect computation of the number of debounce clock cycles for
GPIO_DEBOUNCINGTIME[DEBOUNCETIME].

Also, even with a standard 32768Hz input clock, the actual granularity
is ~30.5us. This leads to the actual debounce time being ~1.5% too
short.

Fix both issues by simply querying the dbck rate, rather than
hardcoding.

Fixes: e85ec6c3047b ("gpio: omap: fix omap2_set_gpio_debounce")
Cc: <stable@vger.kernel.org> # 4.3+
Signed-off-by: David Rivshin <drivshin@allworx.com>
---

This logical bug existed before e85ec6c3047b, but if backporting
further it's probably best to just cherry-pick/backport e85ec6c3047b
first.

 drivers/gpio/gpio-omap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index c40dbdd..66dbe37 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -205,8 +205,8 @@ static inline void omap_gpio_dbck_disable(struct gpio_bank *bank)
  * @offset: the gpio number on this @bank
  * @debounce: debounce time to use
  *
- * OMAP's debounce time is in 31us steps
- *   <debounce time> = (GPIO_DEBOUNCINGTIME[7:0].DEBOUNCETIME + 1) x 31
+ * OMAP's debounce time is in 1/DBCK steps
+ *   <debounce time> = (GPIO_DEBOUNCINGTIME[7:0].DEBOUNCETIME + 1) / DBCK
  * so we need to convert and round up to the closest unit.
  *
  * Return: 0 on success, negative error otherwise.
@@ -223,7 +223,9 @@ static int omap2_set_gpio_debounce(struct gpio_bank *bank, unsigned offset,
 		return -ENOTSUPP;
 
 	if (enable) {
-		debounce = DIV_ROUND_UP(debounce, 31) - 1;
+		u64 tmp = (u64)debounce * clk_get_rate(bank->dbck);
+
+		debounce = DIV_ROUND_UP_ULL(tmp, 1000000) - 1;
 		if ((debounce & OMAP4_GPIO_DEBOUNCINGTIME_MASK) != debounce)
 			return -EINVAL;
 	}
-- 
2.9.3
