From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/8] OMAP2+: hwmod: add postsetup state
Date: Tue, 16 Nov 2010 03:18:07 -0700
Message-ID: <20101116101806.22777.57408.stgit@twilight.localdomain>
References: <20101116101615.22777.49212.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51526 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934134Ab0KPKTO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 05:19:14 -0500
In-Reply-To: <20101116101615.22777.49212.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, Charulatha Varadarajan <charu@ti.com>

Allow board files and OMAP core code to control the state that some or
all of the hwmods end up in at the end of _setup() (called by
omap_hwmod_late_init() ).  Reimplement the old skip_setup_idle code in
terms of this new postsetup state code.

There are two use-cases for this patch: the !CONFIG_PM_RUNTIME case,
in which all IP blocks should stay enabled after _setup() finishes;
and the MPU watchdog case, in which the watchdog IP block should enter
idle if watchdog coverage of kernel initialization is desired, and
should be disabled otherwise.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Charulatha Varadarajan <charu@ti.com>
---
 arch/arm/mach-omap2/io.c                     |   32 ++++++----
 arch/arm/mach-omap2/omap_hwmod.c             |   82 ++++++++++++++++++=
++------
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    6 ++
 3 files changed, 88 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 90ce77a..39ab1ec 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -311,8 +311,15 @@ static int __init _omap2_init_reprogram_sdrc(void)
 	return v;
 }
=20
+static int _set_hwmod_postsetup_state(struct omap_hwmod *oh, void *dat=
a)
+{
+	return omap_hwmod_set_postsetup_state(oh, *(u8 *)data);
+}
+
 void __init omap2_init_common_infrastructure(void)
 {
+	u8 postsetup_state;
+
 	pwrdm_init(powerdomains_omap);
 	clkdm_init(clockdomains_omap, clkdm_autodeps);
 	if (cpu_is_omap242x())
@@ -323,6 +330,16 @@ void __init omap2_init_common_infrastructure(void)
 		omap3xxx_hwmod_init();
 	else if (cpu_is_omap44xx())
 		omap44xx_hwmod_init();
+	else
+		pr_err("Could not init hwmod data - unknown SoC\n");
+
+	/* Set the default postsetup state for all hwmods */
+#ifdef CONFIG_PM_RUNTIME
+	postsetup_state =3D _HWMOD_STATE_IDLE;
+#else
+	postsetup_state =3D _HWMOD_STATE_ENABLED;
+#endif
+	omap_hwmod_for_each(_set_hwmod_postsetup_state, &postsetup_state);
=20
 	/* The OPP tables have to be registered before a clk init */
 	omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
@@ -336,25 +353,16 @@ void __init omap2_init_common_infrastructure(void=
)
 	else if (cpu_is_omap44xx())
 		omap4xxx_clk_init();
 	else
-		pr_err("Could not init clock framework - unknown CPU\n");
+		pr_err("Could not init clock framework - unknown SoC\n");
 }
=20
-/*
- * XXX Ideally, this function will dwindle into nothingness over time;
- * almost all device init code should be possible through initcalls
- * and other generalized mechanisms
- */
 void __init omap2_init_common_devices(struct omap_sdrc_params *sdrc_cs=
0,
 				      struct omap_sdrc_params *sdrc_cs1)
 {
-	u8 skip_setup_idle =3D 0;
-
 	omap_serial_early_init();
=20
-#ifndef CONFIG_PM_RUNTIME
-	skip_setup_idle =3D 1;
-#endif
-	omap_hwmod_late_init(skip_setup_idle);
+	omap_hwmod_late_init();
+
 	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
 		omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
 		_omap2_init_reprogram_sdrc();
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index c051fa4..683428f 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1313,23 +1313,15 @@ static int _shutdown(struct omap_hwmod *oh)
 /**
  * _setup - do initial configuration of omap_hwmod
  * @oh: struct omap_hwmod *
- * @skip_setup_idle_p: do not idle hwmods at the end of the fn if 1
  *
  * Writes the CLOCKACTIVITY bits @clockact to the hwmod @oh
- * OCP_SYSCONFIG register.  @skip_setup_idle is intended to be used on
- * a system that will not call omap_hwmod_enable() to enable devices
- * (e.g., a system without PM runtime).  Returns -EINVAL if the hwmod
- * is in the wrong state or returns 0.
+ * OCP_SYSCONFIG register.  Returns -EINVAL if the hwmod is in the
+ * wrong state or returns 0.
  */
 static int _setup(struct omap_hwmod *oh, void *data)
 {
 	int i, r;
-	u8 skip_setup_idle;
-
-	if (!oh || !data)
-		return -EINVAL;
-
-	skip_setup_idle =3D *(u8 *)data;
+	u8 postsetup_state;
=20
 	/* Set iclk autoidle mode */
 	if (oh->slaves_cnt > 0) {
@@ -1349,7 +1341,6 @@ static int _setup(struct omap_hwmod *oh, void *da=
ta)
 		}
 	}
=20
-	mutex_init(&oh->_mutex);
 	oh->_state =3D _HWMOD_STATE_INITIALIZED;
=20
 	/*
@@ -1383,8 +1374,25 @@ static int _setup(struct omap_hwmod *oh, void *d=
ata)
 		}
 	}
=20
-	if (!(oh->flags & HWMOD_INIT_NO_IDLE) && !skip_setup_idle)
+	postsetup_state =3D oh->_postsetup_state;
+	if (postsetup_state =3D=3D _HWMOD_STATE_UNKNOWN)
+		postsetup_state =3D _HWMOD_STATE_ENABLED;
+
+	/*
+	 * XXX HWMOD_INIT_NO_IDLE does not belong in hwmod data -
+	 * it should be set by the core code as a runtime flag during startup
+	 */
+	if ((oh->flags & HWMOD_INIT_NO_IDLE) &&
+	    (postsetup_state =3D=3D _HWMOD_STATE_IDLE))
+		postsetup_state =3D _HWMOD_STATE_ENABLED;
+
+	if (postsetup_state =3D=3D _HWMOD_STATE_IDLE)
 		_omap_hwmod_idle(oh);
+	else if (postsetup_state =3D=3D _HWMOD_STATE_DISABLED)
+		_shutdown(oh);
+	else if (postsetup_state !=3D _HWMOD_STATE_ENABLED)
+		WARN(1, "hwmod: %s: unknown postsetup state %d! defaulting to enable=
d\n",
+		     oh->name, postsetup_state);
=20
 	return 0;
 }
@@ -1485,6 +1493,8 @@ int omap_hwmod_register(struct omap_hwmod *oh)
=20
 	list_add_tail(&oh->node, &omap_hwmod_list);
=20
+	mutex_init(&oh->_mutex);
+
 	oh->_state =3D _HWMOD_STATE_REGISTERED;
=20
 	ret =3D 0;
@@ -1585,13 +1595,12 @@ int omap_hwmod_init(struct omap_hwmod **ohs)
=20
 /**
  * omap_hwmod_late_init - do some post-clock framework initialization
- * @skip_setup_idle: if 1, do not idle hwmods in _setup()
  *
  * Must be called after omap2_clk_init().  Resolves the struct clk nam=
es
  * to struct clk pointers for each registered omap_hwmod.  Also calls
  * _setup() on each hwmod.  Returns 0.
  */
-int omap_hwmod_late_init(u8 skip_setup_idle)
+int omap_hwmod_late_init(void)
 {
 	int r;
=20
@@ -1603,10 +1612,7 @@ int omap_hwmod_late_init(u8 skip_setup_idle)
 	WARN(!mpu_oh, "omap_hwmod: could not find MPU initiator hwmod %s\n",
 	     MPU_INITIATOR_NAME);
=20
-	if (skip_setup_idle)
-		pr_debug("omap_hwmod: will leave hwmods enabled during setup\n");
-
-	omap_hwmod_for_each(_setup, &skip_setup_idle);
+	omap_hwmod_for_each(_setup, NULL);
=20
 	return 0;
 }
@@ -2132,3 +2138,41 @@ int omap_hwmod_for_each_by_class(const char *cla=
ssname,
 	return ret;
 }
=20
+/**
+ * omap_hwmod_set_postsetup_state - set the post-_setup() state for th=
is hwmod
+ * @oh: struct omap_hwmod *
+ * @state: state that _setup() should leave the hwmod in
+ *
+ * Sets the hwmod state that @oh will enter at the end of _setup() (ca=
lled by
+ * omap_hwmod_late_init()).  Only valid to call between calls to
+ * omap_hwmod_init() and omap_hwmod_late_init().  Returns 0 upon succe=
ss or
+ * -EINVAL if there is a problem with the arguments or if the hwmod is
+ * in the wrong state.
+ */
+int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state)
+{
+	int ret;
+
+	if (!oh)
+		return -EINVAL;
+
+	if (state !=3D _HWMOD_STATE_DISABLED &&
+	    state !=3D _HWMOD_STATE_ENABLED &&
+	    state !=3D _HWMOD_STATE_IDLE)
+		return -EINVAL;
+
+	mutex_lock(&oh->_mutex);
+
+	if (oh->_state !=3D _HWMOD_STATE_REGISTERED) {
+		ret =3D -EINVAL;
+		goto ohsps_unlock;
+	}
+
+	oh->_postsetup_state =3D state;
+	ret =3D 0;
+
+ohsps_unlock:
+	mutex_unlock(&oh->_mutex);
+
+	return ret;
+}
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/pl=
at-omap/include/plat/omap_hwmod.h
index d1f1265..b445ecd 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -462,6 +462,7 @@ struct omap_hwmod_class {
  * @response_lat: device OCP response latency (in interface clock cycl=
es)
  * @_int_flags: internal-use hwmod flags
  * @_state: internal-use hwmod state
+ * @_postsetup_state: internal-use state to leave the hwmod in after _=
setup()
  * @flags: hwmod flags (documented below)
  * @omap_chip: OMAP chips this hwmod is present on
  * @_mutex: mutex serializing operations on this hwmod
@@ -510,6 +511,7 @@ struct omap_hwmod {
 	u8				hwmods_cnt;
 	u8				_int_flags;
 	u8				_state;
+	u8				_postsetup_state;
 	const struct omap_chip_id	omap_chip;
 };
=20
@@ -519,7 +521,7 @@ int omap_hwmod_unregister(struct omap_hwmod *oh);
 struct omap_hwmod *omap_hwmod_lookup(const char *name);
 int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh, void *data),
 			void *data);
-int omap_hwmod_late_init(u8 skip_setup_idle);
+int omap_hwmod_late_init(void);
=20
 int omap_hwmod_enable(struct omap_hwmod *oh);
 int _omap_hwmod_enable(struct omap_hwmod *oh);
@@ -566,6 +568,8 @@ int omap_hwmod_for_each_by_class(const char *classn=
ame,
 					   void *user),
 				 void *user);
=20
+int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state);
+
 /*
  * Chip variant-specific hwmod init routines - XXX should be converted
  * to use initcalls once the initial boot ordering is straightened out


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
