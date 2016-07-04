From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 2/5] ARM: OMAP2+: hwmod: fetch main_clk based on hwmod name
Date: Mon, 4 Jul 2016 14:11:48 +0300
Message-ID: <1467630708-28498-1-git-send-email-t-kristo@ti.com>
References: <20160704065428.GS28140@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160704065428.GS28140@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

With the transition to hwmod module clocks, all hwmods will have
their main clocks named <hwmod_name>_mod_ck. Use this info to
fetch main_clk, and use it if found.

Also, if a main_clk is found based on the hwmod name, disable
the direct PRCM modulemode access from hwmod.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 55 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index be77d05..5b70938 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -178,6 +178,11 @@
  */
 #define OMAP4_RST_CTRL_ST_OFFSET	4
 
+/*
+ * Maximum length for module clock handle names
+ */
+#define MOD_CLK_MAX_NAME_LEN		32
+
 /**
  * struct omap_hwmod_soc_ops - fn ptrs for some SoC-specific operations
  * @enable_module: function to enable a module (via MODULEMODE)
@@ -200,6 +205,7 @@ struct omap_hwmod_soc_ops {
 	int (*init_clkdm)(struct omap_hwmod *oh);
 	void (*update_context_lost)(struct omap_hwmod *oh);
 	int (*get_context_lost)(struct omap_hwmod *oh);
+	int (*disable_direct_prcm)(struct omap_hwmod *oh);
 };
 
 /* soc_ops: adapts the omap_hwmod code to the currently-booted SoC */
@@ -776,17 +782,35 @@ static int _del_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod *init_oh)
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
+	char name[MOD_CLK_MAX_NAME_LEN];
+	struct clk *clk;
 
-	if (!oh->main_clk)
-		return 0;
+	/* +7 magic comes from '_mod_ck' suffix */
+	if (strlen(oh->name) + 7 > MOD_CLK_MAX_NAME_LEN)
+		pr_warn("%s: warning: cropping name for %s\n", __func__,
+			oh->name);
+
+	strncpy(name, oh->name, MOD_CLK_MAX_NAME_LEN - 7);
+	strcat(name, "_mod_ck");
+
+	clk = clk_get(NULL, name);
+	if (!IS_ERR(clk)) {
+		oh->_clk = clk;
+		soc_ops.disable_direct_prcm(oh);
+		oh->main_clk = kstrdup(name, GFP_KERNEL);
+	} else {
+		if (!oh->main_clk)
+			return 0;
+
+		oh->_clk = clk_get(NULL, oh->main_clk);
+	}
 
-	oh->_clk = clk_get(NULL, oh->main_clk);
 	if (IS_ERR(oh->_clk)) {
 		pr_warn("omap_hwmod: %s: cannot clk_get main_clk %s\n",
 			oh->name, oh->main_clk);
@@ -3088,6 +3112,25 @@ static int _omap4_is_hardreset_asserted(struct omap_hwmod *oh,
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
@@ -3910,6 +3953,7 @@ void __init omap_hwmod_init(void)
 		soc_ops.init_clkdm = _init_clkdm;
 		soc_ops.update_context_lost = _omap4_update_context_lost;
 		soc_ops.get_context_lost = _omap4_get_context_lost;
+		soc_ops.disable_direct_prcm = _omap4_disable_direct_prcm;
 	} else if (cpu_is_ti814x() || cpu_is_ti816x() || soc_is_am33xx() ||
 		   soc_is_am43xx()) {
 		soc_ops.enable_module = _omap4_enable_module;
@@ -3919,6 +3963,7 @@ void __init omap_hwmod_init(void)
 		soc_ops.deassert_hardreset = _am33xx_deassert_hardreset;
 		soc_ops.is_hardreset_asserted = _omap4_is_hardreset_asserted;
 		soc_ops.init_clkdm = _init_clkdm;
+		soc_ops.disable_direct_prcm = _omap4_disable_direct_prcm;
 	} else {
 		WARN(1, "omap_hwmod: unknown SoC type\n");
 	}
-- 
1.9.1
