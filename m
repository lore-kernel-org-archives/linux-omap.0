From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 05/11] ARM: OMAP2+: hwmod code/data: fix 32K sync timer
Date: Thu, 07 Jun 2012 00:13:10 -0600
Message-ID: <20120607061309.25532.13430.stgit@dusk>
References: <20120607060901.25532.68354.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60883 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760021Ab2FGGVh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 02:21:37 -0400
In-Reply-To: <20120607060901.25532.68354.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

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
we can safely leave the 32k sync timer in target-no-idle mode, even
while we continue to access it.

This workaround is implemented by programming the force-idle mode for
any IP block that only supports the force-idle and no-idle modes.  If
an IP block is ever released that doesn't support smart-idle and
requires no-idle mode to be programmed while it's in use, we'll have
to change this behavior.

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

This patch is effectively a workaround for a hardware problem.  A
better hardware approach would have been to implement a smart-idle
target idle mode for this IP block.  The smart-idle mode in this case
would behave identically to the force-idle mode.  We consider the
force-idle and no-idle target idle mode settings to be intended for
debugging and automatic idle management bug workarounds only[4].

This patch is a collaboration between Kevin Hilman <khilman@ti.com>
and Paul Walmsley <paul@pwsan.com>.

References:

1. Table 16-96 "REG_32KSYNCNT_SYSCONFIG" of the OMAP34xx TRM Rev. ZU
   (SWPU223U), available from:
   http://www.ti.com/pdfs/wtbu/OMAP34x_ES3.1.x_PUBLIC_TRM_vzU.zip

2. Table 4-72 "Sleep Dependencies" of the OMAP34xx TRM Rev. ZU
   (SWPU223U)

3. ibid.

4. Section 3.1.1.1.2 "Module-Level Clock Management" of The
   OMAP4430 TRM Rev. vAA (SWPU231AA).

Cc: Tony Lindgren <tony@atomide.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Tested-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   32 ++++++++++++++++++++++++++----=
--
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index b0d3064..6b4ae31 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1124,10 +1124,12 @@ static struct omap_hwmod_addr_space * __init _f=
ind_mpu_rt_addr_space(struct omap
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
@@ -1141,8 +1143,26 @@ static void _enable_sysc(struct omap_hwmod *oh)
 	sf =3D oh->class->sysc->sysc_flags;
=20
 	if (sf & SYSC_HAS_SIDLEMODE) {
-		idlemode =3D (oh->flags & HWMOD_SWSUP_SIDLE) ?
-			HWMOD_IDLEMODE_NO : HWMOD_IDLEMODE_SMART;
+		if (oh->flags & HWMOD_SWSUP_SIDLE) {
+			/*
+			 * IP blocks without smart idle should be left
+			 * in force-idle.  Currently this only applies
+			 * to 32k sync "timer" which is guaranteed to
+			 * be accessible when the kernel is running.
+			 * HWMOD_SWSUP_IDLE must also be set on these
+			 * IP blocks to indicate a hardware problem.
+			 * XXX Not an ideal workaround.
+			 */
+			if (oh->class->sysc->idlemodes &
+			    (SIDLE_NO | SIDLE_FORCE) &&
+			    !(oh->class->sysc->idlemodes &
+			      (SIDLE_SMART || SIDLE_SMART_WKUP)))
+				idlemode =3D HWMOD_IDLEMODE_FORCE;
+			else
+				idlemode =3D HWMOD_IDLEMODE_NO;
+		} else {
+			idlemode =3D HWMOD_IDLEMODE_SMART;
+		}
 		_set_slave_idlemode(oh, idlemode, &v);
 	}
=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
