From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [GIT PULL] omapdss changes for 3.11, part 2/2
Date: Mon, 17 Jun 2013 16:47:53 +0300
Message-ID: <51BF1389.4060901@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2LLIXEXVLCXFNRBFWUFMB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42906 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880Ab3FQNr4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jun 2013 09:47:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>

------enig2LLIXEXVLCXFNRBFWUFMB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

The following changes since commit 595470a7853848cb971d5ee3fed443b1e3aa0d=
1b:

  OMAPDSS: gracefully disable overlay at error (2013-06-17 14:00:56 +0300=
)

are available in the git repository at:

  git://gitorious.org/linux-omap-dss2/linux.git tags/omapdss-for-3.11-2

for you to fetch changes up to c545b59515cca4ccaf920e12582a43836cddaa2b:

  OMAPDSS: panels: add Kconfig comment (2013-06-17 14:33:21 +0300)

----------------------------------------------------------------
OMAP display subsystem changes for 3.11 (part 2/2)

This is the second part of OMAP DSS changes for 3.11. This part contains =
the
new DSS device model support.

The current OMAP panel drivers use a custom DSS bus, and there's a hard l=
imit
of one external display block per video pipeline. In the new DSS device m=
odel
the devices/drivers are made according to the control bus of the display =
block,
usually platform, i2c or spi. The display blocks can also be chained so t=
hat we
can have separate drivers for setups with both external encoder and panel=
=2E

To allow the current board files, which use the old style panels, to func=
tion,
the old display drivers are left in their current state, and new ones are=
 added
to drivers/video/omap2/displays-new/. When the board files have been conv=
erted
to use the new style panels, we can remove the old code. This is planned =
to
happen in v3.12.

Having to support two very different DSS device models makes the driver
somewhat confusing in some parts, and prevents us from properly cleaning =
up
some other parts. These cleanups will be done when the old code is remove=
d.

The new device model is designed with CDF (Common Display Framework) in m=
ind.
While CDF is still under work, the new DSS device model should be much mo=
re
similar to CDF's model than the old device model, which should make the
eventual conversion to CDF much easier.

----------------------------------------------------------------
Tomi Valkeinen (23):
      OMAPDSS: public omapdss_register_output()
      OMAPDSS: modify get/find functions to go through the device chain
      OMAPDSS: add OMAP_DISPLAY_TYPE_DVI
      drm/omap: DVI connector fix
      OMAPDSS: DPI: Add ops
      OMAPDSS: SDI: Add ops
      OMAPDSS: DVI: Add ops
      OMAPDSS: AnalogTV: Add ops
      OMAPDSS: HDMI: Add ops
      OMAPDSS: DSI: Add ops
      OMAPDSS: Add new TFP410 Encoder driver
      OMAPDSS: Add new TPD12S015 Encoder driver
      OMAPDSS: Add new DVI Connector driver
      OMAPDSS: Add new HDMI Connector driver
      OMAPDSS: Add new Analog TV Connector driver
      OMAPDSS: Add new simple DPI panel driver
      OMAPDSS: Add new DSI Command Mode panel  driver
      OMAPDSS: Add Sony ACX565AKM panel driver
      OMAPDSS: Add LG.Philips LB035Q02 panel driver
      OMAPDSS: Add Sharp LS037V7DW01 panel driver
      OMAPDSS: Add TPO TD043MTEA1 panel driver
      OMAPDSS: Add NEC NL8048HL11 panel driver
      OMAPDSS: panels: add Kconfig comment

 drivers/gpu/drm/omapdrm/omap_drv.c                 |    6 +-
 drivers/video/omap2/Kconfig                        |    1 +
 drivers/video/omap2/Makefile                       |    1 +
 drivers/video/omap2/displays-new/Kconfig           |   73 ++
 drivers/video/omap2/displays-new/Makefile          |   12 +
 .../video/omap2/displays-new/connector-analog-tv.c |  265 ++++
 drivers/video/omap2/displays-new/connector-dvi.c   |  351 +++++
 drivers/video/omap2/displays-new/connector-hdmi.c  |  375 ++++++
 drivers/video/omap2/displays-new/encoder-tfp410.c  |  267 ++++
 .../video/omap2/displays-new/encoder-tpd12s015.c   |  395 ++++++
 drivers/video/omap2/displays-new/panel-dpi.c       |  270 ++++
 drivers/video/omap2/displays-new/panel-dsi-cm.c    | 1336 ++++++++++++++=
++++++
 .../omap2/displays-new/panel-lgphilips-lb035q02.c  |  358 ++++++
 .../omap2/displays-new/panel-nec-nl8048hl11.c      |  394 ++++++
 .../omap2/displays-new/panel-sharp-ls037v7dw01.c   |  324 +++++
 .../omap2/displays-new/panel-sony-acx565akm.c      |  865 +++++++++++++
 .../omap2/displays-new/panel-tpo-td043mtea1.c      |  646 ++++++++++
 drivers/video/omap2/displays/Kconfig               |    2 +-
 drivers/video/omap2/dss/apply.c                    |   14 +-
 drivers/video/omap2/dss/display.c                  |    1 +
 drivers/video/omap2/dss/dpi.c                      |   74 +-
 drivers/video/omap2/dss/dsi.c                      |   97 +-
 drivers/video/omap2/dss/dss.h                      |    4 -
 drivers/video/omap2/dss/hdmi.c                     |  238 +++-
 drivers/video/omap2/dss/output.c                   |   15 +-
 drivers/video/omap2/dss/rfbi.c                     |    4 +-
 drivers/video/omap2/dss/sdi.c                      |   82 +-
 drivers/video/omap2/dss/venc.c                     |   76 +-
 include/video/omap-panel-data.h                    |  209 +++
 include/video/omapdss.h                            |  192 ++-
 30 files changed, 6911 insertions(+), 36 deletions(-)
 create mode 100644 drivers/video/omap2/displays-new/Kconfig
 create mode 100644 drivers/video/omap2/displays-new/Makefile
 create mode 100644 drivers/video/omap2/displays-new/connector-analog-tv.=
c
 create mode 100644 drivers/video/omap2/displays-new/connector-dvi.c
 create mode 100644 drivers/video/omap2/displays-new/connector-hdmi.c
 create mode 100644 drivers/video/omap2/displays-new/encoder-tfp410.c
 create mode 100644 drivers/video/omap2/displays-new/encoder-tpd12s015.c
 create mode 100644 drivers/video/omap2/displays-new/panel-dpi.c
 create mode 100644 drivers/video/omap2/displays-new/panel-dsi-cm.c
 create mode 100644 drivers/video/omap2/displays-new/panel-lgphilips-lb03=
5q02.c
 create mode 100644 drivers/video/omap2/displays-new/panel-nec-nl8048hl11=
=2Ec
 create mode 100644 drivers/video/omap2/displays-new/panel-sharp-ls037v7d=
w01.c
 create mode 100644 drivers/video/omap2/displays-new/panel-sony-acx565akm=
=2Ec
 create mode 100644 drivers/video/omap2/displays-new/panel-tpo-td043mtea1=
=2Ec


------enig2LLIXEXVLCXFNRBFWUFMB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRvxOJAAoJEPo9qoy8lh71wtIP/0595SZ06agw2UU3GMDQbGBz
qwaEvel1YyV9h5XO95gPVi2ecXqb3XNCcX0OQdkoYi3Zv29toNyemv+5kpcF/bwr
YjJ/hx7YcD7dFp8bJJu6kgXs8NV6IqRrkDVqxkLdMMa+ONUseuuc4asGlcrlC1UK
h2EFIiqOqe1jO8D3uUaQNBgOZwLbwTC+EiSY38mMAmA2fs2VIcyW9JS/pCDaob3s
NdRZA7Miq4bJCqDmyo9c3wkk3j0m1eWCb7jSzhd085ygIJ+cK3ZaaMcsS2vM8uNp
6qs2o+pBsB/8eW0IhtMgFAPhWHUjlNs99WX/qIs16v1DDwIa4pkqxSx0PsIFq7cd
k5Oqk2+MdM04v/FU1dvQTvHdrCPushHIVOQmkSnJbryO5+EjLnOjfKaH9iL9XfTA
CcrCF+Xf4ZGdN1B05SxscW/yHXHeUgBkVNARnuQDD7ipc1x4hYU2pxcOTVO7w23C
ZNoXVZ9Rx1aPXQjevBYvCln+SPqHBRdaPkHuHQinW9/cCR/nWYyLEtMFbzhZDZ7b
B/g2OPJP9uVDzyRwHpJY8RhGZSOL7NPs+XAthP/XbzNE5aKBDYNMkgvu1VPBva5P
m9W19e+ZROw2Aszk+XxlvkOmGFX8efFRGmM4u8n/EOIjuEea755Ohj8f5S1uo8Mp
UKWJ0B7MSK9wzRaoA8Ky
=Anwg
-----END PGP SIGNATURE-----

------enig2LLIXEXVLCXFNRBFWUFMB--
