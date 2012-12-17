From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP: DSS: add FEAT_DPI_USES_VDDS_DSI to omap3630_dss_feat_list
Date: Mon, 17 Dec 2012 13:58:59 +0200
Message-ID: <50CF0903.8010205@ti.com>
References: <20121216080803.618a3634@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig939FBE17013E78EDF1ED012F"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43948 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752393Ab2LQL7o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Dec 2012 06:59:44 -0500
In-Reply-To: <20121216080803.618a3634@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Chandrabhanu Mahapatra <cmahapatra@ti.com>, linux-omap@vger.kernel.org

--------------enig939FBE17013E78EDF1ED012F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-12-15 23:08, NeilBrown wrote:
>=20
> commit 195e672a76056478cc79f5c48343164c9237852e
>    OMAPDSS: DPI: Remove cpu_is_xxxx checks
>=20
> made the mistake of assuming that cpu_is_omap34xx() is exclusive of
> other cpu_is_* predicates whereas it includes cpu_is_omap3630().
>=20
> So on an omap3630, code that was previously enabled by
>   if (cpu_is_omap34xx())
> is now disabled as
>   dss_has_feature(FEAT_DPI_USES_VDDS_DSI)
> fails.
>=20
> So add FEAT_DPI_USES_VDDS_DSI to omap3630_dss_feat_list.
>=20
> Cc: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: NeilBrown <neilb@suse.de>
>=20
> diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/oma=
p2/dss/dss_features.c
> index acbc1e1..aaf3c3f 100644
> --- a/drivers/video/omap2/dss/dss_features.c
> +++ b/drivers/video/omap2/dss/dss_features.c
> @@ -546,6 +546,7 @@ static const enum dss_feat_id omap3630_dss_feat_lis=
t[] =3D {
>  	FEAT_ALPHA_FIXED_ZORDER,
>  	FEAT_FIFO_MERGE,
>  	FEAT_OMAP3_DSI_FIFO_BUG,
> +	FEAT_DPI_USES_VDDS_DSI,
>  };
> =20
>  static const enum dss_feat_id omap4430_es1_0_dss_feat_list[] =3D {
>=20

Thanks, looks correct. Did you encounter a bug related to this, or just
happened to notice?

 Tomi



--------------enig939FBE17013E78EDF1ED012F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQzwkDAAoJEPo9qoy8lh71tlcP/RNynhZQmeI2p1tA1a8weBTf
nxteeRdkzSt95I17TXiuoGrbMiWBJ0bIbPChszPcCt9jMtiJNFVFLXpR12nOCwW3
6r09lAYLWcvYTdzBwsAQ1MwsuXil3dv7nKbtDxife/Y9qG9kkkT53y+6rgiTcdd3
QewnEzUiSEBKSeaO3/tK6cC6eECWGwJOWsfXpULiHsWszFZSj5nWj7lg5vqoMft2
MW/DXZ2VcKFbJ1BVzmV3zeygwqh/kmpE5ojruyZXxt43E5ye9p+6i0hKSkFVghWp
I3SyAbBe1PzBBJmgVXvy6Pp9IiwfBEaMNwJoLlDlQg4H7N/CRRaglk2a7rV6IqDe
Qz3YTqhLf8OLT2mQJdp/1BxBBvt9FTSRAU8bkU9ka/EFxd/LSD3/HB1oOLxGhYaX
IRbOCwZF5WromJmqGEW7QKgrhiYQU63zv8tetw8fGqII1hGnQnp7/itXz7Cy55iR
pcW+6aWOKZGUHHIIMCdrDJ56XXxP8hg/JkGl8DgtLZ3z3rOR1yMsaR2L2bRJN2pW
8CqhL00Y1YbPxY+ls1zFrkg7mIURzMPmlaKmyrcAzdNE7hs109KuWK3I0YiPtpQj
LE7y7qmRgQvsK5MmDhkh91pAVdafgyOeQzTSYVZnuLpmncwa15UVWo/aNGFx1k5w
yEMNaqEDwfsJBSzUTK/G
=xX0l
-----END PGP SIGNATURE-----

--------------enig939FBE17013E78EDF1ED012F--
