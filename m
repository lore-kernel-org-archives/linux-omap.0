From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 5/9] OMAP2+: hwmod: rename some init functions
Date: Mon, 28 Feb 2011 14:12:21 -0700
Message-ID: <20110228211217.15286.26420.stgit@twilight.localdomain>
References: <20110228210858.15286.3200.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50103 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662Ab1B1VOV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Feb 2011 16:14:21 -0500
In-Reply-To: <20110228210858.15286.3200.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Rename omap_hwmod_init() to omap_hwmod_register().  Rename
omap_hwmod_late_init() to omap_hwmod_setup_all().  Also change all of
the callers to reflect the new names.  While here, update some
copyrights.

Suggested by Tony Lindgren <tony@atomide.com>.

N.B. The comment in mach-omap2/serial.c may no longer be correct, given
     recent changes in init order.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   33 ++++++++++++------=
--------
 arch/arm/mach-omap2/omap_hwmod_2420_data.c   |    2 +-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |    2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |    2 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |    2 +-
 arch/arm/mach-omap2/serial.c                 |    2 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    6 +++--
 7 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index 2a7ab6a..557d9eb 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1,7 +1,7 @@
 /*
  * omap_hwmod implementation for OMAP2/3/4
  *
- * Copyright (C) 2009-2010 Nokia Corporation
+ * Copyright (C) 2009-2011 Nokia Corporation
  *
  * Paul Walmsley, Beno=C3=AEt Cousson, Kevin Hilman
  *
@@ -901,7 +901,7 @@ static struct omap_hwmod *_lookup(const char *name)
  * @oh: struct omap_hwmod *
  * @data: not used; pass NULL
  *
- * Called by omap_hwmod_late_init() (after omap2_clk_init()).
+ * Called by omap_hwmod_setup_all() (after omap2_clk_init()).
  * Resolves all clock names embedded in the hwmod.  Returns -EINVAL if
  * the omap_hwmod has not yet been registered or if the clocks have
  * already been initialized, 0 on success, or a non-zero error on
@@ -1580,17 +1580,15 @@ int omap_hwmod_for_each(int (*fn)(struct omap_h=
wmod *oh, void *data),
 	return ret;
 }
=20
-
 /**
- * omap_hwmod_init - init omap_hwmod code and register hwmods
+ * omap_hwmod_register - register an array of hwmods
  * @ohs: pointer to an array of omap_hwmods to register
  *
  * Intended to be called early in boot before the clock framework is
  * initialized.  If @ohs is not null, will register all omap_hwmods
- * listed in @ohs that are valid for this chip.  Returns -EINVAL if
- * omap_hwmod_init() has already been called or 0 otherwise.
+ * listed in @ohs that are valid for this chip.  Returns 0.
  */
-int __init omap_hwmod_init(struct omap_hwmod **ohs)
+int __init omap_hwmod_register(struct omap_hwmod **ohs)
 {
 	int r, i;
=20
@@ -1613,9 +1611,8 @@ int __init omap_hwmod_init(struct omap_hwmod **oh=
s)
 /*
  * _populate_mpu_rt_base - populate the virtual address for a hwmod
  *
- * Must be called only from omap_hwmod_late_init so ioremap works prop=
erly.
+ * Must be called only from omap_hwmod_setup_all() so ioremap works pr=
operly.
  * Assumes the caller takes care of locking if needed.
- *
  */
 static int __init _populate_mpu_rt_base(struct omap_hwmod *oh, void *d=
ata)
 {
@@ -1631,13 +1628,13 @@ static int __init _populate_mpu_rt_base(struct =
omap_hwmod *oh, void *data)
 }
=20
 /**
- * omap_hwmod_late_init - do some post-clock framework initialization
+ * omap_hwmod_setup - do some post-clock framework initialization
  *
  * Must be called after omap2_clk_init().  Resolves the struct clk nam=
es
  * to struct clk pointers for each registered omap_hwmod.  Also calls
  * _setup() on each hwmod.  Returns 0.
  */
-static int __init omap_hwmod_late_init(void)
+static int __init omap_hwmod_setup_all(void)
 {
 	int r;
=20
@@ -1645,7 +1642,7 @@ static int __init omap_hwmod_late_init(void)
=20
 	/* XXX check return value */
 	r =3D omap_hwmod_for_each(_init_clocks, NULL);
-	WARN(r, "omap_hwmod: omap_hwmod_late_init(): _init_clocks failed\n");
+	WARN(r, "omap_hwmod: %s: _init_clocks failed\n", __func__);
=20
 	mpu_oh =3D omap_hwmod_lookup(MPU_INITIATOR_NAME);
 	WARN(!mpu_oh, "omap_hwmod: could not find MPU initiator hwmod %s\n",
@@ -1655,7 +1652,7 @@ static int __init omap_hwmod_late_init(void)
=20
 	return 0;
 }
-core_initcall(omap_hwmod_late_init);
+core_initcall(omap_hwmod_setup_all);
=20
 /**
  * omap_hwmod_enable - enable an omap_hwmod
@@ -2174,11 +2171,11 @@ int omap_hwmod_for_each_by_class(const char *cl=
assname,
  * @oh: struct omap_hwmod *
  * @state: state that _setup() should leave the hwmod in
  *
- * Sets the hwmod state that @oh will enter at the end of _setup() (ca=
lled by
- * omap_hwmod_late_init()).  Only valid to call between calls to
- * omap_hwmod_init() and omap_hwmod_late_init().  Returns 0 upon succe=
ss or
- * -EINVAL if there is a problem with the arguments or if the hwmod is
- * in the wrong state.
+ * Sets the hwmod state that @oh will enter at the end of _setup()
+ * (called by omap_hwmod_setup_all()).  Only valid to call between
+ * calling omap_hwmod_register() and omap_hwmod_setup_all().  Returns
+ * 0 upon success or -EINVAL if there is a problem with the arguments
+ * or if the hwmod is in the wrong state.
  */
 int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state)
 {
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach=
-omap2/omap_hwmod_2420_data.c
index c2f84aa..e58621a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -1990,5 +1990,5 @@ static __initdata struct omap_hwmod *omap2420_hwm=
ods[] =3D {
=20
 int __init omap2420_hwmod_init(void)
 {
-	return omap_hwmod_init(omap2420_hwmods);
+	return omap_hwmod_register(omap2420_hwmods);
 }
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach=
-omap2/omap_hwmod_2430_data.c
index c036996..b46a54c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -2183,5 +2183,5 @@ static __initdata struct omap_hwmod *omap2430_hwm=
ods[] =3D {
=20
 int __init omap2430_hwmod_init(void)
 {
-	return omap_hwmod_init(omap2430_hwmods);
+	return omap_hwmod_register(omap2430_hwmods);
 }
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_3xxx_data.c
index b8776ee..fc1b2b9 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -2919,5 +2919,5 @@ static __initdata struct omap_hwmod *omap3xxx_hwm=
ods[] =3D {
=20
 int __init omap3xxx_hwmod_init(void)
 {
-	return omap_hwmod_init(omap3xxx_hwmods);
+	return omap_hwmod_register(omap3xxx_hwmods);
 }
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index 79a8601..2c58827 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -5125,6 +5125,6 @@ static __initdata struct omap_hwmod *omap44xx_hwm=
ods[] =3D {
=20
 int __init omap44xx_hwmod_init(void)
 {
-	return omap_hwmod_init(omap44xx_hwmods);
+	return omap_hwmod_register(omap44xx_hwmods);
 }
=20
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.=
c
index 47eef48..1ac361b 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -680,7 +680,7 @@ static int __init omap_serial_early_init(void)
 		num_uarts++;
=20
 		/*
-		 * NOTE: omap_hwmod_init() has not yet been called,
+		 * NOTE: omap_hwmod_setup*() has not yet been called,
 		 *       so no hwmod functions will work yet.
 		 */
=20
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/pl=
at-omap/include/plat/omap_hwmod.h
index fedd829..afdf197 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -1,7 +1,7 @@
 /*
  * omap_hwmod macros, structures
  *
- * Copyright (C) 2009-2010 Nokia Corporation
+ * Copyright (C) 2009-2011 Nokia Corporation
  * Paul Walmsley
  *
  * Created in collaboration with (alphabetical order): Beno=C3=AEt Cou=
sson,
@@ -370,8 +370,10 @@ struct omap_hwmod_omap4_prcm {
  *     of standby, rather than relying on module smart-standby
  * HWMOD_INIT_NO_RESET: don't reset this module at boot - important fo=
r
  *     SDRAM controller, etc. XXX probably belongs outside the main hw=
mod file
+ *     XXX Should be HWMOD_SETUP_NO_RESET
  * HWMOD_INIT_NO_IDLE: don't idle this module at boot - important for =
SDRAM
  *     controller, etc. XXX probably belongs outside the main hwmod fi=
le
+ *     XXX Should be HWMOD_SETUP_NO_IDLE
  * HWMOD_NO_AUTOIDLE: disable module autoidle (OCP_SYSCONFIG.AUTOIDLE)
  *     when module is enabled, rather than the default, which is to
  *     enable autoidle
@@ -535,7 +537,7 @@ struct omap_hwmod {
 	const struct omap_chip_id	omap_chip;
 };
=20
-int omap_hwmod_init(struct omap_hwmod **ohs);
+int omap_hwmod_register(struct omap_hwmod **ohs);
 struct omap_hwmod *omap_hwmod_lookup(const char *name);
 int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh, void *data),
 			void *data);


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
