From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 38/42] drivers: gpio: vr41xx: use devm_platform_ioremap_resource()
Date: Mon, 11 Mar 2019 19:55:17 +0100
Message-ID: <1552330521-4276-38-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linus.walleij@linaro.org, bgolaszewski@baylibre.com, andrew@aj.id.au, f.fainelli@gmail.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com, orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com, keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com, thierry.reding@gmail.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, robert.jarzmik@free.fr, yamada.masahiro@socionext.com, jun.nie@linaro.org, shawnguo@kernel.org, linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

this driver deserves a bit more cleanup, to get rid of the global
variable giu_base, which makes it single-instance-only.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-vr41xx.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpio-vr41xx.c b/drivers/gpio/gpio-vr41xx.c
index b13a49c..98cd715 100644
--- a/drivers/gpio/gpio-vr41xx.c
+++ b/drivers/gpio/gpio-vr41xx.c
@@ -467,10 +467,9 @@ static int vr41xx_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 
 static int giu_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	unsigned int trigger, i, pin;
 	struct irq_chip *chip;
-	int irq, ret;
+	int irq;
 
 	switch (pdev->id) {
 	case GPIO_50PINS_PULLUPDOWN:
@@ -489,21 +488,14 @@ static int giu_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -EBUSY;
-
-	giu_base = ioremap(res->start, resource_size(res));
-	if (!giu_base)
-		return -ENOMEM;
+	giu_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(giu_base))
+		return PTR_ERR(giu_base);
 
 	vr41xx_gpio_chip.parent = &pdev->dev;
 
-	ret = gpiochip_add_data(&vr41xx_gpio_chip, NULL);
-	if (!ret) {
-		iounmap(giu_base);
+	if (gpiochip_add_data(&vr41xx_gpio_chip, NULL))
 		return -ENODEV;
-	}
 
 	giu_write(GIUINTENL, 0);
 	giu_write(GIUINTENH, 0);
@@ -534,7 +526,6 @@ static int giu_probe(struct platform_device *pdev)
 static int giu_remove(struct platform_device *pdev)
 {
 	if (giu_base) {
-		iounmap(giu_base);
 		giu_base = NULL;
 	}
 
-- 
1.9.1
