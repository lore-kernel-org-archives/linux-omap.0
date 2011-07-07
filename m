From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3 04/13] OMAP: hwmod: Wait the idle status to be
 disabled
Date: Thu, 7 Jul 2011 02:10:52 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107070029570.31498@utopia.booyaka.com>
References: <1309554558-19819-1-git-send-email-b-cousson@ti.com> <1309554558-19819-5-git-send-email-b-cousson@ti.com> <20110705182144.GA10846@google.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-401741330-1310022414=:31498"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33646 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab1GGIKx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jul 2011 04:10:53 -0400
In-Reply-To: <20110705182144.GA10846@google.com>
Content-ID: <alpine.DEB.2.00.1107070110000.31498@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>, Benoit Cousson <b-cousson@ti.com>
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-401741330-1310022414=:31498
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1107070110001.31498@utopia.booyaka.com>

Hi Todd,

Beno=EEt is away right now, so I'll deal with the straightforward aspects o=
f=20
your comments, and leave the more complex parts for him when he gets=20
back.

On Tue, 5 Jul 2011, Todd Poynor wrote:

> On Fri, Jul 01, 2011 at 11:09:09PM +0200, Benoit Cousson wrote:
> > It is mandatory to wait for a module to be in disabled state before
> > potentially disabling source clock or re-asserting a reset.
> >=20
> > omap_hwmod_idle and omap_hwmod_shutdown does not wait for
> > the module to be fully idle.
> >=20
> > Add a cm_xxx accessor to wait the clkctrl idle status to be disabled.
> > Fix hwmod_[idle|shutdown] to use this API.
> ...
> > +int omap4_cm_wait_module_idle(u8 part, u16 inst, s16 cdoffs, u16 clkct=
rl_offs)
>=20
> Technically this waits for a module slave to enter "full idle" --
> "interface idle" not good enough, and if the module is also a master
> its standby status could possibly be different... personally, these
> details make my brain hurt, but thought I'd mention this in case
> the naming of this interface should capture any of these distinctions.

This is probably going to need clarification from someone who knows the=20
PRCM state machine.

>=20
> > +{
> > +=09int i =3D 0;
> > +
> > +=09if (!clkctrl_offs)
> > +=09=09return 0;
> > +
> > +=09omap_test_timeout(
> > +=09=09_clkctrl_idlest(part, inst, cdoffs, clkctrl_offs) =3D=3D 0x3,
> > +=09=09MAX_MODULE_READY_TIME, i);
>=20
> The numeric constant may already have an equivalent symbol defined, or
> suggest adding one.

Added.

>=20
> >  /**
> > + * _wait_target_disable - wait for a module to be disabled
> > + * @oh: struct omap_hwmod *
> > + *
> > + * Wait for a module @oh to leave slave idle.  Returns 0 if the module
> > + * does not have an IDLEST bit or if the module successfully leaves
> > + * slave idle; otherwise, pass along the return value of the
> > + * appropriate *_cm_wait_module_ready() function.
>=20
> This paragraph probably c&p from a function with opposite meaning.

Fixed.

> >  static int _idle(struct omap_hwmod *oh)
> >  {
> > +=09int ret;
> > +
> >  =09pr_debug("omap_hwmod: %s: idling\n", oh->name);
> > =20
> >  =09if (oh->_state !=3D _HWMOD_STATE_ENABLED) {
> > @@ -1351,6 +1383,10 @@ static int _idle(struct omap_hwmod *oh)
> >  =09=09_idle_sysc(oh);
> >  =09_del_initiator_dep(oh, mpu_oh);
> >  =09_disable_clocks(oh);
> > +=09ret =3D _wait_target_disable(oh);
> > +=09if (ret)
> > +=09=09pr_debug("omap_hwmod: %s: _wait_target_disable failed\n",
> > +=09=09=09   oh->name);
>=20
> Should callers see an error function return in this case?

I don't know, but I've changed the pr_debug() to pr_warn() so that these=20
aren't hidden.  That will result in some warnings on boot.  The goal is to=
=20
'inspire' someone to fix those issues in the -rc series or 3.2.

The updated patch is below.


- Paul

From: Benoit Cousson <b-cousson@ti.com>
Date: Fri, 1 Jul 2011 23:09:09 +0200
Subject: [PATCH] OMAP: hwmod: Wait the idle status to be disabled

It is mandatory to wait for a module to be in disabled state before
potentially disabling source clock or re-asserting a reset.

omap_hwmod_idle and omap_hwmod_shutdown does not wait for
the module to be fully idle.

Add a cm_xxx accessor to wait the clkctrl idle status to be disabled.
Fix hwmod_[idle|shutdown] to use this API.

Based on Rajendra's initial patch.

Please note that most interconnects hwmod will return one timeout because
it is impossible for them to be in idle since the processor is accessing
the registers though the interconnect.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Todd Poynor <toddpoynor@google.com>
[paul@pwsan.com: move cpu_is_*() tests to the top of _wait_target_disable()=
;
 incorporate some feedback from Todd]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/cminst44xx.c |   27 +++++++++++++++++++++++++
 arch/arm/mach-omap2/cminst44xx.h |    1 +
 arch/arm/mach-omap2/omap_hwmod.c |   40 ++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst4=
4xx.c
index 3f65ce0..61e4382 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -33,6 +33,8 @@
 #include "prm44xx.h"
 #include "prcm_mpu44xx.h"
=20
+#define CLKCTRL_IDLEST_DISABLED=09=09=090x3
+
 static u32 _cm_bases[OMAP4_MAX_PRCM_PARTITIONS] =3D {
 =09[OMAP4430_INVALID_PRCM_PARTITION]=09=3D 0,
 =09[OMAP4430_PRM_PARTITION]=09=09=3D OMAP4430_PRM_BASE,
@@ -244,3 +246,28 @@ int omap4_cminst_wait_module_ready(u8 part, u16 inst, =
s16 cdoffs, u16 clkctrl_of
 =09return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
 }
=20
+/**
+ * omap4_cminst_wait_module_idle - wait for a module to be in 'disabled'
+ * state
+ * @part: PRCM partition ID that the CM_CLKCTRL register exists in
+ * @inst: CM instance register offset (*_INST macro)
+ * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
+ * @clkctrl_offs: Module clock control register offset (*_CLKCTRL macro)
+ *
+ * Wait for the module IDLEST to be disabled. Some PRCM transition,
+ * like reset assertion or parent clock de-activation must wait the
+ * module to be fully disabled.
+ */
+int omap4_cminst_wait_module_idle(u8 part, u16 inst, s16 cdoffs, u16 clkct=
rl_offs)
+{
+=09int i =3D 0;
+
+=09if (!clkctrl_offs)
+=09=09return 0;
+
+=09omap_test_timeout((_clkctrl_idlest(part, inst, cdoffs, clkctrl_offs) =
=3D=3D
+=09=09=09   CLKCTRL_IDLEST_DISABLED),
+=09=09=09  MAX_MODULE_READY_TIME, i);
+
+=09return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
+}
diff --git a/arch/arm/mach-omap2/cminst44xx.h b/arch/arm/mach-omap2/cminst4=
4xx.h
index 8eba2ae..a985400 100644
--- a/arch/arm/mach-omap2/cminst44xx.h
+++ b/arch/arm/mach-omap2/cminst44xx.h
@@ -18,6 +18,7 @@ extern void omap4_cminst_clkdm_force_sleep(u8 part, s16 i=
nst, u16 cdoffs);
 extern void omap4_cminst_clkdm_force_wakeup(u8 part, s16 inst, u16 cdoffs)=
;
=20
 extern int omap4_cminst_wait_module_ready(u8 part, u16 inst, s16 cdoffs, u=
16 clkctrl_offs);
+extern int omap4_cminst_wait_module_idle(u8 part, u16 inst, s16 cdoffs, u1=
6 clkctrl_offs);
=20
 /*
  * In an ideal world, we would not export these low-level functions,
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hw=
mod.c
index 39c8831..fee80a8 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1013,6 +1013,36 @@ static int _wait_target_ready(struct omap_hwmod *oh)
 }
=20
 /**
+ * _wait_target_disable - wait for a module to be disabled
+ * @oh: struct omap_hwmod *
+ *
+ * Wait for a module @oh to enter slave idle.  Returns 0 if the module
+ * does not have an IDLEST bit or if the module successfully enters
+ * slave idle; otherwise, pass along the return value of the
+ * appropriate *_cm*_wait_module_idle() function.
+ */
+static int _wait_target_disable(struct omap_hwmod *oh)
+{
+=09/* TODO: For now just handle OMAP4+ */
+=09if (cpu_is_omap24xx() || cpu_is_omap34xx())
+=09=09return 0;
+
+=09if (!oh)
+=09=09return -EINVAL;
+
+=09if (oh->_int_flags & _HWMOD_NO_MPU_PORT)
+=09=09return 0;
+
+=09if (oh->flags & HWMOD_NO_IDLEST)
+=09=09return 0;
+
+=09return omap4_cminst_wait_module_idle(oh->clkdm->prcm_partition,
+=09=09=09=09=09     oh->clkdm->cm_inst,
+=09=09=09=09=09     oh->clkdm->clkdm_offs,
+=09=09=09=09=09     oh->prcm.omap4.clkctrl_offs);
+}
+
+/**
  * _lookup_hardreset - fill register bit info for this hwmod/reset line
  * @oh: struct omap_hwmod *
  * @name: name of the reset line in the context of this hwmod
@@ -1319,6 +1349,8 @@ static int _enable(struct omap_hwmod *oh)
  */
 static int _idle(struct omap_hwmod *oh)
 {
+=09int ret;
+
 =09if (oh->_state !=3D _HWMOD_STATE_ENABLED) {
 =09=09WARN(1, "omap_hwmod: %s: idle state can only be entered from "
 =09=09     "enabled state\n", oh->name);
@@ -1331,6 +1363,10 @@ static int _idle(struct omap_hwmod *oh)
 =09=09_idle_sysc(oh);
 =09_del_initiator_dep(oh, mpu_oh);
 =09_disable_clocks(oh);
+=09ret =3D _wait_target_disable(oh);
+=09if (ret)
+=09=09pr_warn("omap_hwmod: %s: _wait_target_disable failed\n",
+=09=09=09oh->name);
=20
 =09/* Mux pins for device idle if populated */
 =09if (oh->mux && oh->mux->pads_dynamic)
@@ -1427,6 +1463,10 @@ static int _shutdown(struct omap_hwmod *oh)
 =09=09_del_initiator_dep(oh, mpu_oh);
 =09=09/* XXX what about the other system initiators here? dma, dsp */
 =09=09_disable_clocks(oh);
+=09=09ret =3D _wait_target_disable(oh);
+=09=09if (ret)
+=09=09=09pr_warn("omap_hwmod: %s: _wait_target_disable failed\n",
+=09=09=09=09oh->name);
 =09}
 =09/* XXX Should this code also force-disable the optional clocks? */
=20
--=20
1.7.5.4

--155748971-401741330-1310022414=:31498--
