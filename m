From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 22/42] drivers: gpio: mxc: use devm_platform_ioremap_resource()
Date: Mon, 11 Mar 2019 19:55:01 +0100
Message-ID: <1552330521-4276-22-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-mxc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index e86e61d..b281358 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -411,7 +411,6 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct mxc_gpio_port *port;
-	struct resource *iores;
 	int irq_base;
 	int err;
 
@@ -423,8 +422,7 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 
 	port->dev = &pdev->dev;
 
-	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	port->base = devm_ioremap_resource(&pdev->dev, iores);
+	port->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(port->base))
 		return PTR_ERR(port->base);
 
-- 
1.9.1
