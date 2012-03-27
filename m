From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH V2 2/3] OMAPDSS: DISPC: Handle synclost errors in OMAP3
Date: Tue, 27 Mar 2012 13:43:54 +0300
Message-ID: <1332845034.1867.116.camel@deskari>
References: <1332323516-9050-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-8H+NoTc2OxFo2HdPC/yR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:43357 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752771Ab2C0KoB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Mar 2012 06:44:01 -0400
Received: by lahc1 with SMTP id c1so5124381lah.12
        for <linux-omap@vger.kernel.org>; Tue, 27 Mar 2012 03:43:58 -0700 (PDT)
In-Reply-To: <1332323516-9050-1-git-send-email-cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-8H+NoTc2OxFo2HdPC/yR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2012-03-21 at 15:21 +0530, Chandrabhanu Mahapatra wrote:
> In OMAP3 DISPC video overlays suffer from some undocumented horizontal po=
sition
> and timing related limitations leading to SYNCLOST errors. Whenever the i=
mage
> window is moved towards the right of the screen SYNCLOST errors become
> frequent. Checks have been implemented to see that DISPC driver rejects
> configuration exceeding above limitations.
>=20
> This code was successfully tested on OMAP3. This code is written based on=
 code
> written by Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com> in Linux OMA=
P kernel. Ville
> Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com> had added checks for video ov=
erlay horizontal
> timing and DISPC horizontal blanking length limitations.
>=20
> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c |   97 +++++++++++++++++++++++++++++----=
------
>  1 files changed, 72 insertions(+), 25 deletions(-)

The patch seems to be using dos line endings... Where did they come
from? The two others are fine. I think git am removed the dos line
endings, so it's fine.

 Tomi


ERROR: DOS line endings
#72: FILE: drivers/video/omap2/dss/dispc.c:1625:
+static int check_horiz_timing(enum omap_channel channel, u16 pos_x,^M$

ERROR: DOS line endings
#73: FILE: drivers/video/omap2/dss/dispc.c:1626:
+^I^Iu16 width, u16 height, u16 out_width, u16 out_height)^M$

ERROR: DOS line endings
#74: FILE: drivers/video/omap2/dss/dispc.c:1627:
+{^M$

ERROR: DOS line endings
#75: FILE: drivers/video/omap2/dss/dispc.c:1628:
+^Iint DS =3D DIV_ROUND_UP(height, out_height);^M$

ERROR: DOS line endings
#76: FILE: drivers/video/omap2/dss/dispc.c:1629:
+^Istruct omap_dss_device *dssdev =3D dispc_mgr_get_device(channel);^M$

ERROR: DOS line endings
#77: FILE: drivers/video/omap2/dss/dispc.c:1630:
+^Istruct omap_video_timings t =3D dssdev->panel.timings;^M$

ERROR: DOS line endings
#78: FILE: drivers/video/omap2/dss/dispc.c:1631:
+^Iunsigned long nonactive, lclk, pclk;^M$

ERROR: DOS line endings
#79: FILE: drivers/video/omap2/dss/dispc.c:1632:
+^Istatic const u8 limits[3] =3D { 8, 10, 20 };^M$

ERROR: DOS line endings
#80: FILE: drivers/video/omap2/dss/dispc.c:1633:
+^Iu64 val, blank;^M$

ERROR: DOS line endings
#81: FILE: drivers/video/omap2/dss/dispc.c:1634:
+^Iint i;^M$

ERROR: DOS line endings
#82: FILE: drivers/video/omap2/dss/dispc.c:1635:
+^M$

ERROR: DOS line endings
#83: FILE: drivers/video/omap2/dss/dispc.c:1636:
+^Inonactive =3D t.x_res + t.hfp + t.hsw + t.hbp - out_width;^M$

ERROR: DOS line endings
#84: FILE: drivers/video/omap2/dss/dispc.c:1637:
+^Ipclk =3D dispc_mgr_pclk_rate(channel);^M$

ERROR: DOS line endings
#85: FILE: drivers/video/omap2/dss/dispc.c:1638:
+^Ilclk =3D dispc_mgr_lclk_rate(channel);^M$

ERROR: DOS line endings
#86: FILE: drivers/video/omap2/dss/dispc.c:1639:
+^M$

ERROR: DOS line endings
#87: FILE: drivers/video/omap2/dss/dispc.c:1640:
+^Ii =3D 0;^M$

ERROR: DOS line endings
#88: FILE: drivers/video/omap2/dss/dispc.c:1641:
+^Iif (out_height < height)^M$

ERROR: DOS line endings
#89: FILE: drivers/video/omap2/dss/dispc.c:1642:
+^I^Ii++;^M$

ERROR: DOS line endings
#90: FILE: drivers/video/omap2/dss/dispc.c:1643:
+^Iif (out_width < width)^M$

ERROR: DOS line endings
#91: FILE: drivers/video/omap2/dss/dispc.c:1644:
+^I^Ii++;^M$

ERROR: DOS line endings
#92: FILE: drivers/video/omap2/dss/dispc.c:1645:
+^Iblank =3D div_u64((u64)(t.hbp + t.hsw + t.hfp) * lclk, pclk);^M$

ERROR: DOS line endings
#93: FILE: drivers/video/omap2/dss/dispc.c:1646:
+^IDSSDBG("blanking period + ppl =3D %llu (limit =3D %u)\n", blank,
limits[i]);^M$

WARNING: line over 80 characters
#93: FILE: drivers/video/omap2/dss/dispc.c:1646:
+	DSSDBG("blanking period + ppl =3D %llu (limit =3D %u)\n", blank,
limits[i]);

ERROR: DOS line endings
#94: FILE: drivers/video/omap2/dss/dispc.c:1647:
+^Iif (blank <=3D limits[i])^M$

ERROR: DOS line endings
#95: FILE: drivers/video/omap2/dss/dispc.c:1648:
+^I^Ireturn -EINVAL;^M$

ERROR: DOS line endings
#96: FILE: drivers/video/omap2/dss/dispc.c:1649:
+^M$

ERROR: trailing whitespace
#97: FILE: drivers/video/omap2/dss/dispc.c:1650:
+^I/*^M$

ERROR: trailing whitespace
#98: FILE: drivers/video/omap2/dss/dispc.c:1651:
+^I * Pixel data should be prepared before visible display point
starts.^M$

ERROR: trailing whitespace
#99: FILE: drivers/video/omap2/dss/dispc.c:1652:
+^I * So, atleast DS-2 lines must have already been fetched by DISPC^M$

ERROR: trailing whitespace
#100: FILE: drivers/video/omap2/dss/dispc.c:1653:
+^I * during nonactive - pos_x period.^M$

ERROR: DOS line endings
#101: FILE: drivers/video/omap2/dss/dispc.c:1654:
+^I */^M$

ERROR: DOS line endings
#102: FILE: drivers/video/omap2/dss/dispc.c:1655:
+^Ival =3D div_u64((u64)(nonactive - pos_x) * lclk, pclk);^M$

ERROR: DOS line endings
#103: FILE: drivers/video/omap2/dss/dispc.c:1656:
+^IDSSDBG("(nonactive - pos_x) * pcd =3D %llu,"^M$

ERROR: DOS line endings
#104: FILE: drivers/video/omap2/dss/dispc.c:1657:
+^I^I" max(0, DS - 2) * width =3D %d\n",^M$

ERROR: DOS line endings
#105: FILE: drivers/video/omap2/dss/dispc.c:1658:
+^I^Ival, max(0, DS - 2) * width);^M$

ERROR: DOS line endings
#106: FILE: drivers/video/omap2/dss/dispc.c:1659:
+^Iif (val < max(0, DS - 2) * width)^M$

ERROR: DOS line endings
#107: FILE: drivers/video/omap2/dss/dispc.c:1660:
+^I^Ireturn -EINVAL;^M$

ERROR: DOS line endings
#108: FILE: drivers/video/omap2/dss/dispc.c:1661:
+^M$

ERROR: trailing whitespace
#109: FILE: drivers/video/omap2/dss/dispc.c:1662:
+^I/*^M$

ERROR: trailing whitespace
#110: FILE: drivers/video/omap2/dss/dispc.c:1663:
+^I * All lines need to be refilled during the nonactive period of
which^M$

ERROR: trailing whitespace
#111: FILE: drivers/video/omap2/dss/dispc.c:1664:
+^I * only one line can be loaded during the active period. So,
atleast^M$

ERROR: trailing whitespace
#112: FILE: drivers/video/omap2/dss/dispc.c:1665:
+^I * DS - 1 lines should be loaded during nonactive period.^M$

ERROR: DOS line endings
#113: FILE: drivers/video/omap2/dss/dispc.c:1666:
+^I */^M$

ERROR: DOS line endings
#114: FILE: drivers/video/omap2/dss/dispc.c:1667:
+^Ival =3D  div_u64((u64)nonactive * lclk, pclk);^M$

ERROR: DOS line endings
#115: FILE: drivers/video/omap2/dss/dispc.c:1668:
+^IDSSDBG("nonactive * pcd  =3D %llu, max(0, DS - 1) * width =3D %d\n",^M$

ERROR: DOS line endings
#116: FILE: drivers/video/omap2/dss/dispc.c:1669:
+^I^Ival, max(0, DS - 1) * width);^M$

ERROR: DOS line endings
#117: FILE: drivers/video/omap2/dss/dispc.c:1670:
+^Iif (val < max(0, DS - 1) * width)^M$

ERROR: DOS line endings
#118: FILE: drivers/video/omap2/dss/dispc.c:1671:
+^I^Ireturn -EINVAL;^M$

ERROR: DOS line endings
#119: FILE: drivers/video/omap2/dss/dispc.c:1672:
+^M$

ERROR: DOS line endings
#120: FILE: drivers/video/omap2/dss/dispc.c:1673:
+^Ireturn 0;^M$

ERROR: DOS line endings
#121: FILE: drivers/video/omap2/dss/dispc.c:1674:
+}^M$

ERROR: DOS line endings
#122: FILE: drivers/video/omap2/dss/dispc.c:1675:
+^M$

ERROR: DOS line endings
#131: FILE: drivers/video/omap2/dss/dispc.c:1756:
+^I^Iint *x_predecim, int *y_predecim, u16 pos_x)^M$

ERROR: DOS line endings
#139: FILE: drivers/video/omap2/dss/dispc.c:1832:
+^I^I^Ierror =3D check_horiz_timing(channel, pos_x, in_width,^M$

ERROR: DOS line endings
#140: FILE: drivers/video/omap2/dss/dispc.c:1833:
+^I^I^I^Iin_height, out_width, out_height);^M$

ERROR: DOS line endings
#141: FILE: drivers/video/omap2/dss/dispc.c:1834:
+^M$

ERROR: DOS line endings
#150: FILE: drivers/video/omap2/dss/dispc.c:1842:
+^I^I^Ierror =3D (error || in_width > maxsinglelinewidth * 2 ||^M$

ERROR: DOS line endings
#158: FILE: drivers/video/omap2/dss/dispc.c:1858:
+^I^Iif (check_horiz_timing(channel, pos_x, width, height,^M$

ERROR: DOS line endings
#159: FILE: drivers/video/omap2/dss/dispc.c:1859:
+^I^I^Iout_width, out_height)){^M$

ERROR: DOS line endings
#160: FILE: drivers/video/omap2/dss/dispc.c:1860:
+^I^I^I^IDSSERR("horizontal timing too tight\n");^M$

ERROR: DOS line endings
#161: FILE: drivers/video/omap2/dss/dispc.c:1861:
+^I^I^I^Ireturn -EINVAL;^M$

ERROR: DOS line endings
#162: FILE: drivers/video/omap2/dss/dispc.c:1862:
+^I^I}^M$

ERROR: DOS line endings
#163: FILE: drivers/video/omap2/dss/dispc.c:1863:
+^M$

ERROR: DOS line endings
#172: FILE: drivers/video/omap2/dss/dispc.c:1964:
+^I^I^I&x_predecim, &y_predecim, oi->pos_x);^M$

ERROR: DOS line endings
#184: FILE: drivers/video/omap2/dss/dispc.c:2535:
+^Iunsigned long r =3D dispc_fclk_rate();^M$

ERROR: DOS line endings
#187: FILE: drivers/video/omap2/dss/dispc.c:2537:
+^Iif (dispc_mgr_is_lcd(channel)) {^M$

ERROR: DOS line endings
#188: FILE: drivers/video/omap2/dss/dispc.c:2538:
+^I^Iu32 l;^M$

ERROR: DOS line endings
#189: FILE: drivers/video/omap2/dss/dispc.c:2539:
+^I^Iint lcd;^M$

ERROR: DOS line endings
#192: FILE: drivers/video/omap2/dss/dispc.c:2541:
+^I^Il =3D dispc_read_reg(DISPC_DIVISORo(channel));^M$

ERROR: DOS line endings
#193: FILE: drivers/video/omap2/dss/dispc.c:2542:
+^I^Ilcd =3D FLD_GET(l, 23, 16);^M$

ERROR: DOS line endings
#209: FILE: drivers/video/omap2/dss/dispc.c:2544:
+^I^Ireturn r / lcd;^M$

ERROR: DOS line endings
#210: FILE: drivers/video/omap2/dss/dispc.c:2545:
+^I} else {^M$

ERROR: DOS line endings
#211: FILE: drivers/video/omap2/dss/dispc.c:2546:
+^I^Ireturn r;^M$

total: 72 errors, 1 warnings, 143 lines checked

NOTE: whitespace errors detected, you may wish to use scripts/cleanpatch
or
      scripts/cleanfile

123.mbox has style problems, please review.

If any of these errors are false positives, please report
them to the maintainer, see CHECKPATCH in MAINTAINERS.


--=-8H+NoTc2OxFo2HdPC/yR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPcZnqAAoJEPo9qoy8lh71YagQAKnLjyKwkCVOubyYiati9EQP
Xjn6CF+VlR250Br6cQGZ2eFtrr3KVR235t1V8Khi0srUTUM5FEYxAP6d37rEijq5
VgzmXTyD1mNmQeJnVUDw1yF3SESpdWCz0uWLFttJzNd8EqnwbV/HG0ZepWk52NjD
XOvjOJF7uRLBtbRuR/mdFcgVpZXWmd0bW3c1JetQLXIkblxItwXCDUWUGUoNKqr5
+WVrizDTpq1YlNR7wndeHRUzaOnqSt6wmyNVznkdhpkBZHgI8n3UqCT12RZK3tfc
7lm7utN4YupfvOE9J0GPl2VYyzaVBeQlyuNmaVgI4zQtxo5wvTWmXUbBFaaw/+Dd
b7FwuLPE5sI7aPEvhJ6sngYqMSQkJo1E9PQO9pe/b2ZkhsZHXTKoWRcrG3QBPMHF
8ViJ30YJIpnrKZgXulW+yfzzeCigkuyaNp/GGFz4DJ8xRDyU2ScwAEsF7xofOzjb
OkaiHyr0aSYO4cdktz6gDyiRhn7kEXXGe4F5McEZ2I3HZyw476PWIdP+Q7BH7SCX
1yFuIc4z8abQvmacgjAdHime/GJypQRm3b/v0etTFpyX/48P0dnZGQtOi0362hBX
nrX4/H4B0yAjSryHvmP4UJvxSLcMV90JGniDpph9w8wiqouEf74+u+83bwCbj73H
al/EkhYPLurpcNAPJjsm
=LFJ2
-----END PGP SIGNATURE-----

--=-8H+NoTc2OxFo2HdPC/yR--

