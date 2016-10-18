From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 07/15] clk: ti: rename ti_clk_register_legacy_clks API
Date: Tue, 18 Oct 2016 18:46:00 +0300
Message-ID: <1476805568-19264-8-git-send-email-t-kristo@ti.com>
References: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, tony@atomide.com, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Drop the '_legacy_' part out of the name, as this will be used to register
also non-legacy clocks in the following patches; namely the hwmod clocks.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clk-3xxx-legacy.c | 30 +++++++++++++++---------------
 drivers/clk/ti/clk.c             |  4 ++--
 drivers/clk/ti/clock.h           |  2 +-
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/ti/clk-3xxx-legacy.c b/drivers/clk/ti/clk-3xxx-legacy.c
index 0fbf8a9..5a860d2 100644
--- a/drivers/clk/ti/clk-3xxx-legacy.c
+++ b/drivers/clk/ti/clk-3xxx-legacy.c
@@ -4600,9 +4600,9 @@ int __init omap3430es1_clk_legacy_init(void)
 {
 	int r;
 
-	r = ti_clk_register_legacy_clks(omap3430es1_clks);
-	r |= ti_clk_register_legacy_clks(omap34xx_omap36xx_clks);
-	r |= ti_clk_register_legacy_clks(omap3xxx_clks);
+	r = ti_clk_register_clks(omap3430es1_clks);
+	r |= ti_clk_register_clks(omap34xx_omap36xx_clks);
+	r |= ti_clk_register_clks(omap3xxx_clks);
 
 	omap3_clk_legacy_common_init();
 
@@ -4613,10 +4613,10 @@ int __init omap3430_clk_legacy_init(void)
 {
 	int r;
 
-	r = ti_clk_register_legacy_clks(omap34xx_omap36xx_clks);
-	r |= ti_clk_register_legacy_clks(omap36xx_omap3430es2plus_clks);
-	r |= ti_clk_register_legacy_clks(omap36xx_am35xx_omap3430es2plus_clks);
-	r |= ti_clk_register_legacy_clks(omap3xxx_clks);
+	r = ti_clk_register_clks(omap34xx_omap36xx_clks);
+	r |= ti_clk_register_clks(omap36xx_omap3430es2plus_clks);
+	r |= ti_clk_register_clks(omap36xx_am35xx_omap3430es2plus_clks);
+	r |= ti_clk_register_clks(omap3xxx_clks);
 
 	omap3_clk_legacy_common_init();
 	omap3_clk_lock_dpll5();
@@ -4629,11 +4629,11 @@ int __init omap36xx_clk_legacy_init(void)
 	int r;
 
 	ti_clk_patch_legacy_clks(omap36xx_clk_patches);
-	r = ti_clk_register_legacy_clks(omap36xx_clks);
-	r |= ti_clk_register_legacy_clks(omap36xx_omap3430es2plus_clks);
-	r |= ti_clk_register_legacy_clks(omap34xx_omap36xx_clks);
-	r |= ti_clk_register_legacy_clks(omap36xx_am35xx_omap3430es2plus_clks);
-	r |= ti_clk_register_legacy_clks(omap3xxx_clks);
+	r = ti_clk_register_clks(omap36xx_clks);
+	r |= ti_clk_register_clks(omap36xx_omap3430es2plus_clks);
+	r |= ti_clk_register_clks(omap34xx_omap36xx_clks);
+	r |= ti_clk_register_clks(omap36xx_am35xx_omap3430es2plus_clks);
+	r |= ti_clk_register_clks(omap3xxx_clks);
 
 	omap3_clk_legacy_common_init();
 	omap3_clk_lock_dpll5();
@@ -4645,9 +4645,9 @@ int __init am35xx_clk_legacy_init(void)
 {
 	int r;
 
-	r = ti_clk_register_legacy_clks(am35xx_clks);
-	r |= ti_clk_register_legacy_clks(omap36xx_am35xx_omap3430es2plus_clks);
-	r |= ti_clk_register_legacy_clks(omap3xxx_clks);
+	r = ti_clk_register_clks(am35xx_clks);
+	r |= ti_clk_register_clks(omap36xx_am35xx_omap3430es2plus_clks);
+	r |= ti_clk_register_clks(omap3xxx_clks);
 
 	omap3_clk_legacy_common_init();
 	omap3_clk_lock_dpll5();
diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index f526f0d..7a445f4 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -291,6 +291,7 @@ void __init ti_clk_patch_legacy_clks(struct ti_clk **patch)
 		patch++;
 	}
 }
+#endif
 
 struct clk __init *ti_clk_register_clk(struct ti_clk *setup)
 {
@@ -376,7 +377,7 @@ struct clk __init *ti_clk_register_clk(struct ti_clk *setup)
 	{ }
 };
 
-int __init ti_clk_register_legacy_clks(struct ti_clk_alias *clks)
+int __init ti_clk_register_clks(struct ti_clk_alias *clks)
 {
 	struct clk *clk;
 	bool retry;
@@ -443,7 +444,6 @@ int __init ti_clk_register_legacy_clks(struct ti_clk_alias *clks)
 
 	return 0;
 }
-#endif
 
 /**
  * ti_clk_setup_features - setup clock features flags
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 6bf962d..5675e37 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -201,7 +201,7 @@ struct clk *ti_clk_register(struct device *dev, struct clk_hw *hw,
 
 void ti_clk_patch_legacy_clks(struct ti_clk **patch);
 struct clk *ti_clk_register_clk(struct ti_clk *setup);
-int ti_clk_register_legacy_clks(struct ti_clk_alias *clks);
+int ti_clk_register_clks(struct ti_clk_alias *clks);
 
 void __iomem *ti_clk_get_reg_addr(struct device_node *node, int index);
 void ti_dt_clocks_register(struct ti_dt_clk *oclks);
-- 
1.9.1

