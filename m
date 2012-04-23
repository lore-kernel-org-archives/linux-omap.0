From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCHv8 05/10] I2C: OMAP: Don't check if
 wait_for_completion_timeout() returns less than zero
Date: Mon, 23 Apr 2012 19:11:08 +0200
Message-ID: <20120423171108.GJ27321@pengutronix.de>
References: <1334842101-20670-1-git-send-email-shubhrajyoti@ti.com>
 <1334842101-20670-6-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="I/5syFLg1Ed7r+1G"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1334842101-20670-6-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--I/5syFLg1Ed7r+1G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2012 at 06:58:16PM +0530, Shubhrajyoti D wrote:
> By definition, wait_for_completion_timeout() returns an unsigned value and
> therefore, it is not necessary to check if the return value is less than =
zero
> as this is not possible.
>=20
> This is based on a patch from Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
> Changes from his patch
> - Declare a long as the wait_for_completion_timeout returns long.
>=20
> Original patch is
> http://git.omapzoom.org/?p=3Dkernel/omap.git;a=3Dcommitdiff;h=3Dea02cece7=
b0000bc736e60c4188a11aaa74bc6e6

The original patch has a signed-off, so you need to include it here as
well.

>=20
> Cc : Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-omap.c |   10 ++++------
>  1 files changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 1777d79..fec8d5c 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -473,7 +473,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  			     struct i2c_msg *msg, int stop)
>  {
>  	struct omap_i2c_dev *dev =3D i2c_get_adapdata(adap);
> -	int r;
> +	unsigned long timeout;
>  	u16 w;
> =20
>  	dev_dbg(dev->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
> @@ -541,12 +541,10 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *ad=
ap,
>  	 * REVISIT: We should abort the transfer on signals, but the bus goes
>  	 * into arbitration and we're currently unable to recover from it.
>  	 */
> -	r =3D wait_for_completion_timeout(&dev->cmd_complete,
> -					OMAP_I2C_TIMEOUT);
> +	timeout =3D wait_for_completion_timeout(&dev->cmd_complete,
> +						OMAP_I2C_TIMEOUT);
>  	dev->buf_len =3D 0;
> -	if (r < 0)
> -		return r;
> -	if (r =3D=3D 0) {
> +	if (timeout =3D=3D 0) {
>  		dev_err(dev->dev, "controller timed out\n");
>  		omap_i2c_init(dev);
>  		return -ETIMEDOUT;
> --=20
> 1.7.5.4
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--I/5syFLg1Ed7r+1G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+VjSwACgkQD27XaX1/VRtTqQCghNp32aefExdzxHFJftLDLz7j
b7kAoJW0aQgVD8lKOzkzOYQ8ZJ/kdG9u
=ltUz
-----END PGP SIGNATURE-----

--I/5syFLg1Ed7r+1G--
