From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAPDSS: HDMI: Add OMAP5 HDMI support
Date: Wed, 3 Dec 2014 14:42:23 +0200
Message-ID: <547F052F.1040409@ti.com>
References: <20141203122202.GA7398@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="C4mjPVXqkkEndjH8m8TlpLLUG4oaRWamW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35631 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752764AbaLCMm3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Dec 2014 07:42:29 -0500
In-Reply-To: <20141203122202.GA7398@mwanda>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Jyri Sarha <jsarha@ti.com>
Cc: linux-omap@vger.kernel.org

--C4mjPVXqkkEndjH8m8TlpLLUG4oaRWamW
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Dan, Jyri,

On 03/12/14 14:22, Dan Carpenter wrote:
> Hello Tomi Valkeinen,
>=20
> The patch f5bab2229190: "OMAPDSS: HDMI: Add OMAP5 HDMI support" from
> Mar 13, 2014, leads to the following static checker warning:
>=20
> 	drivers/video/fbdev/omap2/dss/hdmi5_core.c:719 hdmi5_core_audio_config=
()
> 	warn: '(3) - (4)' negative one
>=20
> Uh...  This is really weird, I have no idea what this warning is or why=

> it's triggered.  I've even looked at the code which triggers it but tha=
t
> has no documentation.  :P  Still it seems like something worth looking
> into.

I presume it somehow is caused by this line in the dss.h:

#define FLD_MASK(start, end)	(((1 << ((start) - (end) + 1)) - 1) << (end)=
)

But I don't quite see why the warnings happens. start=3D3 and end=3D4 sho=
uld
produce valid code there, even if the end result is not what's expected..=
=2E

> drivers/video/fbdev/omap2/dss/hdmi5_core.c
>    713          /* PCM audio mode */
>    714          val =3D (cfg->iec60958_cfg->status[0] & IEC958_AES0_CON=
_MODE) >> 6;
>    715          REG_FLD_MOD(base, HDMI_CORE_FC_AUDSCHNLS(2), val, 6, 4)=
;
>    716 =20
>    717          /* Source number */
>    718          val =3D cfg->iec60958_cfg->status[2] & IEC958_AES2_CON_=
SOURCE;
>    719          REG_FLD_MOD(base, HDMI_CORE_FC_AUDSCHNLS(2), val, 3, 4)=
;
>                                                                   ^^^^
> Aren't these reversed?  This seems like an invalid bitfield range.

Good catch! Indeed it's reversed.

Jyri, this is in the hdmi audio side. Can you check it out? Fix is
trivial, but I'd like to know if it has caused wrong configuration, and
if it has, why haven't we noticed anything.

 Tomi



--C4mjPVXqkkEndjH8m8TlpLLUG4oaRWamW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUfwUvAAoJEPo9qoy8lh71SOAQAJp/eh9m3EVFU5wr3mg/emMo
cGz3FVw7d4WxENyq6605iAXcJvONXq3flYuJjCjqLTojKaJrOsN8dkS04lYHpkCX
oI7VEwnYDItGlzuIyMXPPkvDbO2xmWWVWWAkxO2ALp04m0cXDUNVDrj3/2Nqp+TK
pW0HAA9zWv/FZUJfCljahlTvW3KBZ1WrIXi03VhkiwdPizvC5Azb7eOqXqj8lmWe
Q0Kt3+fLd/0aANqwRr7WgyfDolOB5NoguZet1b5BT0YaPi06LSNZ47BOzkcc4sNb
daPQZQtwb1gYe3MRmGQaTUg4YpJxtGSeDJW482yWZzwLh1w8/XmoPRRsBm1PnIDd
l2qUj9VWwqR+qrTVBrut9m6vcu0WwthrS4Wd15v5o04tJhoB+keQqlf1GoetJ+TA
MnXU/0KBfFNNkSOF1s7S1JogYlDFlqzKgD5fppVEhb25vy1MitdcWTCGcoTqMpKk
wtOgxJX/5UMv0xKGZR4JuYIiaGMHJOGM2jcrMq7Ei/FTNLvb6IPxz1UJQ/u5ya8W
h0L0DqBm6ZAkHsOs67kzxMTc4Sxu43eIAUs8RhDkp8bxn8M5iFxnqfvf3qS7vw6K
zk9kHuI0gq2fkXPbKfj6p5oE2rVQ0fElJrpSTlJzRvIyzcV1s+5jK3ZPVGlQkMTq
A8F8SBMJ4Zji0vQ+N4sO
=0H9I
-----END PGP SIGNATURE-----

--C4mjPVXqkkEndjH8m8TlpLLUG4oaRWamW--
