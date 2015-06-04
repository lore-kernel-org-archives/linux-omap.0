From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/NOT FOR MERGING] HACK: add global/private timers for A9
Date: Wed, 3 Jun 2015 22:45:56 -0500
Message-ID: <20150604034550.GA25075@saruman.tx.rr.com>
References: <1433363565-17725-1-git-send-email-balbi@ti.com>
 <20150603222619.GY30984@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34599 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751340AbbFDDsp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Jun 2015 23:48:45 -0400
Content-Disposition: inline
In-Reply-To: <20150603222619.GY30984@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Russell King <linux@arm.linux.org.uk>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 03, 2015 at 03:26:20PM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [150603 13:36]:
> > --- a/arch/arm/mach-omap2/timer.c
> > +++ b/arch/arm/mach-omap2/timer.c
> > @@ -655,20 +655,18 @@ static OMAP_SYS_32K_TIMER_INIT(4, 1, "timer_32k_c=
k", "ti,timer-alwon",
> >  static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, OMAP44XX_LOCAL_TWD_BASE=
, 29);
> >  void __init omap4_local_timer_init(void)
> >  {
> > +	int err;
> > +
> >  	omap4_sync32k_timer_init();
> >  	/* Local timers are not supprted on OMAP4430 ES1.0 */
> > -	if (omap_rev() !=3D OMAP4430_REV_ES1_0) {
> > -		int err;
> > -
> > -		if (of_have_populated_dt()) {
> > -			clocksource_of_init();
> > -			return;
> > -		}
> > -
> > -		err =3D twd_local_timer_register(&twd_local_timer);
> > -		if (err)
> > -			pr_err("twd_local_timer_register failed %d\n", err);
> > +	if (of_have_populated_dt()) {
> > +		clocksource_of_init();
> > +		return;
> >  	}
> > +
> > +	err =3D twd_local_timer_register(&twd_local_timer);
> > +	if (err)
> > +		pr_err("twd_local_timer_register failed %d\n", err);
> >  }
> >  #else
> >  void __init omap4_local_timer_init(void)
>=20
> Looks like can get rid of even more code here, see the patch below.
>=20
> Regards,
>=20
> Tony
>=20
> 8< ------------------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Wed, 3 Jun 2015 14:40:40 -0700
> Subject: [PATCH] ARM: OMAP2+: Clean up omap4_local_timer_init
>=20
> Inspired by a patch from Felipe Balbi <balbi@ti.com>, we can
> now get rid of most the code in omap4_local_timer_init.
>=20
> Omap4 is now device tree only.. And we have not properly supported
> omap4 ES1.0 revision for a really long time AFAIK.
>=20
> Let's just remove all that code to simplify things. This assumes
> we have arm,cortex-a9-twd-timer entry in the omap4.dtsi file, which
> we do.
>=20
> Signed-off-by: Tony Lindgren <tony@atomide.com>

very true

Reviewed-by: Felipe Balbi <balbi@ti.com>

> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -649,23 +649,10 @@ static OMAP_SYS_32K_TIMER_INIT(4, 1, "timer_32k_ck"=
, "ti,timer-alwon",
> =20
>  #ifdef CONFIG_ARCH_OMAP4
>  #ifdef CONFIG_HAVE_ARM_TWD
> -static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, OMAP44XX_LOCAL_TWD_BASE, =
29);
>  void __init omap4_local_timer_init(void)
>  {
>  	omap4_sync32k_timer_init();
> -	/* Local timers are not supprted on OMAP4430 ES1.0 */
> -	if (omap_rev() !=3D OMAP4430_REV_ES1_0) {
> -		int err;
> -
> -		if (of_have_populated_dt()) {
> -			clocksource_of_init();
> -			return;
> -		}
> -
> -		err =3D twd_local_timer_register(&twd_local_timer);
> -		if (err)
> -			pr_err("twd_local_timer_register failed %d\n", err);
> -	}
> +	clocksource_of_init();
>  }
>  #else
>  void __init omap4_local_timer_init(void)

--=20
balbi

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVb8nzAAoJEIaOsuA1yqREALcP/Ros5ejikXMY0PNGpLuWNzxu
pDUu0E/dQ3OfHsLd6O+yELVrrqRIKLoKsoHwAVQNlvTEByZhr0Gcn1e924+5nmWV
Eu/w7xKqacPz6OsnEwME0M5g/gs79WNfKMl3J6XsUBMpogtcSrEIMmKm56nAIfKY
mBcwBDqj/FlyssCcxzbFRvGGzTHxi8E6bfN5jYqKuRRCX1zNGLaiIfCmZ6FwwCzd
Bkr6OSSyCZW+wuFKAAPMmGLX04llttNzcFzcMLCw1sGrutEaO0XVbLnXhAbTzIxu
7jrHqGyObBV6ZThnaD4oz702MgRWH7Kxb/V/Q/3R3/TADJCu6dzetZxPFBRfZA5v
FjRPUniu54Qd+ZafmIQ4BoeWx0O+Mzie9Le/Gufk5gY3AvZC/GFvr7GKEBU1Kn5I
cmzrrK7JmNfCMjq8B6wckDuoxASHCra46SV5L48feBytCic/xPj1NBuJO5PP2Aj3
XOje3wIAvu1slilPjG3G1QS3KPup/2t9tE7Br/yMEI9Y4FTlsWdzIEz4WIvv+SvT
bx3tKgM0jmhllmEO54BSeEoC0pL975sCl5gnyEM2tffW2C6LpU7HnWJKfgQqCArj
9pb+eggCigGmT0OcAx3+h1coYjQ/DgTMu4fS+JoHiQfhdCP8br0UEPK44tlZD7yg
guPU4SikBPPMQ+G5WqH8
=3hs9
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
