From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [GIT PULL] omapdss fixes for 3.7-rc
Date: Mon, 5 Nov 2012 11:52:33 +0200
Message-ID: <50978C61.8080907@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD6E4ADFC7B68138EFB2213C5"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49266 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753865Ab2KEJwh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 04:52:37 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org

--------------enigD6E4ADFC7B68138EFB2213C5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Florian,

Here are a few omapdss fixes, two fixing crasher bugs and the third
fixes a missing unlock. These are based on 3.7-rc1. I can rebase on
top of something else if you prefer that.

 Tomi


The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd=
37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://gitorious.org/linux-omap-dss2/linux.git tags/omapdss-for-3.7-rc5

for you to fetch changes up to dffc70ade1d13edd186f542718c4d78a31d92fb8:

  OMAPDSS: HDMI: fix missing unlock on error in hdmi_dump_regs() (2012-10=
-26 08:45:43 +0300)

----------------------------------------------------------------
omapdss fixes for 3.7-rc5

omapdss fixes for two crashes bugs and one missing mutex unlock.

----------------------------------------------------------------
Laurent Pinchart (1):
      omapdss: dss: Fix clocks on OMAP363x

Tomi Valkeinen (1):
      OMAPDSS: DSI: fix dsi_get_dsidev_from_id()

Wei Yongjun (1):
      OMAPDSS: HDMI: fix missing unlock on error in hdmi_dump_regs()

 drivers/video/omap2/dss/dsi.c  |   13 +++++++++++--
 drivers/video/omap2/dss/dss.c  |    4 ++--
 drivers/video/omap2/dss/hdmi.c |    4 +++-
 3 files changed, 16 insertions(+), 5 deletions(-)


--------------enigD6E4ADFC7B68138EFB2213C5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQl4xhAAoJEPo9qoy8lh71bRIP/RP+OBf9SkRLM4uVBeoKHmfj
NqwXu9Sg7Fv3ZKp6F3E59y+U2xLZm0qF9kX1OHPew5VSdfrn5itEt89Xr1ZnbQdy
QadcUGD1a/Wz+VnCojDYDHtZfdnvyLE3s7ANA5sTeZUHOS9Ug+lp2Zp72FLzwGHf
sHY+yezGufMbOlKXy0H8fpUVbDIoqnmtm3TUUAvWtdRhVob2pkKmNZRHybXbYw3Q
Fo4W+Ef+BhJUAh+JPk2e9yUCy5hYOhaIZtH3bcBZpgHJmElbLqDgwcpI+cFGfdpE
Yf/a1Z57t9xFNs8i5rt6f+iof5nyZvGjHUT0IaUS8ntf3WI1ghibuycuZEvDzT7k
taTHsDbkiAyi9c4v8vRp2qwdh9JXLeEJuRyZ3gkwqPWhs6+N8bAT01XHjrh71Cwc
c2xUwt9E3OzwF0sfLdmMtu1rQ3Z8kCnQEpD3SIBVr68X+Jffylu+K2TItvBlVmQv
CsyHqNzTCyfiRdknut5bvfbhx9uMsqhBIQ3tnBUdcKQI6J2t0QR6/ZLvR2D2pI5e
tomhpK3ndw2V+gSgL3+m4V//PfB5gGvouVdbrw+2ayksV+7PvVAG6YRb4Ar08mp2
3KQVpZfgBDZWBV/bTl0w4KRCRjyjsgH8gvJGdav08bfXnx1Alu+/RN0KqgjhZctp
44lmOXGlmmNRQDKArdMK
=tPyh
-----END PGP SIGNATURE-----

--------------enigD6E4ADFC7B68138EFB2213C5--
