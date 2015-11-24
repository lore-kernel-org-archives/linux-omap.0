From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [patch] OMAPDSS: DSI: cleanup DSI_IRQ_ERROR_MASK define
Date: Tue, 24 Nov 2015 12:47:33 +0200
Message-ID: <56544045.7060308@ti.com>
References: <20151123182235.GA2825@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ORfdITwu0UlNF4ct8TdK95NH8Q3jfBUId"
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20151123182235.GA2825@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--ORfdITwu0UlNF4ct8TdK95NH8Q3jfBUId
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 23/11/15 20:22, Dan Carpenter wrote:
> DSI_IRQ_SYNC_LOST was ORed twice so we can remove one.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> diff --git a/drivers/video/fbdev/omap2/dss/dsi.c b/drivers/video/fbdev/=
omap2/dss/dsi.c
> index b3606de..e86df6d 100644
> --- a/drivers/video/fbdev/omap2/dss/dsi.c
> +++ b/drivers/video/fbdev/omap2/dss/dsi.c
> @@ -144,7 +144,7 @@ struct dsi_reg { u16 module; u16 idx; };
>  #define DSI_IRQ_TA_TIMEOUT	(1 << 20)
>  #define DSI_IRQ_ERROR_MASK \
>  	(DSI_IRQ_HS_TX_TIMEOUT | DSI_IRQ_LP_RX_TIMEOUT | DSI_IRQ_SYNC_LOST | =
\
> -	DSI_IRQ_TA_TIMEOUT | DSI_IRQ_SYNC_LOST)
> +	DSI_IRQ_TA_TIMEOUT)
>  #define DSI_IRQ_CHANNEL_MASK	0xf
> =20
>  /* Virtual channel interrupts */
>=20

Thanks, queued for 4.5.

 Tomi


--ORfdITwu0UlNF4ct8TdK95NH8Q3jfBUId
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWVEBFAAoJEPo9qoy8lh71hxYP/3+OCQ3rk0B+pNTjlQGTF9dB
70zlR81mgpZMf0vnZJ7E7EhjlwbvVahFGASCx51p+d4I7K2Njm9fMrXNS60wy5lo
tcM+YnMGHOF0ST5uNKsaPLOTl5YjpY5ZMlyAS3Lg607r6/0TP8a4AL8Evsi4FD7n
um8TmlStlyzt0RWNwoZdeJXuVc0kUuWrzV7PBKDmvMiCTXYjdGG5H02CtpcI79hF
K+0vQ0xm3g8jinSxzsB3ATyDi9DAqoXQmELJ9mqWJPys8H2Dum9wAIgUSFnjB6KW
ZKXu4dh8LPZ4poGI9ReScVp40623giqQpwTDH5YDTMsAEi7A/2OMCwvNcVrSrADg
55Fhb5F9/Doa1vrFoDzw1pGtgGNnuc+goAxyjqoaqBVnVSU8cznyWxtdt79bDpC/
Cm5VMZEQFlLwJ5Tn/JkeU1HmbHvpRQAhm6m2e3Zb0Z+CsEEcXM03z7TWLPfZi1tI
ph1fV8eW3IlWuxsz4sUrUpTrVNay7HVj6jHaL5ikmg42DwcxEwCIfpGcdUDiy/2Q
aU8tHRu2CPfnIP29ke2G3/iV71qIx9werFbryXezYw/qy2Oa8+xCiCvKGEBnukia
jVs4d8+62M0V6htzhANvpf9WyvOyQCB58ghfpYcdscQBo7n0trIZ5mhGqqDlRGMP
keqq0L2jTIzSrzLR3l+S
=3GfJ
-----END PGP SIGNATURE-----

--ORfdITwu0UlNF4ct8TdK95NH8Q3jfBUId--
