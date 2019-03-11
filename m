From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 31/42] drivers: gpio: stp-xway: use devm_platform_ioremap_resource()
Date: Mon, 11 Mar 2019 19:55:10 +0100
Message-ID: <1552330521-4276-31-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-stp-xway.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-stp-xway.c b/drivers/gpio/gpio-stp-xway.c
index 1997208..8a319d5 100644
--- a/drivers/gpio/gpio-stp-xway.c
+++ b/drivers/gpio/gpio-stp-xway.c
@@ -210,7 +210,6 @@ static int xway_stp_hw_init(struct xway_stp *chip)
 
 static int xway_stp_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	u32 shadow, groups, dsl, phy;
 	struct xway_stp *chip;
 	struct clk *clk;
@@ -220,8 +219,7 @@ static int xway_stp_probe(struct platform_device *pdev)
 	if (!chip)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	chip->virt = devm_ioremap_resource(&pdev->dev, res);
+	chip->virt = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(chip->virt))
 		return PTR_ERR(chip->virt);
 
-- 
1.9.1
