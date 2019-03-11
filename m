From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 20/42] drivers: gpio: mt7621: use devm_platform_ioremap_resource()
Date: Mon, 11 Mar 2019 19:54:59 +0100
Message-ID: <1552330521-4276-20-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-mt7621.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
index 74401e0..79654fb 100644
--- a/drivers/gpio/gpio-mt7621.c
+++ b/drivers/gpio/gpio-mt7621.c
@@ -293,7 +293,6 @@ struct mtk {
 static int
 mediatek_gpio_probe(struct platform_device *pdev)
 {
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct mtk *mtk;
@@ -304,7 +303,7 @@ struct mtk {
 	if (!mtk)
 		return -ENOMEM;
 
-	mtk->base = devm_ioremap_resource(dev, res);
+	mtk->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mtk->base))
 		return PTR_ERR(mtk->base);
 
-- 
1.9.1
