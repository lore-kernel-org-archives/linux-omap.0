From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v2 2/2] gpiolib: add description for gpio irqchip fields in struct gpio_chip
Date: Mon, 17 Aug 2015 15:35:24 +0300
Message-ID: <1439814924-11881-2-git-send-email-grygorii.strashko@ti.com>
References: <1439814924-11881-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1439814924-11881-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, lars@metafoo.de, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Add missed description for GPIO irqchip fields in struct gpio_chip.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
Changes in v2:
- New patch.

 include/linux/gpio/driver.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 0c7004d..1aed31c 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -65,6 +65,17 @@ struct seq_file;
  *	registers.
  * @irq_not_threaded: flag must be set if @can_sleep is set but the
  *	IRQs don't need to be threaded
+ * @irqchip: GPIO IRQ chip impl, provided by GPIO driver
+ * @irqdomain: Interrupt translation domain; responsible for mapping
+ *	between GPIO hwirq number and linux irq number
+ * @irq_base: first linux IRQ number assigned to GPIO IRQ chip (deprecated)
+ * @irq_handler: the irq handler to use (often a predefined irq core function)
+ *	for GPIO IRQs, provided by GPIO driver
+ * @irq_default_type: default IRQ triggering type applied during GPIO driver
+ *	initialization, provided by GPIO driver
+ * @irq_parent: GPIO IRQ chip parent/bank linux irq number,
+ *	provided by GPIO driver
+ * @lock_key: per GPIO IRQ chip lockdep class
  *
  * A gpio_chip can help platforms abstract various sources of GPIOs so
  * they can all be accessed through a common programing interface.
-- 
2.5.0

