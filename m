From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v7 7/9] clocksource: timer-dm: Hook device platform data
 if not already assigned
Date: Tue, 9 Jan 2018 10:19:46 +0100
Message-ID: <20180109091946.xxribrhf2ayt3gny@earth.universe>
References: <1515478987-5786-1-git-send-email-j-keerthy@ti.com>
 <1515478987-5786-8-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w6ozopqxpdaejaqk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1515478987-5786-8-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: daniel.lezcano@linaro.org, thierry.reding@gmail.com, tony@atomide.com, aaro.koskinen@iki.fi, Claudiu.Beznea@microchip.com, narmstrong@baylibre.com, linux-pwm@vger.kernel.org, ladis@linux-mips.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, robh+dt@kernel.org, t-kristo@ti.com, grygorii.strashko@ti.com
List-Id: linux-omap@vger.kernel.org


--w6ozopqxpdaejaqk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 09, 2018 at 11:53:05AM +0530, Keerthy wrote:
> From: Ladislav Michl <ladis@linux-mips.org>
>=20
> In the case of device tree boot the device platform data is usually
> NULL so hook the platform data obtained from the match.
> As part of un-constify the platform_data pointer.
>=20
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> Signed-off-by: Keerthy <j-keerthy@ti.com>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

> ---
>  drivers/clocksource/timer-dm.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/clocksource/timer-dm.c b/drivers/clocksource/timer-d=
m.c
> index 1cbd954..60db173 100644
> --- a/drivers/clocksource/timer-dm.c
> +++ b/drivers/clocksource/timer-dm.c
> @@ -806,14 +806,16 @@ static int omap_dm_timer_probe(struct platform_devi=
ce *pdev)
>  	struct omap_dm_timer *timer;
>  	struct resource *mem, *irq;
>  	struct device *dev =3D &pdev->dev;
> -	const struct of_device_id *match;
>  	const struct dmtimer_platform_data *pdata;
>  	int ret;
> =20
> -	match =3D of_match_device(of_match_ptr(omap_timer_match), dev);
> -	pdata =3D match ? match->data : dev->platform_data;
> +	pdata =3D of_device_get_match_data(dev);
> +	if (!pdata)
> +		pdata =3D dev_get_platdata(dev);
> +	else
> +		dev->platform_data =3D (void *)pdata;
> =20
> -	if (!pdata && !dev->of_node) {
> +	if (!pdata) {
>  		dev_err(dev, "%s: no platform data.\n", __func__);
>  		return -ENODEV;
>  	}
> --=20
> 1.9.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--w6ozopqxpdaejaqk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlpUiTIACgkQ2O7X88g7
+pq/jBAAoq4AGDg38Mi1LutJO/yKzWGNl88yHA4jUM7mPYawg76vVSEIsiCLo3Iw
8uKmcEGVxsZ4Wtez+dHM8wr3WbLpN0Z7iLcSKtE9MKUyFFKL6qrk2gxUzp/2bJZS
nndLfYWxCet5c+daMGz4D1KSY5Wo9O/hB+48COopv7JigAcI174iy6QjLBz3QhQy
dKpha2oUlhKtVgg4IwsQe9OXK1HnMVfU/XFnMr+PqjFYe/OXAGU0g7hZyfPfbzdY
jmrDvNsR5zuwVmYybVQ3mXJNaodetz+ZPPRylphoE+BWRijQXMGYpl2rmgRm3jA+
EbQVMUYG2tmAdSC3G2wDJ34K5sf7Gb/PcbfwLOncoqAwWFyYEtJnQItVBYtw2gWP
pECQ7pfZ2EaQU6ZDao8RcWWOJpKJFpyYB+hvMWbXZCBK7vIV0LS4s/9wi0lIyOmF
MHFcO0zOGJpHS9B10V3kp56fFkaSvKVqS8hn+624LgbzacRe4BOviBlI6VhouMZ3
Bddwhw0cAw/wdpTO2wUE5kYrh5CHiR6VrnF7f2OY0lOrLrBzfiHBWZEeCOf5ML2t
fQp32m0MZScAFsxgnG/2P+Jb6sdt27il8+8wr6d58KwH4Fp5kLAyFETnzK0GOdcx
9BO87ehn5myiG9vdoRq1hDWOJpgmUGotikU0dzhNdmaZoN14si0=
=zhlt
-----END PGP SIGNATURE-----

--w6ozopqxpdaejaqk--
