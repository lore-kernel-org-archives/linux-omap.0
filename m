From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 5/5] gpio: davinci: Add a separate compatible for k2g
Date: Wed, 19 Oct 2016 11:03:59 +0530
Message-ID: <1476855239-32730-6-git-send-email-j-keerthy@ti.com>
References: <1476855239-32730-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1476855239-32730-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lokeshvutla-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

In the case of k2g the clocks are handled differently as when compared
with other keystones. Hence adding a separate compatible and match tables
accordingly.

Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/gpio/gpio-davinci.txt      |  2 +-
 drivers/gpio/gpio-davinci.c                        | 45 ++++++++++++++++++++--
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-davinci.txt b/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
index 5079ba7..a76abd2 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
@@ -1,7 +1,7 @@
 Davinci/Keystone GPIO controller bindings
 
 Required Properties:
-- compatible: should be "ti,dm6441-gpio", "ti,keystone-gpio"
+- compatible: should be "ti,dm6441-gpio", "ti,keystone-gpio", "ti,k2g-gpio"
 
 - reg: Physical base address of the controller and the size of memory mapped
        registers.
diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index f7c506b..d91a9a8 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -452,6 +452,26 @@ static struct irq_chip *keystone_gpio_get_irq_chip(unsigned int irq)
 
 static const struct of_device_id davinci_gpio_ids[];
 
+struct gpio_driver_data {
+	gpio_get_irq_chip_cb_t gpio_get_irq_chip;
+	bool clk_optional;
+};
+
+static struct gpio_driver_data davinci_data = {
+	.gpio_get_irq_chip = davinci_gpio_get_irq_chip,
+	.clk_optional = false,
+};
+
+static struct gpio_driver_data keystone_data = {
+	.gpio_get_irq_chip = keystone_gpio_get_irq_chip,
+	.clk_optional = false,
+};
+
+static struct gpio_driver_data k2g_data = {
+	.gpio_get_irq_chip = keystone_gpio_get_irq_chip,
+	.clk_optional = true,
+};
+
 /*
  * NOTE:  for suspend/resume, probably best to make a platform_device with
  * suspend_late/resume_resume calls hooking into results of the set_wake()
@@ -475,6 +495,7 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 	struct irq_domain	*irq_domain = NULL;
 	const struct of_device_id *match;
 	struct irq_chip *irq_chip;
+	struct gpio_driver_data *driver_data = NULL;
 	gpio_get_irq_chip_cb_t gpio_get_irq_chip;
 
 	/*
@@ -483,8 +504,10 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 	gpio_get_irq_chip = davinci_gpio_get_irq_chip;
 	match = of_match_device(of_match_ptr(davinci_gpio_ids),
 				dev);
-	if (match)
-		gpio_get_irq_chip = (gpio_get_irq_chip_cb_t)match->data;
+	if (match) {
+		driver_data = (struct gpio_driver_data *)match->data;
+		gpio_get_irq_chip = driver_data->gpio_get_irq_chip;
+	}
 
 	ngpio = pdata->ngpio;
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
@@ -500,6 +523,9 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	if (driver_data && driver_data->clk_optional)
+		goto skip_clk_handling;
+
 	clk = devm_clk_get(dev, "gpio");
 	if (IS_ERR(clk)) {
 		printk(KERN_ERR "Error %ld getting gpio clock?\n",
@@ -508,6 +534,7 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 	}
 	clk_prepare_enable(clk);
 
+skip_clk_handling:
 	if (!pdata->gpio_unbanked) {
 		irq = irq_alloc_descs(-1, 0, ngpio, 0);
 		if (irq < 0) {
@@ -607,8 +634,18 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 
 #if IS_ENABLED(CONFIG_OF)
 static const struct of_device_id davinci_gpio_ids[] = {
-	{ .compatible = "ti,keystone-gpio", keystone_gpio_get_irq_chip},
-	{ .compatible = "ti,dm6441-gpio", davinci_gpio_get_irq_chip},
+	{
+		.compatible = "ti,keystone-gpio",
+		.data = &keystone_data,
+	},
+	{
+		.compatible = "ti,dm6441-gpio",
+		.data = &davinci_data,
+	},
+	{
+		.compatible = "ti,k2g-gpio",
+		.data = &k2g_data,
+	},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, davinci_gpio_ids);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
