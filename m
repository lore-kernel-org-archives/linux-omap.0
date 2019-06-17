From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 04/30] drivers: gpio: htc-egpio: use subsys_platform_driver()
Date: Mon, 17 Jun 2019 20:40:45 +0200
Message-ID: <1560796871-18560-4-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-htc-egpio.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-htc-egpio.c b/drivers/gpio/gpio-htc-egpio.c
index 9d3ac51..cc7a655 100644
--- a/drivers/gpio/gpio-htc-egpio.c
+++ b/drivers/gpio/gpio-htc-egpio.c
@@ -422,10 +422,4 @@ static int egpio_resume(struct platform_device *pdev)
 	.suspend      = egpio_suspend,
 	.resume       = egpio_resume,
 };
-
-static int __init egpio_init(void)
-{
-	return platform_driver_probe(&egpio_driver, egpio_probe);
-}
-/* start early for dependencies */
-subsys_initcall(egpio_init);
+subsys_platform_driver(egpio_driver);
-- 
1.9.1
