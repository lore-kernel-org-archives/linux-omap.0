From: Felipe Balbi <balbi@ti.com>
Subject: Re: randconfig build error
Date: Mon, 24 Feb 2014 09:37:35 -0600
Message-ID: <20140224153735.GB31636@saruman.home>
References: <20140221155452.GH31902@saruman.home>
 <20140222141525.GT27282@n2100.arm.linux.org.uk>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37944 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042AbaBXPj1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Feb 2014 10:39:27 -0500
Content-Disposition: inline
In-Reply-To: <20140222141525.GT27282@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Felipe Balbi <balbi@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2014 at 02:15:25PM +0000, Russell King - ARM Linux wrote:
> On Fri, Feb 21, 2014 at 09:55:13AM -0600, Felipe Balbi wrote:
> > Here's the error I found:
> >=20
> > warning: (ARCH_HI3xxx && SOC_OMAP5 && ARCH_SHMOBILE_MULTI) selects HAVE=
_ARM_TWD which has unmet direct dependencies (SMP)
> > warning: (ARCH_HI3xxx && SOC_OMAP5 && ARCH_SHMOBILE_MULTI) selects HAVE=
_ARM_TWD which has unmet direct dependencies (SMP)
> > arch/arm/mach-prima2/common.c:23:20: warning: =E2=80=98sirfsoc_map_io=
=E2=80=99 defined but not used [-Wunused-function]
> >  static __init void sirfsoc_map_io(void)
> >                     ^
> > arch/arm/kernel/smp_twd.c: In function =E2=80=98twd_local_timer_of_regi=
ster=E2=80=99:
> > arch/arm/kernel/smp_twd.c:391:20: error: =E2=80=98setup_max_cpus=E2=80=
=99 undeclared (first use in this function)
> >   if (!is_smp() || !setup_max_cpus)
> >                     ^
> > arch/arm/kernel/smp_twd.c:391:20: note: each undeclared identifier is r=
eported only once for each function it appears in
> > make[1]: *** [arch/arm/kernel/smp_twd.o] Error 1
> > make[1]: *** Waiting for unfinished jobs....
> > make: *** [arch/arm/kernel] Error 2
> > make: *** Waiting for unfinished jobs....
> >=20
> > The funny part of that is that SOC_OMAP5, ARCH_SHMOBILE_MULTI, and
> > ARCH_HI3xxx have:
> >=20
> > 	select HAVE_ARM_TWD if SMP
> >=20
> > so how come we still select it if CONFIG_SMP=3Dn on that particular
> > randconfig ?
>=20
> Are you entirely certian which kernel version you're building?  v3.14-rc1
> to my tip has this:
>=20
> diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
> index 8f4649b301b2..1abae5f6a418 100644
> --- a/arch/arm/mach-hisi/Kconfig
> +++ b/arch/arm/mach-hisi/Kconfig
> @@ -8,7 +8,7 @@ config ARCH_HI3xxx
>         select CLKSRC_OF
>         select GENERIC_CLOCKEVENTS
>         select HAVE_ARM_SCU
> -       select HAVE_ARM_TWD
> +       select HAVE_ARM_TWD if SMP
>         select HAVE_SMP
>         select PINCTRL
>         select PINCTRL_SINGLE
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 653b489479e0..e2ce4f8366a7 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -54,7 +54,7 @@ config SOC_OMAP5
>         select ARM_GIC
>         select CPU_V7
>         select HAVE_ARM_SCU if SMP
> -       select HAVE_ARM_TWD if LOCAL_TIMERS
> +       select HAVE_ARM_TWD if SMP
>         select HAVE_SMP
>         select HAVE_ARM_ARCH_TIMER
>         select ARM_ERRATA_798181 if SMP
> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kcon=
fig
> index 338640631e08..05fa505df585 100644
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -8,7 +8,7 @@ config ARCH_SHMOBILE_MULTI
>         select CPU_V7
>         select GENERIC_CLOCKEVENTS
>         select HAVE_ARM_SCU if SMP
> -       select HAVE_ARM_TWD if LOCAL_TIMERS
> +       select HAVE_ARM_TWD if SMP
>         select HAVE_SMP
>         select ARM_GIC
>         select MIGHT_HAVE_CACHE_L2X0
>=20
> The relevant bits are the "-" lines, which indicate that with v3.14-rc1,
> ARCH_HI3xxx would select HAVE_ARM_TWD without SMP set, and indeed, your
> config you attached has ARCH_HI3xxx set.

yeah, just checked that it builds just fine on -rc3. Thanks

--=20
balbi

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTC2c/AAoJEIaOsuA1yqREaooP/3769t8Yrl1iqOWcydX7gH2T
nxhVEVwT+EVxromdUtS3KsKs+px8SYwwvDtrPl3UOs+xWP8rmk1IEHfHXW5x8G8c
wLcUEGe+mFJsu2wUYI9qzAgf67xmeu77nTFGMFhSIxz6uP/GCAH50TEf0l1EzTEy
nOnXb65DNCNm0eAggosVwofTSeW6EQgk9MkYVoI1r9EgnGYytvcCSMm9GaAGse7+
wzC2C/LY4mBt5K2Pohv+0lqA6MBXcm5MlVpn8FeMl3oSzmjmcgzlUlr19biGuUO3
ULBkLM8IXezr9BFu59m0So2MtirS0porhp7rlRcmh0DC8olEZHBVkaHGhjN5ozrz
VbC/x7o4WSRvv9F/J8AmUeT3eISY7jP8/hENWPeSW5xYRa3vaSZfxopV83AqmY7S
ncYc01eDx+FogL1XwiAYyVZJayWQa2cBCepeB73lb+zcJ3XeWQtq+wwVGR3BlHxD
SI3g0oXuQvdQ0kjqnLZSAT4NetQg/K5H5jU1fl7MdpkWOFRA6hHEq9QMcRIVwh35
J6vDetHK6AH2tMUjWJOtvkQbQJUx+t4ODBUssOmBuER4H9b5PIHVAI0+pK0TyHRm
VKSXkQyHx1+J1p11898XDAXbfCqwOkip0I+Qj0EmpJIvjDEkaFx6KgGDSL0dg0fz
u8CbljulgfxIzNXFYVqB
=Wk+I
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
