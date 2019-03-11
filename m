From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 12/42] drivers: gpio: grgpio: use devm_platform_ioremap_resource()
Date: Mon, 11 Mar 2019 19:54:51 +0100
Message-ID: <1552330521-4276-12-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-grgpio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-grgpio.c b/drivers/gpio/gpio-grgpio.c
index 45b8d6a..09d3dac 100644
--- a/drivers/gpio/gpio-grgpio.c
+++ b/drivers/gpio/gpio-grgpio.c
@@ -333,7 +333,6 @@ static int grgpio_probe(struct platform_device *ofdev)
 	void  __iomem *regs;
 	struct gpio_chip *gc;
 	struct grgpio_priv *priv;
-	struct resource *res;
 	int err;
 	u32 prop;
 	s32 *irqmap;
@@ -344,8 +343,7 @@ static int grgpio_probe(struct platform_device *ofdev)
 	if (!priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
-	regs = devm_ioremap_resource(&ofdev->dev, res);
+	regs = devm_platform_ioremap_resource(&ofdev, 0);
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
-- 
1.9.1
