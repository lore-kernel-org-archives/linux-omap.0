From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4 4/4] USB: OMAP1: Tahvo USB transceiver driver
Date: Fri, 6 Dec 2013 14:46:29 -0600
Message-ID: <20131206204629.GL21086@saruman.home>
References: <1386339187-28466-1-git-send-email-aaro.koskinen@iki.fi>
 <1386339187-28466-5-git-send-email-aaro.koskinen@iki.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QWRRbczYj8mXuejp"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48397 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751894Ab3LFUrn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Dec 2013 15:47:43 -0500
Content-Disposition: inline
In-Reply-To: <1386339187-28466-5-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--QWRRbczYj8mXuejp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2013 at 04:13:07PM +0200, Aaro Koskinen wrote:
> Add Tahvo USB transceiver driver.
>=20
> Based on old code from linux-omap tree. The original driver was written
> by Juha Yrj=C3=B6l=C3=A4, Tony Lindgren, and Timo Ter=C3=A4s.
>=20
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

compile error:


  CC [M]  drivers/usb/phy/phy-tahvo.o
drivers/usb/phy/phy-tahvo.c: In function =E2=80=98tahvo_usb_probe=E2=80=99:
drivers/usb/phy/phy-tahvo.c:371:2: error: too many arguments to function =
=E2=80=98extcon_dev_register=E2=80=99
  ret =3D extcon_dev_register(&tu->extcon, &pdev->dev);
  ^
In file included from drivers/usb/phy/phy-tahvo.c:26:0:
include/linux/extcon.h:186:12: note: declared here
 extern int extcon_dev_register(struct extcon_dev *edev);
            ^
make[1]: *** [drivers/usb/phy/phy-tahvo.o] Error 1
make: *** [drivers/usb/phy/] Error 2

fixed it up with:

diff --git a/drivers/usb/phy/phy-tahvo.c b/drivers/usb/phy/phy-tahvo.c
index 7cf1766..8bb833e 100644
--- a/drivers/usb/phy/phy-tahvo.c
+++ b/drivers/usb/phy/phy-tahvo.c
@@ -368,7 +368,9 @@ static int tahvo_usb_probe(struct platform_device *pdev)
=20
 	tu->extcon.name =3D DRIVER_NAME;
 	tu->extcon.supported_cable =3D tahvo_cable;
-	ret =3D extcon_dev_register(&tu->extcon, &pdev->dev);
+	tu->extcon.dev.parent =3D &pdev->dev;
+
+	ret =3D extcon_dev_register(&tu->extcon);
 	if (ret) {
 		dev_err(&pdev->dev, "could not register extcon device: %d\n",
 			ret);

please make sure it still works with v3.13-rc2 + this patch.

--=20
balbi

--QWRRbczYj8mXuejp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSojelAAoJEIaOsuA1yqRE5zIP/0cIbcjF1gyCIilSAjkTCvv8
2ysi92ZSruVHGGofh00K2n2DKqPFR9CpTeNa1UIK42BlSzrBrpiJeI6vtYF8pNEE
X23mY4ACJ4YxGHHOyBot0JikcEpLJYLUs+he5moTllxNAHrpVf3k6IsJGKoNZ0FL
USQirHjj7Zyb7tDmX0ZGRDH9ILqUppfe751FAI3Qk05z2FtMLoxRtzDqSSSvpGdg
WpcDS+K/lQpIhTHzKSq7SJ5OdDJ5DB6joAQ1gpU1i0cEYIxi2rx82bD0iRVBQ9Vr
MxPsHF7zA4Q3JlgE/CGm9HkXqqfw4/VERUyaiWmG4jhsGJKZw0Yj/TVoHFC+1OSx
K8301uYN7kHxBXXjz19gCsPY50oCamRGIDsic/ZxdNiCkCfb7kuqSEO5VZcrkY+H
Mu8YkcrmQzE03gqh1KtfFTnDzX6IS/0Aek4Nj3ytjqzsXkMdthl6HF8LJp/MJ03f
ecID4ZGOARS9Pa9RoG0CXPfIiYCdm8AEQalWSrCjKXvETqsIr0oWbio5foBxPwC+
B27ykW0yTy8zGCbx5knfCbLKC3YnYMs1MhHdL+Aaf0iPd16yrJbNfb8kcw4ho7VC
QoBhHFzdYmAEbqbbmvzGA7OFIWG7GZ+6Zi0GG9ha5CPHxz7r2Mu7gnrZatuYSvIF
/8qQAzgsYBal7mmxkMpD
=i12t
-----END PGP SIGNATURE-----

--QWRRbczYj8mXuejp--
