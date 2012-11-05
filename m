From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv3 8/8] i2c: omap: cleanup the sysc write
Date: Mon, 5 Nov 2012 16:14:42 +0200
Message-ID: <20121105141442.GD4815@arwen.pp.htv.fi>
References: <1352118223-3796-1-git-send-email-shubhrajyoti@ti.com>
 <1352118223-3796-9-git-send-email-shubhrajyoti@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rqzD5py0kzyFAOWN"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1352118223-3796-9-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--rqzD5py0kzyFAOWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 05, 2012 at 05:53:43PM +0530, Shubhrajyoti D wrote:
> Currently after the reset the sysc is written with hardcoded values.
> The patch reads the sysc register and writes back the same value
> after reset.
>=20
> - Some unnecessary rev checks can be optimised.
> - Also due to whatever reason the hwmod flags are changed
> we will not reset the values.
> - In some of the cases the minor values of the 2430 register
> is different(0x37) in that case the autoidle setting may be missed.
>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-omap.c |   20 +++++---------------
>  1 files changed, 5 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 25f1564..a09acdc 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -302,7 +302,11 @@ static void __omap_i2c_init(struct omap_i2c_dev *dev)
>  static int omap_i2c_reset(struct omap_i2c_dev *dev)
>  {
>  	unsigned long timeout;
> +	u16 sysc;
> +
>  	if (dev->rev >=3D OMAP_I2C_OMAP1_REV_2) {
> +		sysc =3D omap_i2c_read_reg(dev, OMAP_I2C_SYSC_REG);
> +
>  		/* Disable I2C controller before soft reset */
>  		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG,
>  			omap_i2c_read_reg(dev, OMAP_I2C_CON_REG) &
> @@ -324,22 +328,8 @@ static int omap_i2c_reset(struct omap_i2c_dev *dev)
>  		}
> =20
>  		/* SYSC register is cleared by the reset; rewrite it */
> -		if (dev->rev =3D=3D OMAP_I2C_REV_ON_2430) {
> -
> -			omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG,
> -					   SYSC_AUTOIDLE_MASK);
> +		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, sysc);
> =20
> -		} else if (dev->rev >=3D OMAP_I2C_REV_ON_3430_3530) {
> -			dev->syscstate =3D SYSC_AUTOIDLE_MASK;
> -			dev->syscstate |=3D SYSC_ENAWAKEUP_MASK;
> -			dev->syscstate |=3D (SYSC_IDLEMODE_SMART <<
> -			      __ffs(SYSC_SIDLEMODE_MASK));
> -			dev->syscstate |=3D (SYSC_CLOCKACTIVITY_FCLK <<
> -			      __ffs(SYSC_CLOCKACTIVITY_MASK));
> -
> -			omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG,
> -							dev->syscstate);
> -		}

not sure if this will work. What about the first time you call reset() ?
won't SYSC just contain the reset values ?

--=20
balbi

--rqzD5py0kzyFAOWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQl8nSAAoJEIaOsuA1yqREOlkP/jk4Pa+8NjR1dGvAz+Wv/9Ju
NaIM9O8uw4G6tB36oEAKyL590uEQBrcv0/bd5KBrs5pwJ1j8Ra+gd7X4wWeYQY8w
RU8HIqRq8zNMLR8o8qeMg+kpimQy5AwCKlQo6HYZLdPOUX4TL8KnTWY4llOAr13r
AHS9+R8+tX40I2v9Im+t6QPtFeVLoAqPtxMUyjeRKFZV1Kst2B3ewFmKb+KBXLR1
J43WD11H3kx0j4GmPMT5hrOUYTSSE/dnQsOk9vTPERcdOIrgZHW/Otq2vxgBgQVf
O/vIlsaQOyr8SK0yjrnZC0HyKzZQVh/sd7rQkpdeXT39wjtJO6UJccX6Au4KYvGi
3OgR2xHXmWKCTaHDXgSF0Lqw04QwpE5qG0b9OfxOTbpLrZS4GdmA/Id4zt1jiPiF
8DygQN8pdaacpszoedoiZ5XRSArX0KxAyYm+9QPy5bAmGCS4yufkK4NdOYjQs7CF
GIBUl+ESf8jPSn7Gs1GiqldxWgtMA+Z85p3D2HynNXxFVXAF1A8Rmyq/KCEiSS5Q
1HAJqQntAGXzpWyVnBpifEH3rWuJb8SryHh8Bcf++rkgo1458AqvCdzs/xb9092j
1QoUo/tuY0wKcCjkxl2ugNv3+DR8BpNHF/UkUZn5r0HwMW7i4aH3JwtfvXkJRWZD
T42YS9avu01xvPOsvX0j
=n4bV
-----END PGP SIGNATURE-----

--rqzD5py0kzyFAOWN--
