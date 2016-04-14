From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 06/28] ARM: OMAP2+: hwmod: fetch main_clk based on hwmod name
Date: Thu, 14 Apr 2016 14:07:55 +0300
Message-ID: <1460632097-25727-7-git-send-email-t-kristo@ti.com>
References: <1460632097-25727-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1460632097-25727-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, sboyd@codeaurora.org, mturquette@baylibre.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

With the transition to hwmod module clocks, all hwmods will have
their main clocks named <hwmod_name>_mod_ck. Use this info to
fetch main_clk, and use it if found.

Also, if a main_clk is found based on the hwmod name, disable
the direct PRCM modulemode access from hwmod.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   49 ++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index c2f6811..31da3b5 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -200,6 +200,7 @@ struct omap_hwmod_soc_ops {
 	int (*init_clkdm)(struct omap_hwmod *oh);
 	void (*update_context_lost)(struct omap_hwmod *oh);
 	int (*get_context_lost)(struct omap_hwmod *oh);
+	int (*disable_direct_prcm)(struct omap_hwmod *oh);
 };
 
 /* soc_ops: adapts the omap_hwmod code to the currently-booted SoC */
@@ -776,17 +777,34 @@ static int _del_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod *init_oh)
  * @oh: struct omap_hwmod *
  *
  * Called from _init_clocks().  Populates the @oh _clk (main
- * functional clock pointer) if a main_clk is present.  Returns 0 on
- * success or -EINVAL on error.
+ * functional clock pointer) if a clock matching the hwmod name is found,
+ * or a main_clk is present.  Returns 0 on success or -EINVAL on error.
  */
 static int _init_main_clk(struct omap_hwmod *oh)
 {
 	int ret = 0;
+	char name[32];
+	static int max_len;
+	struct clk *clk;
 
-	if (!oh->main_clk)
-		return 0;
+	strcpy(name, oh->name);
+	strcat(name, "_mod_ck");
+
+	if (strlen(name) > max_len)
+		max_len = strlen(name);
+
+	clk = ti_clk_get(name);
+	if (!IS_ERR(clk)) {
+		oh->_clk = clk;
+		soc_ops.disable_direct_prcm(oh);
+		oh->main_clk = kstrdup(name, GFP_KERNEL);
+	} else {
+		if (!oh->main_clk)
+			return 0;
+
+		oh->_clk = ti_clk_get(oh->main_clk);
+	}
 
-	oh->_clk = ti_clk_get(oh->main_clk);
 	if (IS_ERR(oh->_clk)) {
 		pr_warn("omap_hwmod: %s: cannot clk_get main_clk %s\n",
 			oh->name, oh->main_clk);
@@ -3091,6 +3109,25 @@ static int _omap4_is_hardreset_asserted(struct omap_hwmod *oh,
 }
 
 /**
+ * _omap4_disable_direct_prcm - disable direct PRCM control for hwmod
+ * @oh: struct omap_hwmod * to disable control for
+ *
+ * Disables direct PRCM clkctrl done by hwmod core. Instead, the hwmod
+ * will be using its main_clk to enable/disable the module. Returns
+ * 0 if successful.
+ */
+static int _omap4_disable_direct_prcm(struct omap_hwmod *oh)
+{
+	if (!oh)
+		return -EINVAL;
+
+	oh->prcm.omap4.clkctrl_offs = 0;
+	oh->prcm.omap4.modulemode = 0;
+
+	return 0;
+}
+
+/**
  * _am33xx_deassert_hardreset - call AM33XX PRM hardreset fn with hwmod args
  * @oh: struct omap_hwmod * to deassert hardreset
  * @ohri: hardreset line data
@@ -3913,6 +3950,7 @@ void __init omap_hwmod_init(void)
 		soc_ops.init_clkdm = _init_clkdm;
 		soc_ops.update_context_lost = _omap4_update_context_lost;
 		soc_ops.get_context_lost = _omap4_get_context_lost;
+		soc_ops.disable_direct_prcm = _omap4_disable_direct_prcm;
 	} else if (cpu_is_ti814x() || cpu_is_ti816x() || soc_is_am33xx() ||
 		   soc_is_am43xx()) {
 		soc_ops.enable_module = _omap4_enable_module;
@@ -3922,6 +3960,7 @@ void __init omap_hwmod_init(void)
 		soc_ops.deassert_hardreset = _am33xx_deassert_hardreset;
 		soc_ops.is_hardreset_asserted = _omap4_is_hardreset_asserted;
 		soc_ops.init_clkdm = _init_clkdm;
+		soc_ops.disable_direct_prcm = _omap4_disable_direct_prcm;
 	} else {
 		WARN(1, "omap_hwmod: unknown SoC type\n");
 	}
-- 
1.7.9.5

