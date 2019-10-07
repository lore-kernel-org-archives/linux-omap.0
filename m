From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] drm: panels: fix spi aliases of former omap panels
Date: Mon, 7 Oct 2019 19:04:46 +0200
Message-ID: <20191007170446.yotb24s6jhe6nx3r@earth.universe>
References: <20191007164130.31534-1-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iql274jatv4mpjov"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191007164130.31534-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, omi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Tony Lindgren <tony@atomide.com>, Jyri Sarha <jsarha@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--iql274jatv4mpjov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 07, 2019 at 06:41:30PM +0200, Andreas Kemnade wrote:
> When the panels were moved from omap/displays/ to panel/
> omapdss prefix was stripped, which cause spi modalias
> to not contain the vendor-prefix anymore.
>=20
> so we had e.g. in former times:
> compatible=3Domapdss,tpo,td028ttec1 -> modalias=3Dspi:tpo,td028ttec1
> now:
> compatible=3Dtpo,td028ttec1 -> modalias=3Dspi:td028ttec1
>=20
> This is consistent with other drivers. Tested the td028ttec.c
> only, but the pattern looks the same for the other ones.
>=20
> Fixes: 45f16c82db7e8 ("drm/omap: displays: Remove unused panel drivers")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---

Patch looks good to me, but you have one false positive.

> [...]
>
> diff --git a/drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c b/drivers/gp=
u/drm/panel/panel-sharp-ls037v7dw01.c
> index 46cd9a2501298..838d39a263f53 100644
> --- a/drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c
> +++ b/drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c
> @@ -204,7 +204,7 @@ static int ls037v7dw01_remove(struct platform_device =
*pdev)
>  }
> =20
>  static const struct of_device_id ls037v7dw01_of_match[] =3D {
> -	{ .compatible =3D "sharp,ls037v7dw01", },
> +	{ .compatible =3D "ls037v7dw01", },
>  	{ /* sentinel */ },
>  };
> =20

The DT compatible should have a vendor prefix.

> [...]

-- Sebastian

--iql274jatv4mpjov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2bcCsACgkQ2O7X88g7
+pqKSQ/9HclHNhGRa3L+55z5K08PEFcrfqZTjrhBUnQW/JOnaun8CyHC229w9gfF
cZ8Z3E0HY6xKlIFHP6K3kjdjcPghU58QXAhneBIf8zr0OiChnuleAe3gZ89WAB8f
Zy/PCAj+tNLWaUzhlwYe0VW+IXkDbXrF5VCkwUIs96QFNAduLraco7wMxpnl1Kcl
FQScSqD7wEXQD55dqnJwEVrYfi1C3JjdrtTPXTAZj3mBcpKekYLQ0JzVAx7JqpwQ
PkRXYjCrVwQ7VfO0gXkqxEjXucK+K/gN6dcIz0wj6Evrl+Pj0e3GKl8RPzWZnk0h
dAtJ/HXclZyh+qlQKLj0dmFuVHebBlWaLO30Kl4WiuKsGXAq2NfpXS9+Nq4ZaRXM
X/pH730gVRGvA6/nlPkkkHoqL/0p2/APW40uPBdzUoKCWpOUGoFbG1rknKfVR7Ug
MNCpJXPv7Jgu9U7pd/mkmlLE08Yu76tshniFFZPz8kzkrkkRwrxIimO/65VTIrFr
hpzDkZPD8DLDb2q287r7UwL3zgccP85jMrPj+l+XPyhZTErWk6HTadm+JRqAWSX3
c1Bh47Pb3PPdxSoOp6tddkbeYWutsufe9CA+lXG46tH8X0VKYQ7KtIj+BzclQLkd
NbbAU4Ja6+mExXInkjgnjB1DGIZ/qSZF9TtwmbZUS6Pe5Rp3NEA=
=vfl2
-----END PGP SIGNATURE-----

--iql274jatv4mpjov--
