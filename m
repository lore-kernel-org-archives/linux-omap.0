From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 32/42] drivers: gpio: tb10x: use devm_platform_ioremap_resource()
Date: Mon, 11 Mar 2019 19:55:11 +0100
Message-ID: <1552330521-4276-32-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linus.walleij@linaro.org, bgolaszewski@baylibre.com, andrew@aj.id.au, f.fainelli@gmail.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com, orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com, keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com, thierry.reding@gmail.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, robert.jarzmik@free.fr, yamada.masahiro@socionext.com, jun.nie@linaro.org, shawnguo@kernel.org, linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-tb10x.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-tb10x.c b/drivers/gpio/gpio-tb10x.c
index d5e5d19..6bbac6c 100644
--- a/drivers/gpio/gpio-tb10x.c
+++ b/drivers/gpio/gpio-tb10x.c
@@ -120,7 +120,6 @@ static irqreturn_t tb10x_gpio_irq_cascade(int irq, void *data)
 static int tb10x_gpio_probe(struct platform_device *pdev)
 {
 	struct tb10x_gpio *tb10x_gpio;
-	struct resource *mem;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	int ret = -EBUSY;
@@ -136,8 +135,7 @@ static int tb10x_gpio_probe(struct platform_device *pdev)
 	if (tb10x_gpio == NULL)
 		return -ENOMEM;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	tb10x_gpio->base = devm_ioremap_resource(dev, mem);
+	tb10x_gpio->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(tb10x_gpio->base))
 		return PTR_ERR(tb10x_gpio->base);
 
-- 
1.9.1
