From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: [PATCH 1/2] ARM: OMAP: hwmod: partially un-reset hwmods might not be
 properly enabled
Date: Wed, 22 Aug 2012 00:42:29 -0500
Message-ID: <1345614150-25723-2-git-send-email-omar.luna@linaro.org>
References: <1345614150-25723-1-git-send-email-omar.luna@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1345614150-25723-1-git-send-email-omar.luna@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Omar Ramirez Luna <omar.luna@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Some IP blocks might not be using/controlling more than one
reset line, this check loosens the restriction to fully use
hwmod framework for those drivers.

E.g.: ipu has reset lines: mmu_cache, cpu0 and cpu1.
- As of now cpu1 is not used and hence (with previous check) the
  IP block isn't fully enabled by hwmod code.
- Usually ipu and dsp processors configure their mmu module first
  and then enable the processors, this involves:
    * Deasserting mmu reset line, and enabling the module.
    * Deasserting cpu0 reset line, and enabling the processor.
  The ones portrayed in this example are controlled through
  rproc_fw_boot in drivers/remoteproc/remoteproc_core.c

While at it, prevent _omap4_module_disable if all the hardreset
lines on an IP block are not under reset.

This will allow the driver to:
  a. Deassert the reset line.
  b. Enable the hwmod through runtime PM default callbacks.
  c. Do its usecase.
  d. Disable hwmod through runtime PM.
  e. Assert the reset line.

Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>
---
 arch/arm/mach-omap2/omap_hwmod.c |   37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 6ca8e51..eaedc33 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1558,25 +1558,28 @@ static int _read_hardreset(struct omap_hwmod *oh, const char *name)
 }
 
 /**
- * _are_any_hardreset_lines_asserted - return true if part of @oh is hard-reset
+ * _are_all_hardreset_lines_asserted - return true if the @oh is hard-reset
  * @oh: struct omap_hwmod *
  *
- * If any hardreset line associated with @oh is asserted, then return true.
- * Otherwise, if @oh has no hardreset lines associated with it, or if
- * no hardreset lines associated with @oh are asserted, then return false.
+ * If all hardreset lines associated with @oh are asserted, then return true.
+ * Otherwise, if part of @oh is out hardreset or if no hardreset lines
+ * associated with @oh are asserted, then return false.
  * This function is used to avoid executing some parts of the IP block
- * enable/disable sequence if a hardreset line is set.
+ * enable/disable sequence if its hardreset line is set.
  */
-static bool _are_any_hardreset_lines_asserted(struct omap_hwmod *oh)
+static bool _are_all_hardreset_lines_asserted(struct omap_hwmod *oh)
 {
-	int i;
+	int i, rst_cnt = 0;
 
 	if (oh->rst_lines_cnt == 0)
 		return false;
 
 	for (i = 0; i < oh->rst_lines_cnt; i++)
 		if (_read_hardreset(oh, oh->rst_lines[i].name) > 0)
-			return true;
+			rst_cnt++;
+
+	if (oh->rst_lines_cnt == rst_cnt)
+		return true;
 
 	return false;
 }
@@ -1595,6 +1598,13 @@ static int _omap4_disable_module(struct omap_hwmod *oh)
 	if (!oh->clkdm || !oh->prcm.omap4.modulemode)
 		return -EINVAL;
 
+	/*
+	 * Since integration code might still be doing something, only
+	 * disable if all lines are under hardreset.
+	 */
+	if (!_are_all_hardreset_lines_asserted(oh))
+		return 0;
+
 	pr_debug("omap_hwmod: %s: %s\n", oh->name, __func__);
 
 	omap4_cminst_module_disable(oh->clkdm->prcm_partition,
@@ -1602,9 +1612,6 @@ static int _omap4_disable_module(struct omap_hwmod *oh)
 				    oh->clkdm->clkdm_offs,
 				    oh->prcm.omap4.clkctrl_offs);
 
-	if (_are_any_hardreset_lines_asserted(oh))
-		return 0;
-
 	v = _omap4_wait_target_disable(oh);
 	if (v)
 		pr_warn("omap_hwmod: %s: _wait_target_disable failed\n",
@@ -1830,7 +1837,7 @@ static int _enable(struct omap_hwmod *oh)
 	}
 
 	/*
-	 * If an IP block contains HW reset lines and any of them are
+	 * If an IP block contains HW reset lines and all of them are
 	 * asserted, we let integration code associated with that
 	 * block handle the enable.  We've received very little
 	 * information on what those driver authors need, and until
@@ -1838,7 +1845,7 @@ static int _enable(struct omap_hwmod *oh)
 	 * posted to the public lists, this is probably the best we
 	 * can do.
 	 */
-	if (_are_any_hardreset_lines_asserted(oh))
+	if (_are_all_hardreset_lines_asserted(oh))
 		return 0;
 
 	/* Mux pins for device runtime if populated */
@@ -1918,7 +1925,7 @@ static int _idle(struct omap_hwmod *oh)
 		return -EINVAL;
 	}
 
-	if (_are_any_hardreset_lines_asserted(oh))
+	if (_are_all_hardreset_lines_asserted(oh))
 		return 0;
 
 	if (oh->class->sysc)
@@ -2006,7 +2013,7 @@ static int _shutdown(struct omap_hwmod *oh)
 		return -EINVAL;
 	}
 
-	if (_are_any_hardreset_lines_asserted(oh))
+	if (_are_all_hardreset_lines_asserted(oh))
 		return 0;
 
 	pr_debug("omap_hwmod: %s: disabling\n", oh->name);
-- 
1.7.9.5
