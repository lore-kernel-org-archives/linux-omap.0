From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 28/38] video/omap: remove invalid check
Date: Thu, 24 Sep 2015 13:48:26 +0300
Message-ID: <5603D4FA.6090902@ti.com>
References: <1442842450-29769-1-git-send-email-a.hajda@samsung.com>
 <1442842450-29769-29-git-send-email-a.hajda@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TjcseAN8aoABfW2jeNbP8f6qKS3goarBU"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442842450-29769-29-git-send-email-a.hajda@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrzej Hajda <a.hajda@samsung.com>, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--TjcseAN8aoABfW2jeNbP8f6qKS3goarBU
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 21/09/15 16:34, Andrzej Hajda wrote:
> regno is unsigned so it cannot be negative.
>=20
> The problem has been detected using proposed semantic patch
> scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci [1].
>=20
> [1]: http://permalink.gmane.org/gmane.linux.kernel/2038576
>=20
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  drivers/video/fbdev/omap/omapfb_main.c | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbd=
ev/omap/omapfb_main.c
> index 1fb3ea3..393ae1b 100644
> --- a/drivers/video/fbdev/omap/omapfb_main.c
> +++ b/drivers/video/fbdev/omap/omapfb_main.c
> @@ -276,11 +276,6 @@ static int _setcolreg(struct fb_info *info, u_int =
regno, u_int red, u_int green,
>  		if (r !=3D 0)
>  			break;
> =20
> -		if (regno < 0) {
> -			r =3D -EINVAL;
> -			break;
> -		}
> -
>  		if (regno < 16) {
>  			u16 pal;
>  			pal =3D ((red >> (16 - var->red.length)) <<
>=20

Thanks, queued for 4.4.

 Tomi


--TjcseAN8aoABfW2jeNbP8f6qKS3goarBU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWA9T6AAoJEPo9qoy8lh71ds0P/Ailyi1GRoAfYOl2NTG7fgqm
8yHXC2YzOl1SR+KXhfqf0h+YauQvtsIKMcIzPLt/0zopfhVuZDGOxD2gayoaVCK7
SGG5gt0Kn0VXdMd8kawrPRploC+HS4hWj/6MO5sSD6A2DgQvHQxDTrKnrBLuQrH8
1QS/Km4BwTeb+RsWbb8XNBod2/NUbbxYsf2XoiPfTgCwMGqAM9Im8aViVzCiVyRU
d/c0HLWKuWvCWGjZli5xxHSKWTMjZ3qgiwgKlNv3Tv5xCnieHxvg2MAsAFxPc+V5
tlN8FbHPcZQ8J4T0GN/C32lJxaB2KNflsWkW4C38T/RzELtA8NToZDXrMWJ82gQ8
1vqIoRIZimtA+P60+vY10D3EkUDK4voferNeZSuQiQ1vzuJLFdYnRtVbWNRQ/W1k
OLiqAX1zADUAic49+dMV+LFysNNMeEWgNgmysYmHX9np40BncH+ycQVp1Pr7J1OV
aODenft59bTZNwWJctXGUpN3HOgsJO/Pl6aCnJBfz5vXy/EZFm7BWo9303ftI6CF
lngitJkKEUj7RL8DcBpcOsyQqDrPQbAuEgwiYtzQbaftgwmyhtK2SF08zpH1H4FV
C1ooA160VsZH67obk+yLG6a9SnVyzoRJpD+N4ThvNDPRLVb8cUVBc9sKSGxqDiJE
v+/hz5vMfFym/Vw4ZOOv
=D5eW
-----END PGP SIGNATURE-----

--TjcseAN8aoABfW2jeNbP8f6qKS3goarBU--
