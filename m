From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 21/30] drivers: gpio: xilinx: use subsys_platform_driver()
Date: Mon, 17 Jun 2019 20:41:02 +0200
Message-ID: <1560796871-18560-21-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-xilinx.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index 32944eb..255facc 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -376,19 +376,7 @@ static int xgpio_probe(struct platform_device *pdev)
 			.of_match_table	= xgpio_of_match,
 	},
 };
-
-static int __init xgpio_init(void)
-{
-	return platform_driver_register(&xgpio_plat_driver);
-}
-
-subsys_initcall(xgpio_init);
-
-static void __exit xgpio_exit(void)
-{
-	platform_driver_unregister(&xgpio_plat_driver);
-}
-module_exit(xgpio_exit);
+subsys_platform_driver(xgpio_plat_driver);
 
 MODULE_AUTHOR("Xilinx, Inc.");
 MODULE_DESCRIPTION("Xilinx GPIO driver");
-- 
1.9.1
