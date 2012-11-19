From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [GIT PULL] omapdss fixes for 3.7-rc
Date: Mon, 19 Nov 2012 14:04:16 +0200
Message-ID: <50AA2040.1040501@ti.com>
References: <50978C61.8080907@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7F9028AEB2D62C747DB8AC84"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55741 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752062Ab2KSMEV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Nov 2012 07:04:21 -0500
In-Reply-To: <50978C61.8080907@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org

--------------enig7F9028AEB2D62C747DB8AC84
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Florian,

I have an additional crash bug fix for omapdss. I don't think you've
pulled the original request below yet, so here's an updated one:

 Tomi

The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd=
37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://gitorious.org/linux-omap-dss2/linux.git tags/omapdss-for-3.7-rc7

for you to fetch changes up to c415187b689842e8bb85135c070c822c2505f805:

  OMAPFB: Fix possible null pointer dereferencing (2012-11-19 10:41:50 +0=
200)

----------------------------------------------------------------
omapdss fixes for 3.7-rc7

omapdss fixes for three crash bugs and one missing mutex unlock.

----------------------------------------------------------------
Laurent Pinchart (1):
      omapdss: dss: Fix clocks on OMAP363x

Tomi Valkeinen (1):
      OMAPDSS: DSI: fix dsi_get_dsidev_from_id()

Tushar Behera (1):
      OMAPFB: Fix possible null pointer dereferencing

Wei Yongjun (1):
      OMAPDSS: HDMI: fix missing unlock on error in hdmi_dump_regs()

 drivers/video/omap2/dss/dsi.c             |   13 +++++++++++--
 drivers/video/omap2/dss/dss.c             |    4 ++--
 drivers/video/omap2/dss/hdmi.c            |    4 +++-
 drivers/video/omap2/omapfb/omapfb-ioctl.c |    2 +-
 4 files changed, 17 insertions(+), 6 deletions(-)




On 2012-11-05 11:52, Tomi Valkeinen wrote:
> Hi Florian,
>=20
> Here are a few omapdss fixes, two fixing crasher bugs and the third=20
> fixes a missing unlock. These are based on 3.7-rc1. I can rebase on=20
> top of something else if you prefer that.
>=20
> Tomi
>=20
>=20
> The following changes since commit
> ddffeb8c4d0331609ef2581d84de4d763607bd37:
>=20
> Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)
>=20
> are available in the git repository at:
>=20
> git://gitorious.org/linux-omap-dss2/linux.git
> tags/omapdss-for-3.7-rc5
>=20
> for you to fetch changes up to
> dffc70ade1d13edd186f542718c4d78a31d92fb8:
>=20
> OMAPDSS: HDMI: fix missing unlock on error in hdmi_dump_regs()
> (2012-10-26 08:45:43 +0300)
>=20
> ----------------------------------------------------------------=20
> omapdss fixes for 3.7-rc5
>=20
> omapdss fixes for two crashes bugs and one missing mutex unlock.
>=20
> ----------------------------------------------------------------=20
> Laurent Pinchart (1): omapdss: dss: Fix clocks on OMAP363x
>=20
> Tomi Valkeinen (1): OMAPDSS: DSI: fix dsi_get_dsidev_from_id()
>=20
> Wei Yongjun (1): OMAPDSS: HDMI: fix missing unlock on error in
> hdmi_dump_regs()
>=20
> drivers/video/omap2/dss/dsi.c  |   13 +++++++++++--=20
> drivers/video/omap2/dss/dss.c  |    4 ++--=20
> drivers/video/omap2/dss/hdmi.c |    4 +++- 3 files changed, 16
> insertions(+), 5 deletions(-)
>=20



--------------enig7F9028AEB2D62C747DB8AC84
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQqiBAAAoJEPo9qoy8lh71hCsP/A5CbJlj82RezyQC7Rhu3pzx
y5mJf6uo8dyj2PwSuTCuDGika+quQf1Jgl0J+1kyv5roSd3J1T54xYjAGDexpe4s
vXe/XcGGXxjOCrTEpJlULuaSC+PDutWo7RkEJUZ0MOX8Bs2uVWqHLorLdOs7YEO1
X+aj0b92xkeag91+jHJ9Hx55AXffXQjQyvINsTsyxjVIByE+MF9TrE2mjsbAUbPr
sW3UfKay72ok17262odWFO9O3GtJQJYlf2CaGgsIEaBUFtXWMfRGe0RuYeD/K7pM
6EDHxdJHrOglZwXRGRvmZx8ek3Ja/LAIKdewkCUB7gpzeuX5+HPmh4I41NT8UOf+
TzAE2+PJoLQC1SrvyA1/CsJMu80JJkUA5hSed0afIpculTL1lxf+INpG9qpq8kr9
hFNC6boSJmPMtQ2X6CuIo2N/n+aFHvlu52RGydqFHTOkFcRg8rBFyaW0UJMlYjlA
s3fjXHuzXUU/cDTKVAVAmxJlK6BgZy529YUUjqCCsZ51COZEDuh9apJG+DTTZO5Q
xxc0B/Pa7jCH5vnR/YOxvCiAbTEc9LufI4wvR0EAyHT6ryOwQzMgdiQX3P3ubAEv
ieYtX+x/P3cdeENVKGkdvEZS1ABy8psrUb+ndf3SqjLJ20XRGQmqjjzB3xLYnuQ3
+jmF5D6opAELGlpmMPTn
=KIvJ
-----END PGP SIGNATURE-----

--------------enig7F9028AEB2D62C747DB8AC84--
