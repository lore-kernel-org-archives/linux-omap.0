From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 28/30] drivers: gpio: mpc8xxx: use arch_platform_driver()
Date: Mon, 17 Jun 2019 20:41:09 +0200
Message-ID: <1560796871-18560-28-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-mpc8xxx.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
index c8673a5..6eef9b8 100644
--- a/drivers/gpio/gpio-mpc8xxx.c
+++ b/drivers/gpio/gpio-mpc8xxx.c
@@ -408,10 +408,4 @@ static int mpc8xxx_remove(struct platform_device *pdev)
 		.of_match_table	= mpc8xxx_gpio_ids,
 	},
 };
-
-static int __init mpc8xxx_init(void)
-{
-	return platform_driver_register(&mpc8xxx_plat_driver);
-}
-
-arch_initcall(mpc8xxx_init);
+arch_platform_driver(mpc8xxx_plat_driver);
-- 
1.9.1
