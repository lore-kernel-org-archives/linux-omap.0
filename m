From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 23/30] drivers: gpio: ep93xx: use postcore_platform_driver()
Date: Mon, 17 Jun 2019 20:41:04 +0200
Message-ID: <1560796871-18560-23-git-send-email-info@metux.net>
References: <1560796871-18560-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1560796871-18560-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: thloh@altera.com, linus.walleij@linaro.org, bgolaszewski@baylibre.com, andriy.shevchenko@linux.intel.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org, patches@opensource.cirrus.com
List-Id: linux-omap@vger.kernel.org

From: Enrico Weigelt <info@metux.net>

Reduce driver init boilerplate by using the new
postcore_platform_driver() macro.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/gpio/gpio-ep93xx.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
index 71728d6..d4dfb50 100644
--- a/drivers/gpio/gpio-ep93xx.c
+++ b/drivers/gpio/gpio-ep93xx.c
@@ -429,12 +429,7 @@ static int ep93xx_gpio_probe(struct platform_device *pdev)
 	},
 	.probe		= ep93xx_gpio_probe,
 };
-
-static int __init ep93xx_gpio_init(void)
-{
-	return platform_driver_register(&ep93xx_gpio_driver);
-}
-postcore_initcall(ep93xx_gpio_init);
+postcore_platform_driver(ep93xx_gpio_driver);
 
 MODULE_AUTHOR("Ryan Mallon <ryan@bluewatersys.com> "
 		"H Hartley Sweeten <hsweeten@visionengravers.com>");
-- 
1.9.1
