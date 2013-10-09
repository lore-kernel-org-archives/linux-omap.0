From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 2/2] ARM: OMAP: igep0020: use display init from dss-common
Date: Wed, 9 Oct 2013 12:27:13 +0300
Message-ID: <52552171.6050002@ti.com>
References: <1381310359-20668-1-git-send-email-javier.martinez@collabora.co.uk> <1381310359-20668-3-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="cHihXmsdoM4Cjhhp8LIdt4AI70JA76RBw"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44779 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536Ab3JIJ1b (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Oct 2013 05:27:31 -0400
In-Reply-To: <1381310359-20668-3-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Tony Lindgren <tony@atomide.com>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org

--cHihXmsdoM4Cjhhp8LIdt4AI70JA76RBw
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/10/13 12:19, Javier Martinez Canillas wrote:
> Now that display information and setup is made from dss-common
> there is no need to have this code in the board file.
>=20
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.u=
k>
> ---
>=20
> Changes since v2:
>  - None, this is a new patch added for v3.
>=20
>  arch/arm/mach-omap2/board-igep0020.c | 41 +++-------------------------=
--------
>  1 file changed, 3 insertions(+), 38 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2=
/board-igep0020.c
> index 06dbb2d..d648d50 100644
> --- a/arch/arm/mach-omap2/board-igep0020.c
> +++ b/arch/arm/mach-omap2/board-igep0020.c
> @@ -43,6 +43,7 @@
>  #include "board-flash.h"
>  #include "control.h"
>  #include "gpmc-onenand.h"
> +#include "dss-common.h"

I didn't try, but I think these can be now removed from the board file:

#include <video/omapdss.h>
#include <video/omap-panel-data.h>

For the series:

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi



--cHihXmsdoM4Cjhhp8LIdt4AI70JA76RBw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSVSFxAAoJEPo9qoy8lh715wYP/2y3nUCKM7JsdmjF06GIo35r
EpS2ppR+tlxsjIDVeX87I7mclGwniNra4m1UQxtQTfSSKEIzj3+Ll5t5hFWB0Cv1
6ry8Nugizymryi3DDlHZ/cHLYEzz+QO4N+36wB/HX3moduA+nWEd9mu7Lp5yXnSf
9ZP4WStMP+219VM64QPuoXzgc59M0G1r86O8DP6uqzqgS/4HPTd77WZVrENo4kdB
7iDBUAJZhmg20vAOjwB/lQM5yjTXzBu6WGbh7/cUuxZuWWnu1/0vH59tDOVQ+Ax2
VaFXkZBpNEaUmgCu31xEUaLv1JBQenazvtZcGgbW8dYw31upYJUqkNkAB05NiKCR
yjWlvZotd3RxU2F+bSlgOkI4LyHesWLJRDKQ7064GkOqgUNUKgYmEVZjbT+LRHuB
TkH7X6bL6NQyEwqtQUGsdFj42cXqommv73NqCyD9bbg22weX1e+8de0/C/8p8R0l
gbn76lf7ozXRWVdVkFJot16LfzHw0ID9SUcFCjlcxLLaJa6xyGfIEpVIkgho5k7J
xzkqZPSA71xfvQKtroi8TYX93Qia6D7X0bXJyHyByfYpFlf1HhCaVJdyCd8ysL+l
63hWmatgtZpxmj4W/GHQK3mOAF7RzxlNg5K6VpTA/rn8qbbfbBYC0MwCqdrsRCC/
LjWKRV9NjQdhzDsYOrS9
=UQFC
-----END PGP SIGNATURE-----

--cHihXmsdoM4Cjhhp8LIdt4AI70JA76RBw--
