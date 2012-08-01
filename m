From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH V2 08/10] ARM: OMAP4: Prevent EMU power domain transitioning
 to OFF when in-use
Date: Wed, 1 Aug 2012 09:36:13 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1208010932270.21488@utopia.booyaka.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com> <1339104132-26885-9-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1207111441300.25585@utopia.booyaka.com> <500028B3.1040309@ti.com> <alpine.DEB.2.00.1207131418500.25585@utopia.booyaka.com>
 <50045D17.9050704@ti.com> <alpine.DEB.2.00.1207161228470.28834@utopia.booyaka.com> <50171841.40309@ti.com> <501760BF.8070801@ti.com> <5018210A.1040902@ti.com> <50187644.40308@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-911869461-1343835308=:21488"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40653 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755547Ab2HAPgP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Aug 2012 11:36:15 -0400
In-Reply-To: <50187644.40308@ti.com>
Content-ID: <alpine.DEB.2.00.1208010935140.21488@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Madhav Vij <mvij@ti.com>=?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-911869461-1343835308=:21488
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1208010935141.21488@utopia.booyaka.com>

Hi Jon et al,

Here's what I'm planning to queue here.  The only changes from what Jon
posted are the patch changelog and some checkpatch fixes.  If anyone
has any final comments, please let me know.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Wed, 1 Aug 2012 09:11:20 -0600
Subject: [PATCH] ARM: OMAP2+: clockdomain/hwmod: add workaround for EMU
 clockdomain idle problems

The idle status of the IP blocks and clocks inside the EMU clockdomain
isn't taken into account by the PRCM hardware when deciding whether
the clockdomain is idle.  Add a workaround flag in the clockdomain
code, CLKDM_MISSING_IDLE_REPORTING, to deal with this problem, and add
the code necessary to support it.

If CLKDM_MISSING_IDLE_REPORTING is set on a clockdomain, the
clockdomain will be forced active whenever an IP block inside that
clockdomain is in use, even if the clockdomain supports
hardware-supervised idle.  When the kernel indicates that the last
active IP block inside the clockdomain is no longer used, the
clockdomain will be forced idle, or, if that mode is not supported in
the hardware, it will be placed into hardware-supervised idle.

This patch is an equal collaboration with Jon Hunter
<jon-hunter@ti.com>.  Ming Lei <ming.lei@canonical.com>, Will Deacon
<will.deacon@arm.com>, Madhav Vij <mvij@ti.com>, Kevin Hilman
<khilman@ti.com>, Beno=EEt Cousson <b-cousson@ti.com>, and Santosh
Shilimkar <santosh.shilimkar@ti.com> all made essential contributions
to the understanding of EMU clockdomain power management on OMAP.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Jon Hunter <jon-hunter@ti.com>
Cc: Ming Lei <ming.lei@canonical.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Madhav Vij <mvij@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Beno=EEt Cousson <b-cousson@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c           |   17 +++++++++++++++++
 arch/arm/mach-omap2/clockdomain.h           |   20 +++++++++++++++++---
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c  |   22 ++++++++++++++++++++++
 arch/arm/mach-omap2/clockdomain44xx.c       |   11 +++++++++++
 arch/arm/mach-omap2/clockdomains3xxx_data.c |    7 ++-----
 arch/arm/mach-omap2/clockdomains44xx_data.c |    3 ++-
 arch/arm/mach-omap2/omap_hwmod.c            |    3 ++-
 arch/arm/mach-omap2/pm.c                    |    3 ++-
 8 files changed, 75 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockd=
omain.c
index b851ba4..17b1d32 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -914,6 +914,23 @@ bool clkdm_in_hwsup(struct clockdomain *clkdm)
 =09return ret;
 }
=20
+/**
+ * clkdm_missing_idle_reporting - can @clkdm enter autoidle even if in use=
?
+ * @clkdm: struct clockdomain *
+ *
+ * Returns true if clockdomain @clkdm has the
+ * CLKDM_MISSING_IDLE_REPORTING flag set, or false if not or @clkdm is
+ * null.  More information is available in the documentation for the
+ * CLKDM_MISSING_IDLE_REPORTING macro.
+ */
+bool clkdm_missing_idle_reporting(struct clockdomain *clkdm)
+{
+=09if (!clkdm)
+=09=09return false;
+
+=09return (clkdm->flags & CLKDM_MISSING_IDLE_REPORTING) ? true : false;
+}
+
 /* Clockdomain-to-clock/hwmod framework interface code */
=20
 static int _clkdm_clk_hwmod_enable(struct clockdomain *clkdm)
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockd=
omain.h
index 7b3c1d2..fb5d37f 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -1,9 +1,7 @@
 /*
- * arch/arm/plat-omap/include/mach/clockdomain.h
- *
  * OMAP2/3 clockdomain framework functions
  *
- * Copyright (C) 2008 Texas Instruments, Inc.
+ * Copyright (C) 2008, 2012 Texas Instruments, Inc.
  * Copyright (C) 2008-2011 Nokia Corporation
  *
  * Paul Walmsley
@@ -34,6 +32,20 @@
  * CLKDM_ACTIVE_WITH_MPU: The PRCM guarantees that this clockdomain is
  *     active whenever the MPU is active.  True for interconnects and
  *     the WKUP clockdomains.
+ * CLKDM_MISSING_IDLE_REPORTING: The idle status of the IP blocks and
+ *     clocks inside this clockdomain are not taken into account by
+ *     the PRCM when determining whether the clockdomain is idle.
+ *     Without this flag, if the clockdomain is set to
+ *     hardware-supervised idle mode, the PRCM may transition the
+ *     enclosing powerdomain to a low power state, even when devices
+ *     inside the clockdomain and powerdomain are in use.  (An example
+ *     of such a clockdomain is the EMU clockdomain on OMAP3/4.)  If
+ *     this flag is set, and the clockdomain does not support the
+ *     force-sleep mode, then the HW_AUTO mode will be used to put the
+ *     clockdomain to sleep.  Similarly, if the clockdomain supports
+ *     the force-wakeup mode, then it will be used whenever a clock or
+ *     IP block inside the clockdomain is active, rather than the
+ *     HW_AUTO mode.
  */
 #define CLKDM_CAN_FORCE_SLEEP=09=09=09(1 << 0)
 #define CLKDM_CAN_FORCE_WAKEUP=09=09=09(1 << 1)
@@ -41,6 +53,7 @@
 #define CLKDM_CAN_DISABLE_AUTO=09=09=09(1 << 3)
 #define CLKDM_NO_AUTODEPS=09=09=09(1 << 4)
 #define CLKDM_ACTIVE_WITH_MPU=09=09=09(1 << 5)
+#define CLKDM_MISSING_IDLE_REPORTING=09=09(1 << 6)
=20
 #define CLKDM_CAN_HWSUP=09=09(CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_DISABLE_AU=
TO)
 #define CLKDM_CAN_SWSUP=09=09(CLKDM_CAN_FORCE_SLEEP | CLKDM_CAN_FORCE_WAKE=
UP)
@@ -188,6 +201,7 @@ int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm=
);
 void clkdm_allow_idle(struct clockdomain *clkdm);
 void clkdm_deny_idle(struct clockdomain *clkdm);
 bool clkdm_in_hwsup(struct clockdomain *clkdm);
+bool clkdm_missing_idle_reporting(struct clockdomain *clkdm);
=20
 int clkdm_wakeup(struct clockdomain *clkdm);
 int clkdm_sleep(struct clockdomain *clkdm);
diff --git a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c b/arch/arm/mach-oma=
p2/clockdomain2xxx_3xxx.c
index f99e65c..3f4b04b 100644
--- a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
@@ -248,6 +248,17 @@ static int omap3xxx_clkdm_clk_enable(struct clockdomai=
n *clkdm)
 =09if (!clkdm->clktrctrl_mask)
 =09=09return 0;
=20
+=09/*
+=09 * The CLKDM_MISSING_IDLE_REPORTING flag documentation has
+=09 * more details on the unpleasant problem this is working
+=09 * around
+=09 */
+=09if ((clkdm->flags & CLKDM_MISSING_IDLE_REPORTING) &&
+=09    (clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)) {
+=09=09omap3_clkdm_wakeup(clkdm);
+=09=09return 0;
+=09}
+
 =09hwsup =3D omap2_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
 =09=09=09=09clkdm->clktrctrl_mask);
=20
@@ -271,6 +282,17 @@ static int omap3xxx_clkdm_clk_disable(struct clockdoma=
in *clkdm)
 =09if (!clkdm->clktrctrl_mask)
 =09=09return 0;
=20
+=09/*
+=09 * The CLKDM_MISSING_IDLE_REPORTING flag documentation has
+=09 * more details on the unpleasant problem this is working
+=09 * around
+=09 */
+=09if (clkdm->flags & CLKDM_MISSING_IDLE_REPORTING &&
+=09    !(clkdm->flags & CLKDM_CAN_FORCE_SLEEP)) {
+=09=09_enable_hwsup(clkdm);
+=09=09return 0;
+=09}
+
 =09hwsup =3D omap2_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
 =09=09=09=09clkdm->clktrctrl_mask);
=20
diff --git a/arch/arm/mach-omap2/clockdomain44xx.c b/arch/arm/mach-omap2/cl=
ockdomain44xx.c
index 762f2cc..6fc6155 100644
--- a/arch/arm/mach-omap2/clockdomain44xx.c
+++ b/arch/arm/mach-omap2/clockdomain44xx.c
@@ -113,6 +113,17 @@ static int omap4_clkdm_clk_disable(struct clockdomain =
*clkdm)
 =09if (!clkdm->prcm_partition)
 =09=09return 0;
=20
+=09/*
+=09 * The CLKDM_MISSING_IDLE_REPORTING flag documentation has
+=09 * more details on the unpleasant problem this is working
+=09 * around
+=09 */
+=09if (clkdm->flags & CLKDM_MISSING_IDLE_REPORTING &&
+=09    !(clkdm->flags & CLKDM_CAN_FORCE_SLEEP)) {
+=09=09omap4_clkdm_allow_idle(clkdm);
+=09=09return 0;
+=09}
+
 =09hwsup =3D omap4_cminst_is_clkdm_in_hwsup(clkdm->prcm_partition,
 =09=09=09=09=09clkdm->cm_inst, clkdm->clkdm_offs);
=20
diff --git a/arch/arm/mach-omap2/clockdomains3xxx_data.c b/arch/arm/mach-om=
ap2/clockdomains3xxx_data.c
index 56089c4..933a35c 100644
--- a/arch/arm/mach-omap2/clockdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains3xxx_data.c
@@ -387,14 +387,11 @@ static struct clockdomain per_am35x_clkdm =3D {
 =09.clktrctrl_mask =3D OMAP3430_CLKTRCTRL_PER_MASK,
 };
=20
-/*
- * Disable hw supervised mode for emu_clkdm, because emu_pwrdm is
- * switched of even if sdti is in use
- */
 static struct clockdomain emu_clkdm =3D {
 =09.name=09=09=3D "emu_clkdm",
 =09.pwrdm=09=09=3D { .name =3D "emu_pwrdm" },
-=09.flags=09=09=3D /* CLKDM_CAN_ENABLE_AUTO |  */CLKDM_CAN_SWSUP,
+=09.flags=09=09=3D (CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_SWSUP |
+=09=09=09   CLKDM_MISSING_IDLE_REPORTING),
 =09.clktrctrl_mask =3D OMAP3430_CLKTRCTRL_EMU_MASK,
 };
=20
diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-om=
ap2/clockdomains44xx_data.c
index 63d60a7..b56d06b 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -390,7 +390,8 @@ static struct clockdomain emu_sys_44xx_clkdm =3D {
 =09.prcm_partition=09  =3D OMAP4430_PRM_PARTITION,
 =09.cm_inst=09  =3D OMAP4430_PRM_EMU_CM_INST,
 =09.clkdm_offs=09  =3D OMAP4430_PRM_EMU_CM_EMU_CDOFFS,
-=09.flags=09=09  =3D CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_FORCE_WAKEUP,
+=09.flags=09=09  =3D (CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_FORCE_WAKEUP |
+=09=09=09     CLKDM_MISSING_IDLE_REPORTING),
 };
=20
 static struct clockdomain l3_dma_44xx_clkdm =3D {
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hw=
mod.c
index 6ca8e51..36f0603 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1857,7 +1857,8 @@ static int _enable(struct omap_hwmod *oh)
 =09=09 * completely the module. The clockdomain can be set
 =09=09 * in HW_AUTO only when the module become ready.
 =09=09 */
-=09=09hwsup =3D clkdm_in_hwsup(oh->clkdm);
+=09=09hwsup =3D clkdm_in_hwsup(oh->clkdm) &&
+=09=09=09!clkdm_missing_idle_reporting(oh->clkdm);
 =09=09r =3D clkdm_hwmod_enable(oh->clkdm, oh);
 =09=09if (r) {
 =09=09=09WARN(1, "omap_hwmod: %s: could not enable clockdomain %s: %d\n",
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 9cb5ced..4182564 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -80,7 +80,8 @@ static void __init omap2_init_processor_devices(void)
=20
 int __init omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused)
 {
-=09if (clkdm->flags & CLKDM_CAN_ENABLE_AUTO)
+=09if ((clkdm->flags & CLKDM_CAN_ENABLE_AUTO) &&
+=09    !(clkdm->flags & CLKDM_MISSING_IDLE_REPORTING))
 =09=09clkdm_allow_idle(clkdm);
 =09else if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP &&
 =09=09 atomic_read(&clkdm->usecount) =3D=3D 0)
--=20
1.7.10.4
--155748971-911869461-1343835308=:21488--
