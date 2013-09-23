From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/4] usb: musb: am35x: use SIMPLE_DEV_PM_OPS
Date: Mon, 23 Sep 2013 16:20:09 -0500
Message-ID: <20130923212009.GK309@radagast>
References: <1379850421-7966-1-git-send-email-zonque@gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WuedheRyq6FDfQ9j"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45374 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752125Ab3IWVUR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Sep 2013 17:20:17 -0400
Content-Disposition: inline
In-Reply-To: <1379850421-7966-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-ubs@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org

--WuedheRyq6FDfQ9j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Sep 22, 2013 at 01:46:58PM +0200, Daniel Mack wrote:
> This makes am35x_pm_ops const.
>=20
> Also, checkpatch.pl complains about the use of DEV_PM_OPS:
>=20
>   ERROR: Macros with complex values should be enclosed in parenthesis
>=20
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  drivers/usb/musb/am35x.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
> index 5c310c6..df32a29 100644
> --- a/drivers/usb/musb/am35x.c
> +++ b/drivers/usb/musb/am35x.c
> @@ -616,12 +616,9 @@ static int am35x_resume(struct device *dev)
>  	return 0;
>  }
> =20
> -static struct dev_pm_ops am35x_pm_ops =3D {
> -	.suspend	=3D am35x_suspend,
> -	.resume		=3D am35x_resume,
> -};
> +static SIMPLE_DEV_PM_OPS(am35x_pm_ops, am35x_suspend, am35x_resume);

you could as well remove the DEV_PM_OPS trickery. Ditto for all other
patches

--=20
balbi

--WuedheRyq6FDfQ9j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSQLCJAAoJEIaOsuA1yqREQDkP+wQbLNC511KDIm34gz02Z0UY
701qUpQPDPzW6qtcatLMFdjGnbeGgVrYaUKVP/dK5Wiuq/7T+hG+Eko5n7mvnhmc
QVO6TXxdQvo3xRDn1tVAyI1LTmKYfN6KocwqtDfX03ZqUi5ZsQXjZz7myuh6lcwH
qO+8bRqr8y4FXYZPdoY1/2/OOk2vGcCBFdXXigZqmYwIK1jztrLmWbRtMjICNP95
gB6S10z1IGCnCnn00KGxo657jpbTb4tMD7Qlj/nyeLVTMzFZGzGz60hBV89wK1gT
+fn2LsUku6NfxW/Ah/yEapQ/+AU5zFn4qkMbCB7M9GIVrEsZE+qD6copmp2jIGzW
k02uja3HRau3W5f821hiJ4NQ+br3+fkmGvLrbkU/e0h5BCDMgIuQ8sF8gQZS+Jzh
tR+83fbiSXgteqykUILvn0GljvU4gkLWnqYJrnDIQILh3nEzdUMH78rIYoX2Ip8y
vK81wVwzGBawTk5tpM/E90Ve0y5BEX6qJMd72Y3vlBGqu6rlRbdUEet2U8sXafrv
50lWjWQy07D2EmN5cnHb2LL1a5PBMqQCwGBKyczu0mtWejWFjypKDssBmVidKnDU
OhtaZCdroImE+4k7clzOkDiP78Qbm76FfMS+dk3aQVXPq9TIK2YKi8iBjyx7cuWK
pf2nKfVRlaSvD7Ut7iiK
=ql7s
-----END PGP SIGNATURE-----

--WuedheRyq6FDfQ9j--
