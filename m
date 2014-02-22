From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: randconfig build error
Date: Sat, 22 Feb 2014 14:15:25 +0000
Message-ID: <20140222141525.GT27282@n2100.arm.linux.org.uk>
References: <20140221155452.GH31902@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:46853 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750937AbaBVOPe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 22 Feb 2014 09:15:34 -0500
Content-Disposition: inline
In-Reply-To: <20140221155452.GH31902@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Fri, Feb 21, 2014 at 09:55:13AM -0600, Felipe Balbi wrote:
> Here's the error I found:
>=20
> warning: (ARCH_HI3xxx && SOC_OMAP5 && ARCH_SHMOBILE_MULTI) selects HA=
VE_ARM_TWD which has unmet direct dependencies (SMP)
> warning: (ARCH_HI3xxx && SOC_OMAP5 && ARCH_SHMOBILE_MULTI) selects HA=
VE_ARM_TWD which has unmet direct dependencies (SMP)
> arch/arm/mach-prima2/common.c:23:20: warning: =E2=80=98sirfsoc_map_io=
=E2=80=99 defined but not used [-Wunused-function]
>  static __init void sirfsoc_map_io(void)
>                     ^
> arch/arm/kernel/smp_twd.c: In function =E2=80=98twd_local_timer_of_re=
gister=E2=80=99:
> arch/arm/kernel/smp_twd.c:391:20: error: =E2=80=98setup_max_cpus=E2=80=
=99 undeclared (first use in this function)
>   if (!is_smp() || !setup_max_cpus)
>                     ^
> arch/arm/kernel/smp_twd.c:391:20: note: each undeclared identifier is=
 reported only once for each function it appears in
> make[1]: *** [arch/arm/kernel/smp_twd.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [arch/arm/kernel] Error 2
> make: *** Waiting for unfinished jobs....
>=20
> The funny part of that is that SOC_OMAP5, ARCH_SHMOBILE_MULTI, and
> ARCH_HI3xxx have:
>=20
> 	select HAVE_ARM_TWD if SMP
>=20
> so how come we still select it if CONFIG_SMP=3Dn on that particular
> randconfig ?

Are you entirely certian which kernel version you're building?  v3.14-r=
c1
to my tip has this:

diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index 8f4649b301b2..1abae5f6a418 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -8,7 +8,7 @@ config ARCH_HI3xxx
        select CLKSRC_OF
        select GENERIC_CLOCKEVENTS
        select HAVE_ARM_SCU
-       select HAVE_ARM_TWD
+       select HAVE_ARM_TWD if SMP
        select HAVE_SMP
        select PINCTRL
        select PINCTRL_SINGLE
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 653b489479e0..e2ce4f8366a7 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -54,7 +54,7 @@ config SOC_OMAP5
        select ARM_GIC
        select CPU_V7
        select HAVE_ARM_SCU if SMP
-       select HAVE_ARM_TWD if LOCAL_TIMERS
+       select HAVE_ARM_TWD if SMP
        select HAVE_SMP
        select HAVE_ARM_ARCH_TIMER
        select ARM_ERRATA_798181 if SMP
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kc=
onfig
index 338640631e08..05fa505df585 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -8,7 +8,7 @@ config ARCH_SHMOBILE_MULTI
        select CPU_V7
        select GENERIC_CLOCKEVENTS
        select HAVE_ARM_SCU if SMP
-       select HAVE_ARM_TWD if LOCAL_TIMERS
+       select HAVE_ARM_TWD if SMP
        select HAVE_SMP
        select ARM_GIC
        select MIGHT_HAVE_CACHE_L2X0

The relevant bits are the "-" lines, which indicate that with v3.14-rc1=
,
ARCH_HI3xxx would select HAVE_ARM_TWD without SMP set, and indeed, your
config you attached has ARCH_HI3xxx set.

--=20
=46TTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
