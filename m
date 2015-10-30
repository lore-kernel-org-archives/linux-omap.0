From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 2/3] ARM: OMAP2+: hwmod: Add hwmod flag for HWMOD_OPT_CLKS_NEEDED
Date: Fri, 30 Oct 2015 09:54:59 +0200
Message-ID: <1446191700-11057-3-git-send-email-peter.ujfalusi@ti.com>
References: <1446191700-11057-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446191700-11057-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

Some module needs more than one functional clock in order to be accessible,
like the McASPs found in DRA7xx family.
This flag will indicate that the opt_clks need to be handled at the same
time as the main_clk for the given hwmod, ensuring that all needed clocks
are enabled before we try to access the module's address space.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 66 ++++++++++++++++++++++------------------
 arch/arm/mach-omap2/omap_hwmod.h |  3 ++
 2 files changed, 39 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index cc8a987149e2..48495ad82aba 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -890,6 +890,36 @@ static int _init_opt_clks(struct omap_hwmod *oh)
 	return ret;
 }
 
+static void _enable_optional_clocks(struct omap_hwmod *oh)
+{
+	struct omap_hwmod_opt_clk *oc;
+	int i;
+
+	pr_debug("omap_hwmod: %s: enabling optional clocks\n", oh->name);
+
+	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++)
+		if (oc->_clk) {
+			pr_debug("omap_hwmod: enable %s:%s\n", oc->role,
+				 __clk_get_name(oc->_clk));
+			clk_enable(oc->_clk);
+		}
+}
+
+static void _disable_optional_clocks(struct omap_hwmod *oh)
+{
+	struct omap_hwmod_opt_clk *oc;
+	int i;
+
+	pr_debug("omap_hwmod: %s: disabling optional clocks\n", oh->name);
+
+	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++)
+		if (oc->_clk) {
+			pr_debug("omap_hwmod: disable %s:%s\n", oc->role,
+				 __clk_get_name(oc->_clk));
+			clk_disable(oc->_clk);
+		}
+}
+
 /**
  * _enable_clocks - enable hwmod main clock and interface clocks
  * @oh: struct omap_hwmod *
@@ -917,6 +947,9 @@ static int _enable_clocks(struct omap_hwmod *oh)
 			clk_enable(os->_clk);
 	}
 
+	if (oh->flags & HWMOD_OPT_CLKS_NEEDED)
+		_enable_optional_clocks(oh);
+
 	/* The opt clocks are controlled by the device driver. */
 
 	return 0;
@@ -948,41 +981,14 @@ static int _disable_clocks(struct omap_hwmod *oh)
 			clk_disable(os->_clk);
 	}
 
+	if (oh->flags & HWMOD_OPT_CLKS_NEEDED)
+		_disable_optional_clocks(oh);
+
 	/* The opt clocks are controlled by the device driver. */
 
 	return 0;
 }
 
-static void _enable_optional_clocks(struct omap_hwmod *oh)
-{
-	struct omap_hwmod_opt_clk *oc;
-	int i;
-
-	pr_debug("omap_hwmod: %s: enabling optional clocks\n", oh->name);
-
-	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++)
-		if (oc->_clk) {
-			pr_debug("omap_hwmod: enable %s:%s\n", oc->role,
-				 __clk_get_name(oc->_clk));
-			clk_enable(oc->_clk);
-		}
-}
-
-static void _disable_optional_clocks(struct omap_hwmod *oh)
-{
-	struct omap_hwmod_opt_clk *oc;
-	int i;
-
-	pr_debug("omap_hwmod: %s: disabling optional clocks\n", oh->name);
-
-	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++)
-		if (oc->_clk) {
-			pr_debug("omap_hwmod: disable %s:%s\n", oc->role,
-				 __clk_get_name(oc->_clk));
-			clk_disable(oc->_clk);
-		}
-}
-
 /**
  * _omap4_enable_module - enable CLKCTRL modulemode on OMAP4
  * @oh: struct omap_hwmod *
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index ca6df1a73475..76bce11c85a4 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -523,6 +523,8 @@ struct omap_hwmod_omap4_prcm {
  * HWMOD_RECONFIG_IO_CHAIN: omap_hwmod code needs to reconfigure wake-up 
  *     events by calling _reconfigure_io_chain() when a device is enabled
  *     or idled.
+ * HWMOD_OPT_CLKS_NEEDED: The optional clocks are needed for the module to
+ *     operate and they need to be handled at the same time as the main_clk.
  */
 #define HWMOD_SWSUP_SIDLE			(1 << 0)
 #define HWMOD_SWSUP_MSTANDBY			(1 << 1)
@@ -538,6 +540,7 @@ struct omap_hwmod_omap4_prcm {
 #define HWMOD_FORCE_MSTANDBY			(1 << 11)
 #define HWMOD_SWSUP_SIDLE_ACT			(1 << 12)
 #define HWMOD_RECONFIG_IO_CHAIN			(1 << 13)
+#define HWMOD_OPT_CLKS_NEEDED			(1 << 14)
 
 /*
  * omap_hwmod._int_flags definitions
-- 
2.6.1
