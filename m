From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/4] i2c: omap: don't reset controller if Arbitration
 Lost detected
Date: Fri, 21 Nov 2014 19:11:25 +0100
Message-ID: <20141121181125.GD3754@katana>
References: <1416518925-20679-1-git-send-email-al.kochet@gmail.com>
 <1416518925-20679-4-git-send-email-al.kochet@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x4pBfXISqBoDm8sr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1416518925-20679-4-git-send-email-al.kochet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Kochetkov <al.kochet@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org


--x4pBfXISqBoDm8sr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2014 at 01:28:44AM +0400, Alexander Kochetkov wrote:
> Arbitration Lost is a expected situation in a multimaster environment.
> IP correctly detect it.
>=20
> The only reason for reseting IP in the AL case is to be sure to
> avoid advisory 1.94 (omap3) and errata i595 (omap4):
> "I2C: After an Arbitration is Lost the Module Incorrectly Starts
> the Next Transfer" with workaround: "The MST and STT bits inside
> I2C_CON should be set to 1 at the same moment (avoid setting the
> MST bit to 1 while STT =3D 0)."
>=20
> The driver never writes MST and STT bits separately and doesn't
> create condition for errata. So the reset is not necessary.
>=20
> Tested on Beagleboard XM C.
>=20
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 3ffb9c0..47103e7 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -707,13 +707,17 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *ad=
ap,
>  		return 0;
> =20
>  	/* We have an error */
> -	if (dev->cmd_err & (OMAP_I2C_STAT_AL | OMAP_I2C_STAT_ROVR |
> +	if (dev->cmd_err & (OMAP_I2C_STAT_ROVR |
>  			    OMAP_I2C_STAT_XUDF)) {
>  		omap_i2c_reset(dev);
>  		__omap_i2c_init(dev);
>  		return -EIO;
>  	}
> =20
> +	if (dev->cmd_err & OMAP_I2C_STAT_AL) {
> +		return -EIO;
> +	}

The errno for AL is -EAGAIN. Curly braces are not needed.

> +
>  	if (dev->cmd_err & OMAP_I2C_STAT_NACK) {
>  		if (msg->flags & I2C_M_IGNORE_NAK)
>  			return 0;
> --=20
> 1.7.9.5
>=20

--x4pBfXISqBoDm8sr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUb4BNAAoJEBQN5MwUoCm25T4P/1ewQDUeHc0TOlcS0LNREi/E
MPT4dAf2Xu2I2NGJpGfUxfXpD4XvC8rl8cyZWzm9za6r51nLn7Bb4Wy3eKlIEN1n
h5N5XaBpFNmSFxz/nsVTaRxr+Q4tfP9jWPckprJhKmJIRcXTkmE4eaT0/OV/Vd+2
IBRj6d99TRvytj9ZS3YOCS3iNXamd1obJd4P9auM1KEUqFBBY7FiQs3PyUZBkuf/
jcZdNcZtrz2DgZiun2j90XfQ4nhSu3xeSgWj0KCow/MgXShXwWC4mSpgYKcn1PMO
gRgr1TFmHoYgozjtnkGAWlWlxn6lYV88rJv2We7fx6XNtqypHYBk8AIQix3JD4CF
aAARYAiJQfqfhT64sovFemergbxm9TCWrukqDBVFO1a3e1ElvFbM/ujBwTn03lDY
KxeowSNy5A6+XnGyf7lbaGMQC1abUlEcTnuy4BhWIF3liRK1IFhRWF4wjXlKFSWi
MXqa7iAGHTCrwx5Z033pm6K9qHD1js+aAOj/5WebYs7IiCCBy0Keforq8/jHZAuu
dnWIj+Ao4bYJNlWOVXrbnitk0gJdB2AP6fdri1y+juQ5UKNw1/CRot4c4/rklgK/
GozeZPebsUZ2b1sDfUP5UJJK6Ckkbg2am3RWHYG4bG6yFur2Rq4Q4Mjf4OwZIoJk
W/UIHKGmkGK6txWlf/mI
=1bEl
-----END PGP SIGNATURE-----

--x4pBfXISqBoDm8sr--
