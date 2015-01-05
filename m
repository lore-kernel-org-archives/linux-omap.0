From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH V4] ARM: dts: am57xx-beagle-x15: Add GPIO controlled fan
 node
Date: Mon, 5 Jan 2015 11:27:18 -0600
Message-ID: <20150105172718.GJ19336@saruman>
References: <1420475549-28492-1-git-send-email-nm@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P6YfpwaDcfcOCJkJ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34769 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753153AbbAER2W (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Jan 2015 12:28:22 -0500
Content-Disposition: inline
In-Reply-To: <1420475549-28492-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, sre@kernel.org

--P6YfpwaDcfcOCJkJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 05, 2015 at 10:32:29AM -0600, Nishanth Menon wrote:
> TPS gpio now controls a 5v 500mA TL5209 regulator which may be supply
> a fan (such as AFB02505HHB) over J1 connector for various purposes.
> Provide device tree node to enable the same.
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>

have already reviewed this one previously:

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
> V4: Change format of the speed-map used.
> V3: https://patchwork.kernel.org/patch/5562121/
> V2: https://patchwork.kernel.org/patch/5445111/
> V1: https://patchwork.kernel.org/patch/5444911/
>=20
> Enable and disable can be controlled by (post the RPM, it finds
> closest match - even a 1 will do)
>=20
> echo '13000' > /sys/class/hwmon/hwmon0/fan1_target
> and
> echo '0' > /sys/class/hwmon/hwmon0/fan1_target
>=20
> Test log: http://slexy.org/view/s2T0ajh46z
>=20
> requires CONFIG_GPIO_PALMAS and CONFIG_SENSORS_GPIO_FAN to be operational
> Applies on v3.19-rc1
>=20
>  arch/arm/boot/dts/am57xx-beagle-x15.dts |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/=
am57xx-beagle-x15.dts
> index 6c2e8e4..c5d4cea 100644
> --- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
> +++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> @@ -80,6 +80,14 @@
>  			default-state =3D "off";
>  		};
>  	};
> +
> +	gpio_fan: gpio_fan {
> +		/* Based on 5v 500mA AFB02505HHB */
> +		compatible =3D "gpio-fan";
> +		gpios =3D  <&tps659038_gpio 1 GPIO_ACTIVE_HIGH>;
> +		gpio-fan,speed-map =3D <0     0>,
> +				     <13000 1>;
> +	};
>  };
> =20
>  &dra7_pmx_core {
> @@ -394,6 +402,12 @@
>  			wakeup-source;
>  			ti,palmas-long-press-seconds =3D <12>;
>  		};
> +
> +		tps659038_gpio: tps659038_gpio {
> +			compatible =3D "ti,palmas-gpio";
> +			gpio-controller;
> +			#gpio-cells =3D <2>;
> +		};
>  	};
> =20
>  	tmp102: tmp102@48 {
> --=20
> 1.7.9.5
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--P6YfpwaDcfcOCJkJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUqsl2AAoJEIaOsuA1yqREMxcP/jRcHE1P/n1htnqFsn1gG6P+
fImNJPf+z5YZSn3If8psKMPoqXOeLVZqiXMffVk6WzB33/W8v4ZxkkGWWPDXcJ2K
TuicSV0G+F5VRmqYN7OxN6nC6pVOIDRAaI0PvckHgTECW3blWaJrLxOb10M+Zyxw
4D49jzxJtfzlQ9TXW/0BTFdl1uuxrwC7RSWFMXUs9CH3O2jR0moUClsA9WkU7vJs
Pj3mo+6K02qzMexOkObQINgrLqy4NoSeezUT1HXShnMnlLH+wy3qQr5WgVNyY52y
wLMbFrUVBFGadq2Hm7Qrd/v7UO6BePy09Dk7VXIR4MU0RhRJj0rxLvbMUJQUIxsB
uhSpD3t9vQhptR1FkDaG7plCuOnmdWsN6zkw8kughm3m3HWpR1MCGWiVlnWhVRm2
+XGXk1hBQciK13APNTKO8l+AxmNv5RrUnJ2keIUm5KwhBi5et/INReYNu1/yo0Sl
0+83RfHyKgJ7dd7SH/vtge15m3KZH2SVQbKXFwxzT8V9/7fwGnMP0hMbS7Volr7e
KwR4Jsnt3MCPqPrtexnsTyew25+4pKF5MLVhgIJS0HX2ZJllmadFY3x4cU7YWyjT
0NvbpA7YY/SXylYkBhCXy6a1O754aZsvuky9G3AzPPzU7p0zzTdiO72bml3fg5ak
v+RDNnIvggJC1EunjNSk
=nJys
-----END PGP SIGNATURE-----

--P6YfpwaDcfcOCJkJ--
