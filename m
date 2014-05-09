From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC 1/6] omapdss: remove check for simpler port/endpoint binding
Date: Fri, 9 May 2014 12:59:53 +0300
Message-ID: <536CA719.1080707@ti.com>
References: <1399540517-17883-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="68AKOKdso9DUxdsPM0RS1pDkpldSMaERp"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50089 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753422AbaEIJ74 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 05:59:56 -0400
In-Reply-To: <1399540517-17883-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

--68AKOKdso9DUxdsPM0RS1pDkpldSMaERp
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/05/14 12:15, Archit Taneja wrote:
> The support for simpler port/endpoint binding was removed in the merged=
 version
> of omapdss DT. But dss_init_ports still tries to get to an endpoint eve=
n if no
> port exists. Remove this as this doesn't work.
>=20
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/video/fbdev/omap2/dss/dss.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/=
omap2/dss/dss.c
> index d55266c..31ef262 100644
> --- a/drivers/video/fbdev/omap2/dss/dss.c
> +++ b/drivers/video/fbdev/omap2/dss/dss.c
> @@ -784,12 +784,8 @@ static int __init dss_init_ports(struct platform_d=
evice *pdev)
>  		return 0;
> =20
>  	port =3D omapdss_of_get_next_port(parent, NULL);
> -	if (!port) {
> -#ifdef CONFIG_OMAP2_DSS_DPI
> -		dpi_init_port(pdev, parent);
> -#endif
> +	if (!port)
>  		return 0;
> -	}
> =20
>  	do {
>  		u32 reg;
>=20

I'll try to find time to review the rest, but I'll queue this one
already for 3.16.

 Tomi



--68AKOKdso9DUxdsPM0RS1pDkpldSMaERp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTbKcZAAoJEPo9qoy8lh71xioP/RH56IT2oH6sqCqR95iPMq0e
Ko7eaLSMxgLXSFtV1rHCc0hNIaelnTOtZvJX54jWNsKgjWOTgDhot8Nefx/hs4wN
Wp79jBqC252+bvm8uk3bTunBII0aPMuIhEPH1psTVlVb5Ins8fb258YQKaOj0+nl
HwgPuNYzlBXXfPNy9q7glFxsNAGUak2OIgqKit2gjnQJ5N55/Khfu2QMQxSv2+wQ
VXxE6cyGGCuisUqDmBHcl2yMD3ps3PABxQVGv7X4Kn/qjYfYFgU7TPX2LHo07SE2
DWEKKrXj9vQ1iCTKu5RhLTZ/bUEpcpH1/iUPPQnadAF0zvg053eTWzA8DM0gjALd
0cavAgGRK059AKhOoLoiZBbE/16l9Oj8YBmCiDeXJkHFAv5jfKkAHEUFX7y5dD2P
IzdzwD09RvKSJeKBVYgKsGKo5fd9vJ64FXEIV7gop9jHF+/e3fq431qvTVL+YdHS
uB5e3S7YzvqkFPUkrqdVHJyuAEyl6zP8/D0QBufMIKRU6rCFE8EBoEBzFGYKXSPi
GSxvuEuMxG5jpSOc6mRCdGtH/gmZ7RedTuOp/acI0J0TZdB138X7H5SfLfHu106d
OH0X8+BxYmgyqsrjGst+LVU1EEN6PuiDSIpG8/uo6Vr25ehXBdTTPogMXniuz2zr
2ml+xoxH6qr888LKk78D
=KBVO
-----END PGP SIGNATURE-----

--68AKOKdso9DUxdsPM0RS1pDkpldSMaERp--
