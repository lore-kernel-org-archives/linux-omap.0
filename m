From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 3/8] ARM: OMAP2+: hwmod: reorganize and document the
 setup process
Date: Thu, 19 Apr 2012 02:14:05 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204190208470.29048@utopia.booyaka.com>
References: <20120228053524.16278.59430.stgit@dusk> <20120228053651.16278.22844.stgit@dusk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1534895207-1334822998=:29048"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47988 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036Ab2DSIOH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Apr 2012 04:14:07 -0400
In-Reply-To: <20120228053651.16278.22844.stgit@dusk>
Content-ID: <alpine.DEB.2.00.1204190210050.29048@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1534895207-1334822998=:29048
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1204190210051.29048@utopia.booyaka.com>

Hi

On Mon, 27 Feb 2012, Paul Walmsley wrote:

> Reorganize the code involved in initializing and configuring an IP
> block to make it easier to read and maintain.  This involves improving
> documentation, splitting some large functions up into smaller ones to
> better conform with Documentation/CodingStyle, and removing some
> unnecessary code.
>=20
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Beno=EEt Cousson <b-cousson@ti.com>

A few changes have been made to this patch:

- The reset changes have been consolidated with the changes in patch 5.

- The changes to the _init function have been split into a separate patch
  to make it easier to debug.

The updated patch follows.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Wed, 18 Apr 2012 19:10:03 -0600
Subject: [PATCH 3/3] ARM: OMAP2+: hwmod: reorganize and document the reset
 and configuration process

Reorganize the code involved in resetting and configuring an IP block
to make it easier to read and maintain.  This involves improving
documentation, splitting some large functions up into smaller ones to
better conform with Documentation/CodingStyle, and removing some
unnecessary code.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=EEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |  152 ++++++++++++++++++++++++++++++----=
----
 1 file changed, 120 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hw=
mod.c
index 253e942..0afbebc 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1534,10 +1534,9 @@ static int _enable(struct omap_hwmod *oh)
 =09pr_debug("omap_hwmod: %s: enabling\n", oh->name);
=20
 =09/*
-=09 * hwmods with HWMOD_INIT_NO_IDLE flag set are left
-=09 * in enabled state at init.
-=09 * Now that someone is really trying to enable them,
-=09 * just ensure that the hwmod mux is set.
+=09 * hwmods with HWMOD_INIT_NO_IDLE flag set are left in enabled
+=09 * state at init.  Now that someone is really trying to enable
+=09 * them, just ensure that the hwmod mux is set.
 =09 */
 =09if (oh->_int_flags & _HWMOD_SKIP_ENABLE) {
 =09=09/*
@@ -1819,46 +1818,60 @@ static int __init _init(struct omap_hwmod *oh, void=
 *n)
 }
=20
 /**
- * _setup - do initial configuration of omap_hwmod
+ * _setup_iclk_autoidle - configure an IP block's interface clocks
  * @oh: struct omap_hwmod *
  *
- * Writes the CLOCKACTIVITY bits @clockact to the hwmod @oh
- * OCP_SYSCONFIG register.  Returns 0.
+ * Set up the module's interface clocks.  XXX This function is still mostl=
y
+ * a stub; implementing this properly requires iclk autoidle usecounting i=
n
+ * the clock code.   No return value.
  */
-static int _setup(struct omap_hwmod *oh, void *data)
+static void __init _setup_iclk_autoidle(struct omap_hwmod *oh)
 {
-=09int i, r;
-=09u8 postsetup_state;
+=09int i;
=20
 =09if (oh->_state !=3D _HWMOD_STATE_INITIALIZED)
-=09=09return 0;
+=09=09return;
=20
-=09/* Set iclk autoidle mode */
-=09if (oh->slaves_cnt > 0) {
-=09=09for (i =3D 0; i < oh->slaves_cnt; i++) {
-=09=09=09struct omap_hwmod_ocp_if *os =3D oh->slaves[i];
-=09=09=09struct clk *c =3D os->_clk;
+=09for (i =3D 0; i < oh->slaves_cnt; i++) {
+=09=09struct omap_hwmod_ocp_if *os =3D oh->slaves[i];
+=09=09struct clk *c =3D os->_clk;
=20
-=09=09=09if (!c)
-=09=09=09=09continue;
+=09=09if (!c)
+=09=09=09continue;
=20
-=09=09=09if (os->flags & OCPIF_SWSUP_IDLE) {
-=09=09=09=09/* XXX omap_iclk_deny_idle(c); */
-=09=09=09} else {
-=09=09=09=09/* XXX omap_iclk_allow_idle(c); */
-=09=09=09=09clk_enable(c);
-=09=09=09}
+=09=09if (os->flags & OCPIF_SWSUP_IDLE) {
+=09=09=09/* XXX omap_iclk_deny_idle(c); */
+=09=09} else {
+=09=09=09/* XXX omap_iclk_allow_idle(c); */
+=09=09=09clk_enable(c);
 =09=09}
 =09}
=20
-=09oh->_state =3D _HWMOD_STATE_INITIALIZED;
+=09return;
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
+=09int r;
+
+=09if (oh->_state !=3D _HWMOD_STATE_INITIALIZED)
+=09=09return -EINVAL;
=20
 =09/*
 =09 * In the case of hwmod with hardreset that should not be
 =09 * de-assert at boot time, we have to keep the module
 =09 * initialized, because we cannot enable it properly with the
-=09 * reset asserted. Exit without warning because that behavior is
-=09 * expected.
+=09 * reset asserted. Exit without warning because that behavior
+=09 * is expected.
 =09 */
 =09if ((oh->flags & HWMOD_INIT_NO_RESET) && oh->rst_lines_cnt > 0)
 =09=09return 0;
@@ -1871,7 +1884,53 @@ static int _setup(struct omap_hwmod *oh, void *data)
 =09}
=20
 =09if (!(oh->flags & HWMOD_INIT_NO_RESET))
-=09=09_reset(oh);
+=09=09r =3D _reset(oh);
+
+=09return r;
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
+=09u8 postsetup_state;
+
+=09if (oh->rst_lines_cnt > 0)
+=09=09return;
=20
 =09postsetup_state =3D oh->_postsetup_state;
 =09if (postsetup_state =3D=3D _HWMOD_STATE_UNKNOWN)
@@ -1895,6 +1954,35 @@ static int _setup(struct omap_hwmod *oh, void *data)
 =09=09WARN(1, "hwmod: %s: unknown postsetup state %d! defaulting to enable=
d\n",
 =09=09     oh->name, postsetup_state);
=20
+=09return;
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
+=09if (oh->_state !=3D _HWMOD_STATE_INITIALIZED)
+=09=09return 0;
+
+=09_setup_iclk_autoidle(oh);
+
+=09if (!_setup_reset(oh))
+=09=09_setup_postsetup(oh);
+
 =09return 0;
 }
=20
@@ -2700,10 +2788,10 @@ int omap_hwmod_for_each_by_class(const char *classn=
ame,
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
--=20
1.7.10

--155748971-1534895207-1334822998=:29048--
