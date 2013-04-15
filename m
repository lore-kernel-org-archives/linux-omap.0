From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [GIT PULL] omap display changes for 3.10
Date: Mon, 15 Apr 2013 13:57:57 +0300
Message-ID: <516BDD35.4000807@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig17F457F7BDE096583B9C867D"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:32937 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753453Ab3DOK6B (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Apr 2013 06:58:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Airlie <airlied@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>

--------------enig17F457F7BDE096583B9C867D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Dave,

As agreed, here's the pull request for omap display.

One thing to note is that the panel platform data cleanups require change=
s to
the board files, which go through linux-omap tree. Merging only either th=
e tag
in this pull request, or the board file changes, will give a kernel that
compiles and boots, but not all omap panels work properly.

 Tomi

The following changes since commit 07961ac7c0ee8b546658717034fe692fd12eef=
a9:

  Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)

are available in the git repository at:

  git://gitorious.org/linux-omap-dss2/linux.git tags/omapdss-for-3.10

for you to fetch changes up to 3d62fe5b214fce69ae14abbdb88794a753418614:

  OMAPDSS: Merge omapdss topic branches (2013-04-15 12:01:02 +0300)

----------------------------------------------------------------

Omapdss patches for 3.10 merge window

The biggest changes are:

* DSI video mode: automatic clock and timing calculation
* Lots of platform data related panel driver cleanups, to prepare for DT

----------------------------------------------------------------
Alexandru Gheorghiu (1):
      drivers: video: omap2: dss: Use PTR_RET function

Archit Taneja (29):
      OMAPDSS: panels: keep platform data of all panels in a single heade=
r
      OMAPDSS: NEC-nl8048hl11: remove platform backlight support
      OMAPDSS: Generic DPI Panel: use devm_kzalloc for allocating driver =
data
      OMAPDSS: lb035q02: use devm_kzalloc for allocating driver data
      OMAPDSS: picodlp: use devm_kzalloc for allocating driver data
      OMAPDSS: panel acx565akm: remove omap_dss_device maximum backlight =
level usage
      OMAPDSS: lb035q02: handle gpios in panel driver
      OMAPDSS: lb035q02 panel: remove platform_enable/disable callbacks
      OMAPDSS: generic dpi panel: remove uses of platform_enable/disable =
ops
      OMAPDSS: sharp-ls panel: remove platform_enable/disable callbacks
      OMAPDSS: acx565akm panel: handle gpios in panel driver
      OMAPDSS: nec-nl8048 panel: handle gpios in panel driver
      OMAPDSS: nec-nl8048 panel: remove platform_enable/disable callbacks=

      OMAPDSS: tpo-td043 panel: handle gpios in panel driver
      OMAPDSS: tpo-td043: remove platform_enable/disable callbacks
      OMAPDSS: picodlp panel: handle gpio data in panel driver
      OMAPDSS: picodlp panel: remove platform_enable/disable callbacks
      OMAPDSS: n8x0 panel: handle gpio data in panel driver
      OMAPDSS: n8x0 panel: remove use of platform_enable/disable
      OMAPDSS: VENC: remove platform_enable/disable calls
      omapdss: DISPC: add max pixel clock limits for LCD and TV managers
      omapdss: Features: Fix some parameter ranges
      OMAPDSS: DISPC: Configure doublestride for NV12 when using 2D Tiler=
 buffers
      OMAPDSS: DISPC: Revert to older DISPC Smart Standby mechanism for O=
MAP5
      omapdss: use devm_clk_get()
      drm/omap: fix modeset_init if a panel doesn't satisfy omapdrm requi=
rements
      drm/omap: Make fixed resolution panels work
      drm/omap: Take a fb reference in omap_plane_update()
      drm/omap: Fix and improve crtc and overlay manager correlation

Lars-Peter Clausen (1):
      OMAPDSS: nec-nl8048 panel: Use dev_pm_ops

Sachin Kamat (1):
      OMAPDSS: DSI: Use devm_clk_get()

Tomi Valkeinen (38):
      OMAPDSS: add fields to panels' platform data
      OMAPDSS: DSI: remove DSI & DISPC clk divisors from dssdev
      OMAPDSS: HDMI: remove HDMI clk divisors from dssdev
      OMAPDSS: DPI: remove omap_dss_device uses
      OMAPDSS: DSI: remove omap_dss_device uses
      OMAPDSS: Taal: remove multi-panel support
      OMAPDSS: APPLY: remove dssdev from dss_mgr_wait_for_vsync
      OMAPDSS: add missing export for omap_dss_get_output()
      OMAPDSS: HDMI: init output earlier
      OMAPDSS: add output->name
      OMAPDSS: add output->dispc_channel
      OMAPDSS: DSI: delay dispc initialization
      OMAPDSS: DSI: fix DSI channel source initialization
      OMAPDSS: Taal: remove rotate & mirror support
      OMAPDSS: DPI: fix dpi_get_dsidev() for omap5
      OMAPDSS: DISPC: store core clk rate
      OMAPDSS: DSI: fix wrong unsigned long long use
      OMAPDSS: DSI: simplify dsi configuration
      OMAPDSS: DSI: get line buffer size at probe
      OMAPDSS: DSI: add enum omap_dss_dsi_trans_mode
      OMAPDSS: DSI remove unneeded clk source setup code
      OMAPDSS: DISPC: add new clock calculation code
      OMAPDSS: DSS: add new clock calculation code
      OMAPDSS: DSI: add new clock calculation code
      OMAPDSS: SDI: use new clock calculation code
      OMAPDSS: DPI: use new clock calculation code
      OMAPDSS: DSI: use new clock calculation code
      OMAPDSS: remove unused old clock calculation code
      OMAPDSS: remove dsi videomode from dssdev
      OMAPDSS: acx565akm: remove platform backlight calls
      OMAPDSS: ls037v7dw01: remove platform backlight calls
      OMAPDSS: n8x0: remove platform backlight calls
      OMAPDSS: generic dpi panel: handle gpios in panel driver
      OMAPDSS: LS037V7DW01: handle gpios in panel driver
      OMAPDSS: fix dss_fck clock rate rounding
      OMAPDSS: DPI: widen the pck search when using dss fck
      drm/omap: add statics to a few structs
      OMAPDSS: Merge omapdss topic branches

 arch/arm/mach-omap2/board-2430sdp.c                |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c                |    2 +-
 arch/arm/mach-omap2/board-am3517evm.c              |    3 +-
 arch/arm/mach-omap2/board-cm-t35.c                 |    3 +-
 arch/arm/mach-omap2/board-devkit8000.c             |    3 +-
 arch/arm/mach-omap2/board-h4.c                     |    2 +-
 arch/arm/mach-omap2/board-igep0020.c               |    2 +-
 arch/arm/mach-omap2/board-ldp.c                    |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c            |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c               |    2 +-
 arch/arm/mach-omap2/board-omap3stalker.c           |    3 +-
 arch/arm/mach-omap2/board-overo.c                  |    3 +-
 arch/arm/mach-omap2/dss-common.c                   |    4 +-
 drivers/gpu/drm/omapdrm/omap_connector.c           |   27 +-
 drivers/gpu/drm/omapdrm/omap_crtc.c                |   21 +-
 drivers/gpu/drm/omapdrm/omap_drv.c                 |  165 ++-
 drivers/gpu/drm/omapdrm/omap_drv.h                 |   38 +-
 drivers/gpu/drm/omapdrm/omap_encoder.c             |   24 +-
 drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c          |    2 +-
 drivers/gpu/drm/omapdrm/omap_irq.c                 |   17 +-
 drivers/gpu/drm/omapdrm/omap_plane.c               |    6 +
 drivers/video/omap2/displays/panel-acx565akm.c     |   59 +-
 drivers/video/omap2/displays/panel-generic-dpi.c   |   39 +-
 .../omap2/displays/panel-lgphilips-lb035q02.c      |   58 +-
 drivers/video/omap2/displays/panel-n8x0.c          |   95 +-
 .../omap2/displays/panel-nec-nl8048hl11-01b.c      |  135 +--
 drivers/video/omap2/displays/panel-picodlp.c       |   49 +-
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |  126 +-
 drivers/video/omap2/displays/panel-taal.c          |  300 +----
 drivers/video/omap2/displays/panel-tfp410.c        |    2 +-
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |   45 +-
 drivers/video/omap2/dss/apply.c                    |   15 +-
 drivers/video/omap2/dss/core.c                     |    5 +-
 drivers/video/omap2/dss/dispc.c                    |  176 ++-
 drivers/video/omap2/dss/dispc.h                    |    1 +
 drivers/video/omap2/dss/dpi.c                      |  316 +++--
 drivers/video/omap2/dss/dsi.c                      | 1221 ++++++++++++--=
------
 drivers/video/omap2/dss/dss.c                      |  181 +--
 drivers/video/omap2/dss/dss.h                      |   36 +-
 drivers/video/omap2/dss/dss_features.c             |    8 +-
 drivers/video/omap2/dss/hdmi.c                     |   35 +-
 drivers/video/omap2/dss/output.c                   |    1 +
 drivers/video/omap2/dss/rfbi.c                     |    2 +
 drivers/video/omap2/dss/sdi.c                      |   70 +-
 drivers/video/omap2/dss/venc.c                     |   23 +-
 drivers/video/omap2/omapfb/omapfb-main.c           |    2 +-
 include/video/omap-panel-data.h                    |  150 +++
 include/video/omap-panel-generic-dpi.h             |   37 -
 include/video/omap-panel-n8x0.h                    |   15 -
 include/video/omap-panel-nokia-dsi.h               |   32 -
 include/video/omap-panel-picodlp.h                 |   23 -
 include/video/omap-panel-tfp410.h                  |   35 -
 include/video/omapdss.h                            |   86 +-
 53 files changed, 1972 insertions(+), 1739 deletions(-)
 create mode 100644 include/video/omap-panel-data.h
 delete mode 100644 include/video/omap-panel-generic-dpi.h
 delete mode 100644 include/video/omap-panel-n8x0.h
 delete mode 100644 include/video/omap-panel-nokia-dsi.h
 delete mode 100644 include/video/omap-panel-picodlp.h
 delete mode 100644 include/video/omap-panel-tfp410.h


--------------enig17F457F7BDE096583B9C867D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRa901AAoJEPo9qoy8lh71ksgP+wX3bjk1Mv3StzdJgOHJ1vOr
AsiF09mF8skHmbaQPbsmamuz8Pqw6kAPFoQWG6qCinPDfg96nI/BQ3WG5E5iOW+G
2qNVCFbL3YxQNUZHER1QLFQRXllhSKNqdAsl1T6wOu8IWl1UdlDt5RncVQ848FqD
ud/RjudJKdLMpQgAHL0KULZ8ijddZ7o4dM1vTMWC1Ugg2nu7FoavMK8DIUzK+RP6
L/+LeezD2CMMXjUfCb+S9IR07Ix+JFaEIdCPrHLjHpNxLTLIula9hu9/HiDY0jui
Usdy6M4vysc2e7FJm/OdeLlbGTlNe7q9St/cZvHV9SqAOvf2OG4Lw9K84EhT7evB
5joMcXstCN/Qc1crW+ZtGTSm9+KCbanLB0+7h6VGBTn9w1CPJyFJUCFm7bilRAO5
U1Q7uadSSUN5cCiuc/0AskPAV/vxHJ/5Id3P5MJIIbpxMC+njyGPd82yupg8V4Fi
0/KzKKe+r5BB0m/KQmlivQlxO60DftjbndY7K7mdDYwOuf3CJPViNH1tPXZG+1Nu
B+iuI6e+VY6rEsibpWOeLbv8J7h5JnOLXTSVxR2m4fKaZptJMKUvW3vxzCFuxLzs
WddcPRMoky1t8nlSAkAnjCZCR0XOioe4l8Ya5RtTjMomLhdVbrijHTLTajH9CAkS
gwx9AA6AjXLTOKd4UuWp
=qqJR
-----END PGP SIGNATURE-----

--------------enig17F457F7BDE096583B9C867D--
