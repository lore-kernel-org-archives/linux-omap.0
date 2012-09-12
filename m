From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv7 04/12] ARM: OMAP: hwmod: Add support for per hwmod/module
 context lost count
Date: Wed, 12 Sep 2012 21:29:03 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209122043260.17903@utopia.booyaka.com>
References: <1342704392-23657-1-git-send-email-t-kristo@ti.com> <1342704392-23657-5-git-send-email-t-kristo@ti.com> <alpine.DEB.2.00.1209121946410.17903@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-1814594080-1347483657=:17903"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41464 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819Ab2ILV3E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Sep 2012 17:29:04 -0400
In-Reply-To: <alpine.DEB.2.00.1209121946410.17903@utopia.booyaka.com>
Content-ID: <alpine.DEB.2.00.1209122128420.17903@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, khilman@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-1814594080-1347483657=:17903
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1209122128421.17903@utopia.booyaka.com>

Hi

Well, anyway.  This patch had some other issues that were found upon a=20
closer inspection:

- it adds a new 'hwmod_ops' set of function pointers rather than using the=
=20
existing 'soc_ops' mechanism

- it returns an unsigned int as a signed integer -- not sure why static=20
analysis didn't catch this one :-(

Here's the updated patch.


- Paul

From: Rajendra Nayak <rnayak@ti.com>
Date: Wed, 12 Sep 2012 11:55:55 -0600
Subject: [PATCH] ARM: OMAP: hwmod: Add support for per hwmod/module context
 lost count

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
[t-kristo@ti.com: added support for arch specific hwmod ops, and changed
 the no context offset indicator to USHRT_MAX]
Signed-off-by: Tero Kristo <t-kristo@ti.com>
[paul@pwsan.com: use NO_CONTEXT_LOSS_BIT flag rather than USHRT_MAX;
 convert unsigned context lost counter to int to match the return type;
 get rid of hwmod_ops in favor of the existing soc_ops mechanism]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   60 ++++++++++++++++++++++=
++--
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   11 +++--
 2 files changed, 63 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hw=
mod.c
index 6ca8e51..a3c5c9c 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -187,6 +187,8 @@ struct omap_hwmod_soc_ops {
 =09int (*is_hardreset_asserted)(struct omap_hwmod *oh,
 =09=09=09=09     struct omap_hwmod_rst_info *ohri);
 =09int (*init_clkdm)(struct omap_hwmod *oh);
+=09void (*update_context_lost)(struct omap_hwmod *oh);
+=09int (*get_context_lost)(struct omap_hwmod *oh);
 };
=20
 /* soc_ops: adapts the omap_hwmod code to the currently-booted SoC */
@@ -1789,6 +1791,47 @@ static void _reconfigure_io_chain(void)
 }
=20
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
+=09u32 r;
+
+=09if (oh->prcm.omap4.flags & HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT)
+=09=09return;
+
+=09r =3D omap4_prminst_read_inst_reg(oh->clkdm->pwrdm.ptr->prcm_partition,
+=09=09=09=09=09oh->clkdm->pwrdm.ptr->prcm_offs,
+=09=09=09=09=09oh->prcm.omap4.context_offs);
+
+=09if (!r)
+=09=09return;
+
+=09oh->prcm.omap4.context_lost_counter++;
+
+=09omap4_prminst_write_inst_reg(r, oh->clkdm->pwrdm.ptr->prcm_partition,
+=09=09=09=09     oh->clkdm->pwrdm.ptr->prcm_offs,
+=09=09=09=09     oh->prcm.omap4.context_offs);
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
+=09return oh->prcm.omap4.context_lost_counter;
+}
+
+/**
  * _enable - enable an omap_hwmod
  * @oh: struct omap_hwmod *
  *
@@ -1870,6 +1913,9 @@ static int _enable(struct omap_hwmod *oh)
 =09if (soc_ops.enable_module)
 =09=09soc_ops.enable_module(oh);
=20
+=09if (soc_ops.update_context_lost)
+=09=09soc_ops.update_context_lost(oh);
+
 =09r =3D (soc_ops.wait_target_ready) ? soc_ops.wait_target_ready(oh) :
 =09=09-EINVAL;
 =09if (!r) {
@@ -3557,17 +3603,21 @@ ohsps_unlock:
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
 =09struct powerdomain *pwrdm;
 =09int ret =3D 0;
=20
+=09if (soc_ops.get_context_lost)
+=09=09return soc_ops.get_context_lost(oh);
+
 =09pwrdm =3D omap_hwmod_get_pwrdm(oh);
 =09if (pwrdm)
 =09=09ret =3D pwrdm_get_context_loss_count(pwrdm);
@@ -3677,6 +3727,8 @@ void __init omap_hwmod_init(void)
 =09=09soc_ops.deassert_hardreset =3D _omap4_deassert_hardreset;
 =09=09soc_ops.is_hardreset_asserted =3D _omap4_is_hardreset_asserted;
 =09=09soc_ops.init_clkdm =3D _init_clkdm;
+=09=09soc_ops.update_context_lost =3D _omap4_update_context_lost;
+=09=09soc_ops.get_context_lost =3D _omap4_get_context_lost;
 =09} else {
 =09=09WARN(1, "omap_hwmod: unknown SoC type\n");
 =09}
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-o=
map/include/plat/omap_hwmod.h
index fd038be..b7014a0 100644
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
  * Created in collaboration with (alphabetical order): Beno=EEt Cousson,
@@ -392,14 +392,16 @@ struct omap_hwmod_omap2_prcm {
  *     flag bit should be set in those cases
  */
 #define HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT=09=09(1 << 0)
-
 /**
  * struct omap_hwmod_omap4_prcm - OMAP4-specific PRCM data
- * @clkctrl_reg: PRCM address of the clock control register
- * @rstctrl_reg: address of the XXX_RSTCTRL register located in the PRM
+ * @clkctrl_offs: offset of the PRCM clock control register
+ * @rstctrl_offs: offset of the XXX_RSTCTRL register located in the PRM
+ * @context_offs: offset of the RM_*_CONTEXT register
  * @rstst_reg: (AM33XX only) address of the XXX_RSTST register in the PRM
  * @submodule_wkdep_bit: bit shift of the WKDEP range
  * @flags: PRCM register capabilities for this IP block
+ * @modulemode: allowable modulemodes
+ * @context_lost_counter: Count of module level context lost
  */
 struct omap_hwmod_omap4_prcm {
 =09u16=09=09clkctrl_offs;
@@ -409,6 +411,7 @@ struct omap_hwmod_omap4_prcm {
 =09u8=09=09submodule_wkdep_bit;
 =09u8=09=09modulemode;
 =09u8=09=09flags;
+=09int=09=09context_lost_counter;
 };
=20
=20
--=20
1.7.10.4
--843723315-1814594080-1347483657=:17903--
