From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] fix vibrations on Droid 4
Date: Thu, 2 Aug 2018 12:55:35 +0200
Message-ID: <20180802105535.2fvggxsma22usrfr@earth.universe>
References: <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
 <20180711080218.GA21225@amd>
 <20180711132739.GL99251@atomide.com>
 <20180715201729.GB19675@amd>
 <20180716075926.GU99251@atomide.com>
 <20180801202821.GB4033@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cyth6dvy6fl3k6an"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180801202821.GB4033@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--cyth6dvy6fl3k6an
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 01, 2018 at 10:28:21PM +0200, Pavel Machek wrote:
> Vibration GPIOs don't have anything to do with wakeup. Move it to
> normal section; this fixes vibrations on Droid 4.
>    =20
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>=20
> diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts=
/omap4-droid4-xt894.dts
> index c27fc87..7b82179 100644

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

> --- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
> +++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> @@ -646,15 +646,6 @@
>  		OMAP4_IOPAD(0x10c, PIN_INPUT | MUX_MODE1)	/* abe_mcbsp3_fsx */
>  		>;
>  	};
> -};
> -
> -&omap4_pmx_wkup {
> -	usb_gpio_mux_sel2: pinmux_usb_gpio_mux_sel2_pins {
> -		/* gpio_wk0 */
> -		pinctrl-single,pins =3D <
> -		OMAP4_IOPAD(0x040, PIN_OUTPUT_PULLDOWN | MUX_MODE3)
> -		>;
> -	};
> =20
>  	vibrator_direction_pin: pinmux_vibrator_direction_pin {
>  		pinctrl-single,pins =3D <
> @@ -669,6 +660,15 @@
>  	};
>  };
> =20
> +&omap4_pmx_wkup {
> +	usb_gpio_mux_sel2: pinmux_usb_gpio_mux_sel2_pins {
> +		/* gpio_wk0 */
> +		pinctrl-single,pins =3D <
> +		OMAP4_IOPAD(0x040, PIN_OUTPUT_PULLDOWN | MUX_MODE3)
> +		>;
> +	};
> +};
> +
>  /*
>   * As uart1 is wired to mdm6600 with rts and cts, we can use the cts pin=
 for
>   * uart1 wakeirq.
>=20
> --=20
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html



--cyth6dvy6fl3k6an
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlti4yMACgkQ2O7X88g7
+pqoGRAAp0IrhrYTJpWM9qcnMX0IYF+Vw4i6VKrymdHSF1JQnb0f4zRkTJ/Qy14U
XCZzvwgxJ1EBL/9P3jSx/8zEKaXtIPhedeBbMH9VW7iq3vEAa8zxvU1ee3WM3KFo
CsUFB69Y0RE/Ofspz1ZeeAwf+DRCZLIa/R0t9NGTB09q9AaUSCUIuyrOxyQWFZLU
gnUSe8Ebi/hDbRFcF9JqtcLXV4hR6S4Y6xQZ1B68qTrWJPSshqJ2dkosnSmenwDk
zsj3IxG2r38wVZfZ4Wd7OSxEUrhapT3Ya7OeDOB56LIyARhhRAIPhjQecVPRgebx
KUq4B7XNer9OwIhs0OK9KyFbaA1RpV7n5itJYL8aLt/Qonih3I6sewrWEs09s/cL
adPGQChYDripApaI4PraefvgKEv/UOue3GHDHkPpBEVO4IFXCWPxiOwP0GB+AG50
SZoC+JxrseCKB9ha4fdaXI0u5v6BnsscJRzSZMag6tzAAnY+Wi5ErhsnnxDd7ZfE
k28TxoJwKNe87uDIAuyuP99wwDxwysa9HSgGrlnxEXfFD8aBOT2w9xf6mxFC1jJl
JjlmH54jb5KU80bstv1m3jTr5lkHx7vZiWb8t+7Ya/1T23JiH3W4mDSf47Qno4tf
Nn0ZCIFmGdhDLXiH9m2vPrfHRsYbXrFV+0wZ9zQh0Gus5U0J81M=
=hDVL
-----END PGP SIGNATURE-----

--cyth6dvy6fl3k6an--
