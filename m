From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] drm/omap: dsi: Fix missing of_platform_depopulate()
Date: Thu, 8 Nov 2018 18:29:33 +0100
Message-ID: <20181108172933.ijqwhnigna4gwewk@earth.universe>
References: <20181106152802.38599-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1851082209=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181106152802.38599-1-tony@atomide.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org


--===============1851082209==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="44jx6lj3x4zynxro"
Content-Disposition: inline


--44jx6lj3x4zynxro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 06, 2018 at 07:28:02AM -0800, Tony Lindgren wrote:
> We're missing a call to of_platform_depopulate() on errors for dsi.
> Looks like dss is already doing this.
>=20
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/gpu/drm/omapdrm/dss/dsi.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/=
dss/dsi.c
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> @@ -5429,15 +5429,19 @@ static int dsi_probe(struct platform_device *pdev)
>  	}
> =20
>  	r =3D of_platform_populate(dev->of_node, NULL, NULL, dev);
> -	if (r)
> +	if (r) {
>  		DSSERR("Failed to populate DSI child devices: %d\n", r);
> +		goto err_uninit_output;
> +	}
> =20
>  	r =3D component_add(&pdev->dev, &dsi_component_ops);
>  	if (r)
> -		goto err_uninit_output;
> +		goto err_of_depopulate;
> =20
>  	return 0;
> =20
> +err_of_depopulate:
> +	of_platform_depopulate(dev);
>  err_uninit_output:
>  	dsi_uninit_output(dsi);
>  err_pm_disable:
> --=20
> 2.19.1

--44jx6lj3x4zynxro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvkcncACgkQ2O7X88g7
+pph7w/9GHaLI8a4TLr13bUtGCG8kcoIn1jZhm6oYWSoqifP7PCFNf6miceNx2Jx
LyEYMZPBdkQG0z2w+xomWWUjdUu38sbHlWmM/xB/bBtUFH3BV3X2y90leJzoEG/D
fgQR/MjUay+aKuPAEvbefSATZE+ypRSLZTtswLaX+BMDIN8FctGrwU+NeiCizrCy
Lr/XjGiWFiaODrqXkWH1FAfU6iUlPCVVhydhF8rgQKop4GDli36TOJKT2yleoc2g
LdQtMUB/5jNExku0kLU6MG0MSdAZB94r2msNns8mm2BhU8luDtLYwOUKIt5WGXtJ
k4+Z7LThBKrLq3aiy2EHEBWdjp+60KkUbTqW/UwGAt9ve/LUBUm/3cMG0jvBuJzZ
9mzgusVXJZKFGnaBwplg5TBQYzpbOHan97eZVO8zOTgW+42oCugR6/YauvjFBTLF
n694lxXOfKmTUJeYL8uT9tY3yziI04Mrm4V9qFqiP9VGpeePoulSvnZnT6P7ZhQ3
w961naR3hTiT2+r3KtmlLwN3sk+5HZDEO55NhiPtH3027j5D+hkdPZG/4O6i6KgR
LKopMsC3aQPJUOye7sHJ2hkrn23yulVWOv2Q5qHhSlWWOLjn0Q5JsnQuYKS9YOZb
h6U6x/c/16Lwf3xUExlCX8f2St3yBRpHvlACuzcwl9/DzpjYo0Y=
=pX0h
-----END PGP SIGNATURE-----

--44jx6lj3x4zynxro--

--===============1851082209==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1851082209==--
