From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 1/3] ARM: OMAP2+: hwmod: assign main clock from DT if
 available
Date: Thu, 18 May 2017 20:16:10 +0300
Message-ID: <1495127772-7486-2-git-send-email-t-kristo@ti.com>
References: <1495127772-7486-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1495127772-7486-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Fix the main clock assignment to assign clkctrl clk from DT as the main
clock if available. If main clock is assigned via DT, the direct PRCM
access for module handling is not used on OMAP4+ architectures either,
as it is assumed the main clock will be doing this instead.

This patch also drops the obsolete "_mod_ck" search as the implementation
required for this was not accepted upstream.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 57 ++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 8bcea0d..6b8a2cf 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -693,31 +693,48 @@ static int _del_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod *init_oh)
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
-	static const char modck[] = "_mod_ck";
-
-	if (strlen(oh->name) >= MOD_CLK_MAX_NAME_LEN - strlen(modck))
-		pr_warn("%s: warning: cropping name for %s\n", __func__,
-			oh->name);
+	struct clk *clk = NULL;
+	int i;
+	int count;
+	const char *name;
+	char clk_name[strlen("clkctrl-x") + 1];
 
-	strlcpy(name, oh->name, MOD_CLK_MAX_NAME_LEN - strlen(modck));
-	strlcat(name, modck, MOD_CLK_MAX_NAME_LEN);
+	if (np) {
+		clk = of_clk_get_by_name(np, "clkctrl");
+		if (IS_ERR(clk)) {
+			/* Try matching by hwmod name */
+			count = of_property_count_strings(np, "ti,hwmods");
+			for (i = 0; i < count; i++) {
+				ret = of_property_read_string_index(np,
+								    "ti,hwmods",
+								    i, &name);
+				if (ret)
+					continue;
+				if (!strcmp(name, oh->name)) {
+					sprintf(clk_name, "clkctrl-%d", i);
+					clk = of_clk_get_by_name(np, clk_name);
+				}
+			}
+		}
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
 
@@ -1482,13 +1499,13 @@ static int _init_clkdm(struct omap_hwmod *oh)
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
 
@@ -1500,7 +1517,7 @@ static int _init_clocks(struct omap_hwmod *oh, void *data)
 	if (soc_ops.init_clkdm)
 		ret |= soc_ops.init_clkdm(oh);
 
-	ret |= _init_main_clk(oh);
+	ret |= _init_main_clk(oh, np);
 	ret |= _init_interface_clks(oh);
 	ret |= _init_opt_clks(oh);
 
@@ -2360,7 +2377,7 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 		return 0;
 	}
 
-	r = _init_clocks(oh, NULL);
+	r = _init_clocks(oh, np);
 	if (r < 0) {
 		WARN(1, "omap_hwmod: %s: couldn't init clocks\n", oh->name);
 		return -EINVAL;
-- 
1.9.1
