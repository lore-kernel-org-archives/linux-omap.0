From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 06/30] drivers: gpio: lantiq: use subsys_platform_driver()
Date: Mon, 17 Jun 2019 20:40:47 +0200
Message-ID: <1560796871-18560-6-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-mm-lantiq.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/gpio/gpio-mm-lantiq.c b/drivers/gpio/gpio-mm-lantiq.c
index b0754fe..3e5ef46 100644
--- a/drivers/gpio/gpio-mm-lantiq.c
+++ b/drivers/gpio/gpio-mm-lantiq.c
@@ -146,16 +146,4 @@ static int ltq_mm_remove(struct platform_device *pdev)
 		.of_match_table = ltq_mm_match,
 	},
 };
-
-static int __init ltq_mm_init(void)
-{
-	return platform_driver_register(&ltq_mm_driver);
-}
-
-subsys_initcall(ltq_mm_init);
-
-static void __exit ltq_mm_exit(void)
-{
-	platform_driver_unregister(&ltq_mm_driver);
-}
-module_exit(ltq_mm_exit);
+subsys_platform_driver(ltq_mm_driver);
-- 
1.9.1
