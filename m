From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 17/30] drivers: gpio: twl4030: use subsys_platform_driver()
Date: Mon, 17 Jun 2019 20:40:58 +0200
Message-ID: <1560796871-18560-17-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-twl4030.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.c
index fbfb648..0c9a86f 100644
--- a/drivers/gpio/gpio-twl4030.c
+++ b/drivers/gpio/gpio-twl4030.c
@@ -633,18 +633,7 @@ static int gpio_twl4030_remove(struct platform_device *pdev)
 	.probe		= gpio_twl4030_probe,
 	.remove		= gpio_twl4030_remove,
 };
-
-static int __init gpio_twl4030_init(void)
-{
-	return platform_driver_register(&gpio_twl4030_driver);
-}
-subsys_initcall(gpio_twl4030_init);
-
-static void __exit gpio_twl4030_exit(void)
-{
-	platform_driver_unregister(&gpio_twl4030_driver);
-}
-module_exit(gpio_twl4030_exit);
+subsys_platform_driver(gpio_twl4030_driver);
 
 MODULE_AUTHOR("Texas Instruments, Inc.");
 MODULE_DESCRIPTION("GPIO interface for TWL4030");
-- 
1.9.1
