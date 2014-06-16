From: "David R. Piegdon" <lkml@p23q.org>
Subject: [PATCH 1/1] omap2: fix parser-bug in platform muxing code
Date: Mon, 16 Jun 2014 23:42:51 +0000
Message-ID: <20140616234251.GA10376@ganymede.118net.x>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx-out-2.rwth-aachen.de ([134.130.5.187]:35450 "EHLO
	mx-out-2.rwth-aachen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbaFPXwb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jun 2014 19:52:31 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fix a parser-bug in the omap2 muxing code where muxtable-entries will be
wrongly selected if the requested muxname is a *prefix* of their
m0-entry and they have a matching mN-entry. Fix by additionally checking
that the length of the m0_entry is equal.

Signed-off-by: David R. Piegdon <lkml@p23q.org>


For example muxing of "dss_data2.dss_data2" on omap32xx will fail
because the prefix "dss_data2" will match the mux-entries "dss_data2" as
well as "dss_data20", with the suffix "dss_data2" matching m0 (for
dss_data2) and m4 (for dss_data20). Thus both are recognized as signal
path candidates:

Relevant muxentries from mux34xx.c:
        _OMAP3_MUXENTRY(DSS_DATA20, 90,
                "dss_data20", NULL, "mcspi3_somi", "dss_data2",
                "gpio_90", NULL, NULL, "safe_mode"),
        _OMAP3_MUXENTRY(DSS_DATA2, 72,
                "dss_data2", NULL, NULL, NULL,
                "gpio_72", NULL, NULL, "safe_mode"),

This will result in a failure to mux the pin at all:

 _omap_mux_get_by_name: Multiple signal paths (2) for dss_data2.dss_data2


Patch should apply to linus' latest master down to rather old linux-2.6
trees.


Yours,

David




diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index fd88ede..957a66f 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -183,8 +183,10 @@ static int __init _omap_mux_get_by_name(struct omap_mu=
x_partition *partition,
 		m0_entry =3D mux->muxnames[0];
=20
 		/* First check for full name in mode0.muxmode format */
-		if (mode0_len && strncmp(muxname, m0_entry, mode0_len))
-			continue;
+		if (mode0_len)
+			if (strncmp(muxname, m0_entry, mode0_len)
+					||(strlen(m0_entry) !=3D mode0_len))
+				continue;
=20
 		/* Then check for muxmode only */
 		for (i =3D 0; i < OMAP_MUX_NR_MODES; i++) {



--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlOfgPoACgkQRAfqAVFUPde1vgCfeL1v8Rtaf/30n7qTd4b+U4/9
pxQAn2r32SVzIOFxTp6GV0HfeIqTNcJw
=B1kf
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
