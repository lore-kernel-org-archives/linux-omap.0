From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] dts/droid4: fix dts w.r.t. pwm
Date: Mon, 16 Jul 2018 12:11:06 +0200
Message-ID: <20180716101106.vgmjz3ic7gqy2u2q@earth.universe>
References: <20180709081534.GA6799@amd>
 <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
 <20180711080218.GA21225@amd>
 <20180711132739.GL99251@atomide.com>
 <20180711142526.dto6iost57zx5t5l@earth.universe>
 <20180716071048.GA23110@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qshvk5u2dnfjfb3e"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180716071048.GA23110@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--qshvk5u2dnfjfb3e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 16, 2018 at 09:10:48AM +0200, Pavel Machek wrote:
> pwm node should not be under gpio6 node in the device tree.
>   =20
> This fixes detection of the pwm on Droid 4.
>    =20
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

> diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts=
/omap4-droid4-xt894.dts
> index 45305e8..c27fc87 100644
> --- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
> +++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> @@ -159,13 +159,7 @@
> =20
>  		dais =3D <&mcbsp2_port>, <&mcbsp3_port>;
>  	};
> -};
> -
> -&dss {
> -	status =3D "okay";
> -};
> =20
> -&gpio6 {
>  	pwm8: dmtimer-pwm-8 {
>  		pinctrl-names =3D "default";
>  		pinctrl-0 =3D <&vibrator_direction_pin>;
> @@ -192,7 +186,10 @@
>  		pwm-names =3D "enable", "direction";
>  		direction-duty-cycle-ns =3D <10000000>;
>  	};
> +};
> =20
> +&dss {
> +	status =3D "okay";
>  };
> =20
>  &dsi1 {
>=20
>=20
>=20
> --=20
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html



--qshvk5u2dnfjfb3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAltMbzcACgkQ2O7X88g7
+por8A//buhi/5dQvTTjCwl1wz4IvrTxE9qONWMbjxu2xjA/5rQciYLQ5uvkozWd
ZvpLsWuIMXdkg5CAxTjwPJMlTI3D4iRGaxBg+pW3JTuWdyGgZcbbRfaJ9mGFfZbF
O0qHKLA4Cv6l5rOVz4UP7yvgPXsTYlm6S4byt3JPzbK/gCEig+ciZ4XyI9pkyhi0
bvd9AnauYRkoZVyoChOp9uLesNRDOBuBKynQlIrRUa2d8O8Dr6M4Lpx80EQFqQcc
aS9PdgIK3tQLlW2VJvYi+hmZGoLH57c2o//W0ocsiFBEY3QtXz5mujMsPPssQiUA
vpzsmDUTYls7Z2fQsHjGbpCX1RzB6YPfVgTE5+WjcncK0YMVWiqLzyqizdwaevwp
ur6qK2K6y+khPcmqkgvKosmKBDNsUdJ9hUmTVpY1iNGcfXo4NAmMV6RMnSAPD9is
qISNVZiW7nj8Y/MRH0cbIXbV4qx3xRwaYxS3A/XgRjxWkLUxQJbkjTwQYUu1BBUp
WgEdkkt8d4MxYnovMcu6SRAm5yz2sKK6rJMstFqISm6I+po41dwJHkzHn+DRCogH
5mvXHb/RDkwa29H3sATcmQiJ2hJmNNAAOdkpWRa6aZZF0Mm9MqN8rg73HRh5hbJg
1BkGCfyO2/kCU9NhwHnhANymygXOde9ix9gudmRpmtxigTjJygs=
=o33p
-----END PGP SIGNATURE-----

--qshvk5u2dnfjfb3e--
