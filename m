From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 3/4] i2c: omap: don't reset controller if Arbitration
 Lost detected
Date: Fri, 21 Nov 2014 19:07:28 -0600
Message-ID: <20141122010728.GB26751@saruman>
References: <1416518925-20679-4-git-send-email-al.kochet@gmail.com>
 <1416610307-3698-1-git-send-email-al.kochet@gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1416610307-3698-1-git-send-email-al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2014 at 02:51:47AM +0400, Alexander Kochetkov wrote:
> Arbitration Lost is an expected situation in a multimaster
> environment. I2C controller (IP) correctly detect and report AL.
>=20
> The only one visible reason for reseting IP in the AL case is
> to avoid advisory 1.94 (omap3) and errata i595 (omap4): "I2C:
> After an Arbitration is Lost the Module Incorrectly Starts
> the Next Transfer".
>=20
> Errata workaround states: "The MST and STT bits inside I2C_CON
> should be set to 1 at the same moment (avoid setting the MST bit
> to 1 while STT =3D 0)." The driver never set MST and STT bits
> separately and doesn't create condition for errata. So the reset
> is not necessary.
>=20
> Also corrected return value for AL to -EAGAIN.
>=20
> Tested on Beagleboard XM C.
>=20
> Signed-off-by: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

you could have kept my tested-by and reviewed-by:

Tested-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>


> On 21.10.2014 21:11, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> > The errno for AL is -EAGAIN. Curly braces are not needed.
>=20
> Thank you, Wolfram, fixed.
>=20
>  drivers/i2c/busses/i2c-omap.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 3ffb9c0..02da567 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -707,13 +707,15 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *ad=
ap,
>  		return 0;
> =20
>  	/* We have an error */
> -	if (dev->cmd_err & (OMAP_I2C_STAT_AL | OMAP_I2C_STAT_ROVR |
> -			    OMAP_I2C_STAT_XUDF)) {
> +	if (dev->cmd_err & (OMAP_I2C_STAT_ROVR | OMAP_I2C_STAT_XUDF)) {
>  		omap_i2c_reset(dev);
>  		__omap_i2c_init(dev);
>  		return -EIO;
>  	}
> =20
> +	if (dev->cmd_err & OMAP_I2C_STAT_AL)
> +		return -EAGAIN;
> +
>  	if (dev->cmd_err & OMAP_I2C_STAT_NACK) {
>  		if (msg->flags & I2C_M_IGNORE_NAK)
>  			return 0;
> --=20
> 1.7.9.5
>=20

--=20
balbi

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUb+HQAAoJEIaOsuA1yqRE6kgP/1IadpV93TFytmxBhHWhz89L
BU2OdhZhRWm6P9EBOCQ4G8P+3yC773kiXCLmuV7wK1XgSZmQyBaCMQBLXnCvHIUZ
XA37Do34V2wSgTrEF/bacWfgNBqCPoqNKI37HYWT5Wv9bf0JectVFUvmwuLVG0tF
nKZYiPhS1RsWm9mj3fkf8K2ZqNm25n/DQ1QfsfZDiY/VMzsK5nG2mOO7dOeklOzD
TK1AVHWJ0swMo5ZBC/0Hq3SoLJ93t3eaQMh8PN7vFmv7K2Rs6rYKBwuYfumtDVL7
uTN6BuPYK07uIJeHFxgjqrpu0RoqQJaq5ya9+MFxBFm0ZBZZ4wK1oFJbNoloxZEX
qu1uWv4PQh1iEJ1GonMDqMgVpx0Pbv86bItEljCUSbDJ1M+CQwmHlqjzlRf0jS+L
5oev0fIWd2LncPE0k1Hd7jGRv8wZmsSVNc/tibstqgTM8A60XmUWLAwBkb0fTTTJ
D6deaoKEUbfQn5LGq6I5djlp4xMaJ9t7J1PmM5sWZLyQehyXyVXWMhAqVMgHya4L
EQCGXwLvQpqU/GjwbyJSzpqS9V2GlzdzMmhxhjfJoX4lB+abObplka9436v7+NY/
El+Fyg3wEy0aeOBSmfQ3bwwgImRw41bdaXX3YCniqz4hwUi8Y0w3Yg/Eew4A+aAV
rdbyUZKHKc0eE+WRp1kR
=ZnN9
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
