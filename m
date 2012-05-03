From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Problems with 3.4-rc5
Date: Thu, 03 May 2012 11:28:41 +0300
Message-ID: <1336033721.14378.2.camel@deskari>
References: <WC20120502115251.8503FF@terrafix.co.uk>
	 <4FA12775.1090206@ti.com> <WC20120502124638.320406@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-y6vxQe/0J0ohNKpamv8E"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:34801 "EHLO
	na3sys009aog135.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752720Ab2ECI2v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 04:28:51 -0400
Received: by lboj14 with SMTP id j14so477079lbo.7
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 01:28:48 -0700 (PDT)
In-Reply-To: <WC20120502124638.320406@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org


--=-y6vxQe/0J0ohNKpamv8E
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-05-02 at 13:46 +0100, Joe Woodward wrote:

> > > Secondly, I get the following when booted:
> > > ...
> > > [    4.701232] devtmpfs: mounted
> > > [    4.704772] Freeing init memory: 168K
> > > [    4.827301] omapdss DISPC error: FIFO UNDERFLOW on gfx, disabling
> > the overlay
> > > ...
> > >
> >=20
> > Could you add some dss debug prints? You can add "omapdss.debug=3D1
> > debug"=20
> > in the bootargs to get that.
> >=20
> > There was a feature called fifo merge added in 3.4, this might lead to=
=20
> > underflow, we had tested this using a DVI monitor on beagle but didn't=
=20
> > see any underflows.
> >=20
> > Are you trying this out on 3.4 for the first time? What was the last=
=20
> > kernel revision on which you tested this and didn't see any issues?

Can you try the following changes (separately):


diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/disp=
c.c
index ee30937..aca4eb1 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1091,13 +1091,8 @@ void dispc_ovl_compute_fifo_thresholds(enum omap_pla=
ne plane,
 	 * combined fifo size
 	 */
=20
-	if (dss_has_feature(FEAT_OMAP3_DSI_FIFO_BUG)) {
-		*fifo_low =3D ovl_fifo_size - burst_size * 2;
-		*fifo_high =3D total_fifo_size - burst_size;
-	} else {
-		*fifo_low =3D ovl_fifo_size - burst_size;
-		*fifo_high =3D total_fifo_size - buf_unit;
-	}
+	*fifo_low =3D ovl_fifo_size - burst_size;
+	*fifo_high =3D total_fifo_size - buf_unit;
 }
=20
 static void dispc_ovl_set_fir(enum omap_plane plane,

---

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/disp=
c.c
index ee30937..d63f1a3 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1077,13 +1077,7 @@ void dispc_ovl_compute_fifo_thresholds(enum omap_pla=
ne plane,
 	burst_size =3D dispc_ovl_get_burst_size(plane);
 	ovl_fifo_size =3D dispc_ovl_get_fifo_size(plane);
=20
-	if (use_fifomerge) {
-		total_fifo_size =3D 0;
-		for (i =3D 0; i < omap_dss_get_num_overlays(); ++i)
-			total_fifo_size +=3D dispc_ovl_get_fifo_size(i);
-	} else {
-		total_fifo_size =3D ovl_fifo_size;
-	}
+	total_fifo_size =3D ovl_fifo_size;
=20
 	/*
 	 * We use the same low threshold for both fifomerge and non-fifomerge

 Tomi


--=-y6vxQe/0J0ohNKpamv8E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPokG5AAoJEPo9qoy8lh71vw8P+gOdgrE2hx6ff4xgslxVdcxm
Zxll1h4ouL27RkJ4et7MkKjD7MsQf/aRmzFHSnEViTPvXgHGdH4tqtBILI7E/snN
4f2bbf9rOpUGXvfgtEmy6tqmAhfUR+7xraajffsTMFM5PNe7ftl74BFLRjRw+C1s
qm7XIBKGEgj79NxvI292IBTqErPp81MBXy9emyPcbNuYJyB7MjhC3/kblvaLblNP
GepXAcZTl+wTuXs4XsmzSngxJf2RW4UQALvAMp2800D4+ol3Bv6XkFdVS/9MVNC2
+5bwuuzt9h8p4Y2OKMGY2yQy7NZP8o4fd0NNR0FCquXbx9GIdI/t1VJ0NKTFQrxJ
aZdZ2Amn/leOykuA1FVTcTlDgMx1Duiz52DN5e5Fy6VqvO7zk1PYsYzz/vHH5/EL
gu9FZYQBo5X1DCzvcbamJgXgZRIDXKK/oO5tfhuhqWv8yT02/yW+vaClzORAfNbP
yAZRMVeQhXU5R6qJ30SxlonIY327Q6tzm06V3xaaqaVRAG8kRCzSaEg1KAf/qpAe
X23Ki494SB/uJCN+cBYvBUEO0BemHVt1GYL2NptjexX5xRu5UtbxiN54HdEcLXci
JVkxBAjusccgoCmFYqf+VoKIUgqJR2LBqrf3F+holWEX/QcivxIWELLnztnSIJ17
rROwOrc7lUuo3Nj7N5he
=Ojz+
-----END PGP SIGNATURE-----

--=-y6vxQe/0J0ohNKpamv8E--

