From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv6 24/24] i2c: omap: Prevent NULL pointer dereference in
 remove
Date: Wed, 15 Aug 2012 09:03:13 +0300
Message-ID: <20120815060312.GE23637@arwen.pp.htv.fi>
References: <1344953946-13005-1-git-send-email-shubhrajyoti@ti.com>
 <1344953946-13005-25-git-send-email-shubhrajyoti@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wtjvnLv0o8UUzur2"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1344953946-13005-25-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--wtjvnLv0o8UUzur2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 14, 2012 at 07:49:06PM +0530, Shubhrajyoti D wrote:
> Prevent the NULL pointer access by moving the platform_set_drvdata functi=
on
> after the access of the pdev.
>=20
> [  654.961761] Unable to handle kernel NULL pointer dereference at virtua=
l address 00000070
> [  654.970611] pgd =3D df254000
> [  654.973480] [00000070] *pgd=3D9f1da831, *pte=3D00000000, *ppte=3D00000=
000
> [  654.980163] Internal error: Oops: 17 [#1] SMP ARM
> [  654.985076] Modules linked in:
> [  654.988281] CPU: 1    Not tainted  (3.6.0-rc1-00031-ge547de1-dirty #33=
9)
> [  654.995330] PC is at omap_i2c_runtime_resume+0x8/0x148
> [  655.000732] LR is at omap_i2c_runtime_resume+0x8/0x148
>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-omap.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 3df6f92..49dbff1 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1217,8 +1217,6 @@ static int __devexit omap_i2c_remove(struct platfor=
m_device *pdev)
>  	struct omap_i2c_dev	*dev =3D platform_get_drvdata(pdev);
>  	int ret;
> =20
> -	platform_set_drvdata(pdev, NULL);
> -
>  	i2c_del_adapter(&dev->adapter);
>  	ret =3D pm_runtime_get_sync(&pdev->dev);
>  	if (IS_ERR_VALUE(ret))
> @@ -1227,6 +1225,8 @@ static int __devexit omap_i2c_remove(struct platfor=
m_device *pdev)
>  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
>  	pm_runtime_put(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> +	platform_set_drvdata(pdev, NULL);

in fact this platform_set_drvdata(pdev, NULL) can be removed. The
platform_device object will be destroyed anyway.

--=20
balbi

--wtjvnLv0o8UUzur2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQKzugAAoJEIaOsuA1yqREHL0P/0hHahS6hVMfFyUFDoEIiVAW
PE/DYICsfSWfSyAaUz55Z2Ofw7P6gPXT0uphLPTGxLEQFTQqF4bcB1AgeIc7L3E9
dowQ3l1dCHwKfxGXYxnRHbwTqXEyi+mCYMWzHIRSAlqInpKRNahNUBzE9oSkivv4
GWR/cpY4X/KbmUpAmoBUqExoKPyJvQOda5oJg0aE2EcS4MH+RA1v3u3xcD+WXWg4
dfLiaT3gjYlNt01pqBKBDNnB8be4pQgiGtnlU0SiCrhlT7YfgMq6Bf7lqndlcGq1
/iA8ToBeVxPXay+TsClQsHO/0vynuZq9Ixqd5CX7Ud/Cw1VAU8GMesczxMgrWUs8
2hifkofQ+S3SvAZB0wYLP3aPYOeViLa7iKEC/iSKRjATw5DT5+xRgzCGd/XqlzGo
jbH98w4JL4vj5YYeBZKAGI6cWWvMR6RmYhlWIksSOzEbfTp2zhzVN0wVnxf7smvy
SrR4R1++46ejOSt8IELQcp1WpoRD2s/Fo7j3BX1sFaBV5Hx6WsUjxlnsveXpx8h0
gLmdFcxe0eoJkfGOvjSgnHs+YLylkE9IvCqW9mRnv5tEZ1fpj2IqP/M4Zc0PdJtB
gSU5+Yek3ZVz0csd4mKVuc8Fk7MWKofVjGiiKNnh07/xs6mEpVGtY3V0TOZNqITd
z0iFVOKDGSUQ2zgqApVQ
=jYV2
-----END PGP SIGNATURE-----

--wtjvnLv0o8UUzur2--
