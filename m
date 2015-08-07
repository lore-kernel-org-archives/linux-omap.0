From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 07/13] twl4030_charger: distinguish between USB current
 and 'AC' current
Date: Fri, 7 Aug 2015 07:13:09 +0200
Message-ID: <20150807051309.GA24702@earth>
References: <20150730001113.4012.18086.stgit@noble>
 <20150730001124.4012.48552.stgit@noble>
 <20150807031116.GH4215@atomide.com>
 <20150807134525.251528ab@home.neil.brown.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150807134525.251528ab@home.neil.brown.name>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neil@brown.name>
Cc: Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>, linux-pm@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, real GTA04 owners <gta04-owner@goldelico.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

This actually slipped through my review. IMHO madc should be
accessed through IIO, as already done for twl4030-madc-battery
and rx51-battery. That way the custom API can be removed at
some point.

Anyway, I queued the below patch with Tony's ACK to fix the build
issue in next.

On Fri, Aug 07, 2015 at 01:45:25PM +1000, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> Date: Fri, 7 Aug 2015 13:44:37 +1000
> Subject: [PATCH] twl4030_charger: fix compile error when TWL4030_MADC not
>  available.
>=20
> We can only use the madc to check for 'ac' availability
> if the madc has been compiled in.
> If not: assume always using USB.
>=20
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: NeilBrown <neil@brown.name>
>=20
> diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_char=
ger.c
> index c7432f532a83..265fd236f4c0 100644
> --- a/drivers/power/twl4030_charger.c
> +++ b/drivers/power/twl4030_charger.c
> @@ -91,6 +91,21 @@
>  #define TWL4030_MSTATEC_COMPLETE1	0x0b
>  #define TWL4030_MSTATEC_COMPLETE4	0x0e
> =20
> +#if IS_ENABLED(CONFIG_TWL4030_MADC)
> +/*
> + * If AC (Accessory Charger) voltage exceeds 4.5V (MADC 11)
> + * then AC is available.
> + */
> +static inline int ac_available(void)
> +{
> +	return twl4030_get_madc_conversion(11) > 4500;
> +}
> +#else
> +static inline int ac_available(void)
> +{
> +	return 0;
> +}
> +#endif
>  static bool allow_usb;
>  module_param(allow_usb, bool, 0644);
>  MODULE_PARM_DESC(allow_usb, "Allow USB charge drawing default current");
> @@ -263,7 +278,7 @@ static int twl4030_charger_update_current(struct twl4=
030_bci *bci)
>  	 * If AC (Accessory Charger) voltage exceeds 4.5V (MADC 11)
>  	 * and AC is enabled, set current for 'ac'
>  	 */
> -	if (twl4030_get_madc_conversion(11) > 4500) {
> +	if (ac_available()) {
>  		cur =3D bci->ac_cur;
>  		bci->ac_is_active =3D true;
>  	} else {

-- Sebastian

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVxD5iAAoJENju1/PIO/qaRyQQAIlGrGohr1hZZwPeFiureWNY
MRTT6ylhlnuPul1OAkMs/xq0FEvL+/y/vgbCCGwgF7V5K4T0dUvymBQm9jdmnENK
mXhephHiNGOPYLQaFrL6iBAjl2+1o7rINfCW5xOh8QKcmOepEtXfALcu+Q54cUXb
zyxUEwLb+TDBkdMHnTYO4zAJxGSqsFlVRxzzOKmBcQ31ydZBIXomjMuvEAnUW+Lu
15h8Dm8uYGiNwjpU/e92zYX4j2Lwup6sB29XE038PG330UTMBUzfgA+GOGFabYwb
LPssLUjbf+9EAUL2xywe2dLixTTLS+edvfXdpCTQXbCcCZuJNLR2tqs41lNJSAzN
Cnb0y7PPXOYoFK77Ny+rD5G4GTsyYpydNyX3r9ry+Sf3r4WzGAPXTPSUa3+CVzt4
7ZOZ4MZOkYm4IaZXogTXW37hV4tNZtGqmfMugr6XnyLdvZHTakB2nxEsrIJ36aIZ
IamQMB3PUEWiIwuafAr/hLnK/ANEUo/T/2R3sAPFjOuXcWeolHeI0PtMkQd4Zsf+
/MG6g8pflUPJgNESgGQp+cIVM3B5bcrtddDyUE06Hrk5nBZ4in5ISu3dLODe6H4c
B8y6cqrwweyG6PKTlGZ7Hz+l9NVgdgay7PbtEDdE/OuYOtoXWYnGutACe0xkua4W
i7kvaOsNoYOEW8ypYkJZ
=j89x
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
