From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [patch] OMAPDSS: reading past end of array in dispc_dump_regs()
Date: Mon, 17 Dec 2012 14:09:00 +0200
Message-ID: <50CF0B5C.9080707@ti.com>
References: <20121214150133.GB15839@elgon.mountain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6DE637B7ACCA566AE158A859"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36249 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732Ab2LQMJG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Dec 2012 07:09:06 -0500
In-Reply-To: <20121214150133.GB15839@elgon.mountain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Archit Taneja <archit@ti.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Chandrabhanu Mahapatra <cmahapatra@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org

--------------enig6DE637B7ACCA566AE158A859
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-12-14 17:01, Dan Carpenter wrote:
> We added another kind of plane in 66a0f9e4ac "OMAPDSS: Use WB fifo for
> GFX overlay" so this array needs a new entry as well.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Static checker work.  I don't have a way to test this.
>=20
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/=
dispc.c
> index fedbd2c..bfe62cc 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -3163,6 +3163,7 @@ static void dispc_dump_regs(struct seq_file *s)
>  		[OMAP_DSS_VIDEO1]	=3D "VID1",
>  		[OMAP_DSS_VIDEO2]	=3D "VID2",
>  		[OMAP_DSS_VIDEO3]	=3D "VID3",
> +		[OMAP_DSS_WB]		=3D "WB",
>  	};
>  	const char **p_names;
> =20
>=20

We don't count WB as an overlay currently, as it's handled a bit
differently, so we never try to access that array with OMAP_DSS_WB. We
don't actually dump any WB related registers currently, it seems.

So I think I'll leave this out for now.

Why does the static checker think OMAP_DSS_WB is needed in the array? I
wonder if I'm reading the code wrong, and we indeed do access the array
with OMAP_DSS_WB...

 Tomi



--------------enig6DE637B7ACCA566AE158A859
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQzwtcAAoJEPo9qoy8lh710U8P/3vWUf63KrOfzgp3QeynpPJz
fzHWZD4FC8eQLsy2ftxy0ODqpmSelykoGHUcRwAgIscbkoi3118L9ciX5t7F+OIj
wWz9MxiMpvioc4UBA/iVm/TcHs1tDcsEgHgOBPN1Q6tZrMvOmnVLk8Iklm4S3F4m
K9T15VcF+PuNwi5FuZmYcSuGA2WBmKsaPo0EnPA9csT/Agifw2Y22Gc5MV3j1nHW
GyWk+6aYgpSZnyZWoC/sfUMpUkg16NJIVB7abg5Sun7K2gVNQdM8SlU4P/viu2FG
23i7+66SFZNaR2XLL8TbEsGQnMhrxxMGT60VmBgfOt7EN3A3Wrp5j9B97ORPw08E
3NB1JzjafgqnyfT6+3cHZghke3N7l+SB1+vWWQKofXhmJLb8IChuQnvpeEEP/WrO
Kumj1Pg5tAfbkda39uvYGf6qM/uf6J/ur+LGAEIifoZoPum9O2yrnjq1KzCpuqSe
HHHej15DGsb93iRXXocRumWW72KCgyuPT5NDSpCZTr2Kfnxi30om2ieGQ3Hb5uFE
AirPBj2VcBhpP2DM2PEVobd5kMOtpXQRR3GaUZ5HC2yWshr1I17oQa5SIIny7pXI
73uPYc03eu34gzegp4tApkuuALvOy1rueoUmlKe9jyC1Kbdh0VOf5mMB98Wzw2l6
sO/UOfjbwaw8QKS2dVlS
=vOL6
-----END PGP SIGNATURE-----

--------------enig6DE637B7ACCA566AE158A859--
