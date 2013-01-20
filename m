From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: errata i462: fix incorrect ack for
 arbitration lost interrupt
Date: Sun, 20 Jan 2013 11:19:17 +0200
Message-ID: <20130120091917.GA16066@arwen.pp.htv.fi>
References: <1358641978-9316-1-git-send-email-aaro.koskinen@iki.fi>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1358641978-9316-1-git-send-email-aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 20, 2013 at 02:32:58AM +0200, Aaro Koskinen wrote:
> The errata handling function acks wrong interrupt in case of "Arbitration
> lost". Fix it.
>=20
> Discovered during code review, the real impact of the bug is unknown.
>=20
> Signed-off-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>

thanks for sending this

Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

> ---
>  drivers/i2c/busses/i2c-omap.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 20d41bf..832f16e 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -803,7 +803,7 @@ static int errata_omap3_i462(struct omap_i2c_dev *dev)
>  			if (stat & OMAP_I2C_STAT_AL) {
>  				dev_err(dev->dev, "Arbitration lost\n");
>  				dev->cmd_err |=3D OMAP_I2C_STAT_AL;
> -				omap_i2c_ack_stat(dev, OMAP_I2C_STAT_NACK);
> +				omap_i2c_ack_stat(dev, OMAP_I2C_STAT_AL);
>  			}
> =20
>  			return -EIO;
> --=20
> 1.7.10.4
>=20

--=20
balbi

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ+7aVAAoJEIaOsuA1yqREsUUP/15IfwPOiKvTADH4OnCwsuWR
Y14RepO16V9RvS/C94W2flu8qBXeI0KaOMl/9UO7Wx26/x6MCrOnsxm3jMb6cyhh
ERtZSjnQDKmlB0wjkknNKuKBTVSnpYr4xA9O8hyaXYv5IXiE70C72l1NKKEoXj4u
2cfUhWBG166n7aW2zyi0WKBR0V0PbMx377BDieoz2MlQBh5GaTUvALWYEm+yb9XP
ukd5H44toTZZM1FvpKakLeyJVMhizg7kgmnZhvQucl7/wxYRlSW/NpJw+0+xIE+N
4L9/xmXeR+krLPAg9IPa2RDLSys/Y4lMAB8LxINEvaNQytNH0PwS7sic+b8ZWM+Z
nIbdEGOCT17yvV5CDA7LGm/RcDXBSQFuSJerr+A72qNZyV2L85/U3REXVE6YJ4C0
pCE1Mtec1LeIlaAG6+P8E2rtPZ4pIt5kzEln8juUk8PwL9zYzGMoadzGVQoDVtvm
B8T+Z4vTTn+jVd+HjLR2nH6Kz3/MVHo/HnL7QHoyIJ0VCorWObe6bSyIcNFFQPOc
vCibTia82zCMs0ak00bvlbf06cTCM3pbdlC3LdWq4LwV2s3eBhqTziqKl1eFdBFH
jVez/vP6D0znDXRVV9X/2BVhDY7tzrpdcF/gh/m1Wad50BwFQQj0Gg7tM2lauLmp
hiDEXttFCHJ8p2VUbp2V
=RPWC
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
