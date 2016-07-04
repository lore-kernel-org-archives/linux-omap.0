From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 10/10] clk: ti: make clk-dra7-atl explicitly non-modular
Date: Mon, 4 Jul 2016 17:12:20 -0400
Message-ID: <20160704211220.5685-11-paul.gortmaker@windriver.com>
References: <20160704211220.5685-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160704211220.5685-1-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Tero Kristo <t-kristo@ti.com>, Michael Turquette <mturquette@baylibre.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

arch/arm/mach-omap2/Kconfig:config SOC_DRA7XX
arch/arm/mach-omap2/Kconfig:    bool "TI DRA7XX"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tags etc. since all that information
is already contained at the top of the file in the comments.

Cc: Tero Kristo <t-kristo@ti.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-omap@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/clk/ti/clk-dra7-atl.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/ti/clk-dra7-atl.c b/drivers/clk/ti/clk-dra7-atl.c
index c77333230bdf..45d05339d583 100644
--- a/drivers/clk/ti/clk-dra7-atl.c
+++ b/drivers/clk/ti/clk-dra7-atl.c
@@ -15,7 +15,7 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/slab.h>
@@ -295,31 +295,17 @@ static int of_dra7_atl_clk_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int of_dra7_atl_clk_remove(struct platform_device *pdev)
-{
-	pm_runtime_disable(&pdev->dev);
-
-	return 0;
-}
-
 static const struct of_device_id of_dra7_atl_clk_match_tbl[] = {
 	{ .compatible = "ti,dra7-atl", },
 	{},
 };
-MODULE_DEVICE_TABLE(of, of_dra7_atl_clk_match_tbl);
 
 static struct platform_driver dra7_atl_clk_driver = {
 	.driver = {
 		.name = "dra7-atl",
+		.suppress_bind_attrs = true,
 		.of_match_table = of_dra7_atl_clk_match_tbl,
 	},
 	.probe = of_dra7_atl_clk_probe,
-	.remove = of_dra7_atl_clk_remove,
 };
-
-module_platform_driver(dra7_atl_clk_driver);
-
-MODULE_DESCRIPTION("Clock driver for DRA7 Audio Tracking Logic");
-MODULE_ALIAS("platform:dra7-atl-clock");
-MODULE_AUTHOR("Peter Ujfalusi <peter.ujfalusi@ti.com>");
-MODULE_LICENSE("GPL v2");
+builtin_platform_driver(dra7_atl_clk_driver);
-- 
2.8.4
