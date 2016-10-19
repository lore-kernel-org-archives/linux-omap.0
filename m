From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 1/5] gpio: davinci: Remove gpio2regs function to accommodate  multi instances
Date: Wed, 19 Oct 2016 11:03:55 +0530
Message-ID: <1476855239-32730-2-git-send-email-j-keerthy@ti.com>
References: <1476855239-32730-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1476855239-32730-1-git-send-email-j-keerthy@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: linus.walleij@linaro.org
Cc: gnurou@gmail.com, lokeshvutla@ti.com, robh+dt@kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, rogerq@ti.com, grygorii.strashko@ti.com, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

gpio2regs is written making an assumption that driver supports only
one instance of gpio controller. Removing this and adding a generic
array so as to support multiple instances of gpio controllers.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/gpio/gpio-davinci.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index dd262f0..419cfaf 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -42,25 +42,7 @@ struct davinci_gpio_regs {
 #define BINTEN	0x8 /* GPIO Interrupt Per-Bank Enable Register */
 
 static void __iomem *gpio_base;
-
-static struct davinci_gpio_regs __iomem *gpio2regs(unsigned gpio)
-{
-	void __iomem *ptr;
-
-	if (gpio < 32 * 1)
-		ptr = gpio_base + 0x10;
-	else if (gpio < 32 * 2)
-		ptr = gpio_base + 0x38;
-	else if (gpio < 32 * 3)
-		ptr = gpio_base + 0x60;
-	else if (gpio < 32 * 4)
-		ptr = gpio_base + 0x88;
-	else if (gpio < 32 * 5)
-		ptr = gpio_base + 0xb0;
-	else
-		ptr = NULL;
-	return ptr;
-}
+static unsigned offset_array[5] = {0x10, 0x38, 0x60, 0x88, 0xb0};
 
 static inline struct davinci_gpio_regs __iomem *irq2regs(struct irq_data *d)
 {
@@ -257,7 +239,7 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 #endif
 		spin_lock_init(&chips[i].lock);
 
-		regs = gpio2regs(base);
+		regs = gpio_base + offset_array[i];
 		if (!regs)
 			return -ENXIO;
 		chips[i].regs = regs;
@@ -415,7 +397,9 @@ static int gpio_irq_type_unbanked(struct irq_data *data, unsigned trigger)
 davinci_gpio_irq_map(struct irq_domain *d, unsigned int irq,
 		     irq_hw_number_t hw)
 {
-	struct davinci_gpio_regs __iomem *g = gpio2regs(hw);
+	struct davinci_gpio_controller *chips =
+				(struct davinci_gpio_controller *)d->host_data;
+	struct davinci_gpio_regs __iomem *g = chips[hw / 32].regs;
 
 	irq_set_chip_and_handler_name(irq, &gpio_irqchip, handle_simple_irq,
 				"davinci_gpio");
@@ -552,7 +536,7 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 		irq_chip->irq_set_type = gpio_irq_type_unbanked;
 
 		/* default trigger: both edges */
-		g = gpio2regs(0);
+		g = chips[0].regs;
 		writel_relaxed(~0, &g->set_falling);
 		writel_relaxed(~0, &g->set_rising);
 
@@ -572,7 +556,7 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 	 */
 	for (gpio = 0, bank = 0; gpio < ngpio; bank++, bank_irq++, gpio += 16) {
 		/* disabled by default, enabled only as needed */
-		g = gpio2regs(gpio);
+		g = chips[bank / 2].regs;
 		writel_relaxed(~0, &g->clr_falling);
 		writel_relaxed(~0, &g->clr_rising);
 
-- 
1.9.1

