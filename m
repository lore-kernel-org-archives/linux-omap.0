From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] OMAPDSS: HDMI: Add M2 divider while calculating
 clkout
Date: Wed, 15 Feb 2012 09:41:00 +0200
Message-ID: <1329291660.1892.9.camel@deskari>
References: <1329285034-16121-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-QbKZRuy3tML8U31h4TuE"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:60094 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757625Ab2BOHlF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 02:41:05 -0500
Received: by mail-lpp01m010-f52.google.com with SMTP id y4so944155lag.11
        for <linux-omap@vger.kernel.org>; Tue, 14 Feb 2012 23:41:03 -0800 (PST)
In-Reply-To: <1329285034-16121-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org


--=-QbKZRuy3tML8U31h4TuE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-02-15 at 11:20 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
>=20
> Add M2 divider in the equation to calculate regm and regmf.
> Formula for calculating:
> Output clock on digital core domain:
> 	CLKOUT =3D (M / (N+1))*CLKINP*(1/M2)
> Internal oscillator output clock on internal LDO domain:
> 	CLKDCOLDO =3D (M / (N+1))*CLKINP
> The current code when allows variable M2 values as input
> ignores using M2 divider values in calculation of regm and regmf.
> so fix it by using M2 in calculation although the default value for
> M2 is 1.
>=20
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/hdmi.c |   16 ++++++++--------
>  1 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdm=
i.c
> index 92a6679..9185630 100644
> --- a/drivers/video/omap2/dss/hdmi.c
> +++ b/drivers/video/omap2/dss/hdmi.c
> @@ -256,24 +256,24 @@ static void hdmi_compute_pll(struct omap_dss_device=
 *dssdev, int phy,
> =20
>  	refclk =3D clkin / pi->regn;
> =20
> -	/*
> -	 * multiplier is pixel_clk/ref_clk
> -	 * Multiplying by 100 to avoid fractional part removal
> -	 */
> -	pi->regm =3D (phy * 100 / (refclk)) / 100;
> -
>  	if (dssdev->clocks.hdmi.regm2 =3D=3D 0)
>  		pi->regm2 =3D HDMI_DEFAULT_REGM2;
>  	else
>  		pi->regm2 =3D dssdev->clocks.hdmi.regm2;
> =20
>  	/*
> +	 * multiplier is pixel_clk/ref_clk
> +	 * Multiplying by 100 to avoid fractional part removal
> +	 */
> +	pi->regm =3D (phy * 100 * pi->regm2 / (refclk)) / 100;

No need for parenthesis around refclk.

> +
> +	/*
>  	 * fractional multiplier is remainder of the difference between
>  	 * multiplier and actual phy(required pixel clock thus should be
>  	 * multiplied by 2^18(262144) divided by the reference clock
>  	 */
> -	mf =3D (phy - pi->regm * refclk) * 262144;
> -	pi->regmf =3D mf / (refclk);
> +	mf =3D (phy - pi->regm / pi->regm2 * refclk) * 262144;

What kind of values does regm have? If the regm2 is something else than
1, and regm is relatively small value, it's quite easy to lose precision
there. Would it be better to have:

pi->regm * refclk / pi->regm2

 Tomi
=20

--=-QbKZRuy3tML8U31h4TuE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPO2GIAAoJEPo9qoy8lh71IgsQAIipaHDkwN6NIqOrMVzO1vPA
BFp6ag5pDxV3XdHp4PL+mGV46LdJqbnr7qtRTLKwAxyJTtLrkBGz4Gr3Vu6lhakU
vK+k2B6HND79rc3disVVxLejpmwU4DJ68M6Vz+K3tzWuJY5Uos3OZxrdspR1bWc1
a8E4vB3fabvKoAIQI25mdvvlzvczs1jl/M39UKu6RU/kwYTSiWyXnHxsDV9SlyqI
ze7hu7k3Y/rgppwFcEH3frqCyMiP3eS8ZNg65LnKQ3UZyuaQS85F+zN7xKC6uSuo
9JiWNf4wsBoWlv1kRU+pJUFYy4LwT1NzVdj3tWxfuX0eFmua6YZAzNx5T5T6f6qe
Fmg2FOJ3Vny2E07rlYnuHYKgqHwRfm/1TThOEE43YUzJ7jSOVaRoRV9m4Q1d4tUX
gf7B+6HjiFs5tIF8NS+WYstdwHRhbQl+m7LkZKuPKivJ1UsHNCRZx4EHFk0AQKo/
uDvTZ/92kmgSb0BBErV1PfRsTKHHXc2u/prrklmXrIG0SNyNbQtuKvQFdob0gxhz
YjdgRNL90xLRVIgMEgjHqKMK80P2ifNrkcYTcj62HPGTyfBFsX3e9QlM25Kbs6km
VP8JJNLxRvXtffGcfCB8TR7mXIVNAgNRm+WI7lNi05gMomlIzAsWzQvf76iAQnpL
7N0A7hqNQZZz77IlPynq
=TSqC
-----END PGP SIGNATURE-----

--=-QbKZRuy3tML8U31h4TuE--

