From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [GIT PULL] omap display fixes for 3.10
Date: Thu, 2 May 2013 15:37:47 +0300
Message-ID: <51825E1B.5090305@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2BVVJQCMTMLFBPBEQVFIV"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43610 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758796Ab3EBMhv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 May 2013 08:37:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Airlie <airlied@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>

------enig2BVVJQCMTMLFBPBEQVFIV
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Dave,

Here are a few omapdss fixes for 3.10. These are based on top of the earl=
ier
pull request I sent.

The first patch is a compilation fix, the rest implement basic support fo=
r
deferred probing. Support for deferred probing is needed when booting wit=
h
device tree, as the probing order with DT is not the same as with non-DT,=

causing display initialization to fail.

 Tomi

The following changes since commit 3d62fe5b214fce69ae14abbdb88794a7534186=
14:

  OMAPDSS: Merge omapdss topic branches (2013-04-15 12:01:02 +0300)

are available in the git repository at:

  git://gitorious.org/linux-omap-dss2/linux.git tags/omapdss-for-3.10-fix=
es

for you to fetch changes up to bca3913034ef99c9cc028d054273a3b271ed62b9:

  OMAPDSS: TFP410: return EPROBE_DEFER if the i2c adapter not found (2013=
-05-02 12:25:44 +0300)

----------------------------------------------------------------
OMAPDSS fixes for 3.10:

* Compilation fix when DSI is disabled in Kconfig
* Basic deferred probe support to fix DT boot

----------------------------------------------------------------
Tomi Valkeinen (17):
      OMAPDSS: DPI: fix compilation if DSI not compiled in
      OMAPDSS: Makefile: move omapfb after panels
      OMAPFB: use module_platform_driver()
      OMAPFB: defer probe if no displays
      OMAPDSS: DPI: use platform_driver_register()
      OMAPDSS: SDI: use platform_driver_register()
      OMAPDSS: DSI: use platform_driver_register()
      OMAPDSS: RFBI: use platform_driver_register()
      OMAPDSS: HDMI: use platform_driver_register()
      OMAPDSS: VENC: use platform_driver_register()
      OMAPDSS: DPI: Add error handling for dpi_probe_pdata
      OMAPDSS: SDI: Add error handling for sdi_probe_pdata
      OMAPDSS: DSI: Add error handling for dsi_probe_pdata
      OMAPDSS: RFBI: Add error handling for rfbi_probe_pdata
      OMAPDSS: HDMI: Add error handling for hdmi_probe_pdata
      OMAPDSS: VENC: Add error handling for venc_probe_pdata
      OMAPDSS: TFP410: return EPROBE_DEFER if the i2c adapter not found

 drivers/video/omap2/Makefile                |  2 +-
 drivers/video/omap2/displays/panel-tfp410.c |  2 +-
 drivers/video/omap2/dss/dpi.c               | 35 ++++++++++++++++++-----=
------
 drivers/video/omap2/dss/dsi.c               | 35 ++++++++++++++++++-----=
------
 drivers/video/omap2/dss/dss.h               | 31 +++++++++++++++++++++--=
--
 drivers/video/omap2/dss/hdmi.c              | 33 +++++++++++++++++------=
----
 drivers/video/omap2/dss/rfbi.c              | 32 ++++++++++++++++-------=
---
 drivers/video/omap2/dss/sdi.c               | 33 +++++++++++++++++------=
----
 drivers/video/omap2/dss/venc.c              | 33 +++++++++++++++++------=
----
 drivers/video/omap2/omapfb/omapfb-main.c    | 30 ++++-------------------=
--
 10 files changed, 160 insertions(+), 106 deletions(-)


------enig2BVVJQCMTMLFBPBEQVFIV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRgl4bAAoJEPo9qoy8lh71BF8P/26w8+kFcgOt3FiYfh7drLAK
6JQ8W+TWLvTLFiAx/iKub/m+c1HXQqQwt79PhpiNOQ6eTaOtQownfXB7hH3+tj4C
AE+JKpCDFkSy4vqeQqJgSTWmVRdYiwltwWS4uV88B3awGnMlSbVLW9P3RRaIUYw/
z7gxh+vCpq7Mq7OEpgcg5fIEiWZ8NYvVzwPeMTbvLJluaqAlo1lzRafOPRLhuP4P
HmE6qjOVdYA5vH20jAsxZAsPU5L8o8EAFUdodWRN2tsHmW1O0sxAsQkNtQj0RbKD
6qQqPtbLxFML9vH4NawAgCYIP3lWgTFV1Ai8lwhacnuWPm5YwVl4YmIMlbh8KD/j
Y3i3ipFxQpdlEi2/gKGvK1ilKbSk6rq8/EZCxx47SocS9FoMelmYZ8v0uyNEZShS
+ruwOpBx85GWAhWoaGYiyOcfv/Jex1fYf08GbCyh+bjykmVF2b5oe9Qh8Kfr+mXc
/NI5L+TV//6ZPuVaa5XML3MLQqEqDGiRLrhYCWu/h/MDUHB8EpF+ni5kC4tJYOj0
MtU9X+b3V9QvNbEIz4DHznZ9sInEv7LcpvdQkULwyahnACUKk3T6l5DfsdK4SGqc
N+gBeLWqCPdVyVFylvvtdbFgwdL+2R0GmYfW8TvymBHFUOA1kMB49x76XE0agGzq
UaVWjsDGQCGKeB6UM3xz
=sPBz
-----END PGP SIGNATURE-----

------enig2BVVJQCMTMLFBPBEQVFIV--
