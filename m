From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 14/42] drivers: gpio: iop: use devm_platform_ioremap_resource()
Date: Mon, 11 Mar 2019 19:54:53 +0100
Message-ID: <1552330521-4276-14-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-iop.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-iop.c b/drivers/gpio/gpio-iop.c
index 8d62db4..11b77d8 100644
--- a/drivers/gpio/gpio-iop.c
+++ b/drivers/gpio/gpio-iop.c
@@ -21,7 +21,6 @@
 
 static int iop3xx_gpio_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	struct gpio_chip *gc;
 	void __iomem *base;
 	int err;
@@ -30,8 +29,7 @@ static int iop3xx_gpio_probe(struct platform_device *pdev)
 	if (!gc)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
1.9.1
