From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv2 02/12] ARM: OMAP2+: hwmod code/data: fix 32K sync
 timer
Date: Wed, 4 Jul 2012 06:48:48 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207040625090.6760@utopia.booyaka.com>
References: <20120611004502.20034.8840.stgit@dusk> <20120611004555.20034.87035.stgit@dusk> <4FDA15AA.6090704@ti.com> <alpine.DEB.2.00.1206141136080.30212@utopia.booyaka.com> <4FDA45F5.9090300@ti.com> <alpine.DEB.2.00.1206141706420.25628@utopia.booyaka.com>
 <4FDB387C.7030003@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-831221608-1341406128=:6760"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59455 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869Ab2GDMst (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 08:48:49 -0400
In-Reply-To: <4FDB387C.7030003@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-831221608-1341406128=:6760
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Beno=EEt,

On Fri, 15 Jun 2012, Cousson, Benoit wrote:

> My point is simple, we should not add any new custom flag when all the=20
> information to detect such exception are already there in the current=20
> data and represent accurately what the HW is doing.

This seems like the crux of the issue.  We don't have sufficient=20
information to detect this exception in our current data, in my view. =20
The software additionally must know when it can rely on a clockdomain=20
remaining active when the MPU is active.

Ideally the hardcoded clockdomain sleep dependencies would be encoded, and=
=20
we could test the intersection of those and the software-programmable=20
clockdomain sleep dependencies.  But such a change seems too complex for=20
the -rc cycle.  So the updated patch below uses a clockdomain data flag=20
for this instead.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Wed, 4 Jul 2012 05:22:53 -0600
Subject: [PATCH] ARM: OMAP2+: hwmod code/clockdomain data: fix 32K sync tim=
er

Kevin discovered that commit c8d82ff68fb6873691536cf33021977efbf5593c
("ARM: OMAP2/3: hwmod data: Add 32k-sync timer data to hwmod
database") broke CORE idle on OMAP3.  This prevents device low power
states.

The root cause is that the 32K sync timer IP block does not support
smart-idle mode[1], and so the hwmod code keeps the IP block in
no-idle mode while it is active.  This in turn prevents the WKUP
clockdomain from transitioning to idle.  There is a hardcoded sleep
dependency that prevents the CORE_L3 and CORE_CM clockdomains from
transitioning to idle when the WKUP clockdomain is active[2], so the
chip cannot enter any device low power states.

It turns out that there is no need to take the 32k sync timer out of
idle.  The IP block itself probably does not have any native idle
handling at all, due to its simplicity.  Furthermore, the PRCM will
never request target idle for this IP block while the kernel is
running, due to the sleep dependency that prevents the WKUP
clockdomain from idling while the CORE_L3 clockdomain is active.  So
we can safely leave the 32k sync timer in target-force-idle mode, even
while we continue to access it.

This workaround is implemented by defining a new clockdomain flag,
CLKDM_ACTIVE_WITH_MPU, that indicates that the clockdomain is
guaranteed to be active whenever the MPU is inactive.  If an IP
block's main functional clock exists inside this clockdomain, and the
IP block does not support smart-idle modes, then the hwmod code will
place the IP block into target force-idle mode even when enabled.  The
WKUP clockdomains on OMAP3/4 are marked with this flag.  (On OMAP2xxx,
no OCP header existed on the 32k sync timer.)   Other clockdomains also
should be marked with this flag, but those changes are deferred until
a later merge window, to create a minimal fix.

Another theoretically clean fix for this problem would be to implement
PM runtime-based control for 32k sync timer accesses.  These PM
runtime calls would need to located in a custom clocksource, since the
32k sync timer is currently used as an MMIO clocksource.  But in
practice, there would be little benefit to doing so; and there would
be some cost, due to the addition of unnecessary lines of code and the
additional CPU overhead of the PM runtime and hwmod code - unnecessary
in this case.

Another possible fix would have been to modify the pm34xx.c code to
force the IP block idle before entering WFI.  But this would not have
been an acceptable approach: we are trying to remove this type of
centralized IP block idle control from the PM code.

This patch is a collaboration between Kevin Hilman <khilman@ti.com>
and Paul Walmsley <paul@pwsan.com>.

Thanks to Vaibhav Hiremath <hvaibhav@ti.com> for providing comments on
an earlier version of this patch.  Thanks to Tero Kristo
<t-kristo@ti.com> for identifying a bug in an earlier version of this
patch.  Thanks to Beno=EEt Cousson <b-cousson@ti.com> for identifying some
bugs in an earlier version of this patch and for implementation comments.

References:

1. Table 16-96 "REG_32KSYNCNT_SYSCONFIG" of the OMAP34xx TRM Rev. ZU
   (SWPU223U), available from:
   http://www.ti.com/pdfs/wtbu/OMAP34x_ES3.1.x_PUBLIC_TRM_vzU.zip

2. Table 4-72 "Sleep Dependencies" of the OMAP34xx TRM Rev. ZU
   (SWPU223U)

3. ibid.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Beno=EEt Cousson <b-cousson@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clockdomain.h                |    4 +++
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |    1 +
 arch/arm/mach-omap2/clockdomains44xx_data.c      |    4 +--
 arch/arm/mach-omap2/omap_hwmod.c                 |   32 ++++++++++++++++--=
----
 4 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockd=
omain.h
index f7b5860..6227e95 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -31,12 +31,16 @@
  *
  * CLKDM_NO_AUTODEPS: Prevent "autodeps" from being added/removed from thi=
s
  *     clockdomain.  (Currently, this applies to OMAP3 clockdomains only.)
+ * CLKDM_ACTIVE_WITH_MPU: The PRCM guarantees that this clockdomain is
+ *     active whenever the MPU is active.  True for interconnects and
+ *     the WKUP clockdomains.
  */
 #define CLKDM_CAN_FORCE_SLEEP=09=09=09(1 << 0)
 #define CLKDM_CAN_FORCE_WAKEUP=09=09=09(1 << 1)
 #define CLKDM_CAN_ENABLE_AUTO=09=09=09(1 << 2)
 #define CLKDM_CAN_DISABLE_AUTO=09=09=09(1 << 3)
 #define CLKDM_NO_AUTODEPS=09=09=09(1 << 4)
+#define CLKDM_ACTIVE_WITH_MPU=09=09=09(1 << 5)
=20
 #define CLKDM_CAN_HWSUP=09=09(CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_DISABLE_AU=
TO)
 #define CLKDM_CAN_SWSUP=09=09(CLKDM_CAN_FORCE_SLEEP | CLKDM_CAN_FORCE_WAKE=
UP)
diff --git a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c b/arch/arm/ma=
ch-omap2/clockdomains2xxx_3xxx_data.c
index 839145e..4972219 100644
--- a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
@@ -88,4 +88,5 @@ struct clockdomain wkup_common_clkdm =3D {
 =09.name=09=09=3D "wkup_clkdm",
 =09.pwrdm=09=09=3D { .name =3D "wkup_pwrdm" },
 =09.dep_bit=09=3D OMAP_EN_WKUP_SHIFT,
+=09.flags=09=09=3D CLKDM_ACTIVE_WITH_MPU,
 };
diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-om=
ap2/clockdomains44xx_data.c
index c534258..6e93d49 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -1,7 +1,7 @@
 /*
  * OMAP4 Clock domains framework
  *
- * Copyright (C) 2009-2011 Texas Instruments, Inc.
+ * Copyright (C) 2009-2012 Texas Instruments, Inc.
  * Copyright (C) 2009-2011 Nokia Corporation
  *
  * Abhijit Pagare (abhijitpagare@ti.com)
@@ -381,7 +381,7 @@ static struct clockdomain l4_wkup_44xx_clkdm =3D {
 =09.cm_inst=09  =3D OMAP4430_PRM_WKUP_CM_INST,
 =09.clkdm_offs=09  =3D OMAP4430_PRM_WKUP_CM_WKUP_CDOFFS,
 =09.dep_bit=09  =3D OMAP4430_L4WKUP_STATDEP_SHIFT,
-=09.flags=09=09  =3D CLKDM_CAN_HWSUP,
+=09.flags=09=09  =3D CLKDM_CAN_HWSUP | CLKDM_ACTIVE_WITH_MPU,
 };
=20
 static struct clockdomain emu_sys_44xx_clkdm =3D {
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hw=
mod.c
index 7731936..f749546 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1124,15 +1124,18 @@ static struct omap_hwmod_addr_space * __init _find_=
mpu_rt_addr_space(struct omap
  * _enable_sysc - try to bring a module out of idle via OCP_SYSCONFIG
  * @oh: struct omap_hwmod *
  *
- * If module is marked as SWSUP_SIDLE, force the module out of slave
- * idle; otherwise, configure it for smart-idle.  If module is marked
- * as SWSUP_MSUSPEND, force the module out of master standby;
- * otherwise, configure it for smart-standby.  No return value.
+ * Ensure that the OCP_SYSCONFIG register for the IP block represented
+ * by @oh is set to indicate to the PRCM that the IP block is active.
+ * Usually this means placing the module into smart-idle mode and
+ * smart-standby, but if there is a bug in the automatic idle handling
+ * for the IP block, it may need to be placed into the force-idle or
+ * no-idle variants of these modes.  No return value.
  */
 static void _enable_sysc(struct omap_hwmod *oh)
 {
 =09u8 idlemode, sf;
 =09u32 v;
+=09bool clkdm_act;
=20
 =09if (!oh->class->sysc)
 =09=09return;
@@ -1141,8 +1144,16 @@ static void _enable_sysc(struct omap_hwmod *oh)
 =09sf =3D oh->class->sysc->sysc_flags;
=20
 =09if (sf & SYSC_HAS_SIDLEMODE) {
-=09=09idlemode =3D (oh->flags & HWMOD_SWSUP_SIDLE) ?
-=09=09=09HWMOD_IDLEMODE_NO : HWMOD_IDLEMODE_SMART;
+=09=09clkdm_act =3D ((oh->clkdm &&
+=09=09=09      oh->clkdm->flags & CLKDM_ACTIVE_WITH_MPU) ||
+=09=09=09     (oh->_clk->clkdm &&
+=09=09=09      oh->_clk->clkdm->flags & CLKDM_ACTIVE_WITH_MPU));
+=09=09if (clkdm_act && !(oh->class->sysc->idlemodes &
+=09=09=09=09   (SIDLE_SMART | SIDLE_SMART_WKUP)))
+=09=09=09idlemode =3D HWMOD_IDLEMODE_FORCE;
+=09=09else
+=09=09=09idlemode =3D (oh->flags & HWMOD_SWSUP_SIDLE) ?
+=09=09=09=09HWMOD_IDLEMODE_NO : HWMOD_IDLEMODE_SMART;
 =09=09_set_slave_idlemode(oh, idlemode, &v);
 =09}
=20
@@ -1208,8 +1219,13 @@ static void _idle_sysc(struct omap_hwmod *oh)
 =09sf =3D oh->class->sysc->sysc_flags;
=20
 =09if (sf & SYSC_HAS_SIDLEMODE) {
-=09=09idlemode =3D (oh->flags & HWMOD_SWSUP_SIDLE) ?
-=09=09=09HWMOD_IDLEMODE_FORCE : HWMOD_IDLEMODE_SMART;
+=09=09/* XXX What about HWMOD_IDLEMODE_SMART_WKUP? */
+=09=09if (oh->flags & HWMOD_SWSUP_SIDLE ||
+=09=09    !(oh->class->sysc->idlemodes &
+=09=09      (SIDLE_SMART | SIDLE_SMART_WKUP)))
+=09=09=09idlemode =3D HWMOD_IDLEMODE_FORCE;
+=09=09else
+=09=09=09idlemode =3D HWMOD_IDLEMODE_SMART;
 =09=09_set_slave_idlemode(oh, idlemode, &v);
 =09}
=20
--=20
1.7.10

--155748971-831221608-1341406128=:6760--
