From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [GIT PULL] OMAP DSS for v3.2
Date: Sun, 16 Oct 2011 21:55:51 +0000
Message-ID: <4E9B52E7.7020601@gmx.de>
References: <1317972007.2374.12.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:44673 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751707Ab1JPVzz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Oct 2011 17:55:55 -0400
In-Reply-To: <1317972007.2374.12.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap mailing list <linux-omap@vger.kernel.org>, lfbdev-ml <linux-fbdev@vger.kernel.org>

Hi Tomi,

On 10/07/2011 07:20 AM, Tomi Valkeinen wrote:
> Hi Florian,
> 
> Please pull OMAP DSS patches for v3.2 merge window.

Pulled.

> Note that there are some conflicts with other trees. The board file
> conflicts are trivial, changes in code which just happen to be next to
> each other. The LCD driver conflicts are even simpler, there were
> changes to them from some other tree, but I have removed the files.
> 
> The conflicts have been solved properly by Stephen in linux-next:
> 
> https://github.com/sfrothwell/linux-next/commit/3e31b3042760e3906d0a275d7adedfaf55ee5b0a
> 
> I also attached the output from git show, as github seems to show the
> full diff for the merge commit.
> 
> Are you ok with the conflicts?

No problem.
Well, as I understand, Linus prefers to see (and solve) these conflicts himself,
so I don't have any work with them at all. I'd only have to resolve them if
Linus gave up and that would probably point to a more fundamental issue in the
workflow, like changes going mainline via the wrong tree or such things.


Thanks,

Florian Tobias Schandinat

> The following changes since commit b6fd41e29dea9c6753b1843a77e50433e6123bcb:
> 
>   Linux 3.1-rc6 (2011-09-12 14:02:02 -0700)
> 
> are available in the git repository at:
>   git://gitorious.org/linux-omap-dss2/linux.git for-florian
> 
> Andy Doan (1):
>       OMAPFB: make debug message more useful
> 
> Archit Taneja (26):
>       OMAP: DSS2: DISPC: Prepare dispc_dump_regs() for shortening
>       OMAP: DSS2: DISPC: Shorten dispc_dump_regs()
>       OMAP: DSS2: DISPC: dispc_save_context() and dispc_restore_context() cleanup
>       OMAP: DSS2: DISPC: Shorten _dispc_set_color_conv_coef()
>       OMAP: DSS2: Use a macro to declare size of the fifo_size array in dispc.c
>       OMAP: DSS2: Use MIPI DSI enums from include/video/mipi_display.h
>       OMAP: DSS2: DSI: Represent L4 and VP as sources of VC instead of modes
>       OMAP: DSS2: Create enum for DSI operation modes
>       OMAP: DSS2: DSI: Introduce generic write functions
>       OMAP: DSS2: DSI: Remove functions dsi_vc_dcs_read_1() and dsi_vc_dcs_read_2()
>       OMAP: DSS2: DSI: Split dsi_vc_dcs_read() into 2 functions
>       OMAP: DSS2: DSI: Introduce generic read functions
>       OMAP: DSS2: Clean up stallmode and io pad mode selection
>       OMAP: DSS2: Create an enum for DSI pixel formats
>       OMAP: DSS2: DSI: Send zero length packet in dsi_vc_send_null()
>       OMAP: DSS2: DSI Video mode support
>       OMAPDSS: DISPC: Reduce the number of arguments in dispc_ovl_setup()
>       OMAPDSS: DISPC: Pass overlay params as arguments to dispc_ovl_setup()
>       OMAPDSS: DISPC: Create helper function dispc_mgr_is_lcd()
>       OMAPDSS: DISPC: Get correct pixel clock for TV manager
>       OMAPDSS: DISPC: Remove hardcoded use of PPL in five tap clock calculation
>       OMAPDSS: DISPC: Clean up scaling related clock and five tap calculations
>       OMAPDSS: FEATURES: Create a range param to get max downscaling
>       OMAPDSS/OMAP_VOUT: Fix incorrect OMAP3-alpha compatibility setting
>       OMAPDSS: DISPC: VIDEO3 pipeline support
>       OMAPDSS: DISPC: zorder support for DSS overlays
> 
> Arnd Bergmann (1):
>       video/omap: fix build dependencies
> 
> Daniel Morsing (1):
>       OMAP: DSS2: Don't allow moving managers away from enabled displays
> 
> Dima Zavin (1):
>       OMAP: DSS: dispc: enable/disable clocks in error handler
> 
> Mayuresh Janorkar (1):
>       OMAP: DSS2: Add picodlp panel driver
> 
> Mythri P K (14):
>       OMAP4: DSS2: HDMI: HDMI clean up to pass base_address
>       OMAP4: DSS2: HDMI: Move pll and video configuration
>       OMAP4: DSS2: HDMI: Use specific HDMI timings structure
>       OMAP4: DSS2: HDMI: Move HDMI IP independent generic header
>       OMAP4: DSS2: HDMI: Move the EDID definition from HDMI
>       OMAP4: DSS2: HDMI: Split the current HDMI driver to move
>       OMAP4: DSS2: HDMI: Move the HDMI IP dependent audio
>       OMAP4: DSS2: HDMI: Rename the functions in HDMI IP library
>       OMAP4: DSS2: HDMI: Function pointer approach to call
>       OMAP4: DSS2: Rename hdmi_omap4_panel.c to hdmi_panel.c
>       OMAPDSS: HDMI: Move the comments in avi infoframe
>       OMAPDSS: HDMI: Replace hdmi_reg struct with u16
>       OMAPDSS: HDMI: Add missing register definitions
>       OMAPDSS: HDMI: Add support to dump registers through debugfs
> 
> Thomas Weber (2):
>       OMAP: DSS2: Support for Innolux AT070TN83
>       OMAP: Devkit8000: Change lcd driver to AT070TN83
> 
> Tomi Valkeinen (63):
>       OMAP: DSS2: PicoDLP: fix error handling in power_on
>       OMAP: DSS2: check for manager when enabling display
>       Revert "HACK: OMAP: DSS2: clk hack for OMAP2/3"
>       Revert "OMAP: DSS2: HDMI: fix hdmi clock name"
>       OMAP: DSS2: remove unneeded fck enable/disables
>       OMAP: DSS2: Change DSI device naming
>       OMAP4: TWL: Add common omapdss supplies
>       OMAP: DSS2: DSI: Improve dsi_mux_pads parameters
>       OMAP: DSS2: Implement dsi_mux_pads for OMAP4
>       OMAP: OMAPFB: make omapfb start even when a display is missing a driver
>       OMAP: DSS2: fix clock sources on error and uninit
>       OMAP: DSS2: Handle manager change in apply
>       OMAP: DSS2: Remove "EXPERIMENTAL" from Kconfig
>       OMAP: DSS2: Remove support for non-DISPC overlays
>       OMAP: DSS2: DISPC: use lookup tables for bit shifts
>       OMAP: DSS2: Add overlay caps to DSS features
>       OMAP: DSS2: Add GLOBAL_ALPHA & PRE_MULT_ALPHA to ovl caps
>       OMAP: DSS2: string parsing cleanups
>       OMAP: OMAPFB: string parsing cleanups
>       OMAP: DSS2: DISPC: remove non-existing func prototypes
>       OMAP: DSS2: DISPC: rename overlay related funcs
>       OMAP: DSS2: DISPC: rename manager related funcs
>       OMAP: DSS2: reorganize functions in dss.h
>       OMAP: DSS2: DISPC: Fix minimum PCD value
>       OMAP: DSS2: HDMI: use default dividers
>       OMAP: DSS2: HDMI: change regn definition
>       OMAP: DSS2: DSI: Add comment about regn
>       OMAP: DSS2: DISPC: Add missing IRQ  definitions
>       OMAP: DSS2: add dss_get_hdmi_venc_clk_source()
>       OMAP: DSS2: DISPC: improve dispc_mgr_enable_digit_out()
>       OMAP: DSS2: HDMI: improve hdmi output enable
>       OMAP: DSS2: add read_edid() to omap_dss_driver struct
>       OMAP: DSS2: add detect() to omap_dss_driver struct
>       OMAP: DSS2: HDMI: make set_timing saner
>       OMAP: DSS2: HDMI: implement read_edid()
>       OMAP: DSS2: HDMI: remove edid parsing
>       OMAP: DSS2: HDMI: split hdmi_core_ddc_edid
>       OMAP: DSS2: HDMI: clean up edid reading & fix checksum
>       OMAP: DSS2: HDMI: remove error prints in check_timings
>       OMAP: DSS2: HDMI: implement detect()
>       OMAP: DSS2: add panel-dvi driver
>       OMAP: use dvi panel driver instead of generic-dpi
>       OMAP: stalker: Remove LCD device from board file
>       OMAP: DSS2: panel-generic-dpi: remove "generic" panel
>       OMAP: Add DDC i2c_bus_num to board files
>       OMAPFB: find best mode from edid
>       OMAPDSS: Taal: remove external backlight support
>       OMAPFB: Remove unused lcd drivers
>       OMAPDSS: Port 2430sdp display driver to DSS2
>       OMAPDSS: Port the H4 display driver to DSS2
>       OMAPDSS: Port the Apollon display driver to DSS2
>       OMAPDSS: Add N800 panel driver
>       OMAPDSS: remove vaddr from overlay info
>       OMAP: 4430SDP: Remove unneeded lcd config
>       OMAP4: 4430SDP: Add panel support to board file
>       OMAP4: 4430SDP: Add picodlp support to board file
>       OMAP: RX51: Remove unused old omapfb stuff
>       OMAP: omap3touchbook: Remove unused lcd stuff
>       OMAP: 2420SDP: Port the display driver to new DSS2
>       OMAP: LDP: Port the display driver to new DSS2
>       OMAP: H4: Port the display driver to new DSS2
>       OMAP: Apollon: Port the display driver to new DSS2
>       OMAPDSS: picodlp: add missing #include <linux/module.h>
> 
>  arch/arm/mach-omap2/board-2430sdp.c                |   78 +-
>  arch/arm/mach-omap2/board-3430sdp.c                |    7 +-
>  arch/arm/mach-omap2/board-4430sdp.c                |  208 +++-
>  arch/arm/mach-omap2/board-am3517evm.c              |    6 +-
>  arch/arm/mach-omap2/board-apollon.c                |   35 +-
>  arch/arm/mach-omap2/board-cm-t35.c                 |    6 +-
>  arch/arm/mach-omap2/board-devkit8000.c             |   10 +-
>  arch/arm/mach-omap2/board-h4.c                     |   42 +-
>  arch/arm/mach-omap2/board-igep0020.c               |    8 +-
>  arch/arm/mach-omap2/board-ldp.c                    |  123 ++-
>  arch/arm/mach-omap2/board-omap3beagle.c            |    8 +-
>  arch/arm/mach-omap2/board-omap3evm.c               |    7 +-
>  arch/arm/mach-omap2/board-omap3pandora.c           |    2 +-
>  arch/arm/mach-omap2/board-omap3stalker.c           |   40 +-
>  arch/arm/mach-omap2/board-omap3touchbook.c         |   18 -
>  arch/arm/mach-omap2/board-omap4panda.c             |    8 +-
>  arch/arm/mach-omap2/board-overo.c                  |    7 +-
>  arch/arm/mach-omap2/board-rx51.c                   |   25 -
>  arch/arm/mach-omap2/display.c                      |   60 +-
>  arch/arm/mach-omap2/twl-common.c                   |   11 +-
>  drivers/media/video/omap/omap_vout.c               |   18 +-
>  drivers/video/omap/Kconfig                         |   29 -
>  drivers/video/omap/Makefile                        |    8 -
>  drivers/video/omap/lcd_2430sdp.c                   |  203 ---
>  drivers/video/omap/lcd_apollon.c                   |  136 --
>  drivers/video/omap/lcd_h4.c                        |  117 --
>  drivers/video/omap/lcd_ldp.c                       |  201 ---
>  drivers/video/omap/lcd_omap3beagle.c               |  130 --
>  drivers/video/omap/lcd_omap3evm.c                  |  193 ---
>  drivers/video/omap/lcd_overo.c                     |  180 ---
>  drivers/video/omap2/displays/Kconfig               |   28 +-
>  drivers/video/omap2/displays/Makefile              |    3 +
>  drivers/video/omap2/displays/panel-dvi.c           |  363 +++++
>  drivers/video/omap2/displays/panel-generic-dpi.c   |  113 +-
>  drivers/video/omap2/displays/panel-n8x0.c          |  747 +++++++++
>  drivers/video/omap2/displays/panel-picodlp.c       |  594 +++++++
>  drivers/video/omap2/displays/panel-picodlp.h       |  288 ++++
>  drivers/video/omap2/displays/panel-taal.c          |  123 +-
>  drivers/video/omap2/dss/Kconfig                    |    2 +-
>  drivers/video/omap2/dss/Makefile                   |    2 +-
>  drivers/video/omap2/dss/core.c                     |    4 +
>  drivers/video/omap2/dss/dispc.c                    | 1700 ++++++++------------
>  drivers/video/omap2/dss/dispc.h                    |   57 +
>  drivers/video/omap2/dss/display.c                  |   31 +-
>  drivers/video/omap2/dss/dpi.c                      |   28 +-
>  drivers/video/omap2/dss/dsi.c                      |  929 +++++++-----
>  drivers/video/omap2/dss/dss.c                      |   18 +-
>  drivers/video/omap2/dss/dss.h                      |  156 +-
>  drivers/video/omap2/dss/dss_features.c             |  130 ++-
>  drivers/video/omap2/dss/dss_features.h             |   17 +-
>  drivers/video/omap2/dss/hdmi.c                     | 1260 ++-------------
>  .../omap2/dss/{hdmi_omap4_panel.c => hdmi_panel.c} |   68 +-
>  drivers/video/omap2/dss/manager.c                  |  191 +--
>  drivers/video/omap2/dss/overlay.c                  |  122 +-
>  drivers/video/omap2/dss/rfbi.c                     |   45 +-
>  drivers/video/omap2/dss/sdi.c                      |   19 +-
>  drivers/video/omap2/dss/ti_hdmi.h                  |  138 ++
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c          | 1239 ++++++++++++++
>  .../video/omap2/dss/{hdmi.h => ti_hdmi_4xxx_ip.h}  |  400 +++---
>  drivers/video/omap2/dss/venc.c                     |   27 +-
>  drivers/video/omap2/omapfb/Kconfig                 |    2 +-
>  drivers/video/omap2/omapfb/omapfb-main.c           |  134 ++-
>  drivers/video/omap2/omapfb/omapfb-sysfs.c          |    6 +-
>  include/video/omap-panel-dvi.h                     |   37 +
>  include/video/omap-panel-n8x0.h                    |   15 +
>  include/video/omap-panel-nokia-dsi.h               |    8 +-
>  include/video/omap-panel-picodlp.h                 |   23 +
>  include/video/omapdss.h                            |  100 +-
>  68 files changed, 6495 insertions(+), 4596 deletions(-)
>  delete mode 100644 drivers/video/omap/lcd_2430sdp.c
>  delete mode 100644 drivers/video/omap/lcd_apollon.c
>  delete mode 100644 drivers/video/omap/lcd_h4.c
>  delete mode 100644 drivers/video/omap/lcd_ldp.c
>  delete mode 100644 drivers/video/omap/lcd_omap3beagle.c
>  delete mode 100644 drivers/video/omap/lcd_omap3evm.c
>  delete mode 100644 drivers/video/omap/lcd_overo.c
>  create mode 100644 drivers/video/omap2/displays/panel-dvi.c
>  create mode 100644 drivers/video/omap2/displays/panel-n8x0.c
>  create mode 100644 drivers/video/omap2/displays/panel-picodlp.c
>  create mode 100644 drivers/video/omap2/displays/panel-picodlp.h
>  rename drivers/video/omap2/dss/{hdmi_omap4_panel.c => hdmi_panel.c} (79%)
>  create mode 100644 drivers/video/omap2/dss/ti_hdmi.h
>  create mode 100644 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
>  rename drivers/video/omap2/dss/{hdmi.h => ti_hdmi_4xxx_ip.h} (54%)
>  create mode 100644 include/video/omap-panel-dvi.h
>  create mode 100644 include/video/omap-panel-n8x0.h
>  create mode 100644 include/video/omap-panel-picodlp.h
> 

