From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 42/42] drivers: gpio: use devm_platform_ioremap_resource()
Date: Mon, 11 Mar 2019 19:55:21 +0100
Message-ID: <1552330521-4276-42-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-zynq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 00ff7b1..9392eda 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -834,7 +834,6 @@ static int zynq_gpio_probe(struct platform_device *pdev)
 	int ret, bank_num;
 	struct zynq_gpio *gpio;
 	struct gpio_chip *chip;
-	struct resource *res;
 	const struct of_device_id *match;
 
 	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
@@ -849,8 +848,7 @@ static int zynq_gpio_probe(struct platform_device *pdev)
 	gpio->p_data = match->data;
 	platform_set_drvdata(pdev, gpio);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	gpio->base_addr = devm_ioremap_resource(&pdev->dev, res);
+	gpio->base_addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(gpio->base_addr))
 		return PTR_ERR(gpio->base_addr);
 
-- 
1.9.1
