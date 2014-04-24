From: yegorslists@googlemail.com
Subject: [PATCH v3] gpio: omap: implement get_direction
Date: Thu, 24 Apr 2014 08:57:39 +0200
Message-ID: <1398322659-20008-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com, linus.walleij@linaro.org, Yegor Yefremov <yegorslists@googlemail.com>
List-Id: linux-omap@vger.kernel.org

From: Yegor Yefremov <yegorslists@googlemail.com>

This patch implements gpio_chip's get_direction() routine, that
lets other drivers get particular GPIOs direction using
struct gpio_desc.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
---
Changes:
	v3: get rid of _get_gpio_direction() (Linus Walleij)
	v2: rework return value calculation
 drivers/gpio/gpio-omap.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 19b886c..62c12e4 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -27,6 +27,7 @@
 #include <linux/irqdomain.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/gpio.h>
+#include <linux/bitops.h>
 #include <linux/platform_data/gpio-omap.h>
 
 #define OFF_MODE	1
@@ -936,6 +937,21 @@ static inline void mpuio_init(struct gpio_bank *bank)
 
 /*---------------------------------------------------------------------*/
 
+static int gpio_get_direction(struct gpio_chip *chip, unsigned offset)
+{
+	struct gpio_bank *bank;
+	unsigned long flags;
+	void __iomem *reg;
+	int dir;
+
+	bank = container_of(chip, struct gpio_bank, chip);
+	reg = bank->base + bank->regs->direction;
+	spin_lock_irqsave(&bank->lock, flags);
+	dir = !!(readl_relaxed(reg) & BIT(offset));
+	spin_unlock_irqrestore(&bank->lock, flags);
+	return dir;
+}
+
 static int gpio_input(struct gpio_chip *chip, unsigned offset)
 {
 	struct gpio_bank *bank;
@@ -1092,6 +1108,7 @@ static void omap_gpio_chip_init(struct gpio_bank *bank)
 	 */
 	bank->chip.request = omap_gpio_request;
 	bank->chip.free = omap_gpio_free;
+	bank->chip.get_direction = gpio_get_direction;
 	bank->chip.direction_input = gpio_input;
 	bank->chip.get = gpio_get;
 	bank->chip.direction_output = gpio_output;
-- 
1.7.7

