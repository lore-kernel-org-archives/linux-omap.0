From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 18/42] drivers: gpio: lpc18xx: use devm_platform_ioremap_resource()
Date: Mon, 11 Mar 2019 19:54:57 +0100
Message-ID: <1552330521-4276-18-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-lpc18xx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-lpc18xx.c b/drivers/gpio/gpio-lpc18xx.c
index d441dba..d711ae0 100644
--- a/drivers/gpio/gpio-lpc18xx.c
+++ b/drivers/gpio/gpio-lpc18xx.c
@@ -340,10 +340,7 @@ static int lpc18xx_gpio_probe(struct platform_device *pdev)
 	index = of_property_match_string(dev->of_node, "reg-names", "gpio");
 	if (index < 0) {
 		/* To support backward compatibility take the first resource */
-		struct resource *res;
-
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		gc->base = devm_ioremap_resource(dev, res);
+		gc->base = devm_platform_ioremap_resource(pdev, 0);
 	} else {
 		struct resource res;
 
-- 
1.9.1
