From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 27/30] drivers: gpio: iop: use arch_platform_driver()
Date: Mon, 17 Jun 2019 20:41:08 +0200
Message-ID: <1560796871-18560-27-git-send-email-info@metux.net>
References: <1560796871-18560-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1560796871-18560-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: thloh@altera.com, linus.walleij@linaro.org, bgolaszewski@baylibre.com, andriy.shevchenko@linux.intel.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org, patches@opensource.cirrus.com
List-Id: linux-omap@vger.kernel.org

From: Enrico Weigelt <info@metux.net>

Reduce driver init boilerplate by using the new
arch_platform_driver() macro.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/gpio/gpio-iop.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-iop.c b/drivers/gpio/gpio-iop.c
index e355c59..651ab5a 100644
--- a/drivers/gpio/gpio-iop.c
+++ b/drivers/gpio/gpio-iop.c
@@ -46,12 +46,7 @@ static int iop3xx_gpio_probe(struct platform_device *pdev)
 	},
 	.probe = iop3xx_gpio_probe,
 };
-
-static int __init iop3xx_gpio_init(void)
-{
-	return platform_driver_register(&iop3xx_gpio_driver);
-}
-arch_initcall(iop3xx_gpio_init);
+arch_platform_driver(iop3xx_gpio_init);
 
 MODULE_DESCRIPTION("GPIO handling for Intel IOP3xx processors");
 MODULE_AUTHOR("Lennert Buytenhek <buytenh@wantstofly.org>");
-- 
1.9.1
