From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 13/42] drivers: gpio: hlwd: use devm_platform_ioremap_resource()
Date: Mon, 11 Mar 2019 19:54:52 +0100
Message-ID: <1552330521-4276-13-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-hlwd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-hlwd.c b/drivers/gpio/gpio-hlwd.c
index a7b1789..e5fa00f 100644
--- a/drivers/gpio/gpio-hlwd.c
+++ b/drivers/gpio/gpio-hlwd.c
@@ -208,7 +208,6 @@ static int hlwd_gpio_irq_set_type(struct irq_data *data, unsigned int flow_type)
 static int hlwd_gpio_probe(struct platform_device *pdev)
 {
 	struct hlwd_gpio *hlwd;
-	struct resource *regs_resource;
 	u32 ngpios;
 	int res;
 
@@ -216,8 +215,7 @@ static int hlwd_gpio_probe(struct platform_device *pdev)
 	if (!hlwd)
 		return -ENOMEM;
 
-	regs_resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hlwd->regs = devm_ioremap_resource(&pdev->dev, regs_resource);
+	hlwd->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hlwd->regs))
 		return PTR_ERR(hlwd->regs);
 
-- 
1.9.1
