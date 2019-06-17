From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 15/30] drivers: gpio: tps6586x: use subsys_platform_driver()
Date: Mon, 17 Jun 2019 20:40:56 +0200
Message-ID: <1560796871-18560-15-git-send-email-info@metux.net>
References: <1560796871-18560-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1560796871-18560-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: thloh@altera.com, linus.walleij@linaro.org, bgolaszewski@baylibre.com, andriy.shevchenko@linux.intel.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org, patches@opensource.cirrus.com
List-Id: linux-omap@vger.kernel.org

From: Enrico Weigelt <info@metux.net>

Reduce driver init boilerplate by using the new
subsys_platform_driver() macro.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/gpio/gpio-tps6586x.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-tps6586x.c b/drivers/gpio/gpio-tps6586x.c
index 9b6cc74..8f75718 100644
--- a/drivers/gpio/gpio-tps6586x.c
+++ b/drivers/gpio/gpio-tps6586x.c
@@ -122,9 +122,4 @@ static int tps6586x_gpio_probe(struct platform_device *pdev)
 	.driver.name	= "tps6586x-gpio",
 	.probe		= tps6586x_gpio_probe,
 };
-
-static int __init tps6586x_gpio_init(void)
-{
-	return platform_driver_register(&tps6586x_gpio_driver);
-}
-subsys_initcall(tps6586x_gpio_init);
+subsys_platform_driver(tps6586x_gpio_driver);
-- 
1.9.1
