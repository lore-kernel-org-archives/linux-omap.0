From: NeilBrown <neilb@suse.de>
Subject: Should I worry about "omap-mcbsp.2: alias fck already exists" or is
 it expected?
Date: Mon, 12 Dec 2011 10:35:53 +1100
Message-ID: <20111212103553.044b17bb@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/08aPZ2mb7sWWRpA3XvF7xxn"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39234 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752566Ab1LKXgG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 11 Dec 2011 18:36:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org

--Sig_/08aPZ2mb7sWWRpA3XvF7xxn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


In 3.2-rc5 (and some earlier kernels) I'm getting the boot-time warning:

[    0.186828]  omap-mcbsp.2: alias fck already exists

and

[    0.188476]  omap-mcbsp.3: alias fck already exists

This happens because omap_alloc_device() contains:


	for (i =3D 0; i < oh_cnt; i++) {
		hwmods[i]->od =3D od;
		_add_hwmod_clocks_clkdev(od, hwmods[i]);
	}

so if oh_cnt is ever > 1 (which is is for mcbsp.2 and .3 in
omap_hwmod_3xxx_data.c as they both declare a '.devattr'), then
_add_hwmod_clocks_clkdev will be called twice with the one 'od', and both
calls will try to add an alias 'fsck' to that same device, and the second
will always give a warning.

Is this actually a bug, or should we silence the warning on second and
subsequent calls to omap_alloc_device()?

Like this?

Thanks,
NeilBrown

omap: don't try to register the main clock twice.

If omap_device_alloc is given 2 or more "struct omap_hwmod" it will try to
register the 'main_clk' of each of them with the same alias - "fck" - again=
st
the same device.  This fails.
So to avoid a warning, don't even try.

Signed-off-by: NeilBrown <neilb@suse.de>

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_dev=
ice.c
index e8d9869..11012bd 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -294,6 +294,7 @@ static void _add_clkdev(struct omap_device *od, const c=
har *clk_alias,
  * and main clock
  * @od: struct omap_device *od
  * @oh: struct omap_hwmod *oh
+ * @sub: this is a subordinate device, so don't try to register fck
  *
  * For the main clock and every optional clock present per hwmod per
  * omap_device, this function adds an entry in the clkdev table of the
@@ -309,11 +310,12 @@ static void _add_clkdev(struct omap_device *od, const=
 char *clk_alias,
  * No return value.
  */
 static void _add_hwmod_clocks_clkdev(struct omap_device *od,
-				     struct omap_hwmod *oh)
+				     struct omap_hwmod *oh, int sub)
 {
 	int i;
=20
-	_add_clkdev(od, "fck", oh->main_clk);
+	if (!sub)
+		_add_clkdev(od, "fck", oh->main_clk);
=20
 	for (i =3D 0; i < oh->opt_clks_cnt; i++)
 		_add_clkdev(od, oh->opt_clks[i].role, oh->opt_clks[i].clk);
@@ -576,7 +578,7 @@ static struct omap_device *omap_device_alloc(struct pla=
tform_device *pdev,
=20
 	for (i =3D 0; i < oh_cnt; i++) {
 		hwmods[i]->od =3D od;
-		_add_hwmod_clocks_clkdev(od, hwmods[i]);
+		_add_hwmod_clocks_clkdev(od, hwmods[i], i);
 	}
=20
 	return od;

--Sig_/08aPZ2mb7sWWRpA3XvF7xxn
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTuU+WTnsnt1WYoG5AQLfnA//b37KjHL97SwQPOVvF5n07ac1ovu8SV5z
wqu/EB9bALuDGU0iJqP2epttc3M0MCEY0vcXLyrK1C0pNy+RDpgXVLJxvi3O9aNq
ACio32Ghz2m5RVJvrcv4tKlO52QC/HE8UR+0dOwuincn49Gazjpjt+vcZaU0MTAM
itW6XXnvXgVQABnR8RTnFdG0046XnTe/Odz/ikMEekIxQzHlOH5VpmH4yn9SsFzy
ohUGIZQG461o+0vd9UpMspRC1fBiPB0Lwei5+nXgoietfWFTC8AWj2eAPRZFI1YV
avwn48gebd1850r8TlbYSMcgFr+T0Ss4ZX28X181NpvPKvAdh7Sk1OE/2KJ5s2FK
I1i7bxpxSds/sXCqq8XhyCGjAsPmjtoC1wXYrabnYwf0VgQls7kDubSselvcFmxc
I5MiXch0nJovRr58fVluPsN9L3iaKUm0LzExHT8C+yrw18u7unKEKs1pmpuoJxIA
RNAgAx1hriEwgsg9BWMjDNj+fG/iVc5vSzz2t6GM8EU5KY1/TI9CGTx7J2x2PDDO
s7uS5u6a49ghZV/Ot6ORSLiE62pE9+vn2kh0Am/ymEsvRLPOJRBtTzco0uDgWQpg
YMEVsVR0lb+4aR6fCtVsO4OAJH43wcUuuJA5IPI+yaW0a85J1iN3cyMFbW9rv1u4
ma/6N9KTgFs=
=16Dl
-----END PGP SIGNATURE-----

--Sig_/08aPZ2mb7sWWRpA3XvF7xxn--
