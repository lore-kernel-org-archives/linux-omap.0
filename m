From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] omap2plus: wdt: Fix boot warn when CONFIG_PM_RUNTIME=n
Date: Thu, 14 Oct 2010 12:37:34 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010141234190.21196@utopia.booyaka.com>
References: <1286798556-22749-1-git-send-email-charu@ti.com> <4CB40B07.8080301@ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB030CFC553C@dbde02.ent.ti.com> <4CB45E0E.6080104@ti.com> <87mxqj1d2v.fsf@deeprootsystems.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB030D09A22D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1133109231-1287081454=:21196"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46105 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755913Ab0JNShf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Oct 2010 14:37:35 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030D09A22D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1133109231-1287081454=:21196
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello Charu, Kevin, Beno=EEt,

On Thu, 14 Oct 2010, Varadarajan, Charulatha wrote:

> Please provide your input on this.

Thinking about this problem -- and the earlier problem of how to
determine what state to leave the watchdog in -- what occurs to me is
that we should probably:

1. add a function pointer in the struct omap_hwmod_class for a custom
   pre-shutdown function, called before clocks are disabled, etc.; that
   can do the appropriate register writes needed during an
   omap_hwmod_shutdown() while the device is still considered to be=20
   enabled;

2. add a function to allow OMAP core code or board-*.c code to tell
   the hwmod code to leave a hwmod disabled at the end of _setup(),
   rather than idled or left enabled -- something like
   omap_hwmod_set_postsetup_state(HWMOD_STATE_DISABLED);

3. look to see if we can detect if the watchdog is enabled before the
   hwmod code starts -- perhaps by reading WSPR? -- and if it is not
   enabled, calling
   omap_hwmod_set_postsetup_state(HWMOD_STATE_DISABLED) prior to
   calling omap_hwmod_late_init();

4. disable the MPU watchdog by default if #3 is not possible, and then
   allow specific board files to indicate that it should be enabled if
   they want full kernel boot watchdog coverage with something like
   omap_hwmod_set_postsetup_state(HWMOD_STATE_IDLE); and possibly also
   add a kernel command line parameter like "enable_omapwdt_boot" that
   can specify that the watchdog should be left enabled upon boot.

This arrangement is a little more complicated, but it ensures that
omap_hwmod_shutdown() really will shut down the watchdog.  It also
makes it possible for individual board files or bootloader
configurations to ensure full watchdog coverage of the kernel
initialization process.  If I were designing a commercial OMAP-based
device, I'd probably want full watchdog coverage of the entire boot
process from the bootloader onwards.  But simultaneously we don't want
to change the existing kernel behavior too much -- most of our
developer users would probably be shocked if, upon upgrading to a new
kernel, suddenly the watchdog started rebooting their machines -- so
it makes sense to me to disable the watchdog unless instructed
otherwise.

Enclosed below is a work-in-progress patch to illustrate the proposal.
It clearly needs some more work and should be split into at least two
patches, but it might help clarify what I am proposing.

We also should, IMHO, move the struct omap_hwmod_class definitions out of
the main hwmod data files, since they may contain function pointers.  (We
will probably also need a .reset function pointer there also to deal
with complicated IPs like the IVA2, as we discussed a few months ago.)
We should try to restrict the main omap_hwmod data files to be relatively
OS-independent data structures.

Regarding the omap_hwmod_is_enabled() proposal: it seems racy to me.  In
theory the system state can change after the result of
omap_hwmod_is_enabled() is tested, but before the consequence of the
conditional statement runs.  There used to be a similar problem in the
clock framework with a clk_is_enabled() function (a similar race still
exists with the clk_get_rate() function).  If possible, I think we
should try to avoid creating APIs that are explicitly racy.

Charu, I think that functions like omap2_disable_wdt() and any related
watchdog device manipulation functions should go into their own file
-- something like arch/arm/mach-omap2/wd_timer.c ? -- and not live in
devices.c.

One last thing: Beno=EEt, in the hwmod data, I think we should separate
watchdog IPs that are automatically enabled upon reset (like the MPU
watchdog), from watchdogs that are disabled after reset (like the IVA2
watchdog).  It doesn't matter to me whether we create a second class,
or whether we just use a dev_attr flag.  If we separate these, then
code can use omap_hwmod_for_each_class() to ensure that all watchdogs
of this type are disabled upon boot, rather than hardcoding a specific
hwmod.


Thoughts?

=2E..

As an aside, we seem to again be skirting issues of what it means for
a hwmod to be "enabled" and "idle."  If we read "enabled" as "fully
functional and registers accessible," that seems to make sense; but if
we consider idle as meaning "configured but nonfunctional," that does
not match up to the state that modules like WDT and GPIO are left in.
The issue with WDT is that it probably does not IdleAck when enabled
and its clocks are turned off, as Beno=EEt mentioned; and the issue with
GPIO is that it can generate asynchronous interrupts, even when all
its clocks are off.  It would be good if we could clarify the
semantics for these states in some formal way.  Perhaps more states
are needed at the hwmod level?  Or perhaps we just need to clarify
what "idle" really means...


- Paul


From=202e05f1c33b2c5b081146079a2908fe5bbb4350d6 Mon Sep 17 00:00:00 2001
From: Paul Walmsley <paul@pwsan.com>
Date: Thu, 14 Oct 2010 11:47:46 -0600
Subject: [RFC PATCH] OMAP2+: hwmod: add postsetup state suppotr

Experimental, didactic patch to add postsetup state, selected at runtime. =
=20
This patch needs major work before merging; it's simply intended to=20
illustrate a proposal.

Not-yet-signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/io.c                     |   53 ++++++++++++++++++++--=
-
 arch/arm/mach-omap2/omap_hwmod.c             |   59 +++++++++++++++++++---=
----
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   16 +++++++-
 3 files changed, 105 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 40562dd..e3a423d 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -311,10 +311,15 @@ static int __init _omap2_init_reprogram_sdrc(void)
 =09return v;
 }
=20
-void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
-=09=09=09=09 struct omap_sdrc_params *sdrc_cs1)
+/* XXX document */
+static int _set_hwmod_postsetup_state(struct omap_hwmod *oh, void *data)
+{
+=09return omap_hwmod_set_postsetup_state(oh, *(u8 *)data);
+}
+
+static void __init omap2_init_common_infra(void)
 {
-=09u8 skip_setup_idle =3D 0;
+=09u8 postsetup_state;
=20
 =09pwrdm_init(powerdomains_omap);
 =09clkdm_init(clockdomains_omap, clkdm_autodeps);
@@ -327,6 +332,24 @@ void __init omap2_init_common_hw(struct omap_sdrc_para=
ms *sdrc_cs0,
 =09else if (cpu_is_omap44xx())
 =09=09omap44xx_hwmod_init();
=20
+=09/* Set the default postsetup state for all hwmods ... */
+#ifdef CONFIG_PM_RUNTIME
+=09postsetup_state =3D _HWMOD_STATE_IDLE;
+#else
+=09postsetup_state =3D _HWMOD_STATE_ENABLED;
+#endif
+=09omap_hwmod_for_each(_set_hwmod_postsetup_state, &postsetup_state);
+
+=09/* ... then handle the exceptions for unusual modules (like MPU WDT) */
+=09/*
+=09 * XXX ideally we could detect whether the MPU WDT was currently
+=09 * enabled here and make this conditional
+=09 */
+=09postsetup_state =3D _HWMOD_STATE_DISABLED;
+=09omap_hwmod_for_each_by_class("wd_timer_enabled_on_reset",
+=09=09=09=09     _set_hwmod_postsetup_state,
+=09=09=09=09     &postsetup_state);
+
 =09/* The OPP tables have to be registered before a clk init */
 =09omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
=20
@@ -340,16 +363,32 @@ void __init omap2_init_common_hw(struct omap_sdrc_par=
ams *sdrc_cs0,
 =09=09omap4xxx_clk_init();
 =09else
 =09=09pr_err("Could not init clock framework - unknown CPU\n");
+}
=20
+static void __init omap2_init_common_devices(struct omap_sdrc_params *sdrc=
_cs0,
+=09=09=09=09=09     struct omap_sdrc_params *sdrc_cs1)
+{
 =09omap_serial_early_init();
=20
-#ifndef CONFIG_PM_RUNTIME
-=09skip_setup_idle =3D 1;
-#endif
-=09omap_hwmod_late_init(skip_setup_idle);
+=09omap_hwmod_late_init();
+
 =09if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
 =09=09omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
 =09=09_omap2_init_reprogram_sdrc();
 =09}
 =09gpmc_init();
 }
+
+/*
+ * XXX this function should go away and the board-*.c files should call
+ * both omap2_init_common_infra() and omap2_init_common_devices(),
+ * so the board-*.c files can override some default hwmod postsetup_states
+ * (e.g., for watchdog) between the two functions.
+ */
+void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
+=09=09=09=09 struct omap_sdrc_params *sdrc_cs1)
+{
+=09omap2_init_common_infra();
+=09omap2_init_common_devices(sdrc_cs0, sdrc_cs1);
+}
+
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hw=
mod.c
index 5a30658..618e135 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1298,24 +1298,19 @@ static int _shutdown(struct omap_hwmod *oh)
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
 =09int i, r;
-=09u8 skip_setup_idle;
+=09u8 postsetup_state;
=20
 =09if (!oh || !data)
 =09=09return -EINVAL;
=20
-=09skip_setup_idle =3D *(u8 *)data;
-
 =09/* Set iclk autoidle mode */
 =09if (oh->slaves_cnt > 0) {
 =09=09for (i =3D 0; i < oh->slaves_cnt; i++) {
@@ -1368,8 +1363,24 @@ static int _setup(struct omap_hwmod *oh, void *data)
 =09=09}
 =09}
=20
-=09if (!(oh->flags & HWMOD_INIT_NO_IDLE) && !skip_setup_idle)
+=09postsetup_state =3D oh->_postsetup_state;
+=09if (postsetup_state =3D=3D _HWMOD_STATE_UNKNOWN)
+=09=09postsetup_state =3D _HWMOD_STATE_ENABLED;
+
+=09/*
+=09 * XXX HWMOD_INIT_NO_IDLE does not belong in hwmod data -
+=09 * it should be set by the core code as a runtime flag during startup
+=09 */
+=09if (!(oh->flags & HWMOD_INIT_NO_IDLE))
+=09=09postsetup_state =3D _HWMOD_STATE_IDLE;
+
+=09if (postsetup_state =3D=3D _HWMOD_STATE_IDLE)
 =09=09_omap_hwmod_idle(oh);
+=09else if (postsetup_state =3D=3D _HWMOD_STATE_DISABLED)
+=09=09_shutdown(oh);
+=09else
+=09=09WARN(1, "hwmod: %s: unknown postsetup state %d! defaulting to enable=
d\n",
+=09=09     oh->name, postsetup_state);
=20
 =09return 0;
 }
@@ -1570,13 +1581,12 @@ int omap_hwmod_init(struct omap_hwmod **ohs)
=20
 /**
  * omap_hwmod_late_init - do some post-clock framework initialization
- * @skip_setup_idle: if 1, do not idle hwmods in _setup()
  *
  * Must be called after omap2_clk_init().  Resolves the struct clk names
  * to struct clk pointers for each registered omap_hwmod.  Also calls
  * _setup() on each hwmod.  Returns 0.
  */
-int omap_hwmod_late_init(u8 skip_setup_idle)
+int omap_hwmod_late_init(void)
 {
 =09int r;
=20
@@ -1588,10 +1598,7 @@ int omap_hwmod_late_init(u8 skip_setup_idle)
 =09WARN(!mpu_oh, "omap_hwmod: could not find MPU initiator hwmod %s\n",
 =09     MPU_INITIATOR_NAME);
=20
-=09if (skip_setup_idle)
-=09=09pr_debug("omap_hwmod: will leave hwmods enabled during setup\n");
-
-=09omap_hwmod_for_each(_setup, &skip_setup_idle);
+=09omap_hwmod_for_each(_setup, NULL);
=20
 =09return 0;
 }
@@ -2117,3 +2124,25 @@ int omap_hwmod_for_each_by_class(const char *classna=
me,
 =09return ret;
 }
=20
+
+/**
+ * omap_hwmod_set_postsetup_state - set the post-_setup() state for this h=
wmod
+ * @oh: struct omap_hwmod *
+ * @state: state that _setup() should leave the hwmod in
+ *
+ * XXX document
+ *
+ */
+int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state)
+{
+=09if (!oh)
+=09=09return -EINVAL;
+
+=09/* XXX insure valid @state passed in */
+
+=09mutex_lock(&oh->_mutex);
+=09oh->_postsetup_state =3D state;
+=09mutex_unlock(&oh->_mutex);
+
+=09return 0;
+}
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-o=
map/include/plat/omap_hwmod.h
index 7eaa8ed..a566efc 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -415,14 +415,24 @@ struct omap_hwmod_omap4_prcm {
  * @name: name of the hwmod_class
  * @sysc: device SYSCONFIG/SYSSTATUS register data
  * @rev: revision of the IP class
+ * @pre_shutdown: fn ptr to be executed immediately prior to device shutdo=
wn
  *
  * Represent the class of a OMAP hardware "modules" (e.g. timer,
  * smartreflex, gpio, uart...)
+ *
+ * @pre_shutdown is a function that will be run immediately before
+ * hwmod clocks are disabled, etc.  It is intended for use for hwmods
+ * like the MPU watchdog, which cannot be disabled with the standard
+ * omap_hwmod_shutdown().  The function should return 0 upon success,
+ * or some negative error upon failure.  Returning an error will cause
+ * omap_hwmod_shutdown() to abort the device shutdown and return an
+ * error.
  */
 struct omap_hwmod_class {
 =09const char=09=09=09=09*name;
 =09struct omap_hwmod_class_sysconfig=09*sysc;
 =09u32=09=09=09=09=09rev;
+=09int=09=09=09=09=09(*pre_shutdown)(struct omap_hwmod *oh);
 };
=20
 /**
@@ -452,6 +462,7 @@ struct omap_hwmod_class {
  * @response_lat: device OCP response latency (in interface clock cycles)
  * @_int_flags: internal-use hwmod flags
  * @_state: internal-use hwmod state
+ * @_postsetup_state: internal-use state to leave the hwmod in after _setu=
p()
  * @flags: hwmod flags (documented below)
  * @omap_chip: OMAP chips this hwmod is present on
  * @_mutex: mutex serializing operations on this hwmod
@@ -500,6 +511,7 @@ struct omap_hwmod {
 =09u8=09=09=09=09hwmods_cnt;
 =09u8=09=09=09=09_int_flags;
 =09u8=09=09=09=09_state;
+=09u8=09=09=09=09_postsetup_state;
 =09const struct omap_chip_id=09omap_chip;
 };
=20
@@ -509,7 +521,7 @@ int omap_hwmod_unregister(struct omap_hwmod *oh);
 struct omap_hwmod *omap_hwmod_lookup(const char *name);
 int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh, void *data),
 =09=09=09void *data);
-int omap_hwmod_late_init(u8 skip_setup_idle);
+int omap_hwmod_late_init(void);
=20
 int omap_hwmod_enable(struct omap_hwmod *oh);
 int _omap_hwmod_enable(struct omap_hwmod *oh);
@@ -556,6 +568,8 @@ int omap_hwmod_for_each_by_class(const char *classname,
 =09=09=09=09=09   void *user),
 =09=09=09=09 void *user);
=20
+int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state);
+
 /*
  * Chip variant-specific hwmod init routines - XXX should be converted
  * to use initcalls once the initial boot ordering is straightened out
--=20
1.7.1

--155748971-1133109231-1287081454=:21196--
