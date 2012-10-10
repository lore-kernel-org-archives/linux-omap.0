From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [GIT PULL] OMAP DSS for v3.7
Date: Wed, 10 Oct 2012 12:48:17 +0000
Message-ID: <50756E91.4040902@gmx.de>
References: <1349120714.13060.8.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:51598 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752550Ab2JJMsb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Oct 2012 08:48:31 -0400
In-Reply-To: <1349120714.13060.8.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev <linux-fbdev@vger.kernel.org>

Hi Tomi,

On 10/01/2012 07:45 PM, Tomi Valkeinen wrote:
> Hi Florian,
>=20
> Here are omapdss changes for 3.7 merge window.

Merged.

> There's something funny with the diff stat, though. I can see a few
> changes there that I have not made, for example to
> drivers/video/console/fbcon.c. I believe they come from my "Merge bra=
nch
> 'fbdev-for-linus' of git://github.com/schandinat/linux-2.6", although=
 I
> don't know why they show up in the diff stat.

Yeah, I know this sort of stuff, had some similar problem some time ago=
,
it happens when you base on multiple branches. Basically you created
your pull request as if you asked Linus to pull it as you started with =
a
commit that is in Linus' tree (but not in mine). If you would take the
HEAD of my tree you wouldn't see the fb stuff but others as you merged
from Linus in the meantime.

> Merge with v3.6 goes without conflicts, but there will be some confli=
cts
> with OMAP platform stuff, at least according to linux-next reports.
> Those conflicts are trivial, though.

Good.


Thanks,

=46lorian Tobias Schandinat

>=20
>  Tomi
>=20
> The following changes since commit 4cbe5a555fa58a79b6ecbb6c531b8bab06=
50778d:
>=20
>   Linux 3.6-rc4 (2012-09-01 10:39:58 -0700)
>=20
> are available in the git repository at:
>=20
>   git://gitorious.org/linux-omap-dss2/linux.git tags/omapdss-for-3.7
>=20
> for you to fetch changes up to 13b1ba7de8d0ecc42e4f9c002d5b0c1a48f05e=
58:
>=20
>   OMAPDSS: add missing include for string.h (2012-09-28 10:03:03 +030=
0)
>=20
> ----------------------------------------------------------------
> Omapdss driver changes for the 3.7 merge window.
>=20
> Notable changes:
>=20
> * Basic writeback support for DISPC level. Writeback is not yet usabl=
e, though,
>   as we need higher level code to actually expose the writeback featu=
re to
>   userspace.
> * Rewriting the omapdss output drivers. We're trying to remove the ha=
rd links
>   between the omapdss and the panels, and this rewrite work moves us =
closer to
>   that goal.
> * Cleanup and restructuring patches that have been made while working=
 on device
>   tree support for omapdss. Device tree support is still some way ahe=
ad, but
>   these patches are good cleanups in themselves.
> * Basic OMAP5 DSS support for DPI and DSI outputs.
> * Workaround for the problem that GFX overlay's fifo is too small for=
 high
>   resolution scenarios, causing underflows.
> * Cleanups that remove dependencies to omap platform code.
>=20
> ----------------------------------------------------------------
> Archit Taneja (70):
>       OMAPDSS: APPLY: Constify timings argument in dss_mgr_set_timing=
s
>       OMAPDSS: DPI: Add locking for DPI interface
>       OMAPDSS: Displays: Add locking in generic DPI panel driver
>       OMAPDSS: DPI: Maintain our own timings field in driver data
>       OMAPDSS: DPI displays: Take care of panel timings in the driver=
 itself
>       OMAPDSS: DSI: Maintain own copy of timings in driver data
>       OMAPDSS: DSI: Add function to set panel size for command mode p=
anels
>       OMAPDSS: DSI: Update manager timings on a manual update
>       OMAPDSS: HDMI: Use our own omap_video_timings field when settin=
g interface timings
>       OMAPDSS: HDMI: Add locking for hdmi interface set timing functi=
ons
>       OMAPDSS: SDI: Create a function to set timings
>       OMAPDSS: SDI: Maintain our own timings field in driver data
>       OMAPDSS: VENC: Split VENC into interface and panel driver
>       OMAPDSS: VENC: Maintain our own timings field in driver data
>       OMAPDSS: RFBI: Remove partial update support
>       OMAPDSS: RFBI: Add function to set panel size
>       OMAPDSS: DSI: Maintain copy of pixel format in driver data
>       OMAPDSS: RFBI: Maintain copy of pixel size in driver data
>       OMAPDSS: RFBI: Maintain copy of number of data lines in driver =
data
>       OMAPDSS: DPI: Maintain copy of number of data lines in driver d=
ata
>       OMAPDSS: SDI: Maintain copy of data pairs in driver data
>       OMAPDSS: DSI: Maintain copy of operation mode in driver data
>       OMAPDSS: DSI: Rename dsi_videomode_data to dsi_videomode_timing=
s
>       OMAPDSS: DSI: Maintain copy of video mode timings in driver dat=
a
>       OMAPDSS: RFBI: Maitain copy of rfbi timings in driver data
>       OMAPDSS: VENC: Maintain copy of venc type in driver data
>       OMAPDSS: VENC: Maintian copy of video output polarity info in p=
rivate data
>       OMAPFB: Clear framebuffers before they are registered
>       OMAPDSS: Add basic omap5 features to dss and dispc
>       OMAPDSS: DSI: Pass dsi platform device wherever possible
>       OMAPDSS: APPLY: Remove omap_dss_device references in wait_for_g=
o functions
>       OMAPDSS: outputs: Create a new entity called outputs
>       OMAPDSS: outputs: Create and register output instances
>       OMAPDSS: output: Add set/unset device ops for omap_dss_output
>       OMAPDSS: APPLY: Add manager set/unset output ops for omap_overl=
ay_manager
>       OMAPDSS: Remove manager->device references
>       OMAP_VOUT: Remove manager->device references
>       OMAPFB: remove manager->device references
>       OMAPDRM: Remove manager->device references
>       OMAPDSS: Create links between managers, outputs and devices
>       OMAPDSS: DPI: Replace dssdev->manager with dssdev->output->mana=
ger references
>       OMAPDSS: DSI: Remove dsi_pdev_map global struct
>       OMAPDSS: DSI: Replace dssdev->manager with dssdev->output->mana=
ger references
>       OMAPDSS: SDI: Replace dssdev->manager with dssdev->output->mana=
ger references
>       OMAPDSS: RFBI: Replace dssdev->manager with dssdev->output->man=
ager references
>       OMAPDSS: VENC: Replace dssdev->manager with dssdev->output->man=
ager references
>       OMAPDSS: HDMI: Replace dssdev->manager with dssdev->output->man=
ager references
>       OMAPFB: Change dssdev->manager references
>       OMAPDSS: MANAGER: Update display sysfs store
>       OMAPDSS: OVERLAY/MANAGER: Get device via output
>       OMAPDSS: APPLY: Remove omap_dss_device references from dss_ovl_=
enable/disable
>       OMAPDSS: Remove old way of setting manager and device links
>       OMAPDSS: DISPC: Constify omap_overlay_info in dispc_ovl_setup()
>       OMAPDSS: DISPC: Simplify function names for setting pipeline in=
put and output sizes
>       OMAPDSS: DISPC: Pass overlay caps as a parameter to dispc plane=
 functions
>       OMAPDSS: OVERLAY: Add position and replication as overlay caps
>       OMAPDSS: DISPC: Make dispc_ovl_setup call dispc_ovl_setup_commo=
n
>       OMAPDSS: DISPC: Don't pass channel out when configuring overlay=
s
>       OMAPDSS: DIPSC: Relax scaling limitations when in memory to mem=
ory mode
>       OMAPDSS: DISPC: Allow both upscaling and downscaling of chroma
>       OMAPDSS: DISPC: Add writeback register offsets and dss features=
 structs
>       OMAPDSS: DISPC: Configure input and output sizes for writeback
>       OMAPDSS: DISPC: Downscale chroma if plane is writeback
>       OMAPDSS: DISPC: Don't set chroma resampling bit for writeback
>       OMAPDSS: DISPC: Add function to set channel in for writeback
>       OMAPDSS: DISPC: Configure overlay-like parameters in dispc_wb_s=
etup
>       OMAPDSS: DISPC: Configure writeback specific parameters in disp=
c_wb_setup()
>       OMAPDSS: DISPC: Configure writeback FIFOs
>       OMAPDSS: DISPC: Add manager like functions for writeback
>       OMAPDSS: DISPC: Configure color conversion coefficients for wri=
teback
>=20
> Chandrabhanu Mahapatra (8):
>       OMAPDSS: DISPC: Cleanup cpu_is_xxxx checks
>       OMAPDSS: DSS: Remove redundant functions
>       OMAPDSS: DSS: Cleanup cpu_is_xxxx checks
>       ARM: OMAP: Disable venc for OMAP4
>       OMAPDSS: VENC: Remove cpu_is_xxxx checks
>       OMAPDSS: DPI: Remove cpu_is_xxxx checks
>       OMAPDSS: Correct DISPC_IRQ bit definitions for LCD3
>       OMAPDSS: DISPC: Add predecimation limit for TILER based rotatio=
ns
>=20
> Grazvydas Ignotas (1):
>       OMAPFB: fix framebuffer console colors
>=20
> Jassi Brar (1):
>       OMAPDSS: DISPC: Use msleep instead of blocking mdelay
>=20
> Rapha=C3=ABl Ass=C3=A9nat (1):
>       OMAPDSS: Do not require a VDDS_DSI regulator on AM35xx
>=20
> Ricardo Neri (2):
>       OMAPDSS: HDMI: Disable PLL properly in case of error at power_o=
n
>       OMAPDSS: DISPC: Improvements to DIGIT sync signal selection
>=20
> Tomi Valkeinen (53):
>       Merge output work from Archit
>       OMAPDSS: HDMI: fix initial HDMI enable
>       Merge tag 'v3.6-rc4'
>       OMAPDSS: HDMI: Move GPIO handling to HDMI driver
>       OMAPDSS: HDMI: Add delay to wait for 5V power
>       OMAP4: TWL: add vdda_hdmi_dac regulator supply
>       OMAPDSS: HDMI: use vdda_hdmi_dac
>       OMAPDSS: Add DSI fclk maximum to dss_features
>       OMAPDSS: DSI: calculate dsi clock
>       OMAP: 4430SDP: remove DSI clock config from board file
>       OMAPDSS: fix use of dssdev->caps
>       OMAPDSS: Taal: use devm_* functions
>       OMAPFB1: remove unnecessary includes
>       OMAPFB1: remove a non-used table
>       OMAPDSS: remove unnecessary includes
>       OMAPFB: clear framebuffers with CPU
>       OMAPDSS: VRAM: Remove clearing with sDMA
>       OMAPDSS: Taal: Reogranize for device tree
>       OMAPDSS: TFP410: use devm_gpio_request_one
>       OMAPDSS: split overlay sysfs code
>       OMAPDSS: split manager sysfs code
>       OMAPDSS: clean up dss_mgr_set_lcd_config
>       OMAPDSS: clean up dss_mgr_set_timings
>       Revert "OMAPDSS: APPLY: add fifo-merge support"
>       Revert "OMAPDSS: APPLY: add fifo merge support funcs"
>       OMAPDSS: Improve fifo management code
>       OMAPDSS: Use WB fifo for GFX overlay
>       OMAPDSS: fix set_timings
>       OMAPDSS: fix dss_ovl_unset_manager
>       Merge miscellaneous omapdss changes
>       Merge branch 'fbdev-for-linus' of git://github.com/schandinat/l=
inux-2.6
>       OMAPDSS: omap_dss_register_device() doesn't take display index
>       OMAPDSS: Add dss_get_default_display_name()
>       OMAPDSS: register only one display device per output
>       OMAPDSS: explicitely initialize dssdev->channel for new display=
s
>       OMAPDSS: handle errors in dss_init_device
>       OMAPDSS: cleanup dss_recheck_connections
>       OMAPDSS: cleanup dss_recheck_connections further
>       OMAPDSS: alloc dssdevs dynamically
>       OMAPDSS: DSI: improve DSI clock calcs for DISPC
>       OMAPDSS: move dss feats to the end of dss.c
>       OMAPDSS: Add support for DPI source selection
>       OMAPDSS: DSI: Add FEAT_DSI_PLL_SELFREQDCO
>       OMAPDSS: DSI: Add FEAT_DSI_PLL_REFSEL
>       OMAPDSS: DSI: Add new linebuffer size for OMAP5
>       OMAPDSS: DSI: Add code to disable PHY DCC
>       OMAPDSS: DSI: make OMAP2_DSS_DSI depend on ARCH_OMAP5
>       Merge omapdss single-dssdev series
>       Merge OMAP5 DSS changes to omapdss
>       OMAPDSS: DSI: fix tlpx_half reg field length
>       Merge branch 'archit/outputs-for-3.7'
>       Merge branch 'archit/wb-dispc-for-3.7'
>       OMAPDSS: add missing include for string.h
>=20
>  arch/arm/mach-omap2/board-4430sdp.c                |   73 +-
>  arch/arm/mach-omap2/board-omap4panda.c             |   27 +-
>  arch/arm/mach-omap2/display.c                      |    1 -
>  arch/arm/mach-omap2/twl-common.c                   |    6 +
>  drivers/media/video/omap/omap_vout.c               |   75 +-
>  drivers/staging/omapdrm/omap_drv.c                 |    5 +-
>  drivers/video/auo_k190x.c                          |    2 -
>  drivers/video/console/bitblit.c                    |    2 +-
>  drivers/video/console/fbcon.c                      |    2 +-
>  drivers/video/mb862xx/mb862xxfbdrv.c               |    2 +
>  drivers/video/omap/hwa742.c                        |    1 -
>  drivers/video/omap/lcd_ams_delta.c                 |    1 -
>  drivers/video/omap/lcd_palmte.c                    |    1 -
>  drivers/video/omap/omapfb_main.c                   |    9 -
>  drivers/video/omap2/displays/panel-acx565akm.c     |   14 +-
>  drivers/video/omap2/displays/panel-generic-dpi.c   |   76 +-
>  .../omap2/displays/panel-lgphilips-lb035q02.c      |    3 +
>  drivers/video/omap2/displays/panel-n8x0.c          |   31 +-
>  .../omap2/displays/panel-nec-nl8048hl11-01b.c      |    3 +
>  drivers/video/omap2/displays/panel-picodlp.c       |    4 +
>  .../video/omap2/displays/panel-sharp-ls037v7dw01.c |    3 +
>  drivers/video/omap2/displays/panel-taal.c          |  239 ++---
>  drivers/video/omap2/displays/panel-tfp410.c        |   20 +-
>  .../video/omap2/displays/panel-tpo-td043mtea1.c    |    7 +-
>  drivers/video/omap2/dss/Kconfig                    |    2 +-
>  drivers/video/omap2/dss/Makefile                   |    4 +-
>  drivers/video/omap2/dss/apply.c                    |  330 ++-----
>  drivers/video/omap2/dss/core.c                     |   91 +-
>  drivers/video/omap2/dss/dispc.c                    | 1019 ++++++++++=
++++------
>  drivers/video/omap2/dss/dispc.h                    |   37 +
>  drivers/video/omap2/dss/display.c                  |  108 ++-
>  drivers/video/omap2/dss/dpi.c                      |  181 +++-
>  drivers/video/omap2/dss/dsi.c                      |  675 ++++++++++=
---
>  drivers/video/omap2/dss/dss.c                      |  257 +++--
>  drivers/video/omap2/dss/dss.h                      |   79 +-
>  drivers/video/omap2/dss/dss_features.c             |  278 +++++-
>  drivers/video/omap2/dss/dss_features.h             |    7 +
>  drivers/video/omap2/dss/hdmi.c                     |  247 +++--
>  drivers/video/omap2/dss/hdmi_panel.c               |   31 +-
>  drivers/video/omap2/dss/manager-sysfs.c            |  512 ++++++++++
>  drivers/video/omap2/dss/manager.c                  |  473 +--------
>  drivers/video/omap2/dss/output.c                   |  148 +++
>  drivers/video/omap2/dss/overlay-sysfs.c            |  456 +++++++++
>  drivers/video/omap2/dss/overlay.c                  |  492 +---------
>  drivers/video/omap2/dss/rfbi.c                     |  222 +++--
>  drivers/video/omap2/dss/sdi.c                      |  136 ++-
>  drivers/video/omap2/dss/venc.c                     |  337 +++----
>  drivers/video/omap2/dss/venc_panel.c               |  251 +++++
>  drivers/video/omap2/omapfb/omapfb-ioctl.c          |    7 +-
>  drivers/video/omap2/omapfb/omapfb-main.c           |   34 +-
>  drivers/video/omap2/omapfb/omapfb.h                |    5 +-
>  drivers/video/omap2/vram.c                         |   56 --
>  include/video/omapdss.h                            |  112 ++-
>  53 files changed, 4592 insertions(+), 2602 deletions(-)
>  create mode 100644 drivers/video/omap2/dss/manager-sysfs.c
>  create mode 100644 drivers/video/omap2/dss/output.c
>  create mode 100644 drivers/video/omap2/dss/overlay-sysfs.c
>  create mode 100644 drivers/video/omap2/dss/venc_panel.c
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
