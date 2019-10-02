From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2] clk: ti: dra7-atl-clock: Remove ti_clk_add_alias call
Date: Wed, 2 Oct 2019 11:34:36 +0300
Message-ID: <20191002083436.10194-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: t-kristo@ti.com, mturquette@baylibre.com
Cc: sboyd@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

ti_clk_register() calls it already so the driver should not create
duplicated alias.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

changes since v1:
- removed unused ret variable

Regards,
Peter

 drivers/clk/ti/clk-dra7-atl.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/clk/ti/clk-dra7-atl.c b/drivers/clk/ti/clk-dra7-atl.c
index a01ca9395179..f65e16c4f3c4 100644
--- a/drivers/clk/ti/clk-dra7-atl.c
+++ b/drivers/clk/ti/clk-dra7-atl.c
@@ -174,7 +174,6 @@ static void __init of_dra7_atl_clock_setup(struct device_node *node)
 	struct clk_init_data init = { NULL };
 	const char **parent_names = NULL;
 	struct clk *clk;
-	int ret;
 
 	clk_hw = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
 	if (!clk_hw) {
@@ -207,11 +206,6 @@ static void __init of_dra7_atl_clock_setup(struct device_node *node)
 	clk = ti_clk_register(NULL, &clk_hw->hw, node->name);
 
 	if (!IS_ERR(clk)) {
-		ret = ti_clk_add_alias(NULL, clk, node->name);
-		if (ret) {
-			clk_unregister(clk);
-			goto cleanup;
-		}
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
 		kfree(parent_names);
 		return;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
