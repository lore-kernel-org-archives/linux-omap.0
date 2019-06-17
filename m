From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 05/30] drivers: gpio: lynxpoint: use subsys_platform_driver()
Date: Mon, 17 Jun 2019 20:40:46 +0200
Message-ID: <1560796871-18560-5-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-lynxpoint.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/gpio/gpio-lynxpoint.c b/drivers/gpio/gpio-lynxpoint.c
index 31b4a09..8e6b998 100644
--- a/drivers/gpio/gpio-lynxpoint.c
+++ b/drivers/gpio/gpio-lynxpoint.c
@@ -438,19 +438,7 @@ static int lp_gpio_remove(struct platform_device *pdev)
 		.acpi_match_table = ACPI_PTR(lynxpoint_gpio_acpi_match),
 	},
 };
-
-static int __init lp_gpio_init(void)
-{
-	return platform_driver_register(&lp_gpio_driver);
-}
-
-static void __exit lp_gpio_exit(void)
-{
-	platform_driver_unregister(&lp_gpio_driver);
-}
-
-subsys_initcall(lp_gpio_init);
-module_exit(lp_gpio_exit);
+subsys_platform_driver(lp_gpio_driver);
 
 MODULE_AUTHOR("Mathias Nyman (Intel)");
 MODULE_DESCRIPTION("GPIO interface for Intel Lynxpoint");
-- 
1.9.1
