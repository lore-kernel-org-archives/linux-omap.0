From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [GIT PULL] omapdss changes for 3.11, part 1/2
Date: Mon, 17 Jun 2013 16:46:14 +0300
Message-ID: <51BF1326.7010206@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2WRGOCEDBSCFSQGVMHLON"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51173 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755765Ab3FQNqR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Jun 2013 09:46:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>

------enig2WRGOCEDBSCFSQGVMHLON
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

The following changes since commit 317ddd256b9c24b0d78fa8018f80f1e495481a=
10:

  Linux 3.10-rc5 (2013-06-08 17:41:04 -0700)

are available in the git repository at:

  git://gitorious.org/linux-omap-dss2/linux.git tags/omapdss-for-3.11-1

for you to fetch changes up to 595470a7853848cb971d5ee3fed443b1e3aa0d1b:

  OMAPDSS: gracefully disable overlay at error (2013-06-17 14:00:56 +0300=
)

----------------------------------------------------------------
OMAP display subsystem changes for 3.11 (part 1/2)

This is the first part of OMAP DSS changes for 3.11. This part contains f=
ixes,
cleanups and reorganizations that are not directly related to the new DSS=

device model that is added in part 2, although many of the reorganization=
s are
made to make the part 2 possible.

There should not be any functional changes visible to the user except the=
 few
bug fixes.

The main new internal features:

- Display (dis)connect support, which allows us to explicitly (dis)connec=
t a
  whole display pipeline

- Panel list, which allows us to operate without the specific DSS bus

- Combine omap_dss_output to omap_dss_device, so that we have one generic=

  "entity" for display pipeline blocks

----------------------------------------------------------------
Emil Goode (1):
      OMAPDSS: Remove kfree for memory allocated with devm_kzalloc

Sergey Kibrik (1):
      OMAPDSS: gracefully disable overlay at error

Tomi Valkeinen (36):
      OMAPDSS: add pdata->default_display_name
      OMAPDSS: only probe pdata if there's one
      OMAPDSS: add omap_dss_find_output()
      OMAPDSS: add omap_dss_find_output_by_node()
      OMAPDSS: fix dss_get_ctx_loss_count for DT
      OMAPDSS: clean up dss_[ovl|mgr]_get_device()
      OMAPDSS: add helpers to get mgr or output from display
      OMAPDSS: split overlay manager creation
      OMAPDRM: fix overlay manager handling
      OMAPDSS: Implement display (dis)connect support
      OMAPDSS: CORE: use devm_regulator_get
      OMAPDSS: DSI: cleanup regulator init
      OMAPDSS: DPI: cleanup pll & regulator init
      OMAPDSS: DPI: fix regulators for DT
      OMAPDSS: HDMI: add hdmi_init_regulator
      OMAPDSS: SDI: clean up regulator init
      OMAPDSS: SDI: fix regulators for DT
      OMAPDSS: VENC: clean up regulator init
      OMAPDSS: add videomode conversion support
      OMAPDSS: remove dssdev uses in trivial cases
      OMAPDSS: add panel list
      OMAPDSS: use the panel list in omap_dss_get_next_device
      OMAPDSS: don't use dss bus in suspend/resume
      OMAPDSS: implement display sysfs without dss bus
      OMAPDSS: Add panel dev pointer to dssdev
      OMAPDSS: remove omap_dss_start/stop_device()
      OMAPDSS: combine omap_dss_output into omap_dss_device
      OMAPDSS: omapdss.h: add owner field to omap_dss_device
      OMAPDSS: add module_get/put to omap_dss_get/put_device()
      OMAPDSS: add THIS_MODULE owner to DSS outputs
      OMAPDSS: output: increase refcount in find_output funcs
      OMAPFB: use EPROBE_DEFER if default display is not present
      OMAPDSS: HDMI: clean up PHY power handling
      OMAPDSS: HDMI clean up hpd_gpio
      OMAPDSS: remove unused fields in omap_dss_device
      OMAPDSS: remove dispc's dependency to VENC/HDMI

 drivers/gpu/drm/omapdrm/omap_crtc.c                |  46 +++-
 drivers/gpu/drm/omapdrm/omap_drv.c                 |  21 +-
 drivers/gpu/drm/omapdrm/omap_drv.h                 |   1 +
 drivers/video/omap2/displays/panel-acx565akm.c     |  16 +-
 drivers/video/omap2/displays/panel-generic-dpi.c   |  26 +--
 .../omap2/displays/panel-lgphilips-lb035q02.c      |  10 +-
 drivers/video/omap2/displays/panel-n8x0.c          |  30 +--
 .../omap2/displays/panel-nec-nl8048hl11-01b.c      |   4 +-
 drivers/video/omap2/displays/panel-picodlp.c       |  34 ++-
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |  10 +-
 drivers/video/omap2/displays/panel-taal.c          | 164 +++++++-------
 drivers/video/omap2/displays/panel-tfp410.c        |  32 +--
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |  36 +--
 drivers/video/omap2/dss/Kconfig                    |   1 +
 drivers/video/omap2/dss/apply.c                    |  47 ++--
 drivers/video/omap2/dss/core.c                     | 108 +++++----
 drivers/video/omap2/dss/dispc-compat.c             |   3 +-
 drivers/video/omap2/dss/dispc.c                    |  24 +-
 drivers/video/omap2/dss/display-sysfs.c            | 154 +++++++------
 drivers/video/omap2/dss/display.c                  | 246 ++++++++++++++-=
------
 drivers/video/omap2/dss/dpi.c                      | 131 +++++------
 drivers/video/omap2/dss/dsi.c                      | 135 +++++------
 drivers/video/omap2/dss/dss.c                      |   3 +-
 drivers/video/omap2/dss/dss.h                      |  35 +--
 drivers/video/omap2/dss/dss_features.c             |   1 -
 drivers/video/omap2/dss/hdmi.c                     | 107 ++++-----
 drivers/video/omap2/dss/manager-sysfs.c            |  47 ++--
 drivers/video/omap2/dss/manager.c                  |  29 ++-
 drivers/video/omap2/dss/output.c                   |  78 ++++++-
 drivers/video/omap2/dss/rfbi.c                     |  39 ++--
 drivers/video/omap2/dss/sdi.c                      |  61 ++---
 drivers/video/omap2/dss/ti_hdmi.h                  |   5 +-
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c          |  87 ++++----
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h          |   1 +
 drivers/video/omap2/dss/venc.c                     |  87 +++-----
 drivers/video/omap2/dss/venc_panel.c               |  16 +-
 drivers/video/omap2/omapfb/omapfb-ioctl.c          |   9 +-
 drivers/video/omap2/omapfb/omapfb-main.c           |  27 +--
 include/video/omapdss.h                            | 113 ++++++----
 39 files changed, 1131 insertions(+), 893 deletions(-)


------enig2WRGOCEDBSCFSQGVMHLON
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRvxMmAAoJEPo9qoy8lh71v9UQAJWh0zFLdfnayKh8fwk6cQrc
RcWmwqx4+/34kMaq+54Bu+86CDLWsaoxnayS/5r7nGHqF5l00/JGyn2yAYiw33nQ
+zKl7ZEa8yjnky31L7xuZyFVWR4NN8Q79ozeVXve/KyeCi+w8yj9It6CFFc/wsyP
FnSC+kyQSJQcjb9O09pOadwmjzxFFr7JJ1XpUdIlOr0ic/4I0sM4bUEsNaqyXTUe
3Wzy0En3CbcKKB1GkXuPZefedn0owxRAc/G2roY19oeqH71YZ5WKoBZMaBg0bZdv
MlLr29NEoaq/wD5KXSDgFQiWa8zS36b6PCGZzetq2EFJ6obAgUxZwVanXHI1bCu5
slfVF+ZLttNYosWUPnHr0yGTq1+D5IJdJJpR+evfhFSsti3eaME4AhX+uO3ywe53
zzRjQ8E+aT+YkFDXmqVlcy9QWxkrZAH7bmA0RTi1DPxnbUOOEUGoo4DKXeE68Jtc
Sj44tr/+PE4dqM2NE+KPlSTDOap7qakA7qUpXZCKqLx9qD77nqaXBVlMIeOSGlz8
dUKRqsMscnfzDs18rs257lgsKJn7g4LUdymtlxW6U0YVcRUW5ginadp7B25okWDB
e49zMBkj66N7zk+iXO5lzBnVOabcMuQaos4+WWWfLbbwY+nAMvg9wI9PKpIhSZB6
rXg5kOQTlCrxFzGjfu3d
=AN0y
-----END PGP SIGNATURE-----

------enig2WRGOCEDBSCFSQGVMHLON--
