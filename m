From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 34/42] drivers: gpio: timberdale: use devm_platform_ioremap_resource()
Date: Mon, 11 Mar 2019 19:55:13 +0100
Message-ID: <1552330521-4276-34-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-timberdale.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-timberdale.c b/drivers/gpio/gpio-timberdale.c
index 314e300..1c70e83 100644
--- a/drivers/gpio/gpio-timberdale.c
+++ b/drivers/gpio/gpio-timberdale.c
@@ -229,7 +229,6 @@ static int timbgpio_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct gpio_chip *gc;
 	struct timbgpio *tgpio;
-	struct resource *iomem;
 	struct timbgpio_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	int irq = platform_get_irq(pdev, 0);
 
@@ -246,8 +245,7 @@ static int timbgpio_probe(struct platform_device *pdev)
 
 	spin_lock_init(&tgpio->lock);
 
-	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	tgpio->membase = devm_ioremap_resource(dev, iomem);
+	tgpio->membase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(tgpio->membase))
 		return PTR_ERR(tgpio->membase);
 
-- 
1.9.1
