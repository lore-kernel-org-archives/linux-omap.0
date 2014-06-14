From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] input: touchscreen: ti_am335x_tsc: warn about incorrect
 spelling
Date: Fri, 13 Jun 2014 19:23:55 -0500
Message-ID: <20140614002355.GB24821@saruman.home>
References: <20131118114029.GD30853@e106331-lin.cambridge.arm.com>
 <1384788541-16338-1-git-send-email-balbi@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1384788541-16338-1-git-send-email-balbi@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, dmitry.torokhov@gmail.com, rob.herring@calxeda.com, Pawel.Moll@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Here's another patch which has been pending for months.

On Mon, Nov 18, 2013 at 09:29:01AM -0600, Felipe Balbi wrote:
> In the hopes that people run new kernels on
> their devices, let's add a warning message
> asking users to have their DTS file fixed.
>=20
> The goal is that by Linux 4.0 we will be
> able to remove support for the bogus version
> of our touchscreen's DTS.
>=20
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>=20
> Here you go, I've added your Suggested-by Mark,
> if you wish I can remove or change to something
> else.
>=20
> cheers
>=20
>  drivers/input/touchscreen/ti_am335x_tsc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/to=
uchscreen/ti_am335x_tsc.c
> index b61df9d..91302cd 100644
> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> @@ -354,9 +354,12 @@ static int titsc_parse_dt(struct platform_device *pd=
ev,
>  	 */
>  	err =3D of_property_read_u32(node, "ti,coordinate-readouts",
>  			&ts_dev->coordinate_readouts);
> -	if (err < 0)
> +	if (err < 0) {
> +		dev_warn(&pdev->dev, "please use 'ti,coordinate-readouts' instead\n");
>  		err =3D of_property_read_u32(node, "ti,coordiante-readouts",
>  				&ts_dev->coordinate_readouts);
> +	}
> +
>  	if (err < 0)
>  		return err;
> =20
> --=20
> 1.8.4.GIT
>=20

--=20
balbi

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTm5YbAAoJEIaOsuA1yqREA78P/iLF0BHGBbl9ppi7nKhphItv
1xu5HKVN0YcI9e6EtUGfc5GWwQXZ3KXsuceAIzbugf0ofUT86Wh2ewhHRf3Aei2T
aJllzrnVI8BSZT0HSD+t6P5AOe2VpyNk5Cx39FPswwYqq0JMLFmobMxESPE8wkn9
YooKKBEXLrqA5A6COOFlYCAeFRGdvu9T6PMf11qQf8Y6+pEL1+BI7+MBEELxjtii
uiCVnrw0dwMdTtLVk89Izhj3204NbxG+k902NBioDniie/5LW1vy32ri2xQro7EQ
0UT8xbhUbkblDyAuSg94HcpdcveUxMHXGMWaV74ijTvg2zw4GH7C99PzstvgF4fj
GcyUr343kp1sEQtsfRvB10qrsD7NjEeLDCTPYehlui5+tz/b/fjkdCoqT1B3ZHOB
SRk2yYDsk8CrMjAZ/2bv1PuoPFYeEMRDilKnINCKWAPv50zOQChOTUsTeQpvnw0B
X7338qT8EqWCUpX/qEaFCP/uIyqxvSsG1JjRpgxuQ1abDwOiTPXhCFKAp1PLGcYX
LD5S8PEg2vN+kGbihIV7ref9GFAzTK4Io8zVdH+YNsHEcFj0OeTTxBpDaEOKdj7d
2arElTOZHfSz3GEv5S1Zn9CElWJCTPsYln02oAAkR2Q13QlMwVOINYZwg+Bl3s6C
8JIbi8Yl0txJcGNe83AE
=vAUv
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--
