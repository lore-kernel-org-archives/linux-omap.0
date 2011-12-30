From: NeilBrown <neilb@suse.de>
Subject: [PATCH] omap: add rcu_locking to omap2_set_init_voltage.
Date: Fri, 30 Dec 2011 12:33:29 +1100
Message-ID: <20111230123329.75f1c7da@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/0YJr7RF2g6VjxdQ5oDEAvYU"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49392 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751221Ab1L3Bdp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Dec 2011 20:33:45 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

--Sig_/0YJr7RF2g6VjxdQ5oDEAvYU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


opp_find_freq_ceil and opp_get_voltage are documented as requiring
rcu_lock to be held.  So hold it.

Signed-off-by: NeilBrown <neilb@suse.de>

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

--Sig_/0YJr7RF2g6VjxdQ5oDEAvYU
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTv0U6Tnsnt1WYoG5AQLXJA//d9thSSvLE4+EsSR4YaGn6lEuDMG3UJ+b
QvckxWPEiMcO5svut2xOuQfapK/bDhLRtBZ3coMCl7uADyVrTmdMJpcl90wOnz87
td9kPnvYOMKEfNktyIJAsRmz+IBXul6jFOP0JTNFKDSU5lyPze1lZv1Zramz/afF
2mFqxzlQ6JlUidDN8/J5VzYXlF1Q2AfhpTDQQVAjNDMV2FZ0EkDpZ9Fb0y+9vN50
Cekvmkw3jJY4REy/1T9YOOMcf4bwlQqUs8KiOJFknJeY+NVWGIW8PCRelWHlCEVt
lgBAGFgvYabIfCeaXfg2yWA0oOuXjVyTjKWrrmLPdTgDbt2IlN06d5rscmdf1gQB
9ScF4t0QGyFhrBgWzKk4HhTLtLcqIvDp254GasL9zwgrwq+DGXG+uRcU/8wha5+L
ptd4An88sK8NI8GSGmh8A/SbxeUeJPpWB9T1z2H8b9u665QPLrNGCWxj0DqS9idi
cL6SBwBp+JTXchQHXf+ECDwmZ3m0rn2Hn+rIYZyDNm/uXDXyxrN4VmTdSveZyZS8
ZZNhhW9HQD/Ygabooi2t7iDXmNGAQn/78/76BcN0SMC/I2eJYdMqabRXk7l16iGh
50aSxZJiUOqR13MX9YNsTuJJkQT0MYtOT08rpaJd6PMBSLa4x5qtFVpzznWOYnJh
7uSD7Ja9py4=
=ScxH
-----END PGP SIGNATURE-----

--Sig_/0YJr7RF2g6VjxdQ5oDEAvYU--
