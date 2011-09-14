From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v3 2/4] OMAP: clockdomain code/data: remove omap_chip bitmask
 from struct clockdomain
Date: Wed, 14 Sep 2011 17:18:45 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109141715480.15220@utopia.booyaka.com>
References: <20110914220723.12067.99495.stgit@dusk> <20110914224505.12067.37503.stgit@dusk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1477764176-1316042325=:15220"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52109 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148Ab1INXSr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Sep 2011 19:18:47 -0400
In-Reply-To: <20110914224505.12067.37503.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1477764176-1316042325=:15220
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE


At Tony's request, remove the omap_chip bitmasks from the clockdomain
and clockdomain dependency definitions.  Instead, initialize
clockdomains based on one or more lists that are applicable to a
particular SoC family, variant, and silicon revision.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
---

Tony found a bug in the previous version that attempts to register a=20
clkdm_dep to a 2430 clockdomain on 2420 chips.  This version fixes that. =
=20
Thanks Tony.

 arch/arm/mach-omap2/Makefile                     |    5 +-
 arch/arm/mach-omap2/clockdomain.c                |   19 +-
 arch/arm/mach-omap2/clockdomain.h                |   15 +-
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c       |    4 -
 arch/arm/mach-omap2/clockdomain44xx.c            |    2 -
 arch/arm/mach-omap2/clockdomains2420_data.c      |  154 ++++
 arch/arm/mach-omap2/clockdomains2430_data.c      |  181 +++++
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |  812 +-----------------=
----
 arch/arm/mach-omap2/clockdomains3xxx_data.c      |  398 +++++++++++
 arch/arm/mach-omap2/clockdomains44xx_data.c      |  404 ++---------
 arch/arm/mach-omap2/io.c                         |    4 +-
 11 files changed, 842 insertions(+), 1156 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomains2420_data.c
 create mode 100644 arch/arm/mach-omap2/clockdomains2430_data.c
 create mode 100644 arch/arm/mach-omap2/clockdomains3xxx_data.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index f343365..5a6fe73 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -116,9 +116,12 @@ obj-$(CONFIG_ARCH_OMAP4)=09=09+=3D $(powerdomain-commo=
n) \
 obj-$(CONFIG_ARCH_OMAP2)=09=09+=3D clockdomain.o \
 =09=09=09=09=09   clockdomain2xxx_3xxx.o \
 =09=09=09=09=09   clockdomains2xxx_3xxx_data.o
+obj-$(CONFIG_SOC_OMAP2420)=09=09+=3D clockdomains2420_data.o
+obj-$(CONFIG_SOC_OMAP2430)=09=09+=3D clockdomains2430_data.o
 obj-$(CONFIG_ARCH_OMAP3)=09=09+=3D clockdomain.o \
 =09=09=09=09=09   clockdomain2xxx_3xxx.o \
-=09=09=09=09=09   clockdomains2xxx_3xxx_data.o
+=09=09=09=09=09   clockdomains2xxx_3xxx_data.o \
+=09=09=09=09=09   clockdomains3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)=09=09+=3D clockdomain.o \
 =09=09=09=09=09   clockdomain44xx.o \
 =09=09=09=09=09   clockdomains44xx_data.o
diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockd=
omain.c
index b73a1dc..8480ee4 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -73,9 +73,6 @@ static int _clkdm_register(struct clockdomain *clkdm)
 =09if (!clkdm || !clkdm->name)
 =09=09return -EINVAL;
=20
-=09if (!omap_chip_is(clkdm->omap_chip))
-=09=09return -EINVAL;
-
 =09pwrdm =3D pwrdm_lookup(clkdm->pwrdm.name);
 =09if (!pwrdm) {
 =09=09pr_err("clockdomain: %s: powerdomain %s does not exist\n",
@@ -105,13 +102,10 @@ static struct clkdm_dep *_clkdm_deps_lookup(struct cl=
ockdomain *clkdm,
 {
 =09struct clkdm_dep *cd;
=20
-=09if (!clkdm || !deps || !omap_chip_is(clkdm->omap_chip))
+=09if (!clkdm || !deps)
 =09=09return ERR_PTR(-EINVAL);
=20
 =09for (cd =3D deps; cd->clkdm_name; cd++) {
-=09=09if (!omap_chip_is(cd->omap_chip))
-=09=09=09continue;
-
 =09=09if (!cd->clkdm && cd->clkdm_name)
 =09=09=09cd->clkdm =3D _clkdm_lookup(cd->clkdm_name);
=20
@@ -148,9 +142,6 @@ static void _autodep_lookup(struct clkdm_autodep *autod=
ep)
 =09if (!autodep)
 =09=09return;
=20
-=09if (!omap_chip_is(autodep->omap_chip))
-=09=09return;
-
 =09clkdm =3D clkdm_lookup(autodep->clkdm.name);
 =09if (!clkdm) {
 =09=09pr_err("clockdomain: autodeps: clockdomain %s does not exist\n",
@@ -182,9 +173,6 @@ void _clkdm_add_autodeps(struct clockdomain *clkdm)
 =09=09if (IS_ERR(autodep->clkdm.ptr))
 =09=09=09continue;
=20
-=09=09if (!omap_chip_is(autodep->omap_chip))
-=09=09=09continue;
-
 =09=09pr_debug("clockdomain: adding %s sleepdep/wkdep for "
 =09=09=09 "clkdm %s\n", autodep->clkdm.ptr->name,
 =09=09=09 clkdm->name);
@@ -216,9 +204,6 @@ void _clkdm_del_autodeps(struct clockdomain *clkdm)
 =09=09if (IS_ERR(autodep->clkdm.ptr))
 =09=09=09continue;
=20
-=09=09if (!omap_chip_is(autodep->omap_chip))
-=09=09=09continue;
-
 =09=09pr_debug("clockdomain: removing %s sleepdep/wkdep for "
 =09=09=09 "clkdm %s\n", autodep->clkdm.ptr->name,
 =09=09=09 clkdm->name);
@@ -243,8 +228,6 @@ static void _resolve_clkdm_deps(struct clockdomain *clk=
dm,
 =09struct clkdm_dep *cd;
=20
 =09for (cd =3D clkdm_deps; cd && cd->clkdm_name; cd++) {
-=09=09if (!omap_chip_is(cd->omap_chip))
-=09=09=09continue;
 =09=09if (cd->clkdm)
 =09=09=09continue;
 =09=09cd->clkdm =3D _clkdm_lookup(cd->clkdm_name);
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockd=
omain.h
index 0d879ff..f7b5860 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -45,7 +45,6 @@
 /**
  * struct clkdm_autodep - clkdm deps to add when entering/exiting hwsup mo=
de
  * @clkdm: clockdomain to add wkdep+sleepdep on - set name member only
- * @omap_chip: OMAP chip types that this autodep is valid on
  *
  * A clockdomain that should have wkdeps and sleepdeps added when a
  * clockdomain should stay active in hwsup mode; and conversely,
@@ -60,14 +59,12 @@ struct clkdm_autodep {
 =09=09const char *name;
 =09=09struct clockdomain *ptr;
 =09} clkdm;
-=09const struct omap_chip_id omap_chip;
 };
=20
 /**
  * struct clkdm_dep - encode dependencies between clockdomains
  * @clkdm_name: clockdomain name
  * @clkdm: pointer to the struct clockdomain of @clkdm_name
- * @omap_chip: OMAP chip types that this dependency is valid on
  * @wkdep_usecount: Number of wakeup dependencies causing this clkdm to wa=
ke
  * @sleepdep_usecount: Number of sleep deps that could prevent clkdm from =
idle
  *
@@ -81,7 +78,6 @@ struct clkdm_dep {
 =09struct clockdomain *clkdm;
 =09atomic_t wkdep_usecount;
 =09atomic_t sleepdep_usecount;
-=09const struct omap_chip_id omap_chip;
 };
=20
 /* Possible flags for struct clockdomain._flags */
@@ -101,7 +97,6 @@ struct clkdm_dep {
  * @clkdm_offs: (OMAP4 only) CM clockdomain register offset
  * @wkdep_srcs: Clockdomains that can be told to wake this powerdomain up
  * @sleepdep_srcs: Clockdomains that can be told to keep this clkdm from i=
nact
- * @omap_chip: OMAP chip types that this clockdomain is valid on
  * @usecount: Usecount tracking
  * @node: list_head to link all clockdomains together
  *
@@ -126,7 +121,6 @@ struct clockdomain {
 =09const u16 clkdm_offs;
 =09struct clkdm_dep *wkdep_srcs;
 =09struct clkdm_dep *sleepdep_srcs;
-=09const struct omap_chip_id omap_chip;
 =09atomic_t usecount;
 =09struct list_head node;
 =09spinlock_t lock;
@@ -198,7 +192,8 @@ int clkdm_clk_disable(struct clockdomain *clkdm, struct=
 clk *clk);
 int clkdm_hwmod_enable(struct clockdomain *clkdm, struct omap_hwmod *oh);
 int clkdm_hwmod_disable(struct clockdomain *clkdm, struct omap_hwmod *oh);
=20
-extern void __init omap2xxx_clockdomains_init(void);
+extern void __init omap242x_clockdomains_init(void);
+extern void __init omap243x_clockdomains_init(void);
 extern void __init omap3xxx_clockdomains_init(void);
 extern void __init omap44xx_clockdomains_init(void);
 extern void _clkdm_add_autodeps(struct clockdomain *clkdm);
@@ -208,4 +203,10 @@ extern struct clkdm_ops omap2_clkdm_operations;
 extern struct clkdm_ops omap3_clkdm_operations;
 extern struct clkdm_ops omap4_clkdm_operations;
=20
+extern struct clkdm_dep gfx_24xx_wkdeps[];
+extern struct clkdm_dep dsp_24xx_wkdeps[];
+extern struct clockdomain wkup_common_clkdm;
+extern struct clockdomain prm_common_clkdm;
+extern struct clockdomain cm_common_clkdm;
+
 #endif
diff --git a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c b/arch/arm/mach-oma=
p2/clockdomain2xxx_3xxx.c
index f740edb..a0d68db 100644
--- a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
@@ -52,8 +52,6 @@ static int omap2_clkdm_clear_all_wkdeps(struct clockdomai=
n *clkdm)
 =09u32 mask =3D 0;
=20
 =09for (cd =3D clkdm->wkdep_srcs; cd && cd->clkdm_name; cd++) {
-=09=09if (!omap_chip_is(cd->omap_chip))
-=09=09=09continue;
 =09=09if (!cd->clkdm)
 =09=09=09continue; /* only happens if data is erroneous */
=20
@@ -98,8 +96,6 @@ static int omap3_clkdm_clear_all_sleepdeps(struct clockdo=
main *clkdm)
 =09u32 mask =3D 0;
=20
 =09for (cd =3D clkdm->sleepdep_srcs; cd && cd->clkdm_name; cd++) {
-=09=09if (!omap_chip_is(cd->omap_chip))
-=09=09=09continue;
 =09=09if (!cd->clkdm)
 =09=09=09continue; /* only happens if data is erroneous */
=20
diff --git a/arch/arm/mach-omap2/clockdomain44xx.c b/arch/arm/mach-omap2/cl=
ockdomain44xx.c
index b43706a..935c7f0 100644
--- a/arch/arm/mach-omap2/clockdomain44xx.c
+++ b/arch/arm/mach-omap2/clockdomain44xx.c
@@ -52,8 +52,6 @@ static int omap4_clkdm_clear_all_wkup_sleep_deps(struct c=
lockdomain *clkdm)
 =09u32 mask =3D 0;
=20
 =09for (cd =3D clkdm->wkdep_srcs; cd && cd->clkdm_name; cd++) {
-=09=09if (!omap_chip_is(cd->omap_chip))
-=09=09=09continue;
 =09=09if (!cd->clkdm)
 =09=09=09continue; /* only happens if data is erroneous */
=20
diff --git a/arch/arm/mach-omap2/clockdomains2420_data.c b/arch/arm/mach-om=
ap2/clockdomains2420_data.c
new file mode 100644
index 0000000..0ab8e46
--- /dev/null
+++ b/arch/arm/mach-omap2/clockdomains2420_data.c
@@ -0,0 +1,154 @@
+/*
+ * OMAP2420 clockdomains
+ *
+ * Copyright (C) 2008-2011 Texas Instruments, Inc.
+ * Copyright (C) 2008-2010 Nokia Corporation
+ *
+ * Paul Walmsley, Jouni H=C3=B6gander
+ *
+ * This file contains clockdomains and clockdomain wakeup dependencies
+ * for OMAP2420 chips.  Some notes:
+ *
+ * A useful validation rule for struct clockdomain: Any clockdomain
+ * referenced by a wkdep_srcs must have a dep_bit assigned.  So
+ * wkdep_srcs are really just software-controllable dependencies.
+ * Non-software-controllable dependencies do exist, but they are not
+ * encoded below (yet).
+ *
+ * 24xx does not support programmable sleep dependencies (SLEEPDEP)
+ *
+ * The overly-specific dep_bit names are due to a bit name collision
+ * with CM_FCLKEN_{DSP,IVA2}.  The DSP/IVA2 PM_WKDEP and CM_SLEEPDEP shift
+ * value are the same for all powerdomains: 2
+ *
+ * XXX should dep_bit be a mask, so we can test to see if it is 0 as a
+ * sanity check?
+ * XXX encode hardware fixed wakeup dependencies -- esp. for 3430 CORE
+ */
+
+/*
+ * To-Do List
+ * -> Port the Sleep/Wakeup dependencies for the domains
+ *    from the Power domain framework
+ */
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+
+#include "clockdomain.h"
+#include "prm2xxx_3xxx.h"
+#include "cm2xxx_3xxx.h"
+#include "cm-regbits-24xx.h"
+#include "prm-regbits-24xx.h"
+
+/*
+ * Clockdomain dependencies for wkdeps
+ *
+ * XXX Hardware dependencies (e.g., dependencies that cannot be
+ * changed in software) are not included here yet, but should be.
+ */
+
+/* Wakeup dependency source arrays */
+
+/* 2420-specific possible wakeup dependencies */
+
+/* 2420 PM_WKDEP_MPU: CORE, DSP, WKUP */
+static struct clkdm_dep mpu_2420_wkdeps[] =3D {
+=09{ .clkdm_name =3D "core_l3_clkdm" },
+=09{ .clkdm_name =3D "core_l4_clkdm" },
+=09{ .clkdm_name =3D "dsp_clkdm" },
+=09{ .clkdm_name =3D "wkup_clkdm" },
+=09{ NULL },
+};
+
+/* 2420 PM_WKDEP_CORE: DSP, GFX, MPU, WKUP */
+static struct clkdm_dep core_2420_wkdeps[] =3D {
+=09{ .clkdm_name =3D "dsp_clkdm" },
+=09{ .clkdm_name =3D "gfx_clkdm" },
+=09{ .clkdm_name =3D "mpu_clkdm" },
+=09{ .clkdm_name =3D "wkup_clkdm" },
+=09{ NULL },
+};
+
+/*
+ * 2420-only clockdomains
+ */
+
+static struct clockdomain mpu_2420_clkdm =3D {
+=09.name=09=09=3D "mpu_clkdm",
+=09.pwrdm=09=09=3D { .name =3D "mpu_pwrdm" },
+=09.flags=09=09=3D CLKDM_CAN_HWSUP,
+=09.wkdep_srcs=09=3D mpu_2420_wkdeps,
+=09.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_MPU_MASK,
+};
+
+static struct clockdomain iva1_2420_clkdm =3D {
+=09.name=09=09=3D "iva1_clkdm",
+=09.pwrdm=09=09=3D { .name =3D "dsp_pwrdm" },
+=09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
+=09.dep_bit=09=3D OMAP24XX_PM_WKDEP_MPU_EN_DSP_SHIFT,
+=09.wkdep_srcs=09=3D dsp_24xx_wkdeps,
+=09.clktrctrl_mask =3D OMAP2420_AUTOSTATE_IVA_MASK,
+};
+
+static struct clockdomain dsp_2420_clkdm =3D {
+=09.name=09=09=3D "dsp_clkdm",
+=09.pwrdm=09=09=3D { .name =3D "dsp_pwrdm" },
+=09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
+=09.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_DSP_MASK,
+};
+
+static struct clockdomain gfx_2420_clkdm =3D {
+=09.name=09=09=3D "gfx_clkdm",
+=09.pwrdm=09=09=3D { .name =3D "gfx_pwrdm" },
+=09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
+=09.wkdep_srcs=09=3D gfx_24xx_wkdeps,
+=09.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_GFX_MASK,
+};
+
+static struct clockdomain core_l3_2420_clkdm =3D {
+=09.name=09=09=3D "core_l3_clkdm",
+=09.pwrdm=09=09=3D { .name =3D "core_pwrdm" },
+=09.flags=09=09=3D CLKDM_CAN_HWSUP,
+=09.wkdep_srcs=09=3D core_2420_wkdeps,
+=09.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_L3_MASK,
+};
+
+static struct clockdomain core_l4_2420_clkdm =3D {
+=09.name=09=09=3D "core_l4_clkdm",
+=09.pwrdm=09=09=3D { .name =3D "core_pwrdm" },
+=09.flags=09=09=3D CLKDM_CAN_HWSUP,
+=09.wkdep_srcs=09=3D core_2420_wkdeps,
+=09.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_L4_MASK,
+};
+
+static struct clockdomain dss_2420_clkdm =3D {
+=09.name=09=09=3D "dss_clkdm",
+=09.pwrdm=09=09=3D { .name =3D "core_pwrdm" },
+=09.flags=09=09=3D CLKDM_CAN_HWSUP,
+=09.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_DSS_MASK,
+};
+
+static struct clockdomain *clockdomains_omap242x[] __initdata =3D {
+=09&wkup_common_clkdm,
+=09&cm_common_clkdm,
+=09&prm_common_clkdm,
+=09&mpu_2420_clkdm,
+=09&iva1_2420_clkdm,
+=09&dsp_2420_clkdm,
+=09&gfx_2420_clkdm,
+=09&core_l3_2420_clkdm,
+=09&core_l4_2420_clkdm,
+=09&dss_2420_clkdm,
+=09NULL,
+};
+
+void __init omap242x_clockdomains_init(void)
+{
+=09if (!cpu_is_omap242x())
+=09=09return;
+
+=09clkdm_register_platform_funcs(&omap2_clkdm_operations);
+=09clkdm_register_clkdms(clockdomains_omap242x);
+=09clkdm_complete_init();
+}
diff --git a/arch/arm/mach-omap2/clockdomains2430_data.c b/arch/arm/mach-om=
ap2/clockdomains2430_data.c
new file mode 100644
index 0000000..3645ed0
--- /dev/null
+++ b/arch/arm/mach-omap2/clockdomains2430_data.c
@@ -0,0 +1,181 @@
+/*
+ * OMAP2xxx clockdomains
+ *
+ * Copyright (C) 2008-2009 Texas Instruments, Inc.
+ * Copyright (C) 2008-2010 Nokia Corporation
+ *
+ * Paul Walmsley, Jouni H=C3=B6gander
+ *
+ * This file contains clockdomains and clockdomain wakeup dependencies
+ * for OMAP2xxx chips.  Some notes:
+ *
+ * A useful validation rule for struct clockdomain: Any clockdomain
+ * referenced by a wkdep_srcs must have a dep_bit assigned.  So
+ * wkdep_srcs are really just software-controllable dependencies.
+ * Non-software-controllable dependencies do exist, but they are not
+ * encoded below (yet).
+ *
+ * 24xx does not support programmable sleep dependencies (SLEEPDEP)
+ *
+ * The overly-specific dep_bit names are due to a bit name collision
+ * with CM_FCLKEN_{DSP,IVA2}.  The DSP/IVA2 PM_WKDEP and CM_SLEEPDEP shift
+ * value are the same for all powerdomains: 2
+ *
+ * XXX should dep_bit be a mask, so we can test to see if it is 0 as a
+ * sanity check?
+ * XXX encode hardware fixed wakeup dependencies -- esp. for 3430 CORE
+ */
+
+/*
+ * To-Do List
+ * -> Port the Sleep/Wakeup dependencies for the domains
+ *    from the Power domain framework
+ */
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+
+#include "clockdomain.h"
+#include "prm2xxx_3xxx.h"
+#include "cm2xxx_3xxx.h"
+#include "cm-regbits-24xx.h"
+#include "prm-regbits-24xx.h"
+
+/*
+ * Clockdomain dependencies for wkdeps
+ *
+ * XXX Hardware dependencies (e.g., dependencies that cannot be
+ * changed in software) are not included here yet, but should be.
+ */
+
+/* Wakeup dependency source arrays */
+
+/* 2430-specific possible wakeup dependencies */
+
+/* 2430 PM_WKDEP_CORE: DSP, GFX, MPU, WKUP, MDM */
+static struct clkdm_dep core_2430_wkdeps[] =3D {
+=09{ .clkdm_name =3D "dsp_clkdm" },
+=09{ .clkdm_name =3D "gfx_clkdm" },
+=09{ .clkdm_name =3D "mpu_clkdm" },
+=09{ .clkdm_name =3D "wkup_clkdm" },
+=09{ .clkdm_name =3D "mdm_clkdm" },
+=09{ NULL },
+};
+
+/* 2430 PM_WKDEP_MPU: CORE, DSP, WKUP, MDM */
+static struct clkdm_dep mpu_2430_wkdeps[] =3D {
+=09{ .clkdm_name =3D "core_l3_clkdm" },
+=09{ .clkdm_name =3D "core_l4_clkdm" },
+=09{ .clkdm_name =3D "dsp_clkdm" },
+=09{ .clkdm_name =3D "wkup_clkdm" },
+=09{ .clkdm_name =3D "mdm_clkdm" },
+=09{ NULL },
+};
+
+/* 2430 PM_WKDEP_MDM: CORE, MPU, WKUP */
+static struct clkdm_dep mdm_2430_wkdeps[] =3D {
+=09{ .clkdm_name =3D "core_l3_clkdm" },
+=09{ .clkdm_name =3D "core_l4_clkdm" },
+=09{ .clkdm_name =3D "mpu_clkdm" },
+=09{ .clkdm_name =3D "wkup_clkdm" },
+=09{ NULL },
+};
+
+/*
+ * 2430-only clockdomains
+ */
+
+static struct clockdomain mpu_2430_clkdm =3D {
+=09.name=09=09=3D "mpu_clkdm",
+=09.pwrdm=09=09=3D { .name =3D "mpu_pwrdm" },
+=09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
+=09.wkdep_srcs=09=3D mpu_2430_wkdeps,
+=09.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_MPU_MASK,
+};
+
+/* Another case of bit name collisions between several registers: EN_MDM *=
/
+static struct clockdomain mdm_clkdm =3D {
+=09.name=09=09=3D "mdm_clkdm",
+=09.pwrdm=09=09=3D { .name =3D "mdm_pwrdm" },
+=09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
+=09.dep_bit=09=3D OMAP2430_PM_WKDEP_MPU_EN_MDM_SHIFT,
+=09.wkdep_srcs=09=3D mdm_2430_wkdeps,
+=09.clktrctrl_mask =3D OMAP2430_AUTOSTATE_MDM_MASK,
+};
+
+static struct clockdomain dsp_2430_clkdm =3D {
+=09.name=09=09=3D "dsp_clkdm",
+=09.pwrdm=09=09=3D { .name =3D "dsp_pwrdm" },
+=09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
+=09.dep_bit=09=3D OMAP24XX_PM_WKDEP_MPU_EN_DSP_SHIFT,
+=09.wkdep_srcs=09=3D dsp_24xx_wkdeps,
+=09.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_DSP_MASK,
+};
+
+static struct clockdomain gfx_2430_clkdm =3D {
+=09.name=09=09=3D "gfx_clkdm",
+=09.pwrdm=09=09=3D { .name =3D "gfx_pwrdm" },
+=09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
+=09.wkdep_srcs=09=3D gfx_24xx_wkdeps,
+=09.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_GFX_MASK,
+};
+
+/*
+ * XXX add usecounting for clkdm dependencies, otherwise the presence
+ * of a single dep bit for core_l3_24xx_clkdm and core_l4_24xx_clkdm
+ * could cause trouble
+ */
+static struct clockdomain core_l3_2430_clkdm =3D {
+=09.name=09=09=3D "core_l3_clkdm",
+=09.pwrdm=09=09=3D { .name =3D "core_pwrdm" },
+=09.flags=09=09=3D CLKDM_CAN_HWSUP,
+=09.dep_bit=09=3D OMAP24XX_EN_CORE_SHIFT,
+=09.wkdep_srcs=09=3D core_2430_wkdeps,
+=09.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_L3_MASK,
+};
+
+/*
+ * XXX add usecounting for clkdm dependencies, otherwise the presence
+ * of a single dep bit for core_l3_24xx_clkdm and core_l4_24xx_clkdm
+ * could cause trouble
+ */
+static struct clockdomain core_l4_2430_clkdm =3D {
+=09.name=09=09=3D "core_l4_clkdm",
+=09.pwrdm=09=09=3D { .name =3D "core_pwrdm" },
+=09.flags=09=09=3D CLKDM_CAN_HWSUP,
+=09.dep_bit=09=3D OMAP24XX_EN_CORE_SHIFT,
+=09.wkdep_srcs=09=3D core_2430_wkdeps,
+=09.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_L4_MASK,
+};
+
+static struct clockdomain dss_2430_clkdm =3D {
+=09.name=09=09=3D "dss_clkdm",
+=09.pwrdm=09=09=3D { .name =3D "core_pwrdm" },
+=09.flags=09=09=3D CLKDM_CAN_HWSUP,
+=09.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_DSS_MASK,
+};
+
+static struct clockdomain *clockdomains_omap243x[] __initdata =3D {
+=09&wkup_common_clkdm,
+=09&cm_common_clkdm,
+=09&prm_common_clkdm,
+=09&mpu_2430_clkdm,
+=09&mdm_clkdm,
+=09&dsp_2430_clkdm,
+=09&gfx_2430_clkdm,
+=09&core_l3_2430_clkdm,
+=09&core_l4_2430_clkdm,
+=09&dss_2430_clkdm,
+=09NULL,
+};
+
+void __init omap243x_clockdomains_init(void)
+{
+=09if (!cpu_is_omap243x())
+=09=09return;
+
+=09clkdm_register_platform_funcs(&omap2_clkdm_operations);
+=09clkdm_register_clkdms(clockdomains_omap243x);
+=09clkdm_complete_init();
+}
+
diff --git a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c b/arch/arm/ma=
ch-omap2/clockdomains2xxx_3xxx_data.c
index 148a3e8..0a6a048 100644
--- a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
@@ -1,7 +1,7 @@
 /*
- * OMAP2/3 clockdomains
+ * OMAP2/3 clockdomain common data
  *
- * Copyright (C) 2008-2009 Texas Instruments, Inc.
+ * Copyright (C) 2008-2011 Texas Instruments, Inc.
  * Copyright (C) 2008-2010 Nokia Corporation
  *
  * Paul Walmsley, Jouni H=C3=B6gander
@@ -51,374 +51,28 @@
  * changed in software) are not included here yet, but should be.
  */
=20
-/* OMAP2/3-common wakeup dependencies */
-
-/*
- * 2420/2430 PM_WKDEP_GFX: CORE, MPU, WKUP
- * 3430ES1 PM_WKDEP_GFX: adds IVA2, removes CORE
- * 3430ES2 PM_WKDEP_SGX: adds IVA2, removes CORE
- * These can share data since they will never be present simultaneously
- * on the same device.
- */
-static struct clkdm_dep gfx_sgx_wkdeps[] =3D {
-=09{
-=09=09.clkdm_name =3D "core_l3_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-=09},
-=09{
-=09=09.clkdm_name =3D "core_l4_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-=09},
-=09{
-=09=09.clkdm_name =3D "iva2_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{
-=09=09.clkdm_name =3D "mpu_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX |
-=09=09=09=09=09    CHIP_IS_OMAP3430)
-=09},
-=09{
-=09=09.clkdm_name =3D "wkup_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX |
-=09=09=09=09=09    CHIP_IS_OMAP3430)
-=09},
-=09{ NULL },
-};
-
-
-/* 24XX-specific possible dependencies */
-
-#ifdef CONFIG_ARCH_OMAP2
-
 /* Wakeup dependency source arrays */
=20
-/* 2420/2430 PM_WKDEP_DSP: CORE, MPU, WKUP */
-static struct clkdm_dep dsp_24xx_wkdeps[] =3D {
-=09{
-=09=09.clkdm_name =3D "core_l3_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-=09},
-=09{
-=09=09.clkdm_name =3D "core_l4_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-=09},
-=09{
-=09=09.clkdm_name =3D "mpu_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-=09},
-=09{
-=09=09.clkdm_name =3D "wkup_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-=09},
-=09{ NULL },
-};
-
-/*
- * 2420 PM_WKDEP_MPU: CORE, DSP, WKUP
- * 2430 adds MDM
- */
-static struct clkdm_dep mpu_24xx_wkdeps[] =3D {
-=09{
-=09=09.clkdm_name =3D "core_l3_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-=09},
-=09{
-=09=09.clkdm_name =3D "core_l4_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-=09},
-=09{
-=09=09.clkdm_name =3D "dsp_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-=09},
-=09{
-=09=09.clkdm_name =3D "wkup_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-=09},
-=09{
-=09=09.clkdm_name =3D "mdm_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
-=09},
-=09{ NULL },
-};
-
-/*
- * 2420 PM_WKDEP_CORE: DSP, GFX, MPU, WKUP
- * 2430 adds MDM
- */
-static struct clkdm_dep core_24xx_wkdeps[] =3D {
-=09{
-=09=09.clkdm_name =3D "dsp_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-=09},
-=09{
-=09=09.clkdm_name =3D "gfx_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-=09},
-=09{
-=09=09.clkdm_name =3D "mpu_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-=09},
-=09{
-=09=09.clkdm_name =3D "wkup_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-=09},
-=09{
-=09=09.clkdm_name =3D "mdm_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
-=09},
-=09{ NULL },
-};
-
-#endif /* CONFIG_ARCH_OMAP2 */
-
-/* 2430-specific possible wakeup dependencies */
+/* 2xxx-specific possible dependencies */
=20
-#ifdef CONFIG_SOC_OMAP2430
-
-/* 2430 PM_WKDEP_MDM: CORE, MPU, WKUP */
-static struct clkdm_dep mdm_2430_wkdeps[] =3D {
-=09{
-=09=09.clkdm_name =3D "core_l3_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-=09},
-=09{
-=09=09.clkdm_name =3D "core_l4_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-=09},
-=09{
-=09=09.clkdm_name =3D "mpu_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-=09},
-=09{
-=09=09.clkdm_name =3D "wkup_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-=09},
-=09{ NULL },
-};
-
-#endif /* CONFIG_SOC_OMAP2430 */
-
-
-/* OMAP3-specific possible dependencies */
-
-#ifdef CONFIG_ARCH_OMAP3
-
-/* 3430: PM_WKDEP_PER: CORE, IVA2, MPU, WKUP */
-static struct clkdm_dep per_wkdeps[] =3D {
-=09{
-=09=09.clkdm_name =3D "core_l3_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{
-=09=09.clkdm_name =3D "core_l4_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{
-=09=09.clkdm_name =3D "iva2_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{
-=09=09.clkdm_name =3D "mpu_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{
-=09=09.clkdm_name =3D "wkup_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{ NULL },
-};
-
-/* 3430ES2: PM_WKDEP_USBHOST: CORE, IVA2, MPU, WKUP */
-static struct clkdm_dep usbhost_wkdeps[] =3D {
-=09{
-=09=09.clkdm_name =3D "core_l3_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{
-=09=09.clkdm_name =3D "core_l4_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{
-=09=09.clkdm_name =3D "iva2_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{
-=09=09.clkdm_name =3D "mpu_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{
-=09=09.clkdm_name =3D "wkup_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
+/* 2xxx PM_WKDEP_GFX: CORE, MPU, WKUP */
+struct clkdm_dep gfx_24xx_wkdeps[] =3D {
+=09{ .clkdm_name =3D "core_l3_clkdm" },
+=09{ .clkdm_name =3D "core_l4_clkdm" },
+=09{ .clkdm_name =3D "mpu_clkdm" },
+=09{ .clkdm_name =3D "wkup_clkdm" },
 =09{ NULL },
 };
=20
-/* 3430 PM_WKDEP_MPU: CORE, IVA2, DSS, PER */
-static struct clkdm_dep mpu_3xxx_wkdeps[] =3D {
-=09{
-=09=09.clkdm_name =3D "core_l3_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{
-=09=09.clkdm_name =3D "core_l4_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{
-=09=09.clkdm_name =3D "iva2_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{
-=09=09.clkdm_name =3D "dss_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{
-=09=09.clkdm_name =3D "per_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
+/* 2xxx PM_WKDEP_DSP: CORE, MPU, WKUP */
+struct clkdm_dep dsp_24xx_wkdeps[] =3D {
+=09{ .clkdm_name =3D "core_l3_clkdm" },
+=09{ .clkdm_name =3D "core_l4_clkdm" },
+=09{ .clkdm_name =3D "mpu_clkdm" },
+=09{ .clkdm_name =3D "wkup_clkdm" },
 =09{ NULL },
 };
=20
-/* 3430 PM_WKDEP_IVA2: CORE, MPU, WKUP, DSS, PER */
-static struct clkdm_dep iva2_wkdeps[] =3D {
-=09{
-=09=09.clkdm_name =3D "core_l3_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{
-=09=09.clkdm_name =3D "core_l4_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{
-=09=09.clkdm_name =3D "mpu_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{
-=09=09.clkdm_name =3D "wkup_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{
-=09=09.clkdm_name =3D "dss_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{
-=09=09.clkdm_name =3D "per_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{ NULL },
-};
-
-
-/* 3430 PM_WKDEP_CAM: IVA2, MPU, WKUP */
-static struct clkdm_dep cam_wkdeps[] =3D {
-=09{
-=09=09.clkdm_name =3D "iva2_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{
-=09=09.clkdm_name =3D "mpu_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{
-=09=09.clkdm_name =3D "wkup_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{ NULL },
-};
-
-/* 3430 PM_WKDEP_DSS: IVA2, MPU, WKUP */
-static struct clkdm_dep dss_wkdeps[] =3D {
-=09{
-=09=09.clkdm_name =3D "iva2_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{
-=09=09.clkdm_name =3D "mpu_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{
-=09=09.clkdm_name =3D "wkup_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{ NULL },
-};
-
-/* 3430: PM_WKDEP_NEON: MPU */
-static struct clkdm_dep neon_wkdeps[] =3D {
-=09{
-=09=09.clkdm_name =3D "mpu_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{ NULL },
-};
-
-
-/* Sleep dependency source arrays for OMAP3-specific clkdms */
-
-/* 3430: CM_SLEEPDEP_DSS: MPU, IVA */
-static struct clkdm_dep dss_sleepdeps[] =3D {
-=09{
-=09=09.clkdm_name =3D "mpu_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{
-=09=09.clkdm_name =3D "iva2_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{ NULL },
-};
-
-/* 3430: CM_SLEEPDEP_PER: MPU, IVA */
-static struct clkdm_dep per_sleepdeps[] =3D {
-=09{
-=09=09.clkdm_name =3D "mpu_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{
-=09=09.clkdm_name =3D "iva2_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{ NULL },
-};
-
-/* 3430ES2: CM_SLEEPDEP_USBHOST: MPU, IVA */
-static struct clkdm_dep usbhost_sleepdeps[] =3D {
-=09{
-=09=09.clkdm_name =3D "mpu_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{
-=09=09.clkdm_name =3D "iva2_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{ NULL },
-};
-
-/* 3430: CM_SLEEPDEP_CAM: MPU */
-static struct clkdm_dep cam_sleepdeps[] =3D {
-=09{
-=09=09.clkdm_name =3D "mpu_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{ NULL },
-};
-
-/*
- * 3430ES1: CM_SLEEPDEP_GFX: MPU
- * 3430ES2: CM_SLEEPDEP_SGX: MPU
- * These can share data since they will never be present simultaneously
- * on the same device.
- */
-static struct clkdm_dep gfx_sgx_sleepdeps[] =3D {
-=09{
-=09=09.clkdm_name =3D "mpu_clkdm",
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{ NULL },
-};
-
-#endif /* CONFIG_ARCH_OMAP3 */
-
=20
 /*
  * OMAP2/3-common clockdomains
@@ -430,448 +84,18 @@ static struct clkdm_dep gfx_sgx_sleepdeps[] =3D {
  */
=20
 /* This is an implicit clockdomain - it is never defined as such in TRM */
-static struct clockdomain wkup_clkdm =3D {
+struct clockdomain wkup_common_clkdm =3D {
 =09.name=09=09=3D "wkup_clkdm",
 =09.pwrdm=09=09=3D { .name =3D "wkup_pwrdm" },
 =09.dep_bit=09=3D OMAP_EN_WKUP_SHIFT,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
 };
=20
-static struct clockdomain prm_clkdm =3D {
+struct clockdomain prm_common_clkdm =3D {
 =09.name=09=09=3D "prm_clkdm",
 =09.pwrdm=09=09=3D { .name =3D "wkup_pwrdm" },
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
 };
=20
-static struct clockdomain cm_clkdm =3D {
+struct clockdomain cm_common_clkdm =3D {
 =09.name=09=09=3D "cm_clkdm",
 =09.pwrdm=09=09=3D { .name =3D "core_pwrdm" },
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
-};
-
-/*
- * 2420-only clockdomains
- */
-
-#if defined(CONFIG_SOC_OMAP2420)
-
-static struct clockdomain mpu_2420_clkdm =3D {
-=09.name=09=09=3D "mpu_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "mpu_pwrdm" },
-=09.flags=09=09=3D CLKDM_CAN_HWSUP,
-=09.wkdep_srcs=09=3D mpu_24xx_wkdeps,
-=09.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_MPU_MASK,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
-};
-
-static struct clockdomain iva1_2420_clkdm =3D {
-=09.name=09=09=3D "iva1_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "dsp_pwrdm" },
-=09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
-=09.dep_bit=09=3D OMAP24XX_PM_WKDEP_MPU_EN_DSP_SHIFT,
-=09.wkdep_srcs=09=3D dsp_24xx_wkdeps,
-=09.clktrctrl_mask =3D OMAP2420_AUTOSTATE_IVA_MASK,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
-};
-
-static struct clockdomain dsp_2420_clkdm =3D {
-=09.name=09=09=3D "dsp_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "dsp_pwrdm" },
-=09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
-=09.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_DSP_MASK,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
-};
-
-static struct clockdomain gfx_2420_clkdm =3D {
-=09.name=09=09=3D "gfx_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "gfx_pwrdm" },
-=09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
-=09.wkdep_srcs=09=3D gfx_sgx_wkdeps,
-=09.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_GFX_MASK,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
-};
-
-static struct clockdomain core_l3_2420_clkdm =3D {
-=09.name=09=09=3D "core_l3_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "core_pwrdm" },
-=09.flags=09=09=3D CLKDM_CAN_HWSUP,
-=09.wkdep_srcs=09=3D core_24xx_wkdeps,
-=09.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_L3_MASK,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
-};
-
-static struct clockdomain core_l4_2420_clkdm =3D {
-=09.name=09=09=3D "core_l4_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "core_pwrdm" },
-=09.flags=09=09=3D CLKDM_CAN_HWSUP,
-=09.wkdep_srcs=09=3D core_24xx_wkdeps,
-=09.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_L4_MASK,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
-};
-
-static struct clockdomain dss_2420_clkdm =3D {
-=09.name=09=09=3D "dss_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "core_pwrdm" },
-=09.flags=09=09=3D CLKDM_CAN_HWSUP,
-=09.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_DSS_MASK,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
-};
-
-#endif   /* CONFIG_SOC_OMAP2420 */
-
-
-/*
- * 2430-only clockdomains
- */
-
-#if defined(CONFIG_SOC_OMAP2430)
-
-static struct clockdomain mpu_2430_clkdm =3D {
-=09.name=09=09=3D "mpu_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "mpu_pwrdm" },
-=09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
-=09.wkdep_srcs=09=3D mpu_24xx_wkdeps,
-=09.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_MPU_MASK,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
-};
-
-/* Another case of bit name collisions between several registers: EN_MDM *=
/
-static struct clockdomain mdm_clkdm =3D {
-=09.name=09=09=3D "mdm_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "mdm_pwrdm" },
-=09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
-=09.dep_bit=09=3D OMAP2430_PM_WKDEP_MPU_EN_MDM_SHIFT,
-=09.wkdep_srcs=09=3D mdm_2430_wkdeps,
-=09.clktrctrl_mask =3D OMAP2430_AUTOSTATE_MDM_MASK,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
-};
-
-static struct clockdomain dsp_2430_clkdm =3D {
-=09.name=09=09=3D "dsp_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "dsp_pwrdm" },
-=09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
-=09.dep_bit=09=3D OMAP24XX_PM_WKDEP_MPU_EN_DSP_SHIFT,
-=09.wkdep_srcs=09=3D dsp_24xx_wkdeps,
-=09.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_DSP_MASK,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
-};
-
-static struct clockdomain gfx_2430_clkdm =3D {
-=09.name=09=09=3D "gfx_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "gfx_pwrdm" },
-=09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
-=09.wkdep_srcs=09=3D gfx_sgx_wkdeps,
-=09.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_GFX_MASK,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
-};
-
-/*
- * XXX add usecounting for clkdm dependencies, otherwise the presence
- * of a single dep bit for core_l3_24xx_clkdm and core_l4_24xx_clkdm
- * could cause trouble
- */
-static struct clockdomain core_l3_2430_clkdm =3D {
-=09.name=09=09=3D "core_l3_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "core_pwrdm" },
-=09.flags=09=09=3D CLKDM_CAN_HWSUP,
-=09.dep_bit=09=3D OMAP24XX_EN_CORE_SHIFT,
-=09.wkdep_srcs=09=3D core_24xx_wkdeps,
-=09.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_L3_MASK,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
-};
-
-/*
- * XXX add usecounting for clkdm dependencies, otherwise the presence
- * of a single dep bit for core_l3_24xx_clkdm and core_l4_24xx_clkdm
- * could cause trouble
- */
-static struct clockdomain core_l4_2430_clkdm =3D {
-=09.name=09=09=3D "core_l4_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "core_pwrdm" },
-=09.flags=09=09=3D CLKDM_CAN_HWSUP,
-=09.dep_bit=09=3D OMAP24XX_EN_CORE_SHIFT,
-=09.wkdep_srcs=09=3D core_24xx_wkdeps,
-=09.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_L4_MASK,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
-};
-
-static struct clockdomain dss_2430_clkdm =3D {
-=09.name=09=09=3D "dss_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "core_pwrdm" },
-=09.flags=09=09=3D CLKDM_CAN_HWSUP,
-=09.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_DSS_MASK,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
-};
-
-#endif    /* CONFIG_SOC_OMAP2430 */
-
-
-/*
- * OMAP3 clockdomains
- */
-
-#if defined(CONFIG_ARCH_OMAP3)
-
-static struct clockdomain mpu_3xxx_clkdm =3D {
-=09.name=09=09=3D "mpu_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "mpu_pwrdm" },
-=09.flags=09=09=3D CLKDM_CAN_HWSUP | CLKDM_CAN_FORCE_WAKEUP,
-=09.dep_bit=09=3D OMAP3430_EN_MPU_SHIFT,
-=09.wkdep_srcs=09=3D mpu_3xxx_wkdeps,
-=09.clktrctrl_mask =3D OMAP3430_CLKTRCTRL_MPU_MASK,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
-
-static struct clockdomain neon_clkdm =3D {
-=09.name=09=09=3D "neon_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "neon_pwrdm" },
-=09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
-=09.wkdep_srcs=09=3D neon_wkdeps,
-=09.clktrctrl_mask =3D OMAP3430_CLKTRCTRL_NEON_MASK,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-};
-
-static struct clockdomain iva2_clkdm =3D {
-=09.name=09=09=3D "iva2_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "iva2_pwrdm" },
-=09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
-=09.dep_bit=09=3D OMAP3430_PM_WKDEP_MPU_EN_IVA2_SHIFT,
-=09.wkdep_srcs=09=3D iva2_wkdeps,
-=09.clktrctrl_mask =3D OMAP3430_CLKTRCTRL_IVA2_MASK,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-};
-
-static struct clockdomain gfx_3430es1_clkdm =3D {
-=09.name=09=09=3D "gfx_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "gfx_pwrdm" },
-=09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
-=09.wkdep_srcs=09=3D gfx_sgx_wkdeps,
-=09.sleepdep_srcs=09=3D gfx_sgx_sleepdeps,
-=09.clktrctrl_mask =3D OMAP3430ES1_CLKTRCTRL_GFX_MASK,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1),
-};
-
-static struct clockdomain sgx_clkdm =3D {
-=09.name=09=09=3D "sgx_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "sgx_pwrdm" },
-=09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
-=09.wkdep_srcs=09=3D gfx_sgx_wkdeps,
-=09.sleepdep_srcs=09=3D gfx_sgx_sleepdeps,
-=09.clktrctrl_mask =3D OMAP3430ES2_CLKTRCTRL_SGX_MASK,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
-};
-
-/*
- * The die-to-die clockdomain was documented in the 34xx ES1 TRM, but
- * then that information was removed from the 34xx ES2+ TRM.  It is
- * unclear whether the core is still there, but the clockdomain logic
- * is there, and must be programmed to an appropriate state if the
- * CORE clockdomain is to become inactive.
- */
-static struct clockdomain d2d_clkdm =3D {
-=09.name=09=09=3D "d2d_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "core_pwrdm" },
-=09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
-=09.clktrctrl_mask =3D OMAP3430ES1_CLKTRCTRL_D2D_MASK,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-};
-
-/*
- * XXX add usecounting for clkdm dependencies, otherwise the presence
- * of a single dep bit for core_l3_3xxx_clkdm and core_l4_3xxx_clkdm
- * could cause trouble
- */
-static struct clockdomain core_l3_3xxx_clkdm =3D {
-=09.name=09=09=3D "core_l3_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "core_pwrdm" },
-=09.flags=09=09=3D CLKDM_CAN_HWSUP,
-=09.dep_bit=09=3D OMAP3430_EN_CORE_SHIFT,
-=09.clktrctrl_mask =3D OMAP3430_CLKTRCTRL_L3_MASK,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-};
-
-/*
- * XXX add usecounting for clkdm dependencies, otherwise the presence
- * of a single dep bit for core_l3_3xxx_clkdm and core_l4_3xxx_clkdm
- * could cause trouble
- */
-static struct clockdomain core_l4_3xxx_clkdm =3D {
-=09.name=09=09=3D "core_l4_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "core_pwrdm" },
-=09.flags=09=09=3D CLKDM_CAN_HWSUP,
-=09.dep_bit=09=3D OMAP3430_EN_CORE_SHIFT,
-=09.clktrctrl_mask =3D OMAP3430_CLKTRCTRL_L4_MASK,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-};
-
-/* Another case of bit name collisions between several registers: EN_DSS *=
/
-static struct clockdomain dss_3xxx_clkdm =3D {
-=09.name=09=09=3D "dss_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "dss_pwrdm" },
-=09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
-=09.dep_bit=09=3D OMAP3430_PM_WKDEP_MPU_EN_DSS_SHIFT,
-=09.wkdep_srcs=09=3D dss_wkdeps,
-=09.sleepdep_srcs=09=3D dss_sleepdeps,
-=09.clktrctrl_mask =3D OMAP3430_CLKTRCTRL_DSS_MASK,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-};
-
-static struct clockdomain cam_clkdm =3D {
-=09.name=09=09=3D "cam_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "cam_pwrdm" },
-=09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
-=09.wkdep_srcs=09=3D cam_wkdeps,
-=09.sleepdep_srcs=09=3D cam_sleepdeps,
-=09.clktrctrl_mask =3D OMAP3430_CLKTRCTRL_CAM_MASK,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-};
-
-static struct clockdomain usbhost_clkdm =3D {
-=09.name=09=09=3D "usbhost_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "usbhost_pwrdm" },
-=09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
-=09.wkdep_srcs=09=3D usbhost_wkdeps,
-=09.sleepdep_srcs=09=3D usbhost_sleepdeps,
-=09.clktrctrl_mask =3D OMAP3430ES2_CLKTRCTRL_USBHOST_MASK,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
-};
-
-static struct clockdomain per_clkdm =3D {
-=09.name=09=09=3D "per_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "per_pwrdm" },
-=09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
-=09.dep_bit=09=3D OMAP3430_EN_PER_SHIFT,
-=09.wkdep_srcs=09=3D per_wkdeps,
-=09.sleepdep_srcs=09=3D per_sleepdeps,
-=09.clktrctrl_mask =3D OMAP3430_CLKTRCTRL_PER_MASK,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-};
-
-/*
- * Disable hw supervised mode for emu_clkdm, because emu_pwrdm is
- * switched of even if sdti is in use
- */
-static struct clockdomain emu_clkdm =3D {
-=09.name=09=09=3D "emu_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "emu_pwrdm" },
-=09.flags=09=09=3D /* CLKDM_CAN_ENABLE_AUTO |  */CLKDM_CAN_SWSUP,
-=09.clktrctrl_mask =3D OMAP3430_CLKTRCTRL_EMU_MASK,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-};
-
-static struct clockdomain dpll1_clkdm =3D {
-=09.name=09=09=3D "dpll1_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "dpll1_pwrdm" },
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-};
-
-static struct clockdomain dpll2_clkdm =3D {
-=09.name=09=09=3D "dpll2_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "dpll2_pwrdm" },
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-};
-
-static struct clockdomain dpll3_clkdm =3D {
-=09.name=09=09=3D "dpll3_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "dpll3_pwrdm" },
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-};
-
-static struct clockdomain dpll4_clkdm =3D {
-=09.name=09=09=3D "dpll4_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "dpll4_pwrdm" },
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-};
-
-static struct clockdomain dpll5_clkdm =3D {
-=09.name=09=09=3D "dpll5_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "dpll5_pwrdm" },
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
-};
-
-#endif   /* CONFIG_ARCH_OMAP3 */
-
-/*
- * Clockdomain hwsup dependencies (OMAP3 only)
- */
-
-static struct clkdm_autodep clkdm_autodeps[] =3D {
-=09{
-=09=09.clkdm=09   =3D { .name =3D "mpu_clkdm" },
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{
-=09=09.clkdm=09   =3D { .name =3D "iva2_clkdm" },
-=09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-=09},
-=09{
-=09=09.clkdm=09   =3D { .name =3D NULL },
-=09}
-};
-
-static struct clockdomain *clockdomains_omap2[] __initdata =3D {
-=09&wkup_clkdm,
-=09&cm_clkdm,
-=09&prm_clkdm,
-
-#ifdef CONFIG_SOC_OMAP2420
-=09&mpu_2420_clkdm,
-=09&iva1_2420_clkdm,
-=09&dsp_2420_clkdm,
-=09&gfx_2420_clkdm,
-=09&core_l3_2420_clkdm,
-=09&core_l4_2420_clkdm,
-=09&dss_2420_clkdm,
-#endif
-
-#ifdef CONFIG_SOC_OMAP2430
-=09&mpu_2430_clkdm,
-=09&mdm_clkdm,
-=09&dsp_2430_clkdm,
-=09&gfx_2430_clkdm,
-=09&core_l3_2430_clkdm,
-=09&core_l4_2430_clkdm,
-=09&dss_2430_clkdm,
-#endif
-
-#ifdef CONFIG_ARCH_OMAP3
-=09&mpu_3xxx_clkdm,
-=09&neon_clkdm,
-=09&iva2_clkdm,
-=09&gfx_3430es1_clkdm,
-=09&sgx_clkdm,
-=09&d2d_clkdm,
-=09&core_l3_3xxx_clkdm,
-=09&core_l4_3xxx_clkdm,
-=09&dss_3xxx_clkdm,
-=09&cam_clkdm,
-=09&usbhost_clkdm,
-=09&per_clkdm,
-=09&emu_clkdm,
-=09&dpll1_clkdm,
-=09&dpll2_clkdm,
-=09&dpll3_clkdm,
-=09&dpll4_clkdm,
-=09&dpll5_clkdm,
-#endif
-=09NULL,
-};
-
-static void __init omap2_3_clockdomains_init(void)
-{
-=09clkdm_register_clkdms(clockdomains_omap2);
-=09clkdm_register_autodeps(clkdm_autodeps);
-=09clkdm_complete_init();
-}
-
-void __init omap2xxx_clockdomains_init(void)
-{
-=09clkdm_register_platform_funcs(&omap2_clkdm_operations);
-=09omap2_3_clockdomains_init();
-}
-
-void __init omap3xxx_clockdomains_init(void)
-{
-=09clkdm_register_platform_funcs(&omap3_clkdm_operations);
-=09omap2_3_clockdomains_init();
-}
diff --git a/arch/arm/mach-omap2/clockdomains3xxx_data.c b/arch/arm/mach-om=
ap2/clockdomains3xxx_data.c
new file mode 100644
index 0000000..b84e138
--- /dev/null
+++ b/arch/arm/mach-omap2/clockdomains3xxx_data.c
@@ -0,0 +1,398 @@
+/*
+ * OMAP3xxx clockdomains
+ *
+ * Copyright (C) 2008-2011 Texas Instruments, Inc.
+ * Copyright (C) 2008-2010 Nokia Corporation
+ *
+ * Paul Walmsley, Jouni H=C3=B6gander
+ *
+ * This file contains clockdomains and clockdomain wakeup/sleep
+ * dependencies for the OMAP3xxx chips.  Some notes:
+ *
+ * A useful validation rule for struct clockdomain: Any clockdomain
+ * referenced by a wkdep_srcs or sleepdep_srcs array must have a
+ * dep_bit assigned.  So wkdep_srcs/sleepdep_srcs are really just
+ * software-controllable dependencies.  Non-software-controllable
+ * dependencies do exist, but they are not encoded below (yet).
+ *
+ * The overly-specific dep_bit names are due to a bit name collision
+ * with CM_FCLKEN_{DSP,IVA2}.  The DSP/IVA2 PM_WKDEP and CM_SLEEPDEP shift
+ * value are the same for all powerdomains: 2
+ *
+ * XXX should dep_bit be a mask, so we can test to see if it is 0 as a
+ * sanity check?
+ * XXX encode hardware fixed wakeup dependencies -- esp. for 3430 CORE
+ */
+
+/*
+ * To-Do List
+ * -> Port the Sleep/Wakeup dependencies for the domains
+ *    from the Power domain framework
+ */
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+
+#include "clockdomain.h"
+#include "prm2xxx_3xxx.h"
+#include "cm2xxx_3xxx.h"
+#include "cm-regbits-34xx.h"
+#include "prm-regbits-34xx.h"
+
+/*
+ * Clockdomain dependencies for wkdeps/sleepdeps
+ *
+ * XXX Hardware dependencies (e.g., dependencies that cannot be
+ * changed in software) are not included here yet, but should be.
+ */
+
+/* OMAP3-specific possible dependencies */
+
+/*
+ * 3430ES1 PM_WKDEP_GFX: adds IVA2, removes CORE
+ * 3430ES2 PM_WKDEP_SGX: adds IVA2, removes CORE
+ */
+static struct clkdm_dep gfx_sgx_3xxx_wkdeps[] =3D {
+=09{ .clkdm_name =3D "iva2_clkdm", },
+=09{ .clkdm_name =3D "mpu_clkdm", },
+=09{ .clkdm_name =3D "wkup_clkdm", },
+=09{ NULL },
+};
+
+/* 3430: PM_WKDEP_PER: CORE, IVA2, MPU, WKUP */
+static struct clkdm_dep per_wkdeps[] =3D {
+=09{ .clkdm_name =3D "core_l3_clkdm" },
+=09{ .clkdm_name =3D "core_l4_clkdm" },
+=09{ .clkdm_name =3D "iva2_clkdm" },
+=09{ .clkdm_name =3D "mpu_clkdm" },
+=09{ .clkdm_name =3D "wkup_clkdm" },
+=09{ NULL },
+};
+
+/* 3430ES2: PM_WKDEP_USBHOST: CORE, IVA2, MPU, WKUP */
+static struct clkdm_dep usbhost_wkdeps[] =3D {
+=09{ .clkdm_name =3D "core_l3_clkdm" },
+=09{ .clkdm_name =3D "core_l4_clkdm" },
+=09{ .clkdm_name =3D "iva2_clkdm" },
+=09{ .clkdm_name =3D "mpu_clkdm" },
+=09{ .clkdm_name =3D "wkup_clkdm" },
+=09{ NULL },
+};
+
+/* 3430 PM_WKDEP_MPU: CORE, IVA2, DSS, PER */
+static struct clkdm_dep mpu_3xxx_wkdeps[] =3D {
+=09{ .clkdm_name =3D "core_l3_clkdm" },
+=09{ .clkdm_name =3D "core_l4_clkdm" },
+=09{ .clkdm_name =3D "iva2_clkdm" },
+=09{ .clkdm_name =3D "dss_clkdm" },
+=09{ .clkdm_name =3D "per_clkdm" },
+=09{ NULL },
+};
+
+/* 3430 PM_WKDEP_IVA2: CORE, MPU, WKUP, DSS, PER */
+static struct clkdm_dep iva2_wkdeps[] =3D {
+=09{ .clkdm_name =3D "core_l3_clkdm" },
+=09{ .clkdm_name =3D "core_l4_clkdm" },
+=09{ .clkdm_name =3D "mpu_clkdm" },
+=09{ .clkdm_name =3D "wkup_clkdm" },
+=09{ .clkdm_name =3D "dss_clkdm" },
+=09{ .clkdm_name =3D "per_clkdm" },
+=09{ NULL },
+};
+
+/* 3430 PM_WKDEP_CAM: IVA2, MPU, WKUP */
+static struct clkdm_dep cam_wkdeps[] =3D {
+=09{ .clkdm_name =3D "iva2_clkdm" },
+=09{ .clkdm_name =3D "mpu_clkdm" },
+=09{ .clkdm_name =3D "wkup_clkdm" },
+=09{ NULL },
+};
+
+/* 3430 PM_WKDEP_DSS: IVA2, MPU, WKUP */
+static struct clkdm_dep dss_wkdeps[] =3D {
+=09{ .clkdm_name =3D "iva2_clkdm" },
+=09{ .clkdm_name =3D "mpu_clkdm" },
+=09{ .clkdm_name =3D "wkup_clkdm" },
+=09{ NULL },
+};
+
+/* 3430: PM_WKDEP_NEON: MPU */
+static struct clkdm_dep neon_wkdeps[] =3D {
+=09{ .clkdm_name =3D "mpu_clkdm" },
+=09{ NULL },
+};
+
+/* Sleep dependency source arrays for OMAP3-specific clkdms */
+
+/* 3430: CM_SLEEPDEP_DSS: MPU, IVA */
+static struct clkdm_dep dss_sleepdeps[] =3D {
+=09{ .clkdm_name =3D "mpu_clkdm" },
+=09{ .clkdm_name =3D "iva2_clkdm" },
+=09{ NULL },
+};
+
+/* 3430: CM_SLEEPDEP_PER: MPU, IVA */
+static struct clkdm_dep per_sleepdeps[] =3D {
+=09{ .clkdm_name =3D "mpu_clkdm" },
+=09{ .clkdm_name =3D "iva2_clkdm" },
+=09{ NULL },
+};
+
+/* 3430ES2: CM_SLEEPDEP_USBHOST: MPU, IVA */
+static struct clkdm_dep usbhost_sleepdeps[] =3D {
+=09{ .clkdm_name =3D "mpu_clkdm" },
+=09{ .clkdm_name =3D "iva2_clkdm" },
+=09{ NULL },
+};
+
+/* 3430: CM_SLEEPDEP_CAM: MPU */
+static struct clkdm_dep cam_sleepdeps[] =3D {
+=09{ .clkdm_name =3D "mpu_clkdm" },
+=09{ NULL },
+};
+
+/*
+ * 3430ES1: CM_SLEEPDEP_GFX: MPU
+ * 3430ES2: CM_SLEEPDEP_SGX: MPU
+ * These can share data since they will never be present simultaneously
+ * on the same device.
+ */
+static struct clkdm_dep gfx_sgx_sleepdeps[] =3D {
+=09{ .clkdm_name =3D "mpu_clkdm" },
+=09{ NULL },
+};
+
+/*
+ * OMAP3 clockdomains
+ */
+
+static struct clockdomain mpu_3xxx_clkdm =3D {
+=09.name=09=09=3D "mpu_clkdm",
+=09.pwrdm=09=09=3D { .name =3D "mpu_pwrdm" },
+=09.flags=09=09=3D CLKDM_CAN_HWSUP | CLKDM_CAN_FORCE_WAKEUP,
+=09.dep_bit=09=3D OMAP3430_EN_MPU_SHIFT,
+=09.wkdep_srcs=09=3D mpu_3xxx_wkdeps,
+=09.clktrctrl_mask =3D OMAP3430_CLKTRCTRL_MPU_MASK,
+};
+
+static struct clockdomain neon_clkdm =3D {
+=09.name=09=09=3D "neon_clkdm",
+=09.pwrdm=09=09=3D { .name =3D "neon_pwrdm" },
+=09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
+=09.wkdep_srcs=09=3D neon_wkdeps,
+=09.clktrctrl_mask =3D OMAP3430_CLKTRCTRL_NEON_MASK,
+};
+
+static struct clockdomain iva2_clkdm =3D {
+=09.name=09=09=3D "iva2_clkdm",
+=09.pwrdm=09=09=3D { .name =3D "iva2_pwrdm" },
+=09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
+=09.dep_bit=09=3D OMAP3430_PM_WKDEP_MPU_EN_IVA2_SHIFT,
+=09.wkdep_srcs=09=3D iva2_wkdeps,
+=09.clktrctrl_mask =3D OMAP3430_CLKTRCTRL_IVA2_MASK,
+};
+
+static struct clockdomain gfx_3430es1_clkdm =3D {
+=09.name=09=09=3D "gfx_clkdm",
+=09.pwrdm=09=09=3D { .name =3D "gfx_pwrdm" },
+=09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
+=09.wkdep_srcs=09=3D gfx_sgx_3xxx_wkdeps,
+=09.sleepdep_srcs=09=3D gfx_sgx_sleepdeps,
+=09.clktrctrl_mask =3D OMAP3430ES1_CLKTRCTRL_GFX_MASK,
+};
+
+static struct clockdomain sgx_clkdm =3D {
+=09.name=09=09=3D "sgx_clkdm",
+=09.pwrdm=09=09=3D { .name =3D "sgx_pwrdm" },
+=09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
+=09.wkdep_srcs=09=3D gfx_sgx_3xxx_wkdeps,
+=09.sleepdep_srcs=09=3D gfx_sgx_sleepdeps,
+=09.clktrctrl_mask =3D OMAP3430ES2_CLKTRCTRL_SGX_MASK,
+};
+
+/*
+ * The die-to-die clockdomain was documented in the 34xx ES1 TRM, but
+ * then that information was removed from the 34xx ES2+ TRM.  It is
+ * unclear whether the core is still there, but the clockdomain logic
+ * is there, and must be programmed to an appropriate state if the
+ * CORE clockdomain is to become inactive.
+ */
+static struct clockdomain d2d_clkdm =3D {
+=09.name=09=09=3D "d2d_clkdm",
+=09.pwrdm=09=09=3D { .name =3D "core_pwrdm" },
+=09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
+=09.clktrctrl_mask =3D OMAP3430ES1_CLKTRCTRL_D2D_MASK,
+};
+
+/*
+ * XXX add usecounting for clkdm dependencies, otherwise the presence
+ * of a single dep bit for core_l3_3xxx_clkdm and core_l4_3xxx_clkdm
+ * could cause trouble
+ */
+static struct clockdomain core_l3_3xxx_clkdm =3D {
+=09.name=09=09=3D "core_l3_clkdm",
+=09.pwrdm=09=09=3D { .name =3D "core_pwrdm" },
+=09.flags=09=09=3D CLKDM_CAN_HWSUP,
+=09.dep_bit=09=3D OMAP3430_EN_CORE_SHIFT,
+=09.clktrctrl_mask =3D OMAP3430_CLKTRCTRL_L3_MASK,
+};
+
+/*
+ * XXX add usecounting for clkdm dependencies, otherwise the presence
+ * of a single dep bit for core_l3_3xxx_clkdm and core_l4_3xxx_clkdm
+ * could cause trouble
+ */
+static struct clockdomain core_l4_3xxx_clkdm =3D {
+=09.name=09=09=3D "core_l4_clkdm",
+=09.pwrdm=09=09=3D { .name =3D "core_pwrdm" },
+=09.flags=09=09=3D CLKDM_CAN_HWSUP,
+=09.dep_bit=09=3D OMAP3430_EN_CORE_SHIFT,
+=09.clktrctrl_mask =3D OMAP3430_CLKTRCTRL_L4_MASK,
+};
+
+/* Another case of bit name collisions between several registers: EN_DSS *=
/
+static struct clockdomain dss_3xxx_clkdm =3D {
+=09.name=09=09=3D "dss_clkdm",
+=09.pwrdm=09=09=3D { .name =3D "dss_pwrdm" },
+=09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
+=09.dep_bit=09=3D OMAP3430_PM_WKDEP_MPU_EN_DSS_SHIFT,
+=09.wkdep_srcs=09=3D dss_wkdeps,
+=09.sleepdep_srcs=09=3D dss_sleepdeps,
+=09.clktrctrl_mask =3D OMAP3430_CLKTRCTRL_DSS_MASK,
+};
+
+static struct clockdomain cam_clkdm =3D {
+=09.name=09=09=3D "cam_clkdm",
+=09.pwrdm=09=09=3D { .name =3D "cam_pwrdm" },
+=09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
+=09.wkdep_srcs=09=3D cam_wkdeps,
+=09.sleepdep_srcs=09=3D cam_sleepdeps,
+=09.clktrctrl_mask =3D OMAP3430_CLKTRCTRL_CAM_MASK,
+};
+
+static struct clockdomain usbhost_clkdm =3D {
+=09.name=09=09=3D "usbhost_clkdm",
+=09.pwrdm=09=09=3D { .name =3D "usbhost_pwrdm" },
+=09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
+=09.wkdep_srcs=09=3D usbhost_wkdeps,
+=09.sleepdep_srcs=09=3D usbhost_sleepdeps,
+=09.clktrctrl_mask =3D OMAP3430ES2_CLKTRCTRL_USBHOST_MASK,
+};
+
+static struct clockdomain per_clkdm =3D {
+=09.name=09=09=3D "per_clkdm",
+=09.pwrdm=09=09=3D { .name =3D "per_pwrdm" },
+=09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
+=09.dep_bit=09=3D OMAP3430_EN_PER_SHIFT,
+=09.wkdep_srcs=09=3D per_wkdeps,
+=09.sleepdep_srcs=09=3D per_sleepdeps,
+=09.clktrctrl_mask =3D OMAP3430_CLKTRCTRL_PER_MASK,
+};
+
+/*
+ * Disable hw supervised mode for emu_clkdm, because emu_pwrdm is
+ * switched of even if sdti is in use
+ */
+static struct clockdomain emu_clkdm =3D {
+=09.name=09=09=3D "emu_clkdm",
+=09.pwrdm=09=09=3D { .name =3D "emu_pwrdm" },
+=09.flags=09=09=3D /* CLKDM_CAN_ENABLE_AUTO |  */CLKDM_CAN_SWSUP,
+=09.clktrctrl_mask =3D OMAP3430_CLKTRCTRL_EMU_MASK,
+};
+
+static struct clockdomain dpll1_clkdm =3D {
+=09.name=09=09=3D "dpll1_clkdm",
+=09.pwrdm=09=09=3D { .name =3D "dpll1_pwrdm" },
+};
+
+static struct clockdomain dpll2_clkdm =3D {
+=09.name=09=09=3D "dpll2_clkdm",
+=09.pwrdm=09=09=3D { .name =3D "dpll2_pwrdm" },
+};
+
+static struct clockdomain dpll3_clkdm =3D {
+=09.name=09=09=3D "dpll3_clkdm",
+=09.pwrdm=09=09=3D { .name =3D "dpll3_pwrdm" },
+};
+
+static struct clockdomain dpll4_clkdm =3D {
+=09.name=09=09=3D "dpll4_clkdm",
+=09.pwrdm=09=09=3D { .name =3D "dpll4_pwrdm" },
+};
+
+static struct clockdomain dpll5_clkdm =3D {
+=09.name=09=09=3D "dpll5_clkdm",
+=09.pwrdm=09=09=3D { .name =3D "dpll5_pwrdm" },
+};
+
+/*
+ * Clockdomain hwsup dependencies
+ */
+
+static struct clkdm_autodep clkdm_autodeps[] =3D {
+=09{
+=09=09.clkdm =3D { .name =3D "mpu_clkdm" },
+=09},
+=09{
+=09=09.clkdm =3D { .name =3D "iva2_clkdm" },
+=09},
+=09{
+=09=09.clkdm =3D { .name =3D NULL },
+=09}
+};
+
+/*
+ *
+ */
+
+static struct clockdomain *clockdomains_omap3430_common[] __initdata =3D {
+=09&wkup_common_clkdm,
+=09&cm_common_clkdm,
+=09&prm_common_clkdm,
+=09&mpu_3xxx_clkdm,
+=09&neon_clkdm,
+=09&iva2_clkdm,
+=09&d2d_clkdm,
+=09&core_l3_3xxx_clkdm,
+=09&core_l4_3xxx_clkdm,
+=09&dss_3xxx_clkdm,
+=09&cam_clkdm,
+=09&per_clkdm,
+=09&emu_clkdm,
+=09&dpll1_clkdm,
+=09&dpll2_clkdm,
+=09&dpll3_clkdm,
+=09&dpll4_clkdm,
+=09NULL
+};
+
+static struct clockdomain *clockdomains_omap3430es1[] __initdata =3D {
+=09&gfx_3430es1_clkdm,
+=09NULL,
+};
+
+static struct clockdomain *clockdomains_omap3430es2plus[] __initdata =3D {
+=09&sgx_clkdm,
+=09&dpll5_clkdm,
+=09&usbhost_clkdm,
+=09NULL,
+};
+
+void __init omap3xxx_clockdomains_init(void)
+{
+=09struct clockdomain **sc;
+
+=09if (!cpu_is_omap34xx())
+=09=09return;
+
+=09clkdm_register_platform_funcs(&omap3_clkdm_operations);
+=09clkdm_register_clkdms(clockdomains_omap3430_common);
+
+=09sc =3D (omap_rev() =3D=3D OMAP3430_REV_ES1_0) ? clockdomains_omap3430es=
1 :
+=09=09clockdomains_omap3430es2plus;
+
+=09clkdm_register_clkdms(sc);
+
+=09clkdm_register_autodeps(clkdm_autodeps);
+=09clkdm_complete_init();
+}
diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-om=
ap2/clockdomains44xx_data.c
index c75411a..9299ac2 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -34,350 +34,122 @@
 /* Static Dependencies for OMAP4 Clock Domains */
=20
 static struct clkdm_dep d2d_wkup_sleep_deps[] =3D {
-=09{
-=09=09.clkdm_name=09 =3D "abe_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "ivahd_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_1_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_2_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_emif_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_init_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l4_cfg_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l4_per_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
+=09{ .clkdm_name =3D "abe_clkdm" },
+=09{ .clkdm_name =3D "ivahd_clkdm" },
+=09{ .clkdm_name =3D "l3_1_clkdm" },
+=09{ .clkdm_name =3D "l3_2_clkdm" },
+=09{ .clkdm_name =3D "l3_emif_clkdm" },
+=09{ .clkdm_name =3D "l3_init_clkdm" },
+=09{ .clkdm_name =3D "l4_cfg_clkdm" },
+=09{ .clkdm_name =3D "l4_per_clkdm" },
 =09{ NULL },
 };
=20
 static struct clkdm_dep ducati_wkup_sleep_deps[] =3D {
-=09{
-=09=09.clkdm_name=09 =3D "abe_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "ivahd_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_1_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_2_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_dss_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_emif_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_gfx_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_init_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l4_cfg_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l4_per_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l4_secure_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l4_wkup_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "tesla_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
+=09{ .clkdm_name =3D "abe_clkdm" },
+=09{ .clkdm_name =3D "ivahd_clkdm" },
+=09{ .clkdm_name =3D "l3_1_clkdm" },
+=09{ .clkdm_name =3D "l3_2_clkdm" },
+=09{ .clkdm_name =3D "l3_dss_clkdm" },
+=09{ .clkdm_name =3D "l3_emif_clkdm" },
+=09{ .clkdm_name =3D "l3_gfx_clkdm" },
+=09{ .clkdm_name =3D "l3_init_clkdm" },
+=09{ .clkdm_name =3D "l4_cfg_clkdm" },
+=09{ .clkdm_name =3D "l4_per_clkdm" },
+=09{ .clkdm_name =3D "l4_secure_clkdm" },
+=09{ .clkdm_name =3D "l4_wkup_clkdm" },
+=09{ .clkdm_name =3D "tesla_clkdm" },
 =09{ NULL },
 };
=20
 static struct clkdm_dep iss_wkup_sleep_deps[] =3D {
-=09{
-=09=09.clkdm_name=09 =3D "ivahd_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_1_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_emif_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
+=09{ .clkdm_name =3D "ivahd_clkdm" },
+=09{ .clkdm_name =3D "l3_1_clkdm" },
+=09{ .clkdm_name =3D "l3_emif_clkdm" },
 =09{ NULL },
 };
=20
 static struct clkdm_dep ivahd_wkup_sleep_deps[] =3D {
-=09{
-=09=09.clkdm_name=09 =3D "l3_1_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_emif_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
+=09{ .clkdm_name =3D "l3_1_clkdm" },
+=09{ .clkdm_name =3D "l3_emif_clkdm" },
 =09{ NULL },
 };
=20
 static struct clkdm_dep l3_dma_wkup_sleep_deps[] =3D {
-=09{
-=09=09.clkdm_name=09 =3D "abe_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "ducati_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "ivahd_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_1_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_dss_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_emif_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_init_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l4_cfg_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l4_per_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l4_secure_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l4_wkup_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
+=09{ .clkdm_name =3D "abe_clkdm" },
+=09{ .clkdm_name =3D "ducati_clkdm" },
+=09{ .clkdm_name =3D "ivahd_clkdm" },
+=09{ .clkdm_name =3D "l3_1_clkdm" },
+=09{ .clkdm_name =3D "l3_dss_clkdm" },
+=09{ .clkdm_name =3D "l3_emif_clkdm" },
+=09{ .clkdm_name =3D "l3_init_clkdm" },
+=09{ .clkdm_name =3D "l4_cfg_clkdm" },
+=09{ .clkdm_name =3D "l4_per_clkdm" },
+=09{ .clkdm_name =3D "l4_secure_clkdm" },
+=09{ .clkdm_name =3D "l4_wkup_clkdm" },
 =09{ NULL },
 };
=20
 static struct clkdm_dep l3_dss_wkup_sleep_deps[] =3D {
-=09{
-=09=09.clkdm_name=09 =3D "ivahd_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_2_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_emif_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
+=09{ .clkdm_name =3D "ivahd_clkdm" },
+=09{ .clkdm_name =3D "l3_2_clkdm" },
+=09{ .clkdm_name =3D "l3_emif_clkdm" },
 =09{ NULL },
 };
=20
 static struct clkdm_dep l3_gfx_wkup_sleep_deps[] =3D {
-=09{
-=09=09.clkdm_name=09 =3D "ivahd_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_1_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_emif_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
+=09{ .clkdm_name =3D "ivahd_clkdm" },
+=09{ .clkdm_name =3D "l3_1_clkdm" },
+=09{ .clkdm_name =3D "l3_emif_clkdm" },
 =09{ NULL },
 };
=20
 static struct clkdm_dep l3_init_wkup_sleep_deps[] =3D {
-=09{
-=09=09.clkdm_name=09 =3D "abe_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "ivahd_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_emif_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l4_cfg_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l4_per_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l4_secure_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l4_wkup_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
+=09{ .clkdm_name =3D "abe_clkdm" },
+=09{ .clkdm_name =3D "ivahd_clkdm" },
+=09{ .clkdm_name =3D "l3_emif_clkdm" },
+=09{ .clkdm_name =3D "l4_cfg_clkdm" },
+=09{ .clkdm_name =3D "l4_per_clkdm" },
+=09{ .clkdm_name =3D "l4_secure_clkdm" },
+=09{ .clkdm_name =3D "l4_wkup_clkdm" },
 =09{ NULL },
 };
=20
 static struct clkdm_dep l4_secure_wkup_sleep_deps[] =3D {
-=09{
-=09=09.clkdm_name=09 =3D "l3_1_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_emif_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l4_per_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
+=09{ .clkdm_name =3D "l3_1_clkdm" },
+=09{ .clkdm_name =3D "l3_emif_clkdm" },
+=09{ .clkdm_name =3D "l4_per_clkdm" },
 =09{ NULL },
 };
=20
 static struct clkdm_dep mpu_wkup_sleep_deps[] =3D {
-=09{
-=09=09.clkdm_name=09 =3D "abe_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "ducati_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "ivahd_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_1_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_2_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_dss_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_emif_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_gfx_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_init_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l4_cfg_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l4_per_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l4_secure_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l4_wkup_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "tesla_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
+=09{ .clkdm_name =3D "abe_clkdm" },
+=09{ .clkdm_name =3D "ducati_clkdm" },
+=09{ .clkdm_name =3D "ivahd_clkdm" },
+=09{ .clkdm_name =3D "l3_1_clkdm" },
+=09{ .clkdm_name =3D "l3_2_clkdm" },
+=09{ .clkdm_name =3D "l3_dss_clkdm" },
+=09{ .clkdm_name =3D "l3_emif_clkdm" },
+=09{ .clkdm_name =3D "l3_gfx_clkdm" },
+=09{ .clkdm_name =3D "l3_init_clkdm" },
+=09{ .clkdm_name =3D "l4_cfg_clkdm" },
+=09{ .clkdm_name =3D "l4_per_clkdm" },
+=09{ .clkdm_name =3D "l4_secure_clkdm" },
+=09{ .clkdm_name =3D "l4_wkup_clkdm" },
+=09{ .clkdm_name =3D "tesla_clkdm" },
 =09{ NULL },
 };
=20
 static struct clkdm_dep tesla_wkup_sleep_deps[] =3D {
-=09{
-=09=09.clkdm_name=09 =3D "abe_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "ivahd_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_1_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_2_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_emif_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l3_init_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l4_cfg_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l4_per_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
-=09{
-=09=09.clkdm_name=09 =3D "l4_wkup_clkdm",
-=09=09.omap_chip=09 =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-=09},
+=09{ .clkdm_name =3D "abe_clkdm" },
+=09{ .clkdm_name =3D "ivahd_clkdm" },
+=09{ .clkdm_name =3D "l3_1_clkdm" },
+=09{ .clkdm_name =3D "l3_2_clkdm" },
+=09{ .clkdm_name =3D "l3_emif_clkdm" },
+=09{ .clkdm_name =3D "l3_init_clkdm" },
+=09{ .clkdm_name =3D "l4_cfg_clkdm" },
+=09{ .clkdm_name =3D "l4_per_clkdm" },
+=09{ .clkdm_name =3D "l4_wkup_clkdm" },
 =09{ NULL },
 };
=20
@@ -388,7 +160,6 @@ static struct clockdomain l4_cefuse_44xx_clkdm =3D {
 =09.cm_inst=09  =3D OMAP4430_CM2_CEFUSE_INST,
 =09.clkdm_offs=09  =3D OMAP4430_CM2_CEFUSE_CEFUSE_CDOFFS,
 =09.flags=09=09  =3D CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
=20
 static struct clockdomain l4_cfg_44xx_clkdm =3D {
@@ -399,7 +170,6 @@ static struct clockdomain l4_cfg_44xx_clkdm =3D {
 =09.clkdm_offs=09  =3D OMAP4430_CM2_CORE_L4CFG_CDOFFS,
 =09.dep_bit=09  =3D OMAP4430_L4CFG_STATDEP_SHIFT,
 =09.flags=09=09  =3D CLKDM_CAN_HWSUP,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
=20
 static struct clockdomain tesla_44xx_clkdm =3D {
@@ -412,7 +182,6 @@ static struct clockdomain tesla_44xx_clkdm =3D {
 =09.wkdep_srcs=09  =3D tesla_wkup_sleep_deps,
 =09.sleepdep_srcs=09  =3D tesla_wkup_sleep_deps,
 =09.flags=09=09  =3D CLKDM_CAN_HWSUP_SWSUP,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
=20
 static struct clockdomain l3_gfx_44xx_clkdm =3D {
@@ -425,7 +194,6 @@ static struct clockdomain l3_gfx_44xx_clkdm =3D {
 =09.wkdep_srcs=09  =3D l3_gfx_wkup_sleep_deps,
 =09.sleepdep_srcs=09  =3D l3_gfx_wkup_sleep_deps,
 =09.flags=09=09  =3D CLKDM_CAN_HWSUP_SWSUP,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
=20
 static struct clockdomain ivahd_44xx_clkdm =3D {
@@ -438,7 +206,6 @@ static struct clockdomain ivahd_44xx_clkdm =3D {
 =09.wkdep_srcs=09  =3D ivahd_wkup_sleep_deps,
 =09.sleepdep_srcs=09  =3D ivahd_wkup_sleep_deps,
 =09.flags=09=09  =3D CLKDM_CAN_HWSUP_SWSUP,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
=20
 static struct clockdomain l4_secure_44xx_clkdm =3D {
@@ -451,7 +218,6 @@ static struct clockdomain l4_secure_44xx_clkdm =3D {
 =09.wkdep_srcs=09  =3D l4_secure_wkup_sleep_deps,
 =09.sleepdep_srcs=09  =3D l4_secure_wkup_sleep_deps,
 =09.flags=09=09  =3D CLKDM_CAN_HWSUP_SWSUP,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
=20
 static struct clockdomain l4_per_44xx_clkdm =3D {
@@ -462,7 +228,6 @@ static struct clockdomain l4_per_44xx_clkdm =3D {
 =09.clkdm_offs=09  =3D OMAP4430_CM2_L4PER_L4PER_CDOFFS,
 =09.dep_bit=09  =3D OMAP4430_L4PER_STATDEP_SHIFT,
 =09.flags=09=09  =3D CLKDM_CAN_HWSUP_SWSUP,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
=20
 static struct clockdomain abe_44xx_clkdm =3D {
@@ -473,7 +238,6 @@ static struct clockdomain abe_44xx_clkdm =3D {
 =09.clkdm_offs=09  =3D OMAP4430_CM1_ABE_ABE_CDOFFS,
 =09.dep_bit=09  =3D OMAP4430_ABE_STATDEP_SHIFT,
 =09.flags=09=09  =3D CLKDM_CAN_HWSUP_SWSUP,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
=20
 static struct clockdomain l3_instr_44xx_clkdm =3D {
@@ -482,7 +246,6 @@ static struct clockdomain l3_instr_44xx_clkdm =3D {
 =09.prcm_partition=09  =3D OMAP4430_CM2_PARTITION,
 =09.cm_inst=09  =3D OMAP4430_CM2_CORE_INST,
 =09.clkdm_offs=09  =3D OMAP4430_CM2_CORE_L3INSTR_CDOFFS,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
=20
 static struct clockdomain l3_init_44xx_clkdm =3D {
@@ -495,7 +258,6 @@ static struct clockdomain l3_init_44xx_clkdm =3D {
 =09.wkdep_srcs=09  =3D l3_init_wkup_sleep_deps,
 =09.sleepdep_srcs=09  =3D l3_init_wkup_sleep_deps,
 =09.flags=09=09  =3D CLKDM_CAN_HWSUP_SWSUP,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
=20
 static struct clockdomain d2d_44xx_clkdm =3D {
@@ -507,7 +269,6 @@ static struct clockdomain d2d_44xx_clkdm =3D {
 =09.wkdep_srcs=09  =3D d2d_wkup_sleep_deps,
 =09.sleepdep_srcs=09  =3D d2d_wkup_sleep_deps,
 =09.flags=09=09  =3D CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
=20
 static struct clockdomain mpu0_44xx_clkdm =3D {
@@ -517,7 +278,6 @@ static struct clockdomain mpu0_44xx_clkdm =3D {
 =09.cm_inst=09  =3D OMAP4430_PRCM_MPU_CPU0_INST,
 =09.clkdm_offs=09  =3D OMAP4430_PRCM_MPU_CPU0_CPU0_CDOFFS,
 =09.flags=09=09  =3D CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
=20
 static struct clockdomain mpu1_44xx_clkdm =3D {
@@ -527,7 +287,6 @@ static struct clockdomain mpu1_44xx_clkdm =3D {
 =09.cm_inst=09  =3D OMAP4430_PRCM_MPU_CPU1_INST,
 =09.clkdm_offs=09  =3D OMAP4430_PRCM_MPU_CPU1_CPU1_CDOFFS,
 =09.flags=09=09  =3D CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
=20
 static struct clockdomain l3_emif_44xx_clkdm =3D {
@@ -538,7 +297,6 @@ static struct clockdomain l3_emif_44xx_clkdm =3D {
 =09.clkdm_offs=09  =3D OMAP4430_CM2_CORE_MEMIF_CDOFFS,
 =09.dep_bit=09  =3D OMAP4430_MEMIF_STATDEP_SHIFT,
 =09.flags=09=09  =3D CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
=20
 static struct clockdomain l4_ao_44xx_clkdm =3D {
@@ -548,7 +306,6 @@ static struct clockdomain l4_ao_44xx_clkdm =3D {
 =09.cm_inst=09  =3D OMAP4430_CM2_ALWAYS_ON_INST,
 =09.clkdm_offs=09  =3D OMAP4430_CM2_ALWAYS_ON_ALWON_CDOFFS,
 =09.flags=09=09  =3D CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
=20
 static struct clockdomain ducati_44xx_clkdm =3D {
@@ -561,7 +318,6 @@ static struct clockdomain ducati_44xx_clkdm =3D {
 =09.wkdep_srcs=09  =3D ducati_wkup_sleep_deps,
 =09.sleepdep_srcs=09  =3D ducati_wkup_sleep_deps,
 =09.flags=09=09  =3D CLKDM_CAN_HWSUP_SWSUP,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
=20
 static struct clockdomain mpu_44xx_clkdm =3D {
@@ -573,7 +329,6 @@ static struct clockdomain mpu_44xx_clkdm =3D {
 =09.wkdep_srcs=09  =3D mpu_wkup_sleep_deps,
 =09.sleepdep_srcs=09  =3D mpu_wkup_sleep_deps,
 =09.flags=09=09  =3D CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
=20
 static struct clockdomain l3_2_44xx_clkdm =3D {
@@ -584,7 +339,6 @@ static struct clockdomain l3_2_44xx_clkdm =3D {
 =09.clkdm_offs=09  =3D OMAP4430_CM2_CORE_L3_2_CDOFFS,
 =09.dep_bit=09  =3D OMAP4430_L3_2_STATDEP_SHIFT,
 =09.flags=09=09  =3D CLKDM_CAN_HWSUP,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
=20
 static struct clockdomain l3_1_44xx_clkdm =3D {
@@ -595,7 +349,6 @@ static struct clockdomain l3_1_44xx_clkdm =3D {
 =09.clkdm_offs=09  =3D OMAP4430_CM2_CORE_L3_1_CDOFFS,
 =09.dep_bit=09  =3D OMAP4430_L3_1_STATDEP_SHIFT,
 =09.flags=09=09  =3D CLKDM_CAN_HWSUP,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
=20
 static struct clockdomain iss_44xx_clkdm =3D {
@@ -607,7 +360,6 @@ static struct clockdomain iss_44xx_clkdm =3D {
 =09.wkdep_srcs=09  =3D iss_wkup_sleep_deps,
 =09.sleepdep_srcs=09  =3D iss_wkup_sleep_deps,
 =09.flags=09=09  =3D CLKDM_CAN_HWSUP_SWSUP,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
=20
 static struct clockdomain l3_dss_44xx_clkdm =3D {
@@ -620,7 +372,6 @@ static struct clockdomain l3_dss_44xx_clkdm =3D {
 =09.wkdep_srcs=09  =3D l3_dss_wkup_sleep_deps,
 =09.sleepdep_srcs=09  =3D l3_dss_wkup_sleep_deps,
 =09.flags=09=09  =3D CLKDM_CAN_HWSUP_SWSUP,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
=20
 static struct clockdomain l4_wkup_44xx_clkdm =3D {
@@ -631,7 +382,6 @@ static struct clockdomain l4_wkup_44xx_clkdm =3D {
 =09.clkdm_offs=09  =3D OMAP4430_PRM_WKUP_CM_WKUP_CDOFFS,
 =09.dep_bit=09  =3D OMAP4430_L4WKUP_STATDEP_SHIFT,
 =09.flags=09=09  =3D CLKDM_CAN_HWSUP,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
=20
 static struct clockdomain emu_sys_44xx_clkdm =3D {
@@ -641,7 +391,6 @@ static struct clockdomain emu_sys_44xx_clkdm =3D {
 =09.cm_inst=09  =3D OMAP4430_PRM_EMU_CM_INST,
 =09.clkdm_offs=09  =3D OMAP4430_PRM_EMU_CM_EMU_CDOFFS,
 =09.flags=09=09  =3D CLKDM_CAN_HWSUP,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
=20
 static struct clockdomain l3_dma_44xx_clkdm =3D {
@@ -653,7 +402,6 @@ static struct clockdomain l3_dma_44xx_clkdm =3D {
 =09.wkdep_srcs=09  =3D l3_dma_wkup_sleep_deps,
 =09.sleepdep_srcs=09  =3D l3_dma_wkup_sleep_deps,
 =09.flags=09=09  =3D CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
=20
 /* As clockdomains are added or removed above, this list must also be chan=
ged */
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 2ce1ce6..d098c87 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -342,11 +342,11 @@ void __init omap2_init_common_infrastructure(void)
=20
 =09if (cpu_is_omap242x()) {
 =09=09omap2xxx_powerdomains_init();
-=09=09omap2xxx_clockdomains_init();
+=09=09omap242x_clockdomains_init();
 =09=09omap2420_hwmod_init();
 =09} else if (cpu_is_omap243x()) {
 =09=09omap2xxx_powerdomains_init();
-=09=09omap2xxx_clockdomains_init();
+=09=09omap243x_clockdomains_init();
 =09=09omap2430_hwmod_init();
 =09} else if (cpu_is_omap34xx()) {
 =09=09omap3xxx_powerdomains_init();
--=20
1.7.5.4

--155748971-1477764176-1316042325=:15220--
