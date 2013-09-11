From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Odd behavior with dpll4_m4x2_ck on omap3 + DT
Date: Wed, 11 Sep 2013 10:21:18 +0300
Message-ID: <523019EE.5000508@ti.com>
References: <521DC143.2010506@ti.com> <521DC770.5050000@ti.com> <521DCD80.1060600@ti.com> <521DE1A6.6030005@ti.com> <522F0390.9050802@gmail.com> <522F0CC7.50501@ti.com> <522F0E3E.1080001@ti.com> <522F0F9B.9050705@ti.com> <522F1346.3020206@ti.com> <522F1BF9.5050006@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="pksdv7IwsS5evorEpnPa3Wp4AS25IVe8m"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34701 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751363Ab3IKHV1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Sep 2013 03:21:27 -0400
In-Reply-To: <522F1BF9.5050006@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Stefan Roese <stefan.roese@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>

--pksdv7IwsS5evorEpnPa3Wp4AS25IVe8m
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/09/13 16:17, Tero Kristo wrote:

> In theory, DPLLs can also be used in their bypass mode to feed customer=

> nodes clocks. I just think the check in the clkoutx2_recalc is wrong,
> and should be enhanced to actually check what is the target mode for th=
e
> clock once it is enabled. Maybe something like this would work properly=
:
>=20
> diff --git a/arch/arm/mach-omap2/dpll3xxx.c
> b/arch/arm/mach-omap2/dpll3xxx.c
> index 3a0296c..ba218fb 100644
> --- a/arch/arm/mach-omap2/dpll3xxx.c
> +++ b/arch/arm/mach-omap2/dpll3xxx.c
> @@ -658,14 +658,12 @@ unsigned long omap3_clkoutx2_recalc(struct clk_hw=

> *hw,
>=20
>         dd =3D pclk->dpll_data;
>=20
> -       WARN_ON(!dd->enable_mask);
> -
> -       v =3D __raw_readl(dd->control_reg) & dd->enable_mask;
> -       v >>=3D __ffs(dd->enable_mask);
> -       if ((v !=3D OMAP3XXX_EN_DPLL_LOCKED) || (dd->flags & DPLL_J_TYP=
E))
> +       if ((dd->flags & DPLL_J_TYPE) ||
> +           __clk_get_rate(dd->clk_bypass) =3D=3D __clk_get_rate(pclk))=

>                 rate =3D parent_rate;
>         else
>                 rate =3D parent_rate * 2;
> +
>         return rate;
>  }

Stefan, are you able to test the above?

I'd rather have a proper fix for this, than hack omapdss =3D).

>> How is the DPLL4's clock rate 432000000 anyway in bypass mode. Isn't
>> bypass mode usually plain sys-clock, or such?
>=20
> This again reflects the rate that the clock has once it is enabled, the=

> clkoutx2 does not.

Ok. Then it does sound like the clkoutx2 is calculated wrong, as you say.=


 Tomi



--pksdv7IwsS5evorEpnPa3Wp4AS25IVe8m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIbBAEBAgAGBQJSMBnyAAoJEPo9qoy8lh71aX0P+Ii5NaVeF1uEf5rODMycaAMW
W8TKmSqMkgMvLVms/+7ZeIXNxLoCX27/366ZEdVpvg5T1SlnCQd+NuINGEE2cji3
dhhEd6mJfguBrfR7G7sodWBPxqRK+E8/ioscClTyWw3egsgejVeYU7++YRVVXjus
yG7IrCa9cEZO/UNmdGnx+8R/x+xA3rVmQ1R/4A888NH0FdWjnEtPpChCkL3wWAct
glx/RkvilL9cUv/3adslKMz9BFCj4JK+Jb1lwwDsGkHC4GO4mn1AAulxLQ+mccLd
3fv/O5YjKdnvKzOSdf0AImpF91pv+GwJgeD/vSWcj9FQAfNRL6IVazobVOYtG3dm
+mvgnKlBC4D1lapvmvG5+Jjjt7vaMFjPIXS617ynifies3OlG02GYT3Slen1w59b
jxvSZjsqwmX2ZQZao86/BsaoZu00a4zr0pwVHWZ3XpycysdNCj/VN+eXl4LRUpVR
l48HvXE/l62I5STAMgzCHesHlzYb3or6S+UO9/hUGFbTHIRT30+k+f6EJNcA/n+Y
ox4LYTXPUTfZtPmJy0F7Az0bD5DxbOd2wt5J0Q6nL3dWkStJOqdn642Y9DPKn4pf
Nt5hmy0k7hLLPCZ1WFSin6fYnreMV/NtTWTk3daC8zG/L30VhIjpJRr4skeC5z1T
4GiZi7H0SyS3RtOgMmA=
=knbF
-----END PGP SIGNATURE-----

--pksdv7IwsS5evorEpnPa3Wp4AS25IVe8m--
