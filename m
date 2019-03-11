From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 03/42] drivers: gpio: amdpt: drop unneeded deref of &pdev->dev
Date: Mon, 11 Mar 2019 19:54:42 +0100
Message-ID: <1552330521-4276-3-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linus.walleij@linaro.org, bgolaszewski@baylibre.com, andrew@aj.id.au, f.fainelli@gmail.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com, orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com, keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com, thierry.reding@gmail.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, robert.jarzmik@free.fr, yamada.masahiro@socionext.com, jun.nie@linaro.org, shawnguo@kernel.org, linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

We already have the struct device* pointer in a local variable,
so we can write this a bit shorter.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-amdpt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-amdpt.c b/drivers/gpio/gpio-amdpt.c
index 1ffd7c2..3220f3c 100644
--- a/drivers/gpio/gpio-amdpt.c
+++ b/drivers/gpio/gpio-amdpt.c
@@ -91,7 +91,7 @@ static int pt_gpio_probe(struct platform_device *pdev)
 
 	pt_gpio->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pt_gpio->reg_base)) {
-		dev_err(&pdev->dev, "Failed to map MMIO resource for PT GPIO.\n");
+		dev_err(dev, "Failed to map MMIO resource for PT GPIO.\n");
 		return PTR_ERR(pt_gpio->reg_base);
 	}
 
@@ -101,7 +101,7 @@ static int pt_gpio_probe(struct platform_device *pdev)
 			 pt_gpio->reg_base + PT_DIRECTION_REG, NULL,
 			 BGPIOF_READ_OUTPUT_REG_SET);
 	if (ret) {
-		dev_err(&pdev->dev, "bgpio_init failed\n");
+		dev_err(dev, "bgpio_init failed\n");
 		return ret;
 	}
 
@@ -110,11 +110,11 @@ static int pt_gpio_probe(struct platform_device *pdev)
 	pt_gpio->gc.free             = pt_gpio_free;
 	pt_gpio->gc.ngpio            = PT_TOTAL_GPIO;
 #if defined(CONFIG_OF_GPIO)
-	pt_gpio->gc.of_node          = pdev->dev.of_node;
+	pt_gpio->gc.of_node          = dev.of_node;
 #endif
 	ret = gpiochip_add_data(&pt_gpio->gc, pt_gpio);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to register GPIO lib\n");
+		dev_err(dev, "Failed to register GPIO lib\n");
 		return ret;
 	}
 
@@ -124,7 +124,7 @@ static int pt_gpio_probe(struct platform_device *pdev)
 	writel(0, pt_gpio->reg_base + PT_SYNC_REG);
 	writel(0, pt_gpio->reg_base + PT_CLOCKRATE_REG);
 
-	dev_dbg(&pdev->dev, "PT GPIO driver loaded\n");
+	dev_dbg(dev, "PT GPIO driver loaded\n");
 	return ret;
 }
 
-- 
1.9.1
