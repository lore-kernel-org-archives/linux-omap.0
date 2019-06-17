From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 09/30] drivers: gpio: rc5t583: use subsys_platform_driver()
Date: Mon, 17 Jun 2019 20:40:50 +0200
Message-ID: <1560796871-18560-9-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-rc5t583.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-rc5t583.c b/drivers/gpio/gpio-rc5t583.c
index 4fae3eb..d0dd3c2 100644
--- a/drivers/gpio/gpio-rc5t583.c
+++ b/drivers/gpio/gpio-rc5t583.c
@@ -133,9 +133,4 @@ static int rc5t583_gpio_probe(struct platform_device *pdev)
 	},
 	.probe		= rc5t583_gpio_probe,
 };
-
-static int __init rc5t583_gpio_init(void)
-{
-	return platform_driver_register(&rc5t583_gpio_driver);
-}
-subsys_initcall(rc5t583_gpio_init);
+subsys_platform_driver(rc5t583_gpio_driver);
-- 
1.9.1
