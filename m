From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 07/42] drivers: gpio: clps711x: use devm_platform_ioremap_resource()
Date: Mon, 11 Mar 2019 19:54:46 +0100
Message-ID: <1552330521-4276-7-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-clps711x.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-clps711x.c b/drivers/gpio/gpio-clps711x.c
index 52fd63f..0fbbb0e 100644
--- a/drivers/gpio/gpio-clps711x.c
+++ b/drivers/gpio/gpio-clps711x.c
@@ -19,7 +19,6 @@ static int clps711x_gpio_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	void __iomem *dat, *dir;
 	struct gpio_chip *gc;
-	struct resource *res;
 	int err, id;
 
 	if (!np)
@@ -33,13 +32,11 @@ static int clps711x_gpio_probe(struct platform_device *pdev)
 	if (!gc)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dat = devm_ioremap_resource(&pdev->dev, res);
+	dat = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dat))
 		return PTR_ERR(dat);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	dir = devm_ioremap_resource(&pdev->dev, res);
+	dir = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(dir))
 		return PTR_ERR(dir);
 
-- 
1.9.1
