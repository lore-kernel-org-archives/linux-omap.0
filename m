From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 30/30] drivers: gpio: max732x: use subsys_i2c_driver()
Date: Mon, 17 Jun 2019 20:41:11 +0200
Message-ID: <1560796871-18560-30-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-max732x.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-max732x.c b/drivers/gpio/gpio-max732x.c
index 5e4102e..c340883 100644
--- a/drivers/gpio/gpio-max732x.c
+++ b/drivers/gpio/gpio-max732x.c
@@ -756,21 +756,10 @@ static int max732x_remove(struct i2c_client *client)
 	.remove		= max732x_remove,
 	.id_table	= max732x_id,
 };
-
-static int __init max732x_init(void)
-{
-	return i2c_add_driver(&max732x_driver);
-}
 /* register after i2c postcore initcall and before
  * subsys initcalls that may rely on these GPIOs
  */
-subsys_initcall(max732x_init);
-
-static void __exit max732x_exit(void)
-{
-	i2c_del_driver(&max732x_driver);
-}
-module_exit(max732x_exit);
+subsys_i2c_driver(max732x_driver);
 
 MODULE_AUTHOR("Eric Miao <eric.miao@marvell.com>");
 MODULE_DESCRIPTION("GPIO expander driver for MAX732X");
-- 
1.9.1
