From: NeilBrown <neilb@suse.de>
Subject: [PATCH] ARM: omap: add rcu_locking to omap2_set_init_voltage.
Date: Mon, 9 Jan 2012 17:15:54 +1100
Message-ID: <20120109171554.7f8538d6@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/bx+KDzg1fwMbRSXX+MNviZ1"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52141 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142Ab2AIGQK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Jan 2012 01:16:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--Sig_/bx+KDzg1fwMbRSXX+MNviZ1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


opp_find_freq_ceil and opp_get_voltage are documented as requiring
rcu_lock to be held.  So hold it.

Signed-off-by: NeilBrown <neilb@suse.de>

--
This time with the proper ARM: prefix  - sorry :-(


diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 00bff46..470976e 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -174,14 +174,17 @@ static int __init omap2_set_init_voltage(char *vdd_na=
me, char *clk_name,
 	freq =3D clk->rate;
 	clk_put(clk);
=20
+	rcu_read_lock();
 	opp =3D opp_find_freq_ceil(dev, &freq);
 	if (IS_ERR(opp)) {
+		rcu_read_unlock();
 		pr_err("%s: unable to find boot up OPP for vdd_%s\n",
 			__func__, vdd_name);
 		goto exit;
 	}
=20
 	bootup_volt =3D opp_get_voltage(opp);
+	rcu_read_unlock();
 	if (!bootup_volt) {
 		pr_err("%s: unable to find voltage corresponding "
 			"to the bootup OPP for vdd_%s\n", __func__, vdd_name);


--Sig_/bx+KDzg1fwMbRSXX+MNviZ1
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTwqGGjnsnt1WYoG5AQL6Cg/+O5TzT5pxG9kdv4VxYMZ/ob9BTflTpB6r
ZztHtfTejRF5T9OeVNb9NlIM1OGUbfmu8N/q/T6cyHL8/5JuPWhshccHf27JqBZI
nqTFyYtDTKrZiSzQ4gYt1Bws6/VtO6VkV+LEJVqIRmNoWkwDYhi66j8BQA1Mgqte
D2Y4sruZ1xfcu9zBOkmCRjx78r1ONr0KLHPNFYbrbFZnCKpIaIoTVlxE4VkEaMti
pSLtdNI9rlcR7AZUWsyxUI35q1dt501RgiqtJo3Vr2nkMUawnyz3K/gehzCt3buN
qD+hqYzv8JioJZ9XxPBI4Lidozy2N5Py5qBUczG5RkbPJxkDL651tOIFCO8uE68H
qHkAm2fqhwGIRUuVZpp1UlnyYRUJp97KkZ1DCyYBO+e9PnMTzeI+VJGQivZmJ2Tl
ujuGEEFe/tKq6e4/+nOv0GigdZ0bFFeN/mQr8mYv7uHr9qhH+tPnLQ1OM5vdopTG
pEs1aZUDIMp9Ss1FKeRe6a+pahjscbA1Mf/9ukKBJoyLL3WWRAgW7ar8iFYiMAxY
7zzUP+bUDiNNHvK//UwpsgpClhkbDsCbLfOS0s4QdufFxbI5ACWUOHFHlwmP+My3
s9U6wzqesTeZQNAcKkQRHKhBlyiqwYTEWeashBNW1pCzwGspTunM/Vn+XGOwA/Rk
T5flVPuX+Hs=
=8Y83
-----END PGP SIGNATURE-----

--Sig_/bx+KDzg1fwMbRSXX+MNviZ1--
