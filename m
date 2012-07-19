From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv7 04/12] ARM: OMAP: hwmod: Add support for per hwmod/module context lost count
Date: Thu, 19 Jul 2012 16:26:24 +0300
Message-ID: <1342704392-23657-5-git-send-email-t-kristo@ti.com>
References: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58892 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991Ab2GSN1L (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jul 2012 09:27:11 -0400
In-Reply-To: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, nm@ti.com, paul@pwsan.com, khilman@ti.com, rnayak@ti.com
Cc: linux-arm-kernel@lists.infradead.org

From: Rajendra Nayak <rnayak@ti.com>

OMAP4 has module specific context lost registers which makes it now
possible to have module level context loss count, instead of relying
on the powerdomain level context count.

Add 2 private hwmod api's to update/clear the hwmod/module specific
context lost counters/register.

Update the module specific context_lost_counter and clear the hardware
bits just after enabling the module.

omap_hwmod_get_context_loss_count() now returns the hwmod context loss
count them on platforms where they exist (OMAP4), else fall back on
the pwrdm level counters for older platforms.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
[paul@pwsan.com: added function kerneldoc, fixed structure kerneldoc,
 rearranged structure to avoid memory waste, marked fns as OMAP4-specific,
 prevent fn entry on non-OMAP4 chips, reduced indentation, merged update
 and clear, merged patches]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
[t-kristo@ti.com: added support for arch specific hwmod ops, and changed
 the no context offset indicator to USHRT_MAX]
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   71 ++++++++++++++++++++++++--
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    8 ++-
 2 files changed, 73 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 936da32..a60dfd2 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -170,6 +170,13 @@
 /* omap_hwmod_list contains all registered struct omap_hwmods */
 static LIST_HEAD(omap_hwmod_list);
 
+struct hwmod_ops {
+	void	(*hwmod_update_context_lost)(struct omap_hwmod *oh);
+	int	(*hwmod_get_context_lost)(struct omap_hwmod *oh);
+};
+
+static struct hwmod_ops *arch_hwmod;
+
 /* mpu_oh: used to add/remove MPU initiator from sleepdep list */
 static struct omap_hwmod *mpu_oh;
 
@@ -1784,6 +1791,52 @@ static void _reconfigure_io_chain(void)
 }
 
 /**
+ * _omap4_update_context_lost - increment hwmod context loss counter if
+ * hwmod context was lost, and clear hardware context loss reg
+ * @oh: hwmod to check for context loss
+ *
+ * If the PRCM indicates that the hwmod @oh lost context, increment
+ * our in-memory context loss counter, and clear the RM_*_CONTEXT
+ * bits. No return value.
+ */
+static void _omap4_update_context_lost(struct omap_hwmod *oh)
+{
+	u32 r;
+
+	if (oh->prcm.omap4.context_offs == USHRT_MAX)
+		return;
+
+	r = omap4_prminst_read_inst_reg(oh->clkdm->pwrdm.ptr->prcm_partition,
+					oh->clkdm->pwrdm.ptr->prcm_offs,
+					oh->prcm.omap4.context_offs);
+
+	if (!r)
+		return;
+
+	oh->prcm.omap4.context_lost_counter++;
+
+	omap4_prminst_write_inst_reg(r, oh->clkdm->pwrdm.ptr->prcm_partition,
+				     oh->clkdm->pwrdm.ptr->prcm_offs,
+				     oh->prcm.omap4.context_offs);
+}
+
+/**
+ * _omap4_get_context_lost - get context loss counter for a hwmod
+ * @oh: hwmod to get context loss counter for
+ *
+ * Returns the in-memory context loss counter for a hwmod.
+ */
+static int _omap4_get_context_lost(struct omap_hwmod *oh)
+{
+	return oh->prcm.omap4.context_lost_counter;
+}
+
+static struct hwmod_ops omap4_hwmod_ops = {
+	.hwmod_update_context_lost	= _omap4_update_context_lost,
+	.hwmod_get_context_lost		= _omap4_get_context_lost,
+};
+
+/**
  * _enable - enable an omap_hwmod
  * @oh: struct omap_hwmod *
  *
@@ -1864,6 +1917,9 @@ static int _enable(struct omap_hwmod *oh)
 	_enable_clocks(oh);
 	_enable_module(oh);
 
+	if (arch_hwmod && arch_hwmod->hwmod_update_context_lost)
+		arch_hwmod->hwmod_update_context_lost(oh);
+
 	r = _wait_target_ready(oh);
 	if (!r) {
 		/*
@@ -2700,6 +2756,9 @@ int __init omap_hwmod_setup_one(const char *oh_name)
  */
 static int __init omap_hwmod_setup_all(void)
 {
+	if (cpu_is_omap44xx())
+		arch_hwmod = &omap4_hwmod_ops;
+
 	_ensure_mpu_hwmod_is_setup(NULL);
 
 	omap_hwmod_for_each(_init, NULL);
@@ -3353,17 +3412,21 @@ ohsps_unlock:
  * omap_hwmod_get_context_loss_count - get lost context count
  * @oh: struct omap_hwmod *
  *
- * Query the powerdomain of of @oh to get the context loss
- * count for this device.
+ * Returns the context loss count of associated @oh
+ * upon success, or zero if no context loss data is available.
  *
- * Returns the context loss count of the powerdomain assocated with @oh
- * upon success, or zero if no powerdomain exists for @oh.
+ * On OMAP4, this queries the per-hwmod context loss register,
+ * assuming one exists.  If not, or on OMAP2/3, this queries the
+ * enclosing powerdomain context loss count.
  */
 int omap_hwmod_get_context_loss_count(struct omap_hwmod *oh)
 {
 	struct powerdomain *pwrdm;
 	int ret = 0;
 
+	if (arch_hwmod && arch_hwmod->hwmod_get_context_lost)
+		return arch_hwmod->hwmod_get_context_lost(oh);
+
 	pwrdm = omap_hwmod_get_pwrdm(oh);
 	if (pwrdm)
 		ret = pwrdm_get_context_loss_count(pwrdm);
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index c835b71..75d59f5 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -372,9 +372,12 @@ struct omap_hwmod_omap2_prcm {
 
 /**
  * struct omap_hwmod_omap4_prcm - OMAP4-specific PRCM data
- * @clkctrl_reg: PRCM address of the clock control register
- * @rstctrl_reg: address of the XXX_RSTCTRL register located in the PRM
+ * @clkctrl_offs: offset of the PRCM clock control register
+ * @rstctrl_offs: offset of the XXX_RSTCTRL register located in the PRM
+ * @context_offs: offset of the RM_*_CONTEXT register
  * @submodule_wkdep_bit: bit shift of the WKDEP range
+ * @modulemode: allowable modulemodes
+ * @context_lost_counter: Count of module level context lost
  */
 struct omap_hwmod_omap4_prcm {
 	u16		clkctrl_offs;
@@ -382,6 +385,7 @@ struct omap_hwmod_omap4_prcm {
 	u16		context_offs;
 	u8		submodule_wkdep_bit;
 	u8		modulemode;
+	unsigned	context_lost_counter;
 };
 
 
-- 
1.7.4.1

