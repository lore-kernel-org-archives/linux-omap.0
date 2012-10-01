From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [GIT PULL] OMAP DSS for v3.7
Date: Mon, 01 Oct 2012 22:45:14 +0300
Message-ID: <1349120714.13060.8.camel@lappyti>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-DEGT3qXPMPxTZy6skJbR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:47072 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751806Ab2JATpU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Oct 2012 15:45:20 -0400
Received: by eaac13 with SMTP id c13so1926153eaa.19
        for <linux-omap@vger.kernel.org>; Mon, 01 Oct 2012 12:45:17 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-omap@vger.kernel.org, linux-fbdev <linux-fbdev@vger.kernel.org>


--=-DEGT3qXPMPxTZy6skJbR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Florian,

Here are omapdss changes for 3.7 merge window.

There's something funny with the diff stat, though. I can see a few
changes there that I have not made, for example to
drivers/video/console/fbcon.c. I believe they come from my "Merge branch
'fbdev-for-linus' of git://github.com/schandinat/linux-2.6", although I
don't know why they show up in the diff stat.

Merge with v3.6 goes without conflicts, but there will be some conflicts
with OMAP platform stuff, at least according to linux-next reports.
Those conflicts are trivial, though.

 Tomi

The following changes since commit 4cbe5a555fa58a79b6ecbb6c531b8bab0650778d=
:

  Linux 3.6-rc4 (2012-09-01 10:39:58 -0700)

are available in the git repository at:

  git://gitorious.org/linux-omap-dss2/linux.git tags/omapdss-for-3.7

for you to fetch changes up to 13b1ba7de8d0ecc42e4f9c002d5b0c1a48f05e58:

  OMAPDSS: add missing include for string.h (2012-09-28 10:03:03 +0300)

----------------------------------------------------------------
Omapdss driver changes for the 3.7 merge window.

Notable changes:

* Basic writeback support for DISPC level. Writeback is not yet usable, tho=
ugh,
  as we need higher level code to actually expose the writeback feature to
  userspace.
* Rewriting the omapdss output drivers. We're trying to remove the hard lin=
ks
  between the omapdss and the panels, and this rewrite work moves us closer=
 to
  that goal.
* Cleanup and restructuring patches that have been made while working on de=
vice
  tree support for omapdss. Device tree support is still some way ahead, bu=
t
  these patches are good cleanups in themselves.
* Basic OMAP5 DSS support for DPI and DSI outputs.
* Workaround for the problem that GFX overlay's fifo is too small for high
  resolution scenarios, causing underflows.
* Cleanups that remove dependencies to omap platform code.

----------------------------------------------------------------
Archit Taneja (70):
      OMAPDSS: APPLY: Constify timings argument in dss_mgr_set_timings
      OMAPDSS: DPI: Add locking for DPI interface
      OMAPDSS: Displays: Add locking in generic DPI panel driver
      OMAPDSS: DPI: Maintain our own timings field in driver data
      OMAPDSS: DPI displays: Take care of panel timings in the driver itsel=
f
      OMAPDSS: DSI: Maintain own copy of timings in driver data
      OMAPDSS: DSI: Add function to set panel size for command mode panels
      OMAPDSS: DSI: Update manager timings on a manual update
      OMAPDSS: HDMI: Use our own omap_video_timings field when setting inte=
rface timings
      OMAPDSS: HDMI: Add locking for hdmi interface set timing functions
      OMAPDSS: SDI: Create a function to set timings
      OMAPDSS: SDI: Maintain our own timings field in driver data
      OMAPDSS: VENC: Split VENC into interface and panel driver
      OMAPDSS: VENC: Maintain our own timings field in driver data
      OMAPDSS: RFBI: Remove partial update support
      OMAPDSS: RFBI: Add function to set panel size
      OMAPDSS: DSI: Maintain copy of pixel format in driver data
      OMAPDSS: RFBI: Maintain copy of pixel size in driver data
      OMAPDSS: RFBI: Maintain copy of number of data lines in driver data
      OMAPDSS: DPI: Maintain copy of number of data lines in driver data
      OMAPDSS: SDI: Maintain copy of data pairs in driver data
      OMAPDSS: DSI: Maintain copy of operation mode in driver data
      OMAPDSS: DSI: Rename dsi_videomode_data to dsi_videomode_timings
      OMAPDSS: DSI: Maintain copy of video mode timings in driver data
      OMAPDSS: RFBI: Maitain copy of rfbi timings in driver data
      OMAPDSS: VENC: Maintain copy of venc type in driver data
      OMAPDSS: VENC: Maintian copy of video output polarity info in private=
 data
      OMAPFB: Clear framebuffers before they are registered
      OMAPDSS: Add basic omap5 features to dss and dispc
      OMAPDSS: DSI: Pass dsi platform device wherever possible
      OMAPDSS: APPLY: Remove omap_dss_device references in wait_for_go func=
tions
      OMAPDSS: outputs: Create a new entity called outputs
      OMAPDSS: outputs: Create and register output instances
      OMAPDSS: output: Add set/unset device ops for omap_dss_output
      OMAPDSS: APPLY: Add manager set/unset output ops for omap_overlay_man=
ager
      OMAPDSS: Remove manager->device references
      OMAP_VOUT: Remove manager->device references
      OMAPFB: remove manager->device references
      OMAPDRM: Remove manager->device references
      OMAPDSS: Create links between managers, outputs and devices
      OMAPDSS: DPI: Replace dssdev->manager with dssdev->output->manager re=
ferences
      OMAPDSS: DSI: Remove dsi_pdev_map global struct
      OMAPDSS: DSI: Replace dssdev->manager with dssdev->output->manager re=
ferences
      OMAPDSS: SDI: Replace dssdev->manager with dssdev->output->manager re=
ferences
      OMAPDSS: RFBI: Replace dssdev->manager with dssdev->output->manager r=
eferences
      OMAPDSS: VENC: Replace dssdev->manager with dssdev->output->manager r=
eferences
      OMAPDSS: HDMI: Replace dssdev->manager with dssdev->output->manager r=
eferences
      OMAPFB: Change dssdev->manager references
      OMAPDSS: MANAGER: Update display sysfs store
      OMAPDSS: OVERLAY/MANAGER: Get device via output
      OMAPDSS: APPLY: Remove omap_dss_device references from dss_ovl_enable=
/disable
      OMAPDSS: Remove old way of setting manager and device links
      OMAPDSS: DISPC: Constify omap_overlay_info in dispc_ovl_setup()
      OMAPDSS: DISPC: Simplify function names for setting pipeline input an=
d output sizes
      OMAPDSS: DISPC: Pass overlay caps as a parameter to dispc plane funct=
ions
      OMAPDSS: OVERLAY: Add position and replication as overlay caps
      OMAPDSS: DISPC: Make dispc_ovl_setup call dispc_ovl_setup_common
      OMAPDSS: DISPC: Don't pass channel out when configuring overlays
      OMAPDSS: DIPSC: Relax scaling limitations when in memory to memory mo=
de
      OMAPDSS: DISPC: Allow both upscaling and downscaling of chroma
      OMAPDSS: DISPC: Add writeback register offsets and dss features struc=
ts
      OMAPDSS: DISPC: Configure input and output sizes for writeback
      OMAPDSS: DISPC: Downscale chroma if plane is writeback
      OMAPDSS: DISPC: Don't set chroma resampling bit for writeback
      OMAPDSS: DISPC: Add function to set channel in for writeback
      OMAPDSS: DISPC: Configure overlay-like parameters in dispc_wb_setup
      OMAPDSS: DISPC: Configure writeback specific parameters in dispc_wb_s=
etup()
      OMAPDSS: DISPC: Configure writeback FIFOs
      OMAPDSS: DISPC: Add manager like functions for writeback
      OMAPDSS: DISPC: Configure color conversion coefficients for writeback

Chandrabhanu Mahapatra (8):
      OMAPDSS: DISPC: Cleanup cpu_is_xxxx checks
      OMAPDSS: DSS: Remove redundant functions
      OMAPDSS: DSS: Cleanup cpu_is_xxxx checks
      ARM: OMAP: Disable venc for OMAP4
      OMAPDSS: VENC: Remove cpu_is_xxxx checks
      OMAPDSS: DPI: Remove cpu_is_xxxx checks
      OMAPDSS: Correct DISPC_IRQ bit definitions for LCD3
      OMAPDSS: DISPC: Add predecimation limit for TILER based rotations

Grazvydas Ignotas (1):
      OMAPFB: fix framebuffer console colors

Jassi Brar (1):
      OMAPDSS: DISPC: Use msleep instead of blocking mdelay

Rapha=C3=ABl Ass=C3=A9nat (1):
      OMAPDSS: Do not require a VDDS_DSI regulator on AM35xx

Ricardo Neri (2):
      OMAPDSS: HDMI: Disable PLL properly in case of error at power_on
      OMAPDSS: DISPC: Improvements to DIGIT sync signal selection

Tomi Valkeinen (53):
      Merge output work from Archit
      OMAPDSS: HDMI: fix initial HDMI enable
      Merge tag 'v3.6-rc4'
      OMAPDSS: HDMI: Move GPIO handling to HDMI driver
      OMAPDSS: HDMI: Add delay to wait for 5V power
      OMAP4: TWL: add vdda_hdmi_dac regulator supply
      OMAPDSS: HDMI: use vdda_hdmi_dac
      OMAPDSS: Add DSI fclk maximum to dss_features
      OMAPDSS: DSI: calculate dsi clock
      OMAP: 4430SDP: remove DSI clock config from board file
      OMAPDSS: fix use of dssdev->caps
      OMAPDSS: Taal: use devm_* functions
      OMAPFB1: remove unnecessary includes
      OMAPFB1: remove a non-used table
      OMAPDSS: remove unnecessary includes
      OMAPFB: clear framebuffers with CPU
      OMAPDSS: VRAM: Remove clearing with sDMA
      OMAPDSS: Taal: Reogranize for device tree
      OMAPDSS: TFP410: use devm_gpio_request_one
      OMAPDSS: split overlay sysfs code
      OMAPDSS: split manager sysfs code
      OMAPDSS: clean up dss_mgr_set_lcd_config
      OMAPDSS: clean up dss_mgr_set_timings
      Revert "OMAPDSS: APPLY: add fifo-merge support"
      Revert "OMAPDSS: APPLY: add fifo merge support funcs"
      OMAPDSS: Improve fifo management code
      OMAPDSS: Use WB fifo for GFX overlay
      OMAPDSS: fix set_timings
      OMAPDSS: fix dss_ovl_unset_manager
      Merge miscellaneous omapdss changes
      Merge branch 'fbdev-for-linus' of git://github.com/schandinat/linux-2=
.6
      OMAPDSS: omap_dss_register_device() doesn't take display index
      OMAPDSS: Add dss_get_default_display_name()
      OMAPDSS: register only one display device per output
      OMAPDSS: explicitely initialize dssdev->channel for new displays
      OMAPDSS: handle errors in dss_init_device
      OMAPDSS: cleanup dss_recheck_connections
      OMAPDSS: cleanup dss_recheck_connections further
      OMAPDSS: alloc dssdevs dynamically
      OMAPDSS: DSI: improve DSI clock calcs for DISPC
      OMAPDSS: move dss feats to the end of dss.c
      OMAPDSS: Add support for DPI source selection
      OMAPDSS: DSI: Add FEAT_DSI_PLL_SELFREQDCO
      OMAPDSS: DSI: Add FEAT_DSI_PLL_REFSEL
      OMAPDSS: DSI: Add new linebuffer size for OMAP5
      OMAPDSS: DSI: Add code to disable PHY DCC
      OMAPDSS: DSI: make OMAP2_DSS_DSI depend on ARCH_OMAP5
      Merge omapdss single-dssdev series
      Merge OMAP5 DSS changes to omapdss
      OMAPDSS: DSI: fix tlpx_half reg field length
      Merge branch 'archit/outputs-for-3.7'
      Merge branch 'archit/wb-dispc-for-3.7'
      OMAPDSS: add missing include for string.h

 arch/arm/mach-omap2/board-4430sdp.c                |   73 +-
 arch/arm/mach-omap2/board-omap4panda.c             |   27 +-
 arch/arm/mach-omap2/display.c                      |    1 -
 arch/arm/mach-omap2/twl-common.c                   |    6 +
 drivers/media/video/omap/omap_vout.c               |   75 +-
 drivers/staging/omapdrm/omap_drv.c                 |    5 +-
 drivers/video/auo_k190x.c                          |    2 -
 drivers/video/console/bitblit.c                    |    2 +-
 drivers/video/console/fbcon.c                      |    2 +-
 drivers/video/mb862xx/mb862xxfbdrv.c               |    2 +
 drivers/video/omap/hwa742.c                        |    1 -
 drivers/video/omap/lcd_ams_delta.c                 |    1 -
 drivers/video/omap/lcd_palmte.c                    |    1 -
 drivers/video/omap/omapfb_main.c                   |    9 -
 drivers/video/omap2/displays/panel-acx565akm.c     |   14 +-
 drivers/video/omap2/displays/panel-generic-dpi.c   |   76 +-
 .../omap2/displays/panel-lgphilips-lb035q02.c      |    3 +
 drivers/video/omap2/displays/panel-n8x0.c          |   31 +-
 .../omap2/displays/panel-nec-nl8048hl11-01b.c      |    3 +
 drivers/video/omap2/displays/panel-picodlp.c       |    4 +
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |    3 +
 drivers/video/omap2/displays/panel-taal.c          |  239 ++---
 drivers/video/omap2/displays/panel-tfp410.c        |   20 +-
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |    7 +-
 drivers/video/omap2/dss/Kconfig                    |    2 +-
 drivers/video/omap2/dss/Makefile                   |    4 +-
 drivers/video/omap2/dss/apply.c                    |  330 ++-----
 drivers/video/omap2/dss/core.c                     |   91 +-
 drivers/video/omap2/dss/dispc.c                    | 1019 ++++++++++++++--=
----
 drivers/video/omap2/dss/dispc.h                    |   37 +
 drivers/video/omap2/dss/display.c                  |  108 ++-
 drivers/video/omap2/dss/dpi.c                      |  181 +++-
 drivers/video/omap2/dss/dsi.c                      |  675 ++++++++++---
 drivers/video/omap2/dss/dss.c                      |  257 +++--
 drivers/video/omap2/dss/dss.h                      |   79 +-
 drivers/video/omap2/dss/dss_features.c             |  278 +++++-
 drivers/video/omap2/dss/dss_features.h             |    7 +
 drivers/video/omap2/dss/hdmi.c                     |  247 +++--
 drivers/video/omap2/dss/hdmi_panel.c               |   31 +-
 drivers/video/omap2/dss/manager-sysfs.c            |  512 ++++++++++
 drivers/video/omap2/dss/manager.c                  |  473 +--------
 drivers/video/omap2/dss/output.c                   |  148 +++
 drivers/video/omap2/dss/overlay-sysfs.c            |  456 +++++++++
 drivers/video/omap2/dss/overlay.c                  |  492 +---------
 drivers/video/omap2/dss/rfbi.c                     |  222 +++--
 drivers/video/omap2/dss/sdi.c                      |  136 ++-
 drivers/video/omap2/dss/venc.c                     |  337 +++----
 drivers/video/omap2/dss/venc_panel.c               |  251 +++++
 drivers/video/omap2/omapfb/omapfb-ioctl.c          |    7 +-
 drivers/video/omap2/omapfb/omapfb-main.c           |   34 +-
 drivers/video/omap2/omapfb/omapfb.h                |    5 +-
 drivers/video/omap2/vram.c                         |   56 --
 include/video/omapdss.h                            |  112 ++-
 53 files changed, 4592 insertions(+), 2602 deletions(-)
 create mode 100644 drivers/video/omap2/dss/manager-sysfs.c
 create mode 100644 drivers/video/omap2/dss/output.c
 create mode 100644 drivers/video/omap2/dss/overlay-sysfs.c
 create mode 100644 drivers/video/omap2/dss/venc_panel.c


--=-DEGT3qXPMPxTZy6skJbR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQafLKAAoJEPo9qoy8lh71+rkP/iaHY8od27fabaTs6Wg6OHHi
UkSe0csffeDjZ+C+N29CGd9oZ/x7jQr5cZTBQkFnIkcfdaukzIsKr2uZrEybgOf7
aRUJfVqNp04rWwYa2AWGNVNWeC0C71qdfZt1hrsG+tcUdlZfl1FvIJlYFRe4vcbG
g3v3/OY/UQ8I2FHJVSbgRJ+oD6YhMeogFlY+slST5w5ShTRx/SgvFkvw4VlTAT9u
V0n4j5AiG6LfWExiYcGqUWi4m527eH2rRL3oR5IwkR6VIXuCOL9DEpRvW3l33O4H
sQi6fWnk8bN8Miy76cLXEtObEi5opSX1OkanaLmon1+yY6EbJmbMYV2WTJEAe6dW
AwoflK4fHcU+W2aJUUPUmZV9MeUuYzWxIlpmWLglOiB0wkUmooU1AWk9eBfSjvVo
nvI5TvqjuVJbvNfJ7gY8pxMmts+bRC2n9gYJH5Dsdv44MTEmokufNYZ4CAmAJ7nj
WmSuLrfxYxkum2ChLsRdsXX0Qn9fyHW1H/POcsbcoRoiOpGxCoDGwxvBjK9w7zJp
tA9iliYLRqV9QyZK1S2WR8ddM+pGRDl1NiqGLRLyZB2lT93dV7iDQretd5aejAkn
/ViO6iDbkqWOkDRGVS1qrCqirrF2mhxUUX/2tfWbeWia/zMEXHh4JiGBGuZqGfeH
IjnDdnuaxnJvZnJE0ayy
=zF1G
-----END PGP SIGNATURE-----

--=-DEGT3qXPMPxTZy6skJbR--

