From: NeilBrown <neilb@suse.de>
Subject: [PATCH] OMAP: DSS: add FEAT_DPI_USES_VDDS_DSI to
 omap3630_dss_feat_list
Date: Sun, 16 Dec 2012 08:08:03 +1100
Message-ID: <20121216080803.618a3634@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/Df4uZa.2Cvszs7y28n=jmp."; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57747 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751995Ab2LOVIV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 15 Dec 2012 16:08:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org

--Sig_/Df4uZa.2Cvszs7y28n=jmp.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


commit 195e672a76056478cc79f5c48343164c9237852e
   OMAPDSS: DPI: Remove cpu_is_xxxx checks

made the mistake of assuming that cpu_is_omap34xx() is exclusive of
other cpu_is_* predicates whereas it includes cpu_is_omap3630().

So on an omap3630, code that was previously enabled by
  if (cpu_is_omap34xx())
is now disabled as
  dss_has_feature(FEAT_DPI_USES_VDDS_DSI)
fails.

So add FEAT_DPI_USES_VDDS_DSI to omap3630_dss_feat_list.

Cc: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: NeilBrown <neilb@suse.de>

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/d=
ss/dss_features.c
index acbc1e1..aaf3c3f 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -546,6 +546,7 @@ static const enum dss_feat_id omap3630_dss_feat_list[] =
=3D {
 	FEAT_ALPHA_FIXED_ZORDER,
 	FEAT_FIFO_MERGE,
 	FEAT_OMAP3_DSI_FIFO_BUG,
+	FEAT_DPI_USES_VDDS_DSI,
 };
=20
 static const enum dss_feat_id omap4430_es1_0_dss_feat_list[] =3D {

--Sig_/Df4uZa.2Cvszs7y28n=jmp.
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIVAwUBUMzmsznsnt1WYoG5AQLmFRAAwV4sBqS6LY3iBuki1eGRvRUBGmKR2G4h
3WmJSeNetUV3UF2q6dvR45ZgOJb11u2oWIAi7KczOVm4gGnanD2atnoo6VbobalH
u5N/ZDO8IcLQtp5o+7ygil+/EYM0wYUcTpcOYN7b/OoXlxtTGtWitHQyZ0lxBExK
nIsAeje2NH2ZszWqqYCeX8n8d7bWnx737PqwCn94eRITn2nsHSjdrjvO29zuzqis
u7scONPKmAyvmbERwpKCH+8Mh9fgb5wTKTg2Ve3rMTcBqyX7XyWhechZet/NJAa9
uGfVcPr+HGgizq8aNGaZuX3HQl2EzybK5zOrTfcDZe9B4Uu0tbj2PF9zNDbCFoQ/
2ErcRt3o0xw91KQeTWh3GiYnUKeDSO4uB2TIqWg23HKzSw8+2zxg2nInJ+rqi9DA
QQJnebZAynflrl4osfCv1gTwqvtxroLQfwMiDuDQTcCNXv85uwQ4CxOvR7VrfWui
nex5bNOAOPf+bgJq1si0I9UrGkKpbmhxu2X78LZ5Zd+WT2QDhEBlcy4MqUltB3e/
ujmSOcYsoDap0zmZXGJsAJ/BQ4t7VroPeA7Y63i5oG+NqNNO1FOcXUolQ2DTGor+
M3BVuNSG0ATu+4fjaIw1mzS3VWRJOOx8p5+v9OrgKq1bUHGK9qPrZFOLRkNYt7Ci
iTUsPtiaqkk=
=Ck4x
-----END PGP SIGNATURE-----

--Sig_/Df4uZa.2Cvszs7y28n=jmp.--
