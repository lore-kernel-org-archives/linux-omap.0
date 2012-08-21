From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 4/5] ARM: OMAP4: Add L2 Cache Controller in Device Tree
Date: Tue, 21 Aug 2012 13:24:57 +0300
Message-ID: <20120821102455.GM10347@arwen.pp.htv.fi>
References: <1344855623-14879-1-git-send-email-santosh.shilimkar@ti.com>
 <1344855623-14879-5-git-send-email-santosh.shilimkar@ti.com>
 <503240EF.4050805@ti.com>
 <CAMQu2gxgSasF4mmEFiZq-gsZfQwYn07DKyVGBVPWqjYkTSTu6g@mail.gmail.com>
 <CAMQu2gyL4-j9QSKMpNi5QQFsLqex8Q=bW9uNQtsewXVyrTumOQ@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aiCxlS1GuupXjEh3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:45040 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756255Ab2HUK2z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 06:28:55 -0400
Received: by lahc1 with SMTP id c1so3994458lah.12
        for <linux-omap@vger.kernel.org>; Tue, 21 Aug 2012 03:28:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMQu2gyL4-j9QSKMpNi5QQFsLqex8Q=bW9uNQtsewXVyrTumOQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.or, tony@atomide.com


--aiCxlS1GuupXjEh3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2012 at 03:11:51PM +0530, Shilimkar, Santosh wrote:
> On Mon, Aug 20, 2012 at 9:21 PM, Shilimkar, Santosh
> <santosh.shilimkar@ti.com> wrote:
> > On Mon, Aug 20, 2012 at 7:21 PM, Benoit Cousson <b-cousson@ti.com> wrot=
e:
> >> Hi Santosh,
> >>
> >> On 08/13/2012 01:00 PM, Santosh Shilimkar wrote:
> >>> This provides PL310 Level 2 Cache Controller Device Tree
> >>> support for OMAP4 based devices.
> >>>
> >>> Cc: Benoit Cousson <b-cousson@ti.com>
> >>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >>> ---
> >>>  arch/arm/boot/dts/omap4.dtsi       |    7 +++++++
> >>>  arch/arm/mach-omap2/omap4-common.c |    6 +++++-
> >>>  2 files changed, 12 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.d=
tsi
> >>> index 6717c71..cf1efb6 100644
> >>> --- a/arch/arm/boot/dts/omap4.dtsi
> >>> +++ b/arch/arm/boot/dts/omap4.dtsi
> >>> @@ -36,6 +36,13 @@
> >>>               };
> >>>       };
> >>>
> >>
> >>> +     L2: l2-cache-controller {
> >>
> >> The reg offset is missing: l2-cache-controller@48242000
> >>
> >>> +             compatible =3D "arm,pl310-cache";
> >>> +             reg =3D <0x48242000 0x1000>;
> >>> +             cache-unified;
> >>> +             cache-level =3D <2>;
> >>> +     };
> >>> +
> >>
> >> In theory, the L2 cache should be referenced from the CPUs.
> >>
> > Agree.
> >
> I have added the reference for the L2 controller in CPUs.
> Other information like L1 cache size etc can be added in cpu
> DT node with another patch.
>=20
> Updated patch below. Have also updated git branch
> accordingly.
>=20
> Regards
> Santosh
>=20
> From 91d6cb4f999061c8cfc844a3916ee3384f2e488a Mon Sep 17 00:00:00 2001
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Date: Wed, 4 Jul 2012 17:57:34 +0530
> Subject: [PATCH 1/2 v2] ARM: OMAP4: Add L2 Cache Controller in Device Tree
>=20
> This provides PL310 Level 2 Cache Controller Device Tree
> support for OMAP4 based devices.
>=20
> Cc: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

nice work :-)

FWIW this looks good to me:

Acked-by: Felipe Balbi <balbi@ti.com>

just one thing, will a similar patch for omap3 be sent ?

cheers

> ---
>  arch/arm/boot/dts/omap4.dtsi       |    9 +++++++++
>  arch/arm/mach-omap2/omap4-common.c |    6 +++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 6717c71..0229dd2 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -30,12 +30,21 @@
>  	cpus {
>  		cpu@0 {
>  			compatible =3D "arm,cortex-a9";
> +			next-level-cache =3D <&L2>;
>  		};
>  		cpu@1 {
>  			compatible =3D "arm,cortex-a9";
> +			next-level-cache =3D <&L2>;
>  		};
>  	};
>=20
> +	L2: l2-cache-controller@48242000 {
> +		compatible =3D "arm,pl310-cache";
> +		reg =3D <0x48242000 0x1000>;
> +		cache-unified;
> +		cache-level =3D <2>;
> +	};
> +
>  	/*
>  	 * The soc node represents the soc top level view. It is uses for IPs
>  	 * that are not memory mapped in the MPU view or for the MPU itself.
> diff --git a/arch/arm/mach-omap2/omap4-common.c
> b/arch/arm/mach-omap2/omap4-common.c
> index c29dee9..6f95992 100644
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -16,6 +16,7 @@
>  #include <linux/io.h>
>  #include <linux/platform_device.h>
>  #include <linux/memblock.h>
> +#include <linux/of.h>
>=20
>  #include <asm/hardware/gic.h>
>  #include <asm/hardware/cache-l2x0.h>
> @@ -171,7 +172,10 @@ static int __init omap_l2_cache_init(void)
>  	/* Enable PL310 L2 Cache controller */
>  	omap_smc1(0x102, 0x1);
>=20
> -	l2x0_init(l2cache_base, aux_ctrl, L2X0_AUX_CTRL_MASK);
> +	if (of_have_populated_dt())
> +		l2x0_of_init(aux_ctrl, L2X0_AUX_CTRL_MASK);
> +	else
> +		l2x0_init(l2cache_base, aux_ctrl, L2X0_AUX_CTRL_MASK);
>=20
>  	/*
>  	 * Override default outer_cache.disable with a OMAP4
> --=20
> 1.7.9.5
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--aiCxlS1GuupXjEh3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQM2H3AAoJEIaOsuA1yqREK2EP/3XnMbzVNsYB69ik5kTfTadH
N04yr6fisOEsjUqE3HIPZWDAkrZ1HP8ikdlqO0JNvfeL4JGS7JGTTvxreEqD28f+
5qitxQ9Kynw8hNrPvj3/Js685w8R5inwsFYRhzDDDI0w0HDw66cebmhIPnTvSW8e
ZEimdNsWo4XinBFDSv/RiwAxgUs/8LnqFZJ1xXLwEb1FUZXLkSoto5BV+ESptCAT
VqWpuxyQT4AiI7hk34Iy/ZQ+AKez3FuY1636iahprXKjDu66dvD+1ByNCBypRPFp
hvdbKmsKWRDDWEM+h/2NyHwsPYShraB858R4j3KiJUVGJnLaYbv7iU7HOevZ5JYC
18cvFXK1CW47tXpty7N/taLel5L/AWII7OwztKYK7ftl4taf3Dy/iOlaNdugn0p8
EZnn2v8IhHMtswDOHXfEemKcACxLlcM5GU5TrB9uqOUmb39MpET9cU88SMEU4FRt
rTL9uoqF21iBbUWcgbiP1mua//60zRz2L4AQQ+fVo748fvmBucAWxUGW4iO7pQph
may1dup8R/M7vycexPzFBBfBi/majRn4C1Z+WWetoVS9RB6VJo0rUUixMwFHkmsI
ncvaTfc5yjj23MAj2w2V6kPonqe3zoy76GQ38mBG2zvE8d+3n4mcAhp61R05AnZF
emARB+riIBOn4eqOfgml
=jXzQ
-----END PGP SIGNATURE-----

--aiCxlS1GuupXjEh3--
