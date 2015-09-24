From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omapdss: acx565akm: Fix module autoload for OF platform
 driver
Date: Thu, 24 Sep 2015 13:17:53 +0300
Message-ID: <5603CDD1.7030709@ti.com>
References: <20150918184457.GA32636@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gSjBk1NdLgRITD8KDgN9SRljUURVj2e8t"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150918184457.GA32636@goodgumbo.baconseed.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis de Bethencourt <luis@debethencourt.com>, linux-kernel@vger.kernel.org
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--gSjBk1NdLgRITD8KDgN9SRljUURVj2e8t
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 18/09/15 21:44, Luis de Bethencourt wrote:
> This platform driver has a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
>=20
> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
> ---
>=20
> Hello,
>=20
> This patch adds the missing MODULE_DEVICE_TABLE() for OF to export
> that information so modules have the correct aliases built-in and
> autoloading works correctly.
>=20
> A longer explanation by Javier Canillas can be found here:
> https://lkml.org/lkml/2015/7/30/519
>=20
> Thanks,
> Luis
>=20
>  drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565ak=
m.c b/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c
> index 90cbc4c..c581231 100644
> --- a/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c
> +++ b/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c
> @@ -898,6 +898,7 @@ static const struct of_device_id acx565akm_of_match=
[] =3D {
>  	{ .compatible =3D "omapdss,sony,acx565akm", },
>  	{},
>  };
> +MODULE_DEVICE_TABLE(of, acx565akm_of_match);
> =20
>  static struct spi_driver acx565akm_driver =3D {
>  	.driver =3D {
>=20

Thanks, queued for 4.3 fixes.

 Tomi



--gSjBk1NdLgRITD8KDgN9SRljUURVj2e8t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWA83RAAoJEPo9qoy8lh71bFwP/3hB/dtqYBeyG3DziQnnAM+x
dzNyyBZ68oJlhJ1kCCwwquI3qyB0/A8MYWkZb0xGy/seaaTCjruDR0rEwgahBZi7
riZ0zP3heqpb19FV6an0NlzU4XqT7vHeqhSXEeZOTiNJAoPdz6uqQ5kuQ+oaDFXv
n6J2XDiO95jzLg68luaNzUJgO2dNORvBQvSn21ySxgpPh6kQt0kQea7ClMsT9cVJ
Uskcr9NVTeS7cZwAtAixYi9zVQ+rMhUQVYkBAOtA71WYWrtGlp/WtOEHY0oH/JQA
cSR4NRLSgtCScKJo/j0AMcv98DIoLuYKNofVrgBHzjBWEEC7/TB1CKz99TlGMs0u
A2W43B/qL6jpkadQcMjnGs3zhWSkfwv5ihyIp6+Qx6AajXMJ6c+mNBSyvTXsl/uP
xzJ7iBClbheeF60/yZhZtw1Z58GOMElPUCggD1lIILERE9W/4WgsU0DYvS+g2WVu
2REBFzFN+750GLfpGVc8iy2tfq+qdNV9UU8463lYHL5j5dxqSLJ1pW9/jsnjQx5R
a0IfMOUCHpNkCjSM9OsJF+AKdrwcR0ebTCZ5E/4fMFNHtb/kj4EbYg0csPtRLZWe
AKFwm+yzbwBuPLlf6YEgvTuUVDgSg9raBRQLRN1w47ekuC2SHRZxizC1eh60u6TR
YGAH2C1VsenGWG2cct0Y
=61il
-----END PGP SIGNATURE-----

--gSjBk1NdLgRITD8KDgN9SRljUURVj2e8t--
