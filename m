From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 12/30] drivers: gpio: stp-xway: use subsys_platform_driver()
Date: Mon, 17 Jun 2019 20:40:53 +0200
Message-ID: <1560796871-18560-12-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-stp-xway.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-stp-xway.c b/drivers/gpio/gpio-stp-xway.c
index 8a319d5..3f5c039 100644
--- a/drivers/gpio/gpio-stp-xway.c
+++ b/drivers/gpio/gpio-stp-xway.c
@@ -291,10 +291,4 @@ static int xway_stp_probe(struct platform_device *pdev)
 		.of_match_table = xway_stp_match,
 	},
 };
-
-static int __init xway_stp_init(void)
-{
-	return platform_driver_register(&xway_stp_driver);
-}
-
-subsys_initcall(xway_stp_init);
+subsys_platform_driver(xway_stp_driver);
-- 
1.9.1
