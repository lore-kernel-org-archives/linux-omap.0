From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 22/30] drivers: gpio: em: use postcore_platform_driver()
Date: Mon, 17 Jun 2019 20:41:03 +0200
Message-ID: <1560796871-18560-22-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-em.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-em.c b/drivers/gpio/gpio-em.c
index 84a7375..8b8037c 100644
--- a/drivers/gpio/gpio-em.c
+++ b/drivers/gpio/gpio-em.c
@@ -396,18 +396,7 @@ static int em_gio_remove(struct platform_device *pdev)
 		.of_match_table = em_gio_dt_ids,
 	}
 };
-
-static int __init em_gio_init(void)
-{
-	return platform_driver_register(&em_gio_device_driver);
-}
-postcore_initcall(em_gio_init);
-
-static void __exit em_gio_exit(void)
-{
-	platform_driver_unregister(&em_gio_device_driver);
-}
-module_exit(em_gio_exit);
+postcore_platform_driver(em_gio_device_driver);
 
 MODULE_AUTHOR("Magnus Damm");
 MODULE_DESCRIPTION("Renesas Emma Mobile GIO Driver");
-- 
1.9.1
