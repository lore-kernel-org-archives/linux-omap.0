From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [GIT PULL] OMAP DSS for v3.5
Date: Tue, 22 May 2012 13:09:23 +0300
Message-ID: <1337681363.4125.10.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-cMpxyu1O+aR9n6kOCB91"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:39573 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751656Ab2EVKJ2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 May 2012 06:09:28 -0400
Received: by lboj14 with SMTP id j14so5824165lbo.35
        for <linux-omap@vger.kernel.org>; Tue, 22 May 2012 03:09:25 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-omap@vger.kernel.org, linux-fbdev <linux-fbdev@vger.kernel.org>, Tony Lindgren <tony@atomide.com>


--=-cMpxyu1O+aR9n6kOCB91
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Florian,

Here are the OMAP DSS changes for 3.5.

I really tried this time to send the pull request early, but here I am
again, sending it when the merge window has already opened... A few
late-found bugs caused some unnecessary delays.

I'm using github this time instead of gitorious, as gitorious seems to
be down. This is my first pull request with a signed tag, I hope
everything is correct.

Note that there's a merge for small branch with omap board file changes
(e4a9e94cc58ed6e4efb02b80be3a9bf57f448d07) that is also pulled by Tony
for the linux-omap tree. This is meant to help avoid conflicts in the
board files.

 Tomi


The following changes since commit 66f75a5d028beaf67c931435fdc3e7823125730c=
:

  Linux 3.4-rc4 (2012-04-21 14:47:52 -0700)

are available in the git repository at:

  git://github.com/tomba/linux.git tags/omapdss-for-3.5

for you to fetch changes up to e92a5b28f71aea01b281f9c89d97a4bc5b24748f:

  OMAPDSS: HDMI: OMAP4: Update IRQ flags for the HPD IRQ request (2012-05-2=
2 11:00:09 +0300)

----------------------------------------------------------------
Omapdss driver changes for 3.5 merge window.

Lots of normal development commits, but perhaps most notable changes are:

* HDMI rework to properly decouple the HDMI audio part from the HDMI video =
part.
* Restructure omapdss core driver so that it's possible to implement device
  tree support. This included changing how platform data is passed to the
  drivers, changing display device registration and improving the panel dri=
ver's
  ability to configure the underlying video output interface.
* Basic support for DSI packet interleaving

----------------------------------------------------------------
Archit Taneja (19):
      OMAPDSS: DISPC/RFBI: Use dispc_mgr_set_lcd_timings() for setting lcd =
size
      OMAPDSS: DISPC: Use a common function to set manager timings
      OMAPDSS: DISPC: Clean up manager timing/size functions
      OMAPDSS: HDMI: Fix ti_hdmi_4xxx_core_dump
      OMAPDSS: HDMI: define and dump CORE registers in correct order
      OMAPDSS: Fix DSI_FCLK clock source selection
      OMAPDSS: DISPC: Remove Fake VSYNC support
      OMAPDSS: APPLY: Add manager timings as extra_info in private data
      OMAPDSS: Apply manager timings instead of direct DISPC writes
      OMAPDSS: MANAGER: Create a function to check manager timings
      OMAPDSS: APPLY: Don't check manager settings if it is disabled
      OMAPDSS: APPLY: Remove display dependency from overlay and manager ch=
ecks
      OMAPDSS: DPI/HDMI: Apply manager timings even if panel is disabled
      OMAPDSS: APPLY: Remove an unnecessary omap_dss_device pointer
      OMAPDSS: DISPC: Remove omap_dss_device pointer usage from dispc_mgr_p=
clk_rate()
      OMAPDSS: DISPC: Remove usage of dispc_mgr_get_device()
      OMAPDSS: DSI: Support command mode interleaving during video mode bla=
nking periods
      OMAPDSS: VENC/DISPC: Delay dividing Y resolution for managers connect=
ed to VENC
      OMAPDSS: Apply VENC timings even if panel is disabled

Axel Castaneda Gonzalez (1):
      OMAPDSS: HDMI: Decouple wrapper enable/disable and audio start/stop

Chandrabhanu Mahapatra (5):
      OMAPDSS: DISPC: Enable predecimation
      OMAPDSS: DISPC: Handle synclost errors in OMAP3
      OMAPDSS: DISPC: Correct DISPC functional clock usage
      OMAPDSS: DISPC: Update Accumulator configuration for chroma plane
      OMAPDSS: DISPC: Support rotation through TILER

Grazvydas Ignotas (5):
      OMAPDSS: OMAPFB: check for matching memory size early
      OMAPDSS: provide default get_timings function for panels
      OMAPDSS: TPO-TD03MTEA1: add set/check timing functions
      OMAPDSS: VENC: allow switching venc output type at runtime
      OMAPDSS: OMAPFB: always allow to configure overlay

Jan Weitzel (1):
      ARM: OMAP2+ Add Primview displays to panel-generic

Mark Brown (4):
      OMAP: DSS2: Remove suspicous and unused TAAL regulator API usage
      OMAPDSS: VENC: Check for errors from regulator_enable()
      OMAPDSS: TPO-TD03MTEA1: Check for errors from regulator_enable()
      OMAPDSS: TPO-TD03MTEA1: Correct comment for power on delay

Peter Meerwald (1):
      OMAPFB: remove unused FB_OMAP_BOOTLOADER_INIT config option

Ricardo Neri (15):
      OMAPDSS: Provide an interface for audio support
      OMAPDSS: HDMI: Split audio_enable into audio_enable/disable
      OMAPDSS: HDMI: Split video_enable into video_enable/disable
      OMAPDSS: HDMI: Remove ASoC codec
      OMAPDSS: HDMI: OMAP4: Remove CEA-861 audio infoframe and IEC-60958 en=
ums
      OMAPDSS: HDMI: OMAP4: Remove invalid I2S settings
      OMAPDSS: HDMI: Decouple HDMI audio from ASoC
      OMAPDSS: HDMI: OMAP4: Expand configuration for IEC-60958 audio
      OMAPDSS: HDMI: Relocate N/CTS calculation
      OMAPDSS: HDMI: Add support for more audio sample rates in N/CTS calcu=
lation
      OMAPDSS: HDMI: Add an audio configuration function
      OMAPDSS: HDMI: OMAP4: Remap speaker order to match ALSA order
      OMAPDSS: HDMI: Panel: Simplify the name of the HDMI mutex
      OMAPDSS: HDMI: Implement DSS driver interface for audio
      OMAPDSS: HDMI: OMAP4: Update IRQ flags for the HPD IRQ request

Russ Dill (1):
      OMAPDSS: TFP410: use gpio_set_value_cansleep

Thomas Weber (2):
      OMAPDSS: Add Mitsubishi AA084SB01 display support
      OMAPDSS: Add EDT ET0500G0DH6 display support

Tomi Valkeinen (38):
      OMAPDSS: add set_min_bus_tput pointer to omapdss's platform data
      OMAPDSS: Ensure OPP100 when DSS is operational
      OMAPDSS: DSI: remove option to use pck for DSI PLL clkin
      OMAPDSS: panel-dvi: add PD gpio handling
      OMAP: board-files: remove custom PD GPIO handling for DVI output
      OMAPDSS: TFP410: rename dvi -> tfp410
      OMAPDSS: TFP410: rename dvi files to tfp410
      OMAPDSS: Taal: move reset gpio handling to taal driver
      OMAPDSS: DSI: implement generic DSI pin config
      Merge branch 'archit/set-timing-work'
      Merge branch 'for-l-o-3.5'
      OMAPFB: fix parsing of vram parameter
      OMAPDSS: TFP410: pdata rewrite
      OMAPDSS: DSI: use dsi_get_dsidev_id(dsidev) instead of dsidev->id
      OMAPDSS: clean up the omapdss platform data mess
      OMAPDSS: remove return from platform_driver_unreg
      OMAPDSS: use platform_driver_probe for core/dispc/dss
      OMAPDSS: create custom pdevs for DSS omap_devices
      OMAPDSS: create DPI & SDI devices
      OMAPDSS: create DPI & SDI drivers
      OMAPDSS: remove uses of dss_runtime_get/put
      OMAPDSS: handle output-driver reg/unreg more dynamically
      OMAPDSS: move the creation of debugfs files
      OMAPDSS: use platform_driver_probe for dsi/hdmi/rfbi/venc/dpi/sdi
      OMAPDSS: add __init & __exit
      OMAPFB: add __init & __exit
      OMAPDSS: change default_device handling
      OMAPDSS: interface drivers register their panel devices
      OMAPDSS: init omap_dss_devices internally
      OMAPDSS: DSI: improve DSI module id handling
      OMAPDSS: separate pdata based initialization
      Merge branch 'dss-devtree-cleanup'
      Merge branch 'omapdss-hdmi-audio'
      OMAPDSS: use DSI_FIFO_BUG workaround only for manual update displays
      OMAPDSS: DISPC: fix usage of dispc_ovl_set_accu_uv
      OMAPDSS: remove compiler warnings when CONFIG_BUG=3Dn
      OMAPFB: remove compiler warnings when CONFIG_BUG=3Dn
      OMAPDSS: VRFB: remove compiler warnings when CONFIG_BUG=3Dn

 Documentation/arm/OMAP/DSS                         |   46 ++
 arch/arm/mach-omap2/board-3430sdp.c                |   38 +-
 arch/arm/mach-omap2/board-4430sdp.c                |   37 +-
 arch/arm/mach-omap2/board-am3517evm.c              |   25 +-
 arch/arm/mach-omap2/board-cm-t35.c                 |   30 +-
 arch/arm/mach-omap2/board-devkit8000.c             |   30 +-
 arch/arm/mach-omap2/board-igep0020.c               |   32 +-
 arch/arm/mach-omap2/board-omap3beagle.c            |   37 +-
 arch/arm/mach-omap2/board-omap3evm.c               |   29 +-
 arch/arm/mach-omap2/board-omap3stalker.c           |   29 +-
 arch/arm/mach-omap2/board-omap4panda.c             |   39 +-
 arch/arm/mach-omap2/board-overo.c                  |   25 +-
 arch/arm/mach-omap2/display.c                      |  196 ++++-
 drivers/video/omap/Kconfig                         |    8 -
 drivers/video/omap2/displays/Kconfig               |    8 +-
 drivers/video/omap2/displays/Makefile              |    2 +-
 drivers/video/omap2/displays/panel-acx565akm.c     |    7 -
 drivers/video/omap2/displays/panel-generic-dpi.c   |  107 ++-
 drivers/video/omap2/displays/panel-n8x0.c          |    8 -
 drivers/video/omap2/displays/panel-taal.c          |  108 +--
 .../omap2/displays/{panel-dvi.c =3D> panel-tfp410.c} |  186 ++---
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |   22 +-
 drivers/video/omap2/dss/Kconfig                    |   13 +-
 drivers/video/omap2/dss/apply.c                    |  134 +++-
 drivers/video/omap2/dss/core.c                     |  255 ++++---
 drivers/video/omap2/dss/dispc.c                    |  747 ++++++++++++++--=
----
 drivers/video/omap2/dss/dispc.h                    |   72 ++
 drivers/video/omap2/dss/display.c                  |   49 +-
 drivers/video/omap2/dss/dpi.c                      |   75 +-
 drivers/video/omap2/dss/dsi.c                      |  537 ++++++++------
 drivers/video/omap2/dss/dss.c                      |   65 +-
 drivers/video/omap2/dss/dss.h                      |  151 ++--
 drivers/video/omap2/dss/dss_features.c             |   30 +-
 drivers/video/omap2/dss/dss_features.h             |    5 +
 drivers/video/omap2/dss/hdmi.c                     |  443 +++++-------
 drivers/video/omap2/dss/hdmi_panel.c               |  236 ++++++-
 drivers/video/omap2/dss/manager.c                  |   19 +-
 drivers/video/omap2/dss/overlay.c                  |   16 +-
 drivers/video/omap2/dss/rfbi.c                     |   84 ++-
 drivers/video/omap2/dss/sdi.c                      |   63 +-
 drivers/video/omap2/dss/ti_hdmi.h                  |   32 +-
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c          |  480 ++++++++-----
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h          |  161 +----
 drivers/video/omap2/dss/venc.c                     |  133 +++-
 drivers/video/omap2/omapfb/omapfb-ioctl.c          |   17 +-
 drivers/video/omap2/omapfb/omapfb-main.c           |   12 +-
 drivers/video/omap2/omapfb/omapfb.h                |    1 +
 drivers/video/omap2/vrfb.c                         |    4 +-
 include/video/omap-panel-nokia-dsi.h               |    3 +
 .../{omap-panel-dvi.h =3D> omap-panel-tfp410.h}      |   18 +-
 include/video/omapdss.h                            |   75 +-
 51 files changed, 2983 insertions(+), 1996 deletions(-)
 rename drivers/video/omap2/displays/{panel-dvi.c =3D> panel-tfp410.c} (56%=
)
 rename include/video/{omap-panel-dvi.h =3D> omap-panel-tfp410.h} (63%)


--=-cMpxyu1O+aR9n6kOCB91
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPu2XTAAoJEPo9qoy8lh71BkYP/jR931b1cVT5oygd5vAv6wVi
+jPeImqzHKZVSOxz5FNVqqfXiP8Npyo09tXxGawxt3VKfroeh/KozqQHKSi0p/28
QJpMFFruukjCwn8LghPJkp8K67+KSldHUXo0aSYiYo9eL+3s8dke62bBNsk6Pg10
z7NI91Kp8CXXh7/b9W7jMb0CMYV5TM9oc34LTxV1ZdhvyqaQppfrVKIfx0rB2LCq
cJ0ij5pmVbLoQEqsP6I8O6KKR865DbiBmmAyMz9O3OwIIorLLv315dPXqf3qfiUI
dDD7ZogjvDNy1mWk8AoM9+4J1qu0PnAZ8BlKZlS79p4MpQaqR0dWkD4hZAi+0qAi
OJ7QPvmrPsYEyNoVUpeM4wlJPtkn3fXdn9MTZNHGkH9SVuvKd3gGA07XDokhwxRV
dQT2h4nawTxnytIlXK64I6Vk3NOxMfxpr5NIuASLbQpXv/tFui+Kvfa6D5+YG/X0
tbxUjDykoUyLlVnyUKSHsHn+Xxpt9G/XYi5VuTz2MUiUVoGk9t/G25esuOLY68HJ
AV3a+tJW8oBMuLQG54/Zxb3Gl/k0BZTKIPMtREfS9SBHFvh1VoKkU1JD6Wy1JG+D
ZQ9AHMHhHD6LAuIWe226b221smhcTdsxYW8qqobAkJylfad8Shr7GQpRvxGohRWm
r+MlBPtYjMLLGI/RcjGZ
=CzA+
-----END PGP SIGNATURE-----

--=-cMpxyu1O+aR9n6kOCB91--

