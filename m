From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 3/8] ARM: OMAP2+: hwmod: reorganize and document the setup
 process
Date: Mon, 27 Feb 2012 22:36:54 -0700
Message-ID: <20120228053651.16278.22844.stgit@dusk>
References: <20120228053524.16278.59430.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58090 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076Ab2B1Fhp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 00:37:45 -0500
In-Reply-To: <20120228053524.16278.59430.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Reorganize the code involved in initializing and configuring an IP
block to make it easier to read and maintain.  This involves improving
documentation, splitting some large functions up into smaller ones to
better conform with Documentation/CodingStyle, and removing some
unnecessary code.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |  361 +++++++++++++++++++++++++-----=
--------
 1 files changed, 242 insertions(+), 119 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index 543b0dd..5b368ee 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2,7 +2,7 @@
  * omap_hwmod implementation for OMAP2/3/4
  *
  * Copyright (C) 2009-2011 Nokia Corporation
- * Copyright (C) 2011 Texas Instruments, Inc.
+ * Copyright (C) 2011-2012 Texas Instruments, Inc.
  *
  * Paul Walmsley, Beno=C3=AEt Cousson, Kevin Hilman
  *
@@ -1457,32 +1457,45 @@ dis_opt_clks:
  * _reset - reset an omap_hwmod
  * @oh: struct omap_hwmod *
  *
- * Resets an omap_hwmod @oh.  The default software reset mechanism for
- * most OMAP IP blocks is triggered via the OCP_SYSCONFIG.SOFTRESET
- * bit.  However, some hwmods cannot be reset via this method: some
- * are not targets and therefore have no OCP header registers to
- * access; others (like the IVA) have idiosyncratic reset sequences.
- * So for these relatively rare cases, custom reset code can be
- * supplied in the struct omap_hwmod_class .reset function pointer.
- * Passes along the return value from either _reset() or the custom
- * reset function - these must return -EINVAL if the hwmod cannot be
- * reset this way or if the hwmod is in the wrong state, -ETIMEDOUT if
- * the module did not reset in time, or 0 upon success.
+ * Resets an omap_hwmod @oh.  If the module has a custom reset
+ * function pointer defined, then call it to reset the IP block, and
+ * pass along its return value to the caller.  Otherwise, if the IP
+ * block has an OCP_SYSCONFIG register with a SOFTRESET bitfield
+ * associated with it, call a function to reset the IP block via that
+ * method, and pass along the return value to the caller.  Finally, if
+ * the IP block has some hardreset lines associated with it, assert
+ * all of those, but do _not_ deassert them. (This is because driver
+ * authors have expressed an apparent requirement to control the
+ * deassertion of the hardreset lines themselves.)
+ *
+ * The default software reset mechanism for most OMAP IP blocks is
+ * triggered via the OCP_SYSCONFIG.SOFTRESET bit.  However, some
+ * hwmods cannot be reset via this method.  Some are not targets and
+ * therefore have no OCP header registers to access.  Others (like the
+ * IVA) have idiosyncratic reset sequences.  So for these relatively
+ * rare cases, custom reset code can be supplied in the struct
+ * omap_hwmod_class .reset function pointer.  Passes along the return
+ * value from either _reset() or the custom reset function - these
+ * must return -EINVAL if the hwmod cannot be reset this way or if the
+ * hwmod is in the wrong state, -ETIMEDOUT if the module did not reset
+ * in time, or 0 upon success.
  */
 static int _reset(struct omap_hwmod *oh)
 {
-	int ret;
+	int i;
=20
 	pr_debug("omap_hwmod: %s: resetting\n", oh->name);
=20
-	/*
-	 * XXX We're not resetting modules with hardreset lines
-	 * automatically here.  Should we do this also, or just expect
-	 * those modules to define custom reset functions?
-	 */
-	ret =3D (oh->class->reset) ? oh->class->reset(oh) : _ocp_softreset(oh=
);
+	if (oh->class->reset)
+		return oh->class->reset(oh);
=20
-	return ret;
+	if (!oh->rst_lines_cnt)
+		return _ocp_softreset(oh);
+
+	for (i =3D 0; i < oh->rst_lines_cnt; i++)
+		_assert_hardreset(oh, oh->rst_lines[i].name);
+
+	return 0;
 }
=20
 /**
@@ -1501,10 +1514,9 @@ static int _enable(struct omap_hwmod *oh)
 	pr_debug("omap_hwmod: %s: enabling\n", oh->name);
=20
 	/*
-	 * hwmods with HWMOD_INIT_NO_IDLE flag set are left
-	 * in enabled state at init.
-	 * Now that someone is really trying to enable them,
-	 * just ensure that the hwmod mux is set.
+	 * hwmods with HWMOD_INIT_NO_IDLE flag set are left in enabled
+	 * state at init.  Now that someone is really trying to enable
+	 * them, just ensure that the hwmod mux is set.
 	 */
 	if (oh->_int_flags & _HWMOD_SKIP_ENABLE) {
 		/*
@@ -1736,46 +1748,77 @@ static int _shutdown(struct omap_hwmod *oh)
 }
=20
 /**
- * _setup - do initial configuration of omap_hwmod
+ * _init_mpu_rt_base - populate the virtual address for a hwmod
+ * @oh: struct omap_hwmod * to locate the virtual address
+ *
+ * Cache the virtual address used by the MPU to access this IP block's
+ * registers.  This address is needed early so the OCP registers that
+ * are part of the device's address space can be ioremapped properly.
+ * No return value.
+ */
+static void __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data=
)
+{
+	if (oh->_int_flags & _HWMOD_NO_MPU_PORT)
+		return 0;
+
+	oh->_mpu_rt_va =3D _find_mpu_rt_base(oh, oh->_mpu_port_index);
+}
+
+/**
+ * _setup_iclk_autoidle - configure an IP block's interface clocks
  * @oh: struct omap_hwmod *
  *
- * Writes the CLOCKACTIVITY bits @clockact to the hwmod @oh
- * OCP_SYSCONFIG register.  Returns 0.
+ * Set up the module's interface clocks.  XXX This function is still m=
ostly
+ * a stub; implementing this properly requires iclk autoidle usecounti=
ng in
+ * the clock code.   No return value.
  */
-static int _setup(struct omap_hwmod *oh, void *data)
+static void __init _setup_iclk_autoidle(struct omap_hwmod *oh)
 {
-	int i, r;
-	u8 postsetup_state;
+	int i;
=20
-	if (oh->_state !=3D _HWMOD_STATE_CLKS_INITED)
-		return 0;
+	if (oh->_state !=3D _HWMOD_STATE_INITIALIZED)
+		return;
=20
-	/* Set iclk autoidle mode */
-	if (oh->slaves_cnt > 0) {
-		for (i =3D 0; i < oh->slaves_cnt; i++) {
-			struct omap_hwmod_ocp_if *os =3D oh->slaves[i];
-			struct clk *c =3D os->_clk;
+	for (i =3D 0; i < oh->slaves_cnt; i++) {
+		struct omap_hwmod_ocp_if *os =3D oh->slaves[i];
+		struct clk *c =3D os->_clk;
=20
-			if (!c)
-				continue;
+		if (!c)
+			continue;
=20
-			if (os->flags & OCPIF_SWSUP_IDLE) {
-				/* XXX omap_iclk_deny_idle(c); */
-			} else {
-				/* XXX omap_iclk_allow_idle(c); */
-				clk_enable(c);
-			}
+		if (os->flags & OCPIF_SWSUP_IDLE) {
+			/* XXX omap_iclk_deny_idle(c); */
+		} else {
+			/* XXX omap_iclk_allow_idle(c); */
+			clk_enable(c);
 		}
 	}
=20
-	oh->_state =3D _HWMOD_STATE_INITIALIZED;
+	return;
+}
+
+/**
+ * _setup_reset - reset an IP block during the setup process
+ * @oh: struct omap_hwmod *
+ *
+ * Reset the IP block corresponding to the hwmod @oh during the setup
+ * process.  The IP block is first enabled so it can be successfully
+ * reset.  Returns 0 upon success or a negative error code upon
+ * failure.
+ */
+static int __init _setup_reset(struct omap_hwmod *oh)
+{
+	int r =3D 0;
+
+	if (oh->_state !=3D _HWMOD_STATE_INITIALIZED)
+		return -EINVAL;
=20
 	/*
 	 * In the case of hwmod with hardreset that should not be
 	 * de-assert at boot time, we have to keep the module
 	 * initialized, because we cannot enable it properly with the
-	 * reset asserted. Exit without warning because that behavior is
-	 * expected.
+	 * reset asserted. Exit without warning because that behavior
+	 * is expected.
 	 */
 	if ((oh->flags & HWMOD_INIT_NO_RESET) && oh->rst_lines_cnt > 0)
 		return 0;
@@ -1787,20 +1830,65 @@ static int _setup(struct omap_hwmod *oh, void *=
data)
 		return 0;
 	}
=20
-	if (!(oh->flags & HWMOD_INIT_NO_RESET)) {
-		_reset(oh);
+	if (!(oh->flags & HWMOD_INIT_NO_RESET))
+		r =3D _reset(oh);
=20
-		/*
-		 * OCP_SYSCONFIG bits need to be reprogrammed after a softreset.
-		 * The _enable() function should be split to
-		 * avoid the rewrite of the OCP_SYSCONFIG register.
-		 */
-		if (oh->class->sysc) {
-			_update_sysc_cache(oh);
-			_enable_sysc(oh);
-		}
+	/*
+	 * OCP_SYSCONFIG bits need to be reprogrammed after a
+	 * softreset.  The _enable() function should be split to avoid
+	 * the rewrite of the OCP_SYSCONFIG register.
+	 */
+	if (oh->class->sysc) {
+		_update_sysc_cache(oh);
+		_enable_sysc(oh);
 	}
=20
+	return r;
+}
+
+/**
+ * _setup_postsetup - transition to the appropriate state after _setup
+ * @oh: struct omap_hwmod *
+ *
+ * Place an IP block represented by @oh into a "post-setup" state --
+ * either IDLE, ENABLED, or DISABLED.  ("post-setup" simply means that
+ * this function is called at the end of _setup().)  The postsetup
+ * state for an IP block can be changed by calling
+ * omap_hwmod_enter_postsetup_state() early in the boot process,
+ * before one of the omap_hwmod_setup*() functions are called for the
+ * IP block.
+ *
+ * The IP block stays in this state until a PM runtime-based driver is
+ * loaded for that IP block.  A post-setup state of IDLE is
+ * appropriate for almost all IP blocks with runtime PM-enabled
+ * drivers, since those drivers are able to enable the IP block.  A
+ * post-setup state of ENABLED is appropriate for kernels with PM
+ * runtime disabled.  The DISABLED state is appropriate for unusual IP
+ * blocks such as the MPU WDTIMER on kernels without WDTIMER drivers
+ * included, since the WDTIMER starts running on reset and will reset
+ * the MPU if left active.
+ *
+ * This post-setup mechanism is deprecated.  Once all of the OMAP
+ * drivers have been converted to use PM runtime, and all of the IP
+ * block data and interconnect data is available to the hwmod code, it
+ * should be possible to replace this mechanism with a "lazy reset"
+ * arrangement.  In a "lazy reset" setup, each IP block is enabled
+ * when the driver first probes, then all remaining IP blocks without
+ * drivers are either shut down or enabled after the drivers have
+ * loaded.  However, this cannot take place until the above
+ * preconditions have been met, since otherwise the late reset code
+ * has no way of knowing which IP blocks are in use by drivers, and
+ * which ones are unused.
+ *
+ * No return value.
+ */
+static void __init _setup_postsetup(struct omap_hwmod *oh)
+{
+	u8 postsetup_state;
+
+	if (oh->rst_lines_cnt > 0)
+		return;
+
 	postsetup_state =3D oh->_postsetup_state;
 	if (postsetup_state =3D=3D _HWMOD_STATE_UNKNOWN)
 		postsetup_state =3D _HWMOD_STATE_ENABLED;
@@ -1823,6 +1911,68 @@ static int _setup(struct omap_hwmod *oh, void *d=
ata)
 		WARN(1, "hwmod: %s: unknown postsetup state %d! defaulting to enable=
d\n",
 		     oh->name, postsetup_state);
=20
+	return;
+}
+
+/**
+ * _init - initialize internal data for the hwmod @oh
+ * @oh: struct omap_hwmod *
+ * @n: (unused)
+ *
+ * Look up the clocks and the address space used by the MPU to access
+ * registers belonging to the hwmod @oh.  @oh must already be
+ * registered at this point.  This is the first of two phases for
+ * hwmod initialization.  Code called here does not touch any hardware
+ * registers, it simply prepares internal data structures.  Returns 0
+ * upon success or if the hwmod isn't registered, or -EINVAL upon
+ * failure.
+ */
+static int __init _init(struct omap_hwmod *oh, void *n)
+{
+	int r;
+
+	if (oh->_state !=3D _HWMOD_STATE_REGISTERED)
+		return 0;
+
+	_init_mpu_rt_base(oh, NULL);
+
+	r =3D _init_clocks(oh, NULL);
+	if (IS_ERR_VALUE(r)) {
+		WARN(1, "omap_hwmod: %s: couldn't init clocks\n", oh->name);
+		return -EINVAL;
+	}
+
+	oh->_state =3D _HWMOD_STATE_INITIALIZED;
+
+	return 0;
+}
+
+/**
+ * _setup - prepare IP block hardware for use
+ * @oh: struct omap_hwmod *
+ * @n: (unused, pass NULL)
+ *
+ * Configure the IP block represented by @oh.  This may include
+ * enabling the IP block, resetting it, and placing it into a
+ * post-setup state, depending on the type of IP block and applicable
+ * flags.  IP blocks are reset to prevent any previous configuration
+ * by the bootloader or previous operating system from interfering
+ * with power management or other parts of the system.  The reset can
+ * be avoided; see omap_hwmod_no_setup_reset().  This is the second of
+ * two phases for hwmod initialization.  Code called here generally
+ * affects the IP block hardware, or system integration hardware
+ * associated with the IP block.  Returns 0.
+ */
+static int __init _setup(struct omap_hwmod *oh, void *n)
+{
+	if (oh->_state !=3D _HWMOD_STATE_INITIALIZED)
+		return 0;
+
+	_setup_iclk_autoidle(oh);
+
+	if (!_setup_reset(oh))
+		_setup_postsetup(oh);
+
 	return 0;
 }
=20
@@ -2030,96 +2180,69 @@ int __init omap_hwmod_register(struct omap_hwmo=
d **ohs)
 	return 0;
 }
=20
-/*
- * _populate_mpu_rt_base - populate the virtual address for a hwmod
+/**
+ * _ensure_mpu_hwmod_is_setup - ensure the MPU SS hwmod is init'ed and=
 set up
+ * @oh: pointer to the hwmod currently being set up (usually not the M=
PU)
  *
- * Must be called only from omap_hwmod_setup_*() so ioremap works prop=
erly.
- * Assumes the caller takes care of locking if needed.
+ * If the hwmod data corresponding to the MPU subsystem IP block
+ * hasn't been initialized and set up yet, do so now.  This must be
+ * done first since sleep dependencies may be added from other hwmods
+ * to the MPU.  Intended to be called only by omap_hwmod_setup*().  No
+ * return value.
  */
-static int __init _populate_mpu_rt_base(struct omap_hwmod *oh, void *d=
ata)
+static void __init _ensure_mpu_hwmod_is_setup(struct omap_hwmod *oh)
 {
-	if (oh->_state !=3D _HWMOD_STATE_REGISTERED)
-		return 0;
-
-	if (oh->_int_flags & _HWMOD_NO_MPU_PORT)
-		return 0;
-
-	oh->_mpu_rt_va =3D _find_mpu_rt_base(oh, oh->_mpu_port_index);
-
-	return 0;
+	if (!mpu_oh || mpu_oh->_state =3D=3D _HWMOD_STATE_UNKNOWN) {
+		pr_err("omap_hwmod: %s: MPU initiator hwmod %s not yet registered\n"=
,
+		       __func__, MPU_INITIATOR_NAME);
+	} else if (mpu_oh->_state =3D=3D _HWMOD_STATE_REGISTERED && oh !=3D m=
pu_oh)
+		omap_hwmod_setup_one(MPU_INITIATOR_NAME);
 }
=20
 /**
  * omap_hwmod_setup_one - set up a single hwmod
  * @oh_name: const char * name of the already-registered hwmod to set =
up
  *
- * Must be called after omap2_clk_init().  Resolves the struct clk
- * names to struct clk pointers for each registered omap_hwmod.  Also
- * calls _setup() on each hwmod.  Returns -EINVAL upon error or 0 upon
- * success.
+ * Initialize and set up a single hwmod.  Intended to be used for a
+ * small number of early devices, such as the timer IP blocks used for
+ * the scheduler clock.  Must be called after omap2_clk_init().
+ * Resolves the struct clk names to struct clk pointers for each
+ * registered omap_hwmod.  Also calls _setup() on each hwmod.  Returns
+ * -EINVAL upon error or 0 upon success.
  */
 int __init omap_hwmod_setup_one(const char *oh_name)
 {
 	struct omap_hwmod *oh;
-	int r;
=20
 	pr_debug("omap_hwmod: %s: %s\n", oh_name, __func__);
=20
-	if (!mpu_oh) {
-		pr_err("omap_hwmod: %s: cannot setup_one: MPU initiator hwmod %s not=
 yet registered\n",
-		       oh_name, MPU_INITIATOR_NAME);
-		return -EINVAL;
-	}
-
 	oh =3D _lookup(oh_name);
 	if (!oh) {
 		WARN(1, "omap_hwmod: %s: hwmod not yet registered\n", oh_name);
 		return -EINVAL;
 	}
=20
-	if (mpu_oh->_state =3D=3D _HWMOD_STATE_REGISTERED && oh !=3D mpu_oh)
-		omap_hwmod_setup_one(MPU_INITIATOR_NAME);
-
-	r =3D _populate_mpu_rt_base(oh, NULL);
-	if (IS_ERR_VALUE(r)) {
-		WARN(1, "omap_hwmod: %s: couldn't set mpu_rt_base\n", oh_name);
-		return -EINVAL;
-	}
-
-	r =3D _init_clocks(oh, NULL);
-	if (IS_ERR_VALUE(r)) {
-		WARN(1, "omap_hwmod: %s: couldn't init clocks\n", oh_name);
-		return -EINVAL;
-	}
+	_ensure_mpu_hwmod_is_setup(oh);
=20
+	_init(oh, NULL);
 	_setup(oh, NULL);
=20
 	return 0;
 }
=20
 /**
- * omap_hwmod_setup - do some post-clock framework initialization
+ * omap_hwmod_setup_all - set up all registered IP blocks
  *
- * Must be called after omap2_clk_init().  Resolves the struct clk nam=
es
- * to struct clk pointers for each registered omap_hwmod.  Also calls
- * _setup() on each hwmod.  Returns 0 upon success.
+ * Initialize and set up all IP blocks registered with the hwmod code.
+ * Must be called after omap2_clk_init().  Resolves the struct clk
+ * names to struct clk pointers for each registered omap_hwmod.  Also
+ * calls _setup() on each hwmod.  Returns 0 upon success.
  */
 static int __init omap_hwmod_setup_all(void)
 {
-	int r;
-
-	if (!mpu_oh) {
-		pr_err("omap_hwmod: %s: MPU initiator hwmod %s not yet registered\n"=
,
-		       __func__, MPU_INITIATOR_NAME);
-		return -EINVAL;
-	}
-
-	r =3D omap_hwmod_for_each(_populate_mpu_rt_base, NULL);
-
-	r =3D omap_hwmod_for_each(_init_clocks, NULL);
-	WARN(IS_ERR_VALUE(r),
-	     "omap_hwmod: %s: _init_clocks failed\n", __func__);
+	_ensure_mpu_hwmod_is_setup(NULL);
=20
+	omap_hwmod_for_each(_init, NULL);
 	omap_hwmod_for_each(_setup, NULL);
=20
 	return 0;
@@ -2651,10 +2774,10 @@ int omap_hwmod_for_each_by_class(const char *cl=
assname,
  * @state: state that _setup() should leave the hwmod in
  *
  * Sets the hwmod state that @oh will enter at the end of _setup()
- * (called by omap_hwmod_setup_*()).  Only valid to call between
- * calling omap_hwmod_register() and omap_hwmod_setup_*().  Returns
- * 0 upon success or -EINVAL if there is a problem with the arguments
- * or if the hwmod is in the wrong state.
+ * (called by omap_hwmod_setup_*()).  See also the documentation
+ * for _setup_postsetup(), above.  Returns 0 upon success or
+ * -EINVAL if there is a problem with the arguments or if the hwmod is
+ * in the wrong state.
  */
 int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state)
 {


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
