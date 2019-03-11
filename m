From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 01/42] drivers: gpio: 74xx-mmio: use devm_platform_ioremap_resource()
Date: Mon, 11 Mar 2019 19:54:40 +0100
Message-ID: <1552330521-4276-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linus.walleij@linaro.org, bgolaszewski@baylibre.com, andrew@aj.id.au, f.fainelli@gmail.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com, orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com, keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com, thierry.reding@gmail.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, robert.jarzmik@free.fr, yamada.masahiro@socionext.com, jun.nie@linaro.org, shawnguo@kernel.org, linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-74xx-mmio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-74xx-mmio.c b/drivers/gpio/gpio-74xx-mmio.c
index 49616ec..0424707 100644
--- a/drivers/gpio/gpio-74xx-mmio.c
+++ b/drivers/gpio/gpio-74xx-mmio.c
@@ -106,7 +106,6 @@ static int mmio_74xx_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 static int mmio_74xx_gpio_probe(struct platform_device *pdev)
 {
 	struct mmio_74xx_gpio_priv *priv;
-	struct resource *res;
 	void __iomem *dat;
 	int err;
 
@@ -116,8 +115,7 @@ static int mmio_74xx_gpio_probe(struct platform_device *pdev)
 
 	priv->flags = (uintptr_t)of_device_get_match_data(&pdev->dev);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dat = devm_ioremap_resource(&pdev->dev, res);
+	dat = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dat))
 		return PTR_ERR(dat);
 
-- 
1.9.1
