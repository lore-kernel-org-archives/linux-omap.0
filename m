From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH] drivers: gpio: omap: use devm_platform_ioremap_resource()
Date: Mon, 11 Mar 2019 20:50:05 +0100
Message-ID: <1552333805-23235-1-git-send-email-info@metux.net>
References: <d3b12ed4-67e6-2993-4f56-80b1be572a24@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d3b12ed4-67e6-2993-4f56-80b1be572a24@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-omap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 7f33024..ce6e67a 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1289,7 +1289,6 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	struct device_node *node = dev->of_node;
 	const struct of_device_id *match;
 	const struct omap_gpio_platform_data *pdata;
-	struct resource *res;
 	struct gpio_bank *bank;
 	struct irq_chip *irqc;
 	int ret;
@@ -1375,8 +1374,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	raw_spin_lock_init(&bank->wa_lock);
 
 	/* Static mapping, never released */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	bank->base = devm_ioremap_resource(dev, res);
+	bank->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(bank->base)) {
 		return PTR_ERR(bank->base);
 	}
-- 
1.9.1
