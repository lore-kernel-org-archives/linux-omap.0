From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 19/30] drivers: gpio: wm8350: use subsys_platform_driver()
Date: Mon, 17 Jun 2019 20:41:00 +0200
Message-ID: <1560796871-18560-19-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-wm8350.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-wm8350.c b/drivers/gpio/gpio-wm8350.c
index 460f0a4..21a3191 100644
--- a/drivers/gpio/gpio-wm8350.c
+++ b/drivers/gpio/gpio-wm8350.c
@@ -137,18 +137,7 @@ static int wm8350_gpio_probe(struct platform_device *pdev)
 	.driver.name	= "wm8350-gpio",
 	.probe		= wm8350_gpio_probe,
 };
-
-static int __init wm8350_gpio_init(void)
-{
-	return platform_driver_register(&wm8350_gpio_driver);
-}
-subsys_initcall(wm8350_gpio_init);
-
-static void __exit wm8350_gpio_exit(void)
-{
-	platform_driver_unregister(&wm8350_gpio_driver);
-}
-module_exit(wm8350_gpio_exit);
+subsys_platform_driver(wm8350_gpio_driver);
 
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
 MODULE_DESCRIPTION("GPIO interface for WM8350 PMICs");
-- 
1.9.1
