From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv3 3/8] i2c: omap: remove the dtrev
Date: Mon, 5 Nov 2012 16:11:54 +0200
Message-ID: <20121105141154.GC4815@arwen.pp.htv.fi>
References: <1352118223-3796-1-git-send-email-shubhrajyoti@ti.com>
 <1352118223-3796-4-git-send-email-shubhrajyoti@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sHrvAb52M6C8blB9"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1352118223-3796-4-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--sHrvAb52M6C8blB9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2012 at 05:53:38PM +0530, Shubhrajyoti D wrote:
> The dtrev is used only for the comments. Remove the same and use
> the scheme instead to know if it is version2.
>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>

Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

> ---
> v3: remove the scheme from the commments.
> todo: remove the dtrev from hwmod etc.
>=20
>  drivers/i2c/busses/i2c-omap.c |   12 +++++-------
>  1 files changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 737d843..5f0c06c 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -191,7 +191,6 @@ struct omap_i2c_dev {
>  	u32			latency;	/* maximum MPU wkup latency */
>  	struct pm_qos_request	pm_qos_request;
>  	u32			speed;		/* Speed of bus in kHz */
> -	u32			dtrev;		/* extra revision from DT */
>  	u32			flags;
>  	u16			cmd_err;
>  	u8			*buf;
> @@ -1076,7 +1075,7 @@ omap_i2c_probe(struct platform_device *pdev)
>  	int irq;
>  	int r;
>  	u32 rev;
> -	u16 minor, major;
> +	u16 minor, major, scheme;
> =20
>  	/* NOTE: driver uses the static register mapping */
>  	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -1108,7 +1107,6 @@ omap_i2c_probe(struct platform_device *pdev)
>  		u32 freq =3D 100000; /* default to 100000 Hz */
> =20
>  		pdata =3D match->data;
> -		dev->dtrev =3D pdata->rev;
>  		dev->flags =3D pdata->flags;
> =20
>  		of_property_read_u32(node, "clock-frequency", &freq);
> @@ -1117,7 +1115,6 @@ omap_i2c_probe(struct platform_device *pdev)
>  	} else if (pdata !=3D NULL) {
>  		dev->speed =3D pdata->clkrate;
>  		dev->flags =3D pdata->flags;
> -		dev->dtrev =3D pdata->rev;
>  	}
> =20
>  	dev->dev =3D &pdev->dev;
> @@ -1146,7 +1143,8 @@ omap_i2c_probe(struct platform_device *pdev)
>  	 */
>  	rev =3D __raw_readw(dev->base + 0x04);
> =20
> -	switch (OMAP_I2C_SCHEME(rev)) {
> +	scheme =3D OMAP_I2C_SCHEME(rev);
> +	switch (scheme) {
>  	case OMAP_I2C_SCHEME_0:
>  		dev->regs =3D (u8 *)reg_map_ip_v1;
>  		dev->rev =3D omap_i2c_read_reg(dev, OMAP_I2C_REV_REG);
> @@ -1230,8 +1228,8 @@ omap_i2c_probe(struct platform_device *pdev)
>  		goto err_unuse_clocks;
>  	}
> =20
> -	dev_info(dev->dev, "bus %d rev%d.%d.%d at %d kHz\n", adap->nr,
> -		 dev->dtrev, major, minor, dev->speed);
> +	dev_info(dev->dev, "bus %d rev%d.%d at %d kHz\n", adap->nr,
> +		 major, minor, dev->speed);
> =20
>  	of_i2c_register_devices(adap);
> =20
> --=20
> 1.7.5.4
>=20

--=20
balbi

--sHrvAb52M6C8blB9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQl8kqAAoJEIaOsuA1yqREmF8QALQrx5qlbam0hy59c8XiRTbf
Y7B22DFld5tnbijwrkavlCKrejuXyE9H24wv+rv9vWyx0A5w6kl/stezTgOULEyX
QApGpFDagWpReYrz1RDsdehvxZvmJI8YACQi1rHgS/faQ8gSwvWyWzz9XsZgw8k4
pvG4Nw0aql3o9xdOLfQoiFLYHWYQcfk53BKkyn0Won1m5uQXKvhCr5XJox0Rle9D
LLNxElgY564B7eHVYQAsQGCA/Ufji6tNCyHV8XPLPhFyCY635juZoTh7Lb3G0ktJ
Xr8lJqhQsMV7PY08MlffYKY71+jGEnxO6HoxYdBsiyBfFSCQVRU4VyS4ixS2E6yb
n6XVT9b4SlsLIJwMRsaOagiAFcHnf642mRwUzB00Ee89hj3SfdU2gJVos8SNlc6p
MsfIlSLfKfrqAWc+8L8jE2LeLifuU/2P6LPOSZmBYpFMt5oFz7RxLiwiJgP/nkme
5yDi1UINg1qVGfFzZS7hlqMvWgPtqd3ob/8Wgq430BCWswCzp87QsyUf/QlV6mc3
ryQeZOK0udZ6+w8Rps3IUq/hCyZknsBe0Rbv0jxawCh3Z54opae48dnEIgxBsUUj
728/XxOUXvaS1501KgTAoEvONGmjAfIyLfF7LP3AY4C+GEYxeZ9kZDbC6L3vNi8b
ZMDhZyOOGjDiVlY6jn08
=Yn5X
-----END PGP SIGNATURE-----

--sHrvAb52M6C8blB9--
