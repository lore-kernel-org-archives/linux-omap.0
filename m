From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 4/8] ARM: OMAP2+: hwmod: revise hardreset behavior
Date: Thu, 19 Apr 2012 00:53:51 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204182253550.29048@utopia.booyaka.com>
References: <20120228053524.16278.59430.stgit@dusk> <20120228053654.16278.73632.stgit@dusk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1067519471-1334812263=:29048"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49904 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437Ab2DSGxw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Apr 2012 02:53:52 -0400
In-Reply-To: <20120228053654.16278.73632.stgit@dusk>
Content-ID: <alpine.DEB.2.00.1204182311290.29048@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1067519471-1334812263=:29048
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1204182311291.29048@utopia.booyaka.com>

Hi Beno=EEt,

On Mon, 27 Feb 2012, Paul Walmsley wrote:

> Change the way that hardreset lines are handled by the hwmod code.
> Hardreset lines are generally associated with initiator IP blocks.
> Prior to this change, the hwmod code expected to control hardreset
> lines itself, asserting them on shutdown and deasserting them upon
> enable.  But driver authors inside TI have commented to us that their
> drivers require direct control over these lines.  Unfortunately, these
> drivers haven't been posted publicly yet, so it's hard to determine
> exactly what is needed, a priori.  This change attempts to set forth
> some reasonable semantics that should be an improvement over the
> current code.

I took another look at this patch, and upon further thought, there are=20
some aspects of this design that really don't make sense.

> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_=
hwmod.c
> index 5b368ee..db4ad41 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -805,6 +805,9 @@ static int _omap4_disable_module(struct omap_hwmod *o=
h)
>  =09=09=09=09    oh->clkdm->clkdm_offs,
>  =09=09=09=09    oh->prcm.omap4.clkctrl_offs);
> =20
> +=09if (oh->rst_lines_cnt >=3D 0)
> +=09=09return 0;

This change prevents any IP block from waiting for the target to disable=20
-- which is not what we want.  The na=EFve fix would be to only skip the=20
disable-wait if oh->rst_lines_cnt is greater than zero.  But if there are=
=20
no hardreset lines asserted, then we should probably wait for the disable=
=20
in that case.

>  =09v =3D _omap4_wait_target_disable(oh);
>  =09if (v)
>  =09=09pr_warn("omap_hwmod: %s: _wait_target_disable failed\n",

[...]

> @@ -1575,7 +1568,19 @@ static int _enable(struct omap_hwmod *oh)
>  =09_enable_clocks(oh);
>  =09_enable_module(oh);
> =20
> -=09r =3D _wait_target_ready(oh);
> +=09/*
> +=09 * If an IP contains HW reset lines, we leave them
> +=09 * asserted.  But this will block the module's idle state
> +=09 * transition - the PRCM will return Intransition status.  So
> +=09 * we need to avoid the target ready-wait in this case.  XXX
> +=09 * We also need to give the drivers a way to wait for the
> +=09 * target to become ready once they decide to deassert some
> +=09 * hardreset lines.  XXX Is this strategy going to break PM
> +=09 * because the clockdomain may not be able to enter idle while
> +=09 * the module's idle status is in-transition?  We may just need
> +=09 * custom reset blocks for all IPs with hardreset lines.
> +=09 */
> +=09r =3D (oh->rst_lines_cnt =3D=3D 0) ? _wait_target_ready(oh) : 1;

And this part is at odds with the patch description.  If there are=20
hardreset lines associated with an IP block, then this code will cause the=
=20
following code to unconditionally disable the module clocks.  Considering=
=20
that this is the _enable() function, this seems counterproductive.

I looked into changing this code to align with the original semantics we=20
discussed.  It seems quite challenging.  With the current codebase, we'd=20
have to bail out in the middle of the enable sequence.  Then we'd lose the=
=20
clockdomain state (the 'hwsup' variable).

So I've updated the patch to essentially bail out early from all hwmod=20
enable, idle, and shutdown code, if any hardreset lines associated with=20
the IP block are asserted.  It will then be the driver integration code's=
=20
responsibility for enabling the IP block when the hardreset lines are=20
asserted.  When the hardreset lines are deasserted, the usual hwmod code=20
will be executed -- I'd assume this would be the case during normal=20
operation of the device.  I think this is probably the best we can do=20
until we actually hear back from the people responsible for drivers for=20
these special IP blocks.

A revised patch is below.  Care to take a look and see if it makes sense=20
to you?


regards,

- Paul


From: Paul Walmsley <paul@pwsan.com>
Date: Wed, 18 Apr 2012 19:10:04 -0600
Subject: [PATCH] ARM: OMAP2+: hwmod: revise hardreset behavior

Change the way that hardreset lines are handled by the hwmod code.
Hardreset lines are generally associated with initiator IP blocks.
Prior to this change, the hwmod code expected to control hardreset
lines itself, asserting them on shutdown and deasserting them upon
enable.  But driver authors inside TI have commented to us that their
drivers require direct control over these lines.  Unfortunately, these
drivers haven't been posted publicly yet, so it's hard to determine
exactly what is needed, a priori.  This change attempts to set forth
some reasonable semantics that should be an improvement over the
current code.

The semantics implemented by this patch are as follows:

- If the hwmod is not marked with HWMOD_INIT_NO_RESET, then assert all
  associated hardreset lines during IP block setup.  This is intended
  to place the IP blocks into a known state that will not interfere
  with other devices during kernel boot.

- IP blocks with hardreset lines will not be automatically enabled or
  idled during setup.  Instead, they will be left in the INITIALIZED
  state.

- When the hwmod code is asked to enable, idle, or shutdown an IP
  block with asserted hardreset lines, the hwmod code will do nothing.
  The driver integration code must do the remaining work needed to
  control these IP blocks.  Once this driver integration code is posted
  to the lists, hopefully we can consolidate it and move it inside the
  hwmod code.

Custom reset functions for IP blocks with hardreset lines still should
be supported and are strongly endorsed.  It is intended that every
subsystem with hardreset lines should have a custom reset function
that can place their subsystem into quiescent idle with the hardreset
lines deasserted.

This reverts most of commit 5365efbe29250a227502256cc912351fe2157b42
("OMAP: hwmod: Add hardreset management support").  Later code
reorganizations caused the sequencing of the code from this patch to
be changed, anyway.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=EEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |  140 ++++++++++++++++++++++------------=
----
 1 file changed, 83 insertions(+), 57 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hw=
mod.c
index e6aa14f..a5c3a9a 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -781,39 +781,6 @@ static int _omap4_wait_target_disable(struct omap_hwmo=
d *oh)
 }
=20
 /**
- * _omap4_disable_module - enable CLKCTRL modulemode on OMAP4
- * @oh: struct omap_hwmod *
- *
- * Disable the PRCM module mode related to the hwmod @oh.
- * Return EINVAL if the modulemode is not supported and 0 in case of succe=
ss.
- */
-static int _omap4_disable_module(struct omap_hwmod *oh)
-{
-=09int v;
-
-=09/* The module mode does not exist prior OMAP4 */
-=09if (!cpu_is_omap44xx())
-=09=09return -EINVAL;
-
-=09if (!oh->clkdm || !oh->prcm.omap4.modulemode)
-=09=09return -EINVAL;
-
-=09pr_debug("omap_hwmod: %s: %s\n", oh->name, __func__);
-
-=09omap4_cminst_module_disable(oh->clkdm->prcm_partition,
-=09=09=09=09    oh->clkdm->cm_inst,
-=09=09=09=09    oh->clkdm->clkdm_offs,
-=09=09=09=09    oh->prcm.omap4.clkctrl_offs);
-
-=09v =3D _omap4_wait_target_disable(oh);
-=09if (v)
-=09=09pr_warn("omap_hwmod: %s: _wait_target_disable failed\n",
-=09=09=09oh->name);
-
-=09return 0;
-}
-
-/**
  * _count_mpu_irqs - count the number of MPU IRQ lines associated with @oh
  * @oh: struct omap_hwmod *oh
  *
@@ -1378,6 +1345,66 @@ static int _read_hardreset(struct omap_hwmod *oh, co=
nst char *name)
 }
=20
 /**
+ * _are_any_hardreset_lines_asserted - return true if part of @oh is hard-=
reset
+ * @oh: struct omap_hwmod *
+ *
+ * If any hardreset line associated with @oh is asserted, then return true=
=2E
+ * Otherwise, if @oh has no hardreset lines associated with it, or if
+ * no hardreset lines associated with @oh are asserted, then return false.
+ * This function is used to avoid executing some parts of the IP block
+ * enable/disable sequence if a hardreset line is set.
+ */
+static bool _are_any_hardreset_lines_asserted(struct omap_hwmod *oh)
+{
+=09int i;
+
+=09if (oh->rst_lines_cnt =3D=3D 0)
+=09=09return false;
+
+=09for (i =3D 0; i < oh->rst_lines_cnt; i++)
+=09=09if (_read_hardreset(oh, oh->rst_lines[i].name) > 0)
+=09=09=09return true;
+
+=09return false;
+}
+
+/**
+ * _omap4_disable_module - enable CLKCTRL modulemode on OMAP4
+ * @oh: struct omap_hwmod *
+ *
+ * Disable the PRCM module mode related to the hwmod @oh.
+ * Return EINVAL if the modulemode is not supported and 0 in case of succe=
ss.
+ */
+static int _omap4_disable_module(struct omap_hwmod *oh)
+{
+=09int v;
+
+=09/* The module mode does not exist prior OMAP4 */
+=09if (!cpu_is_omap44xx())
+=09=09return -EINVAL;
+
+=09if (!oh->clkdm || !oh->prcm.omap4.modulemode)
+=09=09return -EINVAL;
+
+=09pr_debug("omap_hwmod: %s: %s\n", oh->name, __func__);
+
+=09omap4_cminst_module_disable(oh->clkdm->prcm_partition,
+=09=09=09=09    oh->clkdm->cm_inst,
+=09=09=09=09    oh->clkdm->clkdm_offs,
+=09=09=09=09    oh->prcm.omap4.clkctrl_offs);
+
+=09if (_are_any_hardreset_lines_asserted(oh))
+=09=09return 0;
+
+=09v =3D _omap4_wait_target_disable(oh);
+=09if (v)
+=09=09pr_warn("omap_hwmod: %s: _wait_target_disable failed\n",
+=09=09=09oh->name);
+
+=09return 0;
+}
+
+/**
  * _ocp_softreset - reset an omap_hwmod via the OCP_SYSCONFIG bit
  * @oh: struct omap_hwmod *
  *
@@ -1519,7 +1546,7 @@ static int _reset(struct omap_hwmod *oh)
  */
 static int _enable(struct omap_hwmod *oh)
 {
-=09int r, i;
+=09int r;
 =09int hwsup =3D 0;
=20
 =09pr_debug("omap_hwmod: %s: enabling\n", oh->name);
@@ -1551,14 +1578,16 @@ static int _enable(struct omap_hwmod *oh)
 =09}
=20
 =09/*
-=09 * If an IP contains HW reset lines, then de-assert them in order
-=09 * to allow the module state transition. Otherwise the PRCM will return
-=09 * Intransition status, and the init will failed.
+=09 * If an IP block contains HW reset lines and any of them are
+=09 * asserted, we let integration code associated with that
+=09 * block handle the enable.  We've received very little
+=09 * information on what those driver authors need, and until
+=09 * detailed information is provided and the driver code is
+=09 * posted to the public lists, this is probably the best we
+=09 * can do.
 =09 */
-=09if (oh->_state =3D=3D _HWMOD_STATE_INITIALIZED ||
-=09    oh->_state =3D=3D _HWMOD_STATE_DISABLED)
-=09=09for (i =3D 0; i < oh->rst_lines_cnt; i++)
-=09=09=09_deassert_hardreset(oh, oh->rst_lines[i].name);
+=09if (_are_any_hardreset_lines_asserted(oh))
+=09=09return 0;
=20
 =09/* Mux pins for device runtime if populated */
 =09if (oh->mux && (!oh->mux->enabled ||
@@ -1633,6 +1662,9 @@ static int _idle(struct omap_hwmod *oh)
 =09=09return -EINVAL;
 =09}
=20
+=09if (_are_any_hardreset_lines_asserted(oh))
+=09=09return 0;
+
 =09if (oh->class->sysc)
 =09=09_idle_sysc(oh);
 =09_del_initiator_dep(oh, mpu_oh);
@@ -1715,6 +1747,9 @@ static int _shutdown(struct omap_hwmod *oh)
 =09=09return -EINVAL;
 =09}
=20
+=09if (_are_any_hardreset_lines_asserted(oh))
+=09=09return 0;
+
 =09pr_debug("omap_hwmod: %s: disabling\n", oh->name);
=20
 =09if (oh->class->pre_shutdown) {
@@ -1824,27 +1859,18 @@ static int __init _setup_reset(struct omap_hwmod *o=
h)
 =09if (oh->_state !=3D _HWMOD_STATE_INITIALIZED)
 =09=09return -EINVAL;
=20
-=09/*
-=09 * In the case of hwmod with hardreset that should not be
-=09 * de-assert at boot time, we have to keep the module
-=09 * initialized, because we cannot enable it properly with the
-=09 * reset asserted. Exit without warning because that behavior
-=09 * is expected.
-=09 */
-=09if ((oh->flags & HWMOD_INIT_NO_RESET) && oh->rst_lines_cnt > 0)
-=09=09return 0;
-
-=09r =3D _enable(oh);
-=09if (r) {
-=09=09pr_warning("omap_hwmod: %s: cannot be enabled (%d)\n",
-=09=09=09   oh->name, oh->_state);
-=09=09return 0;
+=09if (oh->rst_lines_cnt =3D=3D 0) {
+=09=09r =3D _enable(oh);
+=09=09if (r) {
+=09=09=09pr_warning("omap_hwmod: %s: cannot be enabled for reset (%d)\n",
+=09=09=09=09   oh->name, oh->_state);
+=09=09=09return -EINVAL;
+=09=09}
 =09}
=20
 =09if (!(oh->flags & HWMOD_INIT_NO_RESET))
 =09=09r =3D _reset(oh);
=20
-
 =09return r;
 }
 /**
--=20
1.7.10
--155748971-1067519471-1334812263=:29048--
