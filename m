From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv3 06/17] i2c: omap: split out [XR]DR and [XR]RDY
Date: Mon, 2 Jul 2012 14:56:20 +0300
Message-ID: <20120702115620.GD2730@arwen.pp.htv.fi>
References: <1340964817-8599-1-git-send-email-shubhrajyoti@ti.com>
 <1340964817-8599-7-git-send-email-shubhrajyoti@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1340964817-8599-7-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 29, 2012 at 03:43:26PM +0530, Shubhrajyoti D wrote:
> From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>=20
> While they do pretty much the same thing, there
> are a few peculiarities. Specially WRT erratas,
> it's best to split those out and re-factor the
> read/write loop to another function which both
> cases call.
>=20
> This last part will be done on another patch.
>=20
> While at that, also avoid an unncessary register
> read since dev->fifo_len will always contain the
> correct amount of data to be transferred.

this statement isn't valid anymore, but I'd like it to be. See below

> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-omap.c |  126 ++++++++++++++++++++++++++++++-----=
-----
>  1 files changed, 94 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 359ee08..45bd731 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -820,36 +820,64 @@ complete:
>  			return IRQ_HANDLED;
>  		}
> =20
> -		if (stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR)) {
> +		if (stat & OMAP_I2C_STAT_RDR) {
>  			u8 num_bytes =3D 1;
> =20
> +			if (dev->fifo_size)
> +				num_bytes =3D (omap_i2c_read_reg(dev,
> +						OMAP_I2C_BUFSTAT_REG) >> 8)
> +						& 0x3F;

I wanted to avoid reading registers if we don't have to. This value will
be sitting in dev->buf_len.

--=20
balbi

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP8YxkAAoJEIaOsuA1yqREF5sQAJUFfEj1yEwxGviE7ZLdd1mx
R4MtndOAx638q4lCHaSoUrSIWpCkpfC3Ll6TiaQ6ag6yYZXanjQp7cp/JvoQAS6n
Gmjizx/8cNhA3Ug2qsJen/kqE1FDYg+UlWv3gWTdp3jG9YLLQHkUoghEW/aldaZj
n7hHE9mVm07zDyXuPwXtUTKpwtTPEGmtoBXZaet72Be1ziwYKXTYQTy83ilH0JtZ
rISvn2Cq/Okx6/d4LPli8LYusqOFFp3Ys1AAVdm8k0M2CppTtWMHJwiyZNU+HGsy
qOw/sc86WTioLeJoP7oeYmpjAz0l57/xsyc4yIu6qr+GU7FaYkOnolaoEfKMj70K
c7b74UocqN+XVR/RgvaU6FBkZMHtDzrwqdzgCKASdfg44p1uSWegaMDq0c3bdV/A
pjMfvc6EaOoydqAvAccVppQ0V1MutDgC418Nx1T7h9ilzwiRc+t0nCmgvhI/6c+t
M3kGlWfYKqqAdrl9W8Zr3RdwTU5RA/9bWPMYZ5Bnwqmlw9wlFfHIs9LhzVkv+Pjp
punBX/Zf4FmhRvLsdsTAR+tpgiB7R+8kfBt+ZyQtd8B8MXHLzdfU1kqUaEtM4iHh
LHKehh4JteLRDa/TKRdobn37TwneXjlLn7Jb2dm1/53dK3Lh/J2O2JKMGDLBRwhQ
xwm5fDmWYGdAyHfFKfMW
=cIPZ
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--
