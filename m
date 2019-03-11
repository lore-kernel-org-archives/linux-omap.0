From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 25/42] drivers: gpio: pxa: use devm_platform_ioremap_resource()
Date: Mon, 11 Mar 2019 19:55:04 +0100
Message-ID: <1552330521-4276-25-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-pxa.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index bcc6be4..dd47960 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -622,7 +622,6 @@ static int pxa_gpio_probe(struct platform_device *pdev)
 {
 	struct pxa_gpio_chip *pchip;
 	struct pxa_gpio_bank *c;
-	struct resource *res;
 	struct clk *clk;
 	struct pxa_gpio_platform_data *info;
 	void __iomem *gpio_reg_base;
@@ -665,11 +664,8 @@ static int pxa_gpio_probe(struct platform_device *pdev)
 
 	pchip->irq0 = irq0;
 	pchip->irq1 = irq1;
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -EINVAL;
-	gpio_reg_base = devm_ioremap(&pdev->dev, res->start,
-				     resource_size(res));
+
+	gpio_reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (!gpio_reg_base)
 		return -EINVAL;
 
-- 
1.9.1
