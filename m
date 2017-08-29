From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/5] ARM: OMAP2+: Fix overwriting of clkctrl and modulemode
 values
Date: Tue, 29 Aug 2017 10:03:33 -0700
Message-ID: <20170829170335.11536-4-tony@atomide.com>
References: <20170829170335.11536-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170829170335.11536-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Lokesh Vutla <lokeshvutla@ti.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

We are currently overwiting the hwmod clkctrl registers if we
configure a clock ctrl clock from device tree.

While this does not expose any bugs except for kernel coders
when debugging things, it should be fixed for correctness.
It is now impossible to use the hwmod data for checking the
clkctrl register values after booting for debugging or
generating dts data from hwmod data.

Let's fix the issue by adding a helper to detect if clkctrl
clock is configured.

Cc: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 49 +++++++++++++++++++++++++++++++++-------
 arch/arm/mach-omap2/omap_hwmod.h |  3 +++
 2 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -993,6 +993,34 @@ static int _enable_clocks(struct omap_hwmod *oh)
 	return 0;
 }
 
+/**
+ * _omap4_clkctrl_managed_by_clkfwk - true if clkctrl managed by clock framework
+ * @oh: struct omap_hwmod *
+ */
+static bool _omap4_clkctrl_managed_by_clkfwk(struct omap_hwmod *oh)
+{
+	if (oh->prcm.omap4.flags & HWMOD_OMAP4_CLKFWK_CLKCTR_CLOCK)
+		return true;
+
+	return false;
+}
+
+/**
+ * _omap4_has_clkctrl_clock - returns true if a module has clkctrl clock
+ * @oh: struct omap_hwmod *
+ */
+static bool _omap4_has_clkctrl_clock(struct omap_hwmod *oh)
+{
+	if (oh->prcm.omap4.clkctrl_offs)
+		return true;
+
+	if (!oh->prcm.omap4.clkctrl_offs &&
+	    oh->prcm.omap4.flags & HWMOD_OMAP4_ZERO_CLKCTRL_OFFSET)
+		return true;
+
+	return false;
+}
+
 /**
  * _disable_clocks - disable hwmod main clock and interface clocks
  * @oh: struct omap_hwmod *
@@ -1030,7 +1058,8 @@ static int _disable_clocks(struct omap_hwmod *oh)
  */
 static void _omap4_enable_module(struct omap_hwmod *oh)
 {
-	if (!oh->clkdm || !oh->prcm.omap4.modulemode)
+	if (!oh->clkdm || !oh->prcm.omap4.modulemode ||
+	    _omap4_clkctrl_managed_by_clkfwk(oh))
 		return;
 
 	pr_debug("omap_hwmod: %s: %s: %d\n",
@@ -1061,8 +1090,10 @@ static int _omap4_wait_target_disable(struct omap_hwmod *oh)
 	if (oh->flags & HWMOD_NO_IDLEST)
 		return 0;
 
-	if (!oh->prcm.omap4.clkctrl_offs &&
-	    !(oh->prcm.omap4.flags & HWMOD_OMAP4_ZERO_CLKCTRL_OFFSET))
+	if (_omap4_clkctrl_managed_by_clkfwk(oh))
+		return 0;
+
+	if (!_omap4_has_clkctrl_clock(oh))
 		return 0;
 
 	return omap_cm_wait_module_idle(oh->clkdm->prcm_partition,
@@ -1847,7 +1878,8 @@ static int _omap4_disable_module(struct omap_hwmod *oh)
 {
 	int v;
 
-	if (!oh->clkdm || !oh->prcm.omap4.modulemode)
+	if (!oh->clkdm || !oh->prcm.omap4.modulemode ||
+	    _omap4_clkctrl_managed_by_clkfwk(oh))
 		return -EINVAL;
 
 	/*
@@ -2831,8 +2863,10 @@ static int _omap4_wait_target_ready(struct omap_hwmod *oh)
 	if (!_find_mpu_rt_port(oh))
 		return 0;
 
-	if (!oh->prcm.omap4.clkctrl_offs &&
-	    !(oh->prcm.omap4.flags & HWMOD_OMAP4_ZERO_CLKCTRL_OFFSET))
+	if (_omap4_clkctrl_managed_by_clkfwk(oh))
+		return 0;
+
+	if (!_omap4_has_clkctrl_clock(oh))
 		return 0;
 
 	/* XXX check module SIDLEMODE, hardreset status */
@@ -2988,8 +3022,7 @@ static int _omap4_disable_direct_prcm(struct omap_hwmod *oh)
 	if (!oh)
 		return -EINVAL;
 
-	oh->prcm.omap4.clkctrl_offs = 0;
-	oh->prcm.omap4.modulemode = 0;
+	oh->prcm.omap4.flags |= HWMOD_OMAP4_CLKFWK_CLKCTR_CLOCK;
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -446,9 +446,12 @@ struct omap_hwmod_omap2_prcm {
  * HWMOD_OMAP4_ZERO_CLKCTRL_OFFSET: Some IP blocks have a valid CLKCTRL
  *	offset of zero; this flag bit should be set in those cases to
  *	distinguish from hwmods that have no clkctrl offset.
+ * HWMOD_OMAP4_CLKFWK_CLKCTR_CLOCK: Module clockctrl clock is managed
+ *	by the common clock framework and not hwmod.
  */
 #define HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT		(1 << 0)
 #define HWMOD_OMAP4_ZERO_CLKCTRL_OFFSET		(1 << 1)
+#define HWMOD_OMAP4_CLKFWK_CLKCTR_CLOCK		(1 << 2)
 
 /**
  * struct omap_hwmod_omap4_prcm - OMAP4-specific PRCM data
-- 
2.14.1
