From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 15/42] drivers: gpio: janz-ttl: use devm_platform_ioremap_resource()
Date: Mon, 11 Mar 2019 19:54:54 +0100
Message-ID: <1552330521-4276-15-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-janz-ttl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-janz-ttl.c b/drivers/gpio/gpio-janz-ttl.c
index 6b9bf8b..b97a911 100644
--- a/drivers/gpio/gpio-janz-ttl.c
+++ b/drivers/gpio/gpio-janz-ttl.c
@@ -147,7 +147,6 @@ static int ttl_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct ttl_module *mod;
 	struct gpio_chip *gpio;
-	struct resource *res;
 	int ret;
 
 	pdata = dev_get_platdata(&pdev->dev);
@@ -164,8 +163,7 @@ static int ttl_probe(struct platform_device *pdev)
 	spin_lock_init(&mod->lock);
 
 	/* get access to the MODULbus registers for this module */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mod->regs = devm_ioremap_resource(dev, res);
+	mod->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mod->regs))
 		return PTR_ERR(mod->regs);
 
-- 
1.9.1
