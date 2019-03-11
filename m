From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 30/42] drivers: gpio: sta2x11: use devm_platform_ioremap_resource()
Date: Mon, 11 Mar 2019 19:55:09 +0100
Message-ID: <1552330521-4276-30-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-sta2x11.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-sta2x11.c b/drivers/gpio/gpio-sta2x11.c
index 2283c86..a51c310 100644
--- a/drivers/gpio/gpio-sta2x11.c
+++ b/drivers/gpio/gpio-sta2x11.c
@@ -360,7 +360,6 @@ static int gsta_probe(struct platform_device *dev)
 	struct pci_dev *pdev;
 	struct sta2x11_gpio_pdata *gpio_pdata;
 	struct gsta_gpio *chip;
-	struct resource *res;
 
 	pdev = *(struct pci_dev **)dev_get_platdata(&dev->dev);
 	gpio_pdata = dev_get_platdata(&pdev->dev);
@@ -369,13 +368,11 @@ static int gsta_probe(struct platform_device *dev)
 		dev_err(&dev->dev, "no gpio config\n");
 	pr_debug("gpio config: %p\n", gpio_pdata);
 
-	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
-
 	chip = devm_kzalloc(&dev->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 	chip->dev = &dev->dev;
-	chip->reg_base = devm_ioremap_resource(&dev->dev, res);
+	chip->reg_base = devm_platform_ioremap_resource(dev, 0);
 	if (IS_ERR(chip->reg_base))
 		return PTR_ERR(chip->reg_base);
 
-- 
1.9.1
