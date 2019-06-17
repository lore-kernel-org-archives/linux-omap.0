From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 25/30] drivers: gpio: omap: use postcore_platform_driver()
Date: Mon, 17 Jun 2019 20:41:06 +0200
Message-ID: <1560796871-18560-25-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-omap.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 16289ba..3ea02d3 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1693,17 +1693,7 @@ static int __maybe_unused omap_gpio_runtime_resume(struct device *dev)
  * machine_init functions access gpio APIs.
  * Hence omap_gpio_drv_reg() is a postcore_initcall.
  */
-static int __init omap_gpio_drv_reg(void)
-{
-	return platform_driver_register(&omap_gpio_driver);
-}
-postcore_initcall(omap_gpio_drv_reg);
-
-static void __exit omap_gpio_exit(void)
-{
-	platform_driver_unregister(&omap_gpio_driver);
-}
-module_exit(omap_gpio_exit);
+postcore_platform_driver(omap_gpio_driver);
 
 MODULE_DESCRIPTION("omap gpio driver");
 MODULE_ALIAS("platform:gpio-omap");
-- 
1.9.1
