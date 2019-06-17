From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 02/30] drivers: gpio: altera: use subsys_platform_driver()
Date: Mon, 17 Jun 2019 20:40:43 +0200
Message-ID: <1560796871-18560-2-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-altera.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-altera.c b/drivers/gpio/gpio-altera.c
index e088b90..b757c650 100644
--- a/drivers/gpio/gpio-altera.c
+++ b/drivers/gpio/gpio-altera.c
@@ -342,18 +342,7 @@ static int altera_gpio_remove(struct platform_device *pdev)
 	.probe		= altera_gpio_probe,
 	.remove		= altera_gpio_remove,
 };
-
-static int __init altera_gpio_init(void)
-{
-	return platform_driver_register(&altera_gpio_driver);
-}
-subsys_initcall(altera_gpio_init);
-
-static void __exit altera_gpio_exit(void)
-{
-	platform_driver_unregister(&altera_gpio_driver);
-}
-module_exit(altera_gpio_exit);
+subsys_platform_driver(altera_gpio_driver);
 
 MODULE_AUTHOR("Tien Hock Loh <thloh@altera.com>");
 MODULE_DESCRIPTION("Altera GPIO driver");
-- 
1.9.1
