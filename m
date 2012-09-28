From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/6] OMAPDSS: add omapdss_version
Date: Fri, 28 Sep 2012 13:44:39 +0300
Message-ID: <1348829079.2437.9.camel@deskari>
References: <1348828527-13309-1-git-send-email-tomi.valkeinen@ti.com>
	 <1348828527-13309-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-qhq1/OkRjbrDzG5nsOlC"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:40542 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753365Ab2I1Koo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Sep 2012 06:44:44 -0400
Received: by lagh6 with SMTP id h6so971015lag.19
        for <linux-omap@vger.kernel.org>; Fri, 28 Sep 2012 03:44:41 -0700 (PDT)
In-Reply-To: <1348828527-13309-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, Archit Taneja <a0393947@ti.com>, Chandrabhanu Mahapatra <cmahapatra@ti.com>, =?ISO-8859-1?Q?Rapha=EBl_Ass=E9nat?= <raph@8d.com>, Tony Lindgren <tony@atomide.com>


--=-qhq1/OkRjbrDzG5nsOlC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-09-28 at 13:35 +0300, Tomi Valkeinen wrote:
> Add new enum, omapdss_version, that is used to tell which DSS hardware
> version the SoC has. This enum is initialized during platform init, and
> passed in the platform data to omapdss driver.
>=20
> Note that the versions are not "continuous", that is, you cannot check
> if the version is less or greater than something, but you need to check
> for exact version match. In other words, this is invalid:
>=20
> /* test if DSS is 3630 or earlier */
> if (ver <=3D OMAPDSS_VER_OMAP3630)
> 	...
>=20
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  arch/arm/mach-omap2/display.c |   38 +++++++++++++++++++++++++++++++++++=
+++
>  include/video/omapdss.h       |   14 ++++++++++++++
>  2 files changed, 52 insertions(+)
>=20
> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.=
c
> index ee40739..33555da 100644
> --- a/arch/arm/mach-omap2/display.c
> +++ b/arch/arm/mach-omap2/display.c
> @@ -284,6 +284,35 @@ err:
>  	return ERR_PTR(r);
>  }
> =20
> +static enum omapdss_version omap_display_get_version(void)
> +{
> +	if (cpu_is_omap24xx())
> +		return OMAPDSS_VER_OMAP24xx;
> +	else if (cpu_is_omap3630())
> +		return OMAPDSS_VER_OMAP3630;
> +	else if (cpu_is_omap34xx()) {
> +		if (soc_is_am35xx()) {
> +			return OMAPDSS_VER_AM35xx;
> +		} else {
> +			if (omap_rev() < OMAP3430_REV_ES3_0)
> +				return OMAPDSS_VER_OMAP34xx_ES1;
> +			else
> +				return OMAPDSS_VER_OMAP34xx_ES3;
> +		}
> +	} else if (omap_rev() =3D=3D OMAP4430_REV_ES1_0)
> +		return OMAPDSS_VER_OMAP4430_ES1;
> +	else if (omap_rev() =3D=3D OMAP4430_REV_ES2_0 ||
> +			omap_rev() =3D=3D OMAP4430_REV_ES2_1 ||
> +			omap_rev() =3D=3D OMAP4430_REV_ES2_2)
> +		return OMAPDSS_VER_OMAP4430_ES2;
> +	else if (cpu_is_omap44xx())
> +		return OMAPDSS_VER_OMAP4;
> +	else if (soc_is_omap54xx())
> +		return OMAPDSS_VER_OMAP5;
> +	else
> +		return OMAPDSS_VER_UNKNOWN

Sigh. I made a late minor change, and of course I broke the compilation
and didn't check it. So there's a ; missing in the above line.

 Tomi


--=-qhq1/OkRjbrDzG5nsOlC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQZX+XAAoJEPo9qoy8lh71t0UQAKliNys+JmIJ13ltSYZsi4Rj
YlSZciarvi5qC6j6eOfjPBz/T8fmjxvGXr1rPPgYXPPEbBctRyo7DrtpycOQGGlD
wX4q+L4uz2OmrMbBmNM1ALYSnzDP+d/WHQUDXPMY79T2rwnFPlqmqawet0SkXI68
Fma3fZdNX4TSccYHCjSnQeOlMuCDdFyQHtZrSFpDQ/Jsx4WKEKhlEEbiQUXdhIEa
v/ds6koEXiNwxc3FeTDmx9LetChqr58qSMKJvl+zhrbDrRE6psuj7RxjPPBt5334
yVH9MRkOKu/KjYZTmwgGLKZDgr+I1SJw/bi6iTSOxS+p8ew0D+hvJBnnSe38IxHf
Uwk6XSoCW7kDBF+ARB9DFpNUVXjoSyw52eORgbiumpjs6hc7DOVuPBWB9qGsuh8I
DAS28GgJROToLzOuZ6CDr+r5zzKEbudo0CMAHMvMG5pML/jclaem6m2e7WVojEkt
j/o8QSCaPPmbXy0O4QhyO6h7Ipe+1rGkcmdeKlQzRO1TKjfMYrdA4teoN9z5Wy8+
dVN0C8iTA8pb36z71Z3ehKWH1uEwVF4q68GdfjW1RNveNkwCOrDFilDOxNVzx7sS
chW6rKIHLpEtTeFfHM6rt6qtWR1UfCXkITWNe3dpXqJE8lg6XmVcosO0e3GJaVji
2ljn8n6HCTzjKRwbWbKy
=bIlc
-----END PGP SIGNATURE-----

--=-qhq1/OkRjbrDzG5nsOlC--

