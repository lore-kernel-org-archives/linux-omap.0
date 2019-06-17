From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 03/30] drivers: gpio: da9055: use subsys_platform_driver()
Date: Mon, 17 Jun 2019 20:40:44 +0200
Message-ID: <1560796871-18560-3-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-da9055.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-da9055.c b/drivers/gpio/gpio-da9055.c
index 6ad0c37..d93f8ba 100644
--- a/drivers/gpio/gpio-da9055.c
+++ b/drivers/gpio/gpio-da9055.c
@@ -163,18 +163,7 @@ static int da9055_gpio_probe(struct platform_device *pdev)
 		.name	= "da9055-gpio",
 	},
 };
-
-static int __init da9055_gpio_init(void)
-{
-	return platform_driver_register(&da9055_gpio_driver);
-}
-subsys_initcall(da9055_gpio_init);
-
-static void __exit da9055_gpio_exit(void)
-{
-	platform_driver_unregister(&da9055_gpio_driver);
-}
-module_exit(da9055_gpio_exit);
+subsys_platform_driver(da9055_gpio_driver);
 
 MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
 MODULE_DESCRIPTION("DA9055 GPIO Device Driver");
-- 
1.9.1
