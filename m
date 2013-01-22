From: Paul Walmsley <paul@pwsan.com>
Subject: Re: reset handling in am335x hwmod data
Date: Tue, 22 Jan 2013 02:53:57 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301220245050.25789@utopia.booyaka.com>
References: <87ehij8lpb.fsf@dell.be.48ers.dk> <alpine.DEB.2.00.1212232033030.8937@utopia.booyaka.com> <87d2xda34m.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41007 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752894Ab3AVCx6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jan 2013 21:53:58 -0500
In-Reply-To: <87d2xda34m.fsf@dell.be.48ers.dk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-omap@vger.kernel.org

Hi

On Thu, 10 Jan 2013, Peter Korsgaard wrote:

> >>>>> "Paul" == Paul Walmsley <paul@pwsan.com> writes:
> 
>  Paul> Probably the DTS is the right place, since this is a board- and
>  Paul> bootloader-specific quirk.  The original intention was to allow
>  Paul> board files to set this HWMOD_INIT_NO_RESET flag themselves - see
>  Paul> mach-omap2/ omap_hwmod.c:omap_hwmod_no_setup_reset().  But since
>  Paul> we've deprecated the board files, the DT data seems like the
>  Paul> right place.
> 
>  Paul> It probably shouldn't be a GPIO-specific property.  Other devices
>  Paul> like DSS will also need some kind of 'no-init-reset' property,
>  Paul> since on many commercial devices, it's expected that some kind of
>  Paul> splash screen will be presented by the bootloader and stay on
>  Paul> during the boot process.
> 
> I tried changing omap_device_build_from_dt() to call
> omap_hwmod_no_setup_reset() on the corresponding hwmod if a
> ti,no-init-reset was present, but that doesn't work as the hwmod reset
> happens quite a bit earlier (in omap_hwmod_setup_all()). Do you have
> idea how I could work around this or is that the future reset change you
> referred to above?

For AM33xx, since there's no board file, you'll need to modify the kernel 
source.  You can set the HWMOD_INIT_NO_RESET flag on the GPIO IP blocks 
that should have their reset skipped, in 
mach-omap2/omap_hwmod_33xx_data.c.

In the medium term, we'll deal with this with the late reset change that 
was described earlier.  Here's an experimental patch in case you want to 
play with it, which I wouldn't recommend since it has known flaws, and 
also we're not yet at the point where we can switch to late reset in 
mainline yet, mostly because folks have been more interested in pushing 
new features than doing cleanup work.


- Paul

>From 109751e4621f692466f6156e10c3647317f51c9c Mon Sep 17 00:00:00 2001
From: Paul Walmsley <paul@pwsan.com>
Date: Sun, 20 Jan 2013 21:35:00 -0700
Subject: [PATCH] EXPERIMENTAL: ARM: OMAP2+: hwmod: move device reset later in
 the boot

EXPERIMENTAL: is full of bugs; also requires hwmod device topology patch.

XXX Fix documentation around omap_hwmod_init_*()
XXX can init be moved to device enable as well?
---
 arch/arm/mach-omap2/io.c         |   25 +-
 arch/arm/mach-omap2/omap_hwmod.c |  626 +++++++++++++++++---------------------
 arch/arm/mach-omap2/omap_hwmod.h |   24 +-
 arch/arm/mach-omap2/timer.c      |    4 +-
 4 files changed, 299 insertions(+), 380 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 2c3fdd6..a170c98 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -359,23 +359,20 @@ static int __init _omap2_init_reprogram_sdrc(void)
 	return v;
 }
 
-static int _set_hwmod_postsetup_state(struct omap_hwmod *oh, void *data)
-{
-	return omap_hwmod_set_postsetup_state(oh, *(u8 *)data);
-}
-
 static void __init omap_hwmod_init_postsetup(void)
 {
-	u8 postsetup_state;
-
-	/* Set the default postsetup state for all hwmods */
-#ifdef CONFIG_PM_RUNTIME
-	postsetup_state = _HWMOD_STATE_IDLE;
-#else
-	postsetup_state = _HWMOD_STATE_ENABLED;
+#ifndef CONFIG_PM_RUNTIME
+	/*
+	 * Until we have a real OMAP bus, and the drivers can enable
+	 * and disable the devices themselves, we're stuck with
+	 * runtime PM as a device enable/disable mechanism.  But if
+	 * runtime PM has been configured out, then we're left with no
+	 * way to control the device integration, so just enable
+	 * everything so the kernel doesn't crash when it tries to
+	 * touch a device that hasn't been enabled.
+	 */
+	omap_hwmod_enable_all();
 #endif
-	omap_hwmod_for_each(_set_hwmod_postsetup_state, &postsetup_state);
-
 	omap_pm_if_early_init();
 }
 
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 4653efb..52578a7 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1542,13 +1542,12 @@ static int _init_clkdm(struct omap_hwmod *oh)
  * _init_clocks - clk_get() all clocks associated with this hwmod. Retrieve as
  * well the clockdomain.
  * @oh: struct omap_hwmod *
- * @data: not used; pass NULL
  *
  * Called by omap_hwmod_setup_*() (after omap2_clk_init()).
  * Resolves all clock names embedded in the hwmod.  Returns 0 on
  * success, or a negative error code on failure.
  */
-static int _init_clocks(struct omap_hwmod *oh, void *data)
+static int _init_clocks(struct omap_hwmod *oh)
 {
 	int ret = 0;
 
@@ -1879,12 +1878,15 @@ static int _ocp_softreset(struct omap_hwmod *oh)
 	    !(oh->class->sysc->sysc_flags & SYSC_HAS_SOFTRESET))
 		return -ENOENT;
 
+	/* XXX Check some flag to ensure clocks enabled etc */
+#if 0
 	/* clocks must be on for this operation */
 	if (oh->_state != _HWMOD_STATE_ENABLED) {
 		pr_warn("omap_hwmod: %s: reset can only be entered from enabled state\n",
 			oh->name);
 		return -EINVAL;
 	}
+#endif
 
 	/* For some modules, all optionnal clocks need to be enabled as well */
 	if (oh->flags & HWMOD_CONTROL_OPT_CLKS_IN_RESET)
@@ -2053,6 +2055,188 @@ static int _omap4_get_context_lost(struct omap_hwmod *oh)
 }
 
 /**
+ * omap_hwmod_set_ocp_autoidle - set the hwmod's OCP autoidle bit
+ * @oh: struct omap_hwmod *
+ * @autoidle: desired AUTOIDLE bitfield value (0 or 1)
+ *
+ * Sets the IP block's OCP autoidle bit in hardware, and updates our
+ * local copy. Intended to be used by drivers that require
+ * direct manipulation of the AUTOIDLE bits.
+ * Returns -EINVAL if @oh is null or is not in the ENABLED state, or passes
+ * along the return value from _set_module_autoidle().
+ *
+ * Any users of this function should be scrutinized carefully.
+ */
+int omap_hwmod_set_ocp_autoidle(struct omap_hwmod *oh, u8 autoidle)
+{
+	u32 v;
+	int retval = 0;
+	unsigned long flags;
+
+	if (!oh || oh->_state != _HWMOD_STATE_ENABLED)
+		return -EINVAL;
+
+	spin_lock_irqsave(&oh->_lock, flags);
+
+	v = oh->_sysc_cache;
+
+	retval = _set_module_autoidle(oh, autoidle, &v);
+
+	if (!retval)
+		_write_sysconfig(v, oh);
+
+	spin_unlock_irqrestore(&oh->_lock, flags);
+
+	return retval;
+}
+
+/**
+ * _init_mpu_rt_base - populate the virtual address for a hwmod
+ * @oh: struct omap_hwmod * to locate the virtual address
+ *
+ * Cache the virtual address used by the MPU to access this IP block's
+ * registers.  This address is needed early so the OCP registers that
+ * are part of the device's address space can be ioremapped properly.
+ * No return value.
+ */
+static void __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data)
+{
+	struct omap_hwmod_addr_space *mem;
+	void __iomem *va_start;
+
+	if (!oh)
+		return;
+
+	_save_mpu_port_index(oh);
+
+	if (oh->_int_flags & _HWMOD_NO_MPU_PORT)
+		return;
+
+	mem = _find_mpu_rt_addr_space(oh);
+	if (!mem) {
+		pr_debug("omap_hwmod: %s: no MPU register target found\n",
+			 oh->name);
+		return;
+	}
+
+	va_start = ioremap(mem->pa_start, mem->pa_end - mem->pa_start);
+	if (!va_start) {
+		pr_err("omap_hwmod: %s: Could not ioremap\n", oh->name);
+		return;
+	}
+
+	pr_debug("omap_hwmod: %s: MPU register target at va %p\n",
+		 oh->name, va_start);
+
+	oh->_mpu_rt_va = va_start;
+}
+
+/**
+ * _init - initialize internal data for the hwmod @oh
+ * @oh: struct omap_hwmod *
+ *
+ * Look up the clocks and the address space used by the MPU to access
+ * registers belonging to the hwmod @oh.  @oh must already be
+ * registered at this point.  This is the first of two phases for
+ * hwmod initialization.  Code called here does not touch any hardware
+ * registers, it simply prepares internal data structures.  Returns 0
+ * upon success or if the hwmod isn't registered, or -EINVAL upon
+ * failure.
+ */
+static int __init _init(struct omap_hwmod *oh)
+{
+	int r;
+
+	if (oh->_state != _HWMOD_STATE_REGISTERED)
+		return 0;
+
+	_init_mpu_rt_base(oh, NULL);
+
+	r = _init_clocks(oh);
+	if (IS_ERR_VALUE(r)) {
+		WARN(1, "omap_hwmod: %s: couldn't init clocks\n", oh->name);
+		return -EINVAL;
+	}
+
+	oh->_state = _HWMOD_STATE_INITIALIZED;
+
+	return 0;
+}
+
+/**
+ * _setup_iclk_autoidle - configure an IP block's interface clocks
+ * @oh: struct omap_hwmod *
+ *
+ * Set up the module's interface clocks.  XXX This function is still mostly
+ * a stub; implementing this properly requires iclk autoidle usecounting in
+ * the clock code.   No return value.
+ */
+static void _setup_iclk_autoidle(struct omap_hwmod *oh)
+{
+	struct omap_hwmod_ocp_if *os;
+	struct list_head *p;
+	int i = 0;
+
+	p = oh->slave_ports.next;
+
+	while (i < oh->slaves_cnt) {
+		os = _fetch_next_ocp_if(&p, &i);
+		if (!os->_clk)
+			continue;
+
+		if (os->flags & OCPIF_SWSUP_IDLE) {
+			/* XXX omap_iclk_deny_idle(c); */
+		} else {
+			/* XXX omap_iclk_allow_idle(c); */
+			clk_enable(os->_clk);
+		}
+	}
+
+	return;
+}
+
+/**
+ * _setup - prepare IP block hardware for use
+ * @oh: struct omap_hwmod *
+ *
+ * Configure the IP block represented by @oh.  This may include
+ * enabling the IP block and resetting it, depending on the type of IP
+ * block and applicable flags.  IP blocks are reset to prevent any
+ * previous configuration by the bootloader or previous operating
+ * system from interfering with power management or other parts of the
+ * system.  The reset can be avoided; see omap_hwmod_no_setup_reset().
+ * This is the second of two phases for hwmod initialization.  Code
+ * called here generally affects the IP block hardware, or system
+ * integration hardware associated with the IP block.  Returns 0.
+ * XXX Document other return types
+ */
+static int _setup(struct omap_hwmod *oh)
+{
+	int r = 0;
+
+	if (oh->_state != _HWMOD_STATE_INITIALIZED)
+		return 0;
+
+	_setup_iclk_autoidle(oh);
+
+	if (oh->flags & HWMOD_EXT_OPT_MAIN_CLK)
+		return -EPERM;
+
+	if (!(oh->flags & HWMOD_INIT_NO_RESET)) {
+		r = _reset(oh);
+		if (r)
+			if (r != -ENOENT)  /* XXX TEmporary */
+				pr_err("omap_hwmod: %s: _setup reset failed: %d\n",
+				       oh->name, r);
+	}
+
+	oh->_state = _HWMOD_STATE_SETUP;
+	oh->_int_flags |= _HWMOD_FIRST_ENABLE_SETUP;
+
+	return 0;
+}
+
+/**
  * _enable - enable an omap_hwmod
  * @oh: struct omap_hwmod *
  *
@@ -2067,28 +2251,10 @@ static int _enable(struct omap_hwmod *oh)
 
 	pr_debug("omap_hwmod: %s: enabling\n", oh->name);
 
-	/*
-	 * hwmods with HWMOD_INIT_NO_IDLE flag set are left in enabled
-	 * state at init.  Now that someone is really trying to enable
-	 * them, just ensure that the hwmod mux is set.
-	 */
-	if (oh->_int_flags & _HWMOD_SKIP_ENABLE) {
-		/*
-		 * If the caller has mux data populated, do the mux'ing
-		 * which wouldn't have been done as part of the _enable()
-		 * done during setup.
-		 */
-		if (oh->mux)
-			omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
-
-		oh->_int_flags &= ~_HWMOD_SKIP_ENABLE;
-		return 0;
-	}
-
 	if (oh->_state != _HWMOD_STATE_INITIALIZED &&
 	    oh->_state != _HWMOD_STATE_IDLE &&
 	    oh->_state != _HWMOD_STATE_DISABLED) {
-		WARN(1, "omap_hwmod: %s: enabled state can only be entered from initialized, idle, or disabled state\n",
+		WARN(1, "omap_hwmod: %s: enabled state can only be entered from setup, idle, or disabled state\n",
 			oh->name);
 		return -EINVAL;
 	}
@@ -2135,6 +2301,11 @@ static int _enable(struct omap_hwmod *oh)
 	if (soc_ops.enable_module)
 		soc_ops.enable_module(oh);
 
+	/* XXX Set some flag to indicate module enabled */
+
+	if (!(oh->_int_flags & _HWMOD_FIRST_ENABLE_SETUP))
+		_setup(oh);
+
 	if (soc_ops.update_context_lost)
 		soc_ops.update_context_lost(oh);
 
@@ -2148,14 +2319,14 @@ static int _enable(struct omap_hwmod *oh)
 		if (oh->clkdm && hwsup)
 			clkdm_allow_idle(oh->clkdm);
 
-		oh->_state = _HWMOD_STATE_ENABLED;
-
 		/* Access the sysconfig only if the target is ready */
 		if (oh->class->sysc) {
 			if (!(oh->_int_flags & _HWMOD_SYSCONFIG_LOADED))
 				_update_sysc_cache(oh);
 			_enable_sysc(oh);
 		}
+
+		oh->_state = _HWMOD_STATE_ENABLED;
 	} else {
 		if (soc_ops.disable_module)
 			soc_ops.disable_module(oh);
@@ -2220,42 +2391,6 @@ static int _idle(struct omap_hwmod *oh)
 }
 
 /**
- * omap_hwmod_set_ocp_autoidle - set the hwmod's OCP autoidle bit
- * @oh: struct omap_hwmod *
- * @autoidle: desired AUTOIDLE bitfield value (0 or 1)
- *
- * Sets the IP block's OCP autoidle bit in hardware, and updates our
- * local copy. Intended to be used by drivers that require
- * direct manipulation of the AUTOIDLE bits.
- * Returns -EINVAL if @oh is null or is not in the ENABLED state, or passes
- * along the return value from _set_module_autoidle().
- *
- * Any users of this function should be scrutinized carefully.
- */
-int omap_hwmod_set_ocp_autoidle(struct omap_hwmod *oh, u8 autoidle)
-{
-	u32 v;
-	int retval = 0;
-	unsigned long flags;
-
-	if (!oh || oh->_state != _HWMOD_STATE_ENABLED)
-		return -EINVAL;
-
-	spin_lock_irqsave(&oh->_lock, flags);
-
-	v = oh->_sysc_cache;
-
-	retval = _set_module_autoidle(oh, autoidle, &v);
-
-	if (!retval)
-		_write_sysconfig(v, oh);
-
-	spin_unlock_irqrestore(&oh->_lock, flags);
-
-	return retval;
-}
-
-/**
  * _shutdown - shutdown an omap_hwmod
  * @oh: struct omap_hwmod *
  *
@@ -2324,245 +2459,6 @@ static int _shutdown(struct omap_hwmod *oh)
 }
 
 /**
- * _init_mpu_rt_base - populate the virtual address for a hwmod
- * @oh: struct omap_hwmod * to locate the virtual address
- *
- * Cache the virtual address used by the MPU to access this IP block's
- * registers.  This address is needed early so the OCP registers that
- * are part of the device's address space can be ioremapped properly.
- * No return value.
- */
-static void __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data)
-{
-	struct omap_hwmod_addr_space *mem;
-	void __iomem *va_start;
-
-	if (!oh)
-		return;
-
-	_save_mpu_port_index(oh);
-
-	if (oh->_int_flags & _HWMOD_NO_MPU_PORT)
-		return;
-
-	mem = _find_mpu_rt_addr_space(oh);
-	if (!mem) {
-		pr_debug("omap_hwmod: %s: no MPU register target found\n",
-			 oh->name);
-		return;
-	}
-
-	va_start = ioremap(mem->pa_start, mem->pa_end - mem->pa_start);
-	if (!va_start) {
-		pr_err("omap_hwmod: %s: Could not ioremap\n", oh->name);
-		return;
-	}
-
-	pr_debug("omap_hwmod: %s: MPU register target at va %p\n",
-		 oh->name, va_start);
-
-	oh->_mpu_rt_va = va_start;
-}
-
-/**
- * _init - initialize internal data for the hwmod @oh
- * @oh: struct omap_hwmod *
- * @n: (unused)
- *
- * Look up the clocks and the address space used by the MPU to access
- * registers belonging to the hwmod @oh.  @oh must already be
- * registered at this point.  This is the first of two phases for
- * hwmod initialization.  Code called here does not touch any hardware
- * registers, it simply prepares internal data structures.  Returns 0
- * upon success or if the hwmod isn't registered, or -EINVAL upon
- * failure.
- */
-static int __init _init(struct omap_hwmod *oh, void *data)
-{
-	int r;
-
-	if (oh->_state != _HWMOD_STATE_REGISTERED)
-		return 0;
-
-	_init_mpu_rt_base(oh, NULL);
-
-	r = _init_clocks(oh, NULL);
-	if (IS_ERR_VALUE(r)) {
-		WARN(1, "omap_hwmod: %s: couldn't init clocks\n", oh->name);
-		return -EINVAL;
-	}
-
-	oh->_state = _HWMOD_STATE_INITIALIZED;
-
-	return 0;
-}
-
-/**
- * _setup_iclk_autoidle - configure an IP block's interface clocks
- * @oh: struct omap_hwmod *
- *
- * Set up the module's interface clocks.  XXX This function is still mostly
- * a stub; implementing this properly requires iclk autoidle usecounting in
- * the clock code.   No return value.
- */
-static void __init _setup_iclk_autoidle(struct omap_hwmod *oh)
-{
-	struct omap_hwmod_ocp_if *os;
-	struct list_head *p;
-	int i = 0;
-	if (oh->_state != _HWMOD_STATE_INITIALIZED)
-		return;
-
-	p = oh->slave_ports.next;
-
-	while (i < oh->slaves_cnt) {
-		os = _fetch_next_ocp_if(&p, &i);
-		if (!os->_clk)
-			continue;
-
-		if (os->flags & OCPIF_SWSUP_IDLE) {
-			/* XXX omap_iclk_deny_idle(c); */
-		} else {
-			/* XXX omap_iclk_allow_idle(c); */
-			clk_enable(os->_clk);
-		}
-	}
-
-	return;
-}
-
-/**
- * _setup_reset - reset an IP block during the setup process
- * @oh: struct omap_hwmod *
- *
- * Reset the IP block corresponding to the hwmod @oh during the setup
- * process.  The IP block is first enabled so it can be successfully
- * reset.  Returns 0 upon success or a negative error code upon
- * failure.
- */
-static int __init _setup_reset(struct omap_hwmod *oh)
-{
-	int r;
-
-	if (oh->_state != _HWMOD_STATE_INITIALIZED)
-		return -EINVAL;
-
-	if (oh->flags & HWMOD_EXT_OPT_MAIN_CLK)
-		return -EPERM;
-
-	if (oh->rst_lines_cnt == 0) {
-		r = _enable(oh);
-		if (r) {
-			pr_warning("omap_hwmod: %s: cannot be enabled for reset (%d)\n",
-				   oh->name, oh->_state);
-			return -EINVAL;
-		}
-	}
-
-	if (!(oh->flags & HWMOD_INIT_NO_RESET))
-		r = _reset(oh);
-
-	return r;
-}
-
-/**
- * _setup_postsetup - transition to the appropriate state after _setup
- * @oh: struct omap_hwmod *
- *
- * Place an IP block represented by @oh into a "post-setup" state --
- * either IDLE, ENABLED, or DISABLED.  ("post-setup" simply means that
- * this function is called at the end of _setup().)  The postsetup
- * state for an IP block can be changed by calling
- * omap_hwmod_enter_postsetup_state() early in the boot process,
- * before one of the omap_hwmod_setup*() functions are called for the
- * IP block.
- *
- * The IP block stays in this state until a PM runtime-based driver is
- * loaded for that IP block.  A post-setup state of IDLE is
- * appropriate for almost all IP blocks with runtime PM-enabled
- * drivers, since those drivers are able to enable the IP block.  A
- * post-setup state of ENABLED is appropriate for kernels with PM
- * runtime disabled.  The DISABLED state is appropriate for unusual IP
- * blocks such as the MPU WDTIMER on kernels without WDTIMER drivers
- * included, since the WDTIMER starts running on reset and will reset
- * the MPU if left active.
- *
- * This post-setup mechanism is deprecated.  Once all of the OMAP
- * drivers have been converted to use PM runtime, and all of the IP
- * block data and interconnect data is available to the hwmod code, it
- * should be possible to replace this mechanism with a "lazy reset"
- * arrangement.  In a "lazy reset" setup, each IP block is enabled
- * when the driver first probes, then all remaining IP blocks without
- * drivers are either shut down or enabled after the drivers have
- * loaded.  However, this cannot take place until the above
- * preconditions have been met, since otherwise the late reset code
- * has no way of knowing which IP blocks are in use by drivers, and
- * which ones are unused.
- *
- * No return value.
- */
-static void __init _setup_postsetup(struct omap_hwmod *oh)
-{
-	u8 postsetup_state;
-
-	if (oh->rst_lines_cnt > 0)
-		return;
-
-	postsetup_state = oh->_postsetup_state;
-	if (postsetup_state == _HWMOD_STATE_UNKNOWN)
-		postsetup_state = _HWMOD_STATE_ENABLED;
-
-	/*
-	 * XXX HWMOD_INIT_NO_IDLE does not belong in hwmod data -
-	 * it should be set by the core code as a runtime flag during startup
-	 */
-	if ((oh->flags & HWMOD_INIT_NO_IDLE) &&
-	    (postsetup_state == _HWMOD_STATE_IDLE)) {
-		oh->_int_flags |= _HWMOD_SKIP_ENABLE;
-		postsetup_state = _HWMOD_STATE_ENABLED;
-	}
-
-	if (postsetup_state == _HWMOD_STATE_IDLE)
-		_idle(oh);
-	else if (postsetup_state == _HWMOD_STATE_DISABLED)
-		_shutdown(oh);
-	else if (postsetup_state != _HWMOD_STATE_ENABLED)
-		WARN(1, "hwmod: %s: unknown postsetup state %d! defaulting to enabled\n",
-		     oh->name, postsetup_state);
-
-	return;
-}
-
-/**
- * _setup - prepare IP block hardware for use
- * @oh: struct omap_hwmod *
- * @n: (unused, pass NULL)
- *
- * Configure the IP block represented by @oh.  This may include
- * enabling the IP block, resetting it, and placing it into a
- * post-setup state, depending on the type of IP block and applicable
- * flags.  IP blocks are reset to prevent any previous configuration
- * by the bootloader or previous operating system from interfering
- * with power management or other parts of the system.  The reset can
- * be avoided; see omap_hwmod_no_setup_reset().  This is the second of
- * two phases for hwmod initialization.  Code called here generally
- * affects the IP block hardware, or system integration hardware
- * associated with the IP block.  Returns 0.
- */
-static int __init _setup(struct omap_hwmod *oh, void *data)
-{
-	if (oh->_state != _HWMOD_STATE_INITIALIZED)
-		return 0;
-
-	_setup_iclk_autoidle(oh);
-
-	if (!_setup_reset(oh))
-		_setup_postsetup(oh);
-
-	return 0;
-}
-
-/**
  * _register - register a struct omap_hwmod
  * @oh: struct omap_hwmod *
  *
@@ -3248,15 +3144,17 @@ int __init omap_hwmod_register_links(struct omap_hwmod_ocp_if **ois)
  */
 static void __init _ensure_mpu_hwmod_is_setup(struct omap_hwmod *oh)
 {
-	if (!mpu_oh || mpu_oh->_state == _HWMOD_STATE_UNKNOWN)
+	if (!mpu_oh || mpu_oh->_state == _HWMOD_STATE_UNKNOWN) {
 		pr_err("omap_hwmod: %s: MPU initiator hwmod %s not yet registered\n",
 		       __func__, MPU_INITIATOR_NAME);
-	else if (mpu_oh->_state == _HWMOD_STATE_REGISTERED && oh != mpu_oh)
-		omap_hwmod_setup_one(MPU_INITIATOR_NAME);
+	} else if (mpu_oh->_state == _HWMOD_STATE_REGISTERED && oh != mpu_oh) {
+		_init(mpu_oh);
+		_setup(mpu_oh);
+	}
 }
 
 /**
- * omap_hwmod_setup_one - set up a single hwmod
+ * omap_hwmod_init_one - set up a single hwmod
  * @oh_name: const char * name of the already-registered hwmod to set up
  *
  * Initialize and set up a single hwmod.  Intended to be used for a
@@ -3266,7 +3164,7 @@ static void __init _ensure_mpu_hwmod_is_setup(struct omap_hwmod *oh)
  * registered omap_hwmod.  Also calls _setup() on each hwmod.  Returns
  * -EINVAL upon error or 0 upon success.
  */
-int __init omap_hwmod_setup_one(const char *oh_name)
+int __init omap_hwmod_init_one(const char *oh_name)
 {
 	struct omap_hwmod *oh;
 
@@ -3280,30 +3178,72 @@ int __init omap_hwmod_setup_one(const char *oh_name)
 
 	_ensure_mpu_hwmod_is_setup(oh);
 
-	_init(oh, NULL);
-	_setup(oh, NULL);
+	_init(oh);
 
 	return 0;
 }
 
 /**
- * omap_hwmod_setup_all - set up all registered IP blocks
+ * omap_hwmod_init_all - set up all registered IP blocks
  *
  * Initialize and set up all IP blocks registered with the hwmod code.
  * Must be called after omap2_clk_init().  Resolves the struct clk
  * names to struct clk pointers for each registered omap_hwmod.  Also
  * calls _setup() on each hwmod.  Returns 0 upon success.
  */
-static int __init omap_hwmod_setup_all(void)
+static int __init omap_hwmod_init_all(void)
 {
+	struct omap_hwmod *temp_oh;
+	int ret = 0;
+
 	_ensure_mpu_hwmod_is_setup(NULL);
 
-	omap_hwmod_for_each(_init, NULL);
-	omap_hwmod_for_each(_setup, NULL);
+	list_for_each_entry(temp_oh, &omap_hwmod_list, node) {
+		ret = _init(temp_oh);
+		if (ret)
+			pr_err("omap_hwmod: %s: could not initialize: %d\n",
+			       temp_oh->name, ret);
+	}
 
 	return 0;
 }
-core_initcall(omap_hwmod_setup_all);
+core_initcall(omap_hwmod_init_all);
+
+/**
+ * _shutdown_unused_late - call _setup() and _shutdown() on all unused hwmods
+ *
+ * XXX document
+ */
+static int __init _shutdown_unused_late(void)
+{
+	struct omap_hwmod *temp_oh;
+	int ret = 0;
+
+	pr_info("omap_hwmod: shutting down IP blocks not claimed by drivers\n");
+
+	list_for_each_entry(temp_oh, &omap_hwmod_list, node) {
+		if (temp_oh->_state != _HWMOD_STATE_INITIALIZED)
+			continue;
+
+		/* XXX */
+		pr_info("Attempting to enable & shut down %s\n", temp_oh->name);
+
+		ret = _enable(temp_oh);
+		if (ret)
+			pr_err("omap_hwmod: %s: _enable returned %d\n",
+			       temp_oh->name, ret);
+
+		/*
+		 * XXX HWMOD_INIT_NO_IDLE does not belong in hwmod data -
+		 * it should be set by the core code as a runtime flag during startup
+		 */
+		if (!(temp_oh->flags & HWMOD_INIT_NO_IDLE))
+			_shutdown(temp_oh);
+	}
+
+	return ret;
+}
+late_initcall(_shutdown_unused_late);
 
 /**
  * omap_hwmod_enable - enable an omap_hwmod
@@ -3328,6 +3268,32 @@ int omap_hwmod_enable(struct omap_hwmod *oh)
 }
 
 /**
+ * omap_hwmod_enable_all - XXX
+ *
+ * XXX document
+ */
+int __init omap_hwmod_enable_all(void)
+{
+	struct omap_hwmod *temp_oh;
+	int ret = 0;
+
+	list_for_each_entry(temp_oh, &omap_hwmod_list, node) {
+		if (temp_oh->_state != _HWMOD_STATE_INITIALIZED)
+			continue;
+
+		/* XXX */
+		pr_info("Attempting to enable %s\n", temp_oh->name);
+
+		ret = _enable(temp_oh);
+		if (ret)
+			pr_err("omap_hwmod: %s: %s returned %d\n",
+			       temp_oh->name, __func__, ret);
+	}
+
+	return ret;
+}
+
+/**
  * omap_hwmod_idle - idle an omap_hwmod
  * @oh: struct omap_hwmod *
  *
@@ -3945,46 +3911,6 @@ int omap_hwmod_for_each_by_class(const char *classname,
 }
 
 /**
- * omap_hwmod_set_postsetup_state - set the post-_setup() state for this hwmod
- * @oh: struct omap_hwmod *
- * @state: state that _setup() should leave the hwmod in
- *
- * Sets the hwmod state that @oh will enter at the end of _setup()
- * (called by omap_hwmod_setup_*()).  See also the documentation
- * for _setup_postsetup(), above.  Returns 0 upon success or
- * -EINVAL if there is a problem with the arguments or if the hwmod is
- * in the wrong state.
- */
-int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state)
-{
-	int ret;
-	unsigned long flags;
-
-	if (!oh)
-		return -EINVAL;
-
-	if (state != _HWMOD_STATE_DISABLED &&
-	    state != _HWMOD_STATE_ENABLED &&
-	    state != _HWMOD_STATE_IDLE)
-		return -EINVAL;
-
-	spin_lock_irqsave(&oh->_lock, flags);
-
-	if (oh->_state != _HWMOD_STATE_REGISTERED) {
-		ret = -EINVAL;
-		goto ohsps_unlock;
-	}
-
-	oh->_postsetup_state = state;
-	ret = 0;
-
-ohsps_unlock:
-	spin_unlock_irqrestore(&oh->_lock, flags);
-
-	return ret;
-}
-
-/**
  * omap_hwmod_get_context_loss_count - get lost context count
  * @oh: struct omap_hwmod *
  *
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 3ae852a..7346f7e 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -470,29 +470,26 @@ struct omap_hwmod_omap4_prcm {
  * _HWMOD_NO_MPU_PORT: no path exists for the MPU to write to this module
  * _HWMOD_WAKEUP_ENABLED: set when the omap_hwmod code has enabled ENAWAKEUP
  * _HWMOD_SYSCONFIG_LOADED: set when the OCP_SYSCONFIG value has been cached
- * _HWMOD_SKIP_ENABLE: set if hwmod enabled during init (HWMOD_INIT_NO_IDLE) -
- *     causes the first call to _enable() to only update the pinmux
+ * XXX
  */
 #define _HWMOD_NO_MPU_PORT			(1 << 0)
 #define _HWMOD_WAKEUP_ENABLED			(1 << 1)
 #define _HWMOD_SYSCONFIG_LOADED			(1 << 2)
-#define _HWMOD_SKIP_ENABLE			(1 << 3)
+#define _HWMOD_FIRST_ENABLE_SETUP		(1 << 3)
 
 /*
  * omap_hwmod._state definitions
  *
- * INITIALIZED: reset (optionally), initialized, enabled, disabled
- *              (optionally)
- *
- *
+ * XXX documentation needed
  */
 #define _HWMOD_STATE_UNKNOWN			0
 #define _HWMOD_STATE_REGISTERED			1
 #define _HWMOD_STATE_CLKS_INITED		2
 #define _HWMOD_STATE_INITIALIZED		3
-#define _HWMOD_STATE_ENABLED			4
-#define _HWMOD_STATE_IDLE			5
-#define _HWMOD_STATE_DISABLED			6
+#define _HWMOD_STATE_SETUP			4
+#define _HWMOD_STATE_ENABLED			5
+#define _HWMOD_STATE_IDLE			6
+#define _HWMOD_STATE_DISABLED			7
 
 /**
  * struct omap_hwmod_class - the type of an IP block
@@ -558,7 +555,6 @@ struct omap_hwmod_link {
  * @response_lat: device OCP response latency (in interface clock cycles)
  * @_int_flags: internal-use hwmod flags
  * @_state: internal-use hwmod state
- * @_postsetup_state: internal-use state to leave the hwmod in after _setup()
  * @flags: hwmod flags (documented below)
  * @_lock: spinlock serializing operations on this hwmod
  * @node: list node for hwmod list (internal use)
@@ -607,19 +603,20 @@ struct omap_hwmod {
 	u8				hwmods_cnt;
 	u8				_int_flags;
 	u8				_state;
-	u8				_postsetup_state;
 };
 
 struct omap_hwmod *omap_hwmod_lookup(const char *name);
 int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh, void *data),
 			void *data);
 
-int __init omap_hwmod_setup_one(const char *name);
+int __init omap_hwmod_init_one(const char *name);
 
 int omap_hwmod_enable(struct omap_hwmod *oh);
 int omap_hwmod_idle(struct omap_hwmod *oh);
 int omap_hwmod_shutdown(struct omap_hwmod *oh);
 
+int omap_hwmod_enable_all(void);
+
 int omap_hwmod_assert_hardreset(struct omap_hwmod *oh, const char *name);
 int omap_hwmod_deassert_hardreset(struct omap_hwmod *oh, const char *name);
 int omap_hwmod_read_hardreset(struct omap_hwmod *oh, const char *name);
@@ -659,7 +656,6 @@ int omap_hwmod_for_each_by_class(const char *classname,
 					   void *user),
 				 void *user);
 
-int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state);
 int omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
 
 int omap_hwmod_no_setup_reset(struct omap_hwmod *oh);
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 691aa67..17a1b42 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -299,7 +299,7 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 		}
 	}
 
-	omap_hwmod_setup_one(oh_name);
+	omap_hwmod_init_one(oh_name);
 	omap_hwmod_enable(oh);
 	__omap_dm_timer_init_regs(timer);
 
@@ -421,7 +421,7 @@ static int __init __maybe_unused omap2_sync32k_clocksource_init(void)
 	if (!oh || oh->slaves_cnt == 0)
 		return -ENODEV;
 
-	omap_hwmod_setup_one(oh_name);
+	omap_hwmod_init_one(oh_name);
 
 	if (np) {
 		vbase = of_iomap(np, 0);
-- 
1.7.10.4

