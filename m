From: NeilBrown <neilb@suse.de>
Subject: [PATCH] omap: add rcu_locking to omap2_set_init_voltage.
Date: Mon, 9 Jan 2012 13:14:12 +1100
Message-ID: <20120109131412.6238edf3@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/sxre+Ioclz7mCNy8Pegstjr"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47563 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755142Ab2AICOX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 8 Jan 2012 21:14:23 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--Sig_/sxre+Ioclz7mCNy8Pegstjr
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

--Sig_/sxre+Ioclz7mCNy8Pegstjr
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTwpNdDnsnt1WYoG5AQIKcQ/+NBOKgV1UwF7UTM6tzUbs6RGZlQzHDWmE
M1S3BUXpJ6y9jsbDzp4YFwY6MSKj4IBfHADlGgD/o7fJuZPopfBfqP7Guv49YlZq
4G3wqrYCrjjpPYV0P2DHyyomIXGsrIWIboCfoUfdGaOfzt0LDAn6jnL/2aYfLbPN
F/d0WFuk215O0zmbT7PBlEflDHTsEQGVefkpBL2X23C0N7tPoCbzV9lN/IvEyrn+
dgIeMuZR9Yzs75i29m4VkwwNibTE6sndeGZDP7nj2DmeH+rOUEvYspVil14nunBe
pH9kDyGPKKsGoZlSnpnWdqBdPNVFJ937LD1+GYDx4yEfX6ze/yQTP3sh09IxyKfg
IGEzQcrLja1sBeFll0yZT7dA8JoP+5PXYH1wGcodd8MYpJ27VxATKyFKeIGmark1
b6RHha84p65PBFzapLp5SKLIp9pS9gzK6cQNeXrsr/QyvxKm9c7/KtR3cz9twe81
kJ8OLcV8wpARicipqhXUGvSzlioaHtjUlA1wIYZvbo3XG7QeLr1ZkiLXoy3jM419
gRO7+f6aNb1fnc/lXaEy7oHgM4Bpp7WyaSn3sZHQjttCSV5Y+0LqsVs6iZIWp4Rp
l7TPGnOHUW5RcqPGVKKj9ptdc8nRZlBvPjS2GRQkevWpPDkMGzYodl07tDwLeLcA
u7fkrS+2/Pg=
=jqWg
-----END PGP SIGNATURE-----

--Sig_/sxre+Ioclz7mCNy8Pegstjr--
