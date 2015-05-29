From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: dts: Fix dm816x to use right compatible flag for
 MUSB
Date: Fri, 29 May 2015 11:31:55 -0500
Message-ID: <20150529163127.GG2026@saruman.tx.rr.com>
References: <1432916828-13171-1-git-send-email-tony@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xQmOcGOVkeO43v2v"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43924 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755331AbbE2Qe2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 May 2015 12:34:28 -0400
Content-Disposition: inline
In-Reply-To: <1432916828-13171-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bin Liu <binmlist@gmail.com>, Brian Hutchinson <b.hutchman@gmail.com>, Felipe Balbi <balbi@ti.com>

--xQmOcGOVkeO43v2v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 09:27:08AM -0700, Tony Lindgren wrote:
> With commit 3e457371f436 ("usb: musb: Fix fifo reads for dm816x with
> musb_dsps") we need to use the right compatible flag to avoid issues
> with FIFO reads.
>=20
> Cc: Bin Liu <binmlist@gmail.com>
> Cc: Brian Hutchinson <b.hutchman@gmail.com>
> Cc: George Cherian <george.cherian@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Fixes: 3e457371f436 ("usb: musb: Fix fifo reads for dm816x with musb_dsps=
")

Acked-by: Felipe Balbi <balbi@ti.com>

> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/boot/dts/dm816x.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
> index de8427b..289806a 100644
> --- a/arch/arm/boot/dts/dm816x.dtsi
> +++ b/arch/arm/boot/dts/dm816x.dtsi
> @@ -382,7 +382,7 @@
>  			ti,hwmods =3D "usb_otg_hs";
> =20
>  			usb0: usb@47401000 {
> -				compatible =3D "ti,musb-am33xx";
> +				compatible =3D "ti,musb-dm816";
>  				reg =3D <0x47401400 0x400
>  				       0x47401000 0x200>;
>  				reg-names =3D "mc", "control";
> @@ -422,7 +422,7 @@
>  			};
> =20
>  			usb1: usb@47401800 {
> -				compatible =3D "ti,musb-am33xx";
> +				compatible =3D "ti,musb-dm816";
>  				reg =3D <0x47401c00 0x400
>  				       0x47401800 0x200>;
>  				reg-names =3D "mc", "control";
> --=20
> 2.1.4
>=20

--=20
balbi

--xQmOcGOVkeO43v2v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVaJR7AAoJEIaOsuA1yqREBKsP/0nTv5WFMhLJxp1BKfQh6XMy
y/LI6mcQyT32a1rPfRsCXKkFQJvz4sFaSbgwJtAEhAkzKLz9ZU3qLw6BERSHFzKo
wfPf7uN0TNHC4SI921ED6Eo9ZVyYivKsl1gT67EnKS8e6pvOJwQbpZx1CtwiscFm
QtDv143EQWstzwan8qsKZb56ZdsJ2XZSB44lS4VHFOT7318zr9ZCuBz3W4ntwD15
faLL41UD3cSzNmIzBx8F1a3sl9TXJScTPmNpFVAoC/hmsMjdze89SF6MH/N5UXjR
hbTJzbAVuD6rErF87Z+O+MpQtslEc85t0eQoRrqBqBjOE0t2ghCKooRaocyUDG1H
qfgXWAS8rPkknhZpwynpET3JBs9oTfDVYLR6xvkbmQBg8/ad0k+xKVutA2ZnVSmu
dv07GEb5zGlXRG6iGKlZMbRGqQXIUREYGPvb6uPSXlseCLmqeGbUdhFJruzS6xQk
Uu2/0NATkwyUTVaIopbmISW+bFE4xD8y5u1VswRDDRHDnNtnm1mJb45oUmepmTd9
l3OIxhZsucMxWU8KMnqCN6GzPEtN4/6TgfcIpvGWoLXt809edZrLmj3AZoHToN8J
lvH2ivgFojcX9rNoqm4+PzOwHY/W6ujH9e8ajzJ+W/Uekh2ZOD9b0MTikg7T5dI9
SkURV6Q7+isnJucflAg5
=DgIR
-----END PGP SIGNATURE-----

--xQmOcGOVkeO43v2v--
