From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 41/42] drivers: gpio: xlp: devm_platform_ioremap_resource()
Date: Mon, 11 Mar 2019 19:55:20 +0100
Message-ID: <1552330521-4276-41-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-xlp.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-xlp.c b/drivers/gpio/gpio-xlp.c
index 0a3607f..54d3359 100644
--- a/drivers/gpio/gpio-xlp.c
+++ b/drivers/gpio/gpio-xlp.c
@@ -290,22 +290,17 @@ static void xlp_gpio_set(struct gpio_chip *gc, unsigned gpio, int state)
 static int xlp_gpio_probe(struct platform_device *pdev)
 {
 	struct gpio_chip *gc;
-	struct resource *iores;
 	struct xlp_gpio_priv *priv;
 	void __iomem *gpio_base;
 	int irq_base, irq, err;
 	int ngpio;
 	u32 soc_type;
 
-	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!iores)
-		return -ENODEV;
-
 	priv = devm_kzalloc(&pdev->dev,	sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	gpio_base = devm_ioremap_resource(&pdev->dev, iores);
+	gpio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(gpio_base))
 		return PTR_ERR(gpio_base);
 
-- 
1.9.1
