From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 05/16] mtd: onenand: omap2: Remove skip initial
 unlocking support
Date: Wed, 15 Nov 2017 15:16:23 +0100
Message-ID: <20171115141622.ayxzi7lkf2z5mlgv@earth>
References: <20171111211206.465pgorrjp3eyix6@lenoch>
 <20171111211942.643qupch2dnopz7i@lenoch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1970348058439108688=="
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20171111211942.643qupch2dnopz7i@lenoch>
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


--===============1970348058439108688==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lxhwjmr4facodley"
Content-Disposition: inline


--lxhwjmr4facodley
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 11, 2017 at 10:19:42PM +0100, Ladislav Michl wrote:
> No platform data user sets skip_initial_unlocking, so remove test
> for this field.
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
>  drivers/mtd/onenand/omap2.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
> index a03e1fe4aa48..93bd94337b35 100644
> --- a/drivers/mtd/onenand/omap2.c
> +++ b/drivers/mtd/onenand/omap2.c
> @@ -700,9 +700,6 @@ static int omap2_onenand_probe(struct platform_device=
 *pdev)
>  		}
>  	}
> =20
> -	if (pdata->skip_initial_unlocking)
> -		this->options |=3D ONENAND_SKIP_INITIAL_UNLOCKING;
> -
>  	if ((r =3D onenand_scan(&c->mtd, 1)) < 0)
>  		goto err_release_dma;
> =20
> --=20
> 2.11.0
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--lxhwjmr4facodley
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAloMTDYACgkQ2O7X88g7
+pps7Q/9EMaCadjiSHHtWATZ6c/WUBdT0BwJ0gCYUO5nHbA4gAkulrfJFkvpIhRj
du5PQA9X7HE8BclUUh4wTGmCqE6wu/yf5K+FRC+eg1lv3YJ2rzK0J0orCUnDaZLm
cGK37uUoJNpb7bActv4j6SyWZw6f3j+iVteS4ZKhmRWzQf5Ei+3xTM9w7aUUwxZ6
wr5KIGS6/2DIXBmQ2hIZ9nhAqCgJwLn4/6drW7wk3dmhMZLcBCuteu821Ra2Yg8r
AbOyGqLS1RKJoF59pISBs2bBaVK58XQZU3q/eeszjS5F/dTVbm0ogdz1R1wRoovL
I9Pz1qB/u1UNt3tTwX4kL4PyXHRlTRKlVxccwNg65PvA9o/1zIOmo2rD8+WnJ8wg
KRtP+uJMp+E7E0jg2KLsxn4RahNHtTDz9/EEF/qwRStUN9GVifd5V/o9sZ0REBDh
sxYrCcoA3P2sfE/gDJKHLn8cCG6zl9bFcKTvsSKg2Ab2fziaBkx+rGg/jMbRpl5P
kOsN5hWRF32g5D5/5MvfT7GoWk/99kgECD3A7KSzy7VXma0zPFgfP3yQRTv9OK/2
NrGcLAgHTkli70jpDYKqNyq6kS3ZuFhyZE6wPlMSRdfCS56fDdmiKRb7/l3c6FLB
zNRCDwzMc8J2FRjEbJh+XFO9uUMSpKLD1l47Awo/C1Q5Qm9/q6o=
=a9Wj
-----END PGP SIGNATURE-----

--lxhwjmr4facodley--


--===============1970348058439108688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============1970348058439108688==--
