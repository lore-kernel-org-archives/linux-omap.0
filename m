From: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Subject: [PATCH] regulator: twl6030: add dependency on OF
Date: Fri, 25 Nov 2016 09:43:35 +0200
Message-ID: <20161125074335.6947-1-Nicolae_Rosia@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolae Rosia <Nicolae_Rosia@mentor.com>
List-Id: linux-omap@vger.kernel.org

This driver was converted to device tree only,
add dependency on OF symbol and drop of_match_ptr

Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
---
 drivers/regulator/Kconfig             | 1 +
 drivers/regulator/twl6030-regulator.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 936f7cc..ef70672 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -839,6 +839,7 @@ config REGULATOR_TPS80031
 config REGULATOR_TWL4030
 	tristate "TI TWL4030/TWL5030/TWL6030/TPS659x0 PMIC"
 	depends on TWL4030_CORE
+	depends on OF
 	help
 	  This driver supports the voltage regulators provided by
 	  this family of companion chips.
diff --git a/drivers/regulator/twl6030-regulator.c b/drivers/regulator/twl6030-regulator.c
index 4864b9d..1f327d7 100644
--- a/drivers/regulator/twl6030-regulator.c
+++ b/drivers/regulator/twl6030-regulator.c
@@ -773,7 +773,7 @@ static struct platform_driver twlreg_driver = {
 	 */
 	.driver  = {
 		.name  = "twl6030_reg",
-		.of_match_table = of_match_ptr(twl_of_match),
+		.of_match_table = twl_of_match,
 	},
 };
 
-- 
2.9.3
