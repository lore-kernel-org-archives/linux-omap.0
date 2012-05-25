From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: OMAP2+: hwmod code/data: fix 32K sync timer
Date: Fri, 25 May 2012 15:56:22 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205251546160.25520@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1848285032-1337982982=:25520"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43600 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037Ab2EYV4X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 May 2012 17:56:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@ti.com, Vaibhav Hiremath <hvaibhav@ti.com>, Tony Lindgren <tony@atomide.com>, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1848285032-1337982982=:25520
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE


Kevin discovered that commit c8d82ff68fb6873691536cf33021977efbf5593c
("ARM: OMAP2/3: hwmod data: Add 32k-sync timer data to hwmod
database") broke CORE idle on OMAP3.  This blocks device low power
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
we can safely leave the 32k sync timer in target-no-idle mode, even
while we continue to access it.

This workaround is implemented by defining a new hwmod flag,
HWMOD_ALWAYS_FORCE_SIDLE, that places the IP block into target
force-idle mode even when enabled.  The 32k sync timer hwmods are
marked with this flag for OMAP3 and OMAP4 SoCs.  (On OMAP2xxx, no OCP
header existed on the 32k sync timer.)

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

This patch is effectively a workaround for a hardware oversight.  A
better hardware approach would have been to implement a smart-idle
target idle mode for this IP block.  The smart-idle mode in this case
would behave identically to the force-idle mode.  We consider the
force-idle and no-idle target idle mode settings to be intended for
debugging and automatic idle management bug workarounds only.

This patch is a collaboration between Kevin Hilman <khilman@ti.com>
and Paul Walmsley <paul@pwsan.com>.

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
Tested-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   17 +++++++++++------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |    1 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |    1 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    9 +++++++++
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hw=
mod.c
index bf86f7e..096474c 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1124,10 +1124,12 @@ static struct omap_hwmod_addr_space * __init _find_=
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
@@ -1141,8 +1143,11 @@ static void _enable_sysc(struct omap_hwmod *oh)
 =09sf =3D oh->class->sysc->sysc_flags;
=20
 =09if (sf & SYSC_HAS_SIDLEMODE) {
-=09=09idlemode =3D (oh->flags & HWMOD_SWSUP_SIDLE) ?
-=09=09=09HWMOD_IDLEMODE_NO : HWMOD_IDLEMODE_SMART;
+=09=09if (oh->flags & HWMOD_ALWAYS_FORCE_SIDLE)
+=09=09=09idlemode =3D HWMOD_IDLEMODE_FORCE;
+=09=09else
+=09=09=09idlemode =3D (oh->flags & HWMOD_SWSUP_SIDLE) ?
+=09=09=09=09HWMOD_IDLEMODE_NO : HWMOD_IDLEMODE_SMART;
 =09=09_set_slave_idlemode(oh, idlemode, &v);
 =09}
=20
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_3xxx_data.c
index fd48797..fddf63e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -2029,6 +2029,7 @@ static struct omap_hwmod omap3xxx_counter_32k_hwmod =
=3D {
 =09=09=09.idlest_idle_bit =3D OMAP3430_ST_32KSYNC_SHIFT,
 =09=09},
 =09},
+=09.flags=09=09=3D HWMOD_ALWAYS_FORCE_SIDLE,
 };
=20
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_44xx_data.c
index 950454a..900b4f0 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -416,6 +416,7 @@ static struct omap_hwmod omap44xx_counter_32k_hwmod =3D=
 {
 =09=09=09.context_offs =3D OMAP4_RM_WKUP_SYNCTIMER_CONTEXT_OFFSET,
 =09=09},
 =09},
+=09.flags=09=09=3D HWMOD_ALWAYS_FORCE_SIDLE,
 };
=20
 /*
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-o=
map/include/plat/omap_hwmod.h
index c835b71..038c0d7 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -409,6 +409,14 @@ struct omap_hwmod_omap4_prcm {
  *     in order to complete the reset. Optional clocks will be disabled
  *     again after the reset.
  * HWMOD_16BIT_REG: Module has 16bit registers
+ * HWMOD_ALWAYS_FORCE_SIDLE: Always program this module's SIDLEMODE to
+ *     force-idle mode, even when enabled.  This is needed for IP blocks
+ *     which do not support smart idle, which do not have a software
+ *     controllable functional or interface clock, and which the PRCM
+ *     will not assert SIdleReq until the kernel is not currently
+ *     running on the chip (e.g., the MPU is in idle).  For such modules,
+ *     fine-grained PM runtime-based idle control is simply a waste of
+ *     CPU cycles.
  */
 #define HWMOD_SWSUP_SIDLE=09=09=09(1 << 0)
 #define HWMOD_SWSUP_MSTANDBY=09=09=09(1 << 1)
@@ -419,6 +427,7 @@ struct omap_hwmod_omap4_prcm {
 #define HWMOD_NO_IDLEST=09=09=09=09(1 << 6)
 #define HWMOD_CONTROL_OPT_CLKS_IN_RESET=09=09(1 << 7)
 #define HWMOD_16BIT_REG=09=09=09=09(1 << 8)
+#define HWMOD_ALWAYS_FORCE_SIDLE=09=09(1 << 9)
=20
 /*
  * omap_hwmod._int_flags definitions
--=20
1.7.10

--155748971-1848285032-1337982982=:25520--
