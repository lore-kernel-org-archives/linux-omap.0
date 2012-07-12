From: Paul Walmsley <paul@pwsan.com>
Subject: Re: PM/RTC 3.5-rc5: System suspends fails when not built with RTC?
Date: Thu, 12 Jul 2012 13:35:14 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207121334150.25585@utopia.booyaka.com>
References: <WC20120712081507.600002@terrafix.co.uk> <alpine.DEB.2.00.1207120456100.25585@utopia.booyaka.com> <WC20120712144308.86003F@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-925570018-1342121714=:25585"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41840 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755751Ab2GLTfP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Jul 2012 15:35:15 -0400
In-Reply-To: <WC20120712144308.86003F@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Kevin Hilman <khilman@ti.com>, "linux-omap\\\\@vger.kernel.org" <linux-omap@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-925570018-1342121714=:25585
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello Joe,

On Thu, 12 Jul 2012, Joe Woodward wrote:

> I think this has fixed the following warning:
> [    0.000000] clockdomain: mpu_clkdm: powerdomain =AC=F5`=C08=BAs=C0 doe=
s not exist
> =20
> But when I try and suspend I still get the same problems:
> # echo mem > /sys/power/state
> [   13.283935] PM: Syncing filesystems ... done.
> [   13.300537] Freezing user space processes ... (elapsed 0.01 seconds) d=
one.
> [   13.324859] Freezing remaining freezable tasks ... (elapsed 0.02 secon=
ds) done.
> [   13.356140] Suspending console(s) (use no_console_suspend to debug)
> [   13.487823] PM: suspend of devices complete after 120.578 msecs
> [   13.491577] PM: late suspend of devices complete after 3.722 msecs
> [   13.497375] PM: noirq suspend of devices complete after 5.767 msecs
> [   13.497436] Disabling non-boot CPUs ...
> [   15.806640] Powerdomain (iva2_pwrdm) didn't enter target state 1
> [   15.806640] Powerdomain (dss_pwrdm) didn't enter target state 1
> [   15.806671] Powerdomain (per_pwrdm) didn't enter target state 1
> [   15.806671] Powerdomain (core_pwrdm) didn't enter target state 1
> [   15.806671] Powerdomain (usbhost_pwrdm) didn't enter target state 1
> [   15.806671] Could not enter target state in pm_suspend
> [   15.809722] PM: noirq resume of devices complete after 2.868 msecs
> [   15.813598] PM: early resume of devices complete after 2.380 msecs
> [   16.179382] mmc1: error -110 during resume (card was removed?)
> [   16.189575] PM: resume of devices complete after 375.824 msecs
> [   16.279602] Restarting tasks ... done.
> sh: write error: Operation not permitted

Thanks for the test.  Perhaps you could try the following untested patch?


- Paul

---
 arch/arm/mach-omap2/pm34xx.c |   14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index e4fc88c..ced2f76 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -545,13 +545,10 @@ static void __init prcm_setup_regs(void)
 =09=09=09  OMAP3430_PER_MOD, OMAP3430_PM_MPUGRPSEL);
=20
 =09/* Don't attach IVA interrupts */
-=09if (omap3_has_iva()) {
-=09=09omap2_prm_write_mod_reg(0, WKUP_MOD, OMAP3430_PM_IVAGRPSEL);
-=09=09omap2_prm_write_mod_reg(0, CORE_MOD, OMAP3430_PM_IVAGRPSEL1);
-=09=09omap2_prm_write_mod_reg(0, CORE_MOD, OMAP3430ES2_PM_IVAGRPSEL3);
-=09=09omap2_prm_write_mod_reg(0, OMAP3430_PER_MOD,
-=09=09=09=09=09OMAP3430_PM_IVAGRPSEL);
-=09}
+=09omap2_prm_write_mod_reg(0, WKUP_MOD, OMAP3430_PM_IVAGRPSEL);
+=09omap2_prm_write_mod_reg(0, CORE_MOD, OMAP3430_PM_IVAGRPSEL1);
+=09omap2_prm_write_mod_reg(0, CORE_MOD, OMAP3430ES2_PM_IVAGRPSEL3);
+=09omap2_prm_write_mod_reg(0, OMAP3430_PER_MOD, OMAP3430_PM_IVAGRPSEL);
=20
 =09/* Clear any pending 'reset' flags */
 =09omap2_prm_write_mod_reg(0xffffffff, MPU_MOD, OMAP2_RM_RSTST);
@@ -565,8 +562,7 @@ static void __init prcm_setup_regs(void)
 =09/* Clear any pending PRCM interrupts */
 =09omap2_prm_write_mod_reg(0, OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
=20
-=09if (omap3_has_iva())
-=09=09omap3_iva_idle();
+=09omap3_iva_idle();
=20
 =09omap3_d2d_idle();
 }
--=20
1.7.10

--155748971-925570018-1342121714=:25585--
