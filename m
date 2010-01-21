From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 05/10] OMAP clockdomains: add usecounting for wakeup and
 sleep dependencies
Date: Wed, 20 Jan 2010 21:45:21 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001202141090.24456@utopia.booyaka.com>
References: <20100112010258.6275.97999.stgit@localhost.localdomain> <20100112010537.6275.74977.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-356213667-1264049121=:24456"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51964 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754120Ab0AUEpW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jan 2010 23:45:22 -0500
In-Reply-To: <20100112010537.6275.74977.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@deeprootsystems.com, jouni.hogander@nokia.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-356213667-1264049121=:24456
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE


Hi,

Kevin identified two bugs in this patch (and the one that immediately=20
followed it) during PM branch testing.  These bugs, and the fixes=20
implemented for them, are described below in the revised patch. In the=20
process of fixing it, this patch and the next one were combined.

This patch has taken the place of the previously-posted 05/10 and 06/10=20
patches in the for_2.6.34 branch.

regards,

- Paul


From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP clockdomains: add usecounting for wakeup and sleep de=
pendencies

Add usecounting for wakeup and sleep dependencies.  In the current
situation, if several functions add dependencies on the same
clockdomains, when the first dependency removal function is called,
the dependency will be incorrectly removed from the hardware.

Add clkdm_clear_all_wkdeps() and clkdm_clear_all_sleepdeps(), which
provide a fast and usecounting-consistent way to clear all hardware
clockdomain dependencies, since accesses to these registers can be
quite slow.  pm{2,3}4xx.c has been updated to use these new functions.
The original version of this patch did not touch these files, which
previously wrote directly to the wkdep registers, and thus confused
the usecounting code.  This problem was found by Kevin Hilman
<khilman@deeprootsystems.com>.

N.B.: This patch introduces one significant functional difference over
the previous pm34xx.c code: sleepdeps are now cleared during
clockdomain initialization, whereas previously they were left
untouched.  This has been tested by Kevin and confirmed to work.

The original version of this patch also did not take into
consideration that some clockdomains do not have sleep or wakeup
dependency sources, which caused NULL pointer dereferences.  This
problem was debugged and fixed by Kevin Hilman
<khilman@deeprootsystems.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Jouni H=F6gander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/clockdomain.c             |  216 +++++++++++++++++++++=
+---
 arch/arm/mach-omap2/pm24xx.c                  |   49 ++++---
 arch/arm/mach-omap2/pm34xx.c                  |    3 +
 arch/arm/plat-omap/include/plat/clockdomain.h |    8 +
 4 files changed, 237 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockd=
omain.c
index 2af9996..6eaa931 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -113,7 +113,6 @@ static struct clkdm_dep *_clkdm_deps_lookup(struct cloc=
kdomain *clkdm,
 =09=09return ERR_PTR(-EINVAL);
=20
 =09for (cd =3D deps; cd->clkdm_name; cd++) {
-
 =09=09if (!omap_chip_is(cd->omap_chip))
 =09=09=09continue;
=20
@@ -122,7 +121,6 @@ static struct clkdm_dep *_clkdm_deps_lookup(struct cloc=
kdomain *clkdm,
=20
 =09=09if (cd->clkdm =3D=3D clkdm)
 =09=09=09break;
-
 =09}
=20
 =09if (!cd->clkdm_name)
@@ -254,6 +252,96 @@ static void _omap2_clkdm_set_hwsup(struct clockdomain =
*clkdm, int enable)
=20
 }
=20
+/**
+ * _init_wkdep_usecount - initialize wkdep usecounts to match hardware
+ * @clkdm: clockdomain to initialize wkdep usecounts
+ *
+ * Initialize the wakeup dependency usecount variables for clockdomain @cl=
kdm.
+ * If a wakeup dependency is present in the hardware, the usecount will be
+ * set to 1; otherwise, it will be set to 0.  Software should clear all
+ * software wakeup dependencies prior to calling this function if it wishe=
s
+ * to ensure that all usecounts start at 0.  No return value.
+ */
+static void _init_wkdep_usecount(struct clockdomain *clkdm)
+{
+=09u32 v;
+=09struct clkdm_dep *cd;
+
+=09if (!clkdm->wkdep_srcs)
+=09=09return;
+
+=09for (cd =3D clkdm->wkdep_srcs; cd->clkdm_name; cd++) {
+=09=09if (!omap_chip_is(cd->omap_chip))
+=09=09=09continue;
+
+=09=09if (!cd->clkdm && cd->clkdm_name)
+=09=09=09cd->clkdm =3D _clkdm_lookup(cd->clkdm_name);
+
+=09=09if (!cd->clkdm) {
+=09=09=09WARN(!cd->clkdm, "clockdomain: %s: wkdep clkdm %s not "
+=09=09=09     "found\n", clkdm->name, cd->clkdm_name);
+=09=09=09continue;
+=09=09}
+
+=09=09v =3D prm_read_mod_bits_shift(clkdm->pwrdm.ptr->prcm_offs,
+=09=09=09=09=09    PM_WKDEP,
+=09=09=09=09=09    (1 << cd->clkdm->dep_bit));
+
+=09=09if (v)
+=09=09=09pr_debug("clockdomain: %s: wakeup dependency already "
+=09=09=09=09 "set to wake up when %s wakes\n",
+=09=09=09=09 clkdm->name, cd->clkdm->name);
+
+=09=09atomic_set(&cd->wkdep_usecount, (v) ? 1 : 0);
+=09}
+}
+
+/**
+ * _init_sleepdep_usecount - initialize sleepdep usecounts to match hardwa=
re
+ * @clkdm: clockdomain to initialize sleepdep usecounts
+ *
+ * Initialize the sleep dependency usecount variables for clockdomain @clk=
dm.
+ * If a sleep dependency is present in the hardware, the usecount will be
+ * set to 1; otherwise, it will be set to 0.  Software should clear all
+ * software sleep dependencies prior to calling this function if it wishes
+ * to ensure that all usecounts start at 0.  No return value.
+ */
+static void _init_sleepdep_usecount(struct clockdomain *clkdm)
+{
+=09u32 v;
+=09struct clkdm_dep *cd;
+
+=09if (!cpu_is_omap34xx())
+=09=09return;
+
+=09if (!clkdm->sleepdep_srcs)
+=09=09return;
+
+=09for (cd =3D clkdm->sleepdep_srcs; cd->clkdm_name; cd++) {
+=09=09if (!omap_chip_is(cd->omap_chip))
+=09=09=09continue;
+
+=09=09if (!cd->clkdm && cd->clkdm_name)
+=09=09=09cd->clkdm =3D _clkdm_lookup(cd->clkdm_name);
+
+=09=09if (!cd->clkdm) {
+=09=09=09WARN(!cd->clkdm, "clockdomain: %s: sleepdep clkdm %s "
+=09=09=09     "not found\n", clkdm->name, cd->clkdm_name);
+=09=09=09continue;
+=09=09}
+
+=09=09v =3D prm_read_mod_bits_shift(clkdm->pwrdm.ptr->prcm_offs,
+=09=09=09=09=09    OMAP3430_CM_SLEEPDEP,
+=09=09=09=09=09    (1 << cd->clkdm->dep_bit));
+
+=09=09if (v)
+=09=09=09pr_debug("clockdomain: %s: sleep dependency already "
+=09=09=09=09 "set to prevent from idling until %s "
+=09=09=09=09 "idles\n", clkdm->name, cd->clkdm->name);
+
+=09=09atomic_set(&cd->sleepdep_usecount, (v) ? 1 : 0);
+=09}
+};
=20
 /* Public functions */
=20
@@ -272,6 +360,7 @@ void clkdm_init(struct clockdomain **clkdms,
 =09=09struct clkdm_autodep *init_autodeps)
 {
 =09struct clockdomain **c =3D NULL;
+=09struct clockdomain *clkdm;
 =09struct clkdm_autodep *autodep =3D NULL;
=20
 =09if (clkdms)
@@ -282,6 +371,15 @@ void clkdm_init(struct clockdomain **clkdms,
 =09if (autodeps)
 =09=09for (autodep =3D autodeps; autodep->clkdm.ptr; autodep++)
 =09=09=09_autodep_lookup(autodep);
+
+=09/*
+=09 * Ensure that the *dep_usecount registers reflect the current
+=09 * state of the PRCM.
+=09 */
+=09list_for_each_entry(clkdm, &clkdm_list, node) {
+=09=09_init_wkdep_usecount(clkdm);
+=09=09_init_sleepdep_usecount(clkdm);
+=09}
 }
=20
 /**
@@ -387,11 +485,13 @@ int clkdm_add_wkdep(struct clockdomain *clkdm1, struc=
t clockdomain *clkdm2)
 =09=09return PTR_ERR(cd);
 =09}
=20
-=09pr_debug("clockdomain: hardware will wake up %s when %s wakes up\n",
-=09=09 clkdm1->name, clkdm2->name);
+=09if (atomic_inc_return(&cd->wkdep_usecount) =3D=3D 1) {
+=09=09pr_debug("clockdomain: hardware will wake up %s when %s wakes "
+=09=09=09 "up\n", clkdm1->name, clkdm2->name);
=20
-=09prm_set_mod_reg_bits((1 << clkdm2->dep_bit),
-=09=09=09     clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP);
+=09=09prm_set_mod_reg_bits((1 << clkdm2->dep_bit),
+=09=09=09=09     clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP);
+=09}
=20
 =09return 0;
 }
@@ -420,11 +520,13 @@ int clkdm_del_wkdep(struct clockdomain *clkdm1, struc=
t clockdomain *clkdm2)
 =09=09return PTR_ERR(cd);
 =09}
=20
-=09pr_debug("clockdomain: hardware will no longer wake up %s after %s "
-=09=09 "wakes up\n", clkdm1->name, clkdm2->name);
+=09if (atomic_dec_return(&cd->wkdep_usecount) =3D=3D 0) {
+=09=09pr_debug("clockdomain: hardware will no longer wake up %s "
+=09=09=09 "after %s wakes up\n", clkdm1->name, clkdm2->name);
=20
-=09prm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
-=09=09=09       clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP);
+=09=09prm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
+=09=09=09=09       clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP);
+=09}
=20
 =09return 0;
 }
@@ -457,11 +559,44 @@ int clkdm_read_wkdep(struct clockdomain *clkdm1, stru=
ct clockdomain *clkdm2)
 =09=09return PTR_ERR(cd);
 =09}
=20
+=09/* XXX It's faster to return the atomic wkdep_usecount */
 =09return prm_read_mod_bits_shift(clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP,
 =09=09=09=09       (1 << clkdm2->dep_bit));
 }
=20
 /**
+ * clkdm_clear_all_wkdeps - remove all wakeup dependencies from target clk=
dm
+ * @clkdm: struct clockdomain * to remove all wakeup dependencies from
+ *
+ * Remove all inter-clockdomain wakeup dependencies that could cause
+ * @clkdm to wake.  Intended to be used during boot to initialize the
+ * PRCM to a known state, after all clockdomains are put into swsup idle
+ * and woken up.  Returns -EINVAL if @clkdm pointer is invalid, or
+ * 0 upon success.
+ */
+int clkdm_clear_all_wkdeps(struct clockdomain *clkdm)
+{
+=09struct clkdm_dep *cd;
+=09u32 mask =3D 0;
+
+=09if (!clkdm)
+=09=09return -EINVAL;
+
+=09for (cd =3D clkdm->wkdep_srcs; cd && cd->clkdm_name; cd++) {
+=09=09if (!omap_chip_is(cd->omap_chip))
+=09=09=09continue;
+
+=09=09/* PRM accesses are slow, so minimize them */
+=09=09mask |=3D 1 << cd->clkdm->dep_bit;
+=09=09atomic_set(&cd->wkdep_usecount, 0);
+=09}
+
+=09prm_clear_mod_reg_bits(mask, clkdm->pwrdm.ptr->prcm_offs, PM_WKDEP);
+
+=09return 0;
+}
+
+/**
  * clkdm_add_sleepdep - add a sleep dependency from clkdm2 to clkdm1
  * @clkdm1: prevent this struct clockdomain * from sleeping (dependent)
  * @clkdm2: when this struct clockdomain * is active (source)
@@ -491,12 +626,14 @@ int clkdm_add_sleepdep(struct clockdomain *clkdm1, st=
ruct clockdomain *clkdm2)
 =09=09return PTR_ERR(cd);
 =09}
=20
-=09pr_debug("clockdomain: will prevent %s from sleeping if %s is active\n"=
,
-=09=09 clkdm1->name, clkdm2->name);
+=09if (atomic_inc_return(&cd->sleepdep_usecount) =3D=3D 1) {
+=09=09pr_debug("clockdomain: will prevent %s from sleeping if %s "
+=09=09=09 "is active\n", clkdm1->name, clkdm2->name);
=20
-=09cm_set_mod_reg_bits((1 << clkdm2->dep_bit),
-=09=09=09    clkdm1->pwrdm.ptr->prcm_offs,
-=09=09=09    OMAP3430_CM_SLEEPDEP);
+=09=09cm_set_mod_reg_bits((1 << clkdm2->dep_bit),
+=09=09=09=09    clkdm1->pwrdm.ptr->prcm_offs,
+=09=09=09=09    OMAP3430_CM_SLEEPDEP);
+=09}
=20
 =09return 0;
 }
@@ -531,12 +668,15 @@ int clkdm_del_sleepdep(struct clockdomain *clkdm1, st=
ruct clockdomain *clkdm2)
 =09=09return PTR_ERR(cd);
 =09}
=20
-=09pr_debug("clockdomain: will no longer prevent %s from sleeping if "
-=09=09 "%s is active\n", clkdm1->name, clkdm2->name);
+=09if (atomic_dec_return(&cd->sleepdep_usecount) =3D=3D 0) {
+=09=09pr_debug("clockdomain: will no longer prevent %s from "
+=09=09=09 "sleeping if %s is active\n", clkdm1->name,
+=09=09=09 clkdm2->name);
=20
-=09cm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
-=09=09=09      clkdm1->pwrdm.ptr->prcm_offs,
-=09=09=09      OMAP3430_CM_SLEEPDEP);
+=09=09cm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
+=09=09=09=09      clkdm1->pwrdm.ptr->prcm_offs,
+=09=09=09=09      OMAP3430_CM_SLEEPDEP);
+=09}
=20
 =09return 0;
 }
@@ -575,11 +715,47 @@ int clkdm_read_sleepdep(struct clockdomain *clkdm1, s=
truct clockdomain *clkdm2)
 =09=09return PTR_ERR(cd);
 =09}
=20
+=09/* XXX It's faster to return the atomic sleepdep_usecount */
 =09return prm_read_mod_bits_shift(clkdm1->pwrdm.ptr->prcm_offs,
 =09=09=09=09       OMAP3430_CM_SLEEPDEP,
 =09=09=09=09       (1 << clkdm2->dep_bit));
 }
=20
+/**
+ * clkdm_clear_all_sleepdeps - remove all sleep dependencies from target c=
lkdm
+ * @clkdm: struct clockdomain * to remove all sleep dependencies from
+ *
+ * Remove all inter-clockdomain sleep dependencies that could prevent
+ * @clkdm from idling.  Intended to be used during boot to initialize the
+ * PRCM to a known state, after all clockdomains are put into swsup idle
+ * and woken up.  Returns -EINVAL if @clkdm pointer is invalid, or
+ * 0 upon success.
+ */
+int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm)
+{
+=09struct clkdm_dep *cd;
+=09u32 mask =3D 0;
+
+=09if (!cpu_is_omap34xx())
+=09=09return -EINVAL;
+
+=09if (!clkdm)
+=09=09return -EINVAL;
+
+=09for (cd =3D clkdm->sleepdep_srcs; cd && cd->clkdm_name; cd++) {
+=09=09if (!omap_chip_is(cd->omap_chip))
+=09=09=09continue;
+
+=09=09/* PRM accesses are slow, so minimize them */
+=09=09mask |=3D 1 << cd->clkdm->dep_bit;
+=09=09atomic_set(&cd->sleepdep_usecount, 0);
+=09}
+
+=09prm_clear_mod_reg_bits(mask, clkdm->pwrdm.ptr->prcm_offs,
+=09=09=09       OMAP3430_CM_SLEEPDEP);
+
+=09return 0;
+}
=20
 /**
  * omap2_clkdm_clktrctrl_read - read the clkdm's current state transition =
mode
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 7543818..374299e 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -57,11 +57,8 @@ static void (*omap2_sram_idle)(void);
 static void (*omap2_sram_suspend)(u32 dllctrl, void __iomem *sdrc_dlla_ctr=
l,
 =09=09=09=09  void __iomem *sdrc_power);
=20
-static struct powerdomain *mpu_pwrdm;
-static struct powerdomain *core_pwrdm;
-
-static struct clockdomain *dsp_clkdm;
-static struct clockdomain *gfx_clkdm;
+static struct powerdomain *mpu_pwrdm, *core_pwrdm;
+static struct clockdomain *dsp_clkdm, *mpu_clkdm, *wkup_clkdm, *gfx_clkdm;
=20
 static struct clk *osc_ck, *emul_ck;
=20
@@ -334,9 +331,17 @@ static struct platform_suspend_ops omap_pm_ops =3D {
 =09.valid=09=09=3D suspend_valid_only_mem,
 };
=20
-static int _pm_clkdm_enable_hwsup(struct clockdomain *clkdm, void *unused)
+/* XXX This function should be shareable between OMAP2xxx and OMAP3 */
+static int __init clkdms_setup(struct clockdomain *clkdm, void *unused)
 {
-=09omap2_clkdm_allow_idle(clkdm);
+=09clkdm_clear_all_wkdeps(clkdm);
+=09clkdm_clear_all_sleepdeps(clkdm);
+
+=09if (clkdm->flags & CLKDM_CAN_ENABLE_AUTO)
+=09=09omap2_clkdm_allow_idle(clkdm);
+=09else if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP &&
+=09=09 atomic_read(&clkdm->usecount) =3D=3D 0)
+=09=09omap2_clkdm_sleep(clkdm);
 =09return 0;
 }
=20
@@ -349,14 +354,6 @@ static void __init prcm_setup_regs(void)
 =09prm_write_mod_reg(OMAP24XX_AUTOIDLE, OCP_MOD,
 =09=09=09  OMAP2_PRCM_SYSCONFIG_OFFSET);
=20
-=09/* Set all domain wakeup dependencies */
-=09prm_write_mod_reg(OMAP_EN_WKUP_MASK, MPU_MOD, PM_WKDEP);
-=09prm_write_mod_reg(0, OMAP24XX_DSP_MOD, PM_WKDEP);
-=09prm_write_mod_reg(0, GFX_MOD, PM_WKDEP);
-=09prm_write_mod_reg(0, CORE_MOD, PM_WKDEP);
-=09if (cpu_is_omap2430())
-=09=09prm_write_mod_reg(0, OMAP2430_MDM_MOD, PM_WKDEP);
-
 =09/*
 =09 * Set CORE powerdomain memory banks to retain their contents
 =09 * during RETENTION
@@ -385,8 +382,12 @@ static void __init prcm_setup_regs(void)
 =09pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_OFF);
 =09omap2_clkdm_sleep(gfx_clkdm);
=20
-=09/* Enable clockdomain hardware-supervised control for all clkdms */
-=09clkdm_for_each(_pm_clkdm_enable_hwsup, NULL);
+=09/*
+=09 * Clear clockdomain wakeup dependencies and enable
+=09 * hardware-supervised idle for all clkdms
+=09 */
+=09clkdm_for_each(clkdms_setup, NULL);
+=09clkdm_add_wkdep(mpu_clkdm, wkup_clkdm);
=20
 =09/* Enable clock autoidle for all domains */
 =09cm_write_mod_reg(OMAP24XX_AUTO_CAM |
@@ -482,7 +483,7 @@ static int __init omap2_pm_init(void)
 =09l =3D prm_read_mod_reg(OCP_MOD, OMAP2_PRCM_REVISION_OFFSET);
 =09printk(KERN_INFO "PRCM revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
=20
-=09/* Look up important powerdomains, clockdomains */
+=09/* Look up important powerdomains */
=20
 =09mpu_pwrdm =3D pwrdm_lookup("mpu_pwrdm");
 =09if (!mpu_pwrdm)
@@ -492,9 +493,19 @@ static int __init omap2_pm_init(void)
 =09if (!core_pwrdm)
 =09=09pr_err("PM: core_pwrdm not found\n");
=20
+=09/* Look up important clockdomains */
+
+=09mpu_clkdm =3D clkdm_lookup("mpu_clkdm");
+=09if (!mpu_clkdm)
+=09=09pr_err("PM: mpu_clkdm not found\n");
+
+=09wkup_clkdm =3D clkdm_lookup("wkup_clkdm");
+=09if (!wkup_clkdm)
+=09=09pr_err("PM: wkup_clkdm not found\n");
+
 =09dsp_clkdm =3D clkdm_lookup("dsp_clkdm");
 =09if (!dsp_clkdm)
-=09=09pr_err("PM: mpu_clkdm not found\n");
+=09=09pr_err("PM: dsp_clkdm not found\n");
=20
 =09gfx_clkdm =3D clkdm_lookup("gfx_clkdm");
 =09if (!gfx_clkdm)
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index c34c92e..d8c3b9a 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -993,6 +993,9 @@ static int __init pwrdms_setup(struct powerdomain *pwrd=
m, void *unused)
  */
 static int __init clkdms_setup(struct clockdomain *clkdm, void *unused)
 {
+=09clkdm_clear_all_wkdeps(clkdm);
+=09clkdm_clear_all_sleepdeps(clkdm);
+
 =09if (clkdm->flags & CLKDM_CAN_ENABLE_AUTO)
 =09=09omap2_clkdm_allow_idle(clkdm);
 =09else if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP &&
diff --git a/arch/arm/plat-omap/include/plat/clockdomain.h b/arch/arm/plat-=
omap/include/plat/clockdomain.h
index 2286971..45b5deb 100644
--- a/arch/arm/plat-omap/include/plat/clockdomain.h
+++ b/arch/arm/plat-omap/include/plat/clockdomain.h
@@ -70,6 +70,12 @@ struct clkdm_dep {
 =09/* Clockdomain pointer - resolved by the clockdomain code */
 =09struct clockdomain *clkdm;
=20
+=09/* Number of wakeup dependencies causing this clkdm to wake  */
+=09atomic_t wkdep_usecount;
+
+=09/* Number of sleep dependencies that could prevent clkdm from idle */
+=09atomic_t sleepdep_usecount;
+
 =09/* Flags to mark OMAP chip restrictions, etc. */
 =09const struct omap_chip_id omap_chip;
=20
@@ -126,9 +132,11 @@ struct powerdomain *clkdm_get_pwrdm(struct clockdomain=
 *clkdm);
 int clkdm_add_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2=
);
 int clkdm_del_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2=
);
 int clkdm_read_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm=
2);
+int clkdm_clear_all_wkdeps(struct clockdomain *clkdm);
 int clkdm_add_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clk=
dm2);
 int clkdm_del_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clk=
dm2);
 int clkdm_read_sleepdep(struct clockdomain *clkdm1, struct clockdomain *cl=
kdm2);
+int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm);
=20
 void omap2_clkdm_allow_idle(struct clockdomain *clkdm);
 void omap2_clkdm_deny_idle(struct clockdomain *clkdm);
--=20
1.6.6.rc2.5.g49666

--155748971-356213667-1264049121=:24456--
