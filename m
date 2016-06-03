From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 00/27] fb/drm: omapdss: Clean up the headers and
 separate the two stack
Date: Fri, 3 Jun 2016 14:02:57 +0300
Message-ID: <5e079216-96ea-136b-742b-7d8a15da98b0@ti.com>
References: <20160603105321.7980-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160603105321.7980-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, tony@atomide.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com, jsarha@ti.com, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

Hi,

I can not believe this... My internet got disconnected during git
send-email... This is the second time that this happened.

Will resend the series.

On 06/03/16 13:52, Peter Ujfalusi wrote:
> Hi,
>=20
> Changes since v2:
> - Collected the patches (4 of them) at the beginning which touches ma=
ch-omap2
> - Smaller changes in the moved patches to make sure they compile.
>=20
> Changes since v1:
> - patches (2) added to remove the inclusion of video/omap-panel-data.=
h when it
>   is not needed
> - Transitional patch to create the video/omapfb_dss.h has been change=
d to copy
>   the content of the omapdss.h in one step.
>=20
> I have prepared two branches on top of v4.7-rc1:
> [1] https://github.com/omap-audio/linux-audio.git peter/for-4.8_omapd=
ss_part1
>=20
> containing:
>   ARM: OMAP: rx51-video: Do not set TV connector_type
>   ARM/video: omap2: Move omap_display_init declaration to
>     mach-omap2/display.h
>   video/platform_data: omapdss: Create new header file for platform d=
ata
>   ARM: OMAP2: Use the platform_data header for omapdss
>=20
> [2] https://github.com/omap-audio/linux-audio.git peter/for-4.8_omapd=
ss_part2
>=20
> containing the whole set, including part1.
>=20
> Only patches in part1 branch are touching arch/arm/mach-omap2/ files.
>=20
> omapfb is deprecated. It will not receive new features, only bug fixe=
s. On the.
> other hand omapdrm is in active development and the fact that both
> implementation (omapfb and omapdrm) is using the same header file
> (video/omapdss.h) makes implementing new features or doing bigger cle=
an ups in
> omapdrm harder and hared as the change should not break omapfb.
>=20
> To overcome this issue we need to separate the two implementation. Th=
is is the
> aim of this series:
> Create platform_data header for omapdss,
> clean up the header usage and dependencies,
> new header file for omapfb stack (video/omapfb_dss.h)
> local omapdss.h header file for omapdrm.
>=20
> Regards,
> Peter
> ---
> Peter Ujfalusi (27):
>   ARM: OMAP: rx51-video: Do not set TV connector_type
>   ARM/video: omap2: Move omap_display_init declaration to
>     mach-omap2/display.h
>   video/platform_data: omapdss: Create new header file for platform d=
ata
>   ARM: OMAP2: Use the platform_data header for omapdss
>   omapfb: panel-tpo-td028ttec1: Remove legacy boot support
>   omapfb: panel-nec-nl8048hl11: Remove legacy boot support
>   omapfb: panel-tpo-td043mtea1: Remove legacy boot support
>   omapfb: panel-sharp-ls037v7dw01: Remove legacy boot support
>   omapfb: panel-lgphilips-lb035q02: Remove legacy boot support
>   omapfb: panel-dsi-cm: Remove legacy boot support
>   omapfb: connector-hdmi: Remove legacy boot support
>   omapfb: connector-dvi: Remove legacy boot support
>   omapfb: encoder-tfp410: Remove legacy boot support
>   omapfb: encoder-tpd12s015: No need to include video/omap-panle-data=
=2Eh
>   drm/omap: displays: Do not include video/omap-panel-data.h if not
>     needed
>   omapdss: omap-panel-data.h: Remove struct omap_dss_device declarati=
on
>   drm/omap: connector-analog-tv: Support only Composite type in legac=
y
>     boot
>   omapfb: connector-analog-tv: Support only Composite type in legacy
>     boot
>   omapdss: omap-panel-data.h: Remove connector_type from atv pdata
>   drm/omap: Remove reference to pdata->default_device
>   omapfb: Remove reference to pdata->default_device
>   platform_data: omapdss: Remove unused members from omap_dss_board_i=
nfo
>   omapdss: hdmi audio: Make header file independent of video/omapdss.=
h
>   drm/omap: Do not include video/omapdss.h directly in drivers
>   omapfb: Create new header file for omapfb DSS implementation
>   [media] omap_vout: Switch to use the video/omapfb_dss.h header file
>   drm/omap: Remove the video/omapdss.h and move it's content to local
>     header file
>=20
>  arch/arm/mach-omap2/board-ldp.c                    |   3 +-
>  arch/arm/mach-omap2/board-rx51-video.c             |   4 +-
>  arch/arm/mach-omap2/display.c                      |   2 +-
>  arch/arm/mach-omap2/display.h                      |   5 +
>  arch/arm/mach-omap2/dss-common.c                   |   2 +-
>  .../gpu/drm/omapdrm/displays/connector-analog-tv.c |  11 +-
>  drivers/gpu/drm/omapdrm/displays/connector-dvi.c   |   4 +-
>  drivers/gpu/drm/omapdrm/displays/connector-hdmi.c  |   4 +-
>  drivers/gpu/drm/omapdrm/displays/encoder-opa362.c  |   2 +-
>  drivers/gpu/drm/omapdrm/displays/encoder-tfp410.c  |   3 +-
>  .../gpu/drm/omapdrm/displays/encoder-tpd12s015.c   |   3 +-
>  drivers/gpu/drm/omapdrm/displays/panel-dpi.c       |   3 +-
>  drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c    |   4 +-
>  .../omapdrm/displays/panel-lgphilips-lb035q02.c    |   3 +-
>  .../drm/omapdrm/displays/panel-nec-nl8048hl11.c    |   2 +-
>  .../drm/omapdrm/displays/panel-sharp-ls037v7dw01.c |   3 +-
>  .../drm/omapdrm/displays/panel-sony-acx565akm.c    |   3 +-
>  .../drm/omapdrm/displays/panel-tpo-td028ttec1.c    |   3 +-
>  .../drm/omapdrm/displays/panel-tpo-td043mtea1.c    |   2 +-
>  drivers/gpu/drm/omapdrm/dss/core.c                 |   5 +-
>  drivers/gpu/drm/omapdrm/dss/dispc.c                |   3 +-
>  drivers/gpu/drm/omapdrm/dss/dispc_coefs.c          |   2 +-
>  drivers/gpu/drm/omapdrm/dss/display.c              |   2 +-
>  drivers/gpu/drm/omapdrm/dss/dpi.c                  |   3 +-
>  drivers/gpu/drm/omapdrm/dss/dsi.c                  |   2 +-
>  drivers/gpu/drm/omapdrm/dss/dss-of.c               |   3 +-
>  drivers/gpu/drm/omapdrm/dss/dss.c                  |   3 +-
>  drivers/gpu/drm/omapdrm/dss/dss_features.c         |   3 +-
>  drivers/gpu/drm/omapdrm/dss/hdmi.h                 |   3 +-
>  drivers/gpu/drm/omapdrm/dss/hdmi4.c                |   2 +-
>  drivers/gpu/drm/omapdrm/dss/hdmi5.c                |   2 +-
>  drivers/gpu/drm/omapdrm/dss/hdmi_common.c          |   2 +-
>  drivers/gpu/drm/omapdrm/dss/hdmi_phy.c             |   2 +-
>  drivers/gpu/drm/omapdrm/dss/hdmi_pll.c             |   3 +-
>  drivers/gpu/drm/omapdrm/dss/hdmi_wp.c              |   2 +-
>  drivers/gpu/drm/omapdrm/dss/omapdss.h              | 866 +++++++++++=
+++++++++-
>  drivers/gpu/drm/omapdrm/dss/output.c               |   3 +-
>  drivers/gpu/drm/omapdrm/dss/pll.c                  |   3 +-
>  drivers/gpu/drm/omapdrm/dss/rfbi.c                 |   2 +-
>  drivers/gpu/drm/omapdrm/dss/sdi.c                  |   2 +-
>  drivers/gpu/drm/omapdrm/dss/venc.c                 |   3 +-
>  drivers/gpu/drm/omapdrm/dss/video-pll.c            |   3 +-
>  drivers/gpu/drm/omapdrm/omap_drv.h                 |   1 -
>  drivers/media/platform/omap/omap_vout.c            |   2 +-
>  drivers/media/platform/omap/omap_voutdef.h         |   2 +-
>  drivers/media/platform/omap/omap_voutlib.c         |   2 +-
>  .../omap2/omapfb/displays/connector-analog-tv.c    |  10 +-
>  .../fbdev/omap2/omapfb/displays/connector-dvi.c    |  60 +-
>  .../fbdev/omap2/omapfb/displays/connector-hdmi.c   |  44 +-
>  .../fbdev/omap2/omapfb/displays/encoder-opa362.c   |   2 +-
>  .../fbdev/omap2/omapfb/displays/encoder-tfp410.c   |  46 +-
>  .../omap2/omapfb/displays/encoder-tpd12s015.c      |   3 +-
>  .../video/fbdev/omap2/omapfb/displays/panel-dpi.c  |   2 +-
>  .../fbdev/omap2/omapfb/displays/panel-dsi-cm.c     |  54 +-
>  .../omapfb/displays/panel-lgphilips-lb035q02.c     |  58 +-
>  .../omap2/omapfb/displays/panel-nec-nl8048hl11.c   |  47 +-
>  .../omapfb/displays/panel-sharp-ls037v7dw01.c      |  83 +-
>  .../omap2/omapfb/displays/panel-sony-acx565akm.c   |   2 +-
>  .../omap2/omapfb/displays/panel-tpo-td028ttec1.c   |  45 +-
>  .../omap2/omapfb/displays/panel-tpo-td043mtea1.c   |  46 +-
>  drivers/video/fbdev/omap2/omapfb/dss/apply.c       |   2 +-
>  drivers/video/fbdev/omap2/omapfb/dss/core.c        |   4 +-
>  .../video/fbdev/omap2/omapfb/dss/dispc-compat.c    |   2 +-
>  drivers/video/fbdev/omap2/omapfb/dss/dispc.c       |   2 +-
>  drivers/video/fbdev/omap2/omapfb/dss/dispc_coefs.c |   2 +-
>  .../video/fbdev/omap2/omapfb/dss/display-sysfs.c   |   2 +-
>  drivers/video/fbdev/omap2/omapfb/dss/display.c     |   2 +-
>  drivers/video/fbdev/omap2/omapfb/dss/dpi.c         |   2 +-
>  drivers/video/fbdev/omap2/omapfb/dss/dsi.c         |   2 +-
>  drivers/video/fbdev/omap2/omapfb/dss/dss-of.c      |   2 +-
>  drivers/video/fbdev/omap2/omapfb/dss/dss.c         |   2 +-
>  .../video/fbdev/omap2/omapfb/dss/dss_features.c    |   2 +-
>  drivers/video/fbdev/omap2/omapfb/dss/hdmi.h        |   3 +-
>  drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c       |   2 +-
>  drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c       |   2 +-
>  drivers/video/fbdev/omap2/omapfb/dss/hdmi_common.c |   2 +-
>  drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c    |   2 +-
>  drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c    |   2 +-
>  drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c     |   2 +-
>  .../video/fbdev/omap2/omapfb/dss/manager-sysfs.c   |   2 +-
>  drivers/video/fbdev/omap2/omapfb/dss/manager.c     |   2 +-
>  drivers/video/fbdev/omap2/omapfb/dss/output.c      |   2 +-
>  .../video/fbdev/omap2/omapfb/dss/overlay-sysfs.c   |   2 +-
>  drivers/video/fbdev/omap2/omapfb/dss/overlay.c     |   2 +-
>  drivers/video/fbdev/omap2/omapfb/dss/pll.c         |   2 +-
>  drivers/video/fbdev/omap2/omapfb/dss/rfbi.c        |   2 +-
>  drivers/video/fbdev/omap2/omapfb/dss/sdi.c         |   2 +-
>  drivers/video/fbdev/omap2/omapfb/dss/venc.c        |   2 +-
>  drivers/video/fbdev/omap2/omapfb/dss/video-pll.c   |   2 +-
>  drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c    |   2 +-
>  drivers/video/fbdev/omap2/omapfb/omapfb-main.c     |   2 +-
>  drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c    |   2 +-
>  drivers/video/fbdev/omap2/omapfb/omapfb.h          |   2 +-
>  include/linux/platform_data/omapdss.h              |  37 +
>  include/sound/omap-hdmi-audio.h                    |   9 +-
>  include/video/omap-panel-data.h                    | 157 ----
>  include/video/{omapdss.h =3D> omapfb_dss.h}          |  60 +-
>  sound/soc/omap/omap-hdmi-audio.c                   |   1 -
>  98 files changed, 1081 insertions(+), 751 deletions(-)
>  create mode 100644 include/linux/platform_data/omapdss.h
>  rename include/video/{omapdss.h =3D> omapfb_dss.h} (93%)
>=20


--=20
P=E9ter
