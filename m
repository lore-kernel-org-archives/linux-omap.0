From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 29/30] drivers: gpio: max7300: use arch_platform_driver()
Date: Mon, 17 Jun 2019 20:41:10 +0200
Message-ID: <1560796871-18560-29-git-send-email-info@metux.net>
References: <1560796871-18560-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1560796871-18560-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: thloh@altera.com, linus.walleij@linaro.org, bgolaszewski@baylibre.com, andriy.shevchenko@linux.intel.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org, patches@opensource.cirrus.com
List-Id: linux-omap@vger.kernel.org

From: Enrico Weigelt <info@metux.net>

Reduce driver init boilerplate by using the new
subsys_i2c_driver() macro.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/gpio/gpio-max7300.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-max7300.c b/drivers/gpio/gpio-max7300.c
index 1ae9ba8..36d5afa 100644
--- a/drivers/gpio/gpio-max7300.c
+++ b/drivers/gpio/gpio-max7300.c
@@ -70,18 +70,7 @@ static int max7300_remove(struct i2c_client *client)
 	.remove = max7300_remove,
 	.id_table = max7300_id,
 };
-
-static int __init max7300_init(void)
-{
-	return i2c_add_driver(&max7300_driver);
-}
-subsys_initcall(max7300_init);
-
-static void __exit max7300_exit(void)
-{
-	i2c_del_driver(&max7300_driver);
-}
-module_exit(max7300_exit);
+subsys_i2c_driver(max7300_driver);
 
 MODULE_AUTHOR("Wolfram Sang");
 MODULE_LICENSE("GPL v2");
-- 
1.9.1
