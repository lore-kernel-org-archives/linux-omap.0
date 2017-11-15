From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 06/16] mtd: onenand: omap2: Remove partitioning
 support from platform data
Date: Wed, 15 Nov 2017 15:57:47 +0100
Message-ID: <20171115145747.xlfndxz7dr5w5gsl@earth>
References: <20171111211206.465pgorrjp3eyix6@lenoch>
 <20171111212020.mmz5wjogbctsgxas@lenoch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4325151082233504267=="
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20171111212020.mmz5wjogbctsgxas@lenoch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org


--===============4325151082233504267==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mbgq4ov2xpht5wjo"
Content-Disposition: inline


--mbgq4ov2xpht5wjo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 11, 2017 at 10:20:20PM +0100, Ladislav Michl wrote:
> No platform data user setups partitioning informations, so remove.
>=20
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

>  Changes:
>  -v2: new patch
>  -v3: none
>  -v4: none
>=20
>  drivers/mtd/onenand/omap2.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
> index 93bd94337b35..883993bbe40b 100644
> --- a/drivers/mtd/onenand/omap2.c
> +++ b/drivers/mtd/onenand/omap2.c
> @@ -703,8 +703,7 @@ static int omap2_onenand_probe(struct platform_device=
 *pdev)
>  	if ((r =3D onenand_scan(&c->mtd, 1)) < 0)
>  		goto err_release_dma;
> =20
> -	r =3D mtd_device_register(&c->mtd, pdata ? pdata->parts : NULL,
> -				pdata ? pdata->nr_parts : 0);
> +	r =3D mtd_device_register(&c->mtd, NULL, 0);
>  	if (r)
>  		goto err_release_onenand;
> =20
> --=20
> 2.11.0
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--mbgq4ov2xpht5wjo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAloMVeMACgkQ2O7X88g7
+prtDxAAhhiiH19zQShSXWH/SFyP+jIxcUlPwnkrokZq/Mh4SUSsRz/gN3FwO4Ht
5q5GXG0G4CxDEPvGM+GWlAGA49W7EWakycFWy5vdRWd/Qkz9/2QOqq47KT7VzOR2
I4zO+q/PMcuNyy2apDBvskMHHEba6ZHzwH7Y8x3dbjMFpMae6uKeh8t0UnGuGpDN
aQ/AmOAFiOAjIc+CMorYx/aIPGaa9F8euoKAwgJjbxKBCbGbxnsF7/5gJzFu7ze9
4lDWfxcQ/6juGs5eMCIo8lvel8pC9I5ttPqZnlFwgkcXdOmxgM22iLvsGotO60rw
QyC00D95rkuUr0N3hpY6cgevOCAZAX4WgRgTpNMWacLm1kQTDgkRKi8IsiCkcaa1
wQ+g4T5u+ySwwiwKJ6vqWjjZSRVm4ZS+HyKtko5m/hCVl4Wm5gxY/Hn7dlVweo17
wmXcc9EIOR5SbKOW67ycbiFR0BDbLHGYyAhWV+zLIC0jdWrUciowepRqueLMa7xx
v8zILx+Kwdx6vtPsp8pGnzesiVwwuSbo0dpnBpsFiNaArFL3QSMsClGoRmKJ6VMj
YWNLJvA2ywdDqxcPh+8QdkH6VvKyE+PRojJiY8WdFg5ZLDMTeqsRCkVvbN4m0BaI
OpZauO8pcitIepxGdx/NkeaCttsFNbQ5/M0gKqS7mvj/4gdvd0I=
=8C4c
-----END PGP SIGNATURE-----

--mbgq4ov2xpht5wjo--


--===============4325151082233504267==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============4325151082233504267==--
