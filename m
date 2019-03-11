From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 33/42] drivers: gpio: tegra: use devm_platform_ioremap_resource()
Date: Mon, 11 Mar 2019 19:55:12 +0100
Message-ID: <1552330521-4276-33-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-tegra.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 1ececf2..6d9b690 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -569,7 +569,6 @@ static inline void tegra_gpio_debuginit(struct tegra_gpio_info *tgi)
 static int tegra_gpio_probe(struct platform_device *pdev)
 {
 	struct tegra_gpio_info *tgi;
-	struct resource *res;
 	struct tegra_gpio_bank *bank;
 	unsigned int gpio, i, j;
 	int ret;
@@ -645,8 +644,7 @@ static int tegra_gpio_probe(struct platform_device *pdev)
 		bank->tgi = tgi;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	tgi->regs = devm_ioremap_resource(&pdev->dev, res);
+	tgi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(tgi->regs))
 		return PTR_ERR(tgi->regs);
 
-- 
1.9.1
