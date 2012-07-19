From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv7 10/12] ARM: OMAP4: HWMOD: add support for lostcontext_mask
Date: Thu, 19 Jul 2012 16:26:30 +0300
Message-ID: <1342704392-23657-11-git-send-email-t-kristo@ti.com>
References: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33572 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751664Ab2GSN1Y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jul 2012 09:27:24 -0400
In-Reply-To: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, nm@ti.com, paul@pwsan.com, khilman@ti.com, rnayak@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Currently hwmod only provides the offset for the context lose register,
and if we attempt to share the same register between two or more hwmods,
the resulting context loss counts get wrong. Thus, we need a way to
specify which bits are used for the context loss information for each.
This is accomplished by adding a new field to the omap4 prcm struct,
'lostcontext_mask', which specifies a bit-mask to use for filtering
the register. Only the specified bits are read and cleared by the
context lose counter update code. If a hwmod doesn't specify
'lostcontext_mask' (default behavior), the whole contents of the
context register are used without any filtering.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |    8 ++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    6 ++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index a60dfd2..3ebf93e 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1810,11 +1810,19 @@ static void _omap4_update_context_lost(struct omap_hwmod *oh)
 					oh->clkdm->pwrdm.ptr->prcm_offs,
 					oh->prcm.omap4.context_offs);
 
+	/*
+	 * If lostcontext_mask is defined, only check these bits for
+	 * losing context. Otherwise check whole register.
+	 */
+	if (oh->prcm.omap4.lostcontext_mask)
+		r &= oh->prcm.omap4.lostcontext_mask;
+
 	if (!r)
 		return;
 
 	oh->prcm.omap4.context_lost_counter++;
 
+	/* Clear selected bits */
 	omap4_prminst_write_inst_reg(r, oh->clkdm->pwrdm.ptr->prcm_partition,
 				     oh->clkdm->pwrdm.ptr->prcm_offs,
 				     oh->prcm.omap4.context_offs);
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 75d59f5..ebe3048 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -375,14 +375,20 @@ struct omap_hwmod_omap2_prcm {
  * @clkctrl_offs: offset of the PRCM clock control register
  * @rstctrl_offs: offset of the XXX_RSTCTRL register located in the PRM
  * @context_offs: offset of the RM_*_CONTEXT register
+ * @lostcontext_mask: bitmask for selecting bits from RM_*_CONTEXT register
  * @submodule_wkdep_bit: bit shift of the WKDEP range
  * @modulemode: allowable modulemodes
  * @context_lost_counter: Count of module level context lost
+ *
+ * If @lostcontext_mask is not defined, context loss check code uses
+ * whole register without masking. @lostcontext_mask should only be defined
+ * in cases where @context_offs register is shared by two or more hwmods.
  */
 struct omap_hwmod_omap4_prcm {
 	u16		clkctrl_offs;
 	u16		rstctrl_offs;
 	u16		context_offs;
+	u32		lostcontext_mask;
 	u8		submodule_wkdep_bit;
 	u8		modulemode;
 	unsigned	context_lost_counter;
-- 
1.7.4.1

