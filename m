From: Tero Kristo <t-kristo@ti.com>
Subject: =?UTF-8?q?=5BPATCHv9=201/8=5D=20ARM=3A=20OMAP=3A=20hwmod=3A=20Add=20support=20for=20per=20hwmod/module=20context=20lost=20count?=
Date: Thu, 18 Oct 2012 12:20:03 +0300
Message-ID: <1350552010-28760-2-git-send-email-t-kristo@ti.com>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50206 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754840Ab2JRJUg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Oct 2012 05:20:36 -0400
In-Reply-To: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

=46rom: Rajendra Nayak <rnayak@ti.com>

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
 rearranged structure to avoid memory waste, marked fns as OMAP4-specif=
ic,
 prevent fn entry on non-OMAP4 chips, reduced indentation, merged updat=
e
 and clear, merged patches]
[t-kristo@ti.com: added support for arch specific hwmod ops, and change=
d
 the no context offset indicator to USHRT_MAX]
Signed-off-by: Tero Kristo <t-kristo@ti.com>
[paul@pwsan.com: use NO_CONTEXT_LOSS_BIT flag rather than USHRT_MAX;
 convert unsigned context lost counter to int to match the return type;
 get rid of hwmod_ops in favor of the existing soc_ops mechanism]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   60 ++++++++++++++++++=
++++++--
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   10 +++-
 2 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index b969ab1..d810f85 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -189,6 +189,8 @@ struct omap_hwmod_soc_ops {
 	int (*is_hardreset_asserted)(struct omap_hwmod *oh,
 				     struct omap_hwmod_rst_info *ohri);
 	int (*init_clkdm)(struct omap_hwmod *oh);
+	void (*update_context_lost)(struct omap_hwmod *oh);
+	int (*get_context_lost)(struct omap_hwmod *oh);
 };
=20
 /* soc_ops: adapts the omap_hwmod code to the currently-booted SoC */
@@ -1962,6 +1964,47 @@ static void _reconfigure_io_chain(void)
 }
=20
 /**
+ * _omap4_update_context_lost - increment hwmod context loss counter i=
f
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
+	if (oh->prcm.omap4.flags & HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT)
+		return;
+
+	r =3D omap4_prminst_read_inst_reg(oh->clkdm->pwrdm.ptr->prcm_partitio=
n,
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
+/**
  * _enable - enable an omap_hwmod
  * @oh: struct omap_hwmod *
  *
@@ -2044,6 +2087,9 @@ static int _enable(struct omap_hwmod *oh)
 	if (soc_ops.enable_module)
 		soc_ops.enable_module(oh);
=20
+	if (soc_ops.update_context_lost)
+		soc_ops.update_context_lost(oh);
+
 	r =3D (soc_ops.wait_target_ready) ? soc_ops.wait_target_ready(oh) :
 		-EINVAL;
 	if (!r) {
@@ -3852,17 +3898,21 @@ ohsps_unlock:
  * omap_hwmod_get_context_loss_count - get lost context count
  * @oh: struct omap_hwmod *
  *
- * Query the powerdomain of of @oh to get the context loss
- * count for this device.
+ * Returns the context loss count of associated @oh
+ * upon success, or zero if no context loss data is available.
  *
- * Returns the context loss count of the powerdomain assocated with @o=
h
- * upon success, or zero if no powerdomain exists for @oh.
+ * On OMAP4, this queries the per-hwmod context loss register,
+ * assuming one exists.  If not, or on OMAP2/3, this queries the
+ * enclosing powerdomain context loss count.
  */
 int omap_hwmod_get_context_loss_count(struct omap_hwmod *oh)
 {
 	struct powerdomain *pwrdm;
 	int ret =3D 0;
=20
+	if (soc_ops.get_context_lost)
+		return soc_ops.get_context_lost(oh);
+
 	pwrdm =3D omap_hwmod_get_pwrdm(oh);
 	if (pwrdm)
 		ret =3D pwrdm_get_context_loss_count(pwrdm);
@@ -3980,6 +4030,8 @@ void __init omap_hwmod_init(void)
 		soc_ops.deassert_hardreset =3D _am33xx_deassert_hardreset;
 		soc_ops.is_hardreset_asserted =3D _am33xx_is_hardreset_asserted;
 		soc_ops.init_clkdm =3D _init_clkdm;
+		soc_ops.update_context_lost =3D _omap4_update_context_lost;
+		soc_ops.get_context_lost =3D _omap4_get_context_lost;
 	} else {
 		WARN(1, "omap_hwmod: unknown SoC type\n");
 	}
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/pl=
at-omap/include/plat/omap_hwmod.h
index b3349f7..8590f62 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -2,7 +2,7 @@
  * omap_hwmod macros, structures
  *
  * Copyright (C) 2009-2011 Nokia Corporation
- * Copyright (C) 2012 Texas Instruments, Inc.
+ * Copyright (C) 2011-2012 Texas Instruments, Inc.
  * Paul Walmsley
  *
  * Created in collaboration with (alphabetical order): Beno=C3=AEt Cou=
sson,
@@ -395,12 +395,15 @@ struct omap_hwmod_omap2_prcm {
=20
 /**
  * struct omap_hwmod_omap4_prcm - OMAP4-specific PRCM data
- * @clkctrl_reg: PRCM address of the clock control register
- * @rstctrl_reg: address of the XXX_RSTCTRL register located in the PR=
M
+ * @clkctrl_offs: offset of the PRCM clock control register
+ * @rstctrl_offs: offset of the XXX_RSTCTRL register located in the PR=
M
+ * @context_offs: offset of the RM_*_CONTEXT register
  * @lostcontext_mask: bitmask for selecting bits from RM_*_CONTEXT reg=
ister
  * @rstst_reg: (AM33XX only) address of the XXX_RSTST register in the =
PRM
  * @submodule_wkdep_bit: bit shift of the WKDEP range
  * @flags: PRCM register capabilities for this IP block
+ * @modulemode: allowable modulemodes
+ * @context_lost_counter: Count of module level context lost
  *
  * If @lostcontext_mask is not defined, context loss check code uses
  * whole register without masking. @lostcontext_mask should only be
@@ -416,6 +419,7 @@ struct omap_hwmod_omap4_prcm {
 	u8		submodule_wkdep_bit;
 	u8		modulemode;
 	u8		flags;
+	int		context_lost_counter;
 };
=20
=20
--=20
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
