From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH V4 3/3] rtc: omap: Support regulator supply for RTC
Date: Tue, 28 Oct 2014 10:01:48 -0500
Message-ID: <20141028150148.GE8123@saruman>
References: <1414490332-14856-1-git-send-email-lokeshvutla@ti.com>
 <1414490332-14856-4-git-send-email-lokeshvutla@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ytoMbUMiTKPMT3hY"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43759 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751660AbaJ1PCj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Oct 2014 11:02:39 -0400
Content-Disposition: inline
In-Reply-To: <1414490332-14856-4-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>, broonie@kernel.org
Cc: rtc-linux@googlegroups.com, linux-omap@vger.kernel.org, johan@kernel.org, tony@atomide.com, balbi@ti.com, akpm@linux-foundation.org, nsekhar@ti.com, t-kristo@ti.com, j-keerthy@ti.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, nm@ti.com

--ytoMbUMiTKPMT3hY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2014 at 03:28:52PM +0530, Lokesh Vutla wrote:
> Certain SoCs such as DRA7, RTC is an independent voltage domain of it's o=
wn
> and on platforms such as DRA7-evm, this may be supplied by individual
> regulator on it's own.
> So make the OMAP RTC driver support a power regulator.
>=20
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
> - Dropped the Reviewed-by tags as this patch is changed from previous ver=
sion.
>  Documentation/devicetree/bindings/rtc/rtc-omap.txt |  6 ++++
>  drivers/rtc/rtc-omap.c                             | 41 ++++++++++++++++=
+++++-
>  2 files changed, 46 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-omap.txt b/Documen=
tation/devicetree/bindings/rtc/rtc-omap.txt
> index 750efd4..c1d84ac 100644
> --- a/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> +++ b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> @@ -15,6 +15,9 @@ Required properties:
>  Optional properties:
>  - ti,system-power-controller: whether the rtc is controlling the system =
power
>    through pmic_power_en
> +- vrtc-supply: phandle to the regulator device tree node.
> +- vrtc-minuV: Minimum required voltage in uV, If default voltage needs t=
o be changed
> +- vrtc-maxuV: Maximum acceptable voltage in uV, If default voltage needs=
 to be changed

huh ? minuV and maxuV is already part of the regulator binding itself.

> @@ -514,6 +516,37 @@ static int omap_rtc_probe(struct platform_device *pd=
ev)
>  	if (IS_ERR(rtc->base))
>  		return PTR_ERR(rtc->base);
> =20
> +	rtc->supply =3D devm_regulator_get_optional(&pdev->dev, "vrtc");

I'm not sure if this is optional either, it's just that many of our
current DTS don't really pass a regulator to RTC, right ?

> +	if (IS_ERR(rtc->supply)) {
> +		if (PTR_ERR(rtc->supply) =3D=3D -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +
> +		rtc->supply =3D NULL;
> +	}
> +
> +	if (rtc->supply) {
> +		of_property_read_u32(pdev->dev.of_node, "vrtc-minuV",
> +				     &vrtc_minuV);
> +		of_property_read_u32(pdev->dev.of_node, "vrtc-maxuV",
> +				     &vrtc_maxuV);
> +		if (vrtc_minuV && vrtc_maxuV) {
> +			ret =3D regulator_set_voltage(rtc->supply,
> +						    vrtc_minuV, vrtc_maxuV);
> +			if (ret) {
> +				dev_err(&pdev->dev, "failed to set volt %d\n",
> +					ret);
> +				return ret;
> +			}
> +		}

I'd really like to Mark's comments here but I was under the impression
that if the binding already gives min_microvolt =3D=3D max_microvolt then
driver shouldn't really care about a set_voltage. Mark ?

> +
> +		ret =3D regulator_enable(rtc->supply);
> +		if (ret) {
> +			dev_err(&pdev->dev, "regulator enable failed %d\n",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
>  	platform_set_drvdata(pdev, rtc);
> =20
>  	/* Enable the clock/module so that we can access the registers */
> @@ -624,6 +657,9 @@ err:
>  	pm_runtime_put_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> =20
> +	if (rtc->supply)
> +		regulator_disable(rtc->supply);
> +
>  	return ret;
>  }
> =20
> @@ -649,6 +685,9 @@ static int __exit omap_rtc_remove(struct platform_dev=
ice *pdev)
>  	pm_runtime_put_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> =20
> +	if (rtc->supply)
> +		regulator_disable(rtc->supply);
> +
>  	return 0;
>  }
> =20
> --=20
> 1.9.1
>=20

--=20
balbi

--ytoMbUMiTKPMT3hY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUT6/cAAoJEIaOsuA1yqREUNIP/2Q9ycWiI2mgHdSEGBkJ8S1L
m3hxUv1L/qxQm9xEBGY6Mfkf7Dx+wjVNB8tPi2jt1ScLai8HBVfz1MlTpMRep9JI
jPJCeDxjS0UlgqEdJbaaLRi7wH6CEbyEoP/h2Ajv7VBG/IJvMTyhe2tMxS3P2P5Z
subwWPasJX9tDUe4UryqoFY9O/7pL8xMhJvRZU+eshoCEa5uyt1gn182kSp4j+uh
04XihYfLPCRIhEZkra+go0LKZemuRKuZg5uLru5j15g1h1tt0UYZ/AVtt79ozFib
68UMyvrDKp1/4I4+tckwxcFxC0j85+I+YgwgrtNVaSUs+5BLCrLP7i+ha4h+iS24
LRKrk16pttps8DKJ0uQrsSnea7hs8ONM0Vsinhli2ucvZjOAYZIfUd7WWEBZFSW5
ALXY3MybYVa/HbxUXHPx8eJCdgQFN6KiCgO9CnlHoDLLCJ8cY2iN404KEK6i473s
MJp+XBJwKvbgAojeZL30OnURk3BP92TBSVZN2ckBIoHlzTQDEhvayG3zLn/8MQSS
+/iseZvb/rm2hJWjjqO+llnbMoxQ+x7Sj3lNoGMXo0UeGpOvGaR+QZ9NP7ySmVtW
BWPl0P7LuDvt69NPg/doMGd3zX4eMFOheNpgrgzzN5EgqC5o4ytidadvisxzE0sv
A5W2TEEDgUJg8y9igYQW
=4V3C
-----END PGP SIGNATURE-----

--ytoMbUMiTKPMT3hY--
