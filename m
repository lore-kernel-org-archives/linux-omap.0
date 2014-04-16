From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: HDMI on OMAP4460: clk rate mismatch warning
Date: Wed, 16 Apr 2014 08:40:03 +0300
Message-ID: <534E17B3.5050109@ti.com>
References: <CAGhQ9Vx-3H3yCzMv-8Mp83FWv94gOHvHP9hMiaPWHthZR_ezTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="SqtHxPXtswIuMQtc1W4T2SsbemgfLuSgD"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37678 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754544AbaDPFkG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Apr 2014 01:40:06 -0400
In-Reply-To: <CAGhQ9Vx-3H3yCzMv-8Mp83FWv94gOHvHP9hMiaPWHthZR_ezTQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>

--SqtHxPXtswIuMQtc1W4T2SsbemgfLuSgD
Content-Type: multipart/mixed;
 boundary="------------010903050600040101080905"

This is a multi-part message in MIME format.
--------------010903050600040101080905
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 15/04/14 20:36, Joachim Eastwood wrote:
> Hello,
>=20
> I am trying to get HDMI work with DT on my VAR-STK-OM44 (4460) board.
> But during kernel boot I get the following message:
>=20
> [ 0.953796] ------------[ cut here ]------------
> [ 0.953826] WARNING: CPU: 0 PID: 1 at
> drivers/video/omap2/dss/dss.c:483 dss_set_fck_rate+0x7c/0x8c()
> [ 0.953826] clk rate mismatch: 153600000 !=3D 170666666

I have a fix (attached) for this in fbdev-fixes, which I'll probably be
sending to Linus today. I couldn't send it in the main fbdev pull
request, as it depended on clk driver changes. And it's not fatal, most
likely things work fine even with the warning.

> [ 0.954345] OMAP DSS rev 4.0
> [ 0.956970] connector-hdmi connector.10: failed to find video source
> [ 0.957031] connector-hdmi: probe of connector.10 failed with error -22=

> [ 0.959167] omapfb omapfb: no displays
> [ 0.961547] omapfb omapfb: failed to setup omapfb
> [ 0.961578] platform omapfb: Driver omapfb requests probe deferral

Your DT data is not right. The shorter endpoint format you use is not
supported. Have a look at arch/arm/boot/dts/omap4-panda-common.dtsi for
an example.

Also the HDMI driver does not currently work if the OMAP HDMI is
directly connected to the HDMI connector. Panda and 4430 SDP boards use
TPD12S015 chip in between. This should be fixed in the future, but at
the moment you'll see problems if your board does not have that chip.

 Tomi


--------------010903050600040101080905
Content-Type: text/x-diff;
 name="0001-OMAPDSS-fix-rounding-when-calculating-fclk-rate.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="0001-OMAPDSS-fix-rounding-when-calculating-fclk-rate.patch"

=46rom d0e224f9963b79610850b2a10622182176658022 Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 13 Feb 2014 11:36:22 +0200
Subject: [PATCH] OMAPDSS: fix rounding when calculating fclk rate

"clk: divider: fix rate calculation for fractional rates" patch (and
similar for TI specific divider) fixes the clk-divider's rounding. This
patch updates the DSS driver to round the rates accordingly.

This fixes the DSS's warnings about clock rate mismatch, and also fixes
the wrong fclk rate being set.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Tested-by: Christoph Fritz <chf.fritz@googlemail.com>
Tested-by: Marek Belisko <marek@goldelico.com>
---
 drivers/video/omap2/dss/dss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.=
c
index 825c019ddee7..d55266c0e029 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -457,7 +457,7 @@ bool dss_div_calc(unsigned long pck, unsigned long fc=
k_min,
 	fckd_stop =3D max(DIV_ROUND_UP(prate * m, fck_hw_max), 1ul);
=20
 	for (fckd =3D fckd_start; fckd >=3D fckd_stop; --fckd) {
-		fck =3D prate / fckd * m;
+		fck =3D DIV_ROUND_UP(prate, fckd) * m;
=20
 		if (func(fck, data))
 			return true;
@@ -506,7 +506,7 @@ static int dss_setup_default_clock(void)
=20
 		fck_div =3D DIV_ROUND_UP(prate * dss.feat->dss_fck_multiplier,
 				max_dss_fck);
-		fck =3D prate / fck_div * dss.feat->dss_fck_multiplier;
+		fck =3D DIV_ROUND_UP(prate, fck_div) * dss.feat->dss_fck_multiplier;
 	}
=20
 	r =3D dss_set_fck_rate(fck);
--=20
1.8.3.2


--------------010903050600040101080905--

--SqtHxPXtswIuMQtc1W4T2SsbemgfLuSgD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTThezAAoJEPo9qoy8lh711ewP/1YnYbe6Dml/7Z1/rXdp2yNg
EwB9PdhuzOFAOdfoOZSDhVkQah/GtfDl3jRZ7LjRRMyyAIjOZPYpsUJi/ttFHq9T
M2sQkvfuOJvcuWKpgSrvm0NuzIJZKDLa+h8fhC6WQRetKsay0DzJw+HPMst42OR5
zFAWhuMbaHFAZ1GIvaYdveULVbVbssovI3z+mn5HySrZtsmvT98SR/mZiMQGkz5l
kyfk+QnR4vVaHB1ZuEYsI8ECBYbEbXTu66NQr7vwVnGKCZMqdDNDYFqzCnYs006d
V0ZkLQFGJykZ5Y8xErcSX9pLx+7p9s0hGCXmBs+cMbz7B1ZwDSsKCAm2xzavXeKL
ejfxt+1s7w7/tHo9fvdFl+Gh3kE0ZhELihtkG6aY1pk0O34z6fnOKxx2+XAOZyUI
UjE9uPpU4hQ0JsQMeuDqbEh5oJWDVHyqBvROptz6lXX5S6BfmarXFsWjpyd+VbJa
pXUzoBfXiAoMwkpQKbYW4gl9NUtaxSCST3ZKTCxeQ9s/wBWXOvgPL/OMWa7UHqYg
cYdPVWOK4hkY2jVSHTwS5mYaFDT/o0VUYnu+cvTL3l4KHy8hNLJhIRVCe1kxUUaw
F21HXCyDaT95Qy6zKB8zGCG5aycPS+FXUogVyvaRWVVPxjjibZ0YyWTJetYcRgVD
3KJj+QmXXajZdkrUWttj
=F8La
-----END PGP SIGNATURE-----

--SqtHxPXtswIuMQtc1W4T2SsbemgfLuSgD--
