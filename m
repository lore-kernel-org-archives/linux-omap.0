From: Tuomas Kulve <tuomas.kulve@movial.fi>
Subject: Patch to enable omapfb scaling
Date: Fri, 31 Oct 2008 12:44:48 +0200
Message-ID: <490AE1A0.70609@movial.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC1CCAA6BAEEEF088D299F77F"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.movial.fi ([62.236.91.34]:57134 "EHLO smtp.movial.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751119AbYJaLQf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Oct 2008 07:16:35 -0400
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id E1EA5C801D
	for <linux-omap@vger.kernel.org>; Fri, 31 Oct 2008 12:44:48 +0200 (EET)
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id 5PDBvyg7nIDj for <linux-omap@vger.kernel.org>;
	Fri, 31 Oct 2008 12:44:48 +0200 (EET)
Received: from [172.17.49.56] (sd056.hel.movial.fi [172.17.49.56])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id B93A7C8001
	for <linux-omap@vger.kernel.org>; Fri, 31 Oct 2008 12:44:48 +0200 (EET)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC1CCAA6BAEEEF088D299F77F
Content-Type: multipart/mixed;
 boundary="------------070404070703060606020902"

This is a multi-part message in MIME format.
--------------070404070703060606020902
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


Hi

The attached patch enables omapfb scaling. Tested on omap3 based
beagleboard with 2.6.27-omap1 kernel from linux-omap kernel tree.

The "if" is a leftover from this commit in linux-omap tree:
4139f42ea612e0ff53a4df41428040f777d0422c


Thanks,
--=20
Tuomas Kulve, Movial Creative Technologies Inc.
Porkkalankatu 13J, FI-00180 Helsinki
Fax +358 9 8567 6401, Tel +358 9 8567 6400
www.movial.com

--------------070404070703060606020902
Content-Type: text/x-patch;
 name*0="0001-Removed-old-contradictory-leftover-if-that-prevent.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename*0="0001-Removed-old-contradictory-leftover-if-that-prevent.patc";
 filename*1="h"

=46rom 886ddb31a1192fc324f1bc092766c918c5fd22fb Mon Sep 17 00:00:00 2001
From: Tuomas Kulve <tuomas.kulve@movial.com>
Date: Wed, 29 Oct 2008 10:54:06 +0200
Subject: [PATCH] Removed old contradictory leftover 'if' that prevents vi=
deo scaling.

---
 drivers/video/omap/dispc.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index 1e6e035..68bc887 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -583,9 +583,6 @@ static int omap_dispc_set_scale(int plane,
 	if ((unsigned)plane > OMAPFB_PLANE_NUM)
 		return -ENODEV;
=20
-	if (out_width !=3D orig_width || out_height !=3D orig_height)
-		return -EINVAL;
-
 	enable_lcd_clocks(1);
 	if (orig_width < out_width) {
 		/*
--=20
1.5.6.5




--------------070404070703060606020902--

--------------enigC1CCAA6BAEEEF088D299F77F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFJCuGglNBpRwkGRGMRAoHqAKCFo+RddJnaDjX/CEJPBdNX2z+KWACgwfQP
8cC619hyDz70x9L17/UiNxA=
=GG4W
-----END PGP SIGNATURE-----

--------------enigC1CCAA6BAEEEF088D299F77F--
