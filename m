From: yegorslists@googlemail.com
Subject: [PATCH v2] gpio: omap: implement get_direction
Date: Tue, 22 Apr 2014 15:31:45 +0200
Message-ID: <1398173505-28193-1-git-send-email-yegorslists@googlemail.com>
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
	v2: rework return value calculation

 drivers/gpio/gpio-omap.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 19b886c..fadc45e 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -102,6 +102,17 @@ static int omap_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 	return irq_find_mapping(bank->domain, offset);
 }
 
+static int _get_gpio_direction(struct gpio_bank *bank, int gpio)
+{
+	void __iomem *reg = bank->base;
+	u32 l;
+
+	reg += bank->regs->direction;
+	l = (readl_relaxed(reg) >> gpio);
+
+	return (l & 0x00000001);
+}
+
 static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
 {
 	void __iomem *reg = bank->base;
@@ -936,6 +947,19 @@ static inline void mpuio_init(struct gpio_bank *bank)
 
 /*---------------------------------------------------------------------*/
 
+static int gpio_get_direction(struct gpio_chip *chip, unsigned offset)
+{
+	struct gpio_bank *bank;
+	unsigned long flags;
+	int dir;
+
+	bank = container_of(chip, struct gpio_bank, chip);
+	spin_lock_irqsave(&bank->lock, flags);
+	dir = _get_gpio_direction(bank, offset);
+	spin_unlock_irqrestore(&bank->lock, flags);
+	return dir;
+}
+
 static int gpio_input(struct gpio_chip *chip, unsigned offset)
 {
 	struct gpio_bank *bank;
@@ -1092,6 +1116,7 @@ static void omap_gpio_chip_init(struct gpio_bank *bank)
 	 */
 	bank->chip.request = omap_gpio_request;
 	bank->chip.free = omap_gpio_free;
+	bank->chip.get_direction = gpio_get_direction;
 	bank->chip.direction_input = gpio_input;
 	bank->chip.get = gpio_get;
 	bank->chip.direction_output = gpio_output;
-- 
1.7.7

