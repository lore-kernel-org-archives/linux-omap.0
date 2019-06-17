From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 26/30] drivers: gpio: zynq: use postcore_platform_driver()
Date: Mon, 17 Jun 2019 20:41:07 +0200
Message-ID: <1560796871-18560-26-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-zynq.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index f241b6c..30ad4ee 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -952,22 +952,7 @@ static int zynq_gpio_remove(struct platform_device *pdev)
 	.remove = zynq_gpio_remove,
 };
 
-/**
- * zynq_gpio_init - Initial driver registration call
- *
- * Return: value from platform_driver_register
- */
-static int __init zynq_gpio_init(void)
-{
-	return platform_driver_register(&zynq_gpio_driver);
-}
-postcore_initcall(zynq_gpio_init);
-
-static void __exit zynq_gpio_exit(void)
-{
-	platform_driver_unregister(&zynq_gpio_driver);
-}
-module_exit(zynq_gpio_exit);
+postcore_platform_driver(zynq_gpio_driver);
 
 MODULE_AUTHOR("Xilinx Inc.");
 MODULE_DESCRIPTION("Zynq GPIO driver");
-- 
1.9.1
