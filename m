From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/5] OMAP: hwmod: Fix softreset for modules with optional
	clocks
Date: Tue, 21 Sep 2010 18:19:31 -0600
Message-ID: <20100922001928.8621.60528.stgit@twilight.localdomain>
References: <20100922001834.8621.76144.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35983 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257Ab0IVAV3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 20:21:29 -0400
In-Reply-To: <20100922001834.8621.76144.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Partha Basak <p-basak2@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Benoit Cousson <b-cousson@ti.com>

From: Benoit Cousson <b-cousson@ti.com>

Some modules (like GPIO, DSS...) require optionals clock to be enabled
in order to complete the sofreset properly.
Add a HWMOD_CONTROL_OPT_CLKS_IN_RESET flag to force all optional clocks
to be enabled before reset. Disabled them once the reset is done.

TODO:
For the moment it is very hard to understand from the HW spec, which
optional clock is needed and which one is not. So the current approach
will enable all the optional clocks.
Paul proposed a much finer approach that will allow to tag only the needed
clock in the optional clock table. This might be doable as soon as we have
a clear understanding of these dependencies.

Reported-by: Partha Basak <p-basak2@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   51 +++++++++++++++++++++++---
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    5 +++
 2 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 5027879..f320cfb 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -546,6 +546,36 @@ static int _disable_clocks(struct omap_hwmod *oh)
 	return 0;
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
+				 oc->_clk->name);
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
+				 oc->_clk->name);
+			clk_disable(oc->_clk);
+		}
+}
+
 /**
  * _find_mpu_port_index - find hwmod OCP slave port ID intended for MPU use
  * @oh: struct omap_hwmod *
@@ -976,8 +1006,9 @@ static int _read_hardreset(struct omap_hwmod *oh, const char *name)
  */
 static int _reset(struct omap_hwmod *oh)
 {
-	u32 r, v;
+	u32 v;
 	int c = 0;
+	int ret = 0;
 
 	if (!oh->class->sysc ||
 	    !(oh->class->sysc->sysc_flags & SYSC_HAS_SOFTRESET))
@@ -990,12 +1021,16 @@ static int _reset(struct omap_hwmod *oh)
 		return -EINVAL;
 	}
 
+	/* For some modules, all optionnal clocks need to be enabled as well */
+	if (oh->flags & HWMOD_CONTROL_OPT_CLKS_IN_RESET)
+		_enable_optional_clocks(oh);
+
 	pr_debug("omap_hwmod: %s: resetting\n", oh->name);
 
 	v = oh->_sysc_cache;
-	r = _set_softreset(oh, &v);
-	if (r)
-		return r;
+	ret = _set_softreset(oh, &v);
+	if (ret)
+		goto dis_opt_clks;
 	_write_sysconfig(v, oh);
 
 	if (oh->class->sysc->sysc_flags & SYSS_HAS_RESET_STATUS)
@@ -1020,7 +1055,13 @@ static int _reset(struct omap_hwmod *oh)
 	 * _wait_target_ready() or _reset()
 	 */
 
-	return (c == MAX_MODULE_SOFTRESET_WAIT) ? -ETIMEDOUT : 0;
+	ret = (c == MAX_MODULE_SOFTRESET_WAIT) ? -ETIMEDOUT : 0;
+
+dis_opt_clks:
+	if (oh->flags & HWMOD_CONTROL_OPT_CLKS_IN_RESET)
+		_disable_optional_clocks(oh);
+
+	return ret;
 }
 
 /**
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index faa0827..ee53758 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -369,6 +369,10 @@ struct omap_hwmod_omap4_prcm {
  * HWMOD_SET_DEFAULT_CLOCKACT: program CLOCKACTIVITY bits at startup
  * HWMOD_NO_IDLEST : this module does not have idle status - this is the case
  *     only for few initiator modules on OMAP2 & 3.
+ * HWMOD_CONTROL_OPT_CLKS_IN_RESET: Enable all optional clocks during reset.
+ *     This is needed for devices like DSS that require optional clocks enabled
+ *     in order to complete the reset. Optional clocks will be disabled
+ *     again after the reset.
  */
 #define HWMOD_SWSUP_SIDLE			(1 << 0)
 #define HWMOD_SWSUP_MSTANDBY			(1 << 1)
@@ -377,6 +381,7 @@ struct omap_hwmod_omap4_prcm {
 #define HWMOD_NO_OCP_AUTOIDLE			(1 << 4)
 #define HWMOD_SET_DEFAULT_CLOCKACT		(1 << 5)
 #define HWMOD_NO_IDLEST				(1 << 6)
+#define HWMOD_CONTROL_OPT_CLKS_IN_RESET		(1 << 7)
 
 /*
  * omap_hwmod._int_flags definitions


