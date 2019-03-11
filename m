From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 35/42] drivers: gpio: ts4800: use devm_platform_ioremap_resource()
Date: Mon, 11 Mar 2019 19:55:14 +0100
Message-ID: <1552330521-4276-35-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-ts4800.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-ts4800.c b/drivers/gpio/gpio-ts4800.c
index c2a80b4..8c0d82d 100644
--- a/drivers/gpio/gpio-ts4800.c
+++ b/drivers/gpio/gpio-ts4800.c
@@ -23,7 +23,6 @@ static int ts4800_gpio_probe(struct platform_device *pdev)
 {
 	struct device_node *node;
 	struct gpio_chip *chip;
-	struct resource *res;
 	void __iomem *base_addr;
 	int retval;
 	u32 ngpios;
@@ -32,8 +31,7 @@ static int ts4800_gpio_probe(struct platform_device *pdev)
 	if (!chip)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base_addr = devm_ioremap_resource(&pdev->dev, res);
+	base_addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base_addr))
 		return PTR_ERR(base_addr);
 
-- 
1.9.1
