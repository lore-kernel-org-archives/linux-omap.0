From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omap2/ompafb/omapfb-main.c: Delete if evaluating constant.
Date: Mon, 19 Nov 2012 13:14:45 +0200
Message-ID: <50AA14A5.8030600@ti.com>
References: <1353088261-27085-1-git-send-email-matthias.bgg@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE108BB6EA1AC2B78AA1D1725"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35242 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751584Ab2KSLOt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Nov 2012 06:14:49 -0500
In-Reply-To: <1353088261-27085-1-git-send-email-matthias.bgg@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthias Brugger <matthias.bgg@googlemail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>

--------------enigE108BB6EA1AC2B78AA1D1725
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-16 19:51, Matthias Brugger wrote:
> Variable r is never set to any value different to zero.
> Delete the if statement as it will never executed.
>=20
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  drivers/video/omap2/omapfb/omapfb-main.c |    4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/o=
map2/omapfb/omapfb-main.c
> index 16db158..85f9de0 100644
> --- a/drivers/video/omap2/omapfb/omapfb-main.c
> +++ b/drivers/video/omap2/omapfb/omapfb-main.c
> @@ -2411,7 +2411,6 @@ static int __init omapfb_probe(struct platform_de=
vice *pdev)
>  	fbdev->dev =3D &pdev->dev;
>  	platform_set_drvdata(pdev, fbdev);
> =20
> -	r =3D 0;
>  	fbdev->num_displays =3D 0;
>  	dssdev =3D NULL;
>  	for_each_dss_dev(dssdev) {
> @@ -2434,9 +2433,6 @@ static int __init omapfb_probe(struct platform_de=
vice *pdev)
>  			d->update_mode =3D OMAPFB_AUTO_UPDATE;
>  	}
> =20
> -	if (r)
> -		goto cleanup;
> -
>  	if (fbdev->num_displays =3D=3D 0) {
>  		dev_err(&pdev->dev, "no displays\n");
>  		r =3D -EINVAL;
>=20

Thanks, I'll apply to omapdss tree.

 Tomi



--------------enigE108BB6EA1AC2B78AA1D1725
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQqhSlAAoJEPo9qoy8lh71BFMP/2q15/zIkfdtanpvqvcTcFCE
y2cvB6qtXruN16npCe4TcsMZf++xohblTdVwEtKOuQwICzhLPTOG6Umx7yUlVyRk
FL9Jh/mEoWJXP5jxCUIAp15AA3TZPxdF6YWjuWbjR4LqmKJwCjVOnmmSsIG8Jcyp
Tp6mVWqAq8xcE1DiXOpVERlmBAqDFR6hMajqLUS5/ViD0TNwYSdfErwenc7wxVdG
of3owMizStDPup0+S2AjX/P4VcCnY28nHKqbmkwNimvkT6VfA2DVgtAM5Yj7ye46
vPYUP0gQFwGysiM66ZTZU8NmlEt+KUBbXvnTEpuh0GfJUkQN6JOH6M89NY7sI7Pf
t/SL95y+omoki3z0txr7pPqd5+c1ss2zxumIh45aFK9HEO/tyrh1Sw9lVusIAfE3
bduJ7mX5l7PFYrEzy84mELpW44LKaZudrLMjUcLQgC8Z/wWaDBeipeBjvODISHX1
neqCD20WUjfvsDc6WKm/FRlL+gMFc5/46OMD3Bm+Iayu/2uBdLLQ4RlEIe0mM+46
q5+yLz8HKjLP2n4OH3Xtw87LBB00c4DSOtFJNaMC0G/eQ1kZ12PZXkUhKLmHJNTa
pzc0FDOzjnSIXsIzn+uMN0iLVm9ghuBDsnuzefKcAtLtlOHP1vB4BXz+r7YgRhdj
Jtcw+gyeG+u9V8a7uXp3
=6gi3
-----END PGP SIGNATURE-----

--------------enigE108BB6EA1AC2B78AA1D1725--
