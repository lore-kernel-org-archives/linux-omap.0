From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] clk: ti: clk-7xx: Remove hardwired ABE clock configuration
Date: Mon, 24 Aug 2015 10:35:02 +0300
Message-ID: <1440401702-32420-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The ABE related clocks should be configured via DT and not have it wired
inside of the kernel.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi Tero,

the ABE PLL configuration can, and will be done for dra7xx in DT with the
assigned-clocks/rate/parent feature so no need to have this anymore.

Regards,
Peter

 drivers/clk/ti/clk-7xx.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
index 9b5b289e6334..a911d7de3377 100644
--- a/drivers/clk/ti/clk-7xx.c
+++ b/drivers/clk/ti/clk-7xx.c
@@ -18,7 +18,6 @@
 
 #include "clock.h"
 
-#define DRA7_DPLL_ABE_DEFFREQ				180633600
 #define DRA7_DPLL_GMAC_DEFFREQ				1000000000
 #define DRA7_DPLL_USB_DEFFREQ				960000000
 
@@ -313,27 +312,12 @@ static struct ti_dt_clk dra7xx_clks[] = {
 int __init dra7xx_dt_clk_init(void)
 {
 	int rc;
-	struct clk *abe_dpll_mux, *sys_clkin2, *dpll_ck, *hdcp_ck;
+	struct clk *dpll_ck, *hdcp_ck;
 
 	ti_dt_clocks_register(dra7xx_clks);
 
 	omap2_clk_disable_autoidle_all();
 
-	abe_dpll_mux = clk_get_sys(NULL, "abe_dpll_sys_clk_mux");
-	sys_clkin2 = clk_get_sys(NULL, "sys_clkin2");
-	dpll_ck = clk_get_sys(NULL, "dpll_abe_ck");
-
-	rc = clk_set_parent(abe_dpll_mux, sys_clkin2);
-	if (!rc)
-		rc = clk_set_rate(dpll_ck, DRA7_DPLL_ABE_DEFFREQ);
-	if (rc)
-		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
-
-	dpll_ck = clk_get_sys(NULL, "dpll_abe_m2x2_ck");
-	rc = clk_set_rate(dpll_ck, DRA7_DPLL_ABE_DEFFREQ * 2);
-	if (rc)
-		pr_err("%s: failed to configure ABE DPLL m2x2!\n", __func__);
-
 	dpll_ck = clk_get_sys(NULL, "dpll_gmac_ck");
 	rc = clk_set_rate(dpll_ck, DRA7_DPLL_GMAC_DEFFREQ);
 	if (rc)
-- 
2.5.0
