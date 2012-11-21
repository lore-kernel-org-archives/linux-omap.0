From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv9 1/8] ARM: OMAP: hwmod: Add support for per hwmod/module
 context lost count
Date: Wed, 21 Nov 2012 23:05:23 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211212259150.9132@utopia.booyaka.com>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
 <1350552010-28760-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
 BOUNDARY="843723315-2130916735-1353539123=:32242"
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1350552010-28760-2-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-2130916735-1353539123=:32242
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 18 Oct 2012, Tero Kristo wrote:

> From: Rajendra Nayak <rnayak@ti.com>
>=20
> OMAP4 has module specific context lost registers which makes it now
> possible to have module level context loss count, instead of relying
> on the powerdomain level context count.
>=20
> Add 2 private hwmod api's to update/clear the hwmod/module specific
> context lost counters/register.
>=20
> Update the module specific context_lost_counter and clear the hardware
> bits just after enabling the module.
>=20
> omap_hwmod_get_context_loss_count() now returns the hwmod context loss
> count them on platforms where they exist (OMAP4), else fall back on
> the pwrdm level counters for older platforms.
>=20
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> [paul@pwsan.com: added function kerneldoc, fixed structure kerneldoc,
>  rearranged structure to avoid memory waste, marked fns as OMAP4-specific=
,
>  prevent fn entry on non-OMAP4 chips, reduced indentation, merged update
>  and clear, merged patches]
> [t-kristo@ti.com: added support for arch specific hwmod ops, and changed
>  the no context offset indicator to USHRT_MAX]
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> [paul@pwsan.com: use NO_CONTEXT_LOSS_BIT flag rather than USHRT_MAX;
>  convert unsigned context lost counter to int to match the return type;
>  get rid of hwmod_ops in favor of the existing soc_ops mechanism]
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

Here's an updated version of this one with the low-level PRM accesses=20
moved out to the PRM code.


- Paul

From: Rajendra Nayak <rnayak@ti.com>
Date: Wed, 21 Nov 2012 11:48:46 -0700
Subject: [PATCH] ARM: OMAP2+: hwmod: Add support for per hwmod/module conte=
xt
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
 get rid of hwmod_ops in favor of the existing soc_ops mechanism;
 move context loss low-level accesses to the PRM code]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   55 ++++++++++++++++++++++++++++++++++=
+---
 arch/arm/mach-omap2/omap_hwmod.h |   10 ++++---
 arch/arm/mach-omap2/prm.h        |   11 +++++++-
 arch/arm/mach-omap2/prm44xx.c    |   33 +++++++++++++++++++++++
 arch/arm/mach-omap2/prm_common.c |   45 +++++++++++++++++++++++++++++++
 5 files changed, 146 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hw=
mod.c
index 68616b2..083adbe 100644
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
@@ -1983,6 +1985,42 @@ static void _reconfigure_io_chain(void)
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
+=09if (oh->prcm.omap4.flags & HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT)
+=09=09return;
+
+=09if (!prm_was_any_context_lost_old(oh->clkdm->pwrdm.ptr->prcm_partition,
+=09=09=09=09=09  oh->clkdm->pwrdm.ptr->prcm_offs,
+=09=09=09=09=09  oh->prcm.omap4.context_offs))
+=09=09return;
+
+=09oh->prcm.omap4.context_lost_counter++;
+=09prm_clear_context_loss_flags_old(oh->clkdm->pwrdm.ptr->prcm_partition,
+=09=09=09=09=09 oh->clkdm->pwrdm.ptr->prcm_offs,
+=09=09=09=09=09 oh->prcm.omap4.context_offs);
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
@@ -2065,6 +2103,9 @@ static int _enable(struct omap_hwmod *oh)
 =09if (soc_ops.enable_module)
 =09=09soc_ops.enable_module(oh);
=20
+=09if (soc_ops.update_context_lost)
+=09=09soc_ops.update_context_lost(oh);
+
 =09r =3D (soc_ops.wait_target_ready) ? soc_ops.wait_target_ready(oh) :
 =09=09-EINVAL;
 =09if (!r) {
@@ -3907,17 +3948,21 @@ ohsps_unlock:
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
@@ -4032,6 +4077,8 @@ void __init omap_hwmod_init(void)
 =09=09soc_ops.deassert_hardreset =3D _omap4_deassert_hardreset;
 =09=09soc_ops.is_hardreset_asserted =3D _omap4_is_hardreset_asserted;
 =09=09soc_ops.init_clkdm =3D _init_clkdm;
+=09=09soc_ops.update_context_lost =3D _omap4_update_context_lost;
+=09=09soc_ops.get_context_lost =3D _omap4_get_context_lost;
 =09} else if (soc_is_am33xx()) {
 =09=09soc_ops.enable_module =3D _am33xx_enable_module;
 =09=09soc_ops.disable_module =3D _am33xx_disable_module;
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hw=
mod.h
index 87b59b4..421ff65 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -2,7 +2,7 @@
  * omap_hwmod macros, structures
  *
  * Copyright (C) 2009-2011 Nokia Corporation
- * Copyright (C) 2012 Texas Instruments, Inc.
+ * Copyright (C) 2011-2012 Texas Instruments, Inc.
  * Paul Walmsley
  *
  * Created in collaboration with (alphabetical order): Beno=EEt Cousson,
@@ -394,12 +394,15 @@ struct omap_hwmod_omap2_prcm {
=20
 /**
  * struct omap_hwmod_omap4_prcm - OMAP4-specific PRCM data
- * @clkctrl_reg: PRCM address of the clock control register
- * @rstctrl_reg: address of the XXX_RSTCTRL register located in the PRM
+ * @clkctrl_offs: offset of the PRCM clock control register
+ * @rstctrl_offs: offset of the XXX_RSTCTRL register located in the PRM
+ * @context_offs: offset of the RM_*_CONTEXT register
  * @lostcontext_mask: bitmask for selecting bits from RM_*_CONTEXT registe=
r
  * @rstst_reg: (AM33XX only) address of the XXX_RSTST register in the PRM
  * @submodule_wkdep_bit: bit shift of the WKDEP range
  * @flags: PRCM register capabilities for this IP block
+ * @modulemode: allowable modulemodes
+ * @context_lost_counter: Count of module level context lost
  *
  * If @lostcontext_mask is not defined, context loss check code uses
  * whole register without masking. @lostcontext_mask should only be
@@ -415,6 +418,7 @@ struct omap_hwmod_omap4_prcm {
 =09u8=09=09submodule_wkdep_bit;
 =09u8=09=09modulemode;
 =09u8=09=09flags;
+=09int=09=09context_lost_counter;
 };
=20
=20
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index a1a266c..ac25ae6 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -114,16 +114,25 @@ struct prm_reset_src_map {
=20
 /**
  * struct prm_ll_data - fn ptrs to per-SoC PRM function implementations
- * @read_reset_sources: ptr to the Soc PRM-specific get_reset_source impl
+ * @read_reset_sources: ptr to the SoC PRM-specific get_reset_source impl
+ * @was_any_context_lost_old: ptr to the SoC PRM context loss test fn
+ * @clear_context_loss_flags_old: ptr to the SoC PRM context loss flag cle=
ar fn
+ *
+ * XXX @was_any_context_lost_old and @clear_context_loss_flags_old are
+ * deprecated.
  */
 struct prm_ll_data {
 =09u32 (*read_reset_sources)(void);
+=09bool (*was_any_context_lost_old)(u8 part, s16 inst, u16 idx);
+=09void (*clear_context_loss_flags_old)(u8 part, s16 inst, u16 idx);
 };
=20
 extern int prm_register(struct prm_ll_data *pld);
 extern int prm_unregister(struct prm_ll_data *pld);
=20
 extern u32 prm_read_reset_sources(void);
+extern bool prm_was_any_context_lost_old(u8 part, s16 inst, u16 idx);
+extern void prm_clear_context_loss_flags_old(u8 part, s16 inst, u16 idx);
=20
 #endif
=20
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 9db1bd2..7498bc7 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -346,6 +346,37 @@ static u32 omap44xx_prm_read_reset_sources(void)
 =09return r;
 }
=20
+/**
+ * omap44xx_prm_was_any_context_lost_old - was module hardware context los=
t?
+ * @part: PRM partition ID (e.g., OMAP4430_PRM_PARTITION)
+ * @inst: PRM instance offset (e.g., OMAP4430_PRM_MPU_INST)
+ * @idx: CONTEXT register offset
+ *
+ * Return 1 if any bits were set in the *_CONTEXT_* register
+ * identified by (@part, @inst, @idx), which means that some context
+ * was lost for that module; otherwise, return 0.
+ */
+static bool omap44xx_prm_was_any_context_lost_old(u8 part, s16 inst, u16 i=
dx)
+{
+=09return (omap4_prminst_read_inst_reg(part, inst, idx)) ? 1 : 0;
+}
+
+/**
+ * omap44xx_prm_clear_context_lost_flags_old - clear context loss flags
+ * @part: PRM partition ID (e.g., OMAP4430_PRM_PARTITION)
+ * @inst: PRM instance offset (e.g., OMAP4430_PRM_MPU_INST)
+ * @idx: CONTEXT register offset
+ *
+ * Clear hardware context loss bits for the module identified by
+ * (@part, @inst, @idx).  No return value.  XXX Writes to reserved bits;
+ * is there a way to avoid this?
+ */
+static void omap44xx_prm_clear_context_loss_flags_old(u8 part, s16 inst,
+=09=09=09=09=09=09      u16 idx)
+{
+=09omap4_prminst_write_inst_reg(0xffffffff, part, inst, idx);
+}
+
 /* Powerdomain low-level functions */
=20
 static int omap4_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
@@ -613,6 +644,8 @@ struct pwrdm_ops omap4_pwrdm_operations =3D {
  */
 static struct prm_ll_data omap44xx_prm_ll_data =3D {
 =09.read_reset_sources =3D &omap44xx_prm_read_reset_sources,
+=09.was_any_context_lost_old =3D &omap44xx_prm_was_any_context_lost_old,
+=09.clear_context_loss_flags_old =3D &omap44xx_prm_clear_context_loss_flag=
s_old,
 };
=20
 int __init omap44xx_prm_init(void)
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_com=
mon.c
index d2e0798..c6ae53c 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -367,6 +367,51 @@ u32 prm_read_reset_sources(void)
 }
=20
 /**
+ * prm_was_any_context_lost_old - was device context lost? (old API)
+ * @part: PRM partition ID (e.g., OMAP4430_PRM_PARTITION)
+ * @inst: PRM instance offset (e.g., OMAP4430_PRM_MPU_INST)
+ * @idx: CONTEXT register offset
+ *
+ * Return 1 if any bits were set in the *_CONTEXT_* register
+ * identified by (@part, @inst, @idx), which means that some context
+ * was lost for that module; otherwise, return 0.  XXX Deprecated;
+ * callers need to use a less-SoC-dependent way to identify hardware
+ * IP blocks.
+ */
+bool prm_was_any_context_lost_old(u8 part, s16 inst, u16 idx)
+{
+=09bool ret =3D true;
+
+=09if (prm_ll_data->was_any_context_lost_old)
+=09=09ret =3D prm_ll_data->was_any_context_lost_old(part, inst, idx);
+=09else
+=09=09WARN_ONCE(1, "prm: %s: no mapping function defined\n",
+=09=09=09  __func__);
+
+=09return ret;
+}
+
+/**
+ * prm_clear_context_lost_flags_old - clear context loss flags (old API)
+ * @part: PRM partition ID (e.g., OMAP4430_PRM_PARTITION)
+ * @inst: PRM instance offset (e.g., OMAP4430_PRM_MPU_INST)
+ * @idx: CONTEXT register offset
+ *
+ * Clear hardware context loss bits for the module identified by
+ * (@part, @inst, @idx).  No return value.  XXX Deprecated; callers
+ * need to use a less-SoC-dependent way to identify hardware IP
+ * blocks.
+ */
+void prm_clear_context_loss_flags_old(u8 part, s16 inst, u16 idx)
+{
+=09if (prm_ll_data->clear_context_loss_flags_old)
+=09=09prm_ll_data->clear_context_loss_flags_old(part, inst, idx);
+=09else
+=09=09WARN_ONCE(1, "prm: %s: no mapping function defined\n",
+=09=09=09  __func__);
+}
+
+/**
  * prm_register - register per-SoC low-level data with the PRM
  * @pld: low-level per-SoC OMAP PRM data & function pointers to register
  *
--=20
1.7.10.4

--843723315-2130916735-1353539123=:32242
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--843723315-2130916735-1353539123=:32242--
