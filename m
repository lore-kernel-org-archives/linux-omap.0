From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: am57xx-beagle-x15: Add GPIO controlled fan node
Date: Fri, 5 Dec 2014 11:36:04 -0600
Message-ID: <20141205173604.GB28038@saruman>
References: <1417800739-13146-1-git-send-email-nm@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1417800739-13146-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 05, 2014 at 11:32:18AM -0600, Nishanth Menon wrote:
> From: "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>

do you want to sanitize your name ?

> TPS gpio now controls a 5v 500mA TL5209 regulator which may be supply
> a fan (such as AFB02505HHB) over J1 connector for various purposes.
> Provide device tree node to enable the same.
>=20
> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> ---
> Depends on the following:
> https://patchwork.kernel.org/patch/5439201/
> https://patchwork.kernel.org/patch/5439191/
>=20
> enable and disable can be controlled by
> echo '1' > /sys/class/hwmon/hwmon0/fan1_target
> and
> echo '0' > /sys/class/hwmon/hwmon0/fan1_target
>=20
> requires CONFIG_GPIO_PALMAS and CONFIG_SENSORS_GPIO_FAN to be operational
> Applies on=20
> https://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/log/?h=
=3Domap-for-v3.19/dt-v2
>=20
>  arch/arm/boot/dts/am57xx-beagle-x15.dts |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/=
am57xx-beagle-x15.dts
> index 49edbda..7fe82ef 100644
> --- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
> +++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> @@ -80,6 +80,15 @@
>  			default-state =3D "off";
>  		};
>  	};
> +
> +	gpio_fan {
> +		/* Based on 5v 500mA AFB02505HHB */
> +		compatible =3D "gpio-fan";
> +		pinctrl-names =3D "default";

not needed.

> +		gpios =3D  <&tps659038_gpio 1 GPIO_ACTIVE_HIGH>;
> +		gpio-fan,speed-map =3D <0    0
> +				      13000 1>;
> +	};
>  };
> =20
>  &dra7_pmx_core {
> @@ -314,6 +323,12 @@
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

--=20
balbi

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUge0EAAoJEIaOsuA1yqREQRIP/1h1hw4P48ie/xYkJEryzvVb
991d8xBVEKeYVZhEr8IC9Sq9fCG8f8FpR6m/9hXsPJHRiNdww7u2bV1Qkhtesa1U
i9SViUVhadSkBBHwZEDIvktcPgMmMtV48XuAcrjIgMzBElx/tDiHntbEh8rzFk37
IL1Vx1Ebsur0ylX2gXZ4oeX8S/YUDJfXTTyUuUMnRnH5EJJcQ/iZNqhadYjyZUXo
z85m0L39eo6POpneJjPNXjlwl7dIEjrpNjH0rYtMbyHJpyEq8HDMc+F9pJMgu0E4
dBFzRt7dPCjZ0YVZNVBaflwUlD9NdQajaebPqVSp48RsNUrEHnkODTgIbclYlN++
xcMXe3VyyFn3132AIeX808r72sX6MSQ3gBs0r1nE8WHWZ/Xc6CRShna8SFiAUYhY
JtcbXO9+FR4zU896spdJ6Wa8d5bIuwX6LiOnfalyD3cTudfcmVGGOOWTp4dE2qSE
OzzlVjtScurvALJuoHp7WQfT5yIWBswbSNFzA8C3hrtRUCn6OAbcWiGO8Jgif3dv
PadL0FYZyyTdtx4tUOawI/srgG1egijLFvaySdrzOj8o26UJ2W8O71dg1H4dFkfs
OtlTIjfVSL7/EVbVosdffjiqKCjzJC5wnWSkmD/cB4PEj/l1GhDeP61g6FbH4MrU
AYjmxBs2zZ4gRkhwK+6P
=cVua
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
