From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2] gpio: omap: Give unique labels to each GPIO bank/chip
Date: Tue,  2 Jan 2018 11:32:48 +0100
Message-ID: <20180102103248.15803-1-linus.walleij@linaro.org>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

As we need to add GPIO lookup tables to the OMAP platforms, we
need to reference each GPIO chip with a unique label. Use the GPIO
base to name each chip, "gpio-0-31", "gpio-32-63" etc.

Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Break out errorpath fix to a separate patch.
---
 drivers/gpio/gpio-omap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index d83e8624964a..ed07bbcede01 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1059,6 +1059,7 @@ static void omap_gpio_mod_init(struct gpio_bank *bank)
 static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
 {
 	static int gpio;
+	const char *label;
 	int irq_base = 0;
 	int ret;
 
@@ -1080,7 +1081,11 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
 			bank->chip.parent = &omap_mpuio_device.dev;
 		bank->chip.base = OMAP_MPUIO(0);
 	} else {
-		bank->chip.label = "gpio";
+		label = devm_kasprintf(bank->chip.parent, GFP_KERNEL, "gpio-%d-%d",
+				       gpio, gpio + bank->width - 1);
+		if (!label)
+			return -ENOMEM;
+		bank->chip.label = label;
 		bank->chip.base = gpio;
 	}
 	bank->chip.ngpio = bank->width;
-- 
2.14.3

