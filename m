From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH V4 3/3] rtc: omap: Support regulator supply for RTC
Date: Fri, 24 Oct 2014 10:40:42 -0500
Message-ID: <20141024154042.GK26941@saruman>
References: <1414126425-13198-4-git-send-email-lokeshvutla@ti.com>
 <1414138054-16411-1-git-send-email-lokeshvutla@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gmhhrsDozM2n+uz5"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33825 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755416AbaJXPlw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Oct 2014 11:41:52 -0400
Content-Disposition: inline
In-Reply-To: <1414138054-16411-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: rtc-linux@googlegroups.com, linux-omap@vger.kernel.org, a.zummo@towertech.it, johan@kernel.org, tony@atomide.com, bcousson@baylibre.com, balbi@ti.com, akpm@linux-foundation.org, linux@roeck-us.net, nsekhar@ti.com, t-kristo@ti.com, j-keerthy@ti.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

--gmhhrsDozM2n+uz5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2014 at 01:37:34PM +0530, Lokesh Vutla wrote:
> On some Soc's RTC is powered by an external power regulator.
> e.g. RTC on DRA7 SoC. Make the OMAP RTC driver support a
> power regulator.
>=20
> Reviewed-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

oh sorry, there was already a new version:

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
> Changes since v3:
> - Removed extra Optional properties header.
> - Moved regulator get before platform_set_drvdatai() as suggested by Johan
>=20
>  Documentation/devicetree/bindings/rtc/rtc-omap.txt |  2 ++
>  drivers/rtc/rtc-omap.c                             | 24 ++++++++++++++++=
++++++
>  2 files changed, 26 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-omap.txt b/Documen=
tation/devicetree/bindings/rtc/rtc-omap.txt
> index 750efd4..42ff41f 100644
> --- a/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> +++ b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> @@ -15,6 +15,7 @@ Required properties:
>  Optional properties:
>  - ti,system-power-controller: whether the rtc is controlling the system =
power
>    through pmic_power_en
> +- vrtc-supply: phandle to the regulator device tree node if needed
> =20
>  Example:
> =20
> @@ -25,4 +26,5 @@ rtc@1c23000 {
>  		      19>;
>  	interrupt-parent =3D <&intc>;
>  	ti,system-power-controller;
> +	vrtc-supply =3D <&ldo9_reg>;
>  };
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index d9bb5e7..7f1b527 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -25,6 +25,7 @@
>  #include <linux/of_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/io.h>
> +#include <linux/regulator/consumer.h>
> =20
>  /*
>   * The OMAP RTC is a year/month/day/hours/minutes/seconds BCD clock
> @@ -134,6 +135,7 @@ struct omap_rtc {
>  	u8 interrupts_reg;
>  	bool is_pmic_controller;
>  	const struct omap_rtc_device_type *type;
> +	struct regulator *supply;
>  };
> =20
>  static inline u8 rtc_read(struct omap_rtc *rtc, unsigned int reg)
> @@ -514,6 +516,22 @@ static int omap_rtc_probe(struct platform_device *pd=
ev)
>  	if (IS_ERR(rtc->base))
>  		return PTR_ERR(rtc->base);
> =20
> +	rtc->supply =3D devm_regulator_get_optional(&pdev->dev, "vrtc");
> +	if (IS_ERR(rtc->supply)) {
> +		if (PTR_ERR(rtc->supply) =3D=3D -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +
> +		rtc->supply =3D NULL;
> +	}
> +
> +	if (rtc->supply) {
> +		ret =3D regulator_enable(rtc->supply);
> +		if (ret) {
> +			dev_err(&pdev->dev, "regulator enable failed\n");
> +			return ret;
> +		}
> +	}
> +
>  	platform_set_drvdata(pdev, rtc);
> =20
>  	/* Enable the clock/module so that we can access the registers */
> @@ -624,6 +642,9 @@ err:
>  	pm_runtime_put_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> =20
> +	if (rtc->supply)
> +		regulator_disable(rtc->supply);
> +
>  	return ret;
>  }
> =20
> @@ -649,6 +670,9 @@ static int __exit omap_rtc_remove(struct platform_dev=
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

--gmhhrsDozM2n+uz5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUSnL6AAoJEIaOsuA1yqREBGgP/2+EMuG1tG3+0U6YvxwlbSa1
h2uyBtS7pZyxrB4XqLS5vf9LwrBrNYVTmeQ18uhoSqtlqQhbqcYZNSgoVQ+cH+3g
GzgA8VKff+ND4dKZj49hspVK5ltKo7VGS2AA1Kpn/v6OYONs1sYUdii+E8mzZEav
QWQ8x3LLueDP447v+SD7KYZfL/LK0d9mBJnnIVh+lX3Z9HrQQfpKs2FdM3hRcr5j
KHIE6mBO9waeTt9PIpS31y+xhgiPt2y9BkqbkDyjsJJpSY0Hxwr2agLAqrW/s3rY
/3Uxel4PlvW9Rdkjo4t77mTeDvg0CjlWrPC3l5bRQzcQe/6WVya1LNlqwmoSbuSC
DHxiECs7U3mLhjFuBXAj9orbO2FoO62eWeAYAnE8oUCfqBaODTsTHzRVZd6DVeBb
Fu7S2xxgfoCap2XhOzDn6nTlJE7zezJ2db8wZ9k8tdtD1w2WVXmZbv79mksu3yo8
5B6Yy1cLeIJFokHc6HC6mKekRDSE7x62G2LwqY/nkCoBgwJhxCteoVThqjp/o5C+
+r0mXJhSs8gpHDoMO7RVILkPhS6HOuEA56pvxZjVdUEIFqwTJnRUbO8grCCQNtJI
8eOSlojnRFgwIvsVuJqDqHRYzpMvoBNcgS/5cDhjOac5lhKwcR1ouaxzVUcy14z+
I9OGCNU03rq7ZKeBDFq9
=WZZS
-----END PGP SIGNATURE-----

--gmhhrsDozM2n+uz5--
