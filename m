From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 5/8] ARM: OMAP: hwmod: Add support for per hwmod/module context lost count
Date: Fri, 20 Apr 2012 12:19:48 +0300
Message-ID: <1334913591-26312-6-git-send-email-t-kristo@ti.com>
References: <1334913591-26312-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52311 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751771Ab2DTJUR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 05:20:17 -0400
In-Reply-To: <1334913591-26312-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

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
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   44 +++++++++++++++++++++++--
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    8 +++-
 2 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 00e8cbf..fb2f4a3 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1489,6 +1489,36 @@ static int _reset(struct omap_hwmod *oh)
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
+	if (!(oh->flags & HWMOD_CONTEXT_REG))
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
  * _enable - enable an omap_hwmod
  * @oh: struct omap_hwmod *
  *
@@ -1568,6 +1598,8 @@ static int _enable(struct omap_hwmod *oh)
 	_enable_clocks(oh);
 	_enable_module(oh);
 
+	_omap4_update_context_lost(oh);
+
 	r = _wait_target_ready(oh);
 	if (!r) {
 		/*
@@ -2683,17 +2715,21 @@ ohsps_unlock:
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
 
+	if (oh->flags & HWMOD_CONTEXT_REG)
+		return oh->prcm.omap4.context_lost_counter;
+
 	pwrdm = omap_hwmod_get_pwrdm(oh);
 	if (pwrdm)
 		ret = pwrdm_get_context_loss_count(pwrdm);
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 4e5513b..7a00215 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -362,9 +362,12 @@ struct omap_hwmod_omap2_prcm {
 
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
@@ -372,6 +375,7 @@ struct omap_hwmod_omap4_prcm {
 	u16		context_offs;
 	u8		submodule_wkdep_bit;
 	u8		modulemode;
+	unsigned	context_lost_counter;
 };
 
 
-- 
1.7.4.1

