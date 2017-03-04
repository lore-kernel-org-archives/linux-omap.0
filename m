From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 03/12] gpio: omap: use devm_irq_alloc_descs()
Date: Sat,  4 Mar 2017 17:23:31 +0100
Message-ID: <1488644620-11488-4-git-send-email-bgolaszewski@baylibre.com>
References: <1488644620-11488-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1488644620-11488-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

This driver never frees the allocated interrupt descriptors. Fix it by
using a resource managed variant of irq_alloc_descs().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-omap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index efc85a2..5d6a574 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1085,7 +1085,8 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
 	 * REVISIT: Once we have OMAP1 supporting SPARSE_IRQ, we can drop
 	 * irq_alloc_descs() since a base IRQ offset will no longer be needed.
 	 */
-	irq_base = irq_alloc_descs(-1, 0, bank->width, 0);
+	irq_base = devm_irq_alloc_descs(bank->chip.parent,
+					-1, 0, bank->width, 0);
 	if (irq_base < 0) {
 		dev_err(bank->chip.parent, "Couldn't allocate IRQ numbers\n");
 		return -ENODEV;
-- 
2.9.3

