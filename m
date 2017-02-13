From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 4/6] ARM: OMAP2+: hwmod: assign hwmod-ck as main clock from DT if available
Date: Mon, 13 Feb 2017 15:22:35 +0200
Message-ID: <1486992157-10673-5-git-send-email-t-kristo@ti.com>
References: <1486992157-10673-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1486992157-10673-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Fix the main clock assignment to assign hwmod-ck from DT as the main clock
if available. If main clock is assigned via DT, the direct PRCM access
for module handling is not used on OMAP4+ architectures either, as it is
assumed the main clock will be doing this instead.

This patch also drops the obsolete "_mod_ck" search as the implementation
required for this was not accepted upstream.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 759e1d4..0db56e7d 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -731,31 +731,29 @@ static int _del_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod *init_oh)
 /**
  * _init_main_clk - get a struct clk * for the the hwmod's main functional clk
  * @oh: struct omap_hwmod *
+ * @np: device node mapped to this hwmod
  *
  * Called from _init_clocks().  Populates the @oh _clk (main
  * functional clock pointer) if a clock matching the hwmod name is found,
  * or a main_clk is present.  Returns 0 on success or -EINVAL on error.
  */
-static int _init_main_clk(struct omap_hwmod *oh)
+static int _init_main_clk(struct omap_hwmod *oh, struct device_node *np)
 {
 	int ret = 0;
-	char name[MOD_CLK_MAX_NAME_LEN];
-	struct clk *clk;
+	struct clk *clk = NULL;
 
-	/* +7 magic comes from '_mod_ck' suffix */
-	if (strlen(oh->name) + 7 > MOD_CLK_MAX_NAME_LEN)
-		pr_warn("%s: warning: cropping name for %s\n", __func__,
-			oh->name);
-
-	strncpy(name, oh->name, MOD_CLK_MAX_NAME_LEN - 7);
-	strcat(name, "_mod_ck");
+	if (np) {
+		clk = of_clk_get_by_name(np, "clkctrl");
+		if (!IS_ERR(clk)) {
+			pr_debug("%s: mapped main_clk %s for %s\n", __func__,
+				 __clk_get_name(clk), oh->name);
+			oh->main_clk = __clk_get_name(clk);
+			oh->_clk = clk;
+			soc_ops.disable_direct_prcm(oh);
+		}
+	}
 
-	clk = clk_get(NULL, name);
-	if (!IS_ERR(clk)) {
-		oh->_clk = clk;
-		soc_ops.disable_direct_prcm(oh);
-		oh->main_clk = kstrdup(name, GFP_KERNEL);
-	} else {
+	if (IS_ERR_OR_NULL(clk)) {
 		if (!oh->main_clk)
 			return 0;
 
@@ -1547,13 +1545,13 @@ static int _init_clkdm(struct omap_hwmod *oh)
  * _init_clocks - clk_get() all clocks associated with this hwmod. Retrieve as
  * well the clockdomain.
  * @oh: struct omap_hwmod *
- * @data: not used; pass NULL
+ * @np: device_node mapped to this hwmod
  *
  * Called by omap_hwmod_setup_*() (after omap2_clk_init()).
  * Resolves all clock names embedded in the hwmod.  Returns 0 on
  * success, or a negative error code on failure.
  */
-static int _init_clocks(struct omap_hwmod *oh, void *data)
+static int _init_clocks(struct omap_hwmod *oh, struct device_node *np)
 {
 	int ret = 0;
 
@@ -1565,7 +1563,7 @@ static int _init_clocks(struct omap_hwmod *oh, void *data)
 	if (soc_ops.init_clkdm)
 		ret |= soc_ops.init_clkdm(oh);
 
-	ret |= _init_main_clk(oh);
+	ret |= _init_main_clk(oh, np);
 	ret |= _init_interface_clks(oh);
 	ret |= _init_opt_clks(oh);
 
@@ -2420,7 +2418,7 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 		return 0;
 	}
 
-	r = _init_clocks(oh, NULL);
+	r = _init_clocks(oh, np);
 	if (r < 0) {
 		WARN(1, "omap_hwmod: %s: couldn't init clocks\n", oh->name);
 		return -EINVAL;
-- 
1.9.1

