From: NeilBrown <neilb@suse.de>
Subject: [PATCH] video/omap2. dispc_mgr_enable needs runtime PM
Date: Fri, 30 Dec 2011 12:37:55 +1100
Message-ID: <20111230123755.384a5b5c@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/wGzbW0Y_+gpCRYgxyEygNw0"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49466 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339Ab1L3BiH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Dec 2011 20:38:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org

--Sig_/wGzbW0Y_+gpCRYgxyEygNw0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable



When dispc_mgr_enable is called during shutdown the device might
be asleep, which causes problems.  So ensure it is awake.

Signed-off-by: NeilBrown <neilb@suse.de>

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/disp=
c.c
index 5c81533..75a767f 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2052,12 +2052,14 @@ bool dispc_mgr_is_enabled(enum omap_channel channel)
=20
 void dispc_mgr_enable(enum omap_channel channel, bool enable)
 {
+	dispc_runtime_get();
 	if (dispc_mgr_is_lcd(channel))
 		dispc_mgr_enable_lcd_out(channel, enable);
 	else if (channel =3D=3D OMAP_DSS_CHANNEL_DIGIT)
 		dispc_mgr_enable_digit_out(enable);
 	else
 		BUG();
+	dispc_runtime_put();
 }
=20
 void dispc_lcd_enable_signal_polarity(bool act_high)

--Sig_/wGzbW0Y_+gpCRYgxyEygNw0
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTv0V8znsnt1WYoG5AQJOeQ//ff5wFhUil4DE7DmX0LIydZaxbtYCLqiB
tffzPhhkKK4FYb02rmBMHqbkPR9XMS8zxSBIJHY4YC1/aPD8NRDlYVA31f6uZWx2
Fa8iI1AzFGQZk3NZlo8UzQJbY26lCSmqKh7sC5R+XK+yr2Ed9UbngyJPoYqOfqNp
/2+Vn+AGb048gRMJAj+lSBuAPLh6L2Qt1LgSOWC2Jk/sHB2Nd2JghwY7S8teIAjG
azMAgYGufzuYmimr31H5n3b3jcTdDJPUH4uRLnef0gBDgQ8lgEv5oNC7Jh2Ifb8l
Vfts5b+ZHL0j1G+b8MtXkdrWHiLiydbLRpT4oJIeAUI72D2UMCeJ00WWW2I2sPZa
7IVhzj9TV7T3O8H81FIIgor8X2p1TRHwAlP0ddImT9yqBFrFe+uYY3/28b976neE
74cSUpqv8SLfp1HMCJevRveqw+7yoA8XxdUayJOW07Xo4Vf0TarHV+izLQFDfuSK
uoyx9EenlNGCgAiYngmGM6vpYj6CSanmEFu5f7CEV7LFXhfIrfVsFkLpsmSXDD3J
MXKD51G8GsiUHQ9p3Dh2fdFwPaulORiKW16ZGkoVwXc9Bc92SGyA6i97X/TB9Jjg
LRad5D4lRIkSbsK0iYN/Arbo4dftltrcS6m1i5mMYewksM7EQu6vGYU4/Ad4BkEj
snbXXVQ24yI=
=2wFU
-----END PGP SIGNATURE-----

--Sig_/wGzbW0Y_+gpCRYgxyEygNw0--
