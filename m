From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: Remove duplicate omap4430_init_late()
 declaration
Date: Fri, 8 Feb 2013 17:21:01 +0200
Message-ID: <20130208152101.GI23979@arwen.pp.htv.fi>
References: <1360336306-18277-1-git-send-email-santosh.shilimkar@ti.com>
 <1360336306-18277-2-git-send-email-santosh.shilimkar@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QDIl5R72YNOeCxaP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48335 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946062Ab3BHPVN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Feb 2013 10:21:13 -0500
Content-Disposition: inline
In-Reply-To: <1360336306-18277-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>, Tony Lindgren <tony@atomide.com>

--QDIl5R72YNOeCxaP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 08, 2013 at 08:41:45PM +0530, Santosh Shilimkar wrote:
> Commit bbd707ac {ARM: omap2: use machine specific hook for late init}
> accidentally added two declarations for omap4430_init_late().
>=20
> Remove the duplicate declaration.
>=20
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Tony Lindgren <tony@atomide.com>
>=20
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

nice catch

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/mach-omap2/common.h |    1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> index 948bcaa..e0f9ea7 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -108,7 +108,6 @@ void omap35xx_init_late(void);
>  void omap3630_init_late(void);
>  void am35xx_init_late(void);
>  void ti81xx_init_late(void);
> -void omap4430_init_late(void);
>  int omap2_common_pm_late_init(void);
> =20
>  #if defined(CONFIG_SOC_OMAP2420) || defined(CONFIG_SOC_OMAP2430)
> --=20
> 1.7.9.5
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--QDIl5R72YNOeCxaP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRFRfcAAoJEIaOsuA1yqREC+sP/0Jc1bVB4N+Ms1UzO6mC/7IE
0vAY54yjICSzVEyoCoklf00lSdgV0ORZ5MabImj3K+FtaVVIqd2JyreiRLPY15xH
NOJjcBMLreGnthxno2iLef1n/yRwJ6bYbs6sIs/H84j6qu3a4smQVuHIMewcv4G/
9i9t9jWdwtW2uYcrtU2yCz6ojMco5ou6xsQk0kHWl0vFKZKt5H+lHUV3fopwuSpK
RD08wGHuQYPXjeWmI3bG5cJiRkr7ONLGw7Ki8C4C9E1webO2/PRiKgmptTgBuzZv
V8oijB15xg412MnwXRZs+kR+mPTAFqCiN2B+uPEC+UDI6jFRD8ppyXXVN7wxOIbQ
okO9/9jPmOS4OgINwGUIM6jmHMMKFL5dMBiKFrEq/o1q9K1ER1aoHUqgMuyaMukD
ANxei9z0KGER9XmypXPnGWgWlnSNtqbJTn5UwWwyDPfgzwRujBC3imNP/k/YJoum
35ZGUDRgV0c+RfIQVpSATMmNWRm+K1ewsfBD72dcjtbXDOzPqETqvSau3vdk/rpX
0BqtVlkfi08y8uPrgIC6/03hDOLZV6o6gnCebeCJpvf/twoylo+70OTvlbbRdmF0
xMc4QEqnquKE6lC+JCerL8LyYDdL8QWIPrHSy132usKU5yiL/gO9DUlnWWH/zXjQ
7FUklU2yLWzj8Vecgv5c
=VpVa
-----END PGP SIGNATURE-----

--QDIl5R72YNOeCxaP--
